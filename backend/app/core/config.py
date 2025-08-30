from pydantic_settings import BaseSettings
from typing import List
import os


class Settings(BaseSettings):
    # Database Configuration
    database_url: str = "postgresql://dims_user:dims_password@postgres:5432/dims_db"
    
    # Redis Configuration
    redis_url: str = "redis://redis:6379/0"
    
    # FastAPI Configuration
    api_host: str = "0.0.0.0"
    api_port: int = 8000
    debug: bool = True
    
    # Security
    secret_key: str = "your-secret-key-change-this-in-production"
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 30
    
    # CORS
    allowed_origins: List[str] = ["http://localhost:3000", "http://localhost:8080"]
    
    # Cache Configuration
    cache_ttl: int = 300  # 5 minutes
    redis_cache_ttl: int = 600  # 10 minutes
    
    # API Configuration
    api_v1_prefix: str = "/api/v1"
    project_name: str = "DIMS API"
    project_version: str = "1.0.0"
    project_description: str = "Drug Information Management System API"
    
    class Config:
        env_file = ".env"
        case_sensitive = False


# Create settings instance
settings = Settings()
