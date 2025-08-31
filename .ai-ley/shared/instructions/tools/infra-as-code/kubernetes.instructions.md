# Kubernetes Container Orchestration Instructions

## Tool Overview
- **Tool Name**: Kubernetes (K8s)
- **Version**: 1.28+ (Latest stable)
- **Category**: Container Orchestration Platform
- **Purpose**: Deploy, scale, and manage containerized applications
- **Prerequisites**: Docker, kubectl CLI, cluster access

## Installation & Setup

### kubectl CLI Installation
```bash
# macOS (via Homebrew)
brew install kubectl

# Ubuntu/Debian
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Windows (via chocolatey)
choco install kubernetes-cli

# Verify installation
kubectl version --client
```

### Cluster Setup Options
```bash
# Local development with minikube
brew install minikube
minikube start

# Local development with kind
brew install kind
kind create cluster
```

## Configuration

### Cluster Configuration
```yaml
# kubeconfig setup
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority-data: <ca-data>
    server: https://kubernetes.example.com
  name: production
contexts:
- context:
    cluster: production
    user: admin
  name: production
current-context: production
users:
- name: admin
  user:
    token: <auth-token>
```

## Core Features

### Pod Management
```yaml
# pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  containers:
  - name: web
    image: nginx:1.21
    ports:
    - containerPort: 80
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

### Deployment Management
```yaml
# deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web-app
        image: myapp:v1.2.3
        ports:
        - containerPort: 8080
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 5
```

### Service Discovery
```yaml
# service.yaml
apiVersion: v1
kind: Service
metadata:
  name: web-app-service
spec:
  selector:
    app: web-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
  type: LoadBalancer
```

## Common Commands
```bash
# Cluster management
kubectl cluster-info                     # Display cluster info
kubectl get nodes                       # List cluster nodes

# Resource management
kubectl get pods                        # List pods
kubectl get deployments                 # List deployments
kubectl get services                    # List services

# Resource operations
kubectl apply -f <file.yaml>            # Apply configuration
kubectl delete -f <file.yaml>           # Delete resources
kubectl scale deployment <name> --replicas=5  # Scale deployment

# Debugging
kubectl logs <pod-name>                 # View pod logs
kubectl exec -it <pod-name> -- /bin/bash  # Execute command in pod
kubectl describe pod <pod-name>         # Pod details
```

## Best Practices

### Resource Management
- Set appropriate resource requests and limits
- Use namespaces for environment separation
- Implement proper labeling and selectors
- Use ConfigMaps and Secrets for configuration

### Security Practices
```yaml
# security-context.yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-app
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
  containers:
  - name: app
    image: myapp:latest
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
```

## Common Use Cases

### Microservices Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: user-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: user-service
  template:
    metadata:
      labels:
        app: user-service
    spec:
      containers:
      - name: user-service
        image: user-service:v1.0.0
        ports:
        - containerPort: 8080
```

## Troubleshooting

### Common Issues
#### Issue 1: Pod Startup Failures
**Problem**: Pods fail to start or crash repeatedly
**Solution**:
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name> --previous
```

#### Issue 2: Service Connectivity Issues
**Problem**: Services cannot communicate
**Solution**:
```bash
kubectl get endpoints <service-name>
kubectl exec -it <pod-name> -- curl http://<service-name>
```

## Security Considerations

### RBAC Configuration
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: production
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

## AI Assistant Guidelines
When helping with Kubernetes implementation:

1. **Always use resource limits** to prevent resource exhaustion
2. **Implement health checks** (liveness and readiness probes)
3. **Use namespaces** for environment and team separation
4. **Include security contexts** for container security
5. **Suggest appropriate scaling strategies** based on workload
6. **Include monitoring and logging** configuration
7. **Recommend GitOps practices** for deployment automation
8. **Reference official Kubernetes documentation** for best practices

### Code Generation Rules
- Generate well-structured YAML manifests with proper formatting
- Include comprehensive resource definitions with limits and requests
- Use consistent labeling and selector strategies
- Implement proper security practices and least privilege access
- Include health checks and monitoring configuration
- Follow Kubernetes naming conventions and best practices
- Generate production-ready configurations with error handling