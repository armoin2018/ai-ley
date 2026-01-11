# Deploy resource group
az group create --name myResourceGroup --location "East US"

# Deploy ARM template
az deployment group create \
  --resource-group myResourceGroup \
  --template-file templates/main.json \
  --parameters parameters/dev.parameters.json

# Deploy with inline parameters
az deployment group create \
  --resource-group myResourceGroup \
  --template-file templates/main.json \
  --parameters environment=prod vmSize=Standard_D4s_v3

# Validate template before deployment
az deployment group validate \
  --resource-group myResourceGroup \
  --template-file templates/main.json \
  --parameters parameters/dev.parameters.json