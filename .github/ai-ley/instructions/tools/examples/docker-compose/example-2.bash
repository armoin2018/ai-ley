# Comprehensive security validation for Docker Compose configurations
cat > ~/.local/bin/docker-compose-security-validator.sh << 'EOF'
#!/bin/bash
set -euo pipefail

COMPOSE_FILE="${1:-docker-compose.yml}"
SECURITY_REPORT="/tmp/compose-security-$(date +%Y%m%d-%H%M%S).json"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SECURITY] $*"
}

# Initialize security validation
validate_compose_security() {
    log "Starting comprehensive security validation..."

    if [[ ! -f "$COMPOSE_FILE" ]]; then
        log "ERROR: Compose file not found: $COMPOSE_FILE"
        exit 1
    fi

    # Initialize security report
    cat > "$SECURITY_REPORT" << 'REPORT_START'
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "compose_file": "$COMPOSE_FILE",
  "security_assessment": {
    "overall_score": 0,
    "findings": [],
    "recommendations": []
  }
}
REPORT_START

    # Execute security checks
    check_privileged_containers
    check_host_network_usage
    check_volume_security
    check_secret_management
    check_network_security
    check_user_context
    check_capability_management
    check_resource_limits

    # Calculate overall security score
    calculate_security_score

    log "Security validation completed. Report: $SECURITY_REPORT"
}

# Check for privileged containers
check_privileged_containers() {
    log "Checking for privileged containers..."

    local privileged_count=0

    if yq eval '.services[] | select(.privileged == true)' "$COMPOSE_FILE" | grep -q .; then
        privileged_count=$(yq eval '.services[] | select(.privileged == true)' "$COMPOSE_FILE" | wc -l)

        # Add finding to report
        jq --arg count "$privileged_count" \
           '.security_assessment.findings += [{
             "category": "privileged_containers",
             "severity": "CRITICAL",
             "count": ($count | tonumber),
             "description": "Privileged containers detected",
             "remediation": "Remove privileged: true and use specific capabilities"
           }]' "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"
    fi

    log "✓ Privileged container check completed (found: $privileged_count)"
}

# Check host network usage
check_host_network_usage() {
    log "Checking host network usage..."

    local host_network_count=0

    if yq eval '.services[] | select(.network_mode == "host")' "$COMPOSE_FILE" | grep -q .; then
        host_network_count=$(yq eval '.services[] | select(.network_mode == "host")' "$COMPOSE_FILE" | wc -l)

        jq --arg count "$host_network_count" \
           '.security_assessment.findings += [{
             "category": "host_network",
             "severity": "HIGH",
             "count": ($count | tonumber),
             "description": "Services using host network detected",
             "remediation": "Use custom bridge networks instead of host network"
           }]' "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"
    fi

    log "✓ Host network check completed (found: $host_network_count)"
}

# Validate volume security
check_volume_security() {
    log "Checking volume security..."

    local insecure_binds=0

    # Check for sensitive host path binds
    local sensitive_paths=("/etc" "/usr" "/var" "/sys" "/proc" "/dev")

    for path in "${sensitive_paths[@]}"; do
        if yq eval ".services[].volumes[]? | select(. | test(\"^$path:\"))" "$COMPOSE_FILE" | grep -q .; then
            ((insecure_binds++))
        fi
    done

    if [[ $insecure_binds -gt 0 ]]; then
        jq --arg count "$insecure_binds" \
           '.security_assessment.findings += [{
             "category": "insecure_volumes",
             "severity": "HIGH",
             "count": ($count | tonumber),
             "description": "Insecure host path binds detected",
             "remediation": "Avoid binding sensitive host paths"
           }]' "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"
    fi

    log "✓ Volume security check completed (issues: $insecure_binds)"
}

# Check secret management
check_secret_management() {
    log "Checking secret management..."

    local hardcoded_secrets=0
    local secret_patterns=("password" "secret" "key" "token" "api")

    for pattern in "${secret_patterns[@]}"; do
        if yq eval ".services[].environment[]? | select(. | test(\"$pattern.*=\"; \"i\"))" "$COMPOSE_FILE" | grep -q .; then
            ((hardcoded_secrets++))
        fi
    done

    if [[ $hardcoded_secrets -gt 0 ]]; then
        jq --arg count "$hardcoded_secrets" \
           '.security_assessment.findings += [{
             "category": "hardcoded_secrets",
             "severity": "CRITICAL",
             "count": ($count | tonumber),
             "description": "Hardcoded secrets in environment variables",
             "remediation": "Use Docker secrets or external secret management"
           }]' "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"
    fi

    log "✓ Secret management check completed (issues: $hardcoded_secrets)"
}

# Check network security configuration
check_network_security() {
    log "Checking network security..."

    local default_network_usage=0

    # Check if services are using default network
    if yq eval '.services[] | select(.networks == null)' "$COMPOSE_FILE" | grep -q .; then
        default_network_usage=$(yq eval '.services[] | select(.networks == null)' "$COMPOSE_FILE" | wc -l)

        jq --arg count "$default_network_usage" \
           '.security_assessment.findings += [{
             "category": "default_network",
             "severity": "MEDIUM",
             "count": ($count | tonumber),
             "description": "Services using default network",
             "remediation": "Define custom networks for better segmentation"
           }]' "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"
    fi

    log "✓ Network security check completed (issues: $default_network_usage)"
}

# Check user context
check_user_context() {
    log "Checking user context..."

    local root_users=0

    # Check for services running as root
    if yq eval '.services[] | select(.user == null or .user == "root" or .user == "0")' "$COMPOSE_FILE" | grep -q .; then
        root_users=$(yq eval '.services[] | select(.user == null or .user == "root" or .user == "0")' "$COMPOSE_FILE" | wc -l)

        jq --arg count "$root_users" \
           '.security_assessment.findings += [{
             "category": "root_user",
             "severity": "HIGH",
             "count": ($count | tonumber),
             "description": "Services running as root user",
             "remediation": "Use non-root user with appropriate permissions"
           }]' "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"
    fi

    log "✓ User context check completed (issues: $root_users)"
}

# Check capability management
check_capability_management() {
    log "Checking capability management..."

    local services_without_cap_drop=0

    # Check for services without capability dropping
    if yq eval '.services[] | select(.cap_drop == null)' "$COMPOSE_FILE" | grep -q .; then
        services_without_cap_drop=$(yq eval '.services[] | select(.cap_drop == null)' "$COMPOSE_FILE" | wc -l)

        jq --arg count "$services_without_cap_drop" \
           '.security_assessment.findings += [{
             "category": "capabilities",
             "severity": "MEDIUM",
             "count": ($count | tonumber),
             "description": "Services without explicit capability management",
             "remediation": "Drop unnecessary capabilities with cap_drop"
           }]' "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"
    fi

    log "✓ Capability management check completed (issues: $services_without_cap_drop)"
}

# Check resource limits
check_resource_limits() {
    log "Checking resource limits..."

    local services_without_limits=0

    # Check for services without resource limits
    if yq eval '.services[] | select(.deploy.resources.limits == null)' "$COMPOSE_FILE" | grep -q .; then
        services_without_limits=$(yq eval '.services[] | select(.deploy.resources.limits == null)' "$COMPOSE_FILE" | wc -l)

        jq --arg count "$services_without_limits" \
           '.security_assessment.findings += [{
             "category": "resource_limits",
             "severity": "MEDIUM",
             "count": ($count | tonumber),
             "description": "Services without resource limits",
             "remediation": "Define CPU and memory limits for all services"
           }]' "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"
    fi

    log "✓ Resource limits check completed (issues: $services_without_limits)"
}

# Calculate overall security score
calculate_security_score() {
    log "Calculating security score..."

    local score
    score=$(jq -r '
      .security_assessment.findings |
      map(
        if .severity == "CRITICAL" then -20
        elif .severity == "HIGH" then -10
        elif .severity == "MEDIUM" then -5
        else -1 end
      ) |
      add // 0 |
      (100 + .) |
      if . < 0 then 0 else . end
    ' "$SECURITY_REPORT")

    jq --arg score "$score" '.security_assessment.overall_score = ($score | tonumber)' \
       "$SECURITY_REPORT" > /tmp/report.tmp && mv /tmp/report.tmp "$SECURITY_REPORT"

    log "✓ Security score calculated: $score/100"
}

# Execute security validation
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    validate_compose_security "$@"
fi
EOF

chmod +x ~/.local/bin/docker-compose-security-validator.sh