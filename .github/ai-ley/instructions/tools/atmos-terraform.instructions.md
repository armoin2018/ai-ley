---
name: 'Atmos-Terraform Enterprise Infrastructure Orchestration'
description: 'Enterprise Atmos-Terraform infrastructure orchestration with multi-cloud'
keywords: [automation, actions, atmos, architecture, benchmark, ci/cd, advanced, azure, atmos.yaml, aws]
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

See [example-1](./examples/atmos-terraform/example-1.yaml)

### Enterprise Stack Architecture

See [example-2](./examples/atmos-terraform/example-2.yaml)

### Production Environment Configuration

See [example-3](./examples/atmos-terraform/example-3.yaml)

### EKS Cluster Configuration

See [example-4](./examples/atmos-terraform/example-4.yaml)

## Enterprise Terraform Components

### VPC Component Architecture

See [example-5](./examples/atmos-terraform/example-5.hcl)

### Advanced Networking and Security

See [example-6](./examples/atmos-terraform/example-6.hcl)

## Enterprise Variables and Outputs Framework

### Comprehensive Variable Definitions

See [example-7](./examples/atmos-terraform/example-7.hcl)

### Enterprise Output Specifications

See [example-8](./examples/atmos-terraform/example-8.hcl)

## Enterprise CI/CD Pipeline Integration

### GitHub Actions Workflow

See [example-9](./examples/atmos-terraform/example-9.yaml)

## Enterprise Compliance and Security

### Policy as Code with OPA

See [example-10](./examples/atmos-terraform/example-10.rego)

### Compliance Monitoring

See [example-11](./examples/atmos-terraform/example-11.yaml)

## Enterprise Monitoring and Observability

### Prometheus and Grafana Integration

See [example-12](./examples/atmos-terraform/example-12.hcl)

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

See [example-13](./examples/atmos-terraform/example-13.yaml)

### 📊 Enterprise Cost Management

See [example-14](./examples/atmos-terraform/example-14.hcl)

`See [example-15](./examples/atmos-terraform/example-15.txt)yaml
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
            
  drift_detection:
    enabled: true
    schedule: "0 6 * * *"  # Daily at 6 AM
    notification:
      slack_webhook: "${DRIFT_NOTIFICATION_WEBHOOK}"
      email: "infrastructure@company.com"

  compliance_frameworks:
        enabled: true
      profile: "level2"
      auto_remediation: false
        enabled: true
      controls: ["CC6.1", "CC6.2", "CC6.3", "CC6.6", "CC6.7"]
        enabled: true
      scope: "cardholder_data_environment"
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
                    
  deploy:
    description: "Deploy infrastructure with approvals"
    steps:
                type: "manual"
        condition: "environment == 'prod'"
        timeout: "24h"
        
  destroy:
    description: "Destroy infrastructure with confirmations"
    steps:
            type: "input"
        prompt: "Type 'DESTROY' to confirm destruction of {stack}"
        validation: "exact:DESTROY"
                type: "manual"
        timeout: "1h"
    `See [example-16](./examples/atmos-terraform/example-16.txt)hcl
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

*Content optimized for conciseness. See external references for additional details.*

---
version: 3.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 5.0

---
version: 3.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 5.0
