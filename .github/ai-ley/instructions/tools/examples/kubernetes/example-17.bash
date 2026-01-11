# Cluster management
kubectl cluster-info                          # Display cluster information
kubectl get nodes                            # List cluster nodes
kubectl describe node node-name              # Node details
kubectl top nodes                            # Node resource usage
kubectl drain node-name                      # Drain node for maintenance
kubectl uncordon node-name                   # Make node schedulable

# Pod management
kubectl get pods                             # List pods in current namespace
kubectl get pods --all-namespaces          # List all pods
kubectl get pods -o wide                    # Extended pod information
kubectl describe pod pod-name               # Detailed pod information
kubectl logs pod-name                       # View pod logs
kubectl logs -f pod-name                    # Follow pod logs
kubectl exec -it pod-name -- /bin/bash     # Execute commands in pod

# Deployment management
kubectl get deployments                     # List deployments
kubectl create deployment app --image=nginx # Create deployment
kubectl scale deployment app --replicas=5   # Scale deployment
kubectl set image deployment/app nginx=nginx:1.21 # Update image
kubectl rollout status deployment/app       # Check rollout status
kubectl rollout history deployment/app      # View rollout history
kubectl rollout undo deployment/app         # Rollback deployment

# Service management
kubectl get services                         # List services
kubectl expose deployment app --port=80     # Expose deployment as service
kubectl port-forward service/app 8080:80    # Forward local port to service
kubectl proxy                              # Start kubectl proxy

# Configuration management
kubectl get configmaps                      # List ConfigMaps
kubectl get secrets                         # List Secrets
kubectl create configmap app-config --from-file=config.yaml
kubectl create secret generic app-secret --from-literal=key=value

# Namespace management
kubectl get namespaces                      # List namespaces
kubectl create namespace production         # Create namespace
kubectl config set-context --current --namespace=production # Set default namespace

# Resource management
kubectl apply -f deployment.yaml           # Apply configuration
kubectl delete -f deployment.yaml          # Delete resources
kubectl get all                           # List all resources
kubectl get events                        # View cluster events
kubectl top pods                          # Pod resource usage

# Advanced operations
kubectl get pods --field-selector=status.phase=Running # Filter pods
kubectl get pods --selector=app=web-app    # Select by labels
kubectl patch deployment app -p '{"spec":{"replicas":3}}' # Patch resource
kubectl replace -f deployment.yaml         # Replace resource
kubectl create -f deployment.yaml --dry-run=client -o yaml # Dry run