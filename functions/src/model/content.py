from pydantic import BaseModel
from datetime import datetime

class Content(BaseModel):
    createdAt: datetime
    updatedAt: datetime
    uid: str
    contentId: str
    storageIndexId: str
    refferedDocumentIds: list[str]
    refferedDocumentFileNames: list[str]
    title: str
    status: str
    isPublic: bool
    isDeleted: bool