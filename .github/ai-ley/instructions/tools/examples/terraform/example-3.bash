# Install Terraform CLI (latest stable)
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

# macOS via Homebrew
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# Verify installation
terraform version

# Install additional HashiCorp tools
brew install hashicorp/tap/vault
brew install hashicorp/tap/consul
brew install hashicorp/tap/packer

# Configure Terraform Cloud CLI
terraform login app.terraform.io

# Install terraform-docs for documentation generation
brew install terraform-docs

# Install tflint for linting
brew install tflint

# Install terragrunt for orchestration
brew install terragrunt

# Install checkov for security scanning
pip3 install checkov

# Install terrascan for policy validation
brew install terrascan