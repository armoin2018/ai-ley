#!/bin/bash

# Helm Deployment Script
# Usage: ./deploy.sh [environment] [action]

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HELM_DIR="$(dirname "$SCRIPT_DIR")"
DEFAULT_ENVIRONMENT="development"
DEFAULT_ACTION="install"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[WARN] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

# Parse arguments
ENVIRONMENT="${1:-$DEFAULT_ENVIRONMENT}"
ACTION="${2:-$DEFAULT_ACTION}"

# Configuration based on environment
case "$ENVIRONMENT" in
    "development"|"dev")
        NAMESPACE="myapp-dev"
        VALUES_FILE="values-dev.yaml"
        RELEASE_NAME="myapp-dev"
        ;;
    "staging"|"stage")
        NAMESPACE="myapp-staging"
        VALUES_FILE="values-staging.yaml"
        RELEASE_NAME="myapp-staging"
        ;;
    "production"|"prod")
        NAMESPACE="myapp-prod"
        VALUES_FILE="values-prod.yaml"
        RELEASE_NAME="myapp-prod"
        ;;
    *)
        error "Unknown environment: $ENVIRONMENT. Supported: development, staging, production"
        ;;
esac

# Check prerequisites
command -v helm >/dev/null 2>&1 || error "helm not found. Please install Helm."
command -v kubectl >/dev/null 2>&1 || error "kubectl not found. Please install kubectl."

# Verify kubectl connectivity
kubectl cluster-info >/dev/null 2>&1 || error "Cannot connect to Kubernetes cluster"

# Change to helm directory
cd "$HELM_DIR"

# Validate values file exists
if [[ ! -f "$VALUES_FILE" ]]; then
    warn "Values file $VALUES_FILE not found, using default values.yaml"
    VALUES_FILE="values.yaml"
fi

# Update dependencies
log "Updating Helm dependencies..."
helm dependency update || error "Failed to update dependencies"

# Lint chart
log "Linting Helm chart..."
helm lint . -f "$VALUES_FILE" || error "Helm lint failed"

# Create namespace if it doesn't exist
log "Creating namespace: $NAMESPACE"
kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

case "$ACTION" in
    "install")
        log "Installing Helm chart..."
        helm install "$RELEASE_NAME" . \
            --namespace "$NAMESPACE" \
            --values "$VALUES_FILE" \
            --wait \
            --timeout 600s || error "Helm install failed"
        
        success "Chart installed successfully!"
        ;;
    
    "upgrade")
        log "Upgrading Helm chart..."
        helm upgrade "$RELEASE_NAME" . \
            --namespace "$NAMESPACE" \
            --values "$VALUES_FILE" \
            --wait \
            --timeout 600s || error "Helm upgrade failed"
        
        success "Chart upgraded successfully!"
        ;;
    
    "uninstall")
        echo -e "${RED}WARNING: You are about to uninstall $RELEASE_NAME in $NAMESPACE!${NC}"
        read -p "Are you sure? (yes/no): " confirm
        if [[ "$confirm" != "yes" ]]; then
            log "Uninstall cancelled"
            exit 0
        fi
        
        log "Uninstalling Helm chart..."
        helm uninstall "$RELEASE_NAME" --namespace "$NAMESPACE" || error "Helm uninstall failed"
        
        warn "Chart uninstalled!"
        ;;
    
    "status")
        log "Checking Helm release status..."
        helm status "$RELEASE_NAME" --namespace "$NAMESPACE"
        ;;
    
    "test")
        log "Running Helm tests..."
        helm test "$RELEASE_NAME" --namespace "$NAMESPACE" || error "Helm tests failed"
        
        success "All tests passed!"
        ;;
    
    "rollback")
        REVISION="${3:-}"
        if [[ -z "$REVISION" ]]; then
            log "Available revisions:"
            helm history "$RELEASE_NAME" --namespace "$NAMESPACE"
            read -p "Enter revision number to rollback to: " REVISION
        fi
        
        log "Rolling back to revision $REVISION..."
        helm rollback "$RELEASE_NAME" "$REVISION" --namespace "$NAMESPACE" || error "Rollback failed"
        
        success "Rollback completed!"
        ;;
    
    "diff")
        command -v helm-diff >/dev/null 2>&1 || {
            log "Installing helm-diff plugin..."
            helm plugin install https://github.com/databus23/helm-diff
        }
        
        log "Showing diff..."
        helm diff upgrade "$RELEASE_NAME" . \
            --namespace "$NAMESPACE" \
            --values "$VALUES_FILE" || true
        ;;
    
    *)
        error "Unknown action: $ACTION. Supported actions: install, upgrade, uninstall, status, test, rollback, diff"
        ;;
esac

# Show release information
if [[ "$ACTION" =~ ^(install|upgrade)$ ]]; then
    log "Release information:"
    helm list --namespace "$NAMESPACE"
    
    log "Pod status:"
    kubectl get pods --namespace "$NAMESPACE" -l "app.kubernetes.io/instance=$RELEASE_NAME"
    
    log "Service information:"
    kubectl get services --namespace "$NAMESPACE" -l "app.kubernetes.io/instance=$RELEASE_NAME"
fi

log "Helm operation completed successfully"
