from pydantic import BaseModel
from datetime import datetime

class Answer(BaseModel):
    createdAt: datetime
    uid: str
    contentId: str
    queryId: str
    answerId: str
    body: str
    sources: str
