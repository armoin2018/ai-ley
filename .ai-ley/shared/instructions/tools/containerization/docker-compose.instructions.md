# Docker Compose Instructions

## Tool Overview
- **Tool Name**: Docker Compose
- **Version**: 2.0+ (Compose specification)
- **Category**: Container Orchestration, Development Environment
- **Purpose**: Define and run multi-container Docker applications with declarative YAML configuration
- **Prerequisites**: Docker Engine 20.10+, Docker Compose Plugin or standalone binary

## Installation & Setup
### Package Manager Installation
```bash
# Docker Desktop (includes Compose)
# macOS
brew install --cask docker

# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Compose plugin (if not included)
sudo apt-get update
sudo apt-get install docker-compose-plugin

# Verify installation
docker compose version
```

### Project Integration
```bash
# Initialize new project with docker-compose.yml
mkdir my-app && cd my-app
touch docker-compose.yml
touch .dockerignore
touch .env

# Basic project structure
mkdir -p {src,config,data,scripts}
```

## Configuration

### Basic Docker Compose File Structure
```yaml
# docker-compose.yml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
    volumes:
      - .:/app
      - /app/node_modules
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

volumes:
  postgres_data:
  redis_data:

networks:
  default:
    name: myapp_network
```

### Environment Variables
```bash
# .env file for development
NODE_ENV=development
API_PORT=3000
DATABASE_URL=postgresql://user:password@db:5432/myapp
REDIS_URL=redis://redis:6379

# Production secrets (use external secret management)
DB_PASSWORD_FILE=/run/secrets/db_password
API_SECRET_KEY_FILE=/run/secrets/api_key
```

### Multi-Environment Configuration
```yaml
# docker-compose.override.yml (development)
version: '3.8'

services:
  web:
    build:
      target: development
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - DEBUG=*
    command: npm run dev

  db:
    ports:
      - "5432:5432"  # Expose for local debugging
```

```yaml
# docker-compose.prod.yml (production)
version: '3.8'

services:
  web:
    build:
      target: production
    restart: unless-stopped
    environment:
      - NODE_ENV=production
    deploy:
      replicas: 2
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M

  db:
    restart: unless-stopped
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M
```

## Core Features

### Service Definition and Management
```yaml
# Comprehensive service configuration
services:
  api:
    build:
      context: .
      dockerfile: Dockerfile
      target: production
      args:
        NODE_VERSION: 18
        BUILD_DATE: ${BUILD_DATE}
    image: myapp/api:${TAG:-latest}
    container_name: myapp_api
    hostname: api
    restart: unless-stopped
    
    # Resource limits
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
        reservations:
          cpus: '0.25'
          memory: 256M
    
    # Health check
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s
    
    # Environment and secrets
    environment:
      - NODE_ENV=production
      - API_VERSION=${API_VERSION}
    env_file:
      - .env
      - .env.local
    secrets:
      - db_password
      - api_key
    
    # Networking
    ports:
      - "3000:3000"
      - "9229:9229"  # Debug port
    expose:
      - "3000"
    networks:
      - frontend
      - backend
    
    # Storage
    volumes:
      - ./logs:/app/logs
      - uploads:/app/uploads
    tmpfs:
      - /tmp
    
    # Dependencies
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
    
    # Process management
    init: true
    stop_grace_period: 30s
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.api.rule=Host(`api.localhost`)"
```

### Volume Management
```yaml
# Volume types and configurations
volumes:
  # Named volume for persistent data
  postgres_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /opt/myapp/data/postgres

  # External volume (created separately)
  shared_data:
    external: true
    name: myapp_shared_data

  # NFS volume for distributed storage
  nfs_storage:
    driver: local
    driver_opts:
      type: nfs
      o: addr=nfs-server.local,rw
      device: ":/path/to/share"

services:
  web:
    volumes:
      # Bind mount (development)
      - .:/app

      # Named volume mount
      - postgres_data:/var/lib/postgresql/data

      # Anonymous volume
      - /app/node_modules

      # Read-only mount
      - ./config:/app/config:ro

      # Delegated mount (macOS performance)
      - .:/app:delegated

      # Cached mount (macOS performance)
      - ./node_modules:/app/node_modules:cached
```

### Network Configuration
```yaml
# Custom networks
networks:
  frontend:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16

  backend:
    driver: bridge
    internal: true  # No external access

  external_network:
    external: true
    name: shared_network

services:
  web:
    networks:
      frontend:
        ipv4_address: 172.20.0.10
      backend:
        aliases:
          - web-server
          - api-server

  nginx:
    networks:
      - frontend
    ports:
      - "80:80"
      - "443:443"
```

## Common Commands

### Basic Operations
```bash
# Start services
docker compose up                    # Foreground
docker compose up -d                 # Background (detached)
docker compose up --build            # Rebuild images
docker compose up web db             # Start specific services

# Stop services
docker compose down                  # Stop and remove containers
docker compose down -v              # Also remove volumes
docker compose down --rmi all       # Also remove images
docker compose stop                 # Stop without removing

# View status and logs
docker compose ps                    # List running services
docker compose logs                 # View all logs
docker compose logs -f web          # Follow logs for web service
docker compose top                  # Show running processes

# Service management
docker compose start web            # Start specific service
docker compose stop web             # Stop specific service
docker compose restart web          # Restart specific service
docker compose pause web            # Pause service
docker compose unpause web          # Unpause service
```

### Development Commands
```bash
# Execute commands in running containers
docker compose exec web bash                    # Interactive shell
docker compose exec web npm test               # Run tests
docker compose exec -u root web apt update     # Run as root user

# Run one-off commands
docker compose run web npm install             # Install dependencies
docker compose run --rm web npm test          # Run and remove container
docker compose run -p 3001:3000 web npm start # Custom port mapping

# Debugging and inspection
docker compose config                          # Validate and view configuration
docker compose images                          # List images
docker compose port web 3000                  # Show port mapping
docker compose events                          # Show real-time events
```

### Production Commands
```bash
# Production deployment
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
docker compose --profile production up -d

# Scaling services
docker compose up -d --scale web=3            # Scale web service to 3 instances

# Health checks and monitoring
docker compose ps --format table              # Formatted service status
watch docker compose ps                       # Monitor services

# Backup and restore
docker compose exec db pg_dump -U user myapp > backup.sql
docker compose exec -T db psql -U user myapp < backup.sql
```

## Workflow Integration

### Development Workflow
```yaml
# docker-compose.dev.yml - Development optimized
version: '3.8'

services:
  web:
    build:
      context: .
      target: development
    volumes:
      - .:/app
      - /app/node_modules
      - /app/.next        # Next.js cache
    environment:
      - NODE_ENV=development
      - CHOKIDAR_USEPOLLING=true  # File watching in containers
    command: npm run dev
    stdin_open: true      # Interactive mode
    tty: true            # Allocate TTY

  test:
    build:
      context: .
      target: test
    volumes:
      - .:/app
    environment:
      - NODE_ENV=test
    command: npm run test:watch
    profiles:
      - testing

# Usage: docker compose -f docker-compose.yml -f docker-compose.dev.yml up
```

### CI/CD Integration
```yaml
# .github/workflows/docker.yml
name: Docker Build and Test

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Create environment file
        run: |
          cat << EOF > .env
          NODE_ENV=test
          DATABASE_URL=postgresql://test:test@db:5432/testdb
          EOF
      
      - name: Run tests with Docker Compose
        run: |
          docker compose -f docker-compose.yml -f docker-compose.test.yml up --build --abort-on-container-exit
          docker compose down -v
      
      - name: Build production image
        run: |
          docker compose -f docker-compose.prod.yml build
          docker compose -f docker-compose.prod.yml config
```

### Local Development Scripts
```bash
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
```

## Best Practices

### Configuration Best Practices
```yaml
# Follow semantic versioning for compose file version
version: '3.8'

# Use consistent naming conventions
services:
  my-app-web:      # Use hyphens, not underscores
    container_name: myapp_web  # Container names can use underscores

# Organize services logically
services:
  # Frontend services
  nginx:
  web:
  
  # Backend services  
  api:
  worker:
  
  # Data services
  db:
  redis:
  elasticsearch:

# Use profiles for optional services
services:
  monitoring:
    profiles:
      - monitoring
      - production
```

### Security Best Practices
```yaml
services:
  web:
    # Don't run as root
    user: "${UID:-1000}:${GID:-1000}"
    
    # Read-only root filesystem
    read_only: true
    tmpfs:
      - /tmp
      - /var/cache
    
    # Drop capabilities
    cap_drop:
      - ALL
    cap_add:
      - CHOWN
      - SETUID
      - SETGID
    
    # Use secrets for sensitive data
    secrets:
      - db_password
      - api_key
    
    # Limit resources
    deploy:
      resources:
        limits:
          cpus: '0.50'
          memory: 512M
    
    # Security options
    security_opt:
      - no-new-privileges:true

secrets:
  db_password:
    file: ./secrets/db_password.txt
  api_key:
    external: true
    name: myapp_api_key
```

### Performance Optimization
```yaml
services:
  web:
    # Optimize for development
    volumes:
      - .:/app:cached           # macOS: cached for better performance
      - /app/node_modules       # Anonymous volume for dependencies
    
    # Shared memory for applications that need it
    shm_size: 1gb
    
    # Use init system for proper signal handling
    init: true
    
    # Optimize stop time
    stop_grace_period: 30s
    
    # Health checks for orchestration
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 60s

# Use BuildKit for faster builds
x-build-args: &build-args
  BUILDKIT_INLINE_CACHE: 1

services:
  web:
    build:
      context: .
      args:
        <<: *build-args
```

## Common Use Cases

### Use Case 1: Full-Stack Web Application
**Scenario**: Multi-tier application with frontend, API, database, and caching
**Implementation**:
```yaml
version: '3.8'

services:
  # Reverse proxy and SSL termination
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - frontend
      - api

  # Frontend application
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile.prod
    expose:
      - "3000"
    environment:
      - REACT_APP_API_URL=http://api:4000
    depends_on:
      - api

  # Backend API
  api:
    build:
      context: ./backend
    expose:
      - "4000"
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/app
      - REDIS_URL=redis://redis:6379
    depends_on:
      db:
        condition: service_healthy
      redis:
        condition: service_started
    volumes:
      - ./uploads:/app/uploads

  # Database
  db:
    image: postgres:15
    environment:
      POSTGRES_DB: app
      POSTGRES_USER: user
      POSTGRES_PASSWORD: pass
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql:ro
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user -d app"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Cache and session store
  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data
    command: redis-server --appendonly yes

volumes:
  postgres_data:
  redis_data:
```
**Expected Result**: Complete web application stack with proper service dependencies

### Use Case 2: Microservices Development Environment
**Scenario**: Multiple independent services with service discovery and monitoring
**Implementation**:
```yaml
version: '3.8'

services:
  # Service discovery
  consul:
    image: consul:latest
    ports:
      - "8500:8500"
    command: consul agent -server -ui -client=0.0.0.0 -bootstrap-expect=1

  # API Gateway
  traefik:
    image: traefik:v2.9
    command:
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--entrypoints.web.address=:80"
    ports:
      - "80:80"
      - "8080:8080"  # Traefik dashboard
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock

  # User service
  user-service:
    build: ./services/user
    labels:
      - "traefik.http.routers.users.rule=PathPrefix(`/api/users`)"
    environment:
      - SERVICE_NAME=user-service
      - CONSUL_URL=consul:8500

  # Order service
  order-service:
    build: ./services/order
    labels:
      - "traefik.http.routers.orders.rule=PathPrefix(`/api/orders`)"
    environment:
      - SERVICE_NAME=order-service
      - CONSUL_URL=consul:8500

  # Monitoring
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
```
**Expected Result**: Microservices environment with routing, discovery, and monitoring

### Use Case 3: Database Development and Testing
**Scenario**: Multiple database systems for development and testing
**Implementation**:
```yaml
version: '3.8'

services:
  # PostgreSQL for main application
  postgres:
    image: postgres:15
    environment:
      POSTGRES_MULTIPLE_DATABASES: app,test,analytics
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: dev
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./scripts/create-multiple-postgresql-databases.sh:/docker-entrypoint-initdb.d/create-multiple-postgresql-databases.sh

  # MySQL for legacy compatibility
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: legacy
      MYSQL_USER: dev
      MYSQL_PASSWORD: dev
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql

  # MongoDB for document storage
  mongo:
    image: mongo:6.0
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: root
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db

  # Redis for caching and sessions
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  # Elasticsearch for search and analytics
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:8.6.0
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
    ports:
      - "9200:9200"
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data

  # Database management tools
  adminer:
    image: adminer:latest
    ports:
      - "8080:8080"
    depends_on:
      - postgres
      - mysql

volumes:
  postgres_data:
  mysql_data:
  mongo_data:
  redis_data:
  elasticsearch_data:
```
**Expected Result**: Complete database development environment with management tools

## Integration with Other Tools

### Docker Integration
```dockerfile
# Multi-stage Dockerfile optimized for Compose
FROM node:18-alpine AS base
WORKDIR /app
COPY package*.json ./

FROM base AS dependencies
RUN npm ci --only=production && npm cache clean --force

FROM base AS development
RUN npm ci
COPY . .
CMD ["npm", "run", "dev"]

FROM dependencies AS production
COPY . .
RUN npm run build
USER node
CMD ["npm", "start"]
```

### Kubernetes Migration
```yaml
# docker-compose.k8s.yml - Kubernetes-ready configuration
version: '3.8'

services:
  web:
    image: myapp/web:${TAG}
    deploy:
      replicas: 3
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M
      restart_policy:
        condition: any
        delay: 5s
        max_attempts: 3
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    networks:
      - web-tier
    configs:
      - source: app_config
        target: /app/config.json
    secrets:
      - api_key

configs:
  app_config:
    external: true

secrets:
  api_key:
    external: true

networks:
  web-tier:
    driver: overlay
```

## Troubleshooting

### Common Issues
#### Issue 1: Services Can't Communicate
**Problem**: Containers can't reach each other by service name
**Symptoms**: Connection refused errors, DNS resolution failures
**Solutions**:
1. Ensure services are on the same network
2. Use service names as hostnames
3. Check port exposure vs publishing
4. Verify network configuration
```bash
# Debug network connectivity
docker compose exec web ping db
docker compose exec web nslookup db
docker network ls
docker network inspect myapp_default
```

#### Issue 2: Volume Mount Issues
**Problem**: Files not syncing between host and container
**Symptoms**: Changes not reflected, permission errors
**Solutions**:
1. Check volume mount syntax and paths
2. Verify file permissions
3. Use appropriate mount type for platform
```bash
# Debug volume mounts
docker compose exec web ls -la /app
docker inspect myapp_web | grep -A 10 Mounts
```

#### Issue 3: Port Conflicts
**Problem**: Port already in use errors
**Symptoms**: Cannot start service, bind errors
**Solutions**:
1. Check for conflicting services
2. Use different port mappings
3. Stop conflicting processes
```bash
# Find processes using ports
sudo lsof -i :3000
netstat -tulpn | grep :3000

# Use different ports in override file
echo "services:
  web:
    ports:
      - '3001:3000'" > docker-compose.override.yml
```

### Debug Mode
```bash
# Enable debug logging
export COMPOSE_LOG_LEVEL=DEBUG
docker compose up

# Validate configuration
docker compose config
docker compose config --quiet  # Exit code only

# Profile startup time
time docker compose up -d

# Monitor resource usage
docker stats $(docker compose ps -q)
```

### Performance Issues
```bash
# Analyze build performance
docker compose build --progress=plain

# Check container resource usage
docker compose top
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Optimize volume performance (macOS)
# Use :cached or :delegated for better performance
volumes:
  - .:/app:cached
  - /app/node_modules
```

## Security Considerations

### Security Best Practices
```yaml
# Use specific image tags
services:
  web:
    image: node:18.16.0-alpine3.17  # Not 'latest'

# Run as non-root user
services:
  web:
    user: "1000:1000"
    read_only: true
    tmpfs:
      - /tmp:noexec,nosuid,size=100m

# Use secrets for sensitive data
secrets:
  db_password:
    file: ./secrets/db_password.txt
    mode: 0400
    uid: "1000"
    gid: "1000"

# Limit network exposure
services:
  db:
    # Don't expose to host
    expose:
      - "5432"
    # Internal network only
    networks:
      - backend

networks:
  backend:
    internal: true
```

### Secrets Management
```bash
# Create secrets directory
mkdir -p secrets
chmod 700 secrets

# Generate secure passwords
openssl rand -base64 32 > secrets/db_password.txt
chmod 600 secrets/db_password.txt

# Use environment-specific secrets
docker compose --env-file .env.prod -f docker-compose.yml -f docker-compose.prod.yml up
```

### Network Security
```yaml
# Isolate services with custom networks
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true  # No internet access

services:
  nginx:
    networks:
      - frontend
  
  api:
    networks:
      - frontend
      - backend
  
  database:
    networks:
      - backend  # Only accessible from backend
```

## AI Assistant Guidelines

When helping with Docker Compose:

1. **Environment Consistency**: Always recommend practices that work across development, staging, and production
2. **Service Dependencies**: Use proper dependency management with health checks when appropriate
3. **Resource Management**: Include resource limits and health checks for production-ready configurations
4. **Security First**: Default to secure configurations with non-root users and minimal exposed ports
5. **Development Experience**: Optimize for developer productivity with volume mounts and quick iteration
6. **Scalability**: Design configurations that can scale horizontally when needed
7. **Monitoring**: Include health checks and logging configurations by default
8. **Documentation**: Provide clear comments and documentation within compose files

### Architecture Decision Framework
When helping with Docker Compose architecture:

1. **Service Boundaries**: Help define clear service boundaries and responsibilities
2. **Data Management**: Consider volume strategies for development vs production
3. **Network Design**: Design networks that provide security and proper isolation
4. **Scaling Strategy**: Plan for horizontal scaling and load distribution
5. **Environment Parity**: Ensure development environments match production closely
6. **Migration Path**: Consider evolution to orchestration platforms like Kubernetes

### Code Generation Rules
- Generate compose files using version 3.8+ for modern features
- Include health checks for services that support them
- Use semantic service names that reflect their purpose
- Include resource limits for production configurations
- Add comprehensive comments explaining configuration choices
- Use multi-stage builds when generating Dockerfiles
- Include development overrides for local development

### Quality Enforcement
-  Enforce specific image tags instead of 'latest'
-  Require health checks for critical services
-  Promote non-root user execution
-  Block configurations that expose unnecessary ports
-  Require proper dependency management with 'depends_on'
-  Enforce resource limits for production configurations
-  Promote use of secrets for sensitive data
-  Block bind mounts in production configurations
-  Require proper network isolation between service tiers
-  Enforce consistent naming conventions across services