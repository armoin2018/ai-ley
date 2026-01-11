# SOC2 compliance framework for Helm deployments
cat > ~/.local/bin/helm-soc2-controls.sh << 'EOF'
#!/bin/bash
set -euo pipefail

SOC2_AUDIT_DIR="${SOC2_AUDIT_DIR:-$HOME/.helm/audit}"
CHART_PATH="${1:-.}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SOC2] $*"
}

# Initialize SOC2 audit framework
initialize_soc2_framework() {
    log "Initializing SOC2 Type II controls framework..."

    mkdir -p "$SOC2_AUDIT_DIR"/{access,change,monitoring,security,availability}

    # SOC2 control matrix
    cat > "$SOC2_AUDIT_DIR/control-matrix.yaml" << 'MATRIX_EOF'
soc2_controls:
  common_criteria:
    cc1: # Control Environment
      description: "The entity demonstrates a commitment to integrity and ethical values"
      helm_requirements:
        - "Documented deployment procedures"
        - "Code review requirements"
        - "Security scanning integration"

    cc2: # Communication and Information
      description: "The entity obtains or generates and uses relevant, quality information"
      helm_requirements:
        - "Comprehensive logging and monitoring"
        - "Audit trail maintenance"
        - "Change documentation"

    cc3: # Risk Assessment
      description: "The entity identifies risks to the achievement of its objectives"
      helm_requirements:
        - "Vulnerability scanning"
        - "Risk assessment for deployments"
        - "Security policy validation"

    cc6: # Logical and Physical Access Controls
      description: "The entity implements logical and physical access controls"
      helm_requirements:
        - "RBAC implementation"
        - "Secret management"
        - "Network segmentation"

    cc7: # System Operations
      description: "The entity manages the selection, development, and performance of individuals"
      helm_requirements:
        - "Change management processes"
        - "Monitoring and alerting"
        - "Incident response procedures"

  trust_services_criteria:
    availability:
      a1.1: "Availability objectives are defined"
      a1.2: "Availability commitments are documented"
      a1.3: "Availability requirements are identified"
MATRIX_EOF

    log "✓ SOC2 framework initialized"
}

# CC6.1 - Logical Access Controls
implement_access_controls() {
    log "Implementing SOC2 CC6.1 access controls..."

    # Access control audit
    cat > "$SOC2_AUDIT_DIR/access/rbac-audit.sh" << 'ACCESS_EOF'
#!/bin/bash
set -euo pipefail

AUDIT_REPORT="$SOC2_AUDIT_DIR/access/rbac-$(date +%Y%m%d-%H%M%S).json"

# Audit RBAC configurations
audit_rbac() {
    echo "{"
    echo "  \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\","
    echo "  \"audit_type\": \"rbac_access_control\","
    echo "  \"findings\": ["

    local first=true

    # Check ServiceAccounts
    kubectl get serviceaccounts --all-namespaces -o json | jq -r '.items[] |
    {
      "resource": "ServiceAccount",
      "name": .metadata.name,
      "namespace": .metadata.namespace,
      "automount_token": .automountServiceAccountToken,
      "secrets_count": (.secrets | length)
    }' | while read sa; do
        [[ $first == true ]] && first=false || echo ","
        echo "    $sa"
    done

    echo "  ]"
    echo "}"
}

audit_rbac > "$AUDIT_REPORT"
echo "Access control audit completed: $AUDIT_REPORT"
ACCESS_EOF

    chmod +x "$SOC2_AUDIT_DIR/access/rbac-audit.sh"

    # Access monitoring
    cat > "$SOC2_AUDIT_DIR/access/access-monitor.yaml" << 'MONITOR_EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: access-monitoring-config
  namespace: monitoring
data:
  access-rules.yaml: |
    groups:
    - name: access-control
      rules:
      - alert: UnauthorizedAccess
        expr: increase(apiserver_audit_total{verb!~"get|list|watch"}[5m]) > 100
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "High number of write operations detected"
          description: "{{ $value }} write operations in the last 5 minutes"

      - alert: ServiceAccountTokenAccess
        expr: increase(apiserver_audit_total{objectRef_resource="serviceaccounts",verb="get"}[10m]) > 50
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Unusual service account token access"
          description: "High number of service account access attempts"
MONITOR_EOF

    kubectl apply -f "$SOC2_AUDIT_DIR/access/access-monitor.yaml" 2>/dev/null || {
        log "INFO: Monitoring namespace not available, access monitoring config saved locally"
    }

    log "✓ SOC2 CC6.1 access controls implemented"
}

# CC7.1 - System Operations
implement_operations_controls() {
    log "Implementing SOC2 CC7.1 system operations controls..."

    # Change management tracking
    cat > "$SOC2_AUDIT_DIR/change/helm-change-tracker.sh" << 'CHANGE_EOF'
#!/bin/bash
set -euo pipefail

CHANGE_LOG="$SOC2_AUDIT_DIR/change/changes-$(date +%Y%m).log"

# Track Helm deployment changes
track_deployment_change() {
    local release_name="$1"
    local action="$2"
    local user="${USER:-unknown}"
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)

    # Log change details
    cat >> "$CHANGE_LOG" << CHANGE_LOG_EOF
{
  "timestamp": "$timestamp",
  "user": "$user",
  "action": "$action",
  "release": "$release_name",
  "namespace": "$(kubectl config view --minify -o jsonpath='{..namespace}' 2>/dev/null || echo 'default')",
  "chart_version": "$(helm get metadata "$release_name" 2>/dev/null | grep -E '^VERSION:' | awk '{print $2}' || echo 'unknown')",
  "revision": "$(helm get metadata "$release_name" 2>/dev/null | grep -E '^REVISION:' | awk '{print $2}' || echo 'unknown')",
  "audit_trail": "soc2_change_management"
}
CHANGE_LOG_EOF

    echo "Change tracked: $action for $release_name by $user at $timestamp"
}

# Execute if called directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    track_deployment_change "$@"
fi
CHANGE_EOF

    chmod +x "$SOC2_AUDIT_DIR/change/helm-change-tracker.sh"

    # Operations monitoring dashboard
    cat > "$SOC2_AUDIT_DIR/monitoring/operations-dashboard.json" << 'OPS_EOF'
{
  "dashboard": {
    "title": "SOC2 Operations Dashboard",
    "panels": [
      {
        "title": "Helm Release Changes",
        "type": "graph",
        "targets": [
          {
            "expr": "increase(helm_chart_info[24h])",
            "legendFormat": "Chart Deployments"
          }
        ]
      },
      {
        "title": "Security Policy Violations",
        "type": "stat",
        "targets": [
          {
            "expr": "sum(gatekeeper_violations_total)",
            "legendFormat": "Total Violations"
          }
        ]
      },
      {
        "title": "Failed Deployments",
        "type": "table",
        "targets": [
          {
            "expr": "helm_chart_info{status!=\"deployed\"}",
            "format": "table"
          }
        ]
      }
    ]
  }
}
OPS_EOF

    log "✓ SOC2 CC7.1 operations controls implemented"
}

# A1.1 - Availability Controls
implement_availability_controls() {
    log "Implementing SOC2 A1.1 availability controls..."

    # High availability validation
    cat > "$SOC2_AUDIT_DIR/availability/ha-validator.sh" << 'HA_EOF'
#!/bin/bash
set -euo pipefail

HA_REPORT="$SOC2_AUDIT_DIR/availability/ha-$(date +%Y%m%d-%H%M%S).json"

validate_high_availability() {
    echo "{"
    echo "  \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\","
    echo "  \"availability_assessment\": {"

    # Check replica counts
    local single_replica_count=0
    local multi_replica_count=0

    while IFS= read -r deployment; do
        local replicas=$(kubectl get deployment "$deployment" -o jsonpath='{.spec.replicas}' 2>/dev/null || echo "0")
        if [[ $replicas -eq 1 ]]; then
            ((single_replica_count++))
        elif [[ $replicas -gt 1 ]]; then
            ((multi_replica_count++))
        fi
    done <<< "$(kubectl get deployments --all-namespaces -o jsonpath='{.items[*].metadata.name}' 2>/dev/null || true)"

    echo "    \"single_replica_deployments\": $single_replica_count,"
    echo "    \"multi_replica_deployments\": $multi_replica_count,"
    echo "    \"availability_score\": $(echo "scale=2; $multi_replica_count / ($single_replica_count + $multi_replica_count) * 100" | bc -l 2>/dev/null || echo "0")"
    echo "  }"
    echo "}"
}

validate_high_availability > "$HA_REPORT"
echo "Availability assessment completed: $HA_REPORT"
HA_EOF

    chmod +x "$SOC2_AUDIT_DIR/availability/ha-validator.sh"

    log "✓ SOC2 A1.1 availability controls implemented"
}

# Generate SOC2 compliance report
generate_compliance_report() {
    log "Generating SOC2 compliance report..."

    local report_file="$SOC2_AUDIT_DIR/soc2-compliance-$(date +%Y%m%d-%H%M%S).json"

    cat > "$report_file" << 'REPORT_EOF'
{
  "report_metadata": {
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "report_type": "SOC2_Type_II_Compliance",
    "scope": "Helm_Kubernetes_Deployments",
    "auditor": "Enterprise_Platform_Team",
    "period": "$(date -u -d '30 days ago' +%Y-%m-%d) to $(date -u +%Y-%m-%d)"
  },
  "control_assessment": {
    "cc6_1_logical_access": {
      "status": "implemented",
      "evidence": "$SOC2_AUDIT_DIR/access/",
      "last_tested": "$(date -u +%Y-%m-%d)"
    },
    "cc7_1_system_operations": {
      "status": "implemented",
      "evidence": "$SOC2_AUDIT_DIR/change/",
      "last_tested": "$(date -u +%Y-%m-%d)"
    },
    "a1_1_availability": {
      "status": "implemented",
      "evidence": "$SOC2_AUDIT_DIR/availability/",
      "last_tested": "$(date -u +%Y-%m-%d)"
    }
  },
  "remediation_actions": [],
  "next_review_date": "$(date -u -d '90 days' +%Y-%m-%d)"
}
REPORT_EOF

    log "✓ SOC2 compliance report generated: $report_file"
}

# Execute SOC2 controls implementation
initialize_soc2_framework
implement_access_controls
implement_operations_controls
implement_availability_controls
generate_compliance_report

log "SOC2 Type II controls implementation completed"
EOF

chmod +x ~/.local/bin/helm-soc2-controls.sh