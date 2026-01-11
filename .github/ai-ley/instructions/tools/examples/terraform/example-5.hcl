# variables.tf - Enterprise variable architecture
# Global Configuration Variables
variable "project_name" {
  description = "Name of the enterprise project"
  type        = string
  validation {
    condition     = length(var.project_name) >= 3 && length(var.project_name) <= 20
    error_message = "Project name must be between 3 and 20 characters."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  validation {
    condition     = contains(["dev", "test", "staging", "prod", "dr"], var.environment)
    error_message = "Environment must be one of: dev, test, staging, prod, dr."
  }
}

variable "enterprise_cidr_block" {
  description = "Enterprise-wide CIDR block for multi-cloud networking"
  type        = string
  default     = "10.0.0.0/8"
  validation {
    condition     = can(cidrhost(var.enterprise_cidr_block, 0))
    error_message = "Enterprise CIDR block must be a valid CIDR notation."
  }
}

# Multi-Cloud Configuration
variable "cloud_providers" {
  description = "List of cloud providers to deploy infrastructure"
  type        = list(string)
  default     = ["aws", "azure", "gcp"]
  validation {
    condition = alltrue([
      for provider in var.cloud_providers :
      contains(["aws", "azure", "gcp", "on-premise"], provider)
    ])
    error_message = "Cloud providers must be from: aws, azure, gcp, on-premise."
  }
}

# AWS Multi-Region Configuration
variable "aws_regions" {
  description = "AWS regions for multi-region deployment"
  type = map(object({
    primary             = bool
    availability_zones  = list(string)
    disaster_recovery   = bool
    compliance_required = bool
  }))
  default = {
    "us-west-2" = {
      primary             = true
      availability_zones  = ["us-west-2a", "us-west-2b", "us-west-2c"]
      disaster_recovery   = false
      compliance_required = true
    }
    "us-east-1" = {
      primary             = false
      availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]
      disaster_recovery   = true
      compliance_required = true
    }
  }
}

# Security & Compliance Configuration
variable "security_configuration" {
  description = "Enterprise security configuration settings"
  type = object({
    enable_encryption_at_rest       = bool
    enable_encryption_in_transit    = bool
    enable_network_segmentation     = bool
    enable_intrusion_detection      = bool
    enable_vulnerability_scanning   = bool
    enable_secrets_management       = bool
    enable_identity_federation      = bool
    enable_multi_factor_auth        = bool
    security_monitoring_level       = string
    data_loss_prevention_enabled    = bool
  })
  default = {
    enable_encryption_at_rest       = true
    enable_encryption_in_transit    = true
    enable_network_segmentation     = true
    enable_intrusion_detection      = true
    enable_vulnerability_scanning   = true
    enable_secrets_management       = true
    enable_identity_federation      = true
    enable_multi_factor_auth        = true
    security_monitoring_level       = "high"
    data_loss_prevention_enabled    = true
  }
}

# Monitoring & Observability Configuration
variable "monitoring_configuration" {
  description = "Enterprise monitoring and observability settings"
  type = object({
    enable_prometheus           = bool
    enable_grafana             = bool
    enable_elasticsearch       = bool
    enable_datadog             = bool
    enable_new_relic           = bool
    log_retention_days         = number
    metrics_retention_days     = number
    alerting_channels          = list(string)
    dashboard_auto_provisioning = bool
    sli_slo_monitoring         = bool
  })
  default = {
    enable_prometheus           = true
    enable_grafana             = true
    enable_elasticsearch       = true
    enable_datadog             = false
    enable_new_relic           = false
    log_retention_days         = 90
    metrics_retention_days     = 365
    alerting_channels          = ["slack", "email", "pagerduty"]
    dashboard_auto_provisioning = true
    sli_slo_monitoring         = true
  }
}