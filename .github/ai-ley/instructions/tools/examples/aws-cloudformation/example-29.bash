# Enterprise resource naming standards
# Format: [project]-[environment]-[service]-[identifier]

# Examples:
S3_BUCKET_NAME="myapp-prod-data-bucket"
RDS_INSTANCE="myapp-prod-primary-db"
LAMBDA_FUNCTION="myapp-prod-processor-fn"
SECURITY_GROUP="myapp-prod-web-sg"
IAM_ROLE="myapp-prod-lambda-role"

# Stack naming convention
# Format: [project]-[component]-[environment]
STACK_NAME="myapp-infrastructure-prod"
NESTED_STACK="myapp-network-prod"

# Parameter naming convention
# Format: /[project]/[environment]/[component]/[parameter]
SSM_PARAMETER="/myapp/prod/database/password"
SECRETS_MANAGER="/myapp/prod/api/keys"

# Tag standardization (required on all resources)
STANDARD_TAGS = {
  "Name": "Resource specific name",
  "Environment": "prod|staging|dev",
  "Project": "Project name",
  "Owner": "Team responsible",
  "CostCenter": "Billing allocation",
  "DataClassification": "public|internal|confidential|restricted",
  "ComplianceFramework": "SOC2|PCI-DSS|HIPAA|CIS|NIST",
  "ManagedBy": "CloudFormation",
  "StackName": "CloudFormation stack name",
  "BackupEnabled": "true|false",
  "EncryptionEnabled": "true|false"
}