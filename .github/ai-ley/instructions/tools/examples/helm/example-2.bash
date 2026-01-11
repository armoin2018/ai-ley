# Create new chart
helm create my-web-app
cd my-web-app

# Install chart in development
helm install my-app . --namespace development --create-namespace

# Upgrade after changes
helm upgrade my-app . --namespace development

# Test with different values
helm install my-app-staging . --namespace staging --create-namespace \
  --set image.tag=staging \
  --set replicaCount=2