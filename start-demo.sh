#!/bin/bash

# Ledger System OAuth 2.0 Demo Startup Script

echo "🚀 Starting Ledger System OAuth 2.0 Demo..."
echo "=========================================="

# Check if .env file exists
if [ ! -f .env ]; then
    echo "❌ Error: .env file not found!"
    echo "Please create a .env file with your database credentials."
    echo "You can copy from .env.example if available."
    exit 1
fi

# Build and start the application
echo "📦 Building and starting application..."
make all

# Wait for the application to be ready
echo "⏳ Waiting for application to start..."
sleep 10

# Check if application is running
if curl -s http://localhost:8080/api/public/health > /dev/null; then
    echo "✅ Application is running!"
    echo ""
    echo "🌐 Opening web interface..."
    echo "URL: http://localhost:8080"
    echo ""
    echo "📋 Demo Accounts:"
    echo "  👤 User: username=user, password=password"
    echo "  👑 Admin: username=admin, password=admin"
    echo ""
    echo "🔧 Available Features:"
    echo "  • OAuth 2.0 Authorization Flow"
    echo "  • Client Credentials Flow"
    echo "  • Role-based API Testing"
    echo "  • Real-time Authentication Status"
    echo ""
    
    # Try to open browser
    if command -v xdg-open > /dev/null; then
        xdg-open http://localhost:8080
    elif command -v open > /dev/null; then
        open http://localhost:8080
    elif command -v start > /dev/null; then
        start http://localhost:8080
    else
        echo "💡 Please open your browser and go to: http://localhost:8080"
    fi
    
    echo "🎉 Demo is ready! Press Ctrl+C to stop the application."
    
    # Keep the script running
    while true; do
        sleep 1
    done
    
else
    echo "❌ Application failed to start properly."
    echo "Check the logs for more information."
    exit 1
fi 