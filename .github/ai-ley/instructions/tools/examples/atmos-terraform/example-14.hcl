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