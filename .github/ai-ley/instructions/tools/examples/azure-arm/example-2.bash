# Interactive authentication with device code
az login --use-device-code

# Service Principal authentication (for automation)
az login --service-principal \
  --username "$AZURE_CLIENT_ID" \
  --password "$AZURE_CLIENT_SECRET" \
  --tenant "$AZURE_TENANT_ID"

# Managed Identity authentication (for Azure VMs)
az login --identity

# Configure multi-subscription management
az account list --output table
az account set --subscription "Production-Subscription-ID"

# Set up subscription aliases for easy management
az account alias create --name "prod" --subscription "Production-Subscription-ID"
az account alias create --name "dev" --subscription "Development-Subscription-ID"
az account alias create --name "staging" --subscription "Staging-Subscription-ID"

# Configure default settings for enterprise consistency
az configure --defaults \
  location=eastus \
  group=rg-enterprise-shared \
  output=table

# Set up Azure Cloud Shell for consistent environment
# https://shell.azure.com