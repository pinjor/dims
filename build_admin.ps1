Write-Host "🚀 Building DIMS Admin Web App..." -ForegroundColor Green

# Build the admin web app
docker-compose up -d --build admin_app

Write-Host "✅ Admin app built successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "🌐 Admin Panel Access:" -ForegroundColor Cyan
Write-Host "   URL: http://localhost:3001" -ForegroundColor Yellow
Write-Host "   Username: admin" -ForegroundColor Yellow
Write-Host "   Password: admin123" -ForegroundColor Yellow
Write-Host ""
Write-Host "📱 Main App Access:" -ForegroundColor Cyan
Write-Host "   URL: http://localhost:3000" -ForegroundColor Yellow
Write-Host ""
Write-Host "🔧 Backend API:" -ForegroundColor Cyan
Write-Host "   URL: http://localhost:8000" -ForegroundColor Yellow
Write-Host "   Docs: http://localhost:8000/docs" -ForegroundColor Yellow
Write-Host ""
Write-Host "🗄️  Database Admin:" -ForegroundColor Cyan
Write-Host "   URL: http://localhost:8080" -ForegroundColor Yellow
Write-Host "   Email: admin@dims.com" -ForegroundColor Yellow
Write-Host "   Password: admin123" -ForegroundColor Yellow
