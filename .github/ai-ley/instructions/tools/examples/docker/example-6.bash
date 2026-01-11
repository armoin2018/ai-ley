# Create project Docker configuration
mkdir -p myproject/{docker,scripts}
cd myproject

# Initialize Docker files
touch Dockerfile
touch docker-compose.yml
touch docker-compose.override.yml
touch .dockerignore
touch docker-compose.prod.yml

# Create development scripts
cat > scripts/dev-setup.sh << 'EOF'
#!/bin/bash
set -e

echo "Setting up development environment..."
docker compose build
docker compose up -d
docker compose logs -f
EOF

chmod +x scripts/dev-setup.sh