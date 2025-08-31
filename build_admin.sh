#!/bin/bash

echo "🚀 Building DIMS Admin Web App..."

# Build the admin web app
docker-compose up -d --build admin_app

echo "✅ Admin app built successfully!"
echo ""
echo "🌐 Admin Panel Access:"
echo "   URL: http://localhost:3001"
echo "   Username: admin"
echo "   Password: admin123"
echo ""
echo "📱 Main App Access:"
echo "   URL: http://localhost:3000"
echo ""
echo "🔧 Backend API:"
echo "   URL: http://localhost:8000"
echo "   Docs: http://localhost:8000/docs"
echo ""
echo "🗄️  Database Admin:"
echo "   URL: http://localhost:8080"
echo "   Email: admin@dims.com"
echo "   Password: admin123"
