# terraform-monitoring-setup.sh - Enterprise monitoring and observability
cat > terraform-monitoring-setup.sh << 'EOF'
#!/bin/bash
set -euo pipefail

PROJECT_NAME="${1:-enterprise}"
MONITORING_STACK="${2:-prometheus}"  # prometheus, datadog, cloudwatch
TFE_ORGANIZATION="${3:-enterprise-org}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [TF-MONITORING] $*"
}

# Setup Terraform Cloud monitoring
setup_tfe_monitoring() {
    log "Setting up Terraform Cloud monitoring and alerting..."

    cat > terraform-monitoring.tf << MONITORING_EOF
# Terraform Cloud workspace monitoring
resource "tfe_notification_configuration" "deployment_notifications" {
  count            = length(var.notification_configs)
  name             = var.notification_configs[count.index].name
  enabled          = true
  destination_type = var.notification_configs[count.index].type

  # Notification triggers
  triggers = [
    "run:planning",
    "run:needs_attention",
    "run:applying",
    "run:completed",
    "run:errored",
    "assessment:check_failure",
    "assessment:drifted",
    "assessment:failed"
  ]

  # Workspace association
  workspace_id = tfe_workspace.enterprise_infrastructure[count.index].id

  # Destination configuration
  url   = var.notification_configs[count.index].url
  token = var.notification_configs[count.index].token
}

# Workspace health monitoring
data "tfe_workspace" "monitored_workspaces" {
  count        = length(var.workspaces_to_monitor)
  name         = var.workspaces_to_monitor[count.index]
  organization = var.tfe_organization
}

# Custom monitoring resource
resource "null_resource" "workspace_health_check" {
  count = length(data.tfe_workspace.monitored_workspaces)

  triggers = {
    workspace_id = data.tfe_workspace.monitored_workspaces[count.index].id
    check_time   = timestamp()
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Health check script
      python3 << PYTHON
import requests
import json
import os
from datetime import datetime, timedelta

def check_workspace_health():
    headers = {
        'Authorization': f'Bearer {os.environ["TFE_TOKEN"]}',
        'Content-Type': 'application/vnd.api+json'
    }

    workspace_id = "${data.tfe_workspace.monitored_workspaces[count.index].id}"

    # Get recent runs
    runs_url = f"https://app.terraform.io/api/v2/workspaces/{workspace_id}/runs"
    response = requests.get(runs_url, headers=headers)

    if response.status_code == 200:
        runs = response.json()['data']
        recent_runs = runs[:5]  # Last 5 runs

        # Analyze run health
        failed_runs = [r for r in recent_runs if r['attributes']['status'] in ['errored', 'canceled']]
        success_rate = (len(recent_runs) - len(failed_runs)) / len(recent_runs) if recent_runs else 1

        # Generate health metrics
        health_data = {
            'workspace_id': workspace_id,
            'timestamp': datetime.now().isoformat(),
            'success_rate': success_rate,
            'recent_runs_count': len(recent_runs),
            'failed_runs_count': len(failed_runs),
            'health_status': 'healthy' if success_rate >= 0.8 else 'degraded' if success_rate >= 0.6 else 'unhealthy'
        }

        # Store metrics (could be sent to monitoring system)
        with open(f'/tmp/workspace_health_{workspace_id}.json', 'w') as f:
            json.dump(health_data, f, indent=2)

        print(f"Workspace health check completed: {health_data['health_status']}")

    else:
        print(f"Failed to fetch workspace health: {response.status_code}")

check_workspace_health()
PYTHON
    EOT

    environment = {
      TFE_TOKEN = var.tfe_token
    }
  }
}
MONITORING_EOF

    log "✓ Terraform Cloud monitoring configuration created"
}

# Setup Prometheus monitoring
setup_prometheus_monitoring() {
    log "Setting up Prometheus monitoring for Terraform infrastructure..."

    mkdir -p ./monitoring/{prometheus,grafana,alertmanager}

    # Prometheus configuration
    cat > ./monitoring/prometheus/prometheus.yml << PROM_EOF
global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - "terraform_rules.yml"
  - "infrastructure_rules.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets:
          - alertmanager:9093

scrape_configs:
  # Terraform Cloud API metrics
  - job_name: 'terraform-cloud'
    metrics_path: '/api/v2/admin/terraform-versions'
    static_configs:
      - targets: ['app.terraform.io']
    bearer_token: '${TFE_TOKEN}'
    scrape_interval: 60s

  # Infrastructure metrics
  - job_name: 'aws-cloudwatch'
    static_configs:
      - targets: ['cloudwatch-exporter:9106']

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']

  # Custom Terraform metrics exporter
  - job_name: 'terraform-exporter'
    static_configs:
      - targets: ['terraform-exporter:8080']
PROM_EOF

    # Terraform-specific alerting rules
    cat > ./monitoring/prometheus/terraform_rules.yml << RULES_EOF
groups:
- name: terraform-infrastructure
  rules:
  - alert: TerraformRunFailure
    expr: terraform_run_status{status="errored"} > 0
    for: 0m
    labels:
      severity: critical
    annotations:
      summary: "Terraform run failed"
      description: "Terraform run {{ \$labels.workspace }} has failed with status {{ \$labels.status }}"

  - alert: TerraformDriftDetected
    expr: terraform_drift_detected > 0
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Infrastructure drift detected"
      description: "Configuration drift detected in workspace {{ \$labels.workspace }}"

  - alert: TerraformStateLocked
    expr: terraform_state_locked > 300
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Terraform state locked for extended period"
      description: "State for workspace {{ \$labels.workspace }} has been locked for over 5 minutes"

  - alert: TerraformCostThresholdExceeded
    expr: terraform_estimated_cost > terraform_cost_threshold
    for: 0m
    labels:
      severity: warning
    annotations:
      summary: "Infrastructure cost threshold exceeded"
      description: "Estimated cost \${{ \$value }} exceeds threshold for workspace {{ \$labels.workspace }}"

  - alert: TerraformComplianceViolation
    expr: terraform_compliance_violations > 0
    for: 0m
    labels:
      severity: critical
    annotations:
      summary: "Compliance violation detected"
      description: "{{ \$value }} compliance violations found in workspace {{ \$labels.workspace }}"
RULES_EOF

    log "✓ Prometheus monitoring setup completed"
}

# Setup comprehensive logging
setup_terraform_logging() {
    log "Setting up centralized logging for Terraform operations..."

    cat > terraform-logging.tf << LOGGING_EOF
# CloudWatch log groups for Terraform operations
resource "aws_cloudwatch_log_group" "terraform_operations" {
  name              = "/aws/terraform/operations"
  retention_in_days = var.log_retention_days

  kms_key_id = aws_kms_key.terraform_logging.arn

  tags = var.common_tags
}

resource "aws_cloudwatch_log_group" "terraform_compliance" {
  name              = "/aws/terraform/compliance"
  retention_in_days = var.log_retention_days

  kms_key_id = aws_kms_key.terraform_logging.arn

  tags = var.common_tags
}

# KMS key for log encryption
resource "aws_kms_key" "terraform_logging" {
  description             = "KMS key for Terraform logging encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableLogServiceAccess"
        Effect = "Allow"
        Principal = {
          Service = "logs.amazonaws.com"
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

  tags = var.common_tags
}

# Log analytics and alerting
resource "aws_cloudwatch_metric_filter" "terraform_errors" {
  name           = "terraform-errors"
  log_group_name = aws_cloudwatch_log_group.terraform_operations.name
  pattern        = "ERROR"

  metric_transformation {
    name      = "TerraformErrors"
    namespace = "Terraform/Operations"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_filter" "terraform_warnings" {
  name           = "terraform-warnings"
  log_group_name = aws_cloudwatch_log_group.terraform_operations.name
  pattern        = "WARN"

  metric_transformation {
    name      = "TerraformWarnings"
    namespace = "Terraform/Operations"
    value     = "1"
  }
}

# SNS topic for alerts
resource "aws_sns_topic" "terraform_alerts" {
  name              = "terraform-infrastructure-alerts"
  kms_master_key_id = "alias/aws/sns"

  tags = var.common_tags
}

# CloudWatch alarms
resource "aws_cloudwatch_metric_alarm" "high_error_rate" {
  alarm_name          = "terraform-high-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "TerraformErrors"
  namespace           = "Terraform/Operations"
  period              = "300"
  statistic           = "Sum"
  threshold           = "5"
  alarm_description   = "This metric monitors terraform error rate"
  alarm_actions       = [aws_sns_topic.terraform_alerts.arn]

  tags = var.common_tags
}
LOGGING_EOF

    log "✓ Centralized logging configuration created"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    log "Setting up Terraform enterprise monitoring..."
    log "Project: $PROJECT_NAME"
    log "Monitoring Stack: $MONITORING_STACK"
    log "TFE Organization: $TFE_ORGANIZATION"

    setup_tfe_monitoring
    setup_terraform_logging

    case "$MONITORING_STACK" in
        "prometheus")
            setup_prometheus_monitoring
            ;;
        "datadog")
            log "Datadog integration not implemented in this example"
            ;;
        "cloudwatch")
            log "CloudWatch integration not implemented in this example"
            ;;
    esac

    log "Terraform enterprise monitoring setup completed"
fi
EOF

chmod +x terraform-monitoring-setup.sh