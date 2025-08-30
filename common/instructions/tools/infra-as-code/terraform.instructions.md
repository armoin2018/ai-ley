# Terraform Infrastructure as Code Instructions

## Tool Overview
- **Tool Name**: Terraform
- **Version**: 1.5+ (Latest stable)
- **Category**: Infrastructure as Code (IaC)
- **Purpose**: Provision and manage cloud infrastructure using declarative configuration
- **Prerequisites**: Cloud provider credentials, Terraform CLI

## Installation & Setup

### Package Manager Installation
```bash
# macOS (via Homebrew)
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Ubuntu/Debian
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
sudo apt update
sudo apt install terraform

# Windows (via chocolatey)
choco install terraform

# Verify installation
terraform version
```

### Project Integration
```bash
# Initialize new Terraform project
mkdir infrastructure
cd infrastructure
terraform init

# Create basic directory structure
mkdir -p {modules,environments/{dev,staging,prod}}
touch {main.tf,variables.tf,outputs.tf,terraform.tfvars}
```

## Configuration

### Provider Configuration
```hcl
# main.tf - AWS provider example
terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "infrastructure/terraform.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment   = var.environment
      Project       = var.project_name
      ManagedBy     = "Terraform"
      Owner         = var.owner
    }
  }
}
```

### Variables Configuration
```hcl
# variables.tf
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
```

## Core Features

### Resource Management
- **Purpose**: Define and manage cloud infrastructure resources
- **Usage**: Create, update, and destroy infrastructure declaratively
- **Example**:
```hcl
# VPC and Networking
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
    Type = "Public"
  }
}
```

### Modules and Reusability
- **Purpose**: Create reusable infrastructure components
- **Usage**: Organize code into logical modules for better maintainability
- **Example**:
```hcl
# Module usage in root configuration
module "web_app" {
  source = "./modules/web-app"
  
  environment   = var.environment
  vpc_id        = aws_vpc.main.id
  subnet_ids    = aws_subnet.public[*].id
  instance_type = var.instance_type
}
```

### State Management
- **Purpose**: Track infrastructure state and manage changes
- **Usage**: Maintain state consistency and enable collaboration
- **Example**:
```hcl
# Remote state configuration
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

## Common Commands
```bash
# Essential daily commands
terraform init                          # Initialize working directory
terraform plan                          # Create execution plan
terraform apply                         # Apply changes
terraform destroy                       # Destroy infrastructure
terraform validate                      # Validate configuration

# Advanced operations
terraform fmt                           # Format configuration files
terraform import                        # Import existing resources
terraform state list                    # List resources in state
terraform state show <resource>         # Show resource details
terraform refresh                       # Update state with real infrastructure

# Workspace management
terraform workspace list                # List workspaces
terraform workspace new <name>          # Create new workspace
terraform workspace select <name>       # Switch workspace
```

## Workflow Integration

### CI/CD Integration
```yaml
# GitHub Actions example
name: Terraform

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  terraform:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        terraform_version: 1.5.0
    
    - name: Terraform Init
      run: terraform init
    
    - name: Terraform Plan
      run: terraform plan -no-color
      continue-on-error: true
    
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main'
      run: terraform apply -auto-approve
```

## Best Practices

### Code Organization
- Use consistent naming conventions
- Organize code into logical modules
- Separate environments using workspaces or directories
- Use remote state storage for team collaboration

### Resource Management
```hcl
# Use locals for computed values
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
  
  name_prefix = "${var.project_name}-${var.environment}"
}

# Use data sources for existing resources
data "aws_availability_zones" "available" {
  state = "available"
}
```

### Security Best Practices
- Store sensitive data in encrypted remote state
- Use IAM roles instead of access keys when possible
- Implement least privilege access principles
- Enable resource-level encryption

## Common Use Cases

### Multi-Tier Web Application
**Scenario**: Deploy a complete web application infrastructure
**Implementation**:
```hcl
module "networking" {
  source = "./modules/networking"
  
  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr          = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "application" {
  source = "./modules/application"
  
  environment        = var.environment
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  instance_type     = var.instance_type
}
```

## Troubleshooting

### Common Issues

#### Issue 1: State Lock
**Problem**: Terraform state is locked by another operation
**Solution**: 
```bash
# Force unlock (use carefully)
terraform force-unlock <lock-id>
```

#### Issue 2: Resource Already Exists
**Problem**: Trying to create a resource that already exists
**Solution**:
```bash
# Import existing resource
terraform import aws_s3_bucket.example my-existing-bucket
```

## Security Considerations

### State File Security
- Store state files in encrypted remote backends
- Restrict access to state storage
- Use state locking to prevent concurrent modifications
- Regular state file backups

### Secrets Management
```hcl
# Use AWS Secrets Manager for sensitive data
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "prod/database/password"
}

resource "aws_db_instance" "main" {
  password = jsondecode(data.aws_secretsmanager_secret_version.db_password.secret_string)["password"]
  # ... other configuration
}
```

## AI Assistant Guidelines
When helping with Terraform implementation:

1. **Always use resource tagging** for better resource management and cost tracking
2. **Recommend remote state storage** for team collaboration
3. **Suggest modular architecture** for code reusability and maintainability
4. **Include proper variable validation** and descriptions
5. **Emphasize security best practices** for secrets and access control
6. **Provide environment separation** strategies (workspaces or directories)
7. **Include lifecycle management** for critical resources
8. **Reference official provider documentation** for specific resources

### Code Generation Rules
- Generate well-structured, modular Terraform code
- Include comprehensive variable definitions with validation
- Use consistent naming conventions and tagging strategies
- Implement proper security practices and least privilege access
- Include outputs for resource references and debugging
- Follow HCL formatting and style conventions
- Generate reusable modules for common patterns