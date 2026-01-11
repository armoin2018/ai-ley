# CloudWatch alarms for critical infrastructure
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  for_each = var.critical_resources

  alarm_name          = "${each.key}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors EC2 CPU utilization"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    InstanceId = each.value.instance_id
  }

  tags = local.enterprise_tags
}

# SNS topic for alerts
resource "aws_sns_topic" "alerts" {
  name         = "${var.name_prefix}-infrastructure-alerts"
  display_name = "Infrastructure Alerts"

  tags = local.enterprise_tags
}

# Lambda function for incident response automation
resource "aws_lambda_function" "incident_response" {
  filename         = data.archive_file.incident_response.output_path
  function_name    = "${var.name_prefix}-incident-response"
  role            = aws_iam_role.incident_response_lambda.arn
  handler         = "index.handler"
  source_code_hash = data.archive_file.incident_response.output_base64sha256
  runtime         = "python3.9"
  timeout         = 300

  environment {
    variables = {
      SLACK_WEBHOOK_URL = var.slack_webhook_url
      PAGERDUTY_API_KEY = var.pagerduty_api_key
      ENVIRONMENT       = var.environment
    }
  }

  tags = local.enterprise_tags
}

data "archive_file" "incident_response" {
  type        = "zip"
  output_path = "/tmp/incident_response.zip"

  source {
    content = templatefile("${path.module}/lambda/incident_response.py.tpl", {
      environment = var.environment
      project     = var.project_name
    })
    filename = "index.py"
  }
}