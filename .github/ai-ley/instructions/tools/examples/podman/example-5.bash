# CIS Kubernetes Benchmark compliance for Podman
cat > ~/.local/bin/podman-cis-compliance.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [CIS-COMPLIANCE] $*"
}

log "Starting CIS Kubernetes Benchmark compliance check for Podman..."

# CIS 4.2.1 - Minimize the admission of privileged containers
check_privileged_containers() {
    log "Checking for privileged containers..."
    PRIVILEGED_CONTAINERS=$(podman ps -a --filter "label=security.privileged=true" --format "{{.Names}}" | wc -l)
    if [[ $PRIVILEGED_CONTAINERS -eq 0 ]]; then
        log "✓ CIS 4.2.1 PASS: No privileged containers found"
    else
        log "✗ CIS 4.2.1 FAIL: $PRIVILEGED_CONTAINERS privileged containers found"
    fi
}

# CIS 4.2.2 - Minimize the admission of containers with allowPrivilegeEscalation
check_privilege_escalation() {
    log "Checking for containers with privilege escalation..."
    ESCALATION_CONTAINERS=$(podman ps -a --filter "label=security.allowPrivilegeEscalation=true" --format "{{.Names}}" | wc -l)
    if [[ $ESCALATION_CONTAINERS -eq 0 ]]; then
        log "✓ CIS 4.2.2 PASS: No containers with privilege escalation found"
    else
        log "✗ CIS 4.2.2 FAIL: $ESCALATION_CONTAINERS containers with privilege escalation found"
    fi
}

# CIS 4.2.3 - Minimize the admission of containers with capabilities
check_container_capabilities() {
    log "Checking container capabilities..."
    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            CAPS=$(podman inspect "$container" | jq -r '.[0].HostConfig.CapAdd[]? // empty')
            if [[ -n "$CAPS" ]]; then
                log "✗ CIS 4.2.3 WARNING: Container $container has additional capabilities: $CAPS"
            else
                log "✓ CIS 4.2.3 PASS: Container $container has minimal capabilities"
            fi
        fi
    done
}

# CIS 4.2.4 - Minimize the admission of containers with elevated capabilities
check_elevated_capabilities() {
    log "Checking for containers with elevated capabilities..."
    DANGEROUS_CAPS=("SYS_ADMIN" "NET_ADMIN" "SYS_MODULE" "SYS_RAWIO" "MAC_ADMIN")

    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            for cap in "${DANGEROUS_CAPS[@]}"; do
                if podman inspect "$container" | jq -r '.[0].HostConfig.CapAdd[]? // empty' | grep -q "$cap"; then
                    log "✗ CIS 4.2.4 FAIL: Container $container has dangerous capability: $cap"
                fi
            done
        fi
    done
}

# CIS 4.2.5 - Minimize the admission of containers with seccomp disabled
check_seccomp_profiles() {
    log "Checking seccomp profiles..."
    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            SECCOMP=$(podman inspect "$container" | jq -r '.[0].HostConfig.SecurityOpt[] | select(startswith("seccomp"))')
            if [[ "$SECCOMP" == "seccomp:unconfined" ]]; then
                log "✗ CIS 4.2.5 FAIL: Container $container has seccomp disabled"
            else
                log "✓ CIS 4.2.5 PASS: Container $container has seccomp enabled"
            fi
        fi
    done
}

# CIS 4.2.6 - Minimize the admission of root containers
check_root_containers() {
    log "Checking for root containers..."
    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            USER_ID=$(podman inspect "$container" | jq -r '.[0].Config.User // "0"')
            if [[ "$USER_ID" == "0" || "$USER_ID" == "root" || -z "$USER_ID" ]]; then
                log "✗ CIS 4.2.6 FAIL: Container $container runs as root"
            else
                log "✓ CIS 4.2.6 PASS: Container $container runs as non-root user: $USER_ID"
            fi
        fi
    done
}

# Run all CIS compliance checks
check_privileged_containers
check_privilege_escalation
check_container_capabilities
check_elevated_capabilities
check_seccomp_profiles
check_root_containers

log "CIS Kubernetes Benchmark compliance check completed"
EOF

chmod +x ~/.local/bin/podman-cis-compliance.sh

# SOC2 compliance automation
cat > ~/.local/bin/podman-soc2-compliance.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SOC2-COMPLIANCE] $*"
}

log "Starting SOC2 compliance audit for Podman containers..."

# SOC2 CC6.1 - Logical and physical access controls
audit_access_controls() {
    log "Auditing logical access controls..."

    # Check rootless operation
    if [[ $EUID -eq 0 ]]; then
        log "✗ SOC2 CC6.1 FAIL: Running as root user"
    else
        log "✓ SOC2 CC6.1 PASS: Running as non-root user ($USER)"
    fi

    # Check user namespace isolation
    USER_NS=$(podman info | grep -c "rootless" || true)
    if [[ $USER_NS -gt 0 ]]; then
        log "✓ SOC2 CC6.1 PASS: User namespace isolation enabled"
    else
        log "✗ SOC2 CC6.1 FAIL: User namespace isolation not detected"
    fi
}

# SOC2 CC6.7 - Transmission of data
audit_data_transmission() {
    log "Auditing data transmission security..."

    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            # Check for TLS configuration
            TLS_CONFIG=$(podman inspect "$container" | jq -r '.[0].Config.Env[]? | select(contains("TLS_") or contains("SSL_"))' | wc -l)
            if [[ $TLS_CONFIG -gt 0 ]]; then
                log "✓ SOC2 CC6.7 PASS: Container $container has TLS configuration"
            else
                log "⚠ SOC2 CC6.7 WARNING: Container $container may not have TLS configured"
            fi
        fi
    done
}

# SOC2 CC7.1 - System monitoring
audit_monitoring_logging() {
    log "Auditing monitoring and logging..."

    # Check if containers have logging configured
    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            LOG_DRIVER=$(podman inspect "$container" | jq -r '.[0].HostConfig.LogConfig.Type // "none"')
            if [[ "$LOG_DRIVER" != "none" ]]; then
                log "✓ SOC2 CC7.1 PASS: Container $container has logging configured ($LOG_DRIVER)"
            else
                log "✗ SOC2 CC7.1 FAIL: Container $container has no logging configured"
            fi
        fi
    done
}

# SOC2 A1.1 - Availability monitoring
audit_availability_monitoring() {
    log "Auditing availability monitoring..."

    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            HEALTHCHECK=$(podman inspect "$container" | jq -r '.[0].Config.Healthcheck.Test[]? // empty' | wc -l)
            if [[ $HEALTHCHECK -gt 0 ]]; then
                log "✓ SOC2 A1.1 PASS: Container $container has health monitoring"
            else
                log "⚠ SOC2 A1.1 WARNING: Container $container has no health monitoring"
            fi
        fi
    done
}

# Generate SOC2 compliance report
generate_soc2_report() {
    local report_file="/tmp/soc2-compliance-$(date +%Y%m%d-%H%M%S).json"
    log "Generating SOC2 compliance report: $report_file"

    cat > "$report_file" << REPORT_EOF
{
  "audit_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "audit_scope": "Podman Container Platform",
  "compliance_framework": "SOC2 Type II",
  "auditor": "Automated Podman Compliance Scanner",
  "system_info": {
    "podman_version": "$(podman --version)",
    "host_os": "$(uname -a)",
    "user_context": "$(whoami)",
    "rootless_mode": $(podman info | grep -q "rootless" && echo "true" || echo "false")
  },
  "audit_results": {
    "access_controls_cc6_1": "$(audit_access_controls 2>&1)",
    "data_transmission_cc6_7": "$(audit_data_transmission 2>&1)",
    "monitoring_logging_cc7_1": "$(audit_monitoring_logging 2>&1)",
    "availability_monitoring_a1_1": "$(audit_availability_monitoring 2>&1)"
  }
}
REPORT_EOF

    log "SOC2 compliance report generated: $report_file"
}

# Run SOC2 compliance audit
audit_access_controls
audit_data_transmission
audit_monitoring_logging
audit_availability_monitoring
generate_soc2_report

log "SOC2 compliance audit completed"
EOF

chmod +x ~/.local/bin/podman-soc2-compliance.sh

echo "Enterprise security frameworks and compliance automation configured"