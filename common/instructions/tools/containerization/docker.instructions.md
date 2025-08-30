---
title: 'Docker Containerization Platform Instructions'
description: 'Comprehensive guide for Docker containerization, orchestration, and deployment including multi-stage builds, security, and production workflows'
category: 'Containerization'

tags:
  [
    'docker',
    'containers',
    'containerization',
    'devops',
    'deployment',
    'microservices',
    'orchestration',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/Dockerfile'
  - '**/docker-compose.yml'
  - '**/docker-compose.*.yml'
  - '**/.dockerignore'
  - '**/Dockerfile.*'
---

# Docker Containerization Platform Instructions

## Tool Overview

- **Tool Name**: Docker
- **Version**: 24.0+ (Latest stable with BuildKit and multi-platform support)
- **Category**: Containerization - Application Packaging and Deployment
- **Purpose**: Package applications into portable, lightweight containers for consistent deployment across any environment
- **Prerequisites**: Linux, macOS, or Windows with WSL2, basic understanding of application deployment

## When to Use Docker

### ✅ **Use Docker When**

- Building microservices architectures requiring isolation and scalability
- Need consistent development, testing, and production environments
- Deploying applications across different cloud platforms and environments
- Working with multiple programming languages and runtime versions
- Building CI/CD pipelines requiring reproducible builds
- Need to package legacy applications for modern deployment
- Working with distributed systems requiring service orchestration
- Building applications requiring horizontal scaling and load balancing

### ❌ **Avoid Docker When**

- Building simple static websites without complex dependencies
- Working with applications requiring specialized hardware or GPU access
- Team lacks containerization knowledge and DevOps expertise
- Building desktop applications requiring native OS integration
- Working with applications having strict performance requirements
- Need direct access to host system resources and peripherals
- Building applications with simple single-server deployment needs

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type               | Docker Recommendation                      | Configuration Priority         |
| -------------------------- | ------------------------------------------ | ------------------------------ |
| Microservices Architecture | ✅ **Essential** - Perfect fit             | High - Multi-service setup     |
| Web Application            | ✅ **Essential** - Environment consistency | High - Production optimization |
| API Service                | ✅ **Essential** - Scalable deployment     | High - Load balancing          |
| Database Application       | ✅ **Recommended** - Data persistence      | Medium - Volume management     |
| Desktop Application        | 🔄 **Consider** - Limited benefits         | Low - Native alternatives      |
| IoT/Edge Application       | ✅ **Recommended** - Edge deployment       | Medium - Resource constraints  |

### Complexity Assessment

| Factor              | Low Complexity          | Medium Complexity       | High Complexity           |
| ------------------- | ----------------------- | ----------------------- | ------------------------- |
| **Setup Time**      | 1 hour (single service) | 4 hours (multi-service) | 2 days (orchestration)    |
| **Services**        | Single container        | Multiple containers     | Full orchestration        |
| **Architecture**    | Monolithic application  | Multi-tier application  | Distributed microservices |
| **Data Management** | Stateless application   | Database integration    | Complex data workflows    |

## Installation & Setup

### Docker Engine Installation

```bash
# Ubuntu/Debian installation
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker

# CentOS/RHEL installation
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# macOS installation (Homebrew)
brew install --cask docker

# Verify installation
docker --version
docker compose version
docker buildx version

# Test Docker installation
docker run hello-world
```

### Docker Desktop Setup (Development)

```bash
# macOS/Windows Docker Desktop
# Download from https://www.docker.com/products/docker-desktop

# Configure Docker Desktop settings
# - Enable Kubernetes (optional)
# - Configure resource limits (CPU, Memory)
# - Enable experimental features
# - Configure file sharing directories

# Verify Docker Desktop
docker info
docker system df
docker system prune --help
```

### Development Environment Setup

```bash
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
```

## Configuration

### Production-Ready Dockerfile

```dockerfile
# Multi-stage Dockerfile for Node.js application
# Stage 1: Build environment
FROM node:18-alpine AS builder

# Security: Create non-root user
RUN addgroup -g 1001 -S nodejs &&
    adduser -S nextjs -u 1001

WORKDIR /app

# Copy package files for dependency installation
COPY package*.json ./
COPY yarn.lock* ./

# Install dependencies (including dev dependencies for build)
RUN npm ci --include=dev

# Copy source code
COPY . .

# Build application
RUN npm run build &&
    npm prune --omit=dev

# Stage 2: Production environment
FROM node:18-alpine AS runner

# Security: Install security updates
RUN apk update && apk upgrade &&
    apk add --no-cache dumb-init &&
    rm -rf /var/cache/apk/*

# Create non-root user
RUN addgroup -g 1001 -S nodejs &&
    adduser -S nextjs -u 1001

WORKDIR /app

# Set environment
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Copy built application from builder stage
COPY --from=builder --chown=nextjs:nodejs /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

# Switch to non-root user
USER nextjs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3
  CMD curl -f http://localhost:3000/api/health || exit 1

# Use dumb-init for proper signal handling
ENTRYPOINT ["dumb-init", "--"]

# Start application
CMD ["node", "server.js"]
```

### Advanced Multi-Service Docker Compose

```yaml
# docker-compose.yml - Production-ready multi-service setup
version: '3.8'

services:
  # Web Application
  web:
    build:
      context: .
      dockerfile: Dockerfile
      target: runner
      args:
        NODE_ENV: production
    image: myapp:${APP_VERSION:-latest}
    container_name: myapp-web
    restart: unless-stopped
    ports:
      - '3000:3000'
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://postgres:${POSTGRES_PASSWORD}@db:5432/${POSTGRES_DB}
      - REDIS_URL=redis://redis:6379
      - JWT_SECRET=${JWT_SECRET}
      - API_KEY=${API_KEY}
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    volumes:
      - app_uploads:/app/uploads
      - app_logs:/app/logs
    networks:
      - app_network
    healthcheck:
      test: ['CMD', 'curl', '-f', 'http://localhost:3000/api/health']
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    logging:
      driver: 'json-file'
      options:
        max-size: '10m'
        max-file: '3'
    security_opt:
      - no-new-privileges:true
    cap_drop:
      - ALL
    cap_add:
      - CHOWN
      - SETUID
      - SETGID

  # Database
  db:
    image: postgres:15-alpine
    container_name: myapp-db
    restart: unless-stopped
    environment:
      - POSTGRES_DB=${POSTGRES_DB:-myapp}
      - POSTGRES_USER=${POSTGRES_USER:-postgres}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
      - PGDATA=/var/lib/postgresql/data/pgdata
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./docker/postgres/init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    networks:
      - app_network
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U ${POSTGRES_USER:-postgres} -d ${POSTGRES_DB:-myapp}']
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
    security_opt:
      - no-new-privileges:true

  # Redis Cache
  redis:
    image: redis:7-alpine
    container_name: myapp-redis
    restart: unless-stopped
    command: redis-server --requirepass ${REDIS_PASSWORD} --appendonly yes
    volumes:
      - redis_data:/data
    networks:
      - app_network
    healthcheck:
      test: ['CMD', 'redis-cli', '--raw', 'incr', 'ping']
      interval: 10s
      timeout: 3s
      retries: 5
      start_period: 30s
    security_opt:
      - no-new-privileges:true

  # Nginx Reverse Proxy
  nginx:
    image: nginx:alpine
    container_name: myapp-nginx
    restart: unless-stopped
    ports:
      - '80:80'
      - '443:443'
    volumes:
      - ./docker/nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./docker/nginx/conf.d:/etc/nginx/conf.d:ro
      - ./docker/ssl:/etc/nginx/ssl:ro
      - nginx_logs:/var/log/nginx
    depends_on:
      - web
    networks:
      - app_network
    healthcheck:
      test: ['CMD', 'wget', '--quiet', '--tries=1', '--spider', 'http://localhost/health']
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 30s
    security_opt:
      - no-new-privileges:true

  # Background Worker
  worker:
    build:
      context: .
      dockerfile: Dockerfile.worker
    image: myapp-worker:${APP_VERSION:-latest}
    container_name: myapp-worker
    restart: unless-stopped
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://postgres:${POSTGRES_PASSWORD}@db:5432/${POSTGRES_DB}
      - REDIS_URL=redis://redis:6379
      - WORKER_CONCURRENCY=${WORKER_CONCURRENCY:-2}
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_healthy
    volumes:
      - app_uploads:/app/uploads
      - worker_logs:/app/logs
    networks:
      - app_network
    healthcheck:
      test: ['CMD', 'node', 'health-check.js']
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    security_opt:
      - no-new-privileges:true
    cap_drop:
      - ALL

# Networks
networks:
  app_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16

# Volumes
volumes:
  postgres_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: ./docker/data/postgres
  redis_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: ./docker/data/redis
  app_uploads:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: ./uploads
  app_logs:
    driver: local
  worker_logs:
    driver: local
  nginx_logs:
    driver: local
```

### Development Override Configuration

```yaml
# docker-compose.override.yml - Development environment
version: '3.8'

services:
  web:
    build:
      target: development
    environment:
      - NODE_ENV=development
      - DEBUG=app:*
    volumes:
      - .:/app:cached
      - /app/node_modules
      - /app/.next
    ports:
      - '3000:3000'
      - '9229:9229' # Node.js debugger
    command: npm run dev

  db:
    ports:
      - '5432:5432' # Expose for local access
    environment:
      - POSTGRES_DB=myapp_dev

  redis:
    ports:
      - '6379:6379' # Expose for local access

  # Development tools
  adminer:
    image: adminer:latest
    container_name: myapp-adminer
    restart: unless-stopped
    ports:
      - '8080:8080'
    depends_on:
      - db
    networks:
      - app_network

  # Redis GUI
  redis-commander:
    image: rediscommander/redis-commander:latest
    container_name: myapp-redis-commander
    restart: unless-stopped
    ports:
      - '8081:8081'
    environment:
      - REDIS_HOSTS=local:redis:6379
    depends_on:
      - redis
    networks:
      - app_network
```

### Advanced .dockerignore Configuration

```bash
# .dockerignore - Optimize build context
# Version control
.git
.gitignore
.gitattributes

# Dependencies
node_modules
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build artifacts
.next
dist
build
out

# Development files
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE and editor files
.vscode
.idea
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db

# Documentation
README.md
docs/
*.md

# Testing
coverage/
.nyc_output
.jest-cache

# Logs
logs
*.log

# Docker files (avoid recursive copying)
Dockerfile*
docker-compose*.yml
.dockerignore

# CI/CD
.github/
.gitlab-ci.yml
.travis.yml

# Temporary files
tmp/
temp/
*.tmp
*.temp

# Large files that shouldn't be in containers
*.zip
*.tar.gz
*.sql
*.dump
```

## Core Features

### Multi-Stage Builds

- **Purpose**: Optimize image size and separate build/runtime environments
- **Usage**: Reduce production image size and improve security
- **Example**:

```dockerfile
# Advanced multi-stage build for Go application
# Stage 1: Build environment with all tools
FROM golang:1.21-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git ca-certificates tzdata

# Create non-root user for final stage
RUN adduser -D -g '' appuser

WORKDIR /src

# Copy dependency files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download
RUN go mod verify

# Copy source code
COPY . .

# Build statically linked binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64
    go build -ldflags='-w -s -extldflags "-static"'
    -a -installsuffix cgo -o app ./cmd/server

# Stage 2: Minimal runtime environment
FROM scratch AS runner

# Copy time zone data
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

# Copy SSL certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy user account information
COPY --from=builder /etc/passwd /etc/passwd

# Copy built application
COPY --from=builder /src/app /app

# Use non-root user
USER appuser

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3
  CMD ["/app", "-health-check"]

# Run application
ENTRYPOINT ["/app"]
```

### Docker Compose Orchestration

- **Purpose**: Define and manage multi-container applications
- **Usage**: Coordinate services, networks, and volumes
- **Example**:

```yaml
# Production orchestration with monitoring
version: '3.8'

services:
  # Application services
  api:
    build:
      context: ./api
      dockerfile: Dockerfile
    image: myapp/api:${VERSION}
    restart: unless-stopped
    environment:
      - DATABASE_URL=${DATABASE_URL}
      - REDIS_URL=${REDIS_URL}
      - JWT_SECRET=${JWT_SECRET}
    healthcheck:
      test: ['CMD', 'curl', '-f', 'http://localhost:3000/health']
      interval: 30s
      timeout: 10s
      retries: 3
    deploy:
      replicas: 2
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
    networks:
      - app_tier
      - db_tier

  # Monitoring stack
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    restart: unless-stopped
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=200h'
      - '--web.enable-lifecycle'
    ports:
      - '9090:9090'
    networks:
      - monitoring

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    restart: unless-stopped
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASSWORD}
      - GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource
    volumes:
      - grafana_data:/var/lib/grafana
      - ./monitoring/grafana/provisioning:/etc/grafana/provisioning
    ports:
      - '3001:3000'
    networks:
      - monitoring
    depends_on:
      - prometheus

networks:
  app_tier:
    driver: bridge
  db_tier:
    driver: bridge
  monitoring:
    driver: bridge

volumes:
  prometheus_data:
  grafana_data:
```

### Container Security

- **Purpose**: Implement security best practices for containers
- **Usage**: Protect against vulnerabilities and runtime attacks
- **Example**:

```dockerfile
# Security-hardened Dockerfile
FROM node:18-alpine AS base

# Security: Update packages and remove package manager cache
RUN apk update && apk upgrade &&
    apk add --no-cache dumb-init &&
    rm -rf /var/cache/apk/*

# Security: Create non-root user with specific UID/GID
RUN addgroup -g 1001 -S nodejs &&
    adduser -S nextjs -u 1001 -G nodejs

# Security: Set secure file permissions
WORKDIR /app
CHOWN nextjs:nodejs /app

# Production stage
FROM base AS production

# Security: Copy files with proper ownership
COPY --chown=nextjs:nodejs package*.json ./
COPY --chown=nextjs:nodejs . .

# Security: Install dependencies and remove dev tools
RUN npm ci --only=production &&
    npm cache clean --force

# Security: Remove unnecessary packages
RUN apk del wget curl

# Security: Switch to non-root user
USER nextjs

# Security: Use read-only root filesystem
# Security: Drop all capabilities and add only necessary ones
# Security: Disable new privileges
```

```yaml
# docker-compose.yml with security configuration
version: '3.8'

services:
  app:
    build: .
    security_opt:
      - no-new-privileges:true
      - seccomp:unconfined
    cap_drop:
      - ALL
    cap_add:
      - CHOWN
      - SETUID
      - SETGID
    read_only: true
    tmpfs:
      - /tmp:noexec,nosuid,size=100m
      - /var/run:noexec,nosuid,size=50m
    volumes:
      - type: tmpfs
        target: /app/tmp
        tmpfs:
          size: 100m
    networks:
      - isolated_network
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
          pids: 100
        reservations:
          cpus: '0.25'
          memory: 256M

networks:
  isolated_network:
    driver: bridge
    internal: true
```

### Volume Management and Data Persistence

- **Purpose**: Manage data persistence and sharing between containers
- **Usage**: Store databases, uploads, and persistent application data
- **Example**:

```yaml
# Advanced volume management
version: '3.8'

services:
  database:
    image: postgres:15
    volumes:
      # Named volume for data persistence
      - postgres_data:/var/lib/postgresql/data
      # Bind mount for configuration
      - ./config/postgres.conf:/etc/postgresql/postgresql.conf:ro
      # Bind mount for initialization scripts
      - ./docker/postgres/init:/docker-entrypoint-initdb.d:ro
      # Tmpfs for temporary files
      - type: tmpfs
        target: /var/lib/postgresql/tmp
        tmpfs:
          size: 100m
    environment:
      - POSTGRES_DB=myapp
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
      - POSTGRES_CONFIG_FILE=/etc/postgresql/postgresql.conf

  app:
    build: .
    volumes:
      # Application uploads
      - app_uploads:/app/uploads
      # Application logs
      - app_logs:/app/logs
      # Configuration files
      - ./config/app.yml:/app/config/production.yml:ro
      # Development: source code mounting
      - .:/app:cached
      - /app/node_modules # Anonymous volume to prevent overwriting
    depends_on:
      - database

  backup:
    image: postgres:15
    volumes:
      - postgres_data:/var/lib/postgresql/data:ro
      - backup_data:/backup
    environment:
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
    command: |
      bash -c "
        while true; do
          pg_dump -h database -U postgres myapp > /backup/backup_$(date +%Y%m%d_%H%M%S).sql
          find /backup -name '*.sql' -mtime +7 -delete
          sleep 3600
        done
      "
    depends_on:
      - database

volumes:
  postgres_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /opt/myapp/data/postgres
  app_uploads:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /opt/myapp/uploads
  app_logs:
    external: true
    name: myapp_logs
  backup_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /opt/myapp/backups
```

## Common Commands

```bash
# Essential Docker commands
docker version                        # Show Docker version info
docker info                          # Display system-wide information
docker ps                            # List running containers
docker ps -a                         # List all containers
docker images                        # List images

# Container management
docker run -d --name myapp nginx     # Run container in background
docker start myapp                   # Start stopped container
docker stop myapp                    # Stop running container
docker restart myapp                 # Restart container
docker rm myapp                      # Remove container
docker exec -it myapp bash          # Execute command in running container

# Image management
docker build -t myapp:latest .       # Build image from Dockerfile
docker pull nginx:alpine             # Pull image from registry
docker push myregistry/myapp:latest  # Push image to registry
docker rmi myapp:latest              # Remove image
docker tag myapp:latest myapp:v1.0   # Tag image

# Docker Compose commands
docker compose up                    # Start services
docker compose up -d                 # Start services in background
docker compose down                  # Stop and remove services
docker compose build                 # Build services
docker compose logs -f               # Follow logs
docker compose exec web bash         # Execute command in service

# System maintenance
docker system df                     # Show disk usage
docker system prune                  # Remove unused data
docker system prune -a               # Remove all unused data
docker volume prune                  # Remove unused volumes
docker network prune                 # Remove unused networks

# Development and debugging
docker logs myapp                    # View container logs
docker logs -f myapp                 # Follow container logs
docker inspect myapp                 # Detailed container information
docker stats                        # Live resource usage statistics
docker top myapp                     # Running processes in container

# Registry operations
docker login                        # Login to Docker registry
docker logout                       # Logout from registry
docker search nginx                 # Search Docker Hub for images
docker history myapp:latest         # Show image history

# Advanced operations
docker commit myapp myapp:snapshot   # Create image from container
docker export myapp > myapp.tar      # Export container filesystem
docker import myapp.tar myapp:latest # Import container filesystem
docker save myapp:latest > myapp.tar # Save image to tar archive
docker load < myapp.tar              # Load image from tar archive
```

## Workflow Integration

### Development Workflow

1. **Local Development**: Use Docker Compose for local environment setup
2. **Code Changes**: Live reload with volume mounting for development
3. **Testing**: Run tests in isolated containers
4. **Building**: Multi-stage builds for optimized production images
5. **Deployment**: Container orchestration with Kubernetes or Docker Swarm
6. **Monitoring**: Container health checks and resource monitoring

### CI/CD Pipeline Integration

```yaml
# .github/workflows/docker-ci.yml
name: Docker CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Build test image
        uses: docker/build-push-action@v5
        with:
          context: .
          target: test
          load: true
          tags: ${{ env.IMAGE_NAME }}:test
          cache-from: type=gha
          cache-to: type=gha,mode=max

      - name: Run tests
        run: |
          docker run --rm 
            -v ${{ github.workspace }}/test-results:/app/test-results 
            ${{ env.IMAGE_NAME }}:test npm test

      - name: Run security scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: ${{ env.IMAGE_NAME }}:test
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload security scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'

  build-and-push:
    needs: test
    runs-on: ubuntu-latest
    if: github.event_name != 'pull_request'
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=sha,prefix={{branch}}-
            type=raw,value=latest,enable={{is_default_branch}}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          platforms: linux/amd64,linux/arm64
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max
          build-args: |
            VERSION=${{ github.sha }}
            BUILD_DATE=${{ github.event.head_commit.timestamp }}

  deploy:
    needs: build-and-push
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    environment: production
    steps:
      - name: Deploy to production
        run: |
          echo "Deploying ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }} to production"
          # Add deployment commands here
```

### Package.json Scripts Integration

```json
{
  "scripts": {
    "docker:build": "docker build -t myapp:latest .",
    "docker:build:dev": "docker build --target development -t myapp:dev .",
    "docker:run": "docker run -p 3000:3000 myapp:latest",
    "docker:run:dev": "docker run -p 3000:3000 -v $(pwd):/app myapp:dev",
    "docker:compose:up": "docker compose up -d",
    "docker:compose:down": "docker compose down",
    "docker:compose:logs": "docker compose logs -f",
    "docker:compose:build": "docker compose build",
    "docker:clean": "docker system prune -f",
    "docker:clean:all": "docker system prune -a -f",
    "docker:scan": "docker scan myapp:latest",
    "dev:start": "docker compose -f docker-compose.yml -f docker-compose.override.yml up",
    "prod:start": "docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d"
  }
}
```

## Best Practices

### ✅ **Image Optimization Best Practices**

- **Use multi-stage builds** - Separate build and runtime environments
- **Choose minimal base images** - Use Alpine or distroless images when possible
- **Layer caching optimization** - Order Dockerfile commands for maximum cache efficiency
- **Remove unnecessary packages** - Keep images lean and secure
- **Use .dockerignore** - Exclude unnecessary files from build context
- **Combine RUN commands** - Reduce image layers and size

### ✅ **Security Best Practices**

- **Run as non-root user** - Create and use dedicated application users
- **Use official images** - Trust verified base images from official repositories
- **Scan images for vulnerabilities** - Regular security scanning with tools like Trivy
- **Implement read-only filesystems** - Prevent runtime modifications
- **Use secrets management** - Never embed secrets in images
- **Apply security policies** - Use security contexts and capabilities

### ✅ **Production Deployment Best Practices**

- **Implement health checks** - Monitor container health and restart when needed
- **Set resource limits** - Prevent containers from consuming excessive resources
- **Use orchestration** - Deploy with Kubernetes or Docker Swarm for scaling
- **Implement logging strategy** - Centralized logging for monitoring and debugging
- **Plan for data persistence** - Use volumes and backup strategies
- **Monitor performance** - Track resource usage and application metrics

### ❌ **Common Pitfalls to Avoid**

- **Don't run as root** - Security risk and bad practice
- **Avoid large images** - Impacts deployment speed and storage costs
- **Don't embed secrets** - Use environment variables or secret management
- **Avoid single point of failure** - Design for redundancy and fault tolerance
- **Don't ignore resource limits** - Can cause resource starvation
- **Avoid tightly coupled containers** - Design for loose coupling and scalability

## Advanced Docker Usage

### Docker Swarm Orchestration

```yaml
# docker-stack.yml - Docker Swarm deployment
version: '3.8'

services:
  web:
    image: myapp:latest
    deploy:
      replicas: 3
      restart_policy:
        condition: on-failure
        delay: 5s
        max_attempts: 3
      update_config:
        parallelism: 1
        delay: 10s
        failure_action: rollback
      rollback_config:
        parallelism: 1
        delay: 5s
        failure_action: pause
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
      placement:
        constraints:
          - node.role == worker
          - node.labels.zone == frontend
    ports:
      - '80:3000'
    networks:
      - frontend
      - backend
    secrets:
      - jwt_secret
      - db_password
    configs:
      - source: app_config
        target: /app/config.yml

  database:
    image: postgres:15
    deploy:
      replicas: 1
      placement:
        constraints:
          - node.role == worker
          - node.labels.zone == database
      restart_policy:
        condition: on-failure
    environment:
      - POSTGRES_PASSWORD_FILE=/run/secrets/db_password
    volumes:
      - db_data:/var/lib/postgresql/data
    networks:
      - backend
    secrets:
      - db_password

networks:
  frontend:
    external: true
  backend:
    driver: overlay
    encrypted: true

volumes:
  db_data:
    driver: local

secrets:
  jwt_secret:
    external: true
  db_password:
    external: true

configs:
  app_config:
    external: true
```

### Container Monitoring and Observability

```yaml
# monitoring-stack.yml
version: '3.8'

services:
  # Application
  app:
    image: myapp:latest
    environment:
      - OTEL_EXPORTER_OTLP_ENDPOINT=http://jaeger:14268/api/traces
    networks:
      - app_network
      - monitoring

  # Metrics collection
  prometheus:
    image: prom/prometheus:latest
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus_data:/prometheus
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=200h'
      - '--web.enable-lifecycle'
      - '--web.enable-admin-api'
    ports:
      - '9090:9090'
    networks:
      - monitoring

  # Metrics visualization
  grafana:
    image: grafana/grafana:latest
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASSWORD}
      - GF_USERS_ALLOW_SIGN_UP=false
    volumes:
      - grafana_data:/var/lib/grafana
      - ./monitoring/grafana/provisioning:/etc/grafana/provisioning
      - ./monitoring/grafana/dashboards:/var/lib/grafana/dashboards
    ports:
      - '3001:3000'
    networks:
      - monitoring

  # Distributed tracing
  jaeger:
    image: jaegertracing/all-in-one:latest
    environment:
      - COLLECTOR_OTLP_ENABLED=true
    ports:
      - '16686:16686'
      - '14268:14268'
    networks:
      - monitoring

  # Log aggregation
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.8.0
    environment:
      - discovery.type=single-node
      - 'ES_JAVA_OPTS=-Xms512m -Xmx512m'
      - xpack.security.enabled=false
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data
    networks:
      - monitoring

  logstash:
    image: docker.elastic.co/logstash/logstash:8.8.0
    volumes:
      - ./monitoring/logstash/pipeline:/usr/share/logstash/pipeline:ro
      - ./monitoring/logstash/config:/usr/share/logstash/config:ro
    depends_on:
      - elasticsearch
    networks:
      - monitoring

  kibana:
    image: docker.elastic.co/kibana/kibana:8.8.0
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    ports:
      - '5601:5601'
    depends_on:
      - elasticsearch
    networks:
      - monitoring

networks:
  app_network:
    driver: bridge
  monitoring:
    driver: bridge

volumes:
  prometheus_data:
  grafana_data:
  elasticsearch_data:
```

## Integration with Other Tools

### Kubernetes Integration

```yaml
# k8s/deployment.yaml - Kubernetes deployment for Docker containers
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  labels:
    app: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: myapp
          image: myregistry/myapp:latest
          ports:
            - containerPort: 3000
          env:
            - name: NODE_ENV
              value: 'production'
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: database-url
          resources:
            requests:
              memory: '256Mi'
              cpu: '250m'
            limits:
              memory: '512Mi'
              cpu: '500m'
          livenessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 3000
            initialDelaySeconds: 5
            periodSeconds: 5
          securityContext:
            runAsNonRoot: true
            runAsUser: 1001
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop:
                - ALL
          volumeMounts:
            - name: tmp-volume
              mountPath: /tmp
            - name: app-config
              mountPath: /app/config
              readOnly: true
      volumes:
        - name: tmp-volume
          emptyDir: {}
        - name: app-config
          configMap:
            name: app-config
      imagePullSecrets:
        - name: registry-credentials
```

### Terraform Integration

```hcl
# terraform/docker.tf - Terraform configuration for Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Build Docker image
resource "docker_image" "app" {
  name = "myapp:${var.app_version}"
  build {
    context    = "../"
    dockerfile = "Dockerfile"
    build_args = {
      NODE_ENV = var.environment
      VERSION  = var.app_version
    }
  }
  keep_locally = false
}

# Create Docker network
resource "docker_network" "app_network" {
  name = "myapp-network"
  driver = "bridge"

  ipam_config {
    subnet  = "172.20.0.0/16"
    gateway = "172.20.0.1"
  }
}

# Database container
resource "docker_container" "database" {
  name  = "myapp-db"
  image = "postgres:15"

  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}"
  ]

  volumes {
    host_path      = "${path.cwd}/data/postgres"
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  restart = "unless-stopped"
}

# Application container
resource "docker_container" "app" {
  name  = "myapp"
  image = docker_image.app.image_id

  ports {
    internal = 3000
    external = 3000
  }

  env = [
    "NODE_ENV=${var.environment}",
    "DATABASE_URL=postgresql://${var.db_user}:${var.db_password}@${docker_container.database.name}:5432/${var.db_name}"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.database]
  restart    = "unless-stopped"

  healthcheck {
    test         = ["CMD", "curl", "-f", "http://localhost:3000/health"]
    interval     = "30s"
    timeout      = "10s"
    retries      = 3
    start_period = "40s"
  }
}

# Variables
variable "app_version" {
  description = "Application version"
  type        = string
  default     = "latest"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "myapp"
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# Outputs
output "app_url" {
  value = "http://localhost:3000"
}

output "container_id" {
  value = docker_container.app.id
}
```

## Troubleshooting

### Common Issues

#### Container Won't Start

**Problem**: Container exits immediately or fails to start
**Symptoms**: Container status shows "Exited (1)" or similar error codes
**Solution**:

```bash
# Check container logs
docker logs container_name
docker logs -f container_name  # Follow logs

# Check container configuration
docker inspect container_name

# Debug with interactive shell
docker run -it --entrypoint /bin/sh image_name

# Check resource constraints
docker stats container_name
docker system df
```

#### Build Failures

**Problem**: Docker build fails with errors
**Symptoms**: Build context errors, dependency installation failures
**Solution**:

```bash
# Clean build without cache
docker build --no-cache -t myapp .

# Check build context size
du -sh .
# Optimize with .dockerignore

# Debug build step by step
docker build --target builder -t myapp:debug .
docker run -it myapp:debug /bin/sh

# Check base image
docker pull node:18-alpine
docker run -it node:18-alpine /bin/sh
```

#### Performance Issues

**Problem**: Slow container performance or high resource usage
**Symptoms**: High CPU/memory usage, slow response times
**Solution**:

```bash
# Monitor resource usage
docker stats
docker system df

# Optimize Dockerfile
# Use multi-stage builds
# Minimize layers
# Use .dockerignore

# Set resource limits
docker run --memory=512m --cpus=0.5 myapp

# Check for memory leaks
docker exec container_name ps aux
docker exec container_name top
```

### Debug Mode

```bash
# Enable Docker debug mode
export DOCKER_DEBUG=1
dockerd --debug

# Verbose build output
docker build --progress=plain --no-cache .

# Container debugging
docker run -it --entrypoint /bin/sh myapp
docker exec -it running_container /bin/sh

# Network debugging
docker network ls
docker network inspect bridge
docker port container_name

# Volume debugging
docker volume ls
docker volume inspect volume_name
docker exec container_name df -h
```

### Performance Optimization

```dockerfile
# Optimized Dockerfile template
FROM node:18-alpine AS dependencies

# Install only production dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM node:18-alpine AS runner
WORKDIR /app

# Copy dependencies
COPY --from=dependencies /app/node_modules ./node_modules
# Copy built application
COPY --from=builder /app/dist ./dist
# Copy package.json for start script
COPY package*.json ./

# Create non-root user
RUN addgroup -g 1001 -S nodejs &&
    adduser -S nextjs -u 1001

USER nextjs

EXPOSE 3000
CMD ["npm", "start"]
```

## Security Considerations

### Security Best Practices

- **Use official base images** - Trust verified images from official repositories
- **Scan images regularly** - Use tools like Trivy, Clair, or Snyk for vulnerability scanning
- **Run as non-root** - Create dedicated users with minimal privileges
- **Implement network segmentation** - Use custom networks and limit container communication
- **Use secrets management** - Never embed secrets in images or environment variables
- **Apply security policies** - Use Docker Bench for Security and CIS benchmarks

### Secure Configuration Examples

```dockerfile
# Security-hardened production Dockerfile
FROM node:18-alpine AS base

# Security: Install security updates
RUN apk update && apk upgrade &&
    apk add --no-cache dumb-init &&
    rm -rf /var/cache/apk/*

# Security: Create non-root user
RUN addgroup -g 1001 -S appgroup &&
    adduser -S appuser -u 1001 -G appgroup

FROM base AS production

WORKDIR /app

# Security: Copy with proper ownership
COPY --chown=appuser:appgroup package*.json ./
RUN npm ci --only=production &&
    npm cache clean --force

COPY --chown=appuser:appgroup . .

# Security: Remove unnecessary packages
RUN apk del wget curl &&
    rm -rf /var/cache/apk/*

# Security: Set file permissions
RUN chmod -R 755 /app &&
    chmod -R 644 /app/package*.json

# Security: Switch to non-root user
USER appuser

# Security: Use dumb-init for signal handling
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "index.js"]
```

```yaml
# docker-compose.yml with security hardening
version: '3.8'

services:
  app:
    build: .
    security_opt:
      - no-new-privileges:true
      - seccomp:unconfined
    cap_drop:
      - ALL
    cap_add:
      - CHOWN
      - SETUID
      - SETGID
    read_only: true
    tmpfs:
      - /tmp:noexec,nosuid,size=100m
    networks:
      - isolated_network
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
          pids: 100
    healthcheck:
      test: ['CMD', 'wget', '--no-verbose', '--tries=1', '--spider', 'http://localhost:3000/health']
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

networks:
  isolated_network:
    driver: bridge
    internal: true
```

## AI Assistant Guidelines

When helping with Docker:

1. **Always suggest multi-stage builds** for production applications to optimize image size
2. **Provide complete orchestration examples** with Docker Compose for multi-service applications
3. **Include security best practices** with non-root users, vulnerability scanning, and secure configurations
4. **Suggest appropriate base images** based on the application stack and security requirements
5. **Provide debugging strategies** for common container and build issues
6. **Include monitoring and logging** configurations for production deployments
7. **Reference performance optimization** techniques for efficient container operations
8. **Suggest orchestration solutions** like Kubernetes or Docker Swarm for scalable deployments

### Code Generation Rules

- Generate multi-stage Dockerfiles with optimization and security best practices
- Include proper health checks and resource limits in container configurations
- Provide comprehensive Docker Compose files with networks, volumes, and dependencies
- Follow security best practices with non-root users and minimal privileges
- Include proper error handling and logging configurations
- Generate CI/CD pipeline examples with automated testing and deployment
- Provide monitoring and observability configurations for production environments
- Include backup and disaster recovery strategies for containerized applications

### .dockerignore

```
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.nyc_output
coverage
.vscode
.idea
```

### docker-compose.yml

```yaml
version: '3.8'

services:
  app:
    build: .
    ports:
      - '3000:3000'
    environment:
      - NODE_ENV=production
    volumes:
      - ./logs:/app/logs
    depends_on:
      - db

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - '5432:5432'

volumes:
  postgres_data:
```

## Core Features

### Container Management

- **Purpose**: Create, run, and manage application containers
- **Usage**: Isolate applications with their dependencies
- **Example**:

```bash
docker run -d -p 3000:3000 --name myapp myapp:latest
```

### Image Building

- **Purpose**: Create reusable container images
- **Usage**: Package applications for deployment
- **Example**:

```bash
docker build -t myapp:latest .
docker build -t myapp:v1.2.3 --build-arg NODE_ENV=production .
```

### Multi-stage Builds

- **Purpose**: Optimize image size and security
- **Usage**: Separate build and runtime environments
- **Example**:

```dockerfile
# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Runtime stage
FROM node:18-alpine AS runtime
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

## Common Commands

```bash
# Essential daily commands
docker ps                              # List running containers
docker images                          # List available images
docker logs <container-id>             # View container logs
docker exec -it <container-id> /bin/sh # Access container shell

# Advanced operations
docker system prune                    # Clean up unused resources
docker build --no-cache -t app:latest . # Build without cache
docker run --rm -it app:latest /bin/sh  # Run temporary interactive container
```

## Workflow Integration

### Development Workflow

1. **Setup**: Create Dockerfile and docker-compose.yml
2. **Development**: Use docker-compose for local development
3. **Testing**: Run tests in containers for consistency
4. **Pre-commit**: Build and test images before committing
5. **CI/CD**: Build and push images in CI pipeline

### Automation Scripts

```json
{
  "scripts": {
    "docker:build": "docker build -t myapp:latest .",
    "docker:run": "docker-compose up",
    "docker:test": "docker-compose -f docker-compose.test.yml up --abort-on-container-exit",
    "docker:clean": "docker system prune -f"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
docker build -t myapp:test . && docker run --rm myapp:test npm test
```

## Best Practices

### Configuration Best Practices

- Use multi-stage builds to reduce image size
- Run containers as non-root users for security
- Use specific image tags instead of 'latest' in production
- Keep images small by minimizing layers and removing unnecessary files

### Usage Patterns

- Use .dockerignore to exclude unnecessary files from build context
- Leverage Docker layer caching for faster builds
- Use environment variables for configuration instead of hardcoding values

### Performance Optimization

- Use Alpine Linux base images for smaller size
- Combine RUN commands to reduce layers
- Use BuildKit for improved build performance

## Common Use Cases

### Web Application Deployment

**Scenario**: Deploy a Node.js web application with database
**Implementation**:

```bash
docker-compose up -d
docker-compose logs -f app
```

**Expected Result**: Application running on specified port with database connection

### Development Environment

**Scenario**: Consistent development environment across team
**Implementation**:

```bash
docker-compose -f docker-compose.dev.yml up
docker-compose exec app npm run dev
```

**Expected Result**: Hot-reloaded development server with all dependencies

### Testing Pipeline

**Scenario**: Run tests in isolated environment
**Implementation**:

```bash
docker build -t myapp:test --target test .
docker run --rm myapp:test
```

**Expected Result**: All tests pass in clean environment

## Integration with Other Tools

### Kubernetes

- **Integration Purpose**: Deploy Docker images to Kubernetes clusters
- **Setup**: Create Kubernetes manifests referencing Docker images
- **Usage**: Use kubectl to deploy containerized applications

### CI/CD Pipelines

- **Integration Purpose**: Automate building and deployment of images
- **Setup**: Configure pipeline to build, test, and push images
- **Usage**: Trigger builds on code changes

## Troubleshooting

### Common Issues

#### Container Won't Start

**Problem**: Container exits immediately after starting
**Symptoms**: Container shows "Exited (1)" status
**Solution**: Check logs with `docker logs <container>` and fix application errors

#### Port Already in Use

**Problem**: Cannot bind to port (port already allocated)
**Symptoms**: Error message about port binding
**Solution**: Stop conflicting services or use different port mapping

#### Out of Disk Space

**Problem**: No space left on device
**Symptoms**: Build failures or container start failures
**Solution**: Run `docker system prune -a` to clean up unused resources

### Debug Mode

```bash
# Enable verbose/debug output
docker build --progress=plain --no-cache .
docker run --rm -it --entrypoint=/bin/sh myapp:latest

# Log analysis
docker logs --details <container>
docker inspect <container>
```

### Performance Issues

- Monitor resource usage with `docker stats`
- Limit container resources with `--memory` and `--cpus` flags
- Use health checks to monitor container health

## Security Considerations

### Security Best Practices

- Never store secrets in images or environment variables
- Use official base images from trusted sources
- Regularly update base images for security patches

### Sensitive Data Handling

- Use Docker secrets or external secret management
- Mount sensitive files as volumes instead of copying into images
- Use multi-stage builds to avoid including build-time secrets

### Network Security

- Use custom networks instead of default bridge
- Limit exposed ports to only what's necessary
- Use reverse proxies for external access

## Advanced Configuration

### Docker Buildx

```bash
# Multi-platform builds
docker buildx create --name multiarch
docker buildx use multiarch
docker buildx build --platform linux/amd64,linux/arm64 -t myapp:latest .
```

### Health Checks

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
```

### Resource Limits

```yaml
services:
  app:
    image: myapp:latest
    deploy:
      resources:
        limits:
          memory: 512M
          cpus: '0.5'
        reservations:
          memory: 256M
          cpus: '0.25'
```

## Version Management

### Version Compatibility

- **Docker Engine**: 20.10+
- **Docker Compose**: 2.0+
- **OS Support**: Linux, macOS, Windows 10/11

### Migration Guides

- **From Docker Compose v1**: Update to v2 syntax and commands
- **Breaking Changes**: Review changelog for version-specific changes
- **Deprecation Notices**: Monitor for deprecated features

## Useful Resources

- **Official Documentation**: https://docs.docker.com/
- **Docker Hub**: https://hub.docker.com/
- **Best Practices Guide**: https://docs.docker.com/develop/dev-best-practices/
- **Security Guidelines**: https://docs.docker.com/engine/security/
- **Community Forum**: https://forums.docker.com/

## AI Assistant Guidelines

When helping with Docker:

1. **Always suggest the most current stable version**
2. **Provide working Dockerfile and docker-compose examples**
3. **Include security considerations in configurations**
4. **Mention resource limits and optimization opportunities**
5. **Suggest multi-stage builds for production images**
6. **Provide troubleshooting steps for common issues**
7. **Include health checks and monitoring guidance**
8. **Reference official documentation and best practices**

### Code Generation Rules

- Generate Dockerfiles that follow best practices
- Include comments explaining important steps
- Use specific image tags instead of 'latest'
- Include security measures like non-root users
- Follow the project's existing patterns and conventions
- Provide both development and production configurations
