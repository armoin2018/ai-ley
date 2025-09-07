---
agentMode: general
applyTo: general
author: AI-LEY
description: Enterprise Kubernetes orchestration platform with advanced cluster management, multi-tenant architecture, GitOps automation, security hardening, compliance frameworks, comprehensive monitoring, and production-s    min:
      cpu: "50m"
      memory: "64Mi"
```

## Enterprise Microservices Deployment Patterns

### Production-Ready Deployment

```yaml
# applications/web-service-deployment.yaml - Enterprise microservice
apiVersion: apps/v1
kind: Deployment
metadata:
  name: enterprise-web-service
  namespace: production
  labels:
    app: web-service
    version: v1.2.3
    tier: frontend
    component: web
spec:
  replicas: 6
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 25%
      maxSurge: 25%
  selector:
    matchLabels:
      app: web-service
      version: v1.2.3
  template:
    metadata:
      labels:
        app: web-service
        version: v1.2.3
        tier: frontend
        component: web
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8080"
        prometheus.io/path: "/metrics"
    spec:
      # Security context
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        runAsGroup: 3000
        fsGroup: 2000
        seccompProfile:
          type: RuntimeDefault
      
      # Service account
      serviceAccountName: web-service-sa
      automountServiceAccountToken: false
      
      # Pod anti-affinity for HA
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
                  - web-service
              topologyKey: kubernetes.io/hostname
      
      # Init containers
      initContainers:
      - name: migration
        image: enterprise/web-service:v1.2.3
        command: ['sh', '-c', 'npm run migrate']
        env:
        - name: DB_HOST
          valueFrom:
            secretKeyRef:
              name: database-secrets
              key: host
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: database-secrets
              key: password
      
      containers:
      - name: web-service
        image: enterprise/web-service:v1.2.3
        imagePullPolicy: Always
        
        # Security context
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          capabilities:
            drop:
            - ALL
        
        ports:
        - name: http
          containerPort: 8080
          protocol: TCP
        - name: metrics
          containerPort: 9090
          protocol: TCP
        
        # Resource management
        resources:
          requests:
            memory: "256Mi"
            cpu: "200m"
            ephemeral-storage: "1Gi"
          limits:
            memory: "512Mi"
            cpu: "500m"
            ephemeral-storage: "2Gi"
        
        # Environment variables
        env:
        - name: NODE_ENV
          value: "production"
        - name: LOG_LEVEL
          value: "info"
        - name: PORT
          value: "8080"
        - name: METRICS_PORT
          value: "9090"
        
        # ConfigMap and Secret references
        envFrom:
        - configMapRef:
            name: web-service-config
        - secretRef:
            name: web-service-secrets
        
        # Volume mounts
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: var-cache
          mountPath: /var/cache
        - name: config-volume
          mountPath: /etc/config
          readOnly: true
        
        # Health checks
        livenessProbe:
          httpGet:
            path: /health/live
            port: http
            scheme: HTTP
          initialDelaySeconds: 60
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 3
          successThreshold: 1
        
        readinessProbe:
          httpGet:
            path: /health/ready
            port: http
            scheme: HTTP
          initialDelaySeconds: 10
          periodSeconds: 5
          timeoutSeconds: 3
          failureThreshold: 3
          successThreshold: 1
        
        startupProbe:
          httpGet:
            path: /health/startup
            port: http
            scheme: HTTP
          initialDelaySeconds: 10
          periodSeconds: 10
          timeoutSeconds: 5
          failureThreshold: 30
          successThreshold: 1
      
      # Volumes
      volumes:
      - name: tmp
        emptyDir: {}
      - name: var-cache
        emptyDir: {}
      - name: config-volume
        configMap:
          name: web-service-config
          items:
          - key: app.properties
            path: app.properties
      
      # Image pull secrets
      imagePullSecrets:
      - name: enterprise-registry-secret
      
      # Node selection
      nodeSelector:
        environment: production
        instance-type: compute-optimized
      
      # Tolerations
      tolerations:
      - key: "environment"
        operator: "Equal"
        value: "production"
        effect: "NoSchedule"
      
      # Pod disruption budget
      topologySpreadConstraints:
      - maxSkew: 1
        topologyKey: topology.kubernetes.io/zone
        whenUnsatisfiable: DoNotSchedule
        labelSelector:
          matchLabels:
            app: web-serviceatterns.
extensions:
  - .md
  - .yaml
  - .yml
  - .json
  - .sh
  - .ps1
guidelines: Enterprise Container Orchestration with Kubernetes cluster management, microservices architecture, service mesh integration, observability stack, security policies, compliance automation, and DevOps pipeline integration.
instructionType: general
keywords:
  - kubernetes
  - k8s
  - container-orchestration
  - microservices
  - docker
  - helm
  - istio
  - prometheus
  - grafana
  - enterprise
  - security
  - compliance
  - monitoring
  - devops
  - gitops
lastUpdated: '2025-09-04T00:00:00.000000'
summaryScore: 5.0
title: Kubernetes Enterprise Container Orchestration Platform
version: 3.0.0
---

# Kubernetes Enterprise Container Orchestration at Scale

## Enterprise Overview

Kubernetes Enterprise Container Orchestration provides comprehensive containerized application deployment, scaling, and management across multi-cloud environments. This enterprise implementation features advanced cluster management, multi-tenant architecture, service mesh integration, comprehensive security policies, compliance automation, and production-scale observability.

Enterprise deployments leverage advanced features including GitOps automation, policy-as-code governance, zero-trust networking, comprehensive monitoring with Prometheus/Grafana, service mesh with Istio, advanced scheduling, resource quotas, and sophisticated CI/CD pipeline integration for managing complex containerized workloads at enterprise scale.

## 🧠 Enterprise Context

- **Project Type**: Enterprise Container Orchestration / Cloud-Native Platform Engineering
- **Architecture**: Multi-Tenant / Multi-Cloud / Microservices / Service Mesh / Zero-Trust Security
- **Orchestration**: Kubernetes 1.28+ / Helm 3.12+ / Kustomize / ArgoCD / Flux
- **Service Mesh**: Istio 1.19+ / Envoy / Linkerd / Consul Connect
- **Compliance**: SOC2, PCI-DSS, HIPAA, FedRAMP, CIS Kubernetes Benchmark
- **Scale**: 1000+ nodes, 10K+ pods, 500+ services across 50+ namespaces
- **Technologies**: Docker, containerd, CRI-O, OCI, CNAB, OPA, Falco

## Enterprise Cluster Architecture

### Production Cluster Configuration

```yaml
# cluster/production-cluster.yaml - Enterprise production cluster
apiVersion: kubeadm.k8s.io/v1beta3
kind: ClusterConfiguration
kubernetesVersion: v1.28.4
clusterName: enterprise-production
controlPlaneEndpoint: k8s-api.enterprise.com:6443
certificatesDir: /etc/kubernetes/pki

# Multi-master high availability
controllerManager:
  extraArgs:
    cluster-signing-duration: 87600h # 10 years
    feature-gates: 'RotateKubeletServerCertificate=true'
    bind-address: 0.0.0.0
  extraVolumes:
    - name: audit-logs
      hostPath: /var/log/kubernetes/audit
      mountPath: /var/log/kubernetes/audit
      pathType: DirectoryOrCreate

scheduler:
  extraArgs:
    bind-address: 0.0.0.0
    feature-gates: 'PodTopologySpread=true'

apiServer:
  certSANs:
    - k8s-api.enterprise.com
    - k8s-api-internal.enterprise.com
    - 10.0.0.100
  extraArgs:
    # Security hardening
    anonymous-auth: 'false'
    audit-log-maxage: '30'
    audit-log-maxbackup: '10'
    audit-log-maxsize: '100'
    audit-log-path: /var/log/kubernetes/audit/audit.log
    audit-policy-file: /etc/kubernetes/audit-policy.yaml
    enable-admission-plugins: 'NodeRestriction,ResourceQuota,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,RuntimeClass,Priority,SecurityContextConstraints,PodSecurityPolicy'
    encryption-provider-config: /etc/kubernetes/encryption-config.yaml
    feature-gates: 'APIPriorityAndFairness=true,EphemeralContainers=true'
    oidc-issuer-url: https://auth.enterprise.com
    oidc-client-id: kubernetes
    oidc-username-claim: email
    oidc-groups-claim: groups
    profiling: 'false'
    request-timeout: '300s'
    service-account-lookup: 'true'
    tls-cipher-suites: 'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256'
    tls-min-version: 'VersionTLS12'

etcd:
  local:
    serverCertSANs:
      - etcd.enterprise.com
    peerCertSANs:
      - etcd.enterprise.com
    extraArgs:
      cipher-suites: 'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256'
      client-cert-auth: 'true'
      peer-client-cert-auth: 'true'

networking:
  serviceSubnet: 10.1.0.0/16
  podSubnet: 10.2.0.0/16
  dnsDomain: cluster.local
```

### Enterprise Security Policies

````yaml
# security/audit-policy.yaml - Comprehensive audit policy
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
# Log all requests at RequestResponse level
- level: RequestResponse
  namespaces: ["production", "staging"]
  resources:
  - group: ""
    resources: ["pods", "services", "secrets", "configmaps"]
  - group: "apps"
    resources: ["deployments", "daemonsets", "statefulsets"]

# Log secret access
- level: Metadata
  resources:
  - group: ""
    resources: ["secrets"]

# Log admin access
- level: Request
  users: ["admin", "system:admin"]

# Log failed requests
- level: Request
  namespaceSelector:
    matchLabels:
      compliance: "required"

---
# security/encryption-config.yaml - Data encryption at rest
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
resources:
- resources:
  - secrets
  - configmaps
  providers:
  - aescbc:
      keys:
      - name: key1
        secret: c2VjcmV0IGlzIHNlY3VyZQ==  # base64 encoded key
  - identity: {}

---
# security/pod-security-policy.yaml - Pod security constraints
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: enterprise-restricted
spec:
  privileged: false
  allowPrivilegeEscalation: false
  requiredDropCapabilities:
    - ALL
  volumes:
    - 'configMap'
    - 'emptyDir'
    - 'projected'
    - 'secret'
    - 'downwardAPI'
    - 'persistentVolumeClaim'
  runAsUser:
    rule: 'MustRunAsNonRoot'
  seLinux:
    rule: 'RunAsAny'
  fsGroup:
    rule: 'RunAsAny'
  readOnlyRootFilesystem: true
  seccompProfile:
    type: RuntimeDefault
```

## Enterprise Multi-Tenant Architecture

### Namespace Management and Resource Quotas

```yaml
# namespaces/production-namespace.yaml - Production namespace with quotas
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    environment: production
    compliance: required
    cost-center: engineering
    security-zone: restricted
  annotations:
    scheduler.alpha.kubernetes.io/node-selector: environment=production

---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: production-quota
  namespace: production
spec:
  hard:
    # Compute resources
    requests.cpu: "100"
    requests.memory: 200Gi
    limits.cpu: "200"
    limits.memory: 400Gi

    # Storage resources
    requests.storage: 1Ti
    persistentvolumeclaims: "50"

    # Object counts
    pods: "100"
    services: "20"
    secrets: "50"
    configmaps: "50"
    deployments.apps: "20"
    statefulsets.apps: "10"

---
apiVersion: v1
kind: LimitRange
metadata:
  name: production-limits
  namespace: production
spec:
  limits:
  - type: Pod
    default:
      cpu: "1"
      memory: "1Gi"
    defaultRequest:
      cpu: "100m"
      memory: "128Mi"
    max:
      cpu: "4"
      memory: "8Gi"
    min:
      cpu: "50m"
      memory: "64Mi"
  - type: Container
    default:
      cpu: "500m"
      memory: "512Mi"
    defaultRequest:
      cpu: "100m"
      memory: "128Mi"
    max:
      cpu: "2"
      memory: "4Gi"
    min:
      cpu: "50m"
      memory: "64Mi"
````

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
  - apiGroups: ['']
    resources: ['pods']
    verbs: ['get', 'watch', 'list']
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

## Enterprise Monitoring and Observability

### Prometheus and Grafana Integration

```yaml
# monitoring/prometheus-config.yaml - Prometheus configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
  namespace: monitoring
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
    rule_files:
      - "/etc/prometheus/rules/*.yml"
    scrape_configs:
    - job_name: 'kubernetes-apiservers'
      kubernetes_sd_configs:
      - role: endpoints
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      relabel_configs:
      - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
        action: keep
        regex: default;kubernetes;https
        
    - job_name: 'kubernetes-nodes'
      kubernetes_sd_configs:
      - role: node
      scheme: https
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
      relabel_configs:
      - action: labelmap
        regex: __meta_kubernetes_node_label_(.+)
        
    - job_name: 'kubernetes-pods'
      kubernetes_sd_configs:
      - role: pod
      relabel_configs:
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
        action: keep
        regex: true
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
        action: replace
        target_label: __metrics_path__
        regex: (.+)

---
# monitoring/grafana-dashboard.yaml - Kubernetes cluster dashboard
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubernetes-dashboard
  namespace: monitoring
data:
  kubernetes-cluster.json: |
    {
      "dashboard": {
        "id": null,
        "title": "Kubernetes Cluster Monitoring",
        "tags": ["kubernetes"],
        "timezone": "browser",
        "panels": [
          {
            "id": 1,
            "title": "Cluster CPU Usage",
            "type": "stat",
            "targets": [
              {
                "expr": "(1 - avg(irate(node_cpu_seconds_total{mode=\"idle\"}[5m]))) * 100",
                "legendFormat": "CPU Usage %"
              }
            ]
          },
          {
            "id": 2,
            "title": "Cluster Memory Usage",
            "type": "stat",
            "targets": [
              {
                "expr": "(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100",
                "legendFormat": "Memory Usage %"
              }
            ]
          },
          {
            "id": 3,
            "title": "Pod Status",
            "type": "table",
            "targets": [
              {
                "expr": "kube_pod_status_phase",
                "format": "table"
              }
            ]
          }
        ]
      }
    }
```

### Service Mesh with Istio

```yaml
# istio/virtual-service.yaml - Traffic management
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: web-service-vs
  namespace: production
spec:
  hosts:
    - web-service
    - api.enterprise.com
  gateways:
    - web-service-gateway
    - mesh
  http:
    - match:
        - headers:
            canary:
              exact: 'true'
      route:
        - destination:
            host: web-service
            subset: canary
          weight: 100
    - route:
        - destination:
            host: web-service
            subset: stable
          weight: 90
        - destination:
            host: web-service
            subset: canary
          weight: 10
      fault:
        delay:
          percentage:
            value: 0.1
          fixedDelay: 5s
      timeout: 30s
      retries:
        attempts: 3
        perTryTimeout: 10s

---
# istio/destination-rule.yaml - Load balancing and circuit breakers
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: web-service-dr
  namespace: production
spec:
  host: web-service
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        http1MaxPendingRequests: 50
        maxRequestsPerConnection: 10
    circuitBreaker:
      consecutiveGatewayErrors: 5
      consecutive5xxErrors: 5
      interval: 30s
      baseEjectionTime: 30s
      maxEjectionPercent: 50
    outlierDetection:
      consecutive5xxErrors: 5
      consecutiveGatewayErrors: 5
      interval: 30s
      baseEjectionTime: 30s
      maxEjectionPercent: 50
  subsets:
    - name: stable
      labels:
        version: v1.2.3
    - name: canary
      labels:
        version: v1.3.0
```

## Enterprise GitOps and CI/CD Integration

### ArgoCD Application Configuration

```yaml
# gitops/web-service-application.yaml - ArgoCD application
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: web-service-production
  namespace: argocd
  labels:
    environment: production
    team: platform
spec:
  project: enterprise-production
  source:
    repoURL: https://github.com/enterprise/k8s-manifests
    targetRevision: main
    path: applications/web-service/overlays/production
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - CreateNamespace=false
      - PrunePropagationPolicy=background
      - PruneLast=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
  revisionHistoryLimit: 10

---
# gitops/app-project.yaml - ArgoCD project with security policies
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: enterprise-production
  namespace: argocd
spec:
  description: Enterprise production applications
  sourceRepos:
    - 'https://github.com/enterprise/*'
  destinations:
    - namespace: 'production'
      server: https://kubernetes.default.svc
    - namespace: 'staging'
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: ''
      kind: Namespace
    - group: rbac.authorization.k8s.io
      kind: ClusterRole
    - group: rbac.authorization.k8s.io
      kind: ClusterRoleBinding
  namespaceResourceWhitelist:
    - group: ''
      kind: Service
    - group: ''
      kind: ConfigMap
    - group: ''
      kind: Secret
    - group: apps
      kind: Deployment
    - group: apps
      kind: StatefulSet
    - group: networking.k8s.io
      kind: Ingress
    - group: policy
      kind: PodDisruptionBudget
  roles:
    - name: production-admin
      description: Production environment admin
      policies:
        - p, proj:enterprise-production:production-admin, applications, *, enterprise-production/*, allow
        - p, proj:enterprise-production:production-admin, clusters, *, *, allow
        - p, proj:enterprise-production:production-admin, repositories, *, *, allow
      groups:
        - enterprise:production-team
```

### GitHub Actions CI/CD Pipeline

```yaml
# .github/workflows/kubernetes-deploy.yml - Enterprise deployment pipeline
name: 'Kubernetes Deployment Pipeline'

on:
  push:
    branches: [main, develop]
    paths: ['k8s/**', 'Dockerfile', 'src/**']
  pull_request:
    branches: [main]
    paths: ['k8s/**', 'Dockerfile', 'src/**']

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: enterprise/web-service
  KUBECONFIG_STAGING: ${{ secrets.KUBECONFIG_STAGING }}
  KUBECONFIG_PRODUCTION: ${{ secrets.KUBECONFIG_PRODUCTION }}

jobs:
  security-scan:
    name: 'Security Scanning'
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Scan Kubernetes manifests
        uses: azure/k8s-lint@v1
        with:
          manifests: k8s/

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: 'k8s/'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload Trivy scan results
        uses: github/codeql-action/upload-sarif@v3
        with:
          sarif_file: 'trivy-results.sarif'

  build-and-test:
    name: 'Build and Test'
    runs-on: ubuntu-latest
    needs: security-scan
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Log in to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=sha,prefix={{branch}}-

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          platforms: linux/amd64,linux/arm64
          cache-from: type=gha
          cache-to: type=gha,mode=max

  deploy-staging:
    name: 'Deploy to Staging'
    runs-on: ubuntu-latest
    needs: build-and-test
    if: github.ref == 'refs/heads/develop'
    environment: staging
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup kubectl
        uses: azure/setup-kubectl@v3
        with:
          version: 'v1.28.4'

      - name: Deploy to staging
        run: |
          echo "$KUBECONFIG_STAGING" | base64 -d > kubeconfig
          export KUBECONFIG=kubeconfig
          kubectl apply -k k8s/overlays/staging
          kubectl rollout status deployment/web-service -n staging --timeout=300s

      - name: Run smoke tests
        run: |
          export KUBECONFIG=kubeconfig
          kubectl port-forward svc/web-service 8080:80 -n staging &
          sleep 10
          curl -f http://localhost:8080/health || exit 1

  deploy-production:
    name: 'Deploy to Production'
    runs-on: ubuntu-latest
    needs: build-and-test
    if: github.ref == 'refs/heads/main'
    environment: production
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Update ArgoCD Application
        run: |
          # Update image tag in ArgoCD application manifest
          sed -i "s|image: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:.*|image: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}|" k8s/overlays/production/kustomization.yaml

      - name: Commit and push changes
        run: |
          git config --global user.name 'GitHub Actions'
          git config --global user.email 'actions@github.com'
          git add k8s/overlays/production/kustomization.yaml
          git commit -m "Update production image to ${{ github.sha }}"
          git push
```

## Enterprise Compliance and Security

### Policy as Code with OPA Gatekeeper

```yaml
# policies/required-labels.yaml - Required labels policy
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8srequiredlabels
spec:
  crd:
    spec:
      names:
        kind: K8sRequiredLabels
      validation:
        openAPIV3Schema:
          type: object
          properties:
            labels:
              type: array
              items:
                type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8srequiredlabels

        violation[{"msg": msg}] {
          provided := input.review.object.metadata.labels
          required := input.parameters.labels
          missing := required[_]
          not provided[missing]
          msg := sprintf("Missing required label: %v", [missing])
        }

---
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sRequiredLabels
metadata:
  name: must-have-required-labels
spec:
  match:
    kinds:
      - apiGroups: ['apps']
        kinds: ['Deployment']
      - apiGroups: ['']
        kinds: ['Service']
  parameters:
    labels: ['environment', 'team', 'cost-center', 'compliance']

---
# policies/security-constraints.yaml - Security policy
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8ssecuritycontext
spec:
  crd:
    spec:
      names:
        kind: K8sSecurityContext
      validation:
        openAPIV3Schema:
          type: object
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8ssecuritycontext

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          not container.securityContext.runAsNonRoot
          msg := "Container must run as non-root user"
        }

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          container.securityContext.allowPrivilegeEscalation == true
          msg := "Container must not allow privilege escalation"
        }

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          not container.securityContext.readOnlyRootFilesystem
          msg := "Container must have read-only root filesystem"
        }

---
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sSecurityContext
metadata:
  name: enforce-security-context
spec:
  match:
    kinds:
      - apiGroups: ['']
        kinds: ['Pod']
      - apiGroups: ['apps']
        kinds: ['Deployment']
```

### Falco Runtime Security

```yaml
# security/falco-config.yaml - Runtime security monitoring
apiVersion: v1
kind: ConfigMap
metadata:
  name: falco-config
  namespace: falco-system
data:
  falco.yaml: |
    rules_file:
      - /etc/falco/falco_rules.yaml
      - /etc/falco/falco_rules.local.yaml
      - /etc/falco/k8s_audit_rules.yaml
      - /etc/falco/rules.d

    # Output channels
    json_output: true
    json_include_output_property: true
    json_include_tags_property: true

    # Logging
    log_stderr: true
    log_syslog: true
    log_level: info

    # gRPC output
    grpc:
      enabled: true
      bind_address: "0.0.0.0:5060"
      
    # Webserver
    webserver:
      enabled: true
      listen_port: 8765
      
    # Rule matching
    priority: debug

  falco_rules.local.yaml: |
    - rule: Unauthorized K8s API Call
      desc: Detect unauthorized calls to the K8s API
      condition: >
        ka and
        not ka_allowed_users and
        not ka_allowed_service_accounts
      output: >
        Unauthorized K8s API call (user=%ka.user.name verb=%ka.verb
        resource=%ka.resource.resource reason=%ka.response_reason)
      priority: WARNING
      tags: [k8s, api]
      
    - rule: Shell in Container
      desc: Detect shell execution in container
      condition: >
        spawned_process and
        container and
        shell_procs
      output: >
        Shell in container (user=%user.name container_id=%container.id
        container_name=%container.name shell=%proc.name parent=%proc.pname
        cmdline=%proc.cmdline terminal=%proc.tty)
      priority: WARNING
      tags: [container, shell]
      
    - rule: Sensitive File Access
      desc: Detect access to sensitive files
      condition: >
        open_read and
        sensitive_files and
        proc_name_exists and
        not proc.name in (trusted_binaries)
      output: >
        Sensitive file opened for reading (user=%user.name command=%proc.cmdline
        file=%fd.name parent=%proc.pname pcmdline=%proc.pcmdline gparent=%proc.aname[2])
      priority: WARNING
      tags: [filesystem, sensitive]
```

## Enterprise Best Practices and Guidelines

### 🧶 Enterprise Kubernetes Patterns

#### ✅ Patterns to Follow

- **Multi-Tenant Architecture**: Use namespaces with resource quotas, limit ranges, and network policies for tenant isolation
- **Zero-Trust Security**: Implement pod security policies, security contexts, network policies, and RBAC with least privilege
- **GitOps Deployment**: Use ArgoCD or Flux for declarative, version-controlled deployments with automated sync
- **Observability Stack**: Deploy Prometheus, Grafana, Jaeger, and Fluentd for comprehensive monitoring and logging
- **Service Mesh Integration**: Use Istio or Linkerd for advanced traffic management, security, and observability
- **Policy as Code**: Implement OPA Gatekeeper for automated compliance and security policy enforcement
- **High Availability**: Configure pod anti-affinity, disruption budgets, and multi-zone deployments
- **Resource Management**: Set appropriate requests/limits, implement HPA/VPA, and use quality of service classes

#### 🚫 Patterns to Avoid

- **Privileged Containers**: Never run containers as root or with privileged security context
- **Latest Tags**: Avoid using 'latest' image tags; use specific version tags for reproducibility
- **No Resource Limits**: Always set resource requests and limits to prevent resource exhaustion
- **Shared Namespaces**: Don't deploy different applications or environments in the same namespace
- **Hardcoded Secrets**: Use Kubernetes Secrets or external secret managers, never hardcode sensitive data
- **Single Points of Failure**: Avoid single replica deployments in production environments
- **No Health Checks**: Always implement liveness, readiness, and startup probes
- **Manual Deployments**: Use GitOps and automation instead of manual kubectl commands for production

### 🧪 Enterprise Testing Strategy

```yaml
# testing/chaos-engineering.yaml - Chaos Monkey for Kubernetes
apiVersion: argoproj.io/v1alpha1
kind: CronWorkflow
metadata:
  name: chaos-engineering
  namespace: chaos-engineering
spec:
  schedule: '0 */6 * * *' # Every 6 hours
  workflowSpec:
    entrypoint: chaos-experiments
    templates:
      - name: chaos-experiments
        steps:
          - - name: pod-killer
              template: kill-random-pods
          - - name: network-partition
              template: network-chaos
          - - name: cpu-stress
              template: stress-test

      - name: kill-random-pods
        container:
          image: quay.io/chaos-mesh/chaos-mesh:latest
          command: ['chaos-mesh']
          args: ['--config', '/config/pod-kill.yaml']

      - name: network-chaos
        container:
          image: quay.io/chaos-mesh/chaos-mesh:latest
          command: ['chaos-mesh']
          args: ['--config', '/config/network-partition.yaml']

      - name: stress-test
        container:
          image: quay.io/chaos-mesh/chaos-mesh:latest
          command: ['chaos-mesh']
          args: ['--config', '/config/stress-test.yaml']
```

### 📊 Enterprise Performance Optimization

```yaml
# optimization/vertical-pod-autoscaler.yaml - VPA for resource optimization
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: web-service-vpa
  namespace: production
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: enterprise-web-service
  updatePolicy:
    updateMode: 'Auto'
  resourcePolicy:
    containerPolicies:
      - containerName: web-service
        maxAllowed:
          cpu: 2
          memory: 4Gi
        minAllowed:
          cpu: 100m
          memory: 128Mi
        controlledResources: ['cpu', 'memory']

---
# optimization/pod-disruption-budget.yaml - PDB for availability
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: web-service-pdb
  namespace: production
spec:
  minAvailable: 3
  selector:
    matchLabels:
      app: web-service
```

## � Enterprise Security & Compliance Framework

### Advanced Security Policies & RBAC

```yaml
# security/pod-security-standards.yaml - Pod Security Standards enforcement
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
    compliance-framework: 'SOC2,PCI-DSS,HIPAA'
    security-tier: 'high'

---
# security/network-policies.yaml - Zero-trust network segmentation
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
  namespace: production
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
  namespace: production
spec:
  podSelector:
    matchLabels:
      tier: backend
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              tier: frontend
      ports:
        - protocol: TCP
          port: 8080

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-backend-to-database
  namespace: production
spec:
  podSelector:
    matchLabels:
      tier: database
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              tier: backend
      ports:
        - protocol: TCP
          port: 5432

---
# security/advanced-rbac.yaml - Role-based access control
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: security-auditor
  labels:
    rbac.authorization.kubernetes.io/aggregate-to-view: 'true'
rules:
  - apiGroups: ['']
    resources: ['pods', 'services', 'configmaps', 'secrets']
    verbs: ['get', 'list', 'watch']
  - apiGroups: ['apps']
    resources: ['deployments', 'replicasets', 'daemonsets', 'statefulsets']
    verbs: ['get', 'list', 'watch']
  - apiGroups: ['security.istio.io']
    resources: ['authorizationpolicies', 'peerauthentications', 'requestauthentications']
    verbs: ['get', 'list', 'watch']
  - apiGroups: ['networking.k8s.io']
    resources: ['networkpolicies']
    verbs: ['get', 'list', 'watch']

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: compliance-operator
rules:
  - apiGroups: ['compliance.openshift.io']
    resources: ['*']
    verbs: ['*']
  - apiGroups: ['security.openshift.io']
    resources: ['*']
    verbs: ['get', 'list', 'watch']
  - apiGroups: ['']
    resources: ['pods', 'nodes']
    verbs: ['get', 'list', 'watch']

---
# security/psp-replacement-gatekeeper.yaml - OPA Gatekeeper policies
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8srequiredsecuritycontext
spec:
  crd:
    spec:
      names:
        kind: K8sRequiredSecurityContext
      validation:
        type: object
        properties:
          runAsNonRoot:
            type: boolean
          supplementalGroups:
            type: object
            properties:
              ranges:
                type: array
                items:
                  type: object
                  properties:
                    min:
                      type: integer
                    max:
                      type: integer
          fsGroup:
            type: object
            properties:
              ranges:
                type: array
                items:
                  type: object
                  properties:
                    min:
                      type: integer
                    max:
                      type: integer
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8srequiredsecuritycontext

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          not container.securityContext.runAsNonRoot
          msg := "Container must set runAsNonRoot to true"
        }

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          container.securityContext.runAsUser == 0
          msg := "Container cannot run as root user (UID 0)"
        }

        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          not container.securityContext.readOnlyRootFilesystem
          msg := "Container must set readOnlyRootFilesystem to true"
        }

---
apiVersion: config.gatekeeper.sh/v1alpha1
kind: K8sRequiredSecurityContext
metadata:
  name: security-context-constraint
spec:
  match:
    kinds:
      - apiGroups: ['apps']
        kinds: ['Deployment', 'StatefulSet', 'DaemonSet']
    namespaces: ['production', 'staging']
  parameters:
    runAsNonRoot: true
    supplementalGroups:
      ranges:
        - min: 1000
          max: 65535
    fsGroup:
      ranges:
        - min: 1000
          max: 65535

---
# security/secrets-management.yaml - External Secrets Operator
apiVersion: external-secrets.io/v1beta1
kind: SecretStore
metadata:
  name: aws-secrets-manager
  namespace: production
spec:
  provider:
    aws:
      service: SecretsManager
      region: us-east-1
      auth:
        secretRef:
          accessKeyID:
            name: aws-creds
            key: access-key-id
          secretAccessKey:
            name: aws-creds
            key: secret-access-key

---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: database-credentials
  namespace: production
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: aws-secrets-manager
    kind: SecretStore
  target:
    name: database-secret
    creationPolicy: Owner
  data:
    - secretKey: username
      remoteRef:
        key: production/database
        property: username
    - secretKey: password
      remoteRef:
        key: production/database
        property: password

---
# security/falco-security-monitoring.yaml - Runtime security monitoring
apiVersion: v1
kind: ConfigMap
metadata:
  name: falco-config
  namespace: falco-system
data:
  falco.yaml: |
    rules_file:
      - /etc/falco/falco_rules.yaml
      - /etc/falco/falco_rules.local.yaml
      - /etc/falco/k8s_audit_rules.yaml

    plugins:
      - name: k8saudit
        library_path: libk8saudit.so
        init_config:
          maxEventBytes: 1048576
          webhookMaxBatchSize: 12582912
        open_params: "http://:9765/k8s-audit"
      - name: json
        library_path: libjson.so
        init_config: ""

    load_plugins: [k8saudit, json]

    # Compliance-specific rules
    priority: info
    buffered_outputs: false
    outputs:
      rate: 1
      max_burst: 1000

    syslog_output:
      enabled: true

    file_output:
      enabled: true
      keep_alive: false
      filename: /var/log/falco-events.log

    stdout_output:
      enabled: true

    webserver:
      enabled: true
      listen_port: 8765
      k8s_healthz_endpoint: /healthz
      ssl_enabled: false
      ssl_certificate: /etc/ssl/falco/falco.pem

---
# security/trivy-operator.yaml - Vulnerability scanning
apiVersion: v1
kind: ConfigMap
metadata:
  name: trivy-operator-config
  namespace: trivy-system
data:
  trivy-operator.yaml: |
    vulnerabilityReports:
      scanner: Trivy
    configAuditReports:
      scanner: Trivy
    exposeExposedSecretReports:
      scanner: Trivy
    compliance:
      failEntriesLimit: 10
      reportTTL: 24h
    trivy:
      ignoreUnfixed: false
      timeout: 5m0s
      resources:
        requests:
          cpu: 100m
          memory: 100M
        limits:
          cpu: 500m
          memory: 500M
      severity: UNKNOWN,LOW,MEDIUM,HIGH,CRITICAL
      slow: true
      dbRepository: ghcr.io/aquasecurity/trivy-db
```

### Enterprise Compliance Automation

```yaml
# compliance/cis-benchmark.yaml - CIS Kubernetes Benchmark automation
apiVersion: batch/v1
kind: CronJob
metadata:
  name: cis-benchmark-scan
  namespace: compliance-system
spec:
  schedule: '0 2 * * 0' # Weekly on Sunday at 2 AM
  jobTemplate:
    spec:
      template:
        spec:
          serviceAccountName: cis-benchmark-scanner
          containers:
            - name: kube-bench
              image: aquasec/kube-bench:v0.6.15
              command: ['kube-bench']
              args: ['--benchmark', 'cis-1.23', '--json']
              volumeMounts:
                - name: var-lib-etcd
                  mountPath: /var/lib/etcd
                  readOnly: true
                - name: var-lib-kubelet
                  mountPath: /var/lib/kubelet
                  readOnly: true
                - name: var-lib-kube-scheduler
                  mountPath: /var/lib/kube-scheduler
                  readOnly: true
                - name: var-lib-kube-controller-manager
                  mountPath: /var/lib/kube-controller-manager
                  readOnly: true
                - name: etc-systemd
                  mountPath: /etc/systemd
                  readOnly: true
                - name: lib-systemd
                  mountPath: /lib/systemd/
                  readOnly: true
                - name: srv-kubernetes
                  mountPath: /srv/kubernetes/
                  readOnly: true
                - name: etc-kubernetes
                  mountPath: /etc/kubernetes
                  readOnly: true
                - name: usr-bin
                  mountPath: /usr/local/mount-from-host/bin
                  readOnly: true
          restartPolicy: OnFailure
          volumes:
            - name: var-lib-etcd
              hostPath:
                path: '/var/lib/etcd'
            - name: var-lib-kubelet
              hostPath:
                path: '/var/lib/kubelet'
            - name: var-lib-kube-scheduler
              hostPath:
                path: '/var/lib/kube-scheduler'
            - name: var-lib-kube-controller-manager
              hostPath:
                path: '/var/lib/kube-controller-manager'
            - name: etc-systemd
              hostPath:
                path: '/etc/systemd'
            - name: lib-systemd
              hostPath:
                path: '/lib/systemd'
            - name: srv-kubernetes
              hostPath:
                path: '/srv/kubernetes'
            - name: etc-kubernetes
              hostPath:
                path: '/etc/kubernetes'
            - name: usr-bin
              hostPath:
                path: '/usr/bin'

---
# compliance/pci-dss-controls.yaml - PCI-DSS compliance controls
apiVersion: v1
kind: ConfigMap
metadata:
  name: pci-dss-compliance
  namespace: compliance-system
data:
  pci-dss-requirements.yaml: |
    requirements:
      - id: "1.1.4"
        description: "Requirements for a firewall configuration standard"
        controls:
          - type: "network-policy"
            enforcement: "mandatory"
            scope: "cardholder-data-environment"
      - id: "2.2.1"
        description: "Implement only one primary function per server"
        controls:
          - type: "pod-security-context"
            enforcement: "mandatory"
      - id: "3.4"
        description: "Render PAN unreadable anywhere it is stored"
        controls:
          - type: "encryption-at-rest"
            enforcement: "mandatory"
          - type: "encryption-in-transit"
            enforcement: "mandatory"
      - id: "8.2.3"
        description: "Strong authentication for administrative access"
        controls:
          - type: "multi-factor-authentication"
            enforcement: "mandatory"
            scope: "admin-access"
      - id: "10.2"
        description: "Implement automated audit trails"
        controls:
          - type: "audit-logging"
            enforcement: "mandatory"
          - type: "log-retention"
            duration: "1-year"

---
# compliance/hipaa-controls.yaml - HIPAA compliance automation
apiVersion: v1
kind: ConfigMap
metadata:
  name: hipaa-compliance
  namespace: compliance-system
data:
  hipaa-requirements.yaml: |
    security_rule:
      administrative_safeguards:
        - id: "164.308(a)(1)(i)"
          title: "Security Officer"
          controls:
            - type: "rbac"
              roles: ["security-officer"]
        - id: "164.308(a)(5)(ii)(C)"
          title: "Automatic Logoff"
          controls:
            - type: "session-timeout"
              duration: "15m"
      physical_safeguards:
        - id: "164.310(a)(1)"
          title: "Facility Access Controls"
          controls:
            - type: "node-access-restrictions"
      technical_safeguards:
        - id: "164.312(a)(1)"
          title: "Access Control"
          controls:
            - type: "authentication"
            - type: "authorization"
        - id: "164.312(e)(1)"
          title: "Transmission Security"
          controls:
            - type: "tls-encryption"
              minimum_version: "1.2"

---
# compliance/soc2-type2-controls.yaml - SOC2 Type II controls
apiVersion: v1
kind: ConfigMap
metadata:
  name: soc2-compliance
  namespace: compliance-system
data:
  soc2-controls.yaml: |
    common_criteria:
      cc6_logical_physical_access:
        - id: "CC6.1"
          title: "Logical and Physical Access Controls"
          evidence:
            - type: "rbac-policies"
            - type: "network-policies"
            - type: "pod-security-policies"
        - id: "CC6.2"
          title: "Logical and Physical Access Controls - Remove Access"
          evidence:
            - type: "user-deprovisioning-logs"
            - type: "service-account-rotation"
        - id: "CC6.3"
          title: "Logical and Physical Access Controls - Prevent Unauthorized Access"
          evidence:
            - type: "admission-controllers"
            - type: "policy-violations"
        - id: "CC6.6"
          title: "Logical and Physical Access Controls - Vulnerabilities"
          evidence:
            - type: "vulnerability-scans"
            - type: "security-patches"
        - id: "CC6.7"
          title: "Logical and Physical Access Controls - Data Transmission"
          evidence:
            - type: "encryption-in-transit"
            - type: "certificate-management"
        - id: "CC6.8"
          title: "Logical and Physical Access Controls - Production Changes"
          evidence:
            - type: "change-management-logs"
            - type: "deployment-approvals"
```

### Enterprise Monitoring & Observability

```yaml
# monitoring/prometheus-enterprise.yaml - Comprehensive monitoring stack
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
  namespace: monitoring-system
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
      external_labels:
        cluster: 'production'
        environment: 'prod'
        compliance_frameworks: 'SOC2,PCI-DSS,HIPAA'

    rule_files:
      - "/etc/prometheus/rules/*.yml"

    alerting:
      alertmanagers:
        - static_configs:
            - targets:
              - alertmanager:9093

    scrape_configs:
      # Kubernetes API server
      - job_name: 'kubernetes-apiservers'
        kubernetes_sd_configs:
        - role: endpoints
        scheme: https
        tls_config:
          ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
        relabel_configs:
        - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
          action: keep
          regex: default;kubernetes;https
        
      # Node exporter
      - job_name: 'kubernetes-nodes'
        kubernetes_sd_configs:
        - role: node
        scheme: https
        tls_config:
          ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token
        relabel_configs:
        - action: labelmap
          regex: __meta_kubernetes_node_label_(.+)
        - target_label: __address__
          replacement: kubernetes.default.svc:443
        - source_labels: [__meta_kubernetes_node_name]
          regex: (.+)
          target_label: __metrics_path__
          replacement: /api/v1/nodes/${1}/proxy/metrics
      
      # Pod monitoring
      - job_name: 'kubernetes-pods'
        kubernetes_sd_configs:
        - role: pod
        relabel_configs:
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
          action: keep
          regex: true
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
          action: replace
          target_label: __metrics_path__
          regex: (.+)
        - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
          action: replace
          regex: ([^:]+)(?::\d+)?;(\d+)
          replacement: $1:$2
          target_label: __address__
        - action: labelmap
          regex: __meta_kubernetes_pod_label_(.+)
        - source_labels: [__meta_kubernetes_namespace]
          action: replace
          target_label: kubernetes_namespace
        - source_labels: [__meta_kubernetes_pod_name]
          action: replace
          target_label: kubernetes_pod_name
      
      # Service monitoring
      - job_name: 'kubernetes-services'
        kubernetes_sd_configs:
        - role: endpoints
        relabel_configs:
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
          action: keep
          regex: true
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scheme]
          action: replace
          target_label: __scheme__
          regex: (https?)
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
          action: replace
          target_label: __metrics_path__
          regex: (.+)
        - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
          action: replace
          target_label: __address__
          regex: ([^:]+)(?::\d+)?;(\d+)
          replacement: $1:$2
        - action: labelmap
          regex: __meta_kubernetes_service_label_(.+)
        - source_labels: [__meta_kubernetes_namespace]
          action: replace
          target_label: kubernetes_namespace
        - source_labels: [__meta_kubernetes_service_name]
          action: replace
          target_label: kubernetes_name
      
      # Compliance metrics
      - job_name: 'compliance-metrics'
        static_configs:
        - targets: ['falco-exporter:9376']
        - targets: ['trivy-operator-metrics:9115']
        - targets: ['gatekeeper-controller-manager:8888']
        
      # Security monitoring
      - job_name: 'security-metrics'
        static_configs:
        - targets: ['cert-manager-metrics:9402']
        - targets: ['external-secrets-metrics:8080']

  recording-rules.yml: |
    groups:
    - name: kubernetes.rules
      rules:
      - record: cluster:namespace:pod_memory:active:kube_pod_container_resource_requests
        expr: |
          kube_pod_container_resource_requests{resource="memory",unit="byte"} * on (namespace, pod, cluster)
          group_left() max by (namespace, pod, cluster) (
            (kube_pod_status_phase{phase=~"Pending|Running"} == 1)
          )
      - record: cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests
        expr: |
          kube_pod_container_resource_requests{resource="cpu",unit="core"} * on (namespace, pod, cluster)
          group_left() max by (namespace, pod, cluster) (
            (kube_pod_status_phase{phase=~"Pending|Running"} == 1)
          )
          
    - name: compliance.rules
      rules:
      - record: compliance:security_violations:rate5m
        expr: rate(falco_events_total{priority=~"Emergency|Alert|Critical|Error|Warning"}[5m])
      - record: compliance:policy_violations:rate5m
        expr: rate(gatekeeper_violations_total[5m])
      - record: compliance:vulnerabilities:high_critical
        expr: sum by (namespace) (trivy_image_vulnerabilities{severity=~"HIGH|CRITICAL"})

  alerting-rules.yml: |
    groups:
    - name: kubernetes.alerts
      rules:
      - alert: KubePodCrashLooping
        expr: max_over_time(kube_pod_container_status_restarts_total[1h]) > 5
        for: 15m
        labels:
          severity: warning
          compliance_impact: "high"
        annotations:
          summary: Pod {{ $labels.namespace }}/{{ $labels.pod }} ({{ $labels.container }}) is crash looping
          description: Pod {{ $labels.namespace }}/{{ $labels.pod }} ({{ $labels.container }}) has been restarting {{ $value }} times in the last hour
          
      - alert: KubeNodeUnschedulable
        expr: kube_node_spec_unschedulable > 0
        for: 10m
        labels:
          severity: warning
        annotations:
          summary: Node {{ $labels.node }} is unschedulable
          description: Node {{ $labels.node }} has been unschedulable for more than 10 minutes
          
    - name: security.alerts
      rules:
      - alert: SecurityViolationDetected
        expr: increase(falco_events_total{priority=~"Emergency|Alert|Critical"}[5m]) > 0
        for: 0m
        labels:
          severity: critical
          compliance_framework: "SOC2,PCI-DSS"
        annotations:
          summary: Security violation detected by Falco
          description: Critical security event detected - {{ $labels.rule }}
          
      - alert: PolicyViolation
        expr: increase(gatekeeper_violations_total[5m]) > 0
        for: 1m
        labels:
          severity: warning
          compliance_framework: "CIS"
        annotations:
          summary: Policy violation detected
          description: Gatekeeper policy violation in {{ $labels.violation_kind }}
          
      - alert: HighCriticalVulnerabilities
        expr: sum by (namespace) (trivy_image_vulnerabilities{severity=~"HIGH|CRITICAL"}) > 10
        for: 1h
        labels:
          severity: warning
          compliance_framework: "SOC2"
        annotations:
          summary: High number of critical vulnerabilities
          description: Namespace {{ $labels.namespace }} has {{ $value }} high/critical vulnerabilities
          
    - name: compliance.alerts
      rules:
      - alert: CertificateExpiringSoon
        expr: (cert_manager_certificate_expiration_timestamp_seconds - time()) < 7 * 24 * 3600
        for: 1h
        labels:
          severity: warning
          compliance_framework: "SOC2,PCI-DSS"
        annotations:
          summary: Certificate expiring soon
          description: Certificate {{ $labels.name }} in namespace {{ $labels.namespace }} expires in less than 7 days
          
      - alert: UnencryptedSecretDetected
        expr: increase(falco_events_total{rule=~".*secret.*plain.*"}[5m]) > 0
        for: 0m
        labels:
          severity: critical
          compliance_framework: "HIPAA,PCI-DSS"
        annotations:
          summary: Unencrypted secret detected
          description: Potential unencrypted secret usage detected

---
# monitoring/grafana-enterprise-dashboards.yaml - Comprehensive dashboards
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboards
  namespace: monitoring-system
data:
  kubernetes-cluster-overview.json: |
    {
      "dashboard": {
        "id": null,
        "title": "Kubernetes Cluster Overview - Enterprise",
        "tags": ["kubernetes", "enterprise", "compliance"],
        "timezone": "utc",
        "panels": [
          {
            "id": 1,
            "title": "Cluster Resource Usage",
            "type": "stat",
            "targets": [
              {
                "expr": "sum(kube_node_status_allocatable{resource=\"cpu\"})",
                "legendFormat": "Allocatable CPU"
              },
              {
                "expr": "sum(kube_node_status_allocatable{resource=\"memory\"})",
                "legendFormat": "Allocatable Memory"
              }
            ],
            "gridPos": {"h": 8, "w": 12, "x": 0, "y": 0}
          },
          {
            "id": 2,
            "title": "Pod Status Distribution",
            "type": "piechart",
            "targets": [
              {
                "expr": "sum by (phase) (kube_pod_status_phase)",
                "legendFormat": "{{ phase }}"
              }
            ],
            "gridPos": {"h": 8, "w": 12, "x": 12, "y": 0}
          },
          {
            "id": 3,
            "title": "Security Violations (Last 24h)",
            "type": "stat",
            "targets": [
              {
                "expr": "sum(increase(falco_events_total{priority=~\"Emergency|Alert|Critical|Error|Warning\"}[24h]))",
                "legendFormat": "Security Events"
              }
            ],
            "fieldConfig": {
              "defaults": {
                "color": {
                  "mode": "thresholds"
                },
                "thresholds": {
                  "steps": [
                    {"color": "green", "value": null},
                    {"color": "yellow", "value": 10},
                    {"color": "red", "value": 50}
                  ]
                }
              }
            },
            "gridPos": {"h": 4, "w": 6, "x": 0, "y": 8}
          },
          {
            "id": 4,
            "title": "Policy Violations (Last 24h)",
            "type": "stat",
            "targets": [
              {
                "expr": "sum(increase(gatekeeper_violations_total[24h]))",
                "legendFormat": "Policy Violations"
              }
            ],
            "fieldConfig": {
              "defaults": {
                "color": {
                  "mode": "thresholds"
                },
                "thresholds": {
                  "steps": [
                    {"color": "green", "value": null},
                    {"color": "yellow", "value": 5},
                    {"color": "red", "value": 20}
                  ]
                }
              }
            },
            "gridPos": {"h": 4, "w": 6, "x": 6, "y": 8}
          },
          {
            "id": 5,
            "title": "Critical Vulnerabilities by Namespace",
            "type": "bargauge",
            "targets": [
              {
                "expr": "sum by (namespace) (trivy_image_vulnerabilities{severity=\"CRITICAL\"})",
                "legendFormat": "{{ namespace }}"
              }
            ],
            "gridPos": {"h": 8, "w": 12, "x": 12, "y": 8}
          }
        ],
        "time": {
          "from": "now-6h",
          "to": "now"
        },
        "refresh": "30s"
      }
    }

  compliance-dashboard.json: |
    {
      "dashboard": {
        "id": null,
        "title": "Kubernetes Compliance Dashboard",
        "tags": ["kubernetes", "compliance", "security"],
        "panels": [
          {
            "id": 1,
            "title": "SOC2 Controls Status",
            "type": "stat",
            "targets": [
              {
                "expr": "sum(rate(compliance_control_checks_total{framework=\"SOC2\",status=\"pass\"}[5m])) / sum(rate(compliance_control_checks_total{framework=\"SOC2\"}[5m])) * 100",
                "legendFormat": "SOC2 Compliance %"
              }
            ],
            "fieldConfig": {
              "defaults": {
                "unit": "percent",
                "min": 0,
                "max": 100,
                "thresholds": {
                  "steps": [
                    {"color": "red", "value": null},
                    {"color": "yellow", "value": 70},
                    {"color": "green", "value": 95}
                  ]
                }
              }
            }
          },
          {
            "id": 2,
            "title": "PCI-DSS Compliance Status",
            "type": "stat",
            "targets": [
              {
                "expr": "sum(rate(compliance_control_checks_total{framework=\"PCI-DSS\",status=\"pass\"}[5m])) / sum(rate(compliance_control_checks_total{framework=\"PCI-DSS\"}[5m])) * 100",
                "legendFormat": "PCI-DSS Compliance %"
              }
            ],
            "fieldConfig": {
              "defaults": {
                "unit": "percent",
                "min": 0,
                "max": 100,
                "thresholds": {
                  "steps": [
                    {"color": "red", "value": null},
                    {"color": "yellow", "value": 70},
                    {"color": "green", "value": 95}
                  ]
                }
              }
            }
          }
        ]
      }
    }
```

### Enterprise CI/CD & GitOps Automation

```yaml
# cicd/argocd-enterprise.yaml - GitOps with ArgoCD
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: enterprise-app-production
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
  labels:
    environment: production
    compliance-framework: 'SOC2,PCI-DSS,HIPAA'
spec:
  project: production
  source:
    repoURL: https://github.com/company/k8s-applications
    targetRevision: main
    path: manifests/production
    helm:
      valueFiles:
        - values-production.yaml
      parameters:
        - name: image.tag
          value: v1.2.3
        - name: security.enabled
          value: 'true'
        - name: compliance.framework
          value: 'SOC2,PCI-DSS,HIPAA'
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: false
    syncOptions:
      - CreateNamespace=true
      - PrunePropagationPolicy=foreground
      - PruneLast=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
  revisionHistoryLimit: 10

---
# cicd/appproject-production.yaml - Production project with restrictions
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: production
  namespace: argocd
  labels:
    environment: production
    security-tier: high
spec:
  description: Production environment applications with enhanced security
  sourceRepos:
    - 'https://github.com/company/*'
    - 'https://helm-charts.company.com/*'
  destinations:
    - namespace: production
      server: https://kubernetes.default.svc
    - namespace: monitoring-system
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: ''
      kind: Namespace
    - group: rbac.authorization.k8s.io
      kind: ClusterRole
    - group: rbac.authorization.k8s.io
      kind: ClusterRoleBinding
  namespaceResourceWhitelist:
    - group: ''
      kind: ConfigMap
    - group: ''
      kind: Secret
    - group: ''
      kind: Service
    - group: apps
      kind: Deployment
    - group: apps
      kind: StatefulSet
    - group: networking.k8s.io
      kind: NetworkPolicy
    - group: networking.k8s.io
      kind: Ingress
  roles:
    - name: prod-deployer
      description: Production deployment role
      policies:
        - p, proj:production:prod-deployer, applications, create, production/*, allow
        - p, proj:production:prod-deployer, applications, update, production/*, allow
        - p, proj:production:prod-deployer, applications, sync, production/*, allow
        - p, proj:production:prod-deployer, applications, get, production/*, allow
        - p, proj:production:prod-deployer, applications, list, production/*, allow
      groups:
        - company:production-team
    - name: security-auditor
      description: Security audit and compliance review
      policies:
        - p, proj:production:security-auditor, applications, get, production/*, allow
        - p, proj:production:security-auditor, applications, list, production/*, allow
        - p, proj:production:security-auditor, logs, get, production/*, allow
      groups:
        - company:security-team
  syncWindows:
    - kind: allow
      schedule: '0 9 * * 1-5' # Weekdays 9 AM
      duration: 8h
      applications:
        - production/*
      manualSync: true
    - kind: deny
      schedule: '0 18 * * 5' # Friday 6 PM
      duration: 60h # Until Monday 6 AM
      applications:
        - production/*
      manualSync: false

---
# cicd/tekton-enterprise-pipeline.yaml - Enterprise CI/CD pipeline
apiVersion: tekton.dev/v1beta1
kind: Pipeline
metadata:
  name: enterprise-security-pipeline
  namespace: tekton-pipelines
  labels:
    pipeline.tekton.dev/type: security-enhanced
spec:
  description: |
    Enterprise security-enhanced CI/CD pipeline with comprehensive scanning,
    compliance validation, and automated security controls.
  params:
    - name: git-url
      type: string
      description: The git repository URL to clone from.
    - name: git-revision
      type: string
      description: The git revision to clone.
      default: main
    - name: image-name
      type: string
      description: The name of the image to build
    - name: compliance-frameworks
      type: array
      description: List of compliance frameworks to validate against
      default: ['SOC2', 'PCI-DSS', 'CIS']
  workspaces:
    - name: shared-data
      description: |
        This workspace contains the cloned repo files, so they can be read by the
        next task.
    - name: docker-credentials
      description: Docker registry credentials
  tasks:
    - name: fetch-source
      taskRef:
        name: git-clone
        kind: ClusterTask
      workspaces:
        - name: output
          workspace: shared-data
      params:
        - name: url
          value: $(params.git-url)
        - name: revision
          value: $(params.git-revision)

    - name: security-scan-source
      taskRef:
        name: sonarqube-scanner
        kind: ClusterTask
      runAfter: ['fetch-source']
      workspaces:
        - name: source
          workspace: shared-data
      params:
        - name: SONAR_HOST_URL
          value: https://sonarqube.company.com
        - name: SONAR_PROJECT_KEY
          value: $(params.image-name)

    - name: secret-detection
      taskRef:
        name: trufflesecurity-trufflehog
        kind: ClusterTask
      runAfter: ['fetch-source']
      workspaces:
        - name: source
          workspace: shared-data

    - name: build-image
      taskRef:
        name: buildah
        kind: ClusterTask
      runAfter: ['security-scan-source', 'secret-detection']
      workspaces:
        - name: source
          workspace: shared-data
      params:
        - name: IMAGE
          value: $(params.image-name)
        - name: DOCKERFILE
          value: ./Dockerfile
        - name: CONTEXT
          value: .
        - name: TLSVERIFY
          value: 'true'

    - name: vulnerability-scan
      taskRef:
        name: trivy-scanner
        kind: ClusterTask
      runAfter: ['build-image']
      workspaces:
        - name: source
          workspace: shared-data
      params:
        - name: IMAGE
          value: $(params.image-name)
        - name: SEVERITY
          value: 'HIGH,CRITICAL'

    - name: compliance-validation
      taskRef:
        name: compliance-validator
        kind: Task
      runAfter: ['vulnerability-scan']
      workspaces:
        - name: source
          workspace: shared-data
      params:
        - name: image
          value: $(params.image-name)
        - name: frameworks
          value: $(params.compliance-frameworks[*])

    - name: policy-validation
      taskRef:
        name: opa-conftest
        kind: ClusterTask
      runAfter: ['compliance-validation']
      workspaces:
        - name: source
          workspace: shared-data
      params:
        - name: files
          value: 'k8s-manifests/*.yaml'
        - name: policy
          value: 'security-policies/'

    - name: sign-image
      taskRef:
        name: cosign-sign
        kind: ClusterTask
      runAfter: ['policy-validation']
      workspaces:
        - name: source
          workspace: shared-data
      params:
        - name: image
          value: $(params.image-name)

    - name: deploy-to-staging
      taskRef:
        name: argocd-task-sync-and-wait
        kind: ClusterTask
      runAfter: ['sign-image']
      params:
        - name: application-name
          value: $(params.image-name)-staging
        - name: argocd-server
          value: argocd-server.argocd.svc.cluster.local:443

    - name: security-testing
      taskRef:
        name: owasp-zap-baseline
        kind: ClusterTask
      runAfter: ['deploy-to-staging']
      params:
        - name: target-url
          value: https://$(params.image-name)-staging.company.com

    - name: compliance-evidence
      taskRef:
        name: evidence-collector
        kind: Task
      runAfter: ['security-testing']
      workspaces:
        - name: evidence
          workspace: shared-data
      params:
        - name: pipeline-run
          value: $(context.pipelineRun.name)
        - name: frameworks
          value: $(params.compliance-frameworks[*])

---
# cicd/custom-tasks.yaml - Custom compliance and security tasks
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: compliance-validator
  namespace: tekton-pipelines
spec:
  description: >-
    Validates container images and Kubernetes manifests against compliance frameworks
  params:
    - name: image
      description: Container image to validate
    - name: frameworks
      description: Compliance frameworks to validate against
      type: array
  workspaces:
    - name: source
  steps:
    - name: validate-soc2
      image: aquasec/trivy:latest
      script: |
        #!/bin/sh
        echo "Validating SOC2 compliance for $(params.image)"

        # Check for required security configurations
        trivy config --format json $(workspaces.source.path)/k8s-manifests/ > trivy-results.json

        # Validate SOC2 controls
        python3 -c "
        import json
        import sys

        with open('trivy-results.json') as f:
            results = json.load(f)

        soc2_violations = []
        for result in results.get('Results', []):
            for misconfig in result.get('Misconfigurations', []):
                if 'SOC2' in misconfig.get('ID', ''):
                    soc2_violations.append(misconfig)

        if soc2_violations:
            print('SOC2 compliance violations found:')
            for violation in soc2_violations:
                print(f'- {violation[\"Title\"]}: {violation[\"Message\"]}')
            sys.exit(1)
        else:
            print('SOC2 compliance validation passed')
        "

    - name: validate-pci-dss
      image: aquasec/kube-bench:latest
      script: |
        #!/bin/sh
        echo "Validating PCI-DSS compliance requirements"

        # Check for PCI-DSS specific requirements
        if ! grep -q "runAsNonRoot: true" $(workspaces.source.path)/k8s-manifests/*.yaml; then
          echo "ERROR: Containers must run as non-root user (PCI-DSS requirement)"
          exit 1
        fi

        if ! grep -q "readOnlyRootFilesystem: true" $(workspaces.source.path)/k8s-manifests/*.yaml; then
          echo "ERROR: Containers must use read-only root filesystem (PCI-DSS requirement)"
          exit 1
        fi

        echo "PCI-DSS compliance validation passed"

    - name: validate-cis
      image: aquasec/kube-bench:latest
      script: |
        #!/bin/sh
        echo "Validating CIS Kubernetes Benchmark compliance"

        # Run CIS benchmark checks on manifests
        kube-bench --benchmark cis-1.23 --check 5.1.1,5.1.2,5.1.3,5.1.4,5.1.5 --json > cis-results.json

        # Check for critical failures
        if grep -q '"test_number":"5.1.1","test_desc":".*","audit":".*","type":"manual","status":"FAIL"' cis-results.json; then
          echo "ERROR: CIS benchmark validation failed for critical controls"
          exit 1
        fi

        echo "CIS benchmark compliance validation passed"

---
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: evidence-collector
  namespace: tekton-pipelines
spec:
  description: >-
    Collects compliance evidence from pipeline execution for audit trails
  params:
    - name: pipeline-run
      description: Pipeline run name
    - name: frameworks
      description: Compliance frameworks
      type: array
  workspaces:
    - name: evidence
  steps:
    - name: collect-evidence
      image: alpine/git:latest
      script: |
        #!/bin/sh
        EVIDENCE_DIR=$(workspaces.evidence.path)/evidence
        mkdir -p $EVIDENCE_DIR

        echo "Collecting compliance evidence for pipeline run: $(params.pipeline-run)"

        # Create evidence manifest
        cat > $EVIDENCE_DIR/evidence-manifest.json << EOF
        {
          "pipeline_run": "$(params.pipeline-run)",
          "timestamp": "$(date -Iseconds)",
          "frameworks": [$(printf '"%s",' $(params.frameworks) | sed 's/,$//')],
          "evidence_items": [
            {
              "type": "security_scan",
              "tool": "trivy",
              "file": "trivy-scan-results.json",
              "description": "Container vulnerability scan results"
            },
            {
              "type": "compliance_validation",
              "tool": "custom_validator",
              "file": "compliance-validation-results.json",
              "description": "Multi-framework compliance validation"
            },
            {
              "type": "policy_validation",
              "tool": "opa-conftest",
              "file": "policy-validation-results.json",
              "description": "Security policy validation results"
            },
            {
              "type": "code_analysis",
              "tool": "sonarqube",
              "file": "sonarqube-scan-results.json",
              "description": "Static code analysis results"
            }
          ]
        }
        EOF

        echo "Evidence collection completed"
        ls -la $EVIDENCE_DIR/
```

## �📚 Enterprise References and Documentation

- **Kubernetes Documentation**: [kubernetes.io](https://kubernetes.io) - Official Kubernetes documentation and best practices
- **CNCF Landscape**: [landscape.cncf.io](https://landscape.cncf.io) - Cloud native technologies and tools ecosystem
- **CIS Kubernetes Benchmark**: [cisecurity.org](https://www.cisecurity.org/benchmark/kubernetes) - Security benchmarks and hardening guidelines
- **NIST Container Security**: [nist.gov/publications](https://csrc.nist.gov/publications) - Container and Kubernetes security guidelines
- **Istio Service Mesh**: [istio.io](https://istio.io) - Service mesh architecture and implementation patterns
- **ArgoCD GitOps**: [argoproj.github.io](https://argoproj.github.io/argo-cd/) - GitOps deployment patterns and best practices
- **Prometheus Monitoring**: [prometheus.io](https://prometheus.io) - Monitoring and alerting configuration
- **OPA Gatekeeper**: [open-policy-agent.github.io](https://open-policy-agent.github.io/gatekeeper/) - Policy as code implementation

### Enterprise Support and Escalation

- **Platform Team**: platform@enterprise.com - Primary support for Kubernetes infrastructure and best practices
- **Security Team**: security@enterprise.com - Security policies, compliance, and vulnerability management
- **DevOps Engineering**: devops@enterprise.com - CI/CD pipelines, GitOps, and deployment automation
- **On-Call Support**: +1-555-K8S-HELP - 24/7 production Kubernetes cluster support and incident response
