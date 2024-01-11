import time
import logging
import json
import re
import pandas as pd
import io
from typing import Optional

from google.cloud.storage.blob import Blob

from src.config import *
from src.utils import check_encoding, correct_text_with_openai

logger = logging.getLogger(__name__)

class DocCreator:
    def __init__(self, openai_api_key: str):
        self._file_name: str = ""
        self._docs: list = []
        self._blob:Blob
        self._openai_api_key = openai_api_key
        logger.debug('DocCreator initialized')
    
    @property
    def file_name(self) -> str:
        return self._file_name

    @property
    def docs(self) -> list:
        return self._docs

    def create_docs_from_text(self, title: str, body: str):
        # 改行を削除
        body = body.replace("\n", "")
        # text splitterが半角スペースで分割するため
        # 全角の句点とエクスクラメーションマーク，クエッションマークは直後に半角スペースを入れる
        text = re.sub(r'([。.！!?？])', r'\1 ', body)

        self._docs = [dict(text=text, extra_info={"title": title})]
        self._file_name = "docs_" + title + ".json"
        return

    def create_docs_from_file(self, blob: Blob):
        logger.debug('DocCreator.create_docs_from_file: called')
        self._blob = blob
        self._file_name = str(blob.name).split("/")[-1]
        extension = str(blob.name).split("/")[-1].split(".")[-1].lower()
        if extension == "txt":
            documents = self._create_docs_from_txt()
        elif extension == "md":
            documents = self._create_docs_from_md()
        elif extension == "json":
            documents = self._create_docs_from_json()
        elif extension == "csv":
            documents = self._create_docs_from_csv()
        elif extension == "pdf":
            documents = self._create_docs_from_pdf(revise_text=False)
        else:
            documents = []

        try:
            self._docs = documents
            self._file_name = "docs_" + str(blob.name).split("/")[-1].split(".")[0] + ".json"
            return
        except:
            return

    def _create_docs_from_txt(self):
        logger.debug('DocCreator._create_docs_from_txt: called')
        encoding = check_encoding(self._blob)
        if encoding == "":
            logger.info('DocCreator._create_docs_from_txt: encoding wan unknown then return empty list')
            return []
        base_text = self._blob.download_as_string().decode(encoding)
        # 改行を削除
        base_text = base_text.replace("\n", "")
        # # 正規表現で句点とエクスクラメーションマーク，クエッションマークで分割してリスト作成
        # texts = re.split(r'[。.！!?？]', base_text)
        # text splitterが半角スペースで分割するため
        # 全角の句点とエクスクラメーションマーク，クエッションマークは直後に半角スペースを入れる
        base_text = re.sub(r'([。.！!?？])', r'\1 ', base_text)
        extra_info = {"file_name": self._file_name}
        # documents = [dict(text=text, extra_info=extra_info)
        #              for text in texts]
        documents = [dict(text=base_text, extra_info=extra_info)]
        logger.debug('DocCreator._create_docs_from_txt: finished')
        logger.debug(f'documents: {documents}')
        return documents

    def _create_docs_from_md(self):
        r'''
        markdownファイルを読み込む
        [参照]
        https://llamahub.ai/l/file-markdown
        ...\botob\functions\venv\Lib\site-packages\llama_index\readers\file\markdown_reader.py
        '''
        logger.debug('DocCreator._create_docs_from_md: called')
        from src.llm import MarkdownParser

        encoding = check_encoding(self._blob)
        if encoding == "":
            logger.info('DocCreator._create_docs_from_md: encoding wan unknown then return empty list')
            return []
        data = self._blob.download_as_string().decode(encoding)
        parser = MarkdownParser()
        tups = parser.parse_tups(data)
        documents = []
        for header, base_text in tups:
            # 改行を削除
            base_text = base_text.replace("\n", "")
            # text splitterが半角スペースで分割するため
            # 全角の句点とエクスクラメーションマーク，クエッションマークは直後に半角スペースを入れる
            base_text = re.sub(r'([。.！!?？])', r'\1 ', base_text)
            if header is None:
                extra_info = {"file_name": self._file_name}
            else:
                extra_info = {"file_name": self._file_name, "header": header}
            documents.append(dict(text=base_text, extra_info=extra_info))
        logger.debug('DocCreator._create_docs_from_md: finished')
        logger.debug(f'documents: {documents}')
        return documents

    def _create_docs_from_json(self):
        r'''
        jsonファイルを読み込む
        [参照]
        https://llamahub.ai/l/file-json
        ...\functions\venv\Lib\site-packages\llama_index\readers\json.py
        '''
        logger.debug('DocCreator._create_docs_from_json: called')

        encoding = check_encoding(self._blob)
        if encoding == "":
            logger.info('DocCreator._create_docs_from_json: encoding wan unknown then return empty list')
            return []
        data = json.loads(self._blob.download_as_string().decode(encoding))
        json_output = json.dumps(data, indent=0)
        lines = json_output.split("\n")
        useful_lines = [
            line for line in lines if not re.match(r"^[{}\[\],]*$", line)
        ]
        extra_info = {"file_name": self._file_name}
        documents = [
            dict(text="\n".join(useful_lines), extra_info=extra_info)
        ]
        logger.debug('DocCreator._create_docs_from_json: finished')
        logger.debug(f'documents: {documents}')
        return documents

    def _create_docs_from_pdf(self, revise_text: bool = False):
        r'''
        pdfファイルを読み込む
        [参照]
        ...\botob\functions\venv\Lib\site-packages\llama_index\readers\file\docs_reader.py
        '''
        logger.debug('DocCreator._create_docs_from_pdf: called')
        from src.llm import PdfParser

        parser = PdfParser()
        docs = parser.parse_tups(self._blob.download_as_bytes())
        documents = []
        for doc in docs:
            page_text = doc['text']
            page = doc['page']
            extra_info = {"file_name": self._file_name,
                          "page": page}
            documents.append(dict(text=page_text, extra_info=extra_info))

        # 校正しない場合はここで終了
        if not revise_text:
            logger.debug('DocCreator._create_docs_from_pdf: finished with no revision')
            logger.debug(f'documents: {documents}')
            return documents
        
        # 校正する場合はここから先を実行
        texts = [doc['text'] for doc in documents]
        new_texts = correct_text_with_openai(texts, self._openai_api_key)
        # text splitterが半角スペースで分割するため
        # 全角の句点とエクスクラメーションマーク，クエッションマークは直後に半角スペースを入れる
        new_texts = [re.sub(r'([。.！!?？])', r'\1 ', text) for text in new_texts]
        for i, new_text in enumerate(new_texts):
            documents[i]['text'] = new_text

        logger.debug('DocCreator._create_docs_from_pdf: finished')
        logger.debug(f'documents: {documents}')
        return documents
    
    def _create_docs_from_csv(self):
        r'''
        pandasのread_csvを使って，csvファイルを読み込む
        [参照]
        ...\botob\functions\venv\Lib\site-packages\llama_index\readers\file\tabular_reader.py
        '''
        logger.debug('DocCreator._create_docs_from_csv: called')

        encoding = check_encoding(self._blob)
        if encoding == "":
            logger.info('DocCreator._create_docs_from_csv: encoding wan unknown then return empty list')
            return []
        data = self._blob.download_as_string().decode(encoding)
        df = pd.read_csv(io.StringIO(data))
        col_joiner = ", "
        row_joiner = "\n"
        text_list = df.apply(
            lambda row: (col_joiner).join(row.astype(str).tolist()), axis=1
        ).tolist()
        extra_info = {"file_name": self._file_name}
        documents = [
            dict(text=(row_joiner).join(text_list), extra_info=extra_info)
        ]

        logger.debug('DocCreator._create_docs_from_csv: finished')
        logger.debug(f'documents: {documents}')
        return documents