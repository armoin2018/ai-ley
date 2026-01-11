# cost-optimization.tf - Enterprise cost management
# Scheduled scaling for non-production environments
resource "aws_autoscaling_schedule" "scale_down_evening" {
  count = var.environment != "prod" ? 1 : 0

  scheduled_action_name  = "scale-down-evening"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence            = "0 19 * * MON-FRI"
  time_zone             = "America/Los_Angeles"
  autoscaling_group_name = aws_autoscaling_group.app.name
}

# Spot instance integration for cost savings
resource "aws_launch_template" "spot_template" {
  name_prefix   = "${var.name_prefix}-spot"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.app.id]

  instance_market_options {
    market_type = "spot"
    spot_options {
      spot_instance_type = "persistent"
      max_price         = var.spot_max_price
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.enterprise_tags, {
      Name = "${var.name_prefix}-spot-instance"
      Type = "Spot"
    })
  }
}