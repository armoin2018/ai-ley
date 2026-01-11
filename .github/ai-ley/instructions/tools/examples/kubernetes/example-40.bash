# disaster-recovery.sh - Automated disaster recovery procedures
cat > ~/.local/bin/kubernetes-disaster-recovery.sh << 'EOF'
#!/bin/bash
set -euo pipefail

CLUSTER_NAME="${1:-production}"
RECOVERY_TYPE="${2:-full}"  # full, partial, namespace
BACKUP_DATE="${3:-latest}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [DR] $*"
}

# Validate pre-requisites
validate_prerequisites() {
    log "Validating disaster recovery prerequisites..."

    # Check Velero installation
    if ! kubectl get deployment velero -n velero >/dev/null 2>&1; then
        log "ERROR: Velero not found. Install Velero first."
        exit 1
    fi

    # Check backup storage access
    if ! velero backup-location get aws-backup-location >/dev/null 2>&1; then
        log "ERROR: Backup storage location not accessible"
        exit 1
    fi

    # Check cluster connectivity
    if ! kubectl cluster-info >/dev/null 2>&1; then
        log "ERROR: Cannot connect to Kubernetes cluster"
        exit 1
    fi

    log "✓ Prerequisites validated"
}

# List available backups
list_available_backups() {
    log "Available backups for cluster $CLUSTER_NAME:"
    velero backup get --selector="cluster=$CLUSTER_NAME" --output table
}

# Perform full cluster restore
perform_full_restore() {
    local backup_name="$1"

    log "Performing full cluster restore from backup: $backup_name"

    # Create restore with excluded items
    velero restore create "dr-restore-$(date +%Y%m%d-%H%M%S)" \
        --from-backup "$backup_name" \
        --exclude-resources pods,replicasets \
        --wait

    # Verify critical services
    log "Verifying critical services after restore..."

    local critical_deployments=("kube-dns" "coredns" "metrics-server")
    for deployment in "${critical_deployments[@]}"; do
        if kubectl get deployment "$deployment" -n kube-system >/dev/null 2>&1; then
            kubectl rollout status deployment/"$deployment" -n kube-system --timeout=300s
            log "✓ $deployment is healthy"
        fi
    done

    log "✓ Full cluster restore completed"
}

# Perform namespace-specific restore
perform_namespace_restore() {
    local backup_name="$1"
    local namespace="$2"

    log "Performing namespace restore for $namespace from backup: $backup_name"

    # Create namespace if it doesn't exist
    kubectl create namespace "$namespace" --dry-run=client -o yaml | kubectl apply -f -

    # Perform selective restore
    velero restore create "ns-restore-$namespace-$(date +%Y%m%d-%H%M%S)" \
        --from-backup "$backup_name" \
        --include-namespaces "$namespace" \
        --wait

    # Verify namespace health
    log "Verifying namespace $namespace after restore..."

    local ready_pods failed_pods
    ready_pods=$(kubectl get pods -n "$namespace" --field-selector=status.phase=Running --no-headers | wc -l)
    failed_pods=$(kubectl get pods -n "$namespace" --field-selector=status.phase=Failed --no-headers | wc -l)

    log "Namespace $namespace status: $ready_pods running pods, $failed_pods failed pods"

    if [ "$failed_pods" -gt 0 ]; then
        log "WARNING: Some pods failed in namespace $namespace"
        kubectl get pods -n "$namespace" --field-selector=status.phase=Failed
    fi

    log "✓ Namespace restore completed"
}

# Test disaster recovery procedures
test_disaster_recovery() {
    log "Testing disaster recovery procedures..."

    local test_namespace="dr-test-$(date +%s)"

    # Create test namespace and resources
    kubectl create namespace "$test_namespace"
    kubectl create deployment test-app --image=nginx:1.21 -n "$test_namespace"
    kubectl create configmap test-config --from-literal=key=value -n "$test_namespace"

    # Create test backup
    local test_backup="test-backup-$(date +%Y%m%d-%H%M%S)"
    velero backup create "$test_backup" \
        --include-namespaces "$test_namespace" \
        --wait

    # Delete resources
    kubectl delete namespace "$test_namespace"

    # Wait for cleanup
    sleep 10

    # Restore from backup
    velero restore create "test-restore-$(date +%Y%m%d-%H%M%S)" \
        --from-backup "$test_backup" \
        --wait

    # Verify restoration
    if kubectl get deployment test-app -n "$test_namespace" >/dev/null 2>&1; then
        log "✓ Disaster recovery test PASSED"
    else
        log "✗ Disaster recovery test FAILED"
        exit 1
    fi

    # Cleanup test resources
    kubectl delete namespace "$test_namespace"
    velero backup delete "$test_backup" --confirm

    log "✓ Disaster recovery test completed"
}

# Generate disaster recovery report
generate_dr_report() {
    log "Generating disaster recovery report..."

    local report_file="./dr-report-$(date +%Y%m%d-%H%M%S).json"

    # Collect backup information
    local backup_count
    backup_count=$(velero backup get --output json | jq '.items | length')

    local recent_backups
    recent_backups=$(velero backup get --output json | jq -r '.items[] | select(.status.phase == "Completed") | .metadata.name' | head -10)

    # Collect cluster health information
    local node_count ready_nodes
    node_count=$(kubectl get nodes --no-headers | wc -l)
    ready_nodes=$(kubectl get nodes --no-headers | grep -c Ready)

    cat > "$report_file" << EOF
{
  "disaster_recovery_report": {
    "generated_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "cluster_name": "$CLUSTER_NAME",
    "backup_status": {
      "total_backups": $backup_count,
      "recent_successful_backups": [
        $(echo "$recent_backups" | sed 's/^/"/' | sed 's/$/"/' | paste -sd ',' -)
      ]
    },
    "cluster_health": {
      "total_nodes": $node_count,
      "ready_nodes": $ready_nodes,
      "node_readiness_ratio": "$(echo "scale=2; $ready_nodes / $node_count * 100" | bc)%"
    },
    "velero_status": {
      "installation_status": "$(kubectl get deployment velero -n velero -o jsonpath='{.status.readyReplicas}')/$(kubectl get deployment velero -n velero -o jsonpath='{.spec.replicas}')",
      "backup_locations": [
        $(velero backup-location get -o json | jq -r '.items[].metadata.name' | sed 's/^/"/' | sed 's/$/"/' | paste -sd ',' -)
      ]
    }
  }
}
EOF

    log "✓ Disaster recovery report generated: $report_file"
}

# Main execution
case "$RECOVERY_TYPE" in
    "test")
        validate_prerequisites
        test_disaster_recovery
        ;;
    "full")
        validate_prerequisites
        list_available_backups
        if [ "$BACKUP_DATE" = "latest" ]; then
            local latest_backup
            latest_backup=$(velero backup get --output json | jq -r '.items[] | select(.status.phase == "Completed") | .metadata.name' | head -1)
            perform_full_restore "$latest_backup"
        else
            perform_full_restore "$BACKUP_DATE"
        fi
        ;;
    "namespace")
        validate_prerequisites
        if [ -z "${4:-}" ]; then
            log "ERROR: Namespace parameter required for namespace restore"
            exit 1
        fi
        perform_namespace_restore "$BACKUP_DATE" "$4"
        ;;
    "report")
        validate_prerequisites
        generate_dr_report
        ;;
    *)
        echo "Usage: $0 <cluster_name> [full|namespace|test|report] [backup_date] [namespace]"
        exit 1
        ;;
esac

log "Disaster recovery operation completed"
EOF

chmod +x ~/.local/bin/kubernetes-disaster-recovery.sh