# Flux v2 setup for enterprise GitOps workflows
cat > ~/.local/bin/setup-flux-helm-integration.sh << 'EOF'
#!/bin/bash
set -euo pipefail

GITHUB_USER="${GITHUB_USER:-enterprise}"
GITHUB_TOKEN="${GITHUB_TOKEN}"
GITHUB_REPO="${GITHUB_REPO:-helm-charts}"
CLUSTER_NAME="${CLUSTER_NAME:-enterprise-cluster}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [FLUX] $*"
}

# Install Flux CLI and bootstrap
install_flux() {
    log "Installing Flux CLI and bootstrapping..."

    # Install Flux CLI
    if ! command -v flux &> /dev/null; then
        curl -s https://fluxcd.io/install.sh | bash
        export PATH="$HOME/.local/bin:$PATH"
    fi

    # Bootstrap Flux
    flux bootstrap github \
        --owner="$GITHUB_USER" \
        --repository="$GITHUB_REPO" \
        --branch=main \
        --path="clusters/$CLUSTER_NAME" \
        --personal \
        --token-auth

    log "✓ Flux bootstrapped successfully"
}

# Create Helm repository sources
setup_helm_repositories() {
    log "Setting up Helm repository sources..."

    # Enterprise Harbor registry
    cat > /tmp/harbor-source.yaml << 'HARBOR_EOF'
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: harbor
  namespace: flux-system
spec:
  interval: 10m
  url: https://harbor.enterprise.local/chartrepo/library
  secretRef:
    name: harbor-credentials
---
apiVersion: v1
kind: Secret
metadata:
  name: harbor-credentials
  namespace: flux-system
type: Opaque
stringData:
  username: admin
  password: Harbor12345
HARBOR_EOF

    # Bitnami repository
    cat > /tmp/bitnami-source.yaml << 'BITNAMI_EOF'
apiVersion: source.toolkit.fluxcd.io/v1beta1
kind: HelmRepository
metadata:
  name: bitnami
  namespace: flux-system
spec:
  interval: 30m
  url: https://charts.bitnami.com/bitnami
BITNAMI_EOF

    kubectl apply -f /tmp/harbor-source.yaml
    kubectl apply -f /tmp/bitnami-source.yaml

    log "✓ Helm repository sources configured"
}

# Create GitOps workflow templates
create_gitops_templates() {
    log "Creating GitOps workflow templates..."

    # Environment-specific Kustomization
    for env in development staging production; do
        cat > "/tmp/kustomization-$env.yaml" << KUST_EOF
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
metadata:
  name: enterprise-app-$env
  namespace: flux-system
spec:
  interval: 10m
  sourceRef:
    kind: GitRepository
    name: flux-system
  path: "./environments/$env"
  prune: true
  wait: true
  timeout: 5m
  postBuild:
    substitute:
      environment: "$env"
      cluster_name: "$CLUSTER_NAME"
  healthChecks:
    - apiVersion: apps/v1
      kind: Deployment
      name: enterprise-app
      namespace: enterprise-$env
KUST_EOF

        kubectl apply -f "/tmp/kustomization-$env.yaml"
    done

    log "✓ GitOps workflow templates created"
}

# Setup monitoring and alerting for GitOps
setup_gitops_monitoring() {
    log "Setting up GitOps monitoring..."

    # Flux monitoring dashboard
    cat > /tmp/flux-monitoring.yaml << 'MONITOR_EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: flux-grafana-dashboard
  namespace: monitoring
  labels:
    grafana_dashboard: "1"
data:
  flux-dashboard.json: |
    {
      "dashboard": {
        "title": "Flux GitOps Dashboard",
        "panels": [
          {
            "title": "Git Repository Sync Status",
            "type": "stat",
            "targets": [
              {
                "expr": "gotk_reconcile_condition{type=\"Ready\",kind=\"GitRepository\"}",
                "legendFormat": "{{name}}"
              }
            ]
          },
          {
            "title": "Helm Release Status",
            "type": "stat",
            "targets": [
              {
                "expr": "gotk_reconcile_condition{type=\"Ready\",kind=\"HelmRelease\"}",
                "legendFormat": "{{name}}"
              }
            ]
          }
        ]
      }
    }
MONITOR_EOF

    kubectl apply -f /tmp/flux-monitoring.yaml || {
        log "INFO: Monitoring namespace not available, skipping dashboard"
    }

    log "✓ GitOps monitoring configured"
}

# Execute Flux setup
install_flux
setup_helm_repositories
create_gitops_templates
setup_gitops_monitoring

## 📊 Enterprise Monitoring & Observability Platform

### Prometheus & Grafana Stack for Helm Monitoring