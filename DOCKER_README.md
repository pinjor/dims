# DIMS Docker Environment Setup

This document provides instructions for setting up the DIMS (Digital Information Management System) application using Docker with PostgreSQL database.

## Prerequisites

- Docker Desktop installed on your system
- Docker Compose (included with Docker Desktop)
- Git (for cloning the repository)

## Quick Start

1. **Clone the repository** (if not already done):
   ```bash
   git clone <repository-url>
   cd dims
   ```

2. **Start the Docker environment**:
   ```bash
   docker-compose up -d
   ```

3. **Access the applications**:
   - **DIMS Web App**: http://localhost:3000
   - **pgAdmin**: http://localhost:8080
   - **PostgreSQL**: localhost:5432

## Services Overview

### 1. PostgreSQL Database (`postgres`)
- **Port**: 5432
- **Database**: dims_db
- **Username**: dims_user
- **Password**: dims_password
- **Features**:
  - Pre-configured with DIMS database schema
  - Sample data for testing
  - Health checks enabled
  - Data persistence with Docker volumes

### 2. pgAdmin (`pgadmin`)
- **Port**: 8080
- **Email**: admin@dims.com
- **Password**: admin123
- **Purpose**: Web-based PostgreSQL administration tool

### 3. DIMS Web Application (`dims_app`)
- **Port**: 3000
- **Purpose**: Flutter web application served via nginx
- **Features**: Optimized for production with gzip compression and caching

### 4. Redis Cache (`redis`)
- **Port**: 6379
- **Purpose**: Caching layer for improved performance
- **Features**: Persistent data storage

## Database Schema

The PostgreSQL database includes the following schemas:

### `auth` Schema
- `users`: User authentication and basic information
- `user_profiles`: Extended user profile data

### `dims` Schema
- `medicines`: Medicine database with search capabilities

### `ehr` Schema
- `patients`: Patient information
- `vitals`: Patient vital signs
- `medical_records`: Medical records and documents

### `prescription` Schema
- `prescriptions`: Prescription records
- `prescription_medicines`: Medicine details for prescriptions
- `appointments`: Appointment scheduling

## Sample Data

The database is pre-populated with:
- Sample medicines (Allegra, Valium, Zoloft, etc.)
- Test users (admin and patients)
- Sample prescriptions and appointments
- Medical records and vitals

## Docker Commands

### Start Services
```bash
# Start all services in detached mode
docker-compose up -d

# Start with logs visible
docker-compose up

# Start specific service
docker-compose up postgres
```

### Stop Services
```bash
# Stop all services
docker-compose down

# Stop and remove volumes (WARNING: This will delete all data)
docker-compose down -v
```

### View Logs
```bash
# View all logs
docker-compose logs

# View specific service logs
docker-compose logs postgres
docker-compose logs dims_app
```

### Database Operations
```bash
# Connect to PostgreSQL directly
docker-compose exec postgres psql -U dims_user -d dims_db

# Backup database
docker-compose exec postgres pg_dump -U dims_user dims_db > backup.sql

# Restore database
docker-compose exec -T postgres psql -U dims_user -d dims_db < backup.sql
```

### Rebuild Services
```bash
# Rebuild and restart all services
docker-compose up --build

# Rebuild specific service
docker-compose up --build dims_app
```

## Environment Variables

You can customize the setup by creating a `.env` file:

```env
# Database Configuration
POSTGRES_DB=dims_db
POSTGRES_USER=dims_user
POSTGRES_PASSWORD=your_secure_password

# pgAdmin Configuration
PGADMIN_DEFAULT_EMAIL=admin@yourdomain.com
PGADMIN_DEFAULT_PASSWORD=your_admin_password

# Application Configuration
APP_PORT=3000
POSTGRES_PORT=5432
PGADMIN_PORT=8080
REDIS_PORT=6379
```

## Development Workflow

### For Flutter Development
1. Make changes to your Flutter code
2. Rebuild the Docker image:
   ```bash
   docker-compose up --build dims_app
   ```

### For Database Development
1. Connect to pgAdmin at http://localhost:8080
2. Add a new server with these settings:
   - **Host**: postgres
   - **Port**: 5432
   - **Database**: dims_db
   - **Username**: dims_user
   - **Password**: dims_password

### For API Development
- The nginx configuration includes API proxy settings
- Update the `nginx.conf` file to point to your backend service
- Rebuild the application: `docker-compose up --build dims_app`

## Troubleshooting

### Common Issues

1. **Port conflicts**: If ports 3000, 5432, 6379, or 8080 are already in use:
   ```bash
   # Check what's using the port
   netstat -tulpn | grep :5432
   
   # Stop the conflicting service or change ports in docker-compose.yml
   ```

2. **Permission issues on Windows**:
   ```bash
   # Run Docker Desktop as Administrator
   # Or add your user to the Docker group
   ```

3. **Database connection issues**:
   ```bash
   # Check if PostgreSQL is running
   docker-compose ps
   
   # Check PostgreSQL logs
   docker-compose logs postgres
   ```

4. **Flutter build issues**:
   ```bash
   # Clean and rebuild
   docker-compose down
   docker-compose up --build --force-recreate
   ```

### Health Checks

Monitor service health:
```bash
# Check service status
docker-compose ps

# Check health status
docker inspect dims_postgres | grep Health -A 10
```

## Production Deployment

For production deployment:

1. **Update environment variables** with secure passwords
2. **Use external volumes** for data persistence
3. **Configure SSL/TLS** for secure connections
4. **Set up monitoring** and logging
5. **Use Docker Swarm or Kubernetes** for orchestration

## Support

For issues related to:
- **Docker setup**: Check Docker Desktop logs
- **Database**: Check PostgreSQL logs and pgAdmin
- **Application**: Check nginx logs in the container
- **Flutter**: Ensure all dependencies are properly installed

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Flutter Web Documentation](https://flutter.dev/web)
