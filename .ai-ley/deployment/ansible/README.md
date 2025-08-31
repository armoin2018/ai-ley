# Ansible Deployment Template

## Overview

This template provides a comprehensive Ansible deployment setup for multi-environment application deployment with role-based architecture, inventory management, and CI/CD integration.

## Features

- **Multi-Environment Support**: Development, staging, production environments
- **Role-Based Architecture**: Modular, reusable roles for different components
- **Security Best Practices**: Vault encryption, SSH key management, privilege escalation
- **CI/CD Integration**: GitHub Actions, GitLab CI, Jenkins pipeline support
- **Infrastructure as Code**: Complete server provisioning and application deployment
- **Rolling Deployments**: Zero-downtime deployment strategies
- **Health Checks**: Automated service validation and rollback capabilities

## Structure

```
ansible/
├── ansible.cfg                 # Ansible configuration
├── requirements.yml            # Ansible Galaxy requirements
├── site.yml                   # Main playbook
├── inventories/
│   ├── development/
│   │   ├── hosts.yml          # Development inventory
│   │   └── group_vars/        # Development variables
│   ├── staging/
│   │   ├── hosts.yml          # Staging inventory
│   │   └── group_vars/        # Staging variables
│   └── production/
│       ├── hosts.yml          # Production inventory
│       └── group_vars/        # Production variables
├── roles/
│   ├── common/                # Base system configuration
│   ├── docker/                # Docker installation and setup
│   ├── nginx/                 # Nginx web server
│   ├── app/                   # Application deployment
│   ├── database/              # Database setup
│   └── monitoring/            # Monitoring and logging
├── playbooks/
│   ├── deploy.yml             # Application deployment
│   ├── rollback.yml           # Rollback procedures
│   ├── backup.yml             # Backup operations
│   └── maintenance.yml        # Maintenance tasks
├── group_vars/
│   ├── all.yml                # Global variables
│   └── vault.yml              # Encrypted secrets
└── scripts/
    ├── deploy.sh              # Deployment script
    ├── encrypt-secrets.sh     # Vault encryption helper
    └── health-check.sh        # Post-deployment validation
```

## Quick Start

### 1. Setup Environment

```bash
# Install Ansible
pip install ansible

# Install required collections
ansible-galaxy install -r requirements.yml

# Setup SSH key authentication
ssh-copy-id user@target-server
```

### 2. Configure Inventory

```bash
# Edit environment-specific inventory
vim inventories/production/hosts.yml

# Set environment variables
vim inventories/production/group_vars/all.yml
```

### 3. Deploy Application

```bash
# Deploy to development
./scripts/deploy.sh development

# Deploy to production
./scripts/deploy.sh production

# Deploy specific tags
ansible-playbook -i inventories/production/hosts.yml site.yml --tags "app,nginx"
```

### 4. Manage Secrets

```bash
# Encrypt secrets
./scripts/encrypt-secrets.sh

# Edit encrypted files
ansible-vault edit group_vars/vault.yml
```

## Best Practices

- **Idempotency**: All tasks should be idempotent
- **Testing**: Use molecule for role testing
- **Documentation**: Document all variables and their purposes
- **Security**: Never commit plain text secrets
- **Modularity**: Keep roles focused and reusable
- **Validation**: Always include health checks and validation tasks

## Troubleshooting

### Common Issues

1. **SSH Connection Failures**

   - Verify SSH key authentication
   - Check firewall rules
   - Validate inventory host definitions

2. **Permission Errors**

   - Review become settings
   - Check sudo configuration
   - Validate file ownership

3. **Service Failures**
   - Check service logs
   - Validate configuration files
   - Review dependency order

### Debugging Commands

```bash
# Verbose output
ansible-playbook -vvv site.yml

# Check connectivity
ansible all -m ping

# Dry run
ansible-playbook --check site.yml

# List tasks
ansible-playbook --list-tasks site.yml
```

## Integration with AI Agents

### Model Recommendations

- **Infrastructure Planning**: GPT-4 (Expert/Technical)
- **Role Development**: Claude-3-Sonnet (High/Technical)
- **Troubleshooting**: GPT-3.5-Turbo (Moderate/Analytical)
- **Documentation**: Claude-3-Sonnet (Moderate/Creative)

### Personas to Use

- `devops-engineer.md` - Infrastructure automation
- `security-engineer.md` - Security configuration
- `senior-developer.md` - Application deployment
- `system-administrator.md` - System configuration
