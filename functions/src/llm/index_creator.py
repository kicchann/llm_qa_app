import logging
from typing import Optional

from llama_index import VectorStoreIndex, ServiceContext, Document
from llama_index.text_splitter import SentenceSplitter
from llama_index.llms import OpenAI
import tiktoken

logger = logging.getLogger(__name__)

class IndexCreator:
    def __init__(self, openai_api_key: str):
        self._file_name: str = ""
        self._index_dict: Optional[dict] = None
        self._openai_api_key = openai_api_key
        logger.debug('IndexCreator initialized')
    
    @property
    def file_name(self) -> str:
        return self._file_name

    @property
    def index_dict(self) -> Optional[dict]:
        return self._index_dict

    def create_index_from_docs(self, docs: list[dict]):
        logger.debug('IndexCreator.create_index_from_docs: called')
        text_splitter = SentenceSplitter.from_defaults(
            chunk_overlap=50,
            tokenizer=tiktoken.get_encoding("cl100k_base").encode,
        )
        service_context = ServiceContext.from_defaults(
            llm=OpenAI(
                model="gpt-3.5-turbo",
                api_key=self._openai_api_key,
                ),
            text_splitter=text_splitter,
            )
        documents = [Document(**doc) for doc in docs]
        try:
            index = VectorStoreIndex.from_documents(documents=documents, service_context=service_context)
            self._index_dict = index.storage_context.to_dict()
            self._file_name = "index.json"
            logger.debug('IndexCreator.create_index_from_docs: finished')
        except Exception as e:
            logger.error('IndexCreator.create_index_from_docs: failed to create index')
            logger.error(e)
        return