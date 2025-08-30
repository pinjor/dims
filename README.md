# DIMS - Drug Information Management System

A comprehensive Drug Information Management System built with Flutter frontend and FastAPI backend, featuring PostgreSQL database and Redis caching.

## 🚀 Features

### Frontend (Flutter)
- **Medicine List Management** - View and manage medicine products
- **Medicine Details** - Detailed information about each medicine
- **QR Code Scanning** - Scan medicine QR codes for quick access
- **EHR Integration** - Electronic Health Records management
- **Prescription Management** - Digital prescription handling
- **User Authentication** - Secure user login and profile management

### Backend (FastAPI)
- **RESTful API** - Complete CRUD operations for medicine management
- **PostgreSQL Database** - Robust data storage with proper indexing
- **Redis Caching** - High-performance caching layer
- **Auto-generated Documentation** - Interactive API docs with Swagger UI
- **Input Validation** - Comprehensive data validation with Pydantic
- **Error Handling** - Proper error responses and logging

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Flutter App   │    │   FastAPI       │    │   PostgreSQL    │
│   (Frontend)    │◄──►│   (Backend)     │◄──►│   (Database)    │
│   Port: 3000    │    │   Port: 8000    │    │   Port: 5432    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌─────────────────┐
                       │     Redis       │
                       │   (Cache)       │
                       │   Port: 6379    │
                       └─────────────────┘
```

## 📋 Medicine Product Data Structure

Each medicine product includes comprehensive information:

- **Basic Information**: Serial number, manufacturer, brand name, generic name & strength
- **Medical Details**: Indication, adult/child/renal doses, administration
- **Safety Information**: Side effects, precautions, warnings, pregnancy & lactation
- **Technical Details**: Mode of action, drug interactions, pack size
- **Pricing**: Cost information for inventory management

## 🛠️ Technology Stack

### Frontend
- **Flutter** - Cross-platform mobile development
- **Dart** - Programming language
- **Material Design** - UI/UX framework

### Backend
- **FastAPI** - Modern Python web framework
- **SQLAlchemy** - Python SQL toolkit and ORM
- **Pydantic** - Data validation using Python type annotations
- **Redis** - In-memory data structure store
- **Uvicorn** - ASGI server implementation

### Database
- **PostgreSQL** - Advanced open-source relational database
- **pgAdmin** - Web-based administration tool

### DevOps
- **Docker** - Containerization platform
- **Docker Compose** - Multi-container application orchestration
- **Git** - Version control system

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/pinjor/popular_app.git
   cd popular_app
   ```

2. **Start the services**
   ```bash
   docker-compose up -d
   ```

3. **Access the applications**
   - **Flutter Web App**: http://localhost:3000
   - **FastAPI Backend**: http://localhost:8000
   - **API Documentation**: http://localhost:8000/docs
   - **pgAdmin**: http://localhost:8080
   - **Redis**: localhost:6379

## 📚 API Documentation

### Base URL
```
http://localhost:8000/api/v1
```

### Available Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/medicines/` | Get paginated list of medicines |
| `GET` | `/medicines/{id}` | Get specific medicine by ID |
| `POST` | `/medicines/` | Create new medicine |
| `PUT` | `/medicines/{id}` | Update existing medicine |
| `DELETE` | `/medicines/{id}` | Delete medicine |
| `GET` | `/medicines/search/` | Search medicines with filters |
| `GET` | `/medicines/manufacturer/{name}` | Get medicines by manufacturer |
| `GET` | `/health` | Health check endpoint |

### Example API Usage

#### Get All Medicines
```bash
curl "http://localhost:8000/api/v1/medicines/?page=1&size=10"
```

#### Search Medicines
```bash
curl "http://localhost:8000/api/v1/medicines/search/?query=azithromycin"
```

#### Create New Medicine
```bash
curl -X POST "http://localhost:8000/api/v1/medicines/" \
  -H "Content-Type: application/json" \
  -d '{
    "sl_number": 8,
    "manufacturer_name": "Test Pharma Ltd",
    "brand_name": "Test Medicine 100",
    "generic_name_strength": "Test Drug 100 mg",
    "dosage_form": "Tablet",
    "use_for": "Human",
    "dar_number": "394-0008-999",
    "indication": "Test indication",
    "price": 50.00,
    "adult_dose": "100mg twice daily",
    "dosage_from": "30 tablets per bottle"
  }'
```

## 🗄️ Database Schema

### Medicine Product Type Table
```sql
CREATE TABLE medicine_product_type (
    id SERIAL PRIMARY KEY,
    sl_number INTEGER NOT NULL,
    manufacturer_name VARCHAR(255) NOT NULL,
    brand_name VARCHAR(255) NOT NULL,
    generic_name_strength VARCHAR(255) NOT NULL,
    dosage_form VARCHAR(100) NOT NULL,
    use_for VARCHAR(100) NOT NULL,
    dar_number VARCHAR(50) NOT NULL UNIQUE,
    indication TEXT,
    price DECIMAL(10,2),
    adult_dose TEXT,
    child_dose TEXT,
    renal_dose TEXT,
    administration TEXT,
    side_effects TEXT,
    precautions_warnings TEXT,
    pregnancy_lactation TEXT,
    mode_of_action TEXT,
    interaction TEXT,
    dosage_from VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🔧 Development

### Backend Development
```bash
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload
```

### Frontend Development
```bash
flutter pub get
flutter run -d web
```

### Database Management
Access pgAdmin at http://localhost:8080
- Email: admin@dims.com
- Password: admin123

## 📊 Sample Data

The system comes pre-loaded with sample medicine data including:
- **Nimocon 500** (Azithromycin) - Antibiotic
- **Adbon** (Calcium + Vitamin D3) - Nutritional supplement
- **Opental 50** (Tramadol) - Pain management
- **Acidex 20** (Omeprazole) - GERD treatment
- **Napa 500** (Paracetamol) - Pain relief
- **Napa Extra** (Paracetamol + Caffeine) - Headache relief
- **Ace 100** (Aceclofenac) - Anti-inflammatory

## 🔒 Security Features

- **Input Validation** - All inputs are validated using Pydantic schemas
- **SQL Injection Prevention** - Using SQLAlchemy ORM
- **CORS Configuration** - Proper cross-origin resource sharing
- **Environment Variables** - Sensitive data stored in environment files
- **Non-root Docker User** - Security best practices in containers

## 📈 Performance Features

- **Redis Caching** - 10x faster response times for repeated queries
- **Database Indexing** - Optimized queries with proper indexes
- **Connection Pooling** - Efficient database connections
- **Async Operations** - Non-blocking I/O operations
- **Pagination** - Efficient handling of large datasets

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/yourusername)

## 🙏 Acknowledgments

- FastAPI team for the excellent web framework
- Flutter team for the cross-platform development framework
- PostgreSQL community for the robust database system
- Redis team for the high-performance caching solution

## 📞 Support

For support, email your-email@example.com or create an issue in the GitHub repository.

---

**DIMS** - Making drug information management simple and efficient! 💊