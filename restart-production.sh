#!/bin/bash

echo "🔄 Restarting PEP Score Nexus in Production Mode..."

# Kill existing processes
echo "🛑 Stopping existing services..."
pkill -f "node.*server.js" 2>/dev/null || true  
pkill -f "vite" 2>/dev/null || true
pkill -f "npm.*start" 2>/dev/null || true
pkill -f "npm.*dev" 2>/dev/null || true

# Wait for processes to stop
sleep 3

# Navigate to project root
cd "$(dirname "$0")"

echo "🏗️  Building frontend for production..."
cd frontend

# Set production environment
export NODE_ENV=production
export VITE_NODE_ENV=production

# Build frontend
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Frontend build failed!"
    exit 1
fi

echo "✅ Frontend build completed successfully!"

# Start backend in production mode
echo "🚀 Starting backend in production mode..."
cd ../backend

# Set production environment
export NODE_ENV=production

# Start backend
npm start &
BACKEND_PID=$!

echo "Backend started with PID: $BACKEND_PID"

# Wait a moment for backend to start
sleep 5

# Start frontend in production mode (preview)
echo "🌐 Starting frontend production server..."
cd ../frontend

# Start production preview server
npm run preview &
FRONTEND_PID=$!

echo "Frontend preview started with PID: $FRONTEND_PID"

echo ""
echo "🎉 Services started successfully!"
echo "📱 Frontend: http://localhost:8080 (production build)"
echo "🔧 Backend: http://localhost:3001"
echo ""
echo "Backend PID: $BACKEND_PID"
echo "Frontend PID: $FRONTEND_PID"
echo ""
echo "To stop services:"
echo "  kill $BACKEND_PID $FRONTEND_PID"
echo "  OR run: pkill -f 'node.*server.js' && pkill -f 'vite'"


