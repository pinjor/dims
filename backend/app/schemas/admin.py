from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime

class AdminUserBase(BaseModel):
    username: str = Field(..., min_length=3, max_length=50, description="Admin username")
    email: EmailStr = Field(..., description="Admin email address")
    is_active: bool = Field(True, description="Whether the admin user is active")
    is_superuser: bool = Field(False, description="Whether the admin user is a superuser")

class AdminUserCreate(AdminUserBase):
    password: str = Field(..., min_length=6, max_length=100, description="Admin password")

class AdminUserUpdate(BaseModel):
    username: Optional[str] = Field(None, min_length=3, max_length=50, description="Admin username")
    email: Optional[EmailStr] = Field(None, description="Admin email address")
    password: Optional[str] = Field(None, min_length=6, max_length=100, description="Admin password")
    is_active: Optional[bool] = Field(None, description="Whether the admin user is active")
    is_superuser: Optional[bool] = Field(None, description="Whether the admin user is a superuser")

class AdminUserResponse(AdminUserBase):
    id: int
    created_at: datetime
    updated_at: Optional[datetime] = None
    
    class Config:
        from_attributes = True

class AdminLoginRequest(BaseModel):
    username: str = Field(..., description="Admin username or email")
    password: str = Field(..., description="Admin password")

class AdminLoginResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    admin_user: AdminUserResponse

class TokenData(BaseModel):
    username: Optional[str] = None
    admin_id: Optional[int] = None
