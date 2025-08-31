# Terraform Deployment Template

## Overview

This template provides a comprehensive Terraform Infrastructure as Code (IaC) setup for multi-cloud deployment with state management, environment separation, and CI/CD integration.

## Features

- **Multi-Cloud Support**: AWS, Azure, GCP configurations
- **Environment Separation**: Development, staging, production workspaces
- **State Management**: Remote state with locking and versioning
- **Module System**: Reusable, composable infrastructure modules
- **Security Best Practices**: Encrypted state, IAM roles, security groups
- **CI/CD Integration**: GitHub Actions, GitLab CI, Azure DevOps pipelines
- **Resource Tagging**: Consistent tagging strategy for cost management
- **Disaster Recovery**: Backup and recovery procedures

## Structure

```
terraform/
├── main.tf                    # Main Terraform configuration
├── variables.tf               # Input variables
├── outputs.tf                 # Output values
├── versions.tf                # Provider versions
├── terraform.tfvars.example  # Example variables file
├── environments/
│   ├── development/
│   │   ├── main.tf           # Development environment
│   │   ├── terraform.tfvars  # Development variables
│   │   └── backend.tf        # Development backend config
│   ├── staging/
│   │   ├── main.tf           # Staging environment
│   │   ├── terraform.tfvars  # Staging variables
│   │   └── backend.tf        # Staging backend config
│   └── production/
│       ├── main.tf           # Production environment
│       ├── terraform.tfvars  # Production variables
│       └── backend.tf        # Production backend config
├── modules/
│   ├── vpc/                  # VPC module
│   ├── compute/              # Compute instances module
│   ├── database/             # Database module
│   ├── storage/              # Storage module
│   ├── security/             # Security groups and IAM
│   ├── monitoring/           # CloudWatch/monitoring
│   └── networking/           # Load balancers, DNS
├── policies/
│   ├── iam-policies.json     # IAM policy documents
│   └── security-policies.json # Security policies
└── scripts/
    ├── deploy.sh             # Deployment script
    ├── destroy.sh            # Destruction script
    ├── plan.sh               # Planning script
    └── state-management.sh   # State management utilities
```

## Quick Start

### 1. Setup Environment

```bash
# Install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# Verify installation
terraform version
```

### 2. Configure Backend

```bash
# Initialize Terraform
terraform init

# Create workspace for environment
terraform workspace new development
terraform workspace new staging
terraform workspace new production
```

### 3. Deploy Infrastructure

```bash
# Plan deployment
./scripts/plan.sh development

# Apply deployment
./scripts/deploy.sh development

# Destroy infrastructure (when needed)
./scripts/destroy.sh development
```

### 4. Manage State

```bash
# List state resources
terraform state list

# Show specific resource
terraform state show aws_instance.web

# Import existing resource
terraform import aws_instance.web i-1234567890abcdef0
```

## Best Practices

- **State Management**: Always use remote state with locking
- **Environment Isolation**: Use separate state files per environment
- **Resource Naming**: Follow consistent naming conventions
- **Tagging Strategy**: Tag all resources for cost allocation
- **Version Pinning**: Pin provider and module versions
- **Security**: Use least privilege IAM policies
- **Documentation**: Document all modules and variables

## Cloud Provider Support

### AWS

- EC2 instances and Auto Scaling Groups
- VPC, subnets, and security groups
- RDS databases and ElastiCache
- S3 buckets and CloudFront
- IAM roles and policies
- CloudWatch monitoring

### Azure

- Virtual Machines and Scale Sets
- Virtual Networks and NSGs
- Azure SQL and Cosmos DB
- Storage Accounts and CDN
- Azure AD and RBAC
- Azure Monitor

### Google Cloud Platform

- Compute Engine and Instance Groups
- VPC networks and Firewall rules
- Cloud SQL and Memorystore
- Cloud Storage and CDN
- IAM and Service Accounts
- Cloud Monitoring

## Integration with AI Agents

### Model Recommendations

- **Infrastructure Design**: GPT-4 (Expert/Technical)
- **Security Configuration**: Claude-3-Opus (Expert/Analytical)
- **Cost Optimization**: Claude-3-Sonnet (High/Analytical)
- **Documentation**: Claude-3-Sonnet (Moderate/Creative)

### Personas to Use

- `cloud-architect.md` - Infrastructure design
- `security-engineer.md` - Security configuration
- `devops-engineer.md` - CI/CD integration
- `cost-optimization-specialist.md` - Resource optimization
