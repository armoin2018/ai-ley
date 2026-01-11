# Enable debug mode
aws --debug s3 ls s3://my-bucket

# CloudFormation stack events
aws cloudformation describe-stack-events --stack-name my-stack

# EC2 instance console output
aws ec2 get-console-output --instance-id i-1234567890abcdef0