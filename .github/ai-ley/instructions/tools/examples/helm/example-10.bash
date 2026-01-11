# Chart development
helm create my-chart                    # Create new chart
helm lint my-chart                      # Validate chart
helm template my-chart ./my-chart       # Render templates locally
helm install --dry-run --debug my-release ./my-chart  # Test installation

# Release management
helm install my-release ./my-chart      # Install chart
helm upgrade my-release ./my-chart      # Upgrade release
helm rollback my-release 1              # Rollback to revision 1
helm uninstall my-release               # Remove release

# Repository management
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update                        # Update repository information
helm search repo postgres               # Search for charts
helm show values bitnami/postgresql     # Show chart values

# Release information
helm list                              # List releases
helm status my-release                 # Show release status
helm history my-release                # Show release history
helm get values my-release             # Show release values

# Package and distribute
helm package ./my-chart               # Package chart
helm repo index .                     # Create repository index