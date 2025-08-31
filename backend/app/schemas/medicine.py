from pydantic import BaseModel, Field, validator
from typing import Optional
from datetime import datetime
from decimal import Decimal


class MedicineBase(BaseModel):
    """Base schema for medicine product"""
    sl_number: int = Field(..., description="Serial number")
    manufacturer_name: str = Field(..., min_length=1, max_length=255, description="Manufacturer name")
    brand_name: str = Field(..., min_length=1, max_length=255, description="Brand name")
    generic_name_strength: str = Field(..., min_length=1, max_length=255, description="Generic name and strength")
    dosage_form: str = Field(..., min_length=1, max_length=100, description="Dosage form")
    use_for: str = Field(..., min_length=1, max_length=100, description="Use for")
    dar_number: str = Field(..., min_length=1, max_length=50, description="DAR number")
    indication: Optional[str] = Field(None, description="Indication")
    price: Optional[Decimal] = Field(None, ge=0, description="Price")
    adult_dose: Optional[str] = Field(None, description="Adult dose")
    child_dose: Optional[str] = Field(None, description="Child dose")
    renal_dose: Optional[str] = Field(None, description="Renal dose")
    administration: Optional[str] = Field(None, description="Administration")
    side_effects: Optional[str] = Field(None, description="Side effects")
    precautions_warnings: Optional[str] = Field(None, description="Precautions and warnings")
    pregnancy_lactation: Optional[str] = Field(None, description="Pregnancy and lactation")
    mode_of_action: Optional[str] = Field(None, description="Mode of action")
    interaction: Optional[str] = Field(None, description="Interaction")
    category: Optional[str] = Field(None, max_length=100, description="Category")
    drug_code: Optional[str] = Field(None, max_length=50, description="Drug code")
    country_code: Optional[str] = Field(None, max_length=10, description="Country code")
    pack_size: Optional[str] = Field(None, max_length=100, description="Pack size")
    special_category: Optional[str] = Field(None, max_length=100, description="Special category")
    shelf_life: Optional[str] = Field(None, max_length=50, description="Shelf life")
    temperature_condition: Optional[str] = Field(None, max_length=100, description="Temperature condition")
    therapeutic_class: Optional[str] = Field(None, max_length=100, description="Therapeutic class")


class MedicineCreate(MedicineBase):
    """Schema for creating a new medicine product"""
    pass


class MedicineUpdate(BaseModel):
    """Schema for updating a medicine product"""
    sl_number: Optional[int] = None
    manufacturer_name: Optional[str] = Field(None, min_length=1, max_length=255)
    brand_name: Optional[str] = Field(None, min_length=1, max_length=255)
    generic_name_strength: Optional[str] = Field(None, min_length=1, max_length=255)
    dosage_form: Optional[str] = Field(None, min_length=1, max_length=100)
    use_for: Optional[str] = Field(None, min_length=1, max_length=100)
    dar_number: Optional[str] = Field(None, min_length=1, max_length=50)
    indication: Optional[str] = None
    price: Optional[Decimal] = Field(None, ge=0)
    adult_dose: Optional[str] = None
    child_dose: Optional[str] = None
    renal_dose: Optional[str] = None
    administration: Optional[str] = None
    side_effects: Optional[str] = None
    precautions_warnings: Optional[str] = None
    pregnancy_lactation: Optional[str] = None
    mode_of_action: Optional[str] = None
    interaction: Optional[str] = None
    category: Optional[str] = Field(None, max_length=100)
    drug_code: Optional[str] = Field(None, max_length=50)
    country_code: Optional[str] = Field(None, max_length=10)
    pack_size: Optional[str] = Field(None, max_length=100)
    special_category: Optional[str] = Field(None, max_length=100)
    shelf_life: Optional[str] = Field(None, max_length=50)
    temperature_condition: Optional[str] = Field(None, max_length=100)
    therapeutic_class: Optional[str] = Field(None, max_length=100)


class MedicineResponse(MedicineBase):
    """Schema for medicine product response"""
    id: int
    created_at: datetime
    updated_at: datetime
    
    class Config:
        from_attributes = True


class MedicineListResponse(BaseModel):
    """Schema for paginated medicine list response"""
    items: list[MedicineResponse]
    total: int
    page: int
    size: int
    pages: int


class MedicineSearchRequest(BaseModel):
    """Schema for medicine search request"""
    query: Optional[str] = Field(None, description="Search query")
    manufacturer: Optional[str] = Field(None, description="Manufacturer filter")
    dosage_form: Optional[str] = Field(None, description="Dosage form filter")
    page: int = Field(1, ge=1, description="Page number")
    size: int = Field(10, ge=1, le=100, description="Page size")
    
    @validator('query')
    def validate_query(cls, v):
        if v is not None and len(v.strip()) < 2:
            raise ValueError('Query must be at least 2 characters long')
        return v.strip() if v else None
