#!/bin/bash

# Ansible Deployment Script
# Usage: ./deploy.sh [environment] [tags]

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANSIBLE_DIR="$(dirname "$SCRIPT_DIR")"
DEFAULT_ENVIRONMENT="development"
DEFAULT_TAGS="all"

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
TAGS="${2:-$DEFAULT_TAGS}"

# Validate environment
if [[ ! -d "$ANSIBLE_DIR/inventories/$ENVIRONMENT" ]]; then
    error "Environment '$ENVIRONMENT' not found in inventories/"
fi

# Check prerequisites
command -v ansible-playbook >/dev/null 2>&1 || error "ansible-playbook not found. Please install Ansible."

# Set inventory path
INVENTORY="$ANSIBLE_DIR/inventories/$ENVIRONMENT/hosts.yml"

if [[ ! -f "$INVENTORY" ]]; then
    error "Inventory file not found: $INVENTORY"
fi

log "Starting deployment to $ENVIRONMENT environment"
log "Inventory: $INVENTORY"
log "Tags: $TAGS"

# Install requirements if they don't exist
if [[ ! -d "$HOME/.ansible/collections" ]] || [[ ! -d "$HOME/.ansible/roles" ]]; then
    log "Installing Ansible requirements..."
    ansible-galaxy install -r "$ANSIBLE_DIR/requirements.yml" || error "Failed to install requirements"
fi

# Run connectivity test
log "Testing connectivity..."
if ! ansible all -i "$INVENTORY" -m ping --one-line; then
    error "Connectivity test failed. Please check your inventory and SSH configuration."
fi

# Run syntax check
log "Checking playbook syntax..."
if ! ansible-playbook -i "$INVENTORY" "$ANSIBLE_DIR/site.yml" --syntax-check; then
    error "Syntax check failed"
fi

# Confirm deployment for production
if [[ "$ENVIRONMENT" == "production" ]]; then
    echo -e "${YELLOW}WARNING: You are about to deploy to PRODUCTION!${NC}"
    read -p "Are you sure you want to continue? (yes/no): " confirm
    if [[ "$confirm" != "yes" ]]; then
        log "Deployment cancelled"
        exit 0
    fi
fi

# Run deployment
log "Running deployment..."
if ansible-playbook \
    -i "$INVENTORY" \
    "$ANSIBLE_DIR/site.yml" \
    --tags "$TAGS" \
    --diff; then
    success "Deployment completed successfully!"
else
    error "Deployment failed!"
fi

# Run health check
log "Running post-deployment health check..."
if ansible-playbook \
    -i "$INVENTORY" \
    "$ANSIBLE_DIR/site.yml" \
    --tags "health" \
    --check; then
    success "Health check passed!"
else
    warn "Health check failed - please investigate"
fi

log "Deployment script completed"
