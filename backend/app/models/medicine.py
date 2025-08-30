from sqlalchemy import Column, Integer, String, Text, Numeric, DateTime, Index
from sqlalchemy.sql import func
from ..core.database import Base


class MedicineProductType(Base):
    __tablename__ = "medicine_product_type"
    
    # Primary key
    id = Column(Integer, primary_key=True, index=True)
    
    # Basic information
    sl_number = Column(Integer, nullable=False, index=True)
    manufacturer_name = Column(String(255), nullable=False, index=True)
    brand_name = Column(String(255), nullable=False, index=True)
    generic_name_strength = Column(String(255), nullable=False, index=True)
    dosage_form = Column(String(100), nullable=False)
    use_for = Column(String(100), nullable=False)
    dar_number = Column(String(50), nullable=False, unique=True, index=True)
    
    # Medical information
    indication = Column(Text)
    price = Column(Numeric(10, 2))
    adult_dose = Column(Text)
    child_dose = Column(Text)
    renal_dose = Column(Text)
    administration = Column(Text)
    side_effects = Column(Text)
    precautions_warnings = Column(Text)
    pregnancy_lactation = Column(Text)
    mode_of_action = Column(Text)
    interaction = Column(Text)
    dosage_from = Column(String(100))  # Renamed from pack_size
    
    # Timestamps
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    
    # Indexes for better performance
    __table_args__ = (
        Index('idx_medicine_brand_manufacturer', 'brand_name', 'manufacturer_name'),
        Index('idx_medicine_generic_dosage', 'generic_name_strength', 'dosage_form'),
        Index('idx_medicine_created_updated', 'created_at', 'updated_at'),
    )
    
    def __repr__(self):
        return f"<MedicineProductType(id={self.id}, brand_name='{self.brand_name}', manufacturer='{self.manufacturer_name}')>"
