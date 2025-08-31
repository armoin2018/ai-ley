# Deployment Templates

## Overview

This collection provides comprehensive deployment templates for various deployment models and platforms. Each template includes production-ready configurations, best practices, and integration with AI-powered development workflows.

## Available Templates

### 🤖 Ansible Deployment

**Path**: `ansible/`
**Best For**: Linux/Unix environments, infrastructure automation, configuration management

**Key Features**:

- Multi-environment support (dev/staging/prod)
- Role-based architecture with reusable components
- Vault encryption for secrets management
- Rolling deployment strategies
- Comprehensive health checks and validation

**Quick Start**:

```bash
cd ansible/
./scripts/deploy.sh development
```

### ☁️ Terraform Infrastructure as Code

**Path**: `terraform/`
**Best For**: Cloud infrastructure provisioning, multi-cloud deployments

**Key Features**:

- AWS, Azure, GCP support
- Environment isolation with workspaces
- Remote state management with locking
- Modular architecture for reusability
- Cost optimization and resource tagging

**Quick Start**:

```bash
cd terraform/
./scripts/deploy.sh development plan
./scripts/deploy.sh development apply
```

### ⚓ Helm Charts for Kubernetes

**Path**: `helm/`
**Best For**: Kubernetes container orchestration, microservices deployment

**Key Features**:

- Multi-environment values files
- Auto-scaling with HPA and VPA
- Security best practices with RBAC and Network Policies
- Integrated monitoring and observability
- GitOps ready for ArgoCD/Flux

**Quick Start**:

```bash
cd helm/
./scripts/deploy.sh development install
```

### 🐳 Docker Compose Multi-Service

**Path**: `docker-compose/`
**Best For**: Development environments, local testing, simple production deployments

**Key Features**:

- Multi-service orchestration (web, app, database, cache)
- Environment-specific configurations
- Volume and network management
- Integrated monitoring with Prometheus/Grafana
- Health checks and service dependencies

**Quick Start**:

```bash
cd docker-compose/
./scripts/deploy.sh development
```

### 🐚 Shell Scripts Cross-Platform

**Path**: `shell-scripts/`
**Best For**: Traditional server deployments, legacy systems, custom automation

**Key Features**:

- Cross-platform compatibility (Linux, macOS, WSL)
- Comprehensive error handling and logging
- Backup and rollback capabilities
- Service management and health checks
- Modular library system

**Quick Start**:

```bash
cd shell-scripts/
chmod +x deploy.sh
./deploy.sh development
```

### ⚡ PowerShell for Windows

**Path**: `powershell/`
**Best For**: Windows environments, enterprise integration, .NET applications

**Key Features**:

- Native Windows service management
- IIS and SQL Server integration
- Active Directory and Group Policy support
- PowerShell DSC configurations
- Enterprise logging and monitoring

**Quick Start**:

```powershell
cd powershell
.\Deploy-Application.ps1 -Environment Development
```

## Template Selection Guide

### By Platform

| Platform                  | Recommended Templates                         |
| ------------------------- | --------------------------------------------- |
| **Linux/Unix**            | Ansible, Shell Scripts, Terraform             |
| **Windows**               | PowerShell, Terraform, Ansible (with WinRM)   |
| **Kubernetes**            | Helm Charts, Terraform (for infrastructure)   |
| **Docker**                | Docker Compose, Helm (for K8s), Shell Scripts |
| **Cloud (AWS/Azure/GCP)** | Terraform, Ansible, Helm                      |

### By Use Case

| Use Case                | Primary Template              | Secondary Template |
| ----------------------- | ----------------------------- | ------------------ |
| **Web Applications**    | Ansible, Docker Compose       | Shell Scripts      |
| **Microservices**       | Helm Charts, Docker Compose   | Ansible            |
| **Infrastructure**      | Terraform                     | Ansible            |
| **Legacy Systems**      | Shell Scripts, PowerShell     | Ansible            |
| **Enterprise Windows**  | PowerShell                    | Terraform          |
| **Development/Testing** | Docker Compose, Shell Scripts | Ansible            |

### By Complexity

| Complexity Level | Recommended Templates                 |
| ---------------- | ------------------------------------- |
| **Simple**       | Shell Scripts, Docker Compose         |
| **Medium**       | Ansible, PowerShell                   |
| **Complex**      | Terraform, Helm Charts                |
| **Enterprise**   | Terraform + Ansible, Helm + Terraform |

## Common Features Across Templates

### 🔧 Configuration Management

- Environment-specific configurations (dev/staging/prod)
- Secrets management and encryption
- Template-based configuration generation
- Validation and testing capabilities

### 📊 Monitoring & Observability

- Health check implementations
- Logging configuration and management
- Metrics collection and monitoring
- Alerting and notification setup

### 🛡️ Security Best Practices

- Secure credential handling
- Network isolation and firewall rules
- Access control and permissions
- Security scanning and validation

### 🔄 CI/CD Integration

- GitHub Actions workflows
- GitLab CI/CD pipelines
- Jenkins integration examples
- Automated testing and validation

### 📋 Project Management Integration

- JIRA issue tracking integration
- Deployment documentation generation
- Change management workflows
- Audit logging and compliance

## AI Agent Integration

### Model Recommendations by Template

| Template           | Complexity Analysis | Model Selection | Style Preference     |
| ------------------ | ------------------- | --------------- | -------------------- |
| **Ansible**        | High/Technical      | GPT-4           | Technical/Analytical |
| **Terraform**      | Expert/Technical    | GPT-4           | Technical/Analytical |
| **Helm**           | High/Technical      | GPT-4           | Technical/Creative   |
| **Docker Compose** | Moderate/Technical  | Claude-3-Sonnet | Technical/Creative   |
| **Shell Scripts**  | High/Technical      | GPT-4           | Technical/Analytical |
| **PowerShell**     | High/Technical      | GPT-4           | Technical/Analytical |

### Recommended Personas

#### Infrastructure & DevOps

- `devops-engineer.md` - Deployment automation and CI/CD
- `cloud-architect.md` - Infrastructure design and scaling
- `site-reliability-engineer.md` - Monitoring and observability
- `security-engineer.md` - Security configuration and compliance

#### Platform-Specific

- `kubernetes-engineer.md` - Container orchestration (Helm)
- `docker-specialist.md` - Container management (Docker Compose)
- `linux-administrator.md` - Unix/Linux deployments (Ansible, Shell)
- `windows-administrator.md` - Windows deployments (PowerShell)

#### Application Development

- `backend-developer.md` - Application configuration
- `frontend-developer.md` - Static asset deployment
- `database-administrator.md` - Database migrations and management
- `api-developer.md` - Service configuration and testing

## Getting Started

### 1. Choose Your Template

Select the appropriate template based on your platform, use case, and complexity requirements using the guides above.

### 2. Copy Template Files

```bash
# Copy the desired template to your project
cp -r templates/deployment/[template-name]/* ./deployment/

# Make scripts executable (Unix/Linux)
chmod +x deployment/scripts/*.sh
```

### 3. Configure Environment

```bash
# Copy and edit configuration files
cp deployment/config/development.conf.example deployment/config/development.conf
vim deployment/config/development.conf
```

### 4. Test Deployment

```bash
# Run a dry-run first
./deployment/deploy.sh development --dry-run

# Deploy to development
./deployment/deploy.sh development
```

### 5. Production Preparation

```bash
# Configure production environment
cp deployment/config/production.conf.example deployment/config/production.conf

# Test with staging first
./deployment/deploy.sh staging

# Deploy to production with backup
./deployment/deploy.sh production --backup
```

## Template Customization

### Adding Custom Steps

Each template includes hooks for custom logic:

- **Pre-deployment hooks**: `hooks/pre-deploy.*`
- **Post-deployment hooks**: `hooks/post-deploy.*`
- **Custom validation**: `validation/custom-checks.*`
- **Environment-specific overrides**: `config/[environment].*`

### Extending Templates

Templates are designed to be modular and extensible:

1. **Add new services**: Extend service management modules
2. **Custom health checks**: Implement application-specific validation
3. **Integration points**: Add monitoring, logging, and alerting
4. **Security enhancements**: Implement additional security measures

## Best Practices

### Development Workflow

1. **Test locally first**: Use development environment for initial testing
2. **Validate changes**: Run dry-run mode before actual deployment
3. **Incremental deployment**: Deploy to staging before production
4. **Monitor closely**: Watch logs and metrics during deployment
5. **Have rollback ready**: Always test rollback procedures

### Production Deployment

1. **Create backups**: Always backup before production deployment
2. **Maintenance windows**: Schedule deployments during low-traffic periods
3. **Gradual rollout**: Use blue-green or canary deployment strategies
4. **Health monitoring**: Implement comprehensive health checks
5. **Communication**: Notify stakeholders of deployment status

### Security Considerations

1. **Secrets management**: Never commit plain text secrets
2. **Access control**: Implement least privilege principles
3. **Network security**: Use firewalls and network segmentation
4. **Audit logging**: Log all deployment activities
5. **Compliance**: Follow organizational security policies

## Troubleshooting

### Common Issues

#### Permission Errors

```bash
# Fix file permissions
chmod +x scripts/*.sh

# Fix directory permissions
chmod -R 755 deployment/
```

#### Network Connectivity

```bash
# Test connectivity
ping target-server
telnet target-server 22

# Check firewall rules
iptables -L (Linux)
netsh advfirewall show allprofiles (Windows)
```

#### Service Failures

```bash
# Check service logs
journalctl -u service-name (systemd)
systemctl status service-name

# Check application logs
tail -f /var/log/application.log
```

### Getting Help

1. **Check logs**: Review deployment logs for error details
2. **Validate configuration**: Ensure all configuration files are correct
3. **Test connectivity**: Verify network connectivity to target systems
4. **Review prerequisites**: Confirm all dependencies are installed
5. **Consult documentation**: Reference template-specific README files

## Contributing

To contribute new templates or improvements:

1. **Follow template structure**: Use consistent directory layout and naming
2. **Include documentation**: Provide comprehensive README and examples
3. **Add AI integration**: Include model recommendations and persona mappings
4. **Test thoroughly**: Validate across multiple environments
5. **Update main README**: Add your template to the selection guides

## Integration with Build-Plan-Run Workflow

These deployment templates integrate seamlessly with the build-plan-run workflow:

1. **Planning Phase**: Use templates to estimate deployment complexity and resource requirements
2. **Architecture Phase**: Reference templates when designing deployment architecture
3. **Execution Phase**: Use intelligent model selection to choose optimal templates
4. **Optimization Phase**: Analyze deployment metrics and improve template configurations

For more information on the build-plan-run workflow, see: `templates/copilot/prompts/build-plan-run.prompt.md`
