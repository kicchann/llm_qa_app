from pydantic import BaseModel
from datetime import datetime

class User(BaseModel):
    authProvider: str
    createdAt: datetime
    email: str
    isAdmin: bool
    isPremium: bool
    uid: str
    updatedAt: datetime
    userImageUrl: str
    userName: str
    userPoint: int
