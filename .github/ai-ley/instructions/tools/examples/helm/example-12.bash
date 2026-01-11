# Enterprise ArgoCD setup for Helm chart deployments
cat > ~/.local/bin/setup-argocd-helm-integration.sh << 'EOF'
#!/bin/bash
set -euo pipefail

NAMESPACE="${ARGOCD_NAMESPACE:-argocd}"
DOMAIN="${ARGOCD_DOMAIN:-argocd.enterprise.local}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [GITOPS] $*"
}

# Install ArgoCD with enterprise configuration
install_argocd() {
    log "Installing ArgoCD for GitOps workflows..."

    # Add ArgoCD Helm repository
    helm repo add argo https://argoproj.github.io/argo-helm
    helm repo update

    # ArgoCD enterprise configuration
    cat > /tmp/argocd-values.yaml << 'ARGOCD_EOF'
global:
  image:
    repository: quay.io/argoproj/argocd
    tag: v2.8.4

server:
  service:
    type: ClusterIP
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: enterprise-ca
      nginx.ingress.kubernetes.io/ssl-redirect: "true"
    hosts:
      - argocd.enterprise.local
    tls:
      - secretName: argocd-tls
        hosts:
          - argocd.enterprise.local

  config:
    repositories: |
      - type: git
        url: https://github.com/enterprise/helm-charts
        name: enterprise-charts
      - type: helm
        url: https://harbor.enterprise.local/chartrepo/library
        name: harbor-charts
        username: admin
        password: $harbor-credentials:password

    helm.repositories: |
      - url: https://charts.bitnami.com/bitnami
        name: bitnami
      - url: https://kubernetes.github.io/ingress-nginx
        name: ingress-nginx
      - url: https://harbor.enterprise.local/chartrepo/library
        name: harbor

  rbacConfig:
    policy.default: role:readonly
    policy.csv: |
      p, role:enterprise-admin, applications, *, */*, allow
      p, role:enterprise-admin, clusters, *, *, allow
      p, role:enterprise-admin, repositories, *, *, allow
      g, enterprise:platform-team, role:enterprise-admin

repoServer:
  replicas: 2
  resources:
    requests:
      cpu: 250m
      memory: 512Mi
    limits:
      cpu: 500m
      memory: 1Gi

controller:
  replicas: 1
  resources:
    requests:
      cpu: 500m
      memory: 1Gi
    limits:
      cpu: 1000m
      memory: 2Gi

redis:
  enabled: true
  resources:
    requests:
      cpu: 100m
      memory: 128Mi
    limits:
      cpu: 200m
      memory: 256Mi
ARGOCD_EOF

    # Install ArgoCD
    kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -
    helm upgrade --install argocd argo/argo-cd \
        --namespace "$NAMESPACE" \
        --values /tmp/argocd-values.yaml \
        --wait

    log "✓ ArgoCD installed successfully"
}

# Configure enterprise application templates
setup_application_templates() {
    log "Setting up enterprise application templates..."

    # Multi-environment application template
    cat > /tmp/enterprise-app-template.yaml << 'APP_EOF'
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: enterprise-app-{{ .Environment }}
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  project: enterprise
  source:
    repoURL: https://github.com/enterprise/helm-charts
    targetRevision: HEAD
    path: charts/enterprise-app
    helm:
      releaseName: enterprise-app
      valueFiles:
        - values-{{ .Environment }}.yaml
      parameters:
        - name: image.tag
          value: "{{ .ImageTag }}"
        - name: environment
          value: "{{ .Environment }}"
        - name: replicaCount
          value: "{{ .ReplicaCount }}"
  destination:
    server: https://kubernetes.default.svc
    namespace: enterprise-{{ .Environment }}
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
  revisionHistoryLimit: 3
APP_EOF

    # Application project for RBAC
    cat > /tmp/enterprise-project.yaml << 'PROJ_EOF'
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: enterprise
  namespace: argocd
spec:
  description: Enterprise applications project
  sourceRepos:
    - 'https://github.com/enterprise/*'
    - 'https://harbor.enterprise.local/chartrepo/*'
  destinations:
    - namespace: 'enterprise-*'
      server: https://kubernetes.default.svc
    - namespace: 'monitoring'
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: ''
      kind: Namespace
    - group: rbac.authorization.k8s.io
      kind: ClusterRole
    - group: rbac.authorization.k8s.io
      kind: ClusterRoleBinding
  namespaceResourceWhitelist:
    - group: '*'
      kind: '*'
  roles:
    - name: developer
      description: Developer access
      policies:
        - p, proj:enterprise:developer, applications, get, enterprise/*, allow
        - p, proj:enterprise:developer, applications, sync, enterprise/*, allow
      groups:
        - enterprise:developers
    - name: admin
      description: Admin access
      policies:
        - p, proj:enterprise:admin, applications, *, enterprise/*, allow
        - p, proj:enterprise:admin, repositories, *, *, allow
      groups:
        - enterprise:admins
PROJ_EOF

    kubectl apply -f /tmp/enterprise-project.yaml

    log "✓ Enterprise application templates configured"
}

# Setup multi-cluster management
setup_multi_cluster() {
    log "Setting up multi-cluster management..."

    # Cluster registration script
    cat > ~/.local/bin/register-cluster.sh << 'CLUSTER_EOF'
#!/bin/bash
set -euo pipefail

CLUSTER_NAME="$1"
CLUSTER_SERVER="$2"
CLUSTER_TOKEN="$3"

# Add cluster to ArgoCD
argocd cluster add "$CLUSTER_NAME" \
    --server "$CLUSTER_SERVER" \
    --auth-token "$CLUSTER_TOKEN" \
    --name "$CLUSTER_NAME" \
    --upsert

echo "Cluster $CLUSTER_NAME registered successfully"
CLUSTER_EOF

    chmod +x ~/.local/bin/register-cluster.sh

    log "✓ Multi-cluster management configured"
}

# Execute ArgoCD setup
install_argocd
setup_application_templates
setup_multi_cluster

log "Enterprise GitOps setup completed"
EOF

chmod +x ~/.local/bin/setup-argocd-helm-integration.sh