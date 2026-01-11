# cis-kubernetes-benchmark.sh - Automated CIS compliance validation
cat > ~/.local/bin/cis-kubernetes-benchmark.sh << 'EOF'
#!/bin/bash
set -euo pipefail

CLUSTER_NAME="${1:-production}"
BENCHMARK_DIR="./compliance/cis-kubernetes"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [CIS-K8S] $*"
}

# Setup CIS benchmark structure
setup_cis_structure() {
    log "Setting up CIS Kubernetes benchmark structure..."

    mkdir -p "$BENCHMARK_DIR"/{reports,evidence,remediation,policies}

    # CIS Kubernetes Benchmark controls
    cat > "$BENCHMARK_DIR/cis-k8s-controls.json" << 'CIS_K8S_EOF'
{
  "benchmark": "CIS Kubernetes Benchmark v1.7.0",
  "cluster": "production",
  "controls": {
    "1.1.1": {
      "title": "Ensure API server pod specification file permissions are set to 644 or more restrictive",
      "check": "check_api_server_permissions",
      "level": "Level 1"
    },
    "1.2.6": {
      "title": "Ensure that the --kubelet-certificate-authority argument is set as appropriate",
      "check": "check_kubelet_certificate_authority",
      "level": "Level 1"
    },
    "1.3.2": {
      "title": "Ensure that the --profiling argument is set to false",
      "check": "check_controller_manager_profiling",
      "level": "Level 1"
    },
    "3.2.1": {
      "title": "Ensure that a minimal audit policy is created",
      "check": "check_audit_policy",
      "level": "Level 1"
    },
    "4.2.1": {
      "title": "Minimize the admission of privileged containers",
      "check": "check_privileged_containers",
      "level": "Level 1"
    },
    "5.1.3": {
      "title": "Minimize wildcard use in Roles and ClusterRoles",
      "check": "check_rbac_wildcards",
      "level": "Level 1"
    },
    "5.2.2": {
      "title": "Minimize the admission of containers wishing to share the host process ID namespace",
      "check": "check_host_pid",
      "level": "Level 1"
    },
    "5.3.2": {
      "title": "Minimize the admission of containers with allowPrivilegeEscalation",
      "check": "check_privilege_escalation",
      "level": "Level 1"
    }
  }
}
CIS_K8S_EOF

    log "✓ CIS structure created"
}

# Check API server permissions
check_api_server_permissions() {
    local result_file="$BENCHMARK_DIR/evidence/1.1.1-api-server-permissions.log"

    log "Checking API server permissions (CIS 1.1.1)..."

    # Check if running on managed cluster (EKS, GKE, AKS)
    if kubectl get nodes -o jsonpath='{.items[0].spec.providerID}' | grep -E "(aws|gce|azure)" > /dev/null; then
        echo "PASS: Managed Kubernetes cluster - API server permissions handled by cloud provider" >> "$result_file"
        log "✓ Managed cluster detected - API server permissions managed"
    else
        # For self-managed clusters
        if [ -f /etc/kubernetes/manifests/kube-apiserver.yaml ]; then
            local perms
            perms=$(stat -c %a /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null || echo "unknown")
            if [ "$perms" = "644" ] || [ "$perms" = "600" ]; then
                echo "PASS: API server manifest permissions are $perms" >> "$result_file"
                log "✓ API server permissions are secure ($perms)"
            else
                echo "FAIL: API server manifest permissions are $perms (should be 644 or more restrictive)" >> "$result_file"
                log "⚠️ API server permissions need attention ($perms)"
            fi
        else
            echo "INFO: API server manifest not found - likely managed cluster" >> "$result_file"
        fi
    fi
}

# Check privileged containers
check_privileged_containers() {
    local result_file="$BENCHMARK_DIR/evidence/4.2.1-privileged-containers.log"

    log "Checking for privileged containers (CIS 4.2.1)..."

    # Check for Pod Security Standards
    local restricted_namespaces
    restricted_namespaces=$(kubectl get namespaces -l pod-security.kubernetes.io/enforce=restricted -o name 2>/dev/null | wc -l)

    if [ "$restricted_namespaces" -gt 0 ]; then
        echo "PASS: $restricted_namespaces namespace(s) with restricted pod security standards" >> "$result_file"
        log "✓ Pod Security Standards enforced in $restricted_namespaces namespace(s)"
    fi

    # Check for actual privileged containers
    local privileged_pods
    privileged_pods=$(kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}{" "}{.metadata.name}{" "}{range .spec.containers[*]}{.securityContext.privileged}{"\n"}{end}{end}' | grep -c "true" || echo "0")

    if [ "$privileged_pods" -eq 0 ]; then
        echo "PASS: No privileged containers found" >> "$result_file"
        log "✓ No privileged containers detected"
    else
        echo "FAIL: $privileged_pods privileged container(s) found" >> "$result_file"
        log "⚠️ Found $privileged_pods privileged container(s)"
    fi
}

# Check RBAC wildcards
check_rbac_wildcards() {
    local result_file="$BENCHMARK_DIR/evidence/5.1.3-rbac-wildcards.log"

    log "Checking RBAC wildcards (CIS 5.1.3)..."

    # Check ClusterRoles for wildcards
    local wildcard_clusterroles
    wildcard_clusterroles=$(kubectl get clusterroles -o yaml | grep -E "verbs:.*\*|resources:.*\*" | wc -l || echo "0")

    # Check Roles for wildcards
    local wildcard_roles
    wildcard_roles=$(kubectl get roles --all-namespaces -o yaml | grep -E "verbs:.*\*|resources:.*\*" | wc -l || echo "0")

    local total_wildcards=$((wildcard_clusterroles + wildcard_roles))

    if [ "$total_wildcards" -gt 5 ]; then
        echo "WARN: $total_wildcards RBAC rules with wildcards found (review recommended)" >> "$result_file"
        log "⚠️ $total_wildcards RBAC wildcard rules found"
    else
        echo "PASS: Minimal wildcard usage in RBAC ($total_wildcards rules)" >> "$result_file"
        log "✓ RBAC wildcard usage is minimal"
    fi
}

# Check host PID namespace sharing
check_host_pid() {
    local result_file="$BENCHMARK_DIR/evidence/5.2.2-host-pid.log"

    log "Checking host PID namespace sharing (CIS 5.2.2)..."

    local host_pid_pods
    host_pid_pods=$(kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}{" "}{.metadata.name}{" "}{.spec.hostPID}{"\n"}{end}' | grep -c "true" || echo "0")

    if [ "$host_pid_pods" -eq 0 ]; then
        echo "PASS: No pods sharing host PID namespace" >> "$result_file"
        log "✓ No host PID namespace sharing detected"
    else
        echo "FAIL: $host_pid_pods pod(s) sharing host PID namespace" >> "$result_file"
        log "⚠️ Found $host_pid_pods pod(s) sharing host PID namespace"
    fi
}

# Check privilege escalation
check_privilege_escalation() {
    local result_file="$BENCHMARK_DIR/evidence/5.3.2-privilege-escalation.log"

    log "Checking privilege escalation (CIS 5.3.2)..."

    local allow_privilege_escalation
    allow_privilege_escalation=$(kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{range .spec.containers[*]}{.securityContext.allowPrivilegeEscalation}{"\n"}{end}{end}' | grep -c "true" || echo "0")

    if [ "$allow_privilege_escalation" -eq 0 ]; then
        echo "PASS: No containers allowing privilege escalation" >> "$result_file"
        log "✓ Privilege escalation properly controlled"
    else
        echo "FAIL: $allow_privilege_escalation container(s) allowing privilege escalation" >> "$result_file"
        log "⚠️ Found $allow_privilege_escalation container(s) with privilege escalation"
    fi
}

# Generate CIS compliance report
generate_cis_report() {
    log "Generating CIS Kubernetes compliance report..."

    local report_file="$BENCHMARK_DIR/reports/cis-k8s-report-$(date +%Y%m%d-%H%M%S).json"
    local total_checks=0
    local passed_checks=0
    local failed_checks=0
    local warnings=0

    # Count results
    for evidence_file in "$BENCHMARK_DIR/evidence"/*.log; do
        if [ -f "$evidence_file" ]; then
            local file_passed file_failed file_warnings
            file_passed=$(grep -c "PASS" "$evidence_file" 2>/dev/null || echo 0)
            file_failed=$(grep -c "FAIL" "$evidence_file" 2>/dev/null || echo 0)
            file_warnings=$(grep -c "WARN" "$evidence_file" 2>/dev/null || echo 0)

            passed_checks=$((passed_checks + file_passed))
            failed_checks=$((failed_checks + file_failed))
            warnings=$((warnings + file_warnings))
        fi
    done

    total_checks=$((passed_checks + failed_checks + warnings))
    local compliance_percentage=0
    if [ "$total_checks" -gt 0 ]; then
        compliance_percentage=$(( (passed_checks * 100) / total_checks ))
    fi

    cat > "$report_file" << EOF
{
  "cis_kubernetes_compliance": {
    "benchmark": "CIS Kubernetes Benchmark v1.7.0",
    "cluster_name": "$CLUSTER_NAME",
    "report_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "summary": {
      "total_checks": $total_checks,
      "passed": $passed_checks,
      "failed": $failed_checks,
      "warnings": $warnings,
      "compliance_percentage": $compliance_percentage
    },
    "control_results": {
      "1.1.1_api_server_permissions": "$(test -f "$BENCHMARK_DIR/evidence/1.1.1-api-server-permissions.log" && echo "checked" || echo "skipped")",
      "4.2.1_privileged_containers": "$(test -f "$BENCHMARK_DIR/evidence/4.2.1-privileged-containers.log" && echo "checked" || echo "skipped")",
      "5.1.3_rbac_wildcards": "$(test -f "$BENCHMARK_DIR/evidence/5.1.3-rbac-wildcards.log" && echo "checked" || echo "skipped")",
      "5.2.2_host_pid": "$(test -f "$BENCHMARK_DIR/evidence/5.2.2-host-pid.log" && echo "checked" || echo "skipped")",
      "5.3.2_privilege_escalation": "$(test -f "$BENCHMARK_DIR/evidence/5.3.2-privilege-escalation.log" && echo "checked" || echo "skipped")"
    }
  }
}
EOF

    log "✓ CIS Kubernetes report generated: $report_file"
    log "Compliance Summary: $passed_checks/$total_checks passed ($compliance_percentage%), $failed_checks failed, $warnings warnings"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_cis_structure
    mkdir -p "$BENCHMARK_DIR/evidence"

    # Run CIS checks
    check_api_server_permissions
    check_privileged_containers
    check_rbac_wildcards
    check_host_pid
    check_privilege_escalation

    generate_cis_report

EOF

chmod +x ~/.local/bin/cis-kubernetes-benchmark.sh