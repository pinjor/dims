from fastapi import APIRouter, Depends, HTTPException, Query, Path
from sqlalchemy.orm import Session
from sqlalchemy import or_, and_
from typing import List, Optional
import math

from ..core.database import get_db
from ..core.cache import cache
from ..models.medicine import MedicineProductType
from ..schemas.medicine import (
    MedicineCreate,
    MedicineUpdate,
    MedicineResponse,
    MedicineListResponse,
    MedicineSearchRequest
)

router = APIRouter()


@router.get("/medicines/", response_model=MedicineListResponse)
async def get_medicines(
    page: int = Query(1, ge=1, description="Page number"),
    size: int = Query(10, ge=1, le=100, description="Page size"),
    db: Session = Depends(get_db)
):
    """Get paginated list of medicines"""
    cache_key = f"medicines:list:page:{page}:size:{size}"
    
    # Try to get from cache first
    cached_result = await cache.get(cache_key)
    if cached_result:
        return MedicineListResponse(**cached_result)
    
    # Calculate offset
    offset = (page - 1) * size
    
    # Get total count
    total = db.query(MedicineProductType).count()
    
    # Get medicines with pagination
    medicines = db.query(MedicineProductType)\
        .offset(offset)\
        .limit(size)\
        .all()
    
    # Calculate total pages
    pages = math.ceil(total / size) if total > 0 else 1
    
    # Create response
    result = {
        "items": medicines,
        "total": total,
        "page": page,
        "size": size,
        "pages": pages
    }
    
    # Cache the result
    await cache.set(cache_key, result)
    
    return MedicineListResponse(**result)


@router.get("/medicines/{medicine_id}", response_model=MedicineResponse)
async def get_medicine(
    medicine_id: int = Path(..., description="Medicine ID"),
    db: Session = Depends(get_db)
):
    """Get medicine by ID"""
    cache_key = f"medicine:{medicine_id}"
    
    # Try to get from cache first
    cached_result = await cache.get(cache_key)
    if cached_result:
        return MedicineResponse(**cached_result)
    
    # Get medicine from database
    medicine = db.query(MedicineProductType).filter(
        MedicineProductType.id == medicine_id
    ).first()
    
    if not medicine:
        raise HTTPException(status_code=404, detail="Medicine not found")
    
    # Cache the result
    await cache.set(cache_key, medicine.__dict__)
    
    return MedicineResponse.from_orm(medicine)


@router.post("/medicines/", response_model=MedicineResponse, status_code=201)
async def create_medicine(
    medicine: MedicineCreate,
    db: Session = Depends(get_db)
):
    """Create a new medicine"""
    # Check if DAR number already exists
    existing_medicine = db.query(MedicineProductType).filter(
        MedicineProductType.dar_number == medicine.dar_number
    ).first()
    
    if existing_medicine:
        raise HTTPException(
            status_code=400,
            detail=f"Medicine with DAR number {medicine.dar_number} already exists"
        )
    
    # Create new medicine
    db_medicine = MedicineProductType(**medicine.dict())
    db.add(db_medicine)
    db.commit()
    db.refresh(db_medicine)
    
    # Invalidate cache
    await cache.delete_pattern("medicines:list:*")
    
    return MedicineResponse.from_orm(db_medicine)


@router.put("/medicines/{medicine_id}", response_model=MedicineResponse)
async def update_medicine(
    medicine_id: int = Path(..., description="Medicine ID"),
    medicine_update: MedicineUpdate = None,
    db: Session = Depends(get_db)
):
    """Update medicine by ID"""
    # Get existing medicine
    db_medicine = db.query(MedicineProductType).filter(
        MedicineProductType.id == medicine_id
    ).first()
    
    if not db_medicine:
        raise HTTPException(status_code=404, detail="Medicine not found")
    
    # Check DAR number uniqueness if being updated
    if medicine_update.dar_number and medicine_update.dar_number != db_medicine.dar_number:
        existing_medicine = db.query(MedicineProductType).filter(
            MedicineProductType.dar_number == medicine_update.dar_number
        ).first()
        
        if existing_medicine:
            raise HTTPException(
                status_code=400,
                detail=f"Medicine with DAR number {medicine_update.dar_number} already exists"
            )
    
    # Update medicine
    update_data = medicine_update.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(db_medicine, field, value)
    
    db.commit()
    db.refresh(db_medicine)
    
    # Invalidate cache
    await cache.delete(f"medicine:{medicine_id}")
    await cache.delete_pattern("medicines:list:*")
    
    return MedicineResponse.from_orm(db_medicine)


@router.delete("/medicines/{medicine_id}", status_code=204)
async def delete_medicine(
    medicine_id: int = Path(..., description="Medicine ID"),
    db: Session = Depends(get_db)
):
    """Delete medicine by ID"""
    # Get existing medicine
    db_medicine = db.query(MedicineProductType).filter(
        MedicineProductType.id == medicine_id
    ).first()
    
    if not db_medicine:
        raise HTTPException(status_code=404, detail="Medicine not found")
    
    # Delete medicine
    db.delete(db_medicine)
    db.commit()
    
    # Invalidate cache
    await cache.delete(f"medicine:{medicine_id}")
    await cache.delete_pattern("medicines:list:*")


@router.get("/medicines/search/", response_model=MedicineListResponse)
async def search_medicines(
    search_request: MedicineSearchRequest = Depends(),
    db: Session = Depends(get_db)
):
    """Search medicines with filters"""
    cache_key = f"medicines:search:{search_request.dict()}"
    
    # Try to get from cache first
    cached_result = await cache.get(cache_key)
    if cached_result:
        return MedicineListResponse(**cached_result)
    
    # Build query
    query = db.query(MedicineProductType)
    
    # Apply filters
    filters = []
    
    if search_request.query:
        search_term = f"%{search_request.query}%"
        filters.append(
            or_(
                MedicineProductType.brand_name.ilike(search_term),
                MedicineProductType.generic_name_strength.ilike(search_term),
                MedicineProductType.manufacturer_name.ilike(search_term),
                MedicineProductType.indication.ilike(search_term)
            )
        )
    
    if search_request.manufacturer:
        filters.append(
            MedicineProductType.manufacturer_name.ilike(f"%{search_request.manufacturer}%")
        )
    
    if search_request.dosage_form:
        filters.append(
            MedicineProductType.dosage_form.ilike(f"%{search_request.dosage_form}%")
        )
    
    if filters:
        query = query.filter(and_(*filters))
    
    # Get total count
    total = query.count()
    
    # Apply pagination
    offset = (search_request.page - 1) * search_request.size
    medicines = query.offset(offset).limit(search_request.size).all()
    
    # Calculate total pages
    pages = math.ceil(total / search_request.size) if total > 0 else 1
    
    # Create response
    result = {
        "items": medicines,
        "total": total,
        "page": search_request.page,
        "size": search_request.size,
        "pages": pages
    }
    
    # Cache the result
    await cache.set(cache_key, result)
    
    return MedicineListResponse(**result)


@router.get("/medicines/manufacturer/{manufacturer_name}", response_model=List[MedicineResponse])
async def get_medicines_by_manufacturer(
    manufacturer_name: str = Path(..., description="Manufacturer name"),
    db: Session = Depends(get_db)
):
    """Get medicines by manufacturer"""
    cache_key = f"medicines:manufacturer:{manufacturer_name}"
    
    # Try to get from cache first
    cached_result = await cache.get(cache_key)
    if cached_result:
        return [MedicineResponse(**item) for item in cached_result]
    
    # Get medicines from database
    medicines = db.query(MedicineProductType).filter(
        MedicineProductType.manufacturer_name.ilike(f"%{manufacturer_name}%")
    ).all()
    
    # Cache the result
    await cache.set(cache_key, [medicine.__dict__ for medicine in medicines])
    
    return [MedicineResponse.from_orm(medicine) for medicine in medicines]
