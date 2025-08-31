from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from datetime import timedelta

from ..core.database import get_db
from ..core.auth import (
    authenticate_admin, 
    create_access_token, 
    get_current_active_admin,
    get_current_superuser,
    ACCESS_TOKEN_EXPIRE_MINUTES
)
from ..models.admin import AdminUser
from ..models.medicine import MedicineProductType
from ..schemas.admin import (
    AdminUserCreate, 
    AdminUserUpdate, 
    AdminUserResponse,
    AdminLoginRequest,
    AdminLoginResponse
)
from ..schemas.medicine import MedicineCreate, MedicineUpdate, MedicineResponse

router = APIRouter(prefix="/admin", tags=["admin"])

# Authentication endpoints
@router.post("/login", response_model=AdminLoginResponse)
async def admin_login(login_data: AdminLoginRequest, db: Session = Depends(get_db)):
    """Admin login endpoint."""
    admin = authenticate_admin(db, login_data.username, login_data.password)
    if not admin:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": admin.username, "admin_id": admin.id}, 
        expires_delta=access_token_expires
    )
    
    return AdminLoginResponse(
        access_token=access_token,
        admin_user=AdminUserResponse.from_orm(admin)
    )

@router.get("/me", response_model=AdminUserResponse)
async def get_admin_profile(current_admin: AdminUser = Depends(get_current_active_admin)):
    """Get current admin profile."""
    return AdminUserResponse.from_orm(current_admin)

# Medicine management endpoints
@router.post("/medicines", response_model=MedicineResponse)
async def create_medicine(
    medicine: MedicineCreate,
    db: Session = Depends(get_db),
    current_admin: AdminUser = Depends(get_current_active_admin)
):
    """Create a new medicine."""
    db_medicine = MedicineProductType(**medicine.dict())
    db.add(db_medicine)
    db.commit()
    db.refresh(db_medicine)
    return MedicineResponse.from_orm(db_medicine)

@router.get("/medicines", response_model=List[MedicineResponse])
async def get_medicines(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(get_db),
    current_admin: AdminUser = Depends(get_current_active_admin)
):
    """Get all medicines (admin view)."""
    medicines = db.query(MedicineProductType).offset(skip).limit(limit).all()
    return [MedicineResponse.from_orm(medicine) for medicine in medicines]

@router.get("/medicines/{medicine_id}", response_model=MedicineResponse)
async def get_medicine(
    medicine_id: int,
    db: Session = Depends(get_db),
    current_admin: AdminUser = Depends(get_current_active_admin)
):
    """Get a specific medicine by ID."""
    medicine = db.query(MedicineProductType).filter(MedicineProductType.id == medicine_id).first()
    if not medicine:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Medicine not found"
        )
    return MedicineResponse.from_orm(medicine)

@router.put("/medicines/{medicine_id}", response_model=MedicineResponse)
async def update_medicine(
    medicine_id: int,
    medicine_update: MedicineUpdate,
    db: Session = Depends(get_db),
    current_admin: AdminUser = Depends(get_current_active_admin)
):
    """Update a medicine."""
    medicine = db.query(MedicineProductType).filter(MedicineProductType.id == medicine_id).first()
    if not medicine:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Medicine not found"
        )
    
    # Update only provided fields
    update_data = medicine_update.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(medicine, field, value)
    
    db.commit()
    db.refresh(medicine)
    return MedicineResponse.from_orm(medicine)

@router.delete("/medicines/{medicine_id}")
async def delete_medicine(
    medicine_id: int,
    db: Session = Depends(get_db),
    current_admin: AdminUser = Depends(get_current_active_admin)
):
    """Delete a medicine."""
    medicine = db.query(MedicineProductType).filter(MedicineProductType.id == medicine_id).first()
    if not medicine:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Medicine not found"
        )
    
    db.delete(medicine)
    db.commit()
    return {"message": "Medicine deleted successfully"}

# Admin user management (superuser only)
@router.post("/users", response_model=AdminUserResponse)
async def create_admin_user(
    admin_user: AdminUserCreate,
    db: Session = Depends(get_db),
    current_admin: AdminUser = Depends(get_current_superuser)
):
    """Create a new admin user (superuser only)."""
    # Check if username or email already exists
    existing_admin = db.query(AdminUser).filter(
        (AdminUser.username == admin_user.username) | 
        (AdminUser.email == admin_user.email)
    ).first()
    
    if existing_admin:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username or email already registered"
        )
    
    # Hash password
    from ..core.auth import get_password_hash
    hashed_password = get_password_hash(admin_user.password)
    
    db_admin = AdminUser(
        username=admin_user.username,
        email=admin_user.email,
        hashed_password=hashed_password,
        is_active=admin_user.is_active,
        is_superuser=admin_user.is_superuser
    )
    
    db.add(db_admin)
    db.commit()
    db.refresh(db_admin)
    return AdminUserResponse.from_orm(db_admin)

@router.get("/users", response_model=List[AdminUserResponse])
async def get_admin_users(
    db: Session = Depends(get_db),
    current_admin: AdminUser = Depends(get_current_superuser)
):
    """Get all admin users (superuser only)."""
    admin_users = db.query(AdminUser).all()
    return [AdminUserResponse.from_orm(admin) for admin in admin_users]
