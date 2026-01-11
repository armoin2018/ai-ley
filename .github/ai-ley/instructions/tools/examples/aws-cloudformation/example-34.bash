# Nested stack deployment with dependencies
aws cloudformation package --template-file parent.yaml --s3-bucket my-templates --output-template-file packaged.yaml
aws cloudformation deploy --template-file packaged.yaml --stack-name my-parent-stack --capabilities CAPABILITY_IAM

# Cross-region deployment
aws cloudformation create-stack --stack-name my-stack --template-body file://template.yaml --region us-west-2

# Stack termination protection
aws cloudformation update-termination-protection --enable-termination-protection --stack-name my-stack

# Resource import into existing stack
aws cloudformation create-change-set --stack-name existing-stack --change-set-name import-changeset --change-set-type IMPORT --resources-to-import file://resources-to-import.json

# Stack output processing
aws cloudformation describe-stacks --stack-name my-stack --query 'Stacks[0].Outputs[?OutputKey==`DatabaseEndpoint`].OutputValue' --output text

# Bulk operations
aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE --query 'StackSummaries[].StackName' --output text | xargs -I {} aws cloudformation describe-stacks --stack-name {}