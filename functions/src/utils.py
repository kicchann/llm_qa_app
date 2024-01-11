import time
import logging
import json
from typing import Optional
import openai

from firebase_admin import storage, firestore
from firebase_functions import options
from firebase_functions.params import SecretParam
from google import auth
from google.auth.transport.requests import AuthorizedSession
from google.cloud.storage.blob import Blob

from src.config import *
from src.model import Content, RefferedDocument, IndexManager, User, Answer

logger = logging.getLogger(__name__)

def get_function_url(
    name: str, location: Optional[str] = None 
) -> str:
    """Get the URL of a given v2 cloud function.

    Params:
        name: the function's name
        location: the function's location

    Returns: The URL of the function

    memo:
    # permission deniedのエラーが出たら以下を参照
    https://stackoverflow.com/questions/64095597/google-cloud-datastore-authentication-on-windows-10
    """
    if location is None:
        location = 'asia-northeast1'
    logger.debug('get_function_url: called')
    credentials, project_id = auth.default(scopes=["https://www.googleapis.com/auth/cloud-platform"])
    authed_session = AuthorizedSession(credentials)
    time.sleep(1)  # avoid 429s
    url = "https://cloudfunctions.googleapis.com/v2beta/" \
        + f"projects/{project_id}/locations/{location}/functions/{name}"
    response = authed_session.get(url)
    time.sleep(1)  # avoid 429s
    data = response.json()
    try:
        function_url = data["serviceConfig"]["uri"]
        return function_url
    except KeyError:
        logger.error(f"Function failed to deploy: {data}")
        return ""

class FirestoreUser():
    def __init__(self, user_id:str):
        self._user_id = user_id
        self._bd = firestore.client()

    def user(self)->User:
        logger.debug('FirestoreUser.user: called')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id)
        user = User(**doc_ref.get().to_dict())
        logger.debug('FirestoreUser.user: finished')
        return user

    def get_content(self, content_id:str)->Content:
        logger.debug('FirestoreUser.get_content: called')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(CONTENTS) \
            .document(content_id)
        content = Content(**doc_ref.get().to_dict())
        logger.debug('FirestoreUser.get_content: finished')
        return content

    def get_reffered_document(self, reffered_document_id:str)->RefferedDocument:
        logger.debug('FirestoreUser.get_reffered_document: called')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(REFFERED_DOCUMENTS) \
            .document(reffered_document_id)
        reffered_document = RefferedDocument(**doc_ref.get().to_dict())
        logger.debug('FirestoreUser.get_reffered_document: finished')
        return reffered_document

    def get_index_manager(self, index_manager_id:str)->IndexManager:
        logger.debug('FirestoreUser.get_index_manager: called')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(INDEX_MANAGERS) \
            .document(index_manager_id)
        index_manager = IndexManager(**doc_ref.get().to_dict())
        logger.debug('FirestoreUser.get_index_manager: finished')
        return index_manager

    def set_answer(self, content_id:str, answer:Answer):
        logger.debug('FirestoreUser.set_answer: called')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(CONTENTS) \
            .document(content_id) \
            .collection(ANSWERS) \
            .document(answer.answerId)
        doc_ref.set(answer.dict())
        logger.debug('FirestoreUser.set_answer: finished')
        return
    
    def update_user(self, data:dict):
        logger.debug('update_user: called')
        logger.debug('update_user: updating user')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id)
        doc_ref.update(data)
        logger.info(f'update_user: updated user {USERS}/{self._user_id} with {data}')
        logger.debug('update_user: finished')
        return

    def update_content(self, content_id:str, data:dict):
        logger.debug('update_content: called')
        logger.debug('update_content: updating content')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(CONTENTS) \
            .document(content_id)
        doc_ref.update(data)
        logger.info(f'update_content: updated content {USERS}/{self._user_id}{CONTENTS}/{content_id} with {data}')
        logger.debug('update_content: finished')
        return

    def update_index_manager(self, index_manager_id:str, data:dict):
        logger.debug('update_index_manager: called')
        logger.debug('update_index_manager: updating index_manager')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(INDEX_MANAGERS) \
            .document(index_manager_id)
        doc_ref.update(data)
        logger.info(f'update_index_manager: updated index_manager {USERS}/{self._user_id}{INDEX_MANAGERS}/{index_manager_id} with {data}')
        logger.debug('update_index_manager: finished')
        return

    def update_reffered_document(self, reffered_document_id:str, data:dict):
        logger.debug('update_reffered_document: called')
        logger.debug('update_reffered_document: updating reffered_document')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(REFFERED_DOCUMENTS) \
            .document(reffered_document_id)
        doc_ref.update(data)
        logger.info(f'update_reffered_document: updated reffered_document {USERS}/{self._user_id}{REFFERED_DOCUMENTS}/{reffered_document_id} with {data}')
        logger.debug('update_reffered_document: finished')
        return
        
    def update_query(self, content_id:str, query_id:str, data:dict):
        logger.debug('update_query_with_answer: called')
        logger.debug('update_query_with_answer: updating query')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(CONTENTS) \
            .document(content_id) \
            .collection(QUERIES) \
            .document(query_id)
        doc_ref.update(data)
        logger.info(f'update_query_with_answer: updated query {USERS}/{self._user_id}{CONTENTS}/{content_id}/{QUERIES}/{query_id} with {data}')
        logger.debug('update_query_with_answer: finished')
        return

    def delete_index_manager(self, index_manager_id:str):
        logger.debug('delete_index_manager: called')
        logger.debug('delete_index_manager: deleting index_manager')
        doc_ref = self._bd \
            .collection(USERS) \
            .document(self._user_id) \
            .collection(INDEX_MANAGERS) \
            .document(index_manager_id)
        doc_ref.delete()
        logger.info(f'check_progress_of_documentation: deleted index_manager {index_manager_id}')
        logger.debug('delete_index_manager: finished')
        return 

class FireStorageUser():
    def __init__(self, user_id:str, storage_bucket:str):
        self._user_id = user_id
        self._bucket = storage.bucket(storage_bucket)

    def get_content_blob(self, storage_content_id:str)->Blob:
        logger.debug('FireStorageUser.get_content_blob: called')
        blobs = self._bucket.list_blobs(
            prefix=f'users/{self._user_id}/{CONTENTS}/{storage_content_id}/',
            )
        blob = list(blobs)[0]
        logger.debug('FireStorageUser.get_content_blob: finished')
        return blob

    def get_document_blob(self, storage_document_id:str)->Blob:
        logger.debug('FireStorageUser.get_document_blob: called')
        blobs = self._bucket.list_blobs(
            prefix=f'users/{self._user_id}/{DOCUMENTS}/{storage_document_id}/',
            )
        blob = list(blobs)[0]
        logger.debug('FireStorageUser.get_document_blob: finished')
        return blob

    def get_index_blob(self, storage_index_id:str)->Blob:
        logger.debug('FireStorageUser.get_storage_blob: called')
        blobs = self._bucket.list_blobs(
            prefix=f'users/{self._user_id}/{INDEXES}/{storage_index_id}/',
            )
        blob = list(blobs)[0]
        logger.debug('FireStorageUser.get_storage_blob: finished')
        return blob

    def upload_document(self, doc_id:str, file_name:str, documents:list):
        logger.debug('FireStorageUser.upload_document: called')
        blob = self._bucket.blob(
            f'{USERS}/{self._user_id}/{DOCUMENTS}/{doc_id}/{file_name}')
        blob.upload_from_string(
            data=json.dumps(documents),
            content_type='application/json',
        )
        logger.info(f'FireStorageUser.upload_document: saved docs to storage {doc_id}')
        logger.debug('FireStorageUser.upload_document: finished')
        return

    def upload_index(self, index_id:str, file_name:str, index_dict:dict):
        logger.debug('FireStorageUser.upload_index: called')
        blob = self._bucket.blob(
            f'{USERS}/{self._user_id}/{INDEXES}/{index_id}/{file_name}')
        blob.upload_from_string(
            data=json.dumps(index_dict),
            content_type='application/json',
        )
        logger.info(f'FireStorageUser.upload_index: saved index {index_id}')
        logger.debug('FireStorageUser.upload_index: finished')
        return

    def delete_contents(self, storage_content_id:Optional[str] = None):
        logger.debug('FireStorageUser.delete_contents: called')
        if storage_content_id is not None:
            blobs = self._bucket.list_blobs(
                prefix=f'users/{self._user_id}/{CONTENTS}/',
                )
            _ = [blob.delete() for blob in blobs]
            logger.info(f'FireStorageUser.delete_contents: deleted contents on users/{self._user_id}/{CONTENTS}/')
        else:
            blobs = self._bucket.list_blobs(
                prefix=f'users/{self._user_id}/{CONTENTS}/{storage_content_id}/',
                )
            _ = [blob.delete() for blob in blobs]
            logger.info(f'FireStorageUser.delete_contents: deleted contents on users/{self._user_id}/{CONTENTS}/{storage_content_id}/')
        logger.debug('FireStorageUser.delete_contents: finished')
        return

    def delete_indexes(self, storage_index_id:str):
        logger.debug('FireStorageUser.delete_indexes: called')
        blobs = self._bucket.list_blobs(
            prefix=f'users/{self._user_id}/{INDEXES}/{storage_index_id}/',
            )
        _ = [blob.delete() for blob in blobs]
        logger.info(f'FireStorageUser.delete_indexes: deleted indexes on users/{self._user_id}/{INDEXES}/{storage_index_id}/')
        logger.debug('FireStorageUser.delete_indexes: finished')
        return

def get_index_dict_from_storage(user_id:str, storage_bucket:str, content_id:str)->dict:
    logger.debug('get_index_dict_from_storage: called')
    firestore_user = FirestoreUser(user_id=user_id)
    firestorage_user = FireStorageUser(user_id=user_id, storage_bucket=storage_bucket)

    # firebase firestoreからstorageIndexIdを取得
    logger.debug('get_index_dict_from_storage: getting storageIndexId from firestore')
    content:Content = firestore_user.get_content(content_id=content_id)
    storage_index_id = content.storageIndexId
    if storage_index_id == "":
        logger.error('get_index_dict_from_storage: storageIndexId is empty')
        raise Exception('storageIndexId is empty')
    logger.debug('get_index_dict_from_storage: got storageIndexId from firestore')
    
    logger.debug('get_index_dict_from_storage: getting index from storage')
    blob = firestorage_user.get_index_blob(storage_index_id=storage_index_id)
    storage_index_dict = json.loads(blob.download_as_string())
    logger.debug('get_index_dict_from_storage: got index from storage')
    logger.debug('get_index_dict_from_storage: finished')
    return storage_index_dict

def correct_text_with_openai(texts:list[str], openai_api_key:str) -> list[str]:
    '''_correct_text_with_openai

    openaiを使った文章の校正

    Args:
        texts (list[str]): 校正したい文章

    Returns:
        list[str]: 校正後の文章
    '''
    import random, string

    logger.debug('correct_text_with_openai: called')
    openai.api_key = openai_api_key
    # セパレータとして使う文字列をランダムに生成
    separator = ''.join(random.choices(string.ascii_letters + string.digits, k=6))
    try:
        buf_text = ""
        new_texts = []
        for i, t in enumerate(texts):
            buf_text += t + separator
            if len(buf_text) <= 10000 and i != len(texts) - 1:
                continue
            response = openai.chat.completions.create(
                # 確実にセパレータを残すように、temperatureを0.0に設定
                temperature = 0.0,
                model = MODEL_FOR_CORRECTION,
                messages = [
                    {
                        "role": "system",
                        "content": f"""
                        You are helpful assistant that helps people with their writing.
                        Correct the following sentence and remove or replace unnecessary newlines to make it more readable.
                        Keep '{separator}' as it is used as a separator later.
                        """
                    },
                    {
                        "role": "user",
                        "content": buf_text
                    },
                ],
            )
            corrected_text = str(response.choices[0].message.content).strip()
            # corrected_textをseparatorで分割して、new_textsに追加
            new_texts += corrected_text.split(separator)[:-1]
            # buf_textを初期化
            buf_text = ""
        logger.debug('correct_text_with_openai: finished successfully')
        return new_texts
    except:
        logger.info('correct_text_with_openai: finished with error on openai')
        return texts        

def check_moderation(text: str, openai_api_key:str) -> bool:
    r'''
    与えられたtextが不適切な内容を含んでいないかを確認する

    Args:
        text (str): 確認したいtext

    Returns:
        bool: Trueならば，不適切な内容を含んでいる
    '''
    logger.debug('check_moderation: called')
    openai.api_key = openai_api_key
    response = openai.moderations.create(
        input=text,
    )
    try:
        flag = response.results[0].flagged
        logger.debug('check_moderation: finished with flag: ' + str(flag))
        return flag
    except:
        logger.info('check_moderation: not working then return False')
        return False

def check_encoding(blob:Blob) -> str:
    r'''
    文字コードを判定する
    [参照]
    https://zenn.dev/takedato/articles/c3a491546f8c58
    '''
    import chardet
    encoding:str = ''
    data = blob.download_as_string()
    result = chardet.detect(data)
    try:
        encoding = str(result['encoding'])
    except:
        pass
    return encoding