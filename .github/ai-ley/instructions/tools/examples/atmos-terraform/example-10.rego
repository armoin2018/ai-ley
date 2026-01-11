# schemas/policies/terraform.rego - OPA policy for Terraform compliance
package terraform

import rego.v1

# Deny resources without required tags
deny contains msg if {
    resource := input.resource_changes[_]
    resource.change.actions[_] == "create"

    required_tags := ["Environment", "Owner", "CostCenter", "Compliance"]
    tag := required_tags[_]
    not resource.change.after.tags[tag]

    msg := sprintf("Resource %s missing required tag: %s", [resource.address, tag])
}

# Ensure encryption is enabled for storage resources
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_s3_bucket"
    resource.change.actions[_] == "create"

    not resource.change.after.server_side_encryption_configuration

    msg := sprintf("S3 bucket %s must have encryption enabled", [resource.address])
}

# Ensure VPC flow logs are enabled
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_vpc"
    resource.change.actions[_] == "create"

    # Check if flow log exists for this VPC
    flow_logs := [r | r := input.resource_changes[_]; r.type == "aws_flow_log"]
    count(flow_logs) == 0

    msg := sprintf("VPC %s must have flow logs enabled", [resource.address])
}

# Ensure NAT Gateway high availability in production
deny contains msg if {
    resource := input.resource_changes[_]
    resource.type == "aws_nat_gateway"
    resource.change.actions[_] == "create"

    # Check environment tag
    resource.change.after.tags.Environment == "production"

    # Count NAT gateways
    nat_gateways := [r | r := input.resource_changes[_]; r.type == "aws_nat_gateway"]
    count(nat_gateways) < 2

    msg := "Production environment must have at least 2 NAT Gateways for high availability"
}