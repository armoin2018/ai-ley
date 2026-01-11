#!/bin/bash
# scripts/dev.sh - Development helper script

set -e

# Load environment variables
if [ -f .env.local ]; then
    export $(cat .env.local | xargs)
fi

# Function to clean up
cleanup() {
    echo "Stopping development environment..."
    docker compose down
}
trap cleanup EXIT

# Start development environment
echo "Starting development environment..."
docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build