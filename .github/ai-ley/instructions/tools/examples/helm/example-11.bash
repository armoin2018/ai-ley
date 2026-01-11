# Chart testing with different values
helm template my-release ./my-chart -f values-test.yaml

# Validate against Kubernetes
helm template my-release ./my-chart | kubectl apply --dry-run=client -f -

# Test installation without deploying
helm install my-release ./my-chart --dry-run --debug

# Chart testing with helm test
# Add test pods to templates/tests/
helm test my-release