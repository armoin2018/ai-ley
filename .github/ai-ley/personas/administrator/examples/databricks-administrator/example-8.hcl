resource "databricks_workspace" "production" {
  account_id     = var.databricks_account_id
  workspace_name = "production-workspace"
  deployment_name = "prod-databricks"
  aws_region     = "us-east-1"
  pricing_tier   = "ENTERPRISE"
  
  network_id = databricks_mws_networks.production.network_id
  storage_configuration_id = databricks_mws_storage_configurations.production.storage_configuration_id
  
  tags = {
    Environment = "production"
    Team        = "data-platform"
  }
}