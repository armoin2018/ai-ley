# Resource group operations
az group create --name myResourceGroup --location "East US"
az group delete --name myResourceGroup --yes

# Template deployment
az deployment group create --resource-group myRG --template-file template.json --parameters @parameters.json
az deployment sub create --location "East US" --template-file subscription-template.json
az deployment mg create --management-group-id myMG --template-file mg-template.json

# Template validation and testing
az deployment group validate --resource-group myRG --template-file template.json
az deployment group what-if --resource-group myRG --template-file template.json

# Deployment operations
az deployment group list --resource-group myRG
az deployment group show --resource-group myRG --name myDeployment
az deployment group cancel --resource-group myRG --name myDeployment

# Bicep operations
az bicep install                    # Install Bicep CLI
az bicep build main.bicep          # Compile Bicep to ARM template
az bicep decompile template.json   # Convert ARM template to Bicep