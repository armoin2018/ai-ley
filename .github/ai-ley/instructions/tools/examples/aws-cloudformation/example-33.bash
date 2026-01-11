# Template validation and deployment
aws cloudformation validate-template --template-body file://template.yaml
aws cloudformation create-stack --stack-name my-stack --template-body file://template.yaml --parameters file://params.json --capabilities CAPABILITY_IAM
aws cloudformation update-stack --stack-name my-stack --template-body file://template.yaml --parameters file://params.json
aws cloudformation delete-stack --stack-name my-stack

# Stack monitoring and troubleshooting
aws cloudformation describe-stacks --stack-name my-stack
aws cloudformation describe-stack-events --stack-name my-stack
aws cloudformation describe-stack-resources --stack-name my-stack
aws cloudformation get-stack-policy --stack-name my-stack

# Change sets for safe updates
aws cloudformation create-change-set --stack-name my-stack --template-body file://template.yaml --change-set-name my-changeset --parameters file://params.json
aws cloudformation describe-change-set --stack-name my-stack --change-set-name my-changeset
aws cloudformation execute-change-set --stack-name my-stack --change-set-name my-changeset

# Drift detection
aws cloudformation detect-stack-drift --stack-name my-stack
aws cloudformation describe-stack-drift-detection-status --stack-drift-detection-id <detection-id>
aws cloudformation describe-stack-resource-drifts --stack-name my-stack

# Stack exports and imports
aws cloudformation list-exports
aws cloudformation list-imports --export-name my-export

# StackSets for multi-account deployment
aws cloudformation create-stack-set --stack-set-name my-stackset --template-body file://template.yaml --capabilities CAPABILITY_IAM
aws cloudformation create-stack-instances --stack-set-name my-stackset --accounts 123456789012 --regions us-east-1

# Template and stack analysis
aws cloudformation estimate-template-cost --template-body file://template.yaml --parameters file://params.json
aws cloudformation get-template-summary --template-body file://template.yaml