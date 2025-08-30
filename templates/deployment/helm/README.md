# Helm Charts Deployment Template

## Overview

This template provides comprehensive Helm charts for Kubernetes application deployment with multi-environment support, security best practices, and GitOps integration.

## Features

- **Multi-Environment Deployment**: Development, staging, production configurations
- **Security Best Practices**: RBAC, Network Policies, Pod Security Standards
- **Observability**: Prometheus metrics, logging, tracing integration
- **Auto-scaling**: HPA and VPA configurations
- **GitOps Ready**: ArgoCD and Flux integration
- **Service Mesh**: Istio and Linkerd support
- **Database Integration**: PostgreSQL, MySQL, Redis subchart dependencies
- **CI/CD Integration**: GitHub Actions, GitLab CI, Jenkins pipelines

## Structure

```
helm/
├── Chart.yaml                 # Chart metadata
├── values.yaml               # Default values
├── values-dev.yaml          # Development values
├── values-staging.yaml      # Staging values
├── values-prod.yaml         # Production values
├── charts/                  # Subchart dependencies
│   ├── postgresql/         # PostgreSQL subchart
│   ├── redis/              # Redis subchart
│   └── nginx/              # Nginx subchart
├── templates/
│   ├── _helpers.tpl        # Template helpers
│   ├── configmap.yaml      # ConfigMap resources
│   ├── secret.yaml         # Secret resources
│   ├── deployment.yaml     # Deployment resources
│   ├── service.yaml        # Service resources
│   ├── ingress.yaml        # Ingress resources
│   ├── hpa.yaml            # Horizontal Pod Autoscaler
│   ├── vpa.yaml            # Vertical Pod Autoscaler
│   ├── pdb.yaml            # Pod Disruption Budget
│   ├── networkpolicy.yaml  # Network Policy
│   ├── rbac.yaml           # RBAC resources
│   ├── serviceaccount.yaml # Service Account
│   ├── pvc.yaml            # Persistent Volume Claims
│   └── tests/              # Helm tests
│       ├── test-connection.yaml
│       └── test-deployment.yaml
├── crds/                   # Custom Resource Definitions
│   └── myapp-crd.yaml
└── scripts/
    ├── deploy.sh           # Deployment script
    ├── upgrade.sh          # Upgrade script
    ├── rollback.sh         # Rollback script
    └── test.sh             # Testing script
```

## Quick Start

### 1. Setup Environment

```bash
# Install Helm
curl https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz | tar xz
sudo mv linux-amd64/helm /usr/local/bin/

# Add common repositories
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

### 2. Install Dependencies

```bash
# Update chart dependencies
helm dependency update

# Build dependencies
helm dependency build
```

### 3. Deploy Application

```bash
# Deploy to development
./scripts/deploy.sh development

# Deploy to production
./scripts/deploy.sh production

# Deploy specific version
helm install myapp . --version 1.2.3 -f values-prod.yaml
```

### 4. Manage Releases

```bash
# List releases
helm list

# Upgrade release
./scripts/upgrade.sh production

# Rollback release
./scripts/rollback.sh production

# Uninstall release
helm uninstall myapp
```

## Best Practices

- **Values Organization**: Use environment-specific values files
- **Resource Limits**: Always set resource requests and limits
- **Health Checks**: Configure liveness and readiness probes
- **Security**: Use Pod Security Standards and Network Policies
- **Versioning**: Use semantic versioning for chart releases
- **Testing**: Include Helm tests for deployment validation
- **Documentation**: Document all chart values and templates

## Integration with AI Agents

### Model Recommendations

- **Chart Development**: GPT-4 (High/Technical)
- **Values Configuration**: Claude-3-Sonnet (Moderate/Technical)
- **Troubleshooting**: GPT-3.5-Turbo (Moderate/Analytical)
- **Documentation**: Claude-3-Sonnet (Moderate/Creative)

### Personas to Use

- `kubernetes-engineer.md` - Container orchestration
- `devops-engineer.md` - CI/CD integration
- `security-engineer.md` - Security configuration
- `site-reliability-engineer.md` - Monitoring and observability
