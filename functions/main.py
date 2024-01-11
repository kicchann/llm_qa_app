# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

from datetime import timedelta
import logging

from firebase_functions import tasks_fn, firestore_fn, scheduler_fn, options
from firebase_functions.params import StringParam, SecretParam
import firebase_admin

from src.config import *

ENVIRONMENT = StringParam("ENVIRONMENT", default="dev")
MIN_INSTANCES = ENVIRONMENT.equals("PRODUCTION").then(1, 0)
# bucket name: envとprodで分ける

cred = firebase_admin.credentials.Certificate(SERVICE_ACCOUNT_KEY_JSON)
firebase_admin.initialize_app(cred)
options.set_global_options(region=options.SupportedRegion.ASIA_NORTHEAST1)
storage_bucket = BUCKET_NAME_DEV if ENVIRONMENT.equals("dev") else BUCKET_NAME_PROD

# 標準 Logger の設定
logging.basicConfig(
    format="[%(asctime)s][%(levelname)s] %(message)s",
    level=logging.DEBUG
)
logger = logging.getLogger(__name__)

# DEACTIVATED: Cloud Logging によるログ出力
# import google.cloud.logging
# Cloud Logging ハンドラを logger に接続
# logging_client = google.cloud.logging.Client()
# logging_client.setup_logging()
# # setup_logging() するとログレベルが INFO になるので DEBUG に変更
# logger.setLevel(logging.DEBUG)


@firestore_fn.on_document_created(
    memory=options.MemoryOption.GB_1,
    document="users/{user_id}/refferedDocuments/{reffered_document_id}",
    min_instances=MIN_INSTANCES)
def trigger_create_document(event: firestore_fn.Event) -> None:
    import json
    from datetime import datetime

    from google.cloud import tasks_v2
    from firebase_functions import params

    from src.utils import get_function_url

    """
    documentの容量によっては，timeoutが発生する．
    実際にpdfの読み込みでtimeoutが発生した．(2023/10/20)
    将来，例えば動画を投稿するとなると，さらにその可能性が高くなる．
    そこでdocumentの作成自体はcloud tasksに任せて，timeoutを回避する．
    参照: https://firebase.google.com/docs/functions/task-functions?hl=ja&gen=2nd
    """
    user_id = event.params['user_id']
    reffered_document_id = event.params['reffered_document_id']

    tasks_client = tasks_v2.CloudTasksClient()
    task_queue = tasks_client.queue_path(
        params.PROJECT_ID.value,
        "asia-northeast1", #options.SupportedRegion.ASIA_NORTHEAST1,
        "documenttask"
    )
    target_uri = get_function_url("documenttask")
    if target_uri == '':
        # TODO: contentのstatusにエラーを追加
        logger.error('trigger_create_document: something wrong with get_function_url')
        return

    logger.debug(f'trigger_create_document: target_uri is {target_uri}')
    schedule_delay = timedelta(seconds=5)
    schedule_time = datetime.now() + schedule_delay

    body = {"data": {
        "user_id": user_id,
        "reffered_document_id": reffered_document_id,
    }}
    task = tasks_v2.Task(
        http_request={
            "http_method": tasks_v2.HttpMethod.POST,
            "url": target_uri,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps(body).encode(),
        },
        schedule_time=schedule_time,
    )
    tasks_client.create_task(parent=task_queue, task=task)
    logger.info(f'trigger_create_document: created task for {reffered_document_id}')
    return None

# documentの作成は，容量によっては時間を要するので，timeoutが発生する可能性がある．
# そのため，timeoutの時間が長いhttps関数を作成して，そこでdocumentの作成を行う．
@tasks_fn.on_task_dispatched(
    memory=options.MemoryOption.GB_4,
    retry_config=options.RetryConfig(max_attempts=0),
    rate_limits=options.RateLimits(max_concurrent_dispatches=10),
    secrets=["OPENAI_API_KEY"],
    timeout_sec=3600,
)
def documenttask(req: tasks_fn.CallableRequest) -> str:
    '''
    新しいコンテンツがfireStorageにアップロードされたときに，Document用dictを作成する関数．
    firestorageにアップロードされると同時に，firestoreにrefferedDocumentが作成されため，ここで発火する．
    簡単な流れは以下の通り．
    1. firestoreからrefferedDocumentを取得
    2. refferedDocumentのbodyが空でない場合は，bodyからDocument用dictを作成
    3. refferedDocumentのbodyが空の場合は，firestorageからファイルを取得して，Document用dictを作成
    4. Document用dictをfirestorageに保存
    5. firestorageからcontentを削除
    6. storageDocumentIdをfirestoreに保存
    '''
    import uuid
    import os
    from src.llm.doc_creator import DocCreator
    from src.utils import FirestoreUser, FireStorageUser

    logger.debug('documenttask: called')

    logger.debug('request data is below')
    logger.debug(req.data)

    data = req.data
    user_id = data["user_id"]
    reffered_document_id = data["reffered_document_id"]
    firestore_user = FirestoreUser(user_id=user_id)
    reffered_document = firestore_user.get_reffered_document(reffered_document_id)


    doc_creator = DocCreator(openai_api_key=str(os.environ.get('OPENAI_API_KEY')))
    storage_user = FireStorageUser(user_id=user_id, storage_bucket=storage_bucket)

    '''
    Documentを作成
    '''
    logger.debug('createDocumentTask: creating docs')
    if reffered_document.body != '':
        # bodyが空でない場合は，textからインデックスを作成
        logger.debug('createDocumentTask: creating docs from text')
        doc_creator.create_docs_from_text(
            reffered_document.title,
            reffered_document.body)
    else:
        logger.debug('createDocumentTask: creating docs from file')
        try:
            blob = storage_user.get_content_blob(reffered_document.storageContentId)
            doc_creator.create_docs_from_file(blob)
        except:
            # contentsフォルダにファイルがない場合は，エラーを出力して終了
            logger.error(f'''
                            createDocumentTask: no files are collected.
                            something wrong with firestorage or storageContentId.
                            ''')

    if doc_creator.docs == []:
        logger.error('''
                        createDocumentTask: docs is empty.
                        something wrong with llama_index.
                        ''')
        return 'ERROR'
    logger.debug('createDocumentTask: created docs')

    '''
    Document用dictをstorageに保存
    '''
    logger.debug('createDocumentTask: saving docs')
    doc_id = str(uuid.uuid4()) + '_' + VERSION
    storage_user.upload_document(
        doc_id=doc_id,
        file_name=doc_creator.file_name,
        documents=doc_creator.docs,
    )
    logger.debug('createDocumentTask: saved docs')
    
    '''
    storageからContentを削除
    '''
    if reffered_document.body != '':
        logger.debug('createDocumentTask: deleting content')
        storage_user.delete_contents(reffered_document.storageContentId)
        logger.debug('createDocumentTask: deleted content')

    '''
    firestoreのrefferedDocumentにアクセスして，
    storageDocumentIdを保存
    '''
    logger.debug('createDocumentTask: updating storageDocumentId')
    firestore_user = FirestoreUser(user_id=user_id)
    firestore_user.update_reffered_document(
        reffered_document_id=reffered_document_id,
        data={'storageDocumentId': doc_id},
    )
    logger.info(f'createDocumentTask: updated refferedDocument {reffered_document_id}')
    logger.debug('createDocumentTask: finished')
    return 'OK'


@firestore_fn.on_document_updated(
    memory=options.MemoryOption.MB_512,
    document="users/{user_id}/refferedDocuments/{reffered_document_id}",
)
def check_progress_of_documentation(event: firestore_fn.Event) -> None:
    '''
    Documentの作成状況を確認する関数．
    1. refferedDocumentのstorageDocumentIdが空白の場合は，終了
    2. storageDocumentIdを持つContentを検索・取得
    3. indexManagerを更新
    4. さらにrefferedDocumentIdsとcompletedDocumentIdsが一致したら，indexManagerを削除
    '''
    from datetime import datetime
    from firebase_admin import firestore
    from google.cloud.firestore_v1 import ArrayUnion

    from src.model.reffered_document import RefferedDocument
    from src.model.content import Content
    from src.utils import FirestoreUser
    
    db = firestore.client()

    logger.debug('check_progress_of_documentation: called')
    doc_ref = db.document(event.document)
    doc_snapshot = doc_ref.get()
    if not doc_snapshot.exists:
        logger.info('check_progress_of_documentation: called, but document does not exist')
        return
    reffered_document = RefferedDocument(**doc_snapshot.to_dict())
    user_id = event.params['user_id']
    reffered_document_id = event.params['reffered_document_id']
    # refferded_documentにアクセスして，storageDocumentIdを取得
    # 空白の場合は，storageDocumentIdが未定義なので，終了
    if reffered_document.storageDocumentId == '':
        logger.info('check_progress_of_documentation: called, but storageDocumentId is still blank')
        return

    '''
    refferedDocumentIdを持つContentを検索・取得
    '''
    logger.debug('check_progress_of_documentation: getting content')
    content_ref = db.collection(USERS).document(user_id).collection(CONTENTS).where(
        'refferedDocumentIds', 'array_contains', reffered_document_id).stream()
    contents = [Content(**c.to_dict()) for c in content_ref]
    logger.debug('check_progress_of_documentation: got content below')
    _ = [logger.debug(content.contentId) for content in contents]

    '''
    indexManagerを更新
    indexMagegerのidはcontentIdと同じ
    indexManagerのcompletedDocumentIdsにrefferedDocumentIdを追加
    '''
    # index_managerを取得して更新
    firestore_user = FirestoreUser(user_id=user_id)
    managers = []
    for content in contents:
        firestore_user.update_index_manager(
            index_manager_id=content.contentId,
            data={'completedDocumentIds': ArrayUnion([reffered_document_id])},
        )
        managers += [firestore_user.get_index_manager(content.contentId)]
    
    # contentのstatusを更新
    for i, content in enumerate(contents):
        num_of_completed = len(managers[i].completedDocumentIds)
        num_of_docs = len(managers[i].refferedDocumentIds)
        firestore_user.update_content(
            content_id=content.contentId,
            data={
                'status': f'データ処理中...{num_of_completed} / {num_of_docs}',
                'updatedAt': datetime.now(),
                },
        )

    '''
    さらにrefferedDocumentIdsとcompletedDocumentIdsが一致したら，indexManagerを削除
    削除することで，create_indexが発火する
    '''
    logger.debug('check_progress_of_documentation: deleting indexManager if completed')
    for manager in managers:
        if manager.refferedDocumentIds == manager.completedDocumentIds:
            firestore_user.delete_index_manager(manager.indexManagerId)

    logger.debug('check_progress_of_documentation: finished')
    return

@firestore_fn.on_document_deleted(
    memory=options.MemoryOption.GB_1,
    document="users/{user_id}/indexManagers/{manager_id}",
    secrets=["OPENAI_API_KEY"],
)
def create_index(event: firestore_fn.Event) -> None:
    # firestoreにcontentが作成されたときに，indexを実装する関数．
    import os
    import json
    import uuid
    from datetime import datetime

    from src.model.content import Content
    from src.llm.index_creator import IndexCreator
    from src.utils import FirestoreUser, FireStorageUser

    logger.debug('create_index: called')
    user_id = event.params['user_id']
    content_id = event.params['manager_id']

    firestore_user = FirestoreUser(user_id=user_id)
    storage_user = FireStorageUser(user_id=user_id, storage_bucket=storage_bucket)

    content:Content = firestore_user.get_content(content_id=content_id)
    index_creator = IndexCreator(str(os.environ.get('OPENAI_API_KEY')))

    '''
    documentを収集
    refferedDocumentsからstorageDocumentIdを取得して，storageからDocumentを取得
    複数のDocumentを結合
    ''' 
    logger.debug('create_index: creating index')
    documents = []
    for reffered_document_id in content.refferedDocumentIds:
        try:
            # firestoreからrefferedDocumentを取得
            reffered_document = firestore_user.get_reffered_document(reffered_document_id)
            blob = storage_user.get_document_blob(reffered_document.storageDocumentId)
            documents += json.loads(blob.download_as_string())
        except:
            # storageDocumentIdが間違っている場合は，エラーを出力
            logger.error('create_index: error occured while loading index.')

    '''
    documentが空じゃない場合はindexを生成
    インデックスをstorageに保存
    '''
    if documents == []:
        logger.error('''
                     create_index: documents is empty.
                     index will not be created.
                     ''')
        firestore_user.update_content(
            content_id=content_id,
            data={
                'status': 'データの処理に失敗しました',
                'updatedAt': datetime.now(),
                },
        )
        return
    '''
    インデックスを生成してstorageに保存
    '''
    logger.debug('create_index: creating index')
    index_creator.create_index_from_docs(documents)
    if index_creator.index_dict is None:
        logger.debug('create_index: index is None')
        firestore_user.update_content(
            content_id=content_id,
            data={
                'status': 'インデックスの生成に失敗しました',
                'updatedAt': datetime.now(),
                },
        )
        return
    logger.debug('create_index: saving index to storage')
    index_id = str(uuid.uuid4()) + '_' + VERSION
    storage_user.upload_index(
        index_id=index_id,
        file_name=index_creator.file_name,
        index_dict=index_creator.index_dict,
    )
    '''
    インデックスidをfirestoreに保存
    '''
    firestore_user.update_content(
        content_id=content_id,
        data={
            'storageIndexId': index_id,
            'status': '完了しました',
            'updatedAt': datetime.now(),
            }
    )
    logger.debug('create_index: finished')

    return

@firestore_fn.on_document_created(
    memory=options.MemoryOption.GB_1,
    document="users/{user_id}/contents/{content_id}/queries/{query_id}",
    secrets=["OPENAI_API_KEY"],
)
def create_answer(event: firestore_fn.Event) -> None:
    from datetime import datetime
    import json
    import uuid
    import os
    
    from src.utils import FirestoreUser, get_index_dict_from_storage
    from src.llm import AnswerCreator
    from src.model import Answer

    logger.debug('create_answer: called')
    # 新しいqueryが投稿されたときに，新しい回答を追加する関数．
    user_id = event.params['user_id']
    content_id = event.params['content_id']
    query_id = event.params['query_id']

    # documentにあるbodyを取得
    query_body = event.data.to_dict()['body']

    # llamas indexで回答を作成
    logger.debug('create_answer: getting answer from llm')
    index_dict = get_index_dict_from_storage(
        user_id=user_id,
        storage_bucket=storage_bucket,
        content_id=content_id
        )
    answer_creator = AnswerCreator(openai_api_key= str(os.environ.get('OPENAI_API_KEY')), index_dict=index_dict)
    res, sources = answer_creator.create_answer(query_body)
    logger.debug('create_answer: got answer from llm')

    # 回答を追加
    logger.debug('create_answer: adding answer to firestore')
    firestore_user = FirestoreUser(user_id=user_id)
    now = datetime.now()
    answer_id = str(uuid.uuid4()) + '_' + VERSION
    answer = Answer(
        answerId=answer_id,
        body=res,
        contentId=content_id,
        createdAt=now,
        queryId=query_id,
        sources=json.dumps(sources),
        uid=user_id,
    )
    firestore_user.set_answer(content_id=content_id, answer=answer)
    logger.info(f'create_answer: added answer {USERS}/{user_id}/{CONTENTS}/{content_id}/{ANSWERS}/{answer_id}')
    logger.debug('create_answer: finished')
    return

@firestore_fn.on_document_created(
    document="users/{user_id}/contents/{content_id}/answers/{answer_id}",
)
def update_query_with_answer(event: firestore_fn.Event) -> None:
    from src.utils import FirestoreUser
    logger.debug('create_answer: called')

    # 新しいanswerが投稿されたときに，queryにanswerIdを追加する関数．
    user_id = event.params['user_id']
    content_id = event.params['content_id']
    answer_id = event.params['answer_id']

    # documentにあるbodyを取得
    query_id = event.data.to_dict()['queryId']

    # 質問を更新
    firestore_user = FirestoreUser(user_id=user_id)
    firestore_user.update_query(
        content_id=content_id,
        query_id=query_id,
        data = dict(answer_id=answer_id),
        )
    logger.debug('update_query_with_answer: finished')
    return


@firestore_fn.on_document_created(
    document="users/{user_id}/contents/{content_id}/answers/{answer_id}",
)
def consume_user_point_with_answer(event: firestore_fn.Event) -> None:
    from src.utils import FirestoreUser
    logger.debug('consume_user_point_with_answer: called')
    # 新しいanswerが投稿されたときに，userのpointを消費する関数．
    # eventの中身は，
    # user_id: queryを投稿したユーザーのID
    user_id = event.params['user_id']

    firestore_user = FirestoreUser(user_id=user_id)
    user_point = firestore_user.user.userPoint
    firestore_user.update_user(
        data={'userPoint': user_point - 10},
    )
    logger.info(f'charge_user_point: consumed 10 points on {user_id}')
    logger.debug('consume_user_point_with_answer: finished')
    return

@firestore_fn.on_document_created(
    memory=options.MemoryOption.MB_512,
    document="customers/{user_id}/payments/{payment_id}",
)
def topup_user_point(event: firestore_fn.Event) -> None:
    from firebase_admin import firestore
    # statusがsucceededになったときに，userのpointをチャージ
    # どうもドキュメントが作成された時点ではfieldにitemsがないようで，
    # 内部で改めてドキュメントを取得している．
    user_id = event.params['user_id']
    payment_id = event.params['payment_id']

    db = firestore.client()
    logger.debug('topup_user_point: getting payment info')
    doc_ref = db.collection(CUSTOMERS).document(user_id).collection(PAYMENTS).document(payment_id)
    payment_info = doc_ref.get().to_dict()
    logger.debug('topup_user_point: got payment info')
    price_id = payment_info['items'][0]['price']['id']
    topup_point = PRICE_IDS[price_id]

    logger.debug('topup_user_point: updating and adding userPoint')
    doc_ref = db.collection(USERS).document(user_id)
    user_point = doc_ref.get().to_dict()['userPoint']
    user_point += topup_point
    doc_ref.update({
        'userPoint': user_point,
    })
    logger.info(f'topup_user_point: topup {topup_point} points on {user_id}')
    logger.debug('topup_user_point: finished')
    return


# Run once a day at midnight, to clean up inactive users.
# Manually run the task here https://console.cloud.google.com/cloudscheduler
@scheduler_fn.on_schedule(
        memory=options.MemoryOption.MB_512,
        schedule="every day 18:00",
        ) # JST 03:00
def delete_contents(event: scheduler_fn.ScheduledEvent) -> None:
    """
    userが持つcontentsを削除する関数
    """
    # user/{user_id}/contentsを削除
    from firebase_admin import firestore
    from src.utils import FireStorageUser
    db = firestore.client()
    logger.debug('delete_contents: deleting contents')
    doc_ref = db.collection(USERS).stream()
    user_ids = [doc.id for doc in doc_ref]
    for user_id in user_ids:
        storage_user = FireStorageUser(user_id=user_id, storage_bucket=storage_bucket)
        storage_user.delete_contents()
    logger.debug('delete_contents: deleted contents')

@firestore_fn.on_document_updated(
    memory=options.MemoryOption.MB_512,
    document="users/{user_id}/contents/{contents_id}",
)
def delete_index_json(event: firestore_fn.Event) -> None:
    '''
    contentが論理削除されたときに，indexを削除する関数．
    '''
    from firebase_admin import firestore
    from src.utils import FireStorageUser

    from src.model.content import Content
    db = firestore.client()

    logger.debug('delete_index_json: called')
    doc_ref = db.document(event.document)
    doc_snapshot = doc_ref.get()
    if not doc_snapshot.exists:
        logger.info('delete_index_json: called, but document does not exist')
        return
    content = Content(**doc_snapshot.to_dict())
    if content.isDeleted == False:
        logger.info('delete_index_json: content is updated but not deleted')
        return
    logger.info(f'content which is deleted is {content.contentId}')
    # content.storageIndexIdを使って，index.jsonを削除
    if content.storageIndexId == '':
        logger.info('delete_index_json: called, but storageIndexId is blank')
        return
    logger.debug('delete_index_json: deleting index.json')
    user_id = event.params['user_id']
    storage_user = FireStorageUser(user_id=user_id, storage_bucket=storage_bucket)
    storage_user.delete_indexes(content.storageIndexId)
    logger.debug('delete_index_json: finished')
    return