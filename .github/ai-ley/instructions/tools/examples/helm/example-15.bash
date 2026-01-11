# Automated CIS Kubernetes benchmark validation for Helm deployments
cat > ~/.local/bin/helm-cis-compliance.sh << 'EOF'
#!/bin/bash
set -euo pipefail

CHART_PATH="${1:-.}"
COMPLIANCE_REPORT="/tmp/helm-cis-compliance-$(date +%Y%m%d-%H%M%S).json"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [CIS-COMPLIANCE] $*"
}

# CIS benchmark validation for Helm charts
validate_cis_compliance() {
    log "Starting CIS Kubernetes benchmark validation..."

    local chart_name=$(yq eval '.name' "$CHART_PATH/Chart.yaml")
    local violations=0

    cat > "$COMPLIANCE_REPORT" << 'REPORT_START'
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "chart": "$chart_name",
  "cis_version": "1.7.0",
  "checks": [
REPORT_START

    # CIS 5.1.1 - Ensure that the cluster-admin role is only used where required
    check_cluster_admin_usage

    # CIS 5.1.2 - Minimize access to secrets
    check_secret_access

    # CIS 5.1.3 - Minimize wildcard use in Roles and ClusterRoles
    check_wildcard_permissions

    # CIS 5.2.1 - Minimize the admission of privileged containers
    check_privileged_containers

    # CIS 5.2.2 - Minimize the admission of containers wishing to share the host process ID namespace
    check_host_pid_sharing

    # CIS 5.2.3 - Minimize the admission of containers wishing to share the host IPC namespace
    check_host_ipc_sharing

    # CIS 5.2.4 - Minimize the admission of containers wishing to share the host network namespace
    check_host_network_sharing

    # CIS 5.7.3 - Apply Security Context to Your Pods and Containers
    check_security_contexts

    # Close JSON report
    echo "  ]" >> "$COMPLIANCE_REPORT"
    echo "}" >> "$COMPLIANCE_REPORT"

    log "CIS compliance validation completed. Report: $COMPLIANCE_REPORT"
    log "Total violations found: $violations"

    return $violations
}

check_cluster_admin_usage() {
    log "Checking cluster-admin role usage (CIS 5.1.1)..."

    local found_cluster_admin=false

    # Check for ClusterRoleBinding with cluster-admin
    if find "$CHART_PATH/templates" -name "*.yaml" -exec grep -l "cluster-admin" {} \; 2>/dev/null | head -1; then
        found_cluster_admin=true
        ((violations++))
    fi

    cat >> "$COMPLIANCE_REPORT" << CIS_511_EOF
    {
      "check": "CIS-5.1.1",
      "description": "Ensure that the cluster-admin role is only used where required",
      "status": "$([ "$found_cluster_admin" = true ] && echo "FAIL" || echo "PASS")",
      "severity": "$([ "$found_cluster_admin" = true ] && echo "HIGH" || echo "INFO")",
      "remediation": "Avoid using cluster-admin role, use least-privilege principles"
    },
CIS_511_EOF
}

check_secret_access() {
    log "Checking secret access patterns (CIS 5.1.2)..."

    local secret_violations=0

    # Check for broad secret access in RBAC
    while IFS= read -r file; do
        if grep -q "resources.*secrets" "$file" && grep -q "verbs.*\*" "$file"; then
            ((secret_violations++))
        fi
    done <<< "$(find "$CHART_PATH/templates" -name "*role*.yaml" -type f 2>/dev/null || true)"

    cat >> "$COMPLIANCE_REPORT" << CIS_512_EOF
    {
      "check": "CIS-5.1.2",
      "description": "Minimize access to secrets",
      "status": "$([ $secret_violations -gt 0 ] && echo "FAIL" || echo "PASS")",
      "severity": "$([ $secret_violations -gt 0 ] && echo "HIGH" || echo "INFO")",
      "violations": $secret_violations,
      "remediation": "Limit secret access to specific resources and verbs"
    },
CIS_512_EOF

    ((violations += secret_violations))
}

check_wildcard_permissions() {
    log "Checking for wildcard permissions (CIS 5.1.3)..."

    local wildcard_violations=0

    # Check for wildcard usage in RBAC
    while IFS= read -r file; do
        if grep -q "resources.*\*" "$file" || grep -q "verbs.*\*" "$file"; then
            ((wildcard_violations++))
        fi
    done <<< "$(find "$CHART_PATH/templates" -name "*role*.yaml" -type f 2>/dev/null || true)"

    cat >> "$COMPLIANCE_REPORT" << CIS_513_EOF
    {
      "check": "CIS-5.1.3",
      "description": "Minimize wildcard use in Roles and ClusterRoles",
      "status": "$([ $wildcard_violations -gt 0 ] && echo "FAIL" || echo "PASS")",
      "severity": "$([ $wildcard_violations -gt 0 ] && echo "MEDIUM" || echo "INFO")",
      "violations": $wildcard_violations,
      "remediation": "Replace wildcards with specific resource names and verbs"
    },
CIS_513_EOF

    ((violations += wildcard_violations))
}

check_privileged_containers() {
    log "Checking for privileged containers (CIS 5.2.1)..."

    local privileged_violations=0

    # Check for privileged: true in security contexts
    while IFS= read -r file; do
        if grep -q "privileged.*true" "$file"; then
            ((privileged_violations++))
        fi
    done <<< "$(find "$CHART_PATH/templates" -name "*.yaml" -type f)"

    cat >> "$COMPLIANCE_REPORT" << CIS_521_EOF
    {
      "check": "CIS-5.2.1",
      "description": "Minimize the admission of privileged containers",
      "status": "$([ $privileged_violations -gt 0 ] && echo "FAIL" || echo "PASS")",
      "severity": "$([ $privileged_violations -gt 0 ] && echo "CRITICAL" || echo "INFO")",
      "violations": $privileged_violations,
      "remediation": "Remove privileged: true from container security contexts"
    },
CIS_521_EOF

    ((violations += privileged_violations))
}

check_host_pid_sharing() {
    log "Checking for host PID sharing (CIS 5.2.2)..."

    local host_pid_violations=0

    # Check for hostPID: true
    while IFS= read -r file; do
        if grep -q "hostPID.*true" "$file"; then
            ((host_pid_violations++))
        fi
    done <<< "$(find "$CHART_PATH/templates" -name "*.yaml" -type f)"

    cat >> "$COMPLIANCE_REPORT" << CIS_522_EOF
    {
      "check": "CIS-5.2.2",
      "description": "Minimize the admission of containers wishing to share the host process ID namespace",
      "status": "$([ $host_pid_violations -gt 0 ] && echo "FAIL" || echo "PASS")",
      "severity": "$([ $host_pid_violations -gt 0 ] && echo "HIGH" || echo "INFO")",
      "violations": $host_pid_violations,
      "remediation": "Remove hostPID: true from pod specifications"
    },
CIS_522_EOF

    ((violations += host_pid_violations))
}

check_host_ipc_sharing() {
    log "Checking for host IPC sharing (CIS 5.2.3)..."

    local host_ipc_violations=0

    # Check for hostIPC: true
    while IFS= read -r file; do
        if grep -q "hostIPC.*true" "$file"; then
            ((host_ipc_violations++))
        fi
    done <<< "$(find "$CHART_PATH/templates" -name "*.yaml" -type f)"

    cat >> "$COMPLIANCE_REPORT" << CIS_523_EOF
    {
      "check": "CIS-5.2.3",
      "description": "Minimize the admission of containers wishing to share the host IPC namespace",
      "status": "$([ $host_ipc_violations -gt 0 ] && echo "FAIL" || echo "PASS")",
      "severity": "$([ $host_ipc_violations -gt 0 ] && echo "HIGH" || echo "INFO")",
      "violations": $host_ipc_violations,
      "remediation": "Remove hostIPC: true from pod specifications"
    },
CIS_523_EOF

    ((violations += host_ipc_violations))
}

check_host_network_sharing() {
    log "Checking for host network sharing (CIS 5.2.4)..."

    local host_network_violations=0

    # Check for hostNetwork: true
    while IFS= read -r file; do
        if grep -q "hostNetwork.*true" "$file"; then
            ((host_network_violations++))
        fi
    done <<< "$(find "$CHART_PATH/templates" -name "*.yaml" -type f)"

    cat >> "$COMPLIANCE_REPORT" << CIS_524_EOF
    {
      "check": "CIS-5.2.4",
      "description": "Minimize the admission of containers wishing to share the host network namespace",
      "status": "$([ $host_network_violations -gt 0 ] && echo "FAIL" || echo "PASS")",
      "severity": "$([ $host_network_violations -gt 0 ] && echo "HIGH" || echo "INFO")",
      "violations": $host_network_violations,
      "remediation": "Remove hostNetwork: true from pod specifications"
    },
CIS_524_EOF

    ((violations += host_network_violations))
}

check_security_contexts() {
    log "Checking security contexts (CIS 5.7.3)..."

    local missing_security_context=0
    local deployment_count=0

    # Count deployments and those with security contexts
    while IFS= read -r file; do
        if grep -q "kind: Deployment" "$file"; then
            ((deployment_count++))
            if ! grep -q "securityContext" "$file"; then
                ((missing_security_context++))
            fi
        fi
    done <<< "$(find "$CHART_PATH/templates" -name "*.yaml" -type f)"

    cat >> "$COMPLIANCE_REPORT" << CIS_573_EOF
    {
      "check": "CIS-5.7.3",
      "description": "Apply Security Context to Your Pods and Containers",
      "status": "$([ $missing_security_context -gt 0 ] && echo "FAIL" || echo "PASS")",
      "severity": "$([ $missing_security_context -gt 0 ] && echo "HIGH" || echo "INFO")",
      "violations": $missing_security_context,
      "total_deployments": $deployment_count,
      "remediation": "Add securityContext to all pod and container specifications"
    }
CIS_573_EOF

    ((violations += missing_security_context))
}

# Execute CIS compliance validation
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    validate_cis_compliance "$@"
fi
EOF

chmod +x ~/.local/bin/helm-cis-compliance.sh