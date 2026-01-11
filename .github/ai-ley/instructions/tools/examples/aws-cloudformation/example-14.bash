# Create stack
aws cloudformation create-stack \
  --stack-name my-web-app-dev \
  --template-body file://templates/infrastructure/vpc.yaml \
  --parameters file://parameters/dev.json \
  --capabilities CAPABILITY_IAM \
  --tags Key=Environment,Value=dev Key=Project,Value=WebApp

# Update stack
aws cloudformation update-stack \
  --stack-name my-web-app-dev \
  --template-body file://templates/infrastructure/vpc.yaml \
  --parameters file://parameters/dev.json \
  --capabilities CAPABILITY_IAM

# Delete stack
aws cloudformation delete-stack \
  --stack-name my-web-app-dev

# Describe stack
aws cloudformation describe-stacks \
  --stack-name my-web-app-dev