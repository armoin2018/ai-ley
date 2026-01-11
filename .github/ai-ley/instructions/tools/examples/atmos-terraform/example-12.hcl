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