# Install validation and testing tools
pip install taskcat pytest-cov
npm install -g cfn-nag aws-cdk-assert

# Create validation script
cat > scripts/validate-templates.sh << 'EOF'
#!/bin/bash
set -euo pipefail

TEMPLATE_DIR="${1:-templates}"
LOG_FILE="/tmp/cloudformation-validation-$(date +%Y%m%d-%H%M%S).log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "Starting CloudFormation template validation..."

# Validate syntax with AWS CLI
log "Validating template syntax..."
find "$TEMPLATE_DIR" -name "*.yaml" -o -name "*.yml" -o -name "*.json" | while read template; do
    log "Validating: $template"
    aws cloudformation validate-template --template-body "file://$template" || {
        log "ERROR: Validation failed for $template"
        exit 1
    }
done

# Lint templates with cfn-lint
log "Linting templates with cfn-lint..."
cfn-lint "$TEMPLATE_DIR"/**/*.{yaml,yml,json} || {
    log "ERROR: cfn-lint found issues"
    exit 1
}

# Security analysis with cfn-nag
log "Running security analysis with cfn-nag..."
cfn_nag_scan --input-path "$TEMPLATE_DIR" --output-format json > /tmp/cfn-nag-results.json
if [ "$(jq '.[] | select(.file_results.violations | length > 0)' /tmp/cfn-nag-results.json | wc -l)" -gt 0 ]; then
    log "WARNING: cfn-nag found security issues"
    jq '.[] | select(.file_results.violations | length > 0)' /tmp/cfn-nag-results.json
fi

# Security analysis with Checkov
log "Running compliance analysis with Checkov..."
checkov -f "$TEMPLATE_DIR" --framework cloudformation --output json > /tmp/checkov-results.json || true
failed_checks=$(jq '.results.failed_checks | length' /tmp/checkov-results.json)
if [ "$failed_checks" -gt 0 ]; then
    log "WARNING: Checkov found $failed_checks compliance issues"
fi

log "Template validation completed. Results logged to: $LOG_FILE"
EOF

chmod +x scripts/validate-templates.sh

# Create deployment script
cat > scripts/deploy-stack.sh << 'EOF'
#!/bin/bash
set -euo pipefail

STACK_NAME="${1:-}"
TEMPLATE_FILE="${2:-}"
PARAMETERS_FILE="${3:-}"
ENVIRONMENT="${4:-dev}"
PROFILE="${5:-default}"

if [ -z "$STACK_NAME" ] || [ -z "$TEMPLATE_FILE" ]; then
    echo "Usage: $0 <stack-name> <template-file> [parameters-file] [environment] [profile]"
    exit 1
fi

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log "Starting deployment of stack: $STACK_NAME"

# Validate template first
log "Validating template..."
aws cloudformation validate-template
    --template-body "file://$TEMPLATE_FILE"
    --profile "$PROFILE"

# Build deployment command
DEPLOY_CMD="aws cloudformation deploy"
DEPLOY_CMD+=" --template-file $TEMPLATE_FILE"
DEPLOY_CMD+=" --stack-name $STACK_NAME"
DEPLOY_CMD+=" --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND"
DEPLOY_CMD+=" --profile $PROFILE"

# Add parameters if provided
if [ -n "$PARAMETERS_FILE" ] && [ -f "$PARAMETERS_FILE" ]; then
    log "Using parameters file: $PARAMETERS_FILE"
    DEPLOY_CMD+=" --parameter-overrides file://$PARAMETERS_FILE"
fi

# Add tags
DEPLOY_CMD+=" --tags Environment=$ENVIRONMENT"
DEPLOY_CMD+=" DeployedBy=$(whoami)"
DEPLOY_CMD+=" DeployedAt=$(date -Iseconds)"
DEPLOY_CMD+=" Project=Enterprise"

# Enable termination protection for production
if [ "$ENVIRONMENT" = "production" ]; then
    DEPLOY_CMD+=" --disable-rollback"
fi

log "Executing deployment command..."
eval "$DEPLOY_CMD"

# Enable termination protection for production stacks
if [ "$ENVIRONMENT" = "production" ]; then
    log "Enabling termination protection for production stack..."
    aws cloudformation update-termination-protection
        --enable-termination-protection
        --stack-name "$STACK_NAME"
        --profile "$PROFILE"
fi

log "Deployment completed successfully"
log "Stack outputs:"
aws cloudformation describe-stacks
    --stack-name "$STACK_NAME"
    --profile "$PROFILE"
    --query 'Stacks[0].Outputs'
    --output table
EOF

chmod +x scripts/deploy-stack.sh