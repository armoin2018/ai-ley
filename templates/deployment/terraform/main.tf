# Configure providers
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = local.common_tags
  }
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Local variables
locals {
  environment = terraform.workspace
  
  common_tags = {
    Environment   = local.environment
    Project       = var.project_name
    ManagedBy     = "terraform"
    Owner         = var.owner
    CostCenter    = var.cost_center
    CreatedDate   = formatdate("YYYY-MM-DD", timestamp())
  }
}

# Data sources
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

# VPC Module
module "vpc" {
  source = "./modules/vpc"
  
  environment    = local.environment
  project_name   = var.project_name
  vpc_cidr       = var.vpc_cidr
  azs            = data.aws_availability_zones.available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  
  tags = local.common_tags
}

# Security Module
module "security" {
  source = "./modules/security"
  
  environment  = local.environment
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  
  allowed_cidr_blocks = var.allowed_cidr_blocks
  
  tags = local.common_tags
}

# Compute Module
module "compute" {
  source = "./modules/compute"
  
  environment     = local.environment
  project_name    = var.project_name
  instance_type   = var.instance_type
  key_name        = var.key_name
  
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  public_subnet_ids     = module.vpc.public_subnet_ids
  security_group_id     = module.security.web_security_group_id
  
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  
  tags = local.common_tags
}

# Database Module
module "database" {
  source = "./modules/database"
  
  environment    = local.environment
  project_name   = var.project_name
  
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  security_group_id    = module.security.db_security_group_id
  
  db_instance_class    = var.db_instance_class
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  
  tags = local.common_tags
}

# Storage Module
module "storage" {
  source = "./modules/storage"
  
  environment  = local.environment
  project_name = var.project_name
  
  enable_versioning = var.enable_s3_versioning
  enable_encryption = var.enable_s3_encryption
  
  tags = local.common_tags
}

# Monitoring Module
module "monitoring" {
  source = "./modules/monitoring"
  
  environment  = local.environment
  project_name = var.project_name
  
  enable_detailed_monitoring = var.enable_detailed_monitoring
  sns_topic_arn              = var.sns_topic_arn
  
  tags = local.common_tags
}
