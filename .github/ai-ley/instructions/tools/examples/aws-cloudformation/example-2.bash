# Core AWS CLI v2 (latest)
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

# AWS CDK for advanced constructs
npm install -g aws-cdk@latest
npm install -g aws-cdk-lib constructs

# AWS SAM CLI for serverless applications
pip install aws-sam-cli

# AWS Copilot for container applications
curl -Lo copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux
chmod +x copilot && sudo mv copilot /usr/local/bin/

# CloudFormation utilities
pip install aws-cfn-cli-resource-providers
pip install cfn-flip cfn-lint
npm install -g @aws-cdk/cfnspec

# Enterprise security and compliance tools
pip install prowler checkov
npm install -g cdk-nag

# Performance and cost optimization tools
pip install aws-cost-explorer-cli
curl -o aws-nuke https://github.com/rebuy-de/aws-nuke/releases/latest/download/aws-nuke-linux-amd64
chmod +x aws-nuke && sudo mv aws-nuke /usr/local/bin/

# Verify installations
aws --version
cdk --version
sam --version
copilot --version
cfn-lint --version
checkov --version