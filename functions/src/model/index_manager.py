from pydantic import BaseModel
from datetime import datetime

class IndexManager(BaseModel):
    createdAt: datetime
    indexManagerId: str
    refferedDocumentIds: list[str]
    completedDocumentIds: list[str]

