---
agentMode: general
applyTo: general
author: AI-LEY
description: Enterprise Atmos-Terraform infrastructure orchestration with multi-cloud provisioning, compliance automation, GitOps workflows, and comprehensive monitoring integration for scalable platform engineering operations.
extensions:
  - .md
  - .tf
  - .yaml
  - .yml
  - .hcl
guidelines: Enterprise Infrastructure as Code with Atmos orchestration, Terraform components, multi-environment deployment, compliance frameworks, security hardening, monitoring integration, and GitOps automation.
instructionType: general
keywords:
  - atmos
  - terraform
  - infrastructure-as-code
  - multi-cloud
  - aws
  - azure
  - gcp
  - kubernetes
  - gitops
  - compliance
  - security
  - monitoring
  - enterprise
  - orchestration
  - automation
lastUpdated: '2025-09-04T00:00:00.000000'
summaryScore: 5.0
title: Atmos-Terraform Enterprise Infrastructure Orchestration
version: 3.0.0
---

# Atmos-Terraform Enterprise Infrastructure at Scale

## Enterprise Overview

Atmos-Terraform provides comprehensive cloud infrastructure provisioning through enterprise-grade modular components and multi-environment orchestration. This enterprise implementation leverages Atmos YAML configurations combined with Terraform HCL for scalable, environment-aware infrastructure deployment across AWS, Azure, GCP, and Kubernetes platforms.

Enterprise implementations utilize advanced features including GitOps workflows, automated compliance validation, sophisticated CI/CD pipelines, infrastructure drift detection, cost optimization, security scanning, and comprehensive monitoring integration for managing complex multi-tenant, multi-region cloud architectures.

## 🧠 Enterprise Context

- **Project Type**: Enterprise Cloud Infrastructure Provisioning / Platform Engineering at Scale
- **Architecture**: Modular Components / Multi-Environment / Multi-Tenant / GitOps / Zero-Touch Deployment
- **Cloud Providers**: AWS / Azure / GCP / Kubernetes with cross-cloud federation
- **Compliance**: SOC2, PCI-DSS, HIPAA, FedRAMP, CIS benchmarks
- **Scale**: 1000+ resources across 50+ environments and 10+ regions
- **Technologies**: Terraform 1.6+, Atmos 1.63+, Go templates, YAML, HCL, Terragrunt compatibility

## Enterprise Atmos Configuration Framework

### Advanced Atmos Configuration

```yaml
# atmos.yaml - Enterprise Atmos configuration
cli:
  colors: true
  verbose: true

# Schema validation
schemas:
  jsonschema:
    base_path: 'schemas'
  opa:
    base_path: 'policies'
  cue:
    base_path: 'schemas/cue'

# Component configuration
components:
  terraform:
    base_path: 'components/terraform'
    apply_auto_approve: false
    deploy_run_init: true
    init_run_reconfigure: true
    auto_generate_backend_file: false

# Stack configuration
stacks:
  base_path: 'stacks'
  included_paths:
    - 'orgs/**/*'
    - 'globals/**/*'
    - 'catalog/**/*'
  excluded_paths:
    - '**/_defaults.yaml'
    - '**/deprecated/**/*'
  name_pattern: '{namespace}-{tenant}-{environment}-{stage}'
  name_template: '{{.namespace}}-{{.tenant}}-{{.environment}}-{{.stage}}'

# Workflow configuration
workflows:
  base_path: 'workflows'

# Import sources for reusable components
import:
  - source: 'git::https://github.com/cloudposse/atmos.git//examples/quick-start/components?ref=v1.63.0'
    destination: 'components/vendored'
  - source: 'oci://ghcr.io/cloudposse/atmos-components'
    version: '>=1.0.0'
    destination: 'components/vendored/oci'

# Template processing
templates:
  settings:
    enabled: true
    sprig: true
    gomplate: true
    evaluations: 3

# Validation settings
validation:
  check_missing_required_vars: true
  check_stack_name_pattern: true

# Integration settings
integrations:
  github:
    gitops:
      terraform_version: '1.6.0'
      atmos_version: '1.63.0'
      artifact_storage: true
      opentofu_version: '1.6.0'

  atlantis:
    path: '.atlantis'
    config_templates:
      - name: 'enterprise-workflow'
        workflow: 'enterprise'

# Logs configuration
logs:
  file: '/var/log/atmos/atmos.log'
  level: 'info'

# Enterprise settings
settings:
  enterprise:
    multi_tenant: true
    compliance:
      enabled: true
      frameworks: ['SOC2', 'PCI-DSS', 'HIPAA', 'CIS']
      scan_on_plan: true
      block_on_violations: true
    cost_management:
      enabled: true
      budget_alerts: true
      resource_tagging_required: true
    security:
      drift_detection: true
      vulnerability_scanning: true
      secret_scanning: true

# Provider aliases for multi-region deployments
provider_aliases:
  aws:
    primary: 'us-east-1'
    secondary: 'us-west-2'
    dr: 'eu-west-1'
  azure:
    primary: 'East US'
    secondary: 'West US 2'
    dr: 'West Europe'
  gcp:
    primary: 'us-central1'
    secondary: 'us-west1'
    dr: 'europe-west1'
```

### Enterprise Stack Architecture

```yaml
# stacks/globals/enterprise-baseline.yaml - Enterprise baseline configuration
vars:
  # Organization configuration
  organization:
    name: 'enterprise-corp'
    domain: 'enterprise.com'
    business_unit: 'platform-engineering'
    cost_center: 'engineering'

  # Compliance and governance
  compliance:
    frameworks:
      - 'SOC2-Type2'
      - 'PCI-DSS-3.2.1'
      - 'HIPAA'
      - 'NIST-800-53'
      - 'CIS-AWS-Foundations-1.4'
    data_classification: 'confidential'
    data_retention_days: 2557 # 7 years
    backup_retention_days: 90

  # Security baseline
  security:
    encryption:
      enabled: true
      algorithm: 'AES-256'
      key_rotation_days: 90
    network:
      zero_trust: true
      network_segmentation: true
      dmz_enabled: true
    monitoring:
      siem_enabled: true
      ids_enabled: true
      threat_intelligence: true

  # Tagging strategy
  tags:
    common:
      Organization: '{{ .vars.organization.name }}'
      Environment: '{{ .vars.environment }}'
      Tenant: '{{ .vars.tenant }}'
      Stage: '{{ .vars.stage }}'
      CostCenter: '{{ .vars.organization.cost_center }}'
      ManagedBy: 'atmos-terraform'
      Compliance: '{{ .vars.compliance.frameworks | join "," }}'
      DataClassification: '{{ .vars.compliance.data_classification }}'
      BackupPolicy: 'required'
      MonitoringEnabled: 'true'

  # Network configuration
  networking:
    vpc:
      enable_dns_hostnames: true
      enable_dns_support: true
      enable_flow_logs: true
      flow_logs_retention: 30
    subnets:
      public_subnet_suffix: 'public'
      private_subnet_suffix: 'private'
      database_subnet_suffix: 'database'

  # Monitoring and observability
  monitoring:
    cloudtrail:
      enabled: true
      multi_region: true
      include_global_services: true
      enable_log_file_validation: true
    cloudwatch:
      log_retention_days: 90
      metrics_retention_days: 15
      detailed_monitoring: true
    prometheus:
      enabled: true
      retention_days: 15
      scrape_interval: '30s'
    grafana:
      enabled: true
      admin_user: 'admin'

  # Backup and disaster recovery
  backup:
    enabled: true
    schedule: 'cron(0 2 * * ? *)' # Daily at 2 AM
    retention_days: 30
    cross_region_backup: true
    point_in_time_recovery: true

  # Cost management
  cost_management:
    budgets:
      enabled: true
      alert_thresholds: [80, 90, 100]
      contact_emails: ['finance@enterprise.com', 'engineering@enterprise.com']
    resource_optimization:
      right_sizing: true
      unused_resource_detection: true
      scheduled_scaling: true
```

### Production Environment Configuration

```yaml
# stacks/orgs/enterprise/platform/prod/us-east-1/vpc.yaml - Production VPC stack
import:
  - "globals/enterprise-baseline"
  - "mixins/aws-production"

vars:
  # Environment-specific overrides
  environment: "production"
  stage: "prod"
  tenant: "platform"
  region: "us-east-1"
  availability_zones: ["us-east-1a", "us-east-1b", "us-east-1c"]

  # Production-specific compliance
  compliance:
    audit_logging: true
    encryption_in_transit: true
    encryption_at_rest: true
    vulnerability_scanning: true
    penetration_testing_approved: true

  # Production network configuration
  vpc_cidr: "10.0.0.0/16"
  public_subnet_cidrs: ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidrs: ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnet_cidrs: ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]

  # Security groups
  allow_ssh_from_cidr: ["10.0.0.0/8"]  # Internal only
  allow_https_from_cidr: ["0.0.0.0/0"]
  allow_http_redirect: true

  # NAT Gateway configuration
  enable_nat_gateway: true
  single_nat_gateway: false  # High availability
  enable_vpn_gateway: true

  # Flow logs
  flow_logs_destination_type: "s3"
  flow_logs_s3_bucket: "enterprise-vpc-flow-logs-prod-us-east-1"

  # Enhanced monitoring
  detailed_monitoring: true
  enable_network_insights: true

components:
  terraform:
    vpc:
      metadata:
        component: "vpc"
        type: "terraform"
        description: "Enterprise production VPC with multi-AZ high availability"
      settings:
        spacelift:
          workspace_enabled: true
          autodeploy: false  # Manual approval required for production

      vars:
        # VPC configuration
        vpc_cidr_block: "{{ .vars.vpc_cidr }}"
        availability_zones: "{{ .vars.availability_zones }}"

        # Subnet configuration
        public_subnets: "{{ .vars.public_subnet_cidrs }}"
        private_subnets: "{{ .vars.private_subnet_cidrs }}"
        database_subnets: "{{ .vars.database_subnet_cidrs }}"

        # Gateway configuration
        create_igw: true
        enable_nat_gateway: "{{ .vars.enable_nat_gateway }}"
        single_nat_gateway: "{{ .vars.single_nat_gateway }}"
        enable_vpn_gateway: "{{ .vars.enable_vpn_gateway }}"

        # DNS configuration
        enable_dns_hostnames: true
        enable_dns_support: true

        # Flow logs configuration
        enable_flow_log: true
        flow_log_destination_type: "{{ .vars.flow_logs_destination_type }}"
        flow_log_destination_arn: "arn:aws:s3:::{{ .vars.flow_logs_s3_bucket }}"
        flow_log_log_format: "${start} ${end} ${srcaddr} ${dstaddr} ${srcport} ${dstport} ${protocol} ${packets} ${bytes} ${action}"

        # Network ACLs
        manage_default_network_acl: true
        default_network_acl_ingress: [
          {
            rule_no    = 100
            action     = "allow"
            from_port  = 0
            to_port    = 65535
            protocol   = "-1"
            cidr_block = "10.0.0.0/16"
          }
        ]
        default_network_acl_egress: [
          {
            rule_no    = 100
            action     = "allow"
            from_port  = 0
            to_port    = 65535
            protocol   = "-1"
            cidr_block = "0.0.0.0/0"
          }
        ]

        # Security groups
        manage_default_security_group: true
        default_security_group_ingress: []
        default_security_group_egress: [
          {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = ["0.0.0.0/0"]
          }
        ]

        # Tags
        tags: "{{ .vars.tags.common | toYaml | nindent 8 }}"
        vpc_tags:
          Name: "{{ .vars.organization.name }}-{{ .vars.tenant }}-{{ .vars.stage }}-vpc"
          Type: "production"
        public_subnet_tags:
          Type: "public"
          kubernetes.io/role/elb: "1"
        private_subnet_tags:
          Type: "private"
          kubernetes.io/role/internal-elb: "1"
        database_subnet_tags:
          Type: "database"
```

### EKS Cluster Configuration

```yaml
# stacks/orgs/enterprise/platform/prod/us-east-1/eks.yaml - Production EKS cluster
import:
  - "globals/enterprise-baseline"
  - "mixins/aws-production"

vars:
  environment: "production"
  stage: "prod"
  tenant: "platform"
  region: "us-east-1"

  # EKS cluster configuration
  cluster_name: "enterprise-platform-prod"
  cluster_version: "1.28"
  cluster_endpoint_private_access: true
  cluster_endpoint_public_access: true
  cluster_endpoint_public_access_cidrs: ["0.0.0.0/0"]  # Restrict in production

  # Node group configuration
  node_groups:
    general:
      instance_types: ["m5.large", "m5.xlarge"]
      ami_type: "AL2_x86_64"
      capacity_type: "ON_DEMAND"
      min_size: 3
      max_size: 10
      desired_size: 5

    compute:
      instance_types: ["c5.2xlarge", "c5.4xlarge"]
      ami_type: "AL2_x86_64"
      capacity_type: "SPOT"
      min_size: 0
      max_size: 20
      desired_size: 5

  # Security configuration
  cluster_encryption_config:
    provider_key_arn: "alias/aws/eks"
    resources: ["secrets"]

  # Logging configuration
  cluster_enabled_log_types: [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  # Add-ons
  cluster_addons:
    coredns:
      resolve_conflicts: "OVERWRITE"
    kube-proxy:
      resolve_conflicts: "OVERWRITE"
    vpc-cni:
      resolve_conflicts: "OVERWRITE"
      configuration_values: |
        {
          "env": {
            "ENABLE_POD_ENI": "true",
            "ENABLE_PREFIX_DELEGATION": "true"
          }
        }
    aws-ebs-csi-driver:
      resolve_conflicts: "OVERWRITE"

components:
  terraform:
    eks:
      metadata:
        component: "eks"
        type: "terraform"
        description: "Enterprise production EKS cluster with security hardening"

      settings:
        spacelift:
          workspace_enabled: true
          autodeploy: false

      deps:
        - "vpc"

      vars:
        # Cluster configuration
        cluster_name: "{{ .vars.cluster_name }}"
        cluster_version: "{{ .vars.cluster_version }}"

        # Network configuration
        vpc_id: "{{ (atmos.Component \"vpc\").outputs.vpc_id }}"
        subnet_ids: "{{ (atmos.Component \"vpc\").outputs.private_subnets }}"
        control_plane_subnet_ids: "{{ (atmos.Component \"vpc\").outputs.private_subnets }}"

        # Endpoint configuration
        cluster_endpoint_private_access: "{{ .vars.cluster_endpoint_private_access }}"
        cluster_endpoint_public_access: "{{ .vars.cluster_endpoint_public_access }}"
        cluster_endpoint_public_access_cidrs: "{{ .vars.cluster_endpoint_public_access_cidrs | toYaml | nindent 8 }}"

        # Security configuration
        cluster_encryption_config: "{{ .vars.cluster_encryption_config | toYaml | nindent 8 }}"

        # Logging
        cluster_enabled_log_types: "{{ .vars.cluster_enabled_log_types | toYaml | nindent 8 }}"
        cloudwatch_log_group_retention_in_days: 90

        # Node groups
        eks_managed_node_groups: |
          {{- range $name, $config := .vars.node_groups }}
          {{ $name }}:
            instance_types: {{ $config.instance_types | toYaml | nindent 12 }}
            ami_type: {{ $config.ami_type }}
            capacity_type: {{ $config.capacity_type }}
            min_size: {{ $config.min_size }}
            max_size: {{ $config.max_size }}
            desired_size: {{ $config.desired_size }}

            block_device_mappings:
              xvda:
                device_name: "/dev/xvda"
                ebs:
                  volume_size: 100
                  volume_type: "gp3"
                  iops: 3000
                  encrypted: true
                  delete_on_termination: true

            metadata_options:
              http_endpoint: "enabled"
              http_tokens: "required"
              http_put_response_hop_limit: 2

            labels:
              Environment: "{{ $.vars.environment }}"
              NodeGroup: "{{ $name }}"

            taints: []

            update_config:
              max_unavailable_percentage: 33

          {{- end }}

        # Add-ons
        cluster_addons: "{{ .vars.cluster_addons | toYaml | nindent 8 }}"

        # RBAC
        manage_aws_auth_configmap: true
        aws_auth_roles: [
          {
            rolearn  = "arn:aws:iam::{{ (datasources.aws_caller_identity).account_id }}:role/EKSAdminRole"
            username = "eks-admin"
            groups   = ["system:masters"]
          }
        ]

        # Tags
        tags: "{{ .vars.tags.common | toYaml | nindent 8 }}"
        cluster_tags:
          Name: "{{ .vars.cluster_name }}"
          Type: "production"
```

## Enterprise Terraform Components

### VPC Component Architecture

```hcl
# components/terraform/vpc/main.tf - Enterprise VPC component
terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}

# Local values
locals {
  name = var.name
  region = data.aws_region.current.name

  # Generate availability zones if not provided
  availability_zones = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, min(3, length(data.aws_availability_zones.available.names)))

  # Calculate subnet CIDRs if not provided
  public_subnets = length(var.public_subnets) > 0 ? var.public_subnets : [
    for k in range(length(local.availability_zones)) :
    cidrsubnet(var.vpc_cidr_block, 8, k + 1)
  ]

  private_subnets = length(var.private_subnets) > 0 ? var.private_subnets : [
    for k in range(length(local.availability_zones)) :
    cidrsubnet(var.vpc_cidr_block, 8, k + 101)
  ]

  database_subnets = length(var.database_subnets) > 0 ? var.database_subnets : [
    for k in range(length(local.availability_zones)) :
    cidrsubnet(var.vpc_cidr_block, 8, k + 201)
  ]

  # Common tags
  common_tags = merge(
    var.tags,
    {
      Component   = "vpc"
      Module      = "terraform-aws-vpc"
      Environment = var.environment
      Region      = local.region
    }
  )
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    local.common_tags,
    var.vpc_tags,
    {
      Name = "${local.name}-vpc"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  count = var.create_igw ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-igw"
    }
  )
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(local.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnets[count.index]
  availability_zone       = local.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    var.public_subnet_tags,
    {
      Name = "${local.name}-public-${local.availability_zones[count.index]}"
      Type = "Public"
    }
  )
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(local.private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnets[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = merge(
    local.common_tags,
    var.private_subnet_tags,
    {
      Name = "${local.name}-private-${local.availability_zones[count.index]}"
      Type = "Private"
    }
  )
}
```

### Advanced Networking and Security

```hcl
# Database Subnets
resource "aws_subnet" "database" {
  count = length(local.database_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.database_subnets[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = merge(
    local.common_tags,
    var.database_subnet_tags,
    {
      Name = "${local.name}-database-${local.availability_zones[count.index]}"
      Type = "Database"
    }
  )
}

# Database subnet group
resource "aws_db_subnet_group" "database" {
  count = length(local.database_subnets) > 0 ? 1 : 0

  name       = "${local.name}-database"
  subnet_ids = aws_subnet.database[*].id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-database"
    }
  )
}

# Elastic IPs for NAT Gateways
resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(local.public_subnets)) : 0

  domain = "vpc"

  depends_on = [aws_internet_gateway.main]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-nat-${count.index + 1}"
    }
  )
}

# NAT Gateways
resource "aws_nat_gateway" "main" {
  count = var.enable_nat_gateway ? (var.single_nat_gateway ? 1 : length(local.public_subnets)) : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[var.single_nat_gateway ? 0 : count.index].id

  depends_on = [aws_internet_gateway.main]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-nat-${count.index + 1}"
    }
  )
}

# VPC Flow Logs
resource "aws_flow_log" "vpc" {
  count = var.enable_flow_log ? 1 : 0

  iam_role_arn    = var.flow_log_destination_type == "cloud-watch-logs" ? aws_iam_role.flow_log[0].arn : null
  log_destination = var.flow_log_destination_arn
  log_destination_type = var.flow_log_destination_type
  log_format      = var.flow_log_log_format
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-flow-log"
    }
  )
}

# Security Groups
resource "aws_security_group" "default" {
  name_prefix = "${local.name}-default-"
  vpc_id      = aws_vpc.main.id
  description = "Default security group for ${local.name}"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-default-sg"
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

# VPC Endpoints
resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${local.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = concat(aws_route_table.private[*].id, aws_route_table.public[*].id)

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-s3-endpoint"
    }
  )
}
```

## Enterprise Variables and Outputs Framework

### Comprehensive Variable Definitions

```hcl
# components/terraform/vpc/variables.tf - Enterprise variable definitions
variable "name" {
  description = "Name to be used on all resources as identifier"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "Name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "The vpc_cidr_block must be a valid IPv4 CIDR block."
  }
}

variable "availability_zones" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "enable_nat_gateway" {
  description = "Should be true to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true to provision a single shared NAT Gateway across all private networks"
  type        = bool
  default     = false
}

variable "enable_flow_log" {
  description = "Whether or not to enable VPC Flow Logs"
  type        = bool
  default     = true
}

variable "flow_log_destination_type" {
  description = "Type of flow log destination"
  type        = string
  default     = "s3"

  validation {
    condition     = contains(["s3", "cloud-watch-logs", "kinesis-data-firehose"], var.flow_log_destination_type)
    error_message = "Flow log destination type must be one of: s3, cloud-watch-logs, kinesis-data-firehose."
  }
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}
```

### Enterprise Output Specifications

```hcl
# components/terraform/vpc/outputs.tf - Comprehensive outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.main.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = aws_subnet.database[*].id
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nat[*].public_ip
}

output "vpc_flow_log_id" {
  description = "The ID of the Flow Log resource"
  value       = try(aws_flow_log.vpc[0].id, null)
}

output "default_security_group_id" {
  description = "The ID of the default security group"
  value       = aws_security_group.default.id
}

output "availability_zones" {
  description = "List of availability zones used by subnets"
  value       = local.availability_zones
}
```

## Enterprise CI/CD Pipeline Integration

### GitHub Actions Workflow

```yaml
# .github/workflows/atmos-terraform.yml - Enterprise GitOps workflow
name: 'Atmos Terraform Enterprise Workflow'

on:
  push:
    branches: [main, develop]
    paths:
      - 'components/**'
      - 'stacks/**'
      - 'schemas/**'
  pull_request:
    branches: [main]
    paths:
      - 'components/**'
      - 'stacks/**'
      - 'schemas/**'

env:
  ATMOS_CLI_CONFIG_PATH: './atmos.yaml'
  AWS_REGION: 'us-east-1'

jobs:
  validate:
    name: 'Validate Configuration'
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Atmos
        uses: cloudposse/github-action-setup-atmos@v1
        with:
          atmos-version: '1.63.0'

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: '1.6.0'

      - name: Validate YAML
        run: |
          find stacks -name "*.yaml" -o -name "*.yml" | xargs yamllint -c .yamllint.yml

      - name: Validate Atmos Configuration
        run: atmos validate stacks

      - name: Validate Terraform Components
        run: |
          for component in components/terraform/*/; do
            if [ -d "$component" ]; then
              echo "Validating $component"
              cd "$component"
              terraform init -backend=false
              terraform validate
              cd ../../../
            fi
          done

  security-scan:
    name: 'Security Scanning'
    runs-on: ubuntu-latest
    needs: validate
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run Checkov
        uses: bridgecrewio/checkov-action@master
        with:
          directory: components/terraform
          framework: terraform
          output_format: sarif
          output_file_path: checkov-results.sarif

      - name: Run TFSec
        uses: aquasecurity/tfsec-sarif-action@v0.1.4
        with:
          sarif_file: tfsec-results.sarif
          working_directory: components/terraform

      - name: Upload SARIF files
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: '.'

  plan:
    name: 'Plan Infrastructure Changes'
    runs-on: ubuntu-latest
    needs: [validate, security-scan]
    strategy:
      matrix:
        stack:
          - 'enterprise-platform-dev-us-east-1'
          - 'enterprise-platform-staging-us-east-1'
          - 'enterprise-platform-prod-us-east-1'
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Setup Atmos
        uses: cloudposse/github-action-setup-atmos@v1
        with:
          atmos-version: '1.63.0'

      - name: Plan VPC
        run: |
          atmos terraform plan vpc -s ${{ matrix.stack }}

      - name: Plan EKS
        run: |
          atmos terraform plan eks -s ${{ matrix.stack }}

      - name: Comment PR
        if: github.event_name == 'pull_request'
        uses: actions/github-script@v7
        with:
          script: |
            const output = `
            #### Atmos Terraform Plan 📖 \`${{ matrix.stack }}\`

            <details><summary>Show Plan</summary>

            \`\`\`
            ${{ steps.plan.outputs.stdout }}
            \`\`\`

            </details>

            *Pusher: @${{ github.actor }}, Action: \`${{ github.event_name }}\`, Workflow: \`${{ github.workflow }}\`*`;

            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: output
            })

  deploy:
    name: 'Deploy Infrastructure'
    runs-on: ubuntu-latest
    needs: plan
    if: github.ref == 'refs/heads/main'
    environment: production
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          role-to-assume: ${{ secrets.AWS_ROLE_ARN }}
          aws-region: ${{ env.AWS_REGION }}

      - name: Setup Atmos
        uses: cloudposse/github-action-setup-atmos@v1
        with:
          atmos-version: '1.63.0'

      - name: Apply Infrastructure Changes
        run: |
          atmos terraform apply vpc -s enterprise-platform-prod-us-east-1 --auto-approve
          atmos terraform apply eks -s enterprise-platform-prod-us-east-1 --auto-approve
```

## Enterprise Compliance and Security

### Policy as Code with OPA

```rego
# schemas/policies/terraform.rego - OPA policy for Terraform compliance
package terraform

import rego.v1

# Deny resources without required tags
deny contains msg if {
    resource := input.resource_changes[_]
    resource.change.actions[_] == "create"

    required_tags := ["Environment", "Owner", "CostCenter", "Compliance"]
    tag := required_tags[_]
    not resource.change.after.tags[tag]

    msg := sprintf("Resource %s missing required tag: %s", [resource.address, tag])
}

# Ensure encryption is enabled for storage resources
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket"
    resource.change.actions[_] == "create"

    not resource.change.after.server_side_encryption_configuration

    msg := sprintf("S3 bucket %s must have encryption enabled", [resource.address])
}

# Ensure VPC flow logs are enabled
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_vpc"
    resource.change.actions[_] == "create"

    # Check if flow log exists for this VPC
    flow_logs := [r | r := input.resource_changes[_]; r.type == "aws_flow_log"]
    count(flow_logs) == 0

    msg := sprintf("VPC %s must have flow logs enabled", [resource.address])
}

# Ensure NAT Gateway high availability in production
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_nat_gateway"
    resource.change.actions[_] == "create"

    # Check environment tag
    resource.change.after.tags.Environment == "production"

    # Count NAT gateways
    nat_gateways := [r | r := input.resource_changes[_]; r.type == "aws_nat_gateway"]
    count(nat_gateways) < 2

    msg := "Production environment must have at least 2 NAT Gateways for high availability"
}
```

### Compliance Monitoring

```yaml
# components/terraform/compliance/main.tf - Compliance monitoring component
resource "aws_config_configuration_recorder" "main" {
name     = "${var.name}-config-recorder"
role_arn = aws_iam_role.config.arn

recording_group {
all_supported = true
include_global_resource_types = true
}

depends_on = [aws_config_delivery_channel.main]
}

resource "aws_config_delivery_channel" "main" {
name           = "${var.name}-config-delivery-channel"
s3_bucket_name = aws_s3_bucket.config.bucket

snapshot_delivery_properties {
delivery_frequency = "TwentyFour_Hours"
}
}

resource "aws_config_config_rule" "s3_encrypted" {
name = "s3-bucket-server-side-encryption-enabled"

source {
owner             = "AWS"
source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
}

depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "vpc_flow_logs" {
name = "vpc-flow-logs-enabled"

source {
owner             = "AWS"
source_identifier = "VPC_FLOW_LOGS_ENABLED"
}

depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_config_rule" "root_access_key_check" {
name = "root-access-key-check"

source {
owner             = "AWS"
source_identifier = "ROOT_ACCESS_KEY_CHECK"
}

depends_on = [aws_config_configuration_recorder.main]
}
```

## Enterprise Monitoring and Observability

### Prometheus and Grafana Integration

```hcl
# components/terraform/monitoring/main.tf - Comprehensive monitoring stack
resource "aws_prometheus_workspace" "main" {
  alias = "${var.name}-prometheus"

  tags = var.tags
}

resource "aws_grafana_workspace" "main" {
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["SAML"]
  permission_type         = "SERVICE_MANAGED"
  role_arn               = aws_iam_role.grafana.arn
  name                   = "${var.name}-grafana"

  data_sources = ["PROMETHEUS", "CLOUDWATCH"]

  tags = var.tags
}

# CloudWatch Dashboards
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.name}-infrastructure"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/VPC", "PacketsDropped", "VPC", var.vpc_id],
            ["AWS/EKS", "cluster_failed_request_count", "cluster_name", var.cluster_name]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          period  = 300
          title   = "Infrastructure Health"
        }
      }
    ]
  })
}

# Alerting
resource "aws_sns_topic" "alerts" {
  name = "${var.name}-infrastructure-alerts"

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "high_nat_gateway_errors" {
  alarm_name          = "${var.name}-high-nat-gateway-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "ErrorPortAllocation"
  namespace           = "AWS/NatGateway"
  period              = "300"
  statistic           = "Sum"
  threshold           = "10"
  alarm_description   = "This metric monitors NAT Gateway errors"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    NatGatewayId = var.nat_gateway_id
  }
}
```

## Enterprise Best Practices and Guidelines

### 🧶 Enterprise Patterns

#### ✅ Patterns to Follow

- **Multi-Environment Architecture**: Use Atmos stack inheritance to manage dev/staging/prod environments with shared baseline configurations
- **Component Modularity**: Break infrastructure into reusable components (vpc, eks, rds, monitoring) with clear interfaces
- **Template-Driven Configuration**: Leverage Go templates and Sprig functions for dynamic configuration generation
- **GitOps Workflows**: Implement automated planning and deployment through GitHub Actions with proper approval gates
- **Security by Default**: Enable encryption, flow logs, monitoring, and compliance scanning in all environments
- **Cost Optimization**: Implement resource tagging, budget alerts, and right-sizing recommendations
- **Disaster Recovery**: Configure cross-region backups, multi-AZ deployments, and infrastructure replication

#### 🚫 Patterns to Avoid

- **Hardcoded Values**: Never hardcode environment-specific values; use stack variables and template functions
- **Monolithic Components**: Avoid large, complex components; break into focused, testable modules
- **Direct Terraform Usage**: Always use Atmos CLI for consistency and state management
- **Missing Compliance**: Never deploy without security scanning, compliance validation, and audit logging
- **Single Points of Failure**: Avoid single NAT gateways, single-AZ deployments, or single-region architectures
- **Untagged Resources**: All resources must have consistent tagging for cost allocation and governance
- **Manual Deployments**: Production deployments must go through automated pipelines with approval gates

### 🧪 Enterprise Testing Strategy

```yaml
# .github/workflows/testing.yml - Comprehensive testing workflow
name: 'Infrastructure Testing'

on:
  pull_request:
    paths: ['components/**', 'stacks/**']

jobs:
  unit-tests:
    name: 'Unit Tests'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Terratest
        run: |
          cd tests
          go test -v ./...

  integration-tests:
    name: 'Integration Tests'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Deploy Test Environment
        run: |
          atmos terraform apply vpc -s test-us-east-1 --auto-approve
          atmos terraform apply eks -s test-us-east-1 --auto-approve
      - name: Run Tests
        run: |
          cd tests/integration
          go test -v ./...
      - name: Cleanup
        if: always()
        run: |
          atmos terraform destroy eks -s test-us-east-1 --auto-approve
          atmos terraform destroy vpc -s test-us-east-1 --auto-approve
```

### 📊 Enterprise Cost Management

```hcl
# components/terraform/cost-management/main.tf - Cost optimization
resource "aws_budgets_budget" "infrastructure" {
  name         = "${var.name}-infrastructure-budget"
  budget_type  = "COST"
  limit_amount = var.monthly_budget_limit
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  cost_filters = {
    Tag = ["Environment:${var.environment}"]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_email_addresses = var.budget_notification_emails
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                 = 100
    threshold_type             = "PERCENTAGE"
    notification_type           = "FORECASTED"
    subscriber_email_addresses = var.budget_notification_emails
  }
}

# Cost allocation tags
resource "aws_ce_cost_category" "environment" {
  name         = "${var.name}-environment-cost-category"
  rule_version = "CostCategoryExpression.v1"

  rule {
    value = "Production"
    rule {
      tag {
        key           = "Environment"
        values        = ["prod", "production"]
        match_options = ["EQUALS"]
      }
    }
  }

  rule {
    value = "Development"
    rule {
      tag {
        key           = "Environment"
        values        = ["dev", "development"]
        match_options = ["EQUALS"]
      }
    }
  }
}
```

````

## 🔐 Enterprise Security & Compliance Automation

### Advanced Security Framework

```yaml
# atmos.yaml - Enhanced security configuration
schema:
  atmos_version: 1.63.0

integrations:
  github:
    gitops:
      enabled: true
      webhook_secret: "${GITHUB_WEBHOOK_SECRET}"
      auto_apply: true
      drift_detection: true
      pr_plan: true
      artifact_storage: "s3://terraform-artifacts-bucket"

security:
  policy_as_code:
    enabled: true
    engine: "opa"
    policies_repo: "https://github.com/company/terraform-policies.git"
    policies_path: "policies/"
    enforcement_level: "advisory"  # advisory, mandatory

  secret_scanning:
    enabled: true
    providers:
      - "hashicorp/vault"
      - "aws/secretsmanager"
      - "azure/keyvault"

  drift_detection:
    enabled: true
    schedule: "0 6 * * *"  # Daily at 6 AM
    notification:
      slack_webhook: "${DRIFT_NOTIFICATION_WEBHOOK}"
      email: "infrastructure@company.com"

  compliance_frameworks:
    - name: "CIS"
      enabled: true
      profile: "level2"
      auto_remediation: false
    - name: "SOC2"
      enabled: true
      controls: ["CC6.1", "CC6.2", "CC6.3", "CC6.6", "CC6.7"]
    - name: "PCI-DSS"
      enabled: true
      scope: "cardholder_data_environment"
    - name: "HIPAA"
      enabled: true
      phi_protection: true

stacks:
  name_pattern: "{tenant}-{environment}-{stage}"

settings:
  validation:
    validate_component_name: true
    check_for_unused_components: true

workflows:
  validate:
    description: "Validate Terraform configurations"
    steps:
      - command: "atmos validate stacks"
      - command: "terraform fmt -check=true -recursive"
      - command: "tflint --recursive"
      - command: "checkov -d . --framework terraform"
      - command: "terrascan scan -t terraform"

  deploy:
    description: "Deploy infrastructure with approvals"
    steps:
      - command: "atmos terraform plan {component} -s {stack}"
      - name: "approval_gate"
        type: "manual"
        condition: "environment == 'prod'"
        timeout: "24h"
      - command: "atmos terraform apply {component} -s {stack}"
      - command: "atmos terraform output {component} -s {stack}"

  destroy:
    description: "Destroy infrastructure with confirmations"
    steps:
      - name: "confirmation"
        type: "input"
        prompt: "Type 'DESTROY' to confirm destruction of {stack}"
        validation: "exact:DESTROY"
      - command: "atmos terraform plan -destroy {component} -s {stack}"
      - name: "final_approval"
        type: "manual"
        timeout: "1h"
      - command: "atmos terraform destroy {component} -s {stack}"
````

```hcl
# components/terraform/security/compliance-monitoring/main.tf - Enterprise compliance automation
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9"
    }
  }
}

# CIS Benchmark compliance monitoring
resource "aws_config_configuration_recorder" "cis_compliance" {
  name     = "${var.name_prefix}-cis-compliance-recorder"
  role_arn = aws_iam_role.config.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }

  depends_on = [aws_config_delivery_channel.cis_compliance]
}

resource "aws_config_delivery_channel" "cis_compliance" {
  name           = "${var.name_prefix}-cis-compliance-channel"
  s3_bucket_name = aws_s3_bucket.config_bucket.bucket
  s3_key_prefix  = "config"

  snapshot_delivery_properties {
    delivery_frequency = "Daily"
  }
}

# CIS benchmark rules
resource "aws_config_config_rule" "cis_rules" {
  for_each = {
    "cis-1-3-ensure-cloudtrail-enabled" = {
      source_identifier = "CLOUD_TRAIL_ENABLED"
      description      = "CIS 1.3 - Ensure CloudTrail is enabled in all regions"
    }
    "cis-1-4-ensure-cloudtrail-log-file-validation" = {
      source_identifier = "CLOUD_TRAIL_LOG_FILE_VALIDATION_ENABLED"
      description      = "CIS 1.4 - Ensure CloudTrail log file validation is enabled"
    }
    "cis-2-1-ensure-cloudtrail-encryption" = {
      source_identifier = "CLOUD_TRAIL_ENCRYPTION_ENABLED"
      description      = "CIS 2.1 - Ensure CloudTrail logs are encrypted at rest"
    }
    "cis-2-2-ensure-cloudtrail-bucket-not-public" = {
      source_identifier = "S3_BUCKET_PUBLIC_ACCESS_PROHIBITED"
      description      = "CIS 2.2 - Ensure CloudTrail S3 bucket is not publicly accessible"
    }
    "cis-2-9-ensure-vpc-flow-logging" = {
      source_identifier = "VPC_FLOW_LOGS_ENABLED"
      description      = "CIS 2.9 - Ensure VPC flow logging is enabled"
    }
  }

  name = each.key

  source {
    owner             = "AWS"
    source_identifier = each.value.source_identifier
  }

  depends_on = [aws_config_configuration_recorder.cis_compliance]

  tags = merge(local.common_tags, {
    Name           = each.key
    ComplianceType = "CIS"
    Description    = each.value.description
  })
}

# SOC2 compliance automation
resource "aws_securityhub_standards_subscription" "soc2" {
  for_each = toset([
    "arn:aws:securityhub:::standard/aws-foundational-security",
    "arn:aws:securityhub:::standard/cis-aws-foundations-benchmark/v/1.2.0",
    "arn:aws:securityhub:::standard/pci-dss/v/3.2.1"
  ])

  standards_arn = each.value
  depends_on    = [aws_securityhub_account.main]
}

resource "aws_securityhub_account" "main" {}

# SOC2 control implementations
resource "aws_cloudwatch_log_group" "soc2_audit_logs" {
  name              = "/aws/security/soc2-audit-logs"
  retention_in_days = var.audit_log_retention_days
  kms_key_id        = aws_kms_key.audit_logs.arn

  tags = merge(local.common_tags, {
    Name        = "SOC2 Audit Logs"
    Compliance  = "SOC2"
    Control     = "CC6.1"
    Description = "Logical and physical access controls"
  })
}

# PCI-DSS compliance for cardholder data environments
resource "aws_inspector_assessment_target" "pci_compliance" {
  name = "${var.name_prefix}-pci-compliance-assessment"

  tags = merge(local.common_tags, {
    Name       = "PCI-DSS Assessment"
    Compliance = "PCI-DSS"
    Scope      = "Cardholder Data Environment"
  })
}

resource "aws_inspector_assessment_template" "pci_dss" {
  name       = "${var.name_prefix}-pci-dss-template"
  target_arn = aws_inspector_assessment_target.pci_compliance.arn
  duration   = 3600

  rules_package_arns = [
    data.aws_inspector_rules_packages.current.arns[0],  # Security Best Practices
    data.aws_inspector_rules_packages.current.arns[1],  # Network Reachability
    data.aws_inspector_rules_packages.current.arns[2],  # Common Vulnerabilities
  ]

  tags = merge(local.common_tags, {
    Name       = "PCI-DSS Assessment Template"
    Compliance = "PCI-DSS"
  })
}

# HIPAA compliance for PHI protection
resource "aws_kms_key" "hipaa_phi_encryption" {
  count = var.hipaa_enabled ? 1 : 0

  description             = "HIPAA PHI encryption key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable HIPAA PHI encryption"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key for PHI"
        Effect = "Allow"
        Principal = {
          AWS = var.hipaa_phi_access_principals
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name       = "HIPAA PHI Encryption Key"
    Compliance = "HIPAA"
    DataType   = "PHI"
  })
}

resource "aws_kms_alias" "hipaa_phi_encryption" {
  count         = var.hipaa_enabled ? 1 : 0
  name          = "alias/${var.name_prefix}-hipaa-phi"
  target_key_id = aws_kms_key.hipaa_phi_encryption[0].key_id
}

# Compliance reporting and automation
resource "aws_lambda_function" "compliance_reporter" {
  filename         = "compliance-reporter.zip"
  function_name    = "${var.name_prefix}-compliance-reporter"
  role            = aws_iam_role.compliance_reporter.arn
  handler         = "index.handler"
  source_code_hash = data.archive_file.compliance_reporter.output_base64sha256
  runtime         = "python3.11"
  timeout         = 300

  environment {
    variables = {
      COMPLIANCE_FRAMEWORKS = jsonencode(var.compliance_frameworks)
      SNS_TOPIC_ARN         = aws_sns_topic.compliance_notifications.arn
      S3_BUCKET            = aws_s3_bucket.compliance_reports.bucket
    }
  }

  tags = merge(local.common_tags, {
    Name = "Compliance Reporter"
  })
}

data "archive_file" "compliance_reporter" {
  type        = "zip"
  output_path = "compliance-reporter.zip"

  source {
    content = templatefile("${path.module}/lambda/compliance-reporter.py", {
      frameworks = var.compliance_frameworks
    })
    filename = "index.py"
  }
}

resource "aws_cloudwatch_event_rule" "compliance_check" {
  name                = "${var.name_prefix}-compliance-check"
  description         = "Trigger compliance reporting"
  schedule_expression = "rate(24 hours)"

  tags = merge(local.common_tags, {
    Name = "Compliance Check Schedule"
  })
}

resource "aws_cloudwatch_event_target" "compliance_reporter" {
  rule      = aws_cloudwatch_event_rule.compliance_check.name
  target_id = "ComplianceReporterTarget"
  arn       = aws_lambda_function.compliance_reporter.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_compliance" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.compliance_reporter.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.compliance_check.arn
}
```

### Enterprise Monitoring & Observability Integration

```hcl
# components/terraform/monitoring/enterprise-observability/main.tf - Comprehensive monitoring platform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    grafana = {
      source  = "grafana/grafana"
      version = ">= 2.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = ">= 3.0"
    }
  }
}

# CloudWatch enhanced monitoring
resource "aws_cloudwatch_dashboard" "infrastructure_overview" {
  dashboard_name = "${var.name_prefix}-infrastructure-overview"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", "${var.load_balancer_name}"],
            ["AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", "${var.load_balancer_name}"],
            ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${var.rds_instance_id}"],
            ["AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.rds_instance_id}"],
            ["AWS/ECS", "CPUUtilization", "ServiceName", "${var.ecs_service_name}", "ClusterName", "${var.ecs_cluster_name}"],
            ["AWS/ECS", "MemoryUtilization", "ServiceName", "${var.ecs_service_name}", "ClusterName", "${var.ecs_cluster_name}"]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "Infrastructure Health Overview"
          period  = 300
        }
      },
      {
        type   = "log"
        x      = 0
        y      = 6
        width  = 24
        height = 6

        properties = {
          query   = "SOURCE '/aws/lambda/${var.lambda_function_name}' | fields @timestamp, @message | sort @timestamp desc | limit 100"
          region  = var.aws_region
          title   = "Application Logs"
          view    = "table"
        }
      }
    ]
  })

  tags = local.common_tags
}

# Prometheus monitoring setup
resource "aws_prometheus_workspace" "main" {
  alias = "${var.name_prefix}-prometheus"

  logging_configuration {
    log_group_arn = "${aws_cloudwatch_log_group.prometheus.arn}:*"
  }

  tags = merge(local.common_tags, {
    Name = "Prometheus Workspace"
  })
}

resource "aws_cloudwatch_log_group" "prometheus" {
  name              = "/aws/prometheus/${var.name_prefix}"
  retention_in_days = var.log_retention_days
  kms_key_id        = aws_kms_key.logging.arn

  tags = local.common_tags
}

# Grafana managed service
resource "aws_grafana_workspace" "main" {
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"]
  permission_type          = "SERVICE_MANAGED"
  role_arn                = aws_iam_role.grafana.arn
  name                    = "${var.name_prefix}-grafana"
  description             = "Enterprise Grafana workspace for ${var.name_prefix}"

  data_sources = [
    "CLOUDWATCH",
    "PROMETHEUS",
    "XRAY"
  ]

  notification_destinations = ["SNS"]

  organizational_units = var.organizational_units

  tags = merge(local.common_tags, {
    Name = "Grafana Workspace"
  })
}

# Custom metrics and alarms
resource "aws_cloudwatch_metric_alarm" "high_cpu_utilization" {
  for_each = var.monitored_instances

  alarm_name          = "${var.name_prefix}-high-cpu-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]
  ok_actions          = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = each.value.instance_id
  }

  tags = merge(local.common_tags, {
    Name     = "High CPU Alarm - ${each.key}"
    Severity = "warning"
  })
}

resource "aws_cloudwatch_metric_alarm" "infrastructure_drift" {
  alarm_name          = "${var.name_prefix}-infrastructure-drift"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "DriftDetectionCount"
  namespace           = "Custom/Infrastructure"
  period              = "3600"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Infrastructure drift detected"
  alarm_actions       = [aws_sns_topic.critical_alerts.arn]
  treat_missing_data  = "notBreaching"

  tags = merge(local.common_tags, {
    Name     = "Infrastructure Drift Alarm"
    Severity = "critical"
  })
}

# Application Performance Monitoring (APM) integration
resource "datadog_synthetics_test" "api_health_check" {
  count = var.datadog_enabled ? 1 : 0

  type    = "api"
  subtype = "http"

  request_definition {
    method = "GET"
    url    = var.application_health_check_url
    timeout = 60

    headers = {
      "User-Agent" = "Datadog Synthetic"
    }
  }

  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }

  assertion {
    type     = "responseTime"
    operator = "lessThan"
    target   = "1000"
  }

  locations = var.synthetic_test_locations

  options_list {
    tick_every = 60

    retry {
      count    = 3
      interval = 300
    }

    monitor_options {
      renotify_interval = 120
    }
  }

  name    = "${var.name_prefix} API Health Check"
  message = "API health check failed @pagerduty-infrastructure"

  tags = ["environment:${var.environment}", "service:${var.service_name}"]
}

# Infrastructure cost monitoring
resource "aws_budgets_budget" "infrastructure_cost" {
  name         = "${var.name_prefix}-infrastructure-budget"
  budget_type  = "COST"
  limit_amount = var.monthly_budget_limit
  limit_unit   = "USD"
  time_unit    = "MONTHLY"
  time_period_start = "2024-01-01_00:00"

  cost_filters {
    tag {
      key = "Project"
      values = [var.name_prefix]
    }
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                 = 80
    threshold_type            = "PERCENTAGE"
    notification_type         = "ACTUAL"
    subscriber_email_addresses = var.budget_alert_emails
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                 = 100
    threshold_type            = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.budget_alert_emails
  }
}

# Log aggregation and analysis
resource "aws_elasticsearch_domain" "logs" {
  count                 = var.elasticsearch_enabled ? 1 : 0
  domain_name           = "${var.name_prefix}-logs"
  elasticsearch_version = "7.10"

  cluster_config {
    instance_type            = var.elasticsearch_instance_type
    instance_count           = var.elasticsearch_instance_count
    dedicated_master_enabled = true
    master_instance_type     = var.elasticsearch_master_instance_type
    master_instance_count    = 3
    zone_awareness_enabled   = true

    zone_awareness_config {
      availability_zone_count = 2
    }
  }

  vpc_options {
    security_group_ids = [aws_security_group.elasticsearch[0].id]
    subnet_ids         = var.elasticsearch_subnet_ids
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp3"
    volume_size = var.elasticsearch_volume_size
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  access_policies = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.elasticsearch_access_principals
        }
        Action   = "es:*"
        Resource = "arn:aws:es:${var.aws_region}:${data.aws_caller_identity.current.account_id}:domain/${var.name_prefix}-logs/*"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "Elasticsearch Logs Domain"
  })
}
```

### Enterprise CI/CD & GitOps Automation

```hcl
# components/terraform/cicd/enterprise-pipeline/main.tf - Advanced CI/CD automation
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    github = {
      source  = "integrations/github"
      version = ">= 5.0"
    }
  }
}

# CodePipeline for Terraform deployments
resource "aws_codepipeline" "terraform_pipeline" {
  name     = "${var.name_prefix}-terraform-pipeline"
  role_arn = aws_iam_role.pipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.pipeline_artifacts.bucket
    type     = "S3"

    encryption_key {
      id   = aws_kms_key.pipeline_artifacts.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        Owner      = var.github_owner
        Repo       = var.github_repo
        Branch     = var.github_branch
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "Validate"

    action {
      name             = "ValidateAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["ValidateOutput"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.terraform_validate.name
      }
    }
  }

  stage {
    name = "Plan"

    action {
      name             = "PlanAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["ValidateOutput"]
      output_artifacts = ["PlanOutput"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.terraform_plan.name
      }
    }
  }

  dynamic "stage" {
    for_each = var.approval_required ? [1] : []
    content {
      name = "Approval"

      action {
        name     = "ApprovalAction"
        category = "Approval"
        owner    = "AWS"
        provider = "Manual"
        version  = "1"

        configuration = {
          CustomData      = "Please review the Terraform plan before applying"
          ExternalEntityLink = "${var.github_repo_url}/actions"
        }
      }
    }
  }

  stage {
    name = "Apply"

    action {
      name            = "ApplyAction"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["PlanOutput"]
      version         = "1"

      configuration = {
        ProjectName = aws_codebuild_project.terraform_apply.name
      }
    }
  }

  tags = local.common_tags
}

# CodeBuild projects for Terraform operations
resource "aws_codebuild_project" "terraform_validate" {
  name          = "${var.name_prefix}-terraform-validate"
  description   = "Validate Terraform configurations"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_MEDIUM"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = var.terraform_version
    }

    environment_variable {
      name  = "ATMOS_VERSION"
      value = var.atmos_version
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec-validate.yml"
  }

  cache {
    type = "S3"
    location = "${aws_s3_bucket.pipeline_cache.bucket}/validate-cache"
  }

  tags = local.common_tags
}

resource "aws_codebuild_project" "terraform_plan" {
  name          = "${var.name_prefix}-terraform-plan"
  description   = "Generate Terraform execution plans"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_MEDIUM"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = var.terraform_version
    }

    environment_variable {
      name  = "ATMOS_VERSION"
      value = var.atmos_version
    }

    environment_variable {
      name  = "STACK_NAME"
      value = var.stack_name
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = templatefile("${path.module}/buildspec-plan.yml", {
      terraform_version = var.terraform_version
      atmos_version     = var.atmos_version
      components        = var.components_to_deploy
    })
  }

  cache {
    type = "S3"
    location = "${aws_s3_bucket.pipeline_cache.bucket}/plan-cache"
  }

  tags = local.common_tags
}

resource "aws_codebuild_project" "terraform_apply" {
  name          = "${var.name_prefix}-terraform-apply"
  description   = "Apply Terraform configurations"
  service_role  = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_LARGE"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = var.terraform_version
    }

    environment_variable {
      name  = "ATMOS_VERSION"
      value = var.atmos_version
    }

    environment_variable {
      name  = "STACK_NAME"
      value = var.stack_name
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec-apply.yml"
  }

  tags = local.common_tags
}

# GitHub Actions integration
resource "github_actions_secret" "aws_access_key_id" {
  count           = var.github_actions_enabled ? 1 : 0
  repository      = var.github_repo
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = aws_iam_access_key.github_actions[0].id
}

resource "github_actions_secret" "aws_secret_access_key" {
  count           = var.github_actions_enabled ? 1 : 0
  repository      = var.github_repo
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = aws_iam_access_key.github_actions[0].secret
}

resource "github_repository_file" "github_actions_workflow" {
  count               = var.github_actions_enabled ? 1 : 0
  repository          = var.github_repo
  branch             = var.github_branch
  file               = ".github/workflows/terraform-atmos.yml"
  commit_message     = "Add Terraform Atmos GitHub Actions workflow"
  commit_author      = "Terraform"
  commit_email       = "terraform@example.com"
  overwrite_on_create = true

  content = templatefile("${path.module}/templates/github-actions-workflow.yml", {
    terraform_version = var.terraform_version
    atmos_version     = var.atmos_version
    aws_region        = var.aws_region
    components        = var.components_to_deploy
    stacks           = var.stacks_to_deploy
  })
}

# Terraform Cloud/Enterprise integration
resource "aws_ssm_parameter" "terraform_cloud_token" {
  count = var.terraform_cloud_enabled ? 1 : 0
  name  = "/${var.name_prefix}/terraform-cloud-token"
  type  = "SecureString"
  value = var.terraform_cloud_token

  tags = local.common_tags
}

# Infrastructure drift detection
resource "aws_lambda_function" "drift_detection" {
  filename         = "drift-detection.zip"
  function_name    = "${var.name_prefix}-drift-detection"
  role            = aws_iam_role.drift_detection_lambda.arn
  handler         = "index.handler"
  source_code_hash = data.archive_file.drift_detection.output_base64sha256
  runtime         = "python3.11"
  timeout         = 900
  memory_size     = 1024

  environment {
    variables = {
      S3_BUCKET        = aws_s3_bucket.terraform_state.bucket
      STACK_CONFIGS    = jsonencode(var.drift_detection_stacks)
      SNS_TOPIC_ARN    = aws_sns_topic.drift_alerts.arn
      TERRAFORM_VERSION = var.terraform_version
      ATMOS_VERSION     = var.atmos_version
    }
  }

  tags = local.common_tags
}

data "archive_file" "drift_detection" {
  type        = "zip"
  output_path = "drift-detection.zip"

  source {
    content = templatefile("${path.module}/lambda/drift-detection.py", {
      stacks = var.drift_detection_stacks
    })
    filename = "index.py"
  }
}

resource "aws_cloudwatch_event_rule" "drift_detection_schedule" {
  name                = "${var.name_prefix}-drift-detection"
  description         = "Trigger infrastructure drift detection"
  schedule_expression = var.drift_detection_schedule

  tags = local.common_tags
}

resource "aws_cloudwatch_event_target" "drift_detection_lambda" {
  rule      = aws_cloudwatch_event_rule.drift_detection_schedule.name
  target_id = "DriftDetectionLambdaTarget"
  arn       = aws_lambda_function.drift_detection.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_drift" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.drift_detection.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.drift_detection_schedule.arn
}
```

```yaml
# stacks/catalog/prod/us-east-1.yaml - Enterprise production stack configuration
import:
  - catalog/prod/_defaults

vars:
  stage: 'prod'
  environment: 'production'

  # Enhanced security configuration
  security:
    compliance_frameworks:
      - name: 'SOC2'
        enabled: true
        controls: ['CC6.1', 'CC6.2', 'CC6.3', 'CC6.6', 'CC6.7', 'CC6.8']
        audit_logging: true
        automated_remediation: false
      - name: 'PCI-DSS'
        enabled: true
        scope: 'cardholder_data_environment'
        network_segmentation: true
        encryption_at_rest: true
        key_management: 'aws-kms'
      - name: 'HIPAA'
        enabled: true
        phi_protection: true
        audit_controls: true
        access_logging: true

    kms_key_rotation: true
    secrets_management: 'aws-secretsmanager'
    network_acls_enabled: true
    vpc_flow_logs_enabled: true
    cloudtrail_encryption: true
    config_recording: true
    security_hub_enabled: true

  # Production monitoring configuration
  monitoring:
    prometheus:
      enabled: true
      retention_days: 90
      high_availability: true
      alertmanager_enabled: true

    grafana:
      enabled: true
      authentication: 'aws-sso'
      notification_channels:
        - type: 'slack'
          webhook_url: '${SLACK_WEBHOOK_URL}'
        - type: 'pagerduty'
          integration_key: '${PAGERDUTY_INTEGRATION_KEY}'

    elasticsearch:
      enabled: true
      instance_type: 'r6g.large.elasticsearch'
      instance_count: 3
      master_instance_type: 'r6g.medium.elasticsearch'
      master_instance_count: 3
      volume_size: 500

    cloudwatch:
      enhanced_monitoring: true
      detailed_monitoring: true
      log_retention_days: 365
      custom_metrics_enabled: true

    synthetic_monitoring:
      enabled: true
      test_locations: ['us-east-1', 'us-west-2', 'eu-west-1']
      test_frequency: 60

  # CI/CD pipeline configuration
  cicd:
    github_actions:
      enabled: true
      environments: ['staging', 'production']
      approval_required: true
      branch_protection: true

    pipeline:
      terraform_version: '1.6.2'
      atmos_version: '1.63.0'
      parallel_execution: true
      drift_detection: true
      cost_estimation: true
      security_scanning: true
      compliance_validation: true

    deployment:
      strategy: 'blue-green'
      rollback_enabled: true
      health_checks: true
      smoke_tests: true
      canary_percentage: 10

  # Enterprise networking
  networking:
    vpc:
      cidr_block: '10.0.0.0/16'
      enable_dns_hostnames: true
      enable_dns_support: true
      enable_nat_gateway: true
      single_nat_gateway: false
      enable_vpn_gateway: false

    subnets:
      public:
        - cidr: '10.0.1.0/24'
          availability_zone: 'us-east-1a'
        - cidr: '10.0.2.0/24'
          availability_zone: 'us-east-1b'
        - cidr: '10.0.3.0/24'
          availability_zone: 'us-east-1c'

      private:
        - cidr: '10.0.10.0/24'
          availability_zone: 'us-east-1a'
        - cidr: '10.0.20.0/24'
          availability_zone: 'us-east-1b'
        - cidr: '10.0.30.0/24'
          availability_zone: 'us-east-1c'

      database:
        - cidr: '10.0.100.0/24'
          availability_zone: 'us-east-1a'
        - cidr: '10.0.200.0/24'
          availability_zone: 'us-east-1b'
        - cidr: '10.0.300.0/24'
          availability_zone: 'us-east-1c'

    security_groups:
      allow_https_from_alb: true
      allow_ssh_from_bastion: true
      database_access_restricted: true

    transit_gateway:
      enabled: true
      amazon_side_asn: 64512
      cross_region_peering: true

  # High availability configuration
  high_availability:
    multi_az: true
    auto_scaling: true
    load_balancing: true
    health_checks: true
    failover_enabled: true
    backup_enabled: true
    backup_retention_days: 30
    cross_region_backup: true
    disaster_recovery_enabled: true

components:
  terraform:
    # Core infrastructure components
    vpc:
      metadata:
        component: 'infra/vpc'
        inherits:
          - 'vpc/defaults'
      vars:
        cidr_block: '%{parent.networking.vpc.cidr_block}'
        enable_dns_hostnames: '%{parent.networking.vpc.enable_dns_hostnames}'
        enable_dns_support: '%{parent.networking.vpc.enable_dns_support}'

    security-compliance:
      metadata:
        component: 'security/compliance-monitoring'
      vars:
        compliance_frameworks: '%{parent.security.compliance_frameworks}'
        audit_log_retention_days: 2557 # 7 years for compliance
        hipaa_enabled: "%{parent.security.compliance_frameworks | selectattr('name', 'equalto', 'HIPAA') | list | length > 0}"

    monitoring-observability:
      metadata:
        component: 'monitoring/enterprise-observability'
      vars:
        prometheus_config: '%{parent.monitoring.prometheus}'
        grafana_config: '%{parent.monitoring.grafana}'
        elasticsearch_enabled: '%{parent.monitoring.elasticsearch.enabled}'
        elasticsearch_instance_type: '%{parent.monitoring.elasticsearch.instance_type}'
        elasticsearch_instance_count: '%{parent.monitoring.elasticsearch.instance_count}'

    cicd-pipeline:
      metadata:
        component: 'cicd/enterprise-pipeline'
      vars:
        github_actions_enabled: '%{parent.cicd.github_actions.enabled}'
        approval_required: '%{parent.cicd.github_actions.approval_required}'
        terraform_version: '%{parent.cicd.pipeline.terraform_version}'
        atmos_version: '%{parent.cicd.pipeline.atmos_version}'
        drift_detection_schedule: 'rate(6 hours)'
```

## 📚 Enterprise References and Documentation

- **Atmos Documentation**: [atmos.tools](https://atmos.tools) - Comprehensive Atmos CLI and configuration guide
- **Terraform Enterprise**: [terraform.io](https://terraform.io) - Advanced Terraform patterns and best practices
- **AWS Well-Architected**: [aws.amazon.com/architecture/well-architected](https://aws.amazon.com/architecture/well-architected) - Enterprise architecture principles
- **Cloud Security Alliance**: [cloudsecurityalliance.org](https://cloudsecurityalliance.org) - Cloud security best practices and compliance
- **NIST Cybersecurity Framework**: [nist.gov/cyberframework](https://nist.gov/cyberframework) - Security and compliance standards
- **Terraform Registry**: [registry.terraform.io](https://registry.terraform.io) - Community modules and providers
- **Policy as Code**: [openpolicyagent.org](https://openpolicyagent.org) - OPA policies for infrastructure governance
- **GitOps**: [gitops.tech](https://gitops.tech) - GitOps principles and implementation patterns

### Enterprise Support and Escalation

- **Infrastructure Team**: infrastructure@enterprise.com - Primary support for Atmos-Terraform deployments
- **Security Team**: security@enterprise.com - Security compliance and vulnerability management
- **Platform Engineering**: platform@enterprise.com - Enterprise architecture and best practices
- **On-Call Escalation**: +1-555-INFRA-1 - 24/7 production infrastructure support

```

```
