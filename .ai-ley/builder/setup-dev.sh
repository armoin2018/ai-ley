#!/bin/bash

# AI-LEY Workflow Builder - Development Setup Script
echo "🚀 Setting up AI-LEY Workflow Builder..."

# Check Node.js version
echo "📋 Checking prerequisites..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js >= 18.0.0"
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2)
REQUIRED_VERSION="18.0.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$NODE_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
    echo "❌ Node.js version $NODE_VERSION is too old. Please install >= $REQUIRED_VERSION"
    exit 1
fi

echo "✅ Node.js version: $NODE_VERSION"

# Check npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed"
    exit 1
fi

NPM_VERSION=$(npm --version)
echo "✅ npm version: $NPM_VERSION"

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo "✅ Dependencies installed successfully"

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p ../shared/uml-flows/user
mkdir -p ../shared/uml-flows/backups
mkdir -p public/exports

echo "✅ Directory structure created"

# Create .env.local if it doesn't exist
if [ ! -f .env.local ]; then
    echo "🔧 Creating environment configuration..."
    cat > .env.local << EOF
# AI-LEY Workflow Builder Configuration

# API Configuration
NEXT_PUBLIC_API_URL=http://localhost:3000/api
PLANTUML_SERVER_URL=https://www.plantuml.com

# Execution Settings
WORKFLOW_TIMEOUT=300000
MAX_CONCURRENT_STEPS=5

# Storage Configuration
WORKFLOW_STORAGE_PATH=../.ai-ley/shared/uml-flows

# Development Settings
NODE_ENV=development
NEXT_PUBLIC_ENABLE_DEBUG=true
EOF
    echo "✅ Environment configuration created"
else
    echo "✅ Environment configuration already exists"
fi

# Start development server
echo "🌟 Starting development server..."
echo ""
echo "🎉 Setup complete! Your workflow builder is starting..."
echo "📋 Open your browser to: http://localhost:3000"
echo "📚 Documentation: README.md"
echo "🛠  Component Palette: Left sidebar"
echo "🎨 Design Mode: Default view"
echo "👀 Preview Mode: Switch to see PlantUML"
echo "▶️  Execute Mode: Run your workflows"
echo ""

# Open browser (optional)
if command -v open &> /dev/null; then
    echo "🌐 Opening browser..."
    sleep 3 && open http://localhost:3000 &
elif command -v xdg-open &> /dev/null; then
    echo "🌐 Opening browser..."
    sleep 3 && xdg-open http://localhost:3000 &
fi

# Start the development server
npm run dev
