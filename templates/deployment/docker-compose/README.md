# Docker Compose Deployment Template

## Overview

This template provides a comprehensive Docker Compose setup for multi-service application deployment with development, staging, and production configurations.

## Features

- **Multi-Environment Support**: Development, staging, production compose files
- **Service Orchestration**: Web servers, databases, caching, monitoring
- **Volume Management**: Named volumes, bind mounts, tmpfs mounts
- **Network Isolation**: Custom networks for service communication
- **Health Checks**: Service health monitoring and dependencies
- **Scaling**: Horizontal scaling with load balancing
- **Security**: Secrets management and secure configurations
- **Monitoring**: Integrated observability stack

## Structure

```
docker-compose/
├── docker-compose.yml         # Base compose file
├── docker-compose.dev.yml     # Development overrides
├── docker-compose.staging.yml # Staging overrides
├── docker-compose.prod.yml    # Production overrides
├── docker-compose.test.yml    # Testing configuration
├── .env.example              # Environment variables template
├── .env.dev                  # Development environment
├── .env.staging              # Staging environment
├── .env.prod                 # Production environment
├── configs/                  # Configuration files
│   ├── nginx/
│   │   ├── nginx.conf
│   │   └── default.conf
│   ├── postgresql/
│   │   └── postgresql.conf
│   └── redis/
│       └── redis.conf
├── secrets/                  # Secret files
│   ├── db_password.txt
│   ├── jwt_secret.txt
│   └── ssl_cert.pem
├── volumes/                  # Volume mount points
│   ├── postgres_data/
│   ├── redis_data/
│   └── app_data/
└── scripts/
    ├── deploy.sh            # Deployment script
    ├── backup.sh            # Backup script
    ├── restore.sh           # Restore script
    └── logs.sh              # Log management script
```

## Quick Start

### 1. Setup Environment

```bash
# Install Docker and Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose (if not included)
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### 2. Configure Environment

```bash
# Copy environment template
cp .env.example .env.dev

# Edit environment variables
vim .env.dev
```

### 3. Deploy Services

```bash
# Deploy development environment
./scripts/deploy.sh development

# Deploy production environment
./scripts/deploy.sh production

# Deploy specific services
docker-compose up -d web database
```

### 4. Manage Services

```bash
# View logs
./scripts/logs.sh

# Scale services
docker-compose up -d --scale web=3

# Stop services
docker-compose down

# Remove volumes
docker-compose down -v
```

## Best Practices

- **Environment Separation**: Use different compose files per environment
- **Resource Limits**: Set memory and CPU limits for containers
- **Health Checks**: Configure health checks for all services
- **Secrets Management**: Use Docker secrets for sensitive data
- **Network Security**: Use custom networks to isolate services
- **Volume Management**: Use named volumes for persistent data
- **Logging**: Configure centralized logging

## Integration with AI Agents

### Model Recommendations

- **Service Architecture**: GPT-4 (High/Technical)
- **Configuration**: Claude-3-Sonnet (Moderate/Technical)
- **Troubleshooting**: GPT-3.5-Turbo (Moderate/Analytical)
- **Documentation**: Claude-3-Sonnet (Moderate/Creative)

### Personas to Use

- `docker-engineer.md` - Container orchestration
- `devops-engineer.md` - CI/CD integration
- `backend-developer.md` - Service configuration
- `system-administrator.md` - Infrastructure management
