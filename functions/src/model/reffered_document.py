from pydantic import BaseModel
from datetime import datetime

class RefferedDocument(BaseModel):
    createdAt: datetime
    refferedDocumentId: str
    title: str
    body: str
    fileName: str
    storageContentId: str
    storageDocumentId: str
    isDeleted: bool
