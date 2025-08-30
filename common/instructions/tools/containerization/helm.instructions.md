`
---
applyTo: "helm, **/*helm*, **/charts/**, **/*.helm.yaml"
---

# Helm Kubernetes Package Manager Instructions

## Overview
- **Domain**: Kubernetes Application Packaging and Deployment
- **Purpose**: Package, configure, and deploy applications to Kubernetes clusters using Helm charts
- **Applicable To**: Kubernetes applications, microservices, complex deployments, and infrastructure components
- **Integration Level**: Kubernetes cluster management and application lifecycle automation

## Core Principles

### Fundamental Concepts
1. **Package Management for Kubernetes**: Helm manages Kubernetes applications through charts
2. **Templating and Configuration**: Use templates and values to customize deployments
3. **Release Management**: Track deployments and enable rollbacks and upgrades
4. **Repository Ecosystem**: Share and discover applications through chart repositories

### Key Benefits
- Simplified Kubernetes application deployment and management
- Templating system for configuration flexibility and reuse
- Release management with rollback and upgrade capabilities
- Large ecosystem of pre-built charts for common applications
- Dependency management for complex application stacks

### Common Misconceptions
- **Myth**: Helm is only useful for complex applications
  **Reality**: Helm provides value even for simple applications through templating and release management
- **Myth**: Helm adds unnecessary complexity to Kubernetes
  **Reality**: Helm simplifies Kubernetes deployments and provides essential management capabilities

## Implementation Framework

### Getting Started
#### Prerequisites
- Kubernetes cluster (local or cloud-based)
- kubectl configured and working
- Basic understanding of Kubernetes concepts (pods, services, deployments)

#### Initial Setup
```bash
# Install Helm (macOS)
brew install helm

# Install Helm (Linux)
curl https://get.helm.sh/helm-v3.13.2-linux-amd64.tar.gz | tar xz
sudo mv linux-amd64/helm /usr/local/bin/

# Verify installation
helm version

# Add popular chart repositories
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# List available repositories
helm repo list
```

### Core Methodologies
#### Chart Development
- **Purpose**: Create reusable Kubernetes application packages
- **When to Use**: Custom applications and standardized deployments
- **Implementation Steps**:
  1. Create chart structure with helm create
  2. Define templates for Kubernetes resources
  3. Configure values.yaml for customization
  4. Test and validate chart functionality
- **Success Metrics**: Reusable charts with proper templating and documentation

#### Release Management
- **Purpose**: Deploy, upgrade, and manage application releases
- **When to Use**: All Kubernetes application deployments
- **Implementation Steps**:
  1. Install applications using helm install
  2. Upgrade releases with helm upgrade
  3. Monitor deployments with helm status
  4. Rollback failed deployments with helm rollback
- **Success Metrics**: Reliable deployments with easy rollback capabilities

### Process Integration
#### Development Workflow
```bash
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
```

#### CI/CD Integration
```yaml
# .github/workflows/helm-deploy.yml
name: Deploy with Helm
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Helm
      uses: azure/setup-helm@v3
      with:
        version: '3.13.2'
    
    - name: Setup kubectl
      uses: azure/setup-kubectl@v3
      with:
        version: '1.28.0'
    
    - name: Deploy to staging
      run: |
        echo "${{ secrets.KUBECONFIG }}" | base64 -d > kubeconfig
        export KUBECONFIG=kubeconfig
        
        helm upgrade --install my-app ./charts/my-app \
          --namespace staging \
          --create-namespace \
          --set image.tag=${{ github.sha }} \
          --set environment=staging \
          --wait
```

## Best Practices

### Chart Structure and Templates
```yaml
# Chart.yaml - Chart metadata
apiVersion: v2
name: web-application
description: A Helm chart for a modern web application
type: application
version: 0.1.0
appVersion: "1.0.0"

keywords:
  - web
  - nodejs
  - react

home: https://github.com/company/web-app
sources:
  - https://github.com/company/web-app

maintainers:
  - name: DevOps Team
    email: devops@company.com

dependencies:
  - name: postgresql
    version: 12.x.x
    repository: https://charts.bitnami.com/bitnami
    condition: postgresql.enabled
  - name: redis
    version: 17.x.x
    repository: https://charts.bitnami.com/bitnami
    condition: redis.enabled
```

```yaml
# values.yaml - Default configuration values
# Default values for web-application chart

replicaCount: 3

image:
  repository: myregistry.com/web-app
  pullPolicy: IfNotPresent
  tag: "latest"

imagePullSecrets: []
nameOverride: ""
fullnameOverride: ""

serviceAccount:
  create: true
  annotations: {}
  name: ""

podAnnotations: {}

podSecurityContext:
  fsGroup: 2000

securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  runAsUser: 1000

service:
  type: ClusterIP
  port: 80
  targetPort: 3000

ingress:
  enabled: true
  className: "nginx"
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    cert-manager.io/cluster-issuer: letsencrypt-prod
  hosts:
    - host: myapp.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: myapp-tls
      hosts:
        - myapp.example.com

resources:
  limits:
    cpu: 500m
    memory: 512Mi
  requests:
    cpu: 250m
    memory: 256Mi

autoscaling:
  enabled: true
  minReplicas: 3
  maxReplicas: 10
  targetCPUUtilizationPercentage: 70
  targetMemoryUtilizationPercentage: 80

nodeSelector: {}

tolerations: []

affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
    - weight: 100
      podAffinityTerm:
        labelSelector:
          matchExpressions:
          - key: app.kubernetes.io/name
            operator: In
            values:
            - web-application
        topologyKey: kubernetes.io/hostname

# Application-specific configuration
app:
  environment: production
  logLevel: info
  port: 3000

# Database configuration
postgresql:
  enabled: true
  auth:
    database: webapp
    username: webapp
  primary:
    persistence:
      size: 10Gi

redis:
  enabled: true
  auth:
    enabled: false
  master:
    persistence:
      size: 1Gi

# Environment variables
env:
  NODE_ENV: production
  LOG_LEVEL: info

# Secrets (use external secret management in production)
secrets:
  database:
    username: webapp
    # password: set via --set-string or external secret
  redis:
    # password: set via --set-string or external secret

# Health check configuration
healthCheck:
  enabled: true
  path: /health
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3

# Monitoring and observability
monitoring:
  enabled: true
  serviceMonitor:
    enabled: true
    path: /metrics
    interval: 30s
```

```yaml
# templates/deployment.yaml - Deployment template
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "web-application.fullname" . }}
  labels:
    {{- include "web-application.labels" . | nindent 4 }}
spec:
  {{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.replicaCount }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "web-application.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      annotations:
        checksum/config: {{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
        checksum/secret: {{ include (print $.Template.BasePath "/secret.yaml") . | sha256sum }}
        {{- with .Values.podAnnotations }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
      labels:
        {{- include "web-application.selectorLabels" . | nindent 8 }}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ include "web-application.serviceAccountName" . }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ .Chart.Name }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          ports:
            - name: http
              containerPort: {{ .Values.app.port }}
              protocol: TCP
          env:
            - name: NODE_ENV
              value: {{ .Values.app.environment | quote }}
            - name: LOG_LEVEL
              value: {{ .Values.app.logLevel | quote }}
            - name: PORT
              value: {{ .Values.app.port | quote }}
            {{- if .Values.postgresql.enabled }}
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: {{ include "web-application.fullname" . }}-secrets
                  key: database-url
            {{- end }}
            {{- if .Values.redis.enabled }}
            - name: REDIS_URL
              valueFrom:
                secretKeyRef:
                  name: {{ include "web-application.fullname" . }}-secrets
                  key: redis-url
            {{- end }}
            {{- range $key, $value := .Values.env }}
            - name: {{ $key }}
              value: {{ $value | quote }}
            {{- end }}
          {{- if .Values.healthCheck.enabled }}
          livenessProbe:
            httpGet:
              path: {{ .Values.healthCheck.path }}
              port: http
            initialDelaySeconds: {{ .Values.healthCheck.initialDelaySeconds }}
            periodSeconds: {{ .Values.healthCheck.periodSeconds }}
            timeoutSeconds: {{ .Values.healthCheck.timeoutSeconds }}
            failureThreshold: {{ .Values.healthCheck.failureThreshold }}
          readinessProbe:
            httpGet:
              path: {{ .Values.healthCheck.path }}
              port: http
            initialDelaySeconds: 5
            periodSeconds: 5
            timeoutSeconds: 3
            failureThreshold: 3
          {{- end }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
          volumeMounts:
            - name: tmp
              mountPath: /tmp
      volumes:
        - name: tmp
          emptyDir: {}
      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
```

### Helper Templates
```yaml
# templates/_helpers.tpl - Template helpers
{{/*
Expand the name of the chart.
*/}}
{{- define "web-application.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "web-application.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "web-application.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "web-application.labels" -}}
helm.sh/chart: {{ include "web-application.chart" . }}
{{ include "web-application.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "web-application.selectorLabels" -}}
app.kubernetes.io/name: {{ include "web-application.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "web-application.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "web-application.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate database URL from postgresql subchart
*/}}
{{- define "web-application.databaseUrl" -}}
{{- if .Values.postgresql.enabled -}}
postgresql://{{ .Values.postgresql.auth.username }}:{{ .Values.secrets.database.password }}@{{ include "web-application.fullname" . }}-postgresql:5432/{{ .Values.postgresql.auth.database }}
{{- end }}
{{- end }}

{{/*
Generate Redis URL from redis subchart
*/}}
{{- define "web-application.redisUrl" -}}
{{- if .Values.redis.enabled -}}
{{- if .Values.secrets.redis.password -}}
redis://:{{ .Values.secrets.redis.password }}@{{ include "web-application.fullname" . }}-redis-master:6379
{{- else -}}
redis://{{ include "web-application.fullname" . }}-redis-master:6379
{{- end }}
{{- end }}
{{- end }}
```

## Common Patterns and Examples

### Pattern 1: Multi-Environment Deployment
**Scenario**: Deploy application across development, staging, and production environments
**Implementation**:
```bash
# values-development.yaml
replicaCount: 1
image:
  tag: development
app:
  environment: development
  logLevel: debug
resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
autoscaling:
  enabled: false

# values-staging.yaml  
replicaCount: 2
image:
  tag: staging
app:
  environment: staging
  logLevel: info
ingress:
  hosts:
    - host: staging.myapp.com
      paths:
        - path: /
          pathType: Prefix

# values-production.yaml
replicaCount: 5
image:
  tag: stable
app:
  environment: production
  logLevel: warn
resources:
  limits:
    cpu: 1000m
    memory: 1Gi
  requests:
    cpu: 500m
    memory: 512Mi
autoscaling:
  enabled: true
  minReplicas: 5
  maxReplicas: 20

# Deploy to different environments
helm install myapp-dev ./charts/web-app -f values-development.yaml -n development
helm install myapp-staging ./charts/web-app -f values-staging.yaml -n staging  
helm install myapp-prod ./charts/web-app -f values-production.yaml -n production
```
**Expected Outcomes**: Consistent deployments across environments with appropriate configurations

### Pattern 2: Blue-Green Deployment Strategy
**Scenario**: Zero-downtime deployments using blue-green strategy
**Implementation**:
```bash
#!/bin/bash
# blue-green-deploy.sh

CHART_PATH="./charts/web-app"
NAMESPACE="production"
APP_NAME="myapp"
NEW_VERSION=$1

if [ -z "$NEW_VERSION" ]; then
  echo "Usage: $0 <new-version>"
  exit 1
fi

# Get current active deployment
CURRENT_RELEASE=$(helm list -n $NAMESPACE -o json | jq -r '.[] | select(.name | startswith("'$APP_NAME'")) | .name')
CURRENT_COLOR=$(echo $CURRENT_RELEASE | sed "s/$APP_NAME-//")

# Determine new color
if [ "$CURRENT_COLOR" = "blue" ]; then
  NEW_COLOR="green"
else
  NEW_COLOR="blue"
fi

NEW_RELEASE="$APP_NAME-$NEW_COLOR"

echo "Deploying $NEW_RELEASE with version $NEW_VERSION..."

# Deploy new version
helm upgrade --install $NEW_RELEASE $CHART_PATH \
  --namespace $NAMESPACE \
  --set image.tag=$NEW_VERSION \
  --set nameOverride=$APP_NAME-$NEW_COLOR \
  --wait

# Test new deployment
echo "Testing new deployment..."
kubectl port-forward -n $NAMESPACE svc/$NEW_RELEASE 8080:80 &
PF_PID=$!
sleep 5

# Simple health check
HEALTH_CHECK=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health)
kill $PF_PID

if [ "$HEALTH_CHECK" = "200" ]; then
  echo "Health check passed. Switching traffic..."
  
  # Update ingress to point to new deployment
  helm upgrade $NEW_RELEASE $CHART_PATH \
    --namespace $NAMESPACE \
    --set image.tag=$NEW_VERSION \
    --set nameOverride=$APP_NAME \
    --reuse-values
  
  echo "Traffic switched to $NEW_COLOR deployment"
  
  # Clean up old deployment after verification
  read -p "Remove old $CURRENT_COLOR deployment? (y/N): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    helm uninstall $CURRENT_RELEASE -n $NAMESPACE
    echo "Old deployment removed"
  fi
else
  echo "Health check failed. Rolling back..."
  helm uninstall $NEW_RELEASE -n $NAMESPACE
  exit 1
fi
```
**Expected Outcomes**: Zero-downtime deployments with automatic rollback on failure

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Hardcoded Values in Templates
- **Description**: Using literal values instead of template variables
- **Why It's Problematic**: Reduces chart reusability and flexibility
- **Better Approach**: Use values.yaml and template functions for all configurations

#### Anti-Pattern 2: Ignoring Resource Limits
- **Description**: Not setting CPU and memory limits for containers
- **Why It's Problematic**: Can cause resource contention and cluster instability
- **Better Approach**: Always define appropriate resource requests and limits

## Tools and Resources

### Essential Commands
```bash
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
```

### Testing and Validation
```bash
# Chart testing with different values
helm template my-release ./my-chart -f values-test.yaml

# Validate against Kubernetes
helm template my-release ./my-chart | kubectl apply --dry-run=client -f -

# Test installation without deploying
helm install my-release ./my-chart --dry-run --debug

# Chart testing with helm test
# Add test pods to templates/tests/
helm test my-release
```

### Learning Resources
- **Helm Documentation**: https://helm.sh/docs/
- **Chart Best Practices**: https://helm.sh/docs/chart_best_practices/
- **Helm Hub**: https://artifacthub.io/
- **Chart Testing**: https://github.com/helm/chart-testing

## Quality and Compliance

### Quality Standards
- All charts must pass helm lint validation
- Charts include comprehensive documentation and examples
- Resource limits and requests properly configured
- Health checks implemented for all deployments
- Secrets properly managed (not hardcoded)

### Security Standards
- Use least-privilege security contexts
- Enable pod security standards
- Manage secrets through external systems (not in values.yaml)
- Regular updates of chart dependencies
- Image scanning and vulnerability assessment

### Performance Standards
- Resource requests and limits based on actual usage
- Horizontal Pod Autoscaler configured for scalable applications
- Efficient image pulling strategies
- Proper affinity rules for high availability

## AI Assistant Guidelines

When helping with Helm Development:

1. **Chart Design First**: Always analyze application requirements and Kubernetes resource needs before creating charts
2. **Templating Strategy**: Use comprehensive templating for flexibility while maintaining simplicity
3. **Security Focus**: Implement proper security contexts, resource limits, and secret management
4. **Best Practices**: Follow Helm chart best practices for naming, labeling, and organization
5. **Testing Strategy**: Include comprehensive testing and validation approaches
6. **Documentation**: Ensure charts are well-documented with clear usage examples
7. **Dependency Management**: Properly manage chart dependencies and version constraints
8. **Release Management**: Plan for upgrades, rollbacks, and release lifecycle management

### Decision Making Framework
When helping teams choose Helm approaches:

1. **Requirements Analysis**: Understand application architecture and deployment requirements
2. **Chart Strategy**: Decide between creating custom charts vs using existing ones
3. **Template Design**: Plan templating strategy for flexibility and maintainability
4. **Environment Strategy**: Design for multiple environments with proper value overrides
5. **CI/CD Integration**: Plan for automated deployment and testing workflows
6. **Security Assessment**: Implement appropriate security measures and compliance requirements

### Code Generation Rules
- Generate charts following Helm best practices and conventions
- Include comprehensive values.yaml with proper documentation
- Use helper templates for common patterns and reusability
- Implement proper resource management and security contexts
- Generate corresponding tests and validation scripts
- Include multi-environment configuration examples
- Follow Kubernetes resource naming and labeling conventions
- Provide clear documentation and usage examples

### Quality Enforcement
- ✅ Enforce proper chart structure and naming conventions
- ✅ Require resource limits and requests for all containers
- ✅ Block hardcoded values in favor of templating
- ✅ Enforce security contexts and pod security standards
- ✅ Require health checks for all application deployments
- ✅ Enforce proper secret management practices
- ✅ Require chart documentation and examples
- ✅ Promote testing and validation strategies