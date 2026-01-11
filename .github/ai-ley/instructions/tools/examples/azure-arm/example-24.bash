# Validate template syntax
az deployment group validate \
  --resource-group myRG \
  --template-file template.json \
  --parameters @parameters.json

# Check template with detailed error output
az deployment group create \
  --resource-group myRG \
  --template-file template.json \
  --parameters @parameters.json \
  --debug