# DIMS (Drug Information Management System) - Architecture Template

## 🏗️ **DOCKER COMPOSE ARCHITECTURE**

### Services Overview
```yaml
services:
  postgres:     # PostgreSQL Database (port 5432)
  redis:        # Redis Cache (port 6379)
  backend:      # FastAPI Backend (port 8000)
  dims_app:     # Flutter Web App (port 3000)
  admin_app:    # Admin Web App (port 3001)
  pgadmin:      # Database Admin (port 8080)
```

### Network Configuration
- **Network**: `dims_network` (bridge driver)
- **Internal Communication**: Services communicate via service names
- **External Access**: Port mapping to localhost

### Volume Management
```yaml
volumes:
  postgres_data:    # Database persistence
  pgadmin_data:     # pgAdmin settings
  redis_data:       # Redis persistence
```

---

## 🗄️ **DATABASE ARCHITECTURE**

### PostgreSQL Configuration
- **Database**: `dims_db`
- **User**: `dims_user`
- **Password**: `dims_password`
- **Port**: `5432`
- **Health Check**: `pg_isready`

### Main Table Schema: `medicine_product_type`
```sql
-- Primary Key
id (SERIAL PRIMARY KEY)

-- Basic Information
sl_number (INTEGER NOT NULL)
manufacturer_name (VARCHAR(255) NOT NULL)
brand_name (VARCHAR(255) NOT NULL)
generic_name_strength (VARCHAR(255) NOT NULL)
dosage_form (VARCHAR(100) NOT NULL)
use_for (VARCHAR(100) NOT NULL)
dar_number (VARCHAR(50) NOT NULL UNIQUE)

-- Medical Information
indication (TEXT)
price (NUMERIC(10,2))
adult_dose (TEXT)
child_dose (TEXT)
renal_dose (TEXT)
administration (TEXT)
side_effects (TEXT)
precautions_warnings (TEXT)
pregnancy_lactation (TEXT)
mode_of_action (TEXT)
interaction (TEXT)

-- Additional Information
category (VARCHAR(100))
drug_code (VARCHAR(50))
country_code (VARCHAR(10))
pack_size (VARCHAR(100))
special_category (VARCHAR(100))
shelf_life (VARCHAR(50))
temperature_condition (VARCHAR(100))
therapeutic_class (VARCHAR(100))

-- Timestamps
created_at (TIMESTAMP WITH TIME ZONE)
updated_at (TIMESTAMP WITH TIME ZONE)
```

### Database Indexes
```sql
-- Performance Indexes
CREATE INDEX idx_medicine_brand_manufacturer ON medicine_product_type(brand_name, manufacturer_name);
CREATE INDEX idx_medicine_generic_dosage ON medicine_product_type(generic_name_strength, dosage_form);
CREATE INDEX idx_medicine_created_updated ON medicine_product_type(created_at, updated_at);
CREATE INDEX idx_medicine_dar_number ON medicine_product_type(dar_number);
```

---

## 🌐 **NGINX CONFIGURATION**

### Admin App (nginx.admin.conf)
```nginx
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    # Gzip Compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;

    # Static Files
    location / {
        try_files $uri $uri/ /index.html;
        add_header Cache-Control "no-cache, no-store, must-revalidate";
    }

    # Flutter Web Assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

### Main App (nginx.conf)
```nginx
server {
    listen 80;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;

    # Flutter Web App Configuration
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

---

## 🚀 **FASTAPI BACKEND ARCHITECTURE**

### Project Structure
```
backend/
├── app/
│   ├── api/
│   │   ├── medicine.py      # Medicine CRUD endpoints
│   │   └── admin.py         # Admin endpoints
│   ├── core/
│   │   ├── config.py        # Settings & CORS
│   │   ├── database.py      # Database connection
│   │   └── cache.py         # Redis cache
│   ├── models/
│   │   └── medicine.py      # SQLAlchemy models
│   ├── schemas/
│   │   └── medicine.py      # Pydantic schemas
│   └── main.py              # FastAPI app
├── Dockerfile
└── requirements.txt
```

### API Endpoints
```python
# Medicine Management
GET    /api/v1/medicines/                    # List medicines (paginated)
GET    /api/v1/medicines/{id}                # Get medicine by ID
POST   /api/v1/medicines/                    # Create new medicine
PUT    /api/v1/medicines/{id}                # Update medicine
DELETE /api/v1/medicines/{id}                # Delete medicine
GET    /api/v1/medicines/search/             # Search medicines
GET    /api/v1/medicines/manufacturer/{name} # Get by manufacturer

# Health Check
GET    /health                               # Service health
GET    /                                     # Root endpoint
```

### CORS Configuration
```python
allowed_origins = [
    "http://localhost:3000",    # Main Flutter app
    "http://localhost:3001",    # Admin app
    "http://localhost:8080",    # pgAdmin
    "http://192.168.80.158:3000" # External access
]
```

---

## 📱 **FLUTTER WEB APPS**

### Admin App Structure
```
lib/
├── admin_simple_main.dart           # Entry point
├── core/
│   └── services/
│       └── medicine_api_service.dart # API service
└── features/
    └── admin/
        └── presentation/
            └── screens/
                └── medicine_management_screen.dart
```

### API Service Configuration
```dart
class MedicineApiService {
  static const String baseUrl = 'http://localhost:8000/api/v1';
  
  // CRUD Operations
  static Future<Map<String, dynamic>> getMedicines({int page = 1, int size = 10});
  static Future<Map<String, dynamic>> createMedicine(Map<String, dynamic> data);
  static Future<Map<String, dynamic>> updateMedicine(int id, Map<String, dynamic> data);
  static Future<void> deleteMedicine(int id);
}
```

### Medicine Form Fields (26 fields)
```dart
// Controllers for all medicine fields
_slNumberController
_manufacturerNameController
_brandNameController
_genericNameStrengthController
_dosageFormController
_useForController
_darNumberController
_indicationController
_priceController
_adultDoseController
_childDoseController
_renalDoseController
_administrationController
_sideEffectsController
_precautionsWarningsController
_pregnancyLactationController
_modeOfActionController
_interactionController
_categoryController
_drugCodeController
_countryCodeController
_packSizeController
_specialCategoryController
_shelfLifeController
_temperatureConditionController
_therapeuticClassController
```

---

## 🔧 **DEPLOYMENT CONFIGURATION**

### Docker Compose Environment Variables
```yaml
environment:
  # Database
  - DATABASE_URL=postgresql://dims_user:dims_password@postgres:5432/dims_db
  - REDIS_URL=redis://redis:6379/0
  
  # API
  - API_HOST=0.0.0.0
  - API_PORT=8000
  - DEBUG=True
  - SECRET_KEY=your-secret-key-change-this-in-production
  
  # Cache
  - CACHE_TTL=300
  - REDIS_CACHE_TTL=600
```

### Health Checks
```yaml
# PostgreSQL
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U dims_user -d dims_db"]
  interval: 10s
  timeout: 5s
  retries: 5

# Backend
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8000/health"]
  interval: 30s
  timeout: 10s
  retries: 3
  start_period: 40s

# Redis
healthcheck:
  test: ["CMD", "redis-cli", "ping"]
  interval: 10s
  timeout: 5s
  retries: 5
```

---

## 🚀 **QUICK START COMMANDS**

### Development
```bash
# Start all services
docker-compose up -d

# Rebuild specific service
docker-compose up -d --build admin_app

# View logs
docker-compose logs -f backend

# Access services
# Admin App: http://localhost:3001
# Main App: http://localhost:3000
# Backend API: http://localhost:8000
# pgAdmin: http://localhost:8080
```

### Database Operations
```bash
# Connect to database
docker exec -it dims_postgres psql -U dims_user -d dims_db

# Backup database
docker exec dims_postgres pg_dump -U dims_user dims_db > backup.sql

# Restore database
docker exec -i dims_postgres psql -U dims_user dims_db < backup.sql
```

---

## 📋 **TROUBLESHOOTING CHECKLIST**

### Common Issues
1. **CORS Errors**: Check `allowed_origins` in backend config
2. **Database Connection**: Verify PostgreSQL is healthy
3. **Cache Issues**: Clear browser cache (Ctrl+F5)
4. **Port Conflicts**: Ensure ports 3000, 3001, 8000, 5432, 6379, 8080 are free
5. **API Timeout**: Check backend health at `/health` endpoint

### Debug Commands
```bash
# Check service status
docker ps --filter "name=dims_"

# Check backend health
curl http://localhost:8000/health

# Check database connection
docker exec dims_postgres pg_isready -U dims_user -d dims_db

# View service logs
docker-compose logs backend
docker-compose logs admin_app
```

---

This template provides a complete reference for the DIMS architecture, including database schema, Docker configuration, API endpoints, and deployment procedures.
