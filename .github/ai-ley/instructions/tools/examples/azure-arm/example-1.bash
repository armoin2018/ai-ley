# Azure CLI v2 (latest) - Core ARM deployment engine
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash  # Linux
brew update && brew install azure-cli  # macOS
# Windows: Download from https://aka.ms/installazurecliwindows

# Azure PowerShell for advanced management
# Linux/macOS
pwsh -Command "Install-Module -Name Az -Repository PSGallery -Force"
# Windows PowerShell
Install-Module -Name Az -Repository PSGallery -Force

# Bicep CLI for modern ARM template development
az bicep install
az bicep upgrade

# Azure DevOps CLI for CI/CD automation
az extension add --name azure-devops
az extension update --name azure-devops

# Azure Policy CLI for governance automation
az extension add --name policy
az extension add --name resource-graph

# ARM Template Toolkit (arm-ttk) for validation
git clone https://github.com/Azure/arm-ttk.git
cd arm-ttk/arm-ttk
Import-Module ./arm-ttk.psd1

# Additional enterprise tools
az extension add --name application-insights  # APM integration
az extension add --name log-analytics         # Log management
az extension add --name security-insights     # Security monitoring
az extension add --name costmanagement        # Cost optimization
az extension add --name advisor               # Best practices

# Verify installations
az --version
bicep --version
pwsh -Command "Get-InstalledModule Az"