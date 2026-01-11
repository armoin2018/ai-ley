# Stack operations
aws cloudformation create-stack --stack-name <name> --template-body file://template.yaml
aws cloudformation update-stack --stack-name <name> --template-body file://template.yaml
aws cloudformation delete-stack --stack-name <name>
aws cloudformation describe-stacks --stack-name <name>

# Template validation
aws cloudformation validate-template --template-body file://template.yaml

# Stack events and status
aws cloudformation describe-stack-events --stack-name <name>
aws cloudformation describe-stack-resources --stack-name <name>

# Change sets
aws cloudformation create-change-set --stack-name <name> --change-set-name <changeset-name> --template-body file://template.yaml
aws cloudformation execute-change-set --change-set-name <changeset-name>

# List stacks
aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE