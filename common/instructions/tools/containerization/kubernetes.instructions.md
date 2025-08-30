---
title: 'Kubernetes Container Orchestration Instructions'
description: 'Comprehensive guide for Kubernetes container orchestration, scaling, service management, and enterprise deployment with monitoring and security'
category: 'Containerization'

tags:
  [
    'kubernetes',
    'k8s',
    'container-orchestration',
    'microservices',
    'scaling',
    'devops',
    'cloud-native',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/k8s/**'
  - '**/kubernetes/**'
  - '**/*.yaml'
  - '**/*.yml'
  - '**/deployment.yaml'
  - '**/service.yaml'
  - '**/ingress.yaml'
  - '**/configmap.yaml'
  - '**/secret.yaml'
---

# Kubernetes Container Orchestration Instructions

## Tool Overview

- **Tool Name**: Kubernetes (K8s)
- **Version**: 1.28+ (Latest stable with enhanced security and performance features)
- **Category**: Container Orchestration - Application Deployment and Management
- **Purpose**: Orchestrate containerized applications with automated deployment, scaling, load balancing, and self-healing capabilities
- **Prerequisites**: Docker, basic understanding of containerization, networking concepts, YAML configuration

## When to Use Kubernetes

### ✅ **Use Kubernetes When**

- Building microservices architectures requiring orchestration and service discovery
- Need automated scaling based on demand and resource utilization
- Deploying applications across multiple environments (dev, staging, production)
- Require high availability with load balancing and fault tolerance
- Building cloud-native applications with rolling updates and zero-downtime deployments
- Managing complex multi-service applications with dependencies
- Need resource management and optimization across compute clusters
- Building applications requiring service mesh and advanced networking

### ❌ **Avoid Kubernetes When**

- Building simple single-container applications
- Team lacks containerization and orchestration expertise
- Working with small-scale applications without scaling requirements
- Need quick prototyping without complex deployment needs
- Working with applications requiring specialized hardware configurations
- Building desktop applications or simple static websites
- Have limited infrastructure resources or budget constraints

## AI Agent Decision Matrix

### Project Complexity Assessment

| Project Type                  | Kubernetes Recommendation                      | Setup Complexity                  |
| ----------------------------- | ---------------------------------------------- | --------------------------------- |
| Microservices Architecture    | ✅ **Essential** - Perfect orchestration       | High - Multi-service coordination |
| Distributed Systems           | ✅ **Essential** - Service mesh integration    | High - Advanced networking        |
| Cloud-Native Applications     | ✅ **Essential** - Auto-scaling and resilience | High - Production deployment      |
| Web Applications (Multi-tier) | ✅ **Recommended** - Load balancing            | Medium - Service management       |
| API Gateway Applications      | ✅ **Recommended** - Traffic management        | Medium - Ingress configuration    |
| Batch Processing              | 🔄 **Consider** - Job orchestration            | Medium - CronJob setup            |
| Single Container Apps         | ❌ **Avoid** - Unnecessary complexity          | Low - Use Docker Compose          |

### Infrastructure Assessment

| Factor         | Small Scale              | Medium Scale          | Enterprise Scale         |
| -------------- | ------------------------ | --------------------- | ------------------------ |
| **Setup Time** | 2 days (managed cluster) | 1 week (self-managed) | 2-4 weeks (enterprise)   |
| **Node Count** | 3-5 nodes                | 10-50 nodes           | 50+ nodes                |
| **Services**   | 5-10 services            | 20-100 services       | 100+ services            |
| **Complexity** | Basic deployments        | Multi-environment     | Multi-cluster federation |

## Installation & Setup

### kubectl Installation

```bash
# macOS installation
brew install kubectl

# Linux installation
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Windows installation
curl.exe -LO "https://dl.k8s.io/release/v1.28.0/bin/windows/amd64/kubectl.exe"

# Verify installation
kubectl version --client
kubectl version --short
```

### Local Development Cluster

```bash
# Minikube installation and setup
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start local cluster
minikube start --driver=docker --cpus=4 --memory=8192
minikube addons enable ingress
minikube addons enable dashboard
minikube addons enable metrics-server

# Kind (Kubernetes in Docker) setup
go install sigs.k8s.io/kind@v0.20.0
kind create cluster --config=kind-config.yaml

# Docker Desktop Kubernetes
# Enable Kubernetes in Docker Desktop settings

# Verify cluster access
kubectl cluster-info
kubectl get nodes
kubectl get pods --all-namespaces
```

### Production Cluster Setup

```bash
# Managed Kubernetes services
# AWS EKS
eksctl create cluster --name production-cluster --region us-west-2 --nodegroup-name standard-workers --node-type m5.xlarge --nodes 3 --nodes-min 1 --nodes-max 4

# Google GKE
gcloud container clusters create production-cluster --zone us-central1-a --num-nodes 3 --machine-type n1-standard-4 --enable-autoscaling --min-nodes 1 --max-nodes 10

# Azure AKS
az aks create --resource-group myResourceGroup --name production-cluster --node-count 3 --node-vm-size Standard_D4s_v3 --enable-addons monitoring --generate-ssh-keys

# Configure kubectl for cluster access
aws eks update-kubeconfig --region us-west-2 --name production-cluster
gcloud container clusters get-credentials production-cluster --zone us-central1-a
az aks get-credentials --resource-group myResourceGroup --name production-cluster
```

## Configuration

### Production-Ready Application Deployment

```yaml
# deployment.yaml - Comprehensive application deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  namespace: production
  labels:
    app: web-app
    version: v1.0.0
    environment: production
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
        version: v1.0.0
    spec:
      serviceAccountName: web-app-sa
      securityContext:
        runAsNonRoot: true
        runAsUser: 1001
        fsGroup: 1001
      containers:
        - name: web-app
          image: myregistry/web-app:v1.0.0
          imagePullPolicy: Always
          ports:
            - containerPort: 3000
              name: http
              protocol: TCP
          env:
            - name: NODE_ENV
              value: 'production'
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: database-secrets
                  key: connection-string
            - name: REDIS_URL
              valueFrom:
                configMapKeyRef:
                  name: app-config
                  key: redis-url
            - name: JWT_SECRET
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: jwt-secret
          resources:
            requests:
              memory: '256Mi'
              cpu: '250m'
            limits:
              memory: '512Mi'
              cpu: '500m'
          livenessProbe:
            httpGet:
              path: /health
              port: 3000
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 3
          readinessProbe:
            httpGet:
              path: /ready
              port: 3000
            initialDelaySeconds: 5
            periodSeconds: 5
            timeoutSeconds: 3
            failureThreshold: 3
          startupProbe:
            httpGet:
              path: /startup
              port: 3000
            initialDelaySeconds: 10
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 30
          securityContext:
            allowPrivilegeEscalation: false
            runAsNonRoot: true
            runAsUser: 1001
            capabilities:
              drop:
                - ALL
            readOnlyRootFilesystem: true
          volumeMounts:
            - name: tmp-volume
              mountPath: /tmp
            - name: app-config
              mountPath: /app/config
              readOnly: true
            - name: app-storage
              mountPath: /app/storage
      volumes:
        - name: tmp-volume
          emptyDir: {}
        - name: app-config
          configMap:
            name: app-config
        - name: app-storage
          persistentVolumeClaim:
            claimName: app-storage-pvc
      imagePullSecrets:
        - name: registry-credentials
      nodeSelector:
        kubernetes.io/arch: amd64
      tolerations:
        - key: 'app'
          operator: 'Equal'
          value: 'web-app'
          effect: 'NoSchedule'
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
            - weight: 100
              podAffinityTerm:
                labelSelector:
                  matchExpressions:
                    - key: app
                      operator: In
                      values:
                        - web-app
                topologyKey: kubernetes.io/hostname
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 2
```

### Service Configuration

```yaml
# service.yaml - Load balancer service configuration
apiVersion: v1
kind: Service
metadata:
  name: web-app-service
  namespace: production
  labels:
    app: web-app
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: 'nlb'
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: 'http'
spec:
  type: LoadBalancer
  selector:
    app: web-app
  ports:
    - name: http
      port: 80
      targetPort: 3000
      protocol: TCP
    - name: https
      port: 443
      targetPort: 3000
      protocol: TCP
  sessionAffinity: ClientIP
  sessionAffinityConfig:
    clientIP:
      timeoutSeconds: 3600

---
# headless service for StatefulSet
apiVersion: v1
kind: Service
metadata:
  name: web-app-headless
  namespace: production
spec:
  clusterIP: None
  selector:
    app: web-app
  ports:
    - name: http
      port: 3000
      targetPort: 3000
```

### Ingress Configuration

```yaml
# ingress.yaml - Advanced ingress with SSL and routing
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-app-ingress
  namespace: production
  annotations:
    kubernetes.io/ingress.class: 'nginx'
    nginx.ingress.kubernetes.io/ssl-redirect: 'true'
    nginx.ingress.kubernetes.io/force-ssl-redirect: 'true'
    nginx.ingress.kubernetes.io/proxy-body-size: '50m'
    nginx.ingress.kubernetes.io/rate-limit: '100'
    nginx.ingress.kubernetes.io/rate-limit-window: '1m'
    nginx.ingress.kubernetes.io/enable-cors: 'true'
    nginx.ingress.kubernetes.io/cors-allow-origin: 'https://mydomain.com'
    cert-manager.io/cluster-issuer: 'letsencrypt-prod'
    nginx.ingress.kubernetes.io/configuration-snippet: |
      add_header X-Frame-Options SAMEORIGIN always;
      add_header X-Content-Type-Options nosniff always;
      add_header X-XSS-Protection "1; mode=block" always;
      add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
spec:
  tls:
    - hosts:
        - api.mydomain.com
        - app.mydomain.com
      secretName: web-app-tls
  rules:
    - host: api.mydomain.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web-app-service
                port:
                  number: 80
    - host: app.mydomain.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: frontend-service
                port:
                  number: 80
          - path: /api
            pathType: Prefix
            backend:
              service:
                name: web-app-service
                port:
                  number: 80
```

### ConfigMap and Secrets

```yaml
# configmap.yaml - Application configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: production
data:
  app.properties: |
    server.port=3000
    logging.level=info
    redis.url=redis://redis-service:6379
    database.pool.max=20
    database.pool.min=5
    cache.ttl=3600
  nginx.conf: |
    upstream backend {
        server web-app-service:80;
    }
    server {
        listen 80;
        location / {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
    }

---
# secret.yaml - Sensitive configuration
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
  namespace: production
type: Opaque
data:
  jwt-secret: <base64-encoded-secret>
  api-key: <base64-encoded-api-key>
  database-password: <base64-encoded-password>

---
# database-secrets.yaml - Database connection
apiVersion: v1
kind: Secret
metadata:
  name: database-secrets
  namespace: production
type: Opaque
stringData:
  connection-string: 'postgresql://user:password@postgres-service:5432/myapp'
  username: 'myapp_user'
  password: 'secure_password_123'
```

### Persistent Storage

```yaml
# storage.yaml - Persistent volume configuration
apiVersion: v1
kind: PersistentVolume
metadata:
  name: app-storage-pv
  labels:
    type: local
spec:
  storageClassName: fast-ssd
  capacity:
    storage: 100Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: '/mnt/data/app-storage'

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: app-storage-pvc
  namespace: production
spec:
  storageClassName: fast-ssd
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi

---
# StorageClass for dynamic provisioning
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-ssd
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp3
  iops: '3000'
  throughput: '125'
  encrypted: 'true'
allowVolumeExpansion: true
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```

## Core Features

### Horizontal Pod Autoscaler (HPA)

- **Purpose**: Automatically scale pods based on CPU, memory, or custom metrics
- **Usage**: Maintain optimal resource utilization and handle traffic spikes
- **Example**:

```yaml
# hpa.yaml - Horizontal Pod Autoscaler
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: web-app-hpa
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web-app
  minReplicas: 3
  maxReplicas: 20
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: 80
    - type: Pods
      pods:
        metric:
          name: requests_per_second
        target:
          type: AverageValue
          averageValue: '30'
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 10
          periodSeconds: 60
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
        - type: Percent
          value: 100
          periodSeconds: 15
        - type: Pods
          value: 4
          periodSeconds: 15
      selectPolicy: Max
```

### StatefulSet for Stateful Applications

- **Purpose**: Manage stateful applications with persistent identity and storage
- **Usage**: Databases, message queues, and applications requiring stable network identities
- **Example**:

```yaml
# statefulset.yaml - Database StatefulSet
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
  namespace: production
spec:
  serviceName: postgres-headless
  replicas: 3
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:15-alpine
          env:
            - name: POSTGRES_DB
              value: myapp
            - name: POSTGRES_USER
              valueFrom:
                secretKeyRef:
                  name: postgres-secret
                  key: username
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-secret
                  key: password
            - name: PGDATA
              value: /var/lib/postgresql/data/pgdata
          ports:
            - containerPort: 5432
              name: postgres
          resources:
            requests:
              memory: '1Gi'
              cpu: '500m'
            limits:
              memory: '2Gi'
              cpu: '1000m'
          livenessProbe:
            exec:
              command:
                - pg_isready
                - -U
                - $(POSTGRES_USER)
                - -d
                - $(POSTGRES_DB)
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            exec:
              command:
                - pg_isready
                - -U
                - $(POSTGRES_USER)
                - -d
                - $(POSTGRES_DB)
            initialDelaySeconds: 5
            periodSeconds: 5
          volumeMounts:
            - name: postgres-storage
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
    - metadata:
        name: postgres-storage
      spec:
        accessModes: ['ReadWriteOnce']
        storageClassName: 'fast-ssd'
        resources:
          requests:
            storage: 100Gi
```

### Jobs and CronJobs

- **Purpose**: Run batch processing and scheduled tasks
- **Usage**: Data processing, backups, and periodic maintenance tasks
- **Example**:

```yaml
# cronjob.yaml - Scheduled backup job
apiVersion: batch/v1
kind: CronJob
metadata:
  name: database-backup
  namespace: production
spec:
  schedule: '0 2 * * *' # Daily at 2 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: backup
              image: postgres:15-alpine
              env:
                - name: PGPASSWORD
                  valueFrom:
                    secretKeyRef:
                      name: postgres-secret
                      key: password
              command:
                - /bin/bash
                - -c
                - |
                  pg_dump -h postgres-service -U myapp_user myapp > /backup/backup-$(date +%Y%m%d-%H%M%S).sql
                  find /backup -name "*.sql" -mtime +7 -delete
              volumeMounts:
                - name: backup-storage
                  mountPath: /backup
          volumes:
            - name: backup-storage
              persistentVolumeClaim:
                claimName: backup-pvc
          restartPolicy: OnFailure
  successfulJobsHistoryLimit: 3
  failedJobsHistoryLimit: 1
  concurrencyPolicy: Forbid

---
# job.yaml - One-time migration job
apiVersion: batch/v1
kind: Job
metadata:
  name: database-migration
  namespace: production
spec:
  template:
    spec:
      containers:
        - name: migration
          image: myregistry/migration-tool:latest
          env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: database-secrets
                  key: connection-string
          command: ['npm', 'run', 'migrate']
      restartPolicy: Never
  backoffLimit: 3
  activeDeadlineSeconds: 1800
```

### NetworkPolicy for Security

- **Purpose**: Control network traffic between pods and services
- **Usage**: Implement micro-segmentation and security policies
- **Example**:

```yaml
# networkpolicy.yaml - Traffic control policies
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: web-app-network-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      app: web-app
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
      ports:
        - protocol: TCP
          port: 3000
    - from:
        - podSelector:
            matchLabels:
              app: frontend
      ports:
        - protocol: TCP
          port: 3000
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: postgres
      ports:
        - protocol: TCP
          port: 5432
    - to:
        - podSelector:
            matchLabels:
              app: redis
      ports:
        - protocol: TCP
          port: 6379
    - to: [] # Allow DNS
      ports:
        - protocol: UDP
          port: 53
```

## Common Commands

```bash
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
```

## Workflow Integration

### Development Workflow

1. **Local Development**: Use Minikube or Kind for local Kubernetes testing
2. **Image Building**: Build and tag container images for deployment
3. **Configuration**: Create Kubernetes manifests for application components
4. **Testing**: Deploy to development namespace and validate functionality
5. **CI/CD Integration**: Automated deployment pipelines with GitOps
6. **Monitoring**: Implement observability with metrics, logs, and tracing

### GitOps with ArgoCD

```yaml
# argocd-application.yaml - GitOps application definition
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: web-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/myorg/k8s-manifests
    targetRevision: HEAD
    path: apps/web-app/overlays/production
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
```

### CI/CD Pipeline Integration

```yaml
# .github/workflows/deploy.yml
name: Deploy to Kubernetes

on:
  push:
    branches: [main]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up kubectl
        uses: azure/setup-kubectl@v3
        with:
          version: 'v1.28.0'

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-west-2

      - name: Update kubeconfig
        run: |
          aws eks update-kubeconfig --region us-west-2 --name production-cluster

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

      - name: Update Kubernetes manifests
        run: |
          sed -i 's|IMAGE_TAG|${{ github.sha }}|g' k8s/deployment.yaml

      - name: Deploy to Kubernetes
        run: |
          kubectl apply -f k8s/namespace.yaml
          kubectl apply -f k8s/configmap.yaml
          kubectl apply -f k8s/secret.yaml
          kubectl apply -f k8s/deployment.yaml
          kubectl apply -f k8s/service.yaml
          kubectl apply -f k8s/ingress.yaml

      - name: Wait for deployment
        run: |
          kubectl rollout status deployment/web-app -n production --timeout=300s

      - name: Run smoke tests
        run: |
          kubectl wait --for=condition=ready pod -l app=web-app -n production --timeout=300s
          kubectl port-forward service/web-app-service 8080:80 -n production &
          sleep 10
          curl -f http://localhost:8080/health || exit 1
```

## Best Practices

### ✅ **Container and Pod Best Practices**

- **Use resource limits and requests** - Prevent resource starvation and enable proper scheduling
- **Implement health checks** - Ensure application availability with liveness, readiness, and startup probes
- **Run as non-root user** - Enhance security by avoiding root privileges
- **Use multi-stage builds** - Optimize container images for production deployment
- **Implement proper logging** - Structure logs for centralized collection and analysis
- **Use init containers** - Handle initialization tasks separately from main application

### ✅ **Security Best Practices**

- **Use RBAC** - Implement Role-Based Access Control for fine-grained permissions
- **Network policies** - Control traffic flow between pods and services
- **Pod Security Standards** - Enforce security policies for pod specifications
- **Secrets management** - Use Kubernetes Secrets and external secret management systems
- **Image scanning** - Regularly scan container images for vulnerabilities
- **Service mesh** - Implement mTLS and advanced security policies with Istio or Linkerd

### ✅ **Deployment and Scaling Best Practices**

- **Rolling updates** - Use rolling deployment strategies for zero-downtime updates
- **Horizontal Pod Autoscaling** - Implement HPA for automatic scaling based on metrics
- **Pod Disruption Budgets** - Ensure availability during voluntary disruptions
- **Anti-affinity rules** - Distribute pods across nodes for high availability
- **Blue-green deployments** - Implement advanced deployment strategies for critical applications
- **Canary deployments** - Gradually roll out changes with traffic splitting

### ❌ **Common Pitfalls to Avoid**

- **Don't ignore resource limits** - Can cause cluster instability and resource contention
- **Avoid privileged containers** - Security risk and bad practice
- **Don't store secrets in manifests** - Use proper secret management
- **Avoid single points of failure** - Design for redundancy and fault tolerance
- **Don't neglect monitoring** - Implement comprehensive observability
- **Avoid manual configuration** - Use Infrastructure as Code and GitOps

## Advanced Kubernetes Usage

### Custom Resource Definitions (CRDs)

```yaml
# custom-resource.yaml - Custom application resource
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: webapps.example.com
spec:
  group: example.com
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                replicas:
                  type: integer
                  minimum: 1
                  maximum: 100
                image:
                  type: string
                resources:
                  type: object
                  properties:
                    cpu:
                      type: string
                    memory:
                      type: string
            status:
              type: object
              properties:
                phase:
                  type: string
                  enum: ['Pending', 'Running', 'Failed']
                replicas:
                  type: integer
  scope: Namespaced
  names:
    plural: webapps
    singular: webapp
    kind: WebApp
    shortNames:
      - wa
```

### Operator Pattern

```yaml
# operator-deployment.yaml - Custom operator
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-operator
  namespace: operators
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webapp-operator
  template:
    metadata:
      labels:
        app: webapp-operator
    spec:
      serviceAccountName: webapp-operator
      containers:
        - name: operator
          image: myregistry/webapp-operator:v1.0.0
          env:
            - name: WATCH_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: OPERATOR_NAME
              value: 'webapp-operator'
          resources:
            requests:
              memory: '128Mi'
              cpu: '100m'
            limits:
              memory: '256Mi'
              cpu: '200m'
```

### Service Mesh with Istio

```yaml
# istio-gateway.yaml - Istio gateway configuration
apiVersion: networking.istio.io/v1alpha3
kind: Gateway
metadata:
  name: web-app-gateway
  namespace: production
spec:
  selector:
    istio: ingressgateway
  servers:
    - port:
        number: 80
        name: http
        protocol: HTTP
      hosts:
        - 'app.mydomain.com'
      tls:
        httpsRedirect: true
    - port:
        number: 443
        name: https
        protocol: HTTPS
      tls:
        mode: SIMPLE
        credentialName: web-app-tls
      hosts:
        - 'app.mydomain.com'

---
# virtualservice.yaml - Traffic routing
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: web-app-vs
  namespace: production
spec:
  hosts:
    - 'app.mydomain.com'
  gateways:
    - web-app-gateway
  http:
    - match:
        - uri:
            prefix: '/api/v2'
      route:
        - destination:
            host: web-app-v2-service
            port:
              number: 80
          weight: 10
        - destination:
            host: web-app-service
            port:
              number: 80
          weight: 90
    - match:
        - uri:
            prefix: '/'
      route:
        - destination:
            host: web-app-service
            port:
              number: 80
      timeout: 30s
      retries:
        attempts: 3
        perTryTimeout: 10s

---
# destinationrule.yaml - Traffic policies
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: web-app-dr
  namespace: production
spec:
  host: web-app-service
  trafficPolicy:
    loadBalancer:
      simple: LEAST_CONN
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        http1MaxPendingRequests: 50
        maxRequestsPerConnection: 10
    circuitBreaker:
      consecutiveErrors: 3
      interval: 30s
      baseEjectionTime: 30s
      maxEjectionPercent: 50
```

## Integration with Other Tools

### Helm Chart Management

```yaml
# Chart.yaml - Helm chart metadata
apiVersion: v2
name: web-app
description: A production-ready web application
type: application
version: 1.0.0
appVersion: '1.0.0'

dependencies:
  - name: postgresql
    version: 12.1.0
    repository: https://charts.bitnami.com/bitnami
    condition: postgresql.enabled
  - name: redis
    version: 17.4.0
    repository: https://charts.bitnami.com/bitnami
    condition: redis.enabled
```

```yaml
# values.yaml - Helm values
replicaCount: 3

image:
  repository: myregistry/web-app
  pullPolicy: IfNotPresent
  tag: 'v1.0.0'

service:
  type: ClusterIP
  port: 80

ingress:
  enabled: true
  className: 'nginx'
  annotations:
    cert-manager.io/cluster-issuer: 'letsencrypt-prod'
  hosts:
    - host: app.mydomain.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: web-app-tls
      hosts:
        - app.mydomain.com

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 20
  targetCPUUtilizationPercentage: 70
  targetMemoryUtilizationPercentage: 80

postgresql:
  enabled: true
  auth:
    username: myapp
    database: myapp

redis:
  enabled: true
  auth:
    enabled: false
```

### Prometheus Monitoring

```yaml
# servicemonitor.yaml - Prometheus monitoring
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: web-app-monitor
  namespace: production
  labels:
    app: web-app
spec:
  selector:
    matchLabels:
      app: web-app
  endpoints:
    - port: metrics
      interval: 30s
      path: /metrics
```

### Terraform Integration

```hcl
# kubernetes.tf - Terraform Kubernetes provider
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "production" {
  metadata {
    name = "production"
    labels = {
      environment = "production"
      managed-by  = "terraform"
    }
  }
}

resource "helm_release" "web_app" {
  name       = "web-app"
  namespace  = kubernetes_namespace.production.metadata[0].name
  chart      = "./helm/web-app"

  values = [
    file("${path.module}/helm-values/production.yaml")
  ]

  set {
    name  = "image.tag"
    value = var.app_version
  }

  set_sensitive {
    name  = "postgresql.auth.password"
    value = var.db_password
  }
}
```

## Troubleshooting

### Common Issues

#### Pod Startup Problems

**Problem**: Pod fails to start or crashes repeatedly
**Symptoms**: Pod status shows CrashLoopBackOff, ImagePullBackOff, or Pending
**Solution**:

```bash
# Check pod status and events
kubectl describe pod pod-name
kubectl get events --field-selector involvedObject.name=pod-name

# Check logs
kubectl logs pod-name
kubectl logs pod-name --previous  # Previous container logs

# Debug with temporary container
kubectl run debug --image=busybox -it --rm -- /bin/sh

# Check resource constraints
kubectl top pod pod-name
kubectl describe node node-name
```

#### Service Discovery Issues

**Problem**: Services cannot communicate with each other
**Symptoms**: Connection timeouts, DNS resolution failures
**Solution**:

```bash
# Test DNS resolution
kubectl run dns-debug --image=busybox -it --rm -- nslookup service-name

# Check service endpoints
kubectl get endpoints service-name
kubectl describe service service-name

# Test network connectivity
kubectl exec -it pod-name -- nc -zv service-name port

# Check network policies
kubectl get networkpolicies
kubectl describe networkpolicy policy-name
```

#### Storage Issues

**Problem**: Persistent volumes not mounting or data loss
**Symptoms**: Volume mount failures, permission errors
**Solution**:

```bash
# Check PV and PVC status
kubectl get pv,pvc
kubectl describe pvc pvc-name

# Check storage class
kubectl get storageclass
kubectl describe storageclass class-name

# Debug volume permissions
kubectl exec -it pod-name -- ls -la /mount/path
kubectl exec -it pod-name -- id
```

### Debug Mode

```bash
# Enable verbose kubectl output
kubectl --v=8 get pods

# Use kubectl debug for troubleshooting
kubectl debug pod-name -it --image=busybox

# Create debug container in existing pod
kubectl debug pod-name -it --image=busybox --target=container-name

# Copy files from pod for analysis
kubectl cp pod-name:/path/to/file ./local-file

# Port forward for debugging
kubectl port-forward pod/pod-name 8080:80

# Proxy for accessing Kubernetes API
kubectl proxy --port=8080
```

### Performance Optimization

```yaml
# Resource optimization
resources:
  requests:
    memory: '256Mi' # Guaranteed allocation
    cpu: '250m' # Guaranteed CPU
  limits:
    memory: '512Mi' # Maximum allocation
    cpu: '500m' # Maximum CPU

# Quality of Service classes
# Guaranteed: requests = limits
# Burstable: requests < limits
# BestEffort: no requests/limits
```

## Security Considerations

### RBAC Configuration

```yaml
# rbac.yaml - Role-based access control
apiVersion: v1
kind: ServiceAccount
metadata:
  name: web-app-sa
  namespace: production

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: production
  name: web-app-role
rules:
  - apiGroups: ['']
    resources: ['configmaps', 'secrets']
    verbs: ['get', 'list']
  - apiGroups: ['']
    resources: ['pods']
    verbs: ['get', 'list', 'create']

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: web-app-binding
  namespace: production
subjects:
  - kind: ServiceAccount
    name: web-app-sa
    namespace: production
roleRef:
  kind: Role
  name: web-app-role
  apiGroup: rbac.authorization.k8s.io
```

### Pod Security Standards

```yaml
# pod-security-policy.yaml - Pod security enforcement
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

### Security Context Best Practices

```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1001
  runAsGroup: 1001
  fsGroup: 1001
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    drop:
      - ALL
    add:
      - NET_BIND_SERVICE
  allowPrivilegeEscalation: false
  readOnlyRootFilesystem: true
```

## AI Assistant Guidelines

When helping with Kubernetes:

1. **Always recommend production-ready configurations** with proper resource limits, health checks, and security settings
2. **Provide complete manifest examples** including all necessary Kubernetes resources for the application
3. **Include security best practices** with RBAC, network policies, and pod security standards
4. **Suggest appropriate scaling strategies** with HPA, VPA, and cluster autoscaling
5. **Provide debugging guidance** for common pod, service, and cluster issues
6. **Include monitoring and observability** configurations for production deployments
7. **Reference GitOps workflows** with ArgoCD or Flux for automated deployments
8. **Suggest appropriate storage solutions** based on application requirements and performance needs

### Code Generation Rules

- Generate production-ready Kubernetes manifests with comprehensive configurations
- Include proper resource requests and limits for optimal cluster utilization
- Provide security-hardened configurations with non-root users and security contexts
- Include health checks, monitoring, and logging configurations for observability
- Generate multi-environment configurations with proper namespace separation
- Provide CI/CD pipeline examples with automated testing and deployment
- Include backup and disaster recovery strategies for stateful applications
- Generate Helm charts and Kustomize overlays for configuration management`
