# modules/monitoring/main.tf - Enterprise monitoring infrastructure
resource "aws_ecs_cluster" "monitoring" {
  name = "${var.name_prefix}-monitoring"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.enterprise.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ecs_monitoring.name
      }
    }
  }

  tags = local.enterprise_tags
}

# Prometheus service
resource "aws_ecs_service" "prometheus" {
  name            = "prometheus"
  cluster         = aws_ecs_cluster.monitoring.id
  task_definition = aws_ecs_task_definition.prometheus.arn
  desired_count   = var.monitoring_configuration.enable_prometheus ? 2 : 0

  launch_type = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.monitoring.id]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.prometheus.arn
    container_name   = "prometheus"
    container_port   = 9090
  }

  service_registries {
    registry_arn = aws_service_discovery_service.prometheus.arn
  }

  tags = local.enterprise_tags
}

# Grafana service
resource "aws_ecs_service" "grafana" {
  name            = "grafana"
  cluster         = aws_ecs_cluster.monitoring.id
  task_definition = aws_ecs_task_definition.grafana.arn
  desired_count   = var.monitoring_configuration.enable_grafana ? 1 : 0

  launch_type = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.monitoring.id]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.grafana.arn
    container_name   = "grafana"
    container_port   = 3000
  }

  tags = local.enterprise_tags
}

# CloudWatch monitoring integration
resource "aws_cloudwatch_dashboard" "infrastructure" {
  dashboard_name = "${var.name_prefix}-infrastructure"

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
            ["AWS/EC2", "CPUUtilization"],
            ["AWS/RDS", "CPUUtilization"],
            ["AWS/ApplicationELB", "TargetResponseTime"]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_primary_region
          title   = "Infrastructure Performance Metrics"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/VPC", "FlowLogRecords"],
            ["AWS/CloudTrail", "EventCount"]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_primary_region
          title   = "Security Monitoring"
          period  = 300
        }
      }
    ]
  })

  tags = local.enterprise_tags
}