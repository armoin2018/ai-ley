# sentinel-policies.tf - Enterprise policy management
resource "tfe_policy_set" "enterprise_security" {
  name          = "enterprise-security-policies"
  description   = "Enterprise security and compliance policies"
  organization  = var.tfe_organization

  # Policy enforcement levels
  policies_path = "policies/security/"

  # Apply to all workspaces with specific tags
  workspace_ids = []

  # Global policy set
  global = true

  # Version control integration
  vcs_repo {
    identifier     = "enterprise/terraform-policies"
    branch         = "main"
    oauth_token_id = var.vcs_oauth_token
  }
}

# Cost management policy set
resource "tfe_policy_set" "cost_management" {
  name         = "cost-management-policies"
  description  = "Cost optimization and budget enforcement policies"
  organization = var.tfe_organization

  policies_path = "policies/cost/"
  global       = true

  vcs_repo {
    identifier     = "enterprise/terraform-policies"
    branch         = "main"
    oauth_token_id = var.vcs_oauth_token
  }
}

# Environment-specific policy sets
resource "tfe_policy_set" "production_compliance" {
  name         = "production-compliance"
  description  = "Strict compliance policies for production environments"
  organization = var.tfe_organization

  policies_path = "policies/compliance/production/"

  # Apply only to production workspaces
  workspace_ids = [for ws in tfe_workspace.enterprise_infrastructure : ws.id if strcontains(ws.name, "prod")]

  vcs_repo {
    identifier     = "enterprise/terraform-policies"
    branch         = "main"
    oauth_token_id = var.vcs_oauth_token
  }
}