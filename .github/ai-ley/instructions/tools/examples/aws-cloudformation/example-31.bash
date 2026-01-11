# Issue 1: Stack rollback due to resource dependencies
# Solution: Check dependency chain and add explicit DependsOn

# Check stack events for failure details
aws cloudformation describe-stack-events \
  --stack-name your-stack-name \
  --query 'StackEvents[?ResourceStatus==`CREATE_FAILED`]'

# Issue 2: IAM permissions insufficient
# Solution: Check IAM policies and resource-based policies

# Validate IAM permissions
aws iam simulate-principal-policy \
  --policy-source-arn arn:aws:iam::123456789012:role/CloudFormation-Role \
  --action-names s3:CreateBucket \
  --resource-arns arn:aws:s3:::my-bucket

# Issue 3: Parameter validation errors
# Solution: Verify parameter constraints and allowed values

# Validate template before deployment
aws cloudformation validate-template \
  --template-body file://template.yaml

# Issue 4: Resource limits exceeded
# Solution: Check service quotas and request increases

# Check service quotas
aws service-quotas list-service-quotas \
  --service-code ec2 \
  --query 'Quotas[?QuotaName==`EC2-VPC Instances`]'

# Issue 5: Drift detection showing configuration changes
# Solution: Update template to match actual configuration

# Detect drift
aws cloudformation detect-stack-drift --stack-name your-stack-name

# Get drift details
aws cloudformation describe-stack-drift-detection-status \
  --stack-drift-detection-id drift-detection-id