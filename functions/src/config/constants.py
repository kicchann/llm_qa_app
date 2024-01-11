
SERVICE_ACCOUNT_KEY_JSON = './key/serviceAccountKey.json'
APP_CRED_JSON = './key/application_default_credentials.json'
BUCKET_NAME_DEV = 'botob-5a38c.appspot.com'
BUCKET_NAME_PROD = 'botobai.appspot.com'


PRICE_IDS = {
    'price_1NwuASIMWjAXzwjskYPjLBpB': 100,
    'price_1NwuBFIMWjAXzwjsWUj15U9v': 1000,
    'price_1NwuFUIMWjAXzwjsVCPnYppC': 10000,
}

USERS = 'users'
CUSTOMERS = 'customers'
PAYMENTS = 'payments'
CONTENTS = 'contents'
DOCUMENTS = 'documents'
REFFERED_DOCUMENTS = 'refferedDocuments'
INDEX_MANAGERS = 'indexManagers'
INDEXES = 'indexes'
TEMP = 'temp'
QUERIES = 'queries'
ANSWERS = 'answers'
QAS = 'qas'


####################################
# GPT用の定数
####################################
MODEL_FOR_CORRECTION = "gpt-3.5-turbo-16k"

PROMPT_SYSTEM = '''
You are an expert Q&A system that is trusted around the world.
Always answer the query using the provided context information, and not prior knowledge.
Some rules to follow:
1. Never directly reference the given context in your answer.
2. Avoid statements like 'Based on the context, ...' or 'The context information ...' or anything along those lines. 
'''

PROMPT_USER = '''
Context information is below.
---------------------
{context_str}
---------------------
Given the context information and not prior knowledge, answer the query with markdown format and the language used in the query.
Query: {query_str}
Answer:
'''

CONTENT_TYPE_TEXT = 'text'
CONTENT_TYPE_FILES: list = ['txt', 'md', 'Json', 'pdf']

VERSION = 'v1'
