# Shell Scripts Deployment Template

## Overview

This template provides comprehensive shell scripts for automated deployment across various platforms with error handling, logging, and rollback capabilities.

## Features

- **Cross-Platform Support**: Linux, macOS, Windows (WSL) compatibility
- **Error Handling**: Comprehensive error detection and recovery
- **Logging**: Detailed logging with rotation and archival
- **Configuration Management**: Environment-based configuration
- **Service Management**: Start, stop, restart, status operations
- **Health Checks**: Automated service validation
- **Backup & Restore**: Data backup and recovery procedures
- **Rollback Capability**: Automated rollback on deployment failures

## Structure

```
shell-scripts/
├── deploy.sh                 # Main deployment script
├── config/
│   ├── development.conf     # Development configuration
│   ├── staging.conf         # Staging configuration
│   └── production.conf      # Production configuration
├── lib/
│   ├── common.sh           # Common functions library
│   ├── logging.sh          # Logging functions
│   ├── validation.sh       # Validation functions
│   └── backup.sh           # Backup functions
├── services/
│   ├── web-server.sh       # Web server management
│   ├── database.sh         # Database management
│   ├── cache.sh            # Cache service management
│   └── monitoring.sh       # Monitoring service management
├── hooks/
│   ├── pre-deploy.sh       # Pre-deployment hooks
│   ├── post-deploy.sh      # Post-deployment hooks
│   ├── pre-rollback.sh     # Pre-rollback hooks
│   └── post-rollback.sh    # Post-rollback hooks
├── utils/
│   ├── health-check.sh     # Health check utilities
│   ├── backup-data.sh      # Data backup utilities
│   ├── restore-data.sh     # Data restore utilities
│   └── cleanup.sh          # Cleanup utilities
└── logs/
    ├── deployment.log      # Deployment logs
    ├── error.log           # Error logs
    └── audit.log           # Audit logs
```

## Quick Start

### 1. Setup Environment

```bash
# Make scripts executable
chmod +x *.sh lib/*.sh services/*.sh hooks/*.sh utils/*.sh

# Copy configuration template
cp config/development.conf.example config/development.conf

# Edit configuration
vim config/development.conf
```

### 2. Deploy Application

```bash
# Deploy to development
./deploy.sh development

# Deploy to production with backup
./deploy.sh production --backup

# Deploy specific version
./deploy.sh production --version 1.2.3

# Deploy with custom configuration
./deploy.sh staging --config custom.conf
```

### 3. Manage Services

```bash
# Check service status
./services/web-server.sh status

# Restart services
./services/web-server.sh restart

# View service logs
./utils/health-check.sh --service web
```

### 4. Backup and Restore

```bash
# Create backup
./utils/backup-data.sh --environment production

# Restore from backup
./utils/restore-data.sh --backup 2025-08-16_backup.tar.gz

# List available backups
./utils/backup-data.sh --list
```

## Best Practices

- **Error Handling**: Use `set -euo pipefail` for strict error handling
- **Logging**: Log all operations with timestamps and severity levels
- **Validation**: Validate inputs and environment before execution
- **Idempotency**: Ensure scripts can be run multiple times safely
- **Documentation**: Include help text and usage examples
- **Testing**: Test scripts in development before production use
- **Security**: Avoid hardcoded secrets, use secure file permissions

## Integration with AI Agents

### Model Recommendations

- **Script Development**: GPT-4 (High/Technical)
- **Error Handling**: Claude-3-Sonnet (High/Analytical)
- **Optimization**: GPT-3.5-Turbo (Moderate/Technical)
- **Documentation**: Claude-3-Sonnet (Moderate/Creative)

### Personas to Use

- `bash-script-developer.md` - Shell scripting expertise
- `system-administrator.md` - System management
- `devops-engineer.md` - Deployment automation
- `security-engineer.md` - Security best practices
