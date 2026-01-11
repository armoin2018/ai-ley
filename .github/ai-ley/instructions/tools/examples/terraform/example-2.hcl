# providers.tf - Enterprise multi-cloud provider setup
terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.10"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.22"
    }
  }

  # Enterprise remote state backend
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "enterprise-org"

    workspaces {
      prefix = "infrastructure-"
    }
  }
}

# AWS Provider with enterprise defaults
provider "aws" {
  region = var.aws_primary_region

  assume_role {
    role_arn     = "arn:aws:iam::${var.aws_account_id}:role/TerraformExecutionRole"
    session_name = "terraform-${var.environment}-${var.workspace_name}"
  }

  default_tags {
    tags = local.enterprise_tags
  }
}

# Local values for enterprise standards
locals {
  enterprise_tags = {
    Environment        = var.environment
    Project           = var.project_name
    Owner             = var.project_owner
    CostCenter        = var.cost_center
    ManagedBy         = "Terraform"
    Compliance        = var.compliance_framework
    DataClassification = var.data_classification
    BackupRequired    = var.backup_required
    MonitoringEnabled = var.monitoring_enabled
    CreatedDate       = formatdate("YYYY-MM-DD", timestamp())
    TerraformWorkspace = terraform.workspace
  }

  # Naming conventions
  name_prefix = "${var.project_name}-${var.environment}"
  name_suffix = random_id.deployment.hex

  # Network calculations
  vpc_cidr_blocks = {
    aws   = cidrsubnet(var.enterprise_cidr_block, 8, 1)
    azure = cidrsubnet(var.enterprise_cidr_block, 8, 2)
    gcp   = cidrsubnet(var.enterprise_cidr_block, 8, 3)
  }
}