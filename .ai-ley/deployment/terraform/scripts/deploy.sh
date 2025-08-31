#!/bin/bash

# Terraform Deployment Script
# Usage: ./deploy.sh [environment] [action]

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM_DIR="$(dirname "$SCRIPT_DIR")"
DEFAULT_ENVIRONMENT="development"
DEFAULT_ACTION="plan"

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

# Validate environment
if [[ ! -d "$TERRAFORM_DIR/environments/$ENVIRONMENT" ]]; then
    error "Environment '$ENVIRONMENT' not found in environments/"
fi

# Check prerequisites
command -v terraform >/dev/null 2>&1 || error "terraform not found. Please install Terraform."

# Change to environment directory
cd "$TERRAFORM_DIR/environments/$ENVIRONMENT"

# Initialize Terraform if needed
if [[ ! -d ".terraform" ]]; then
    log "Initializing Terraform..."
    terraform init || error "Terraform initialization failed"
fi

# Select workspace
log "Selecting workspace: $ENVIRONMENT"
terraform workspace select "$ENVIRONMENT" 2>/dev/null || {
    log "Creating new workspace: $ENVIRONMENT"
    terraform workspace new "$ENVIRONMENT"
}

# Validate configuration
log "Validating Terraform configuration..."
terraform validate || error "Terraform validation failed"

# Format check
log "Checking Terraform formatting..."
terraform fmt -check || {
    warn "Terraform files are not properly formatted. Running format..."
    terraform fmt
}

case "$ACTION" in
    "plan")
        log "Running Terraform plan..."
        terraform plan -var-file="terraform.tfvars" -out="tfplan"
        ;;
    
    "apply")
        # Confirm deployment for production
        if [[ "$ENVIRONMENT" == "production" ]]; then
            echo -e "${YELLOW}WARNING: You are about to deploy to PRODUCTION!${NC}"
            read -p "Are you sure you want to continue? (yes/no): " confirm
            if [[ "$confirm" != "yes" ]]; then
                log "Deployment cancelled"
                exit 0
            fi
        fi
        
        log "Running Terraform apply..."
        if [[ -f "tfplan" ]]; then
            terraform apply "tfplan"
        else
            terraform apply -var-file="terraform.tfvars" -auto-approve
        fi
        
        success "Infrastructure deployment completed!"
        
        # Show outputs
        log "Infrastructure outputs:"
        terraform output
        ;;
    
    "destroy")
        echo -e "${RED}WARNING: You are about to DESTROY infrastructure in $ENVIRONMENT!${NC}"
        read -p "Are you absolutely sure? Type 'destroy' to confirm: " confirm
        if [[ "$confirm" != "destroy" ]]; then
            log "Destruction cancelled"
            exit 0
        fi
        
        log "Running Terraform destroy..."
        terraform destroy -var-file="terraform.tfvars" -auto-approve
        
        warn "Infrastructure destroyed!"
        ;;
    
    "output")
        log "Showing Terraform outputs..."
        terraform output
        ;;
    
    "state")
        log "Showing Terraform state..."
        terraform state list
        ;;
    
    *)
        error "Unknown action: $ACTION. Supported actions: plan, apply, destroy, output, state"
        ;;
esac

log "Terraform operation completed successfully"
