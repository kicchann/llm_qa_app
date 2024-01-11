import logging
import openai
from llama_index import StorageContext, ServiceContext, load_index_from_storage
from llama_index.llms import OpenAI
from llama_index.text_splitter import SentenceSplitter
from llama_index.llms.base import ChatMessage, MessageRole
from llama_index.prompts.base import ChatPromptTemplate

from llama_index.llms import OpenAI
import tiktoken

from src.config.constants import *

logger = logging.getLogger(__name__)

class AnswerCreator:
    def __init__(self, openai_api_key:str, index_dict: dict):
        logger.debug('AnswerCreator.__init__: called')
        # llama indexでindexを読み込む
        openai.api_key = openai_api_key
        storage_context = StorageContext.from_dict(index_dict)
        text_splitter = SentenceSplitter.from_defaults(
            chunk_overlap=50,
            tokenizer=tiktoken.get_encoding("cl100k_base").encode,
        )
        service_context = ServiceContext.from_defaults(
            llm=OpenAI(model="gpt-3.5-turbo"),
            text_splitter=text_splitter,
            )
        self._index = load_index_from_storage(
            storage_context=storage_context,
            service_context=service_context,
        )
        # QAプロンプトテンプレートメッセージ
        TEXT_QA_PROMPT_TMPL_MSGS = [
            ChatMessage(
                role=MessageRole.SYSTEM,
                content=(PROMPT_SYSTEM),
            ),
            ChatMessage(
                role=MessageRole.USER,
                content=(PROMPT_USER),
            ),
        ]
        # チャットQAプロンプト
        self.__CHAT_TEXT_QA_PROMPT = ChatPromptTemplate(
            message_templates=TEXT_QA_PROMPT_TMPL_MSGS,
            )
        logger.debug('AnswerCreator.__init__: finished')

    def create_answer(self, query: str) -> tuple[str, list[dict]]:

        # 質問応答
        query_engine = self._index.as_query_engine(
            similarity_top_k=5,
            text_qa_template=self.__CHAT_TEXT_QA_PROMPT,
        )
        response = query_engine.query(query)
        res = str(response)
        sources = []
        for sorce_node in response.source_nodes:
            try:
                source_text = sorce_node.node.text
            except:
                source_text = ""
            # 無駄な改行を削除
            source_text = source_text.replace("\n", "")
            
            sources.append({
                "metadata": sorce_node.node.metadata,
                "text": source_text,
            })
        return (res, sources)

