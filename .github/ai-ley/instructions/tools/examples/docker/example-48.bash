# docker-cis-compliance.sh - CIS Docker benchmark validation
cat > docker-cis-compliance.sh << 'EOF'
#!/bin/bash
set -euo pipefail

COMPLIANCE_REPORT="/tmp/cis-docker-compliance-$(date +%Y%m%d-%H%M%S).json"
BENCHMARK_VERSION="1.6.0"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [CIS] $*"
}

# Initialize compliance report
init_compliance_report() {
    cat > "$COMPLIANCE_REPORT" << EOF
{
  "cis_docker_benchmark": {
    "version": "$BENCHMARK_VERSION",
    "scan_date": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "results": {
      "host_configuration": [],
      "docker_daemon": [],
      "docker_files": [],
      "container_images": [],
      "container_runtime": [],
      "docker_security": []
    },
    "summary": {
      "total_checks": 0,
      "passed": 0,
      "failed": 0,
      "warnings": 0
    }
  }
}
EOF
}

# Check 1.1 - Ensure a separate partition for containers
check_container_partition() {
    log "Checking 1.1 - Container partition separation"

    local result="PASS"
    local message="Container partition separation verified"

    if ! df -h | grep -q "/var/lib/docker"; then
        result="WARN"
        message="No separate partition for /var/lib/docker"
    fi

    add_check_result "host_configuration" "1.1" "Separate partition for containers" "$result" "$message"
}

# Check 2.1 - Restrict network traffic between containers
check_network_traffic() {
    log "Checking 2.1 - Network traffic restriction"

    local result="FAIL"
    local message="Default bridge allows unrestricted traffic"

    if docker network inspect bridge | jq -r '.[0].Options."com.docker.network.bridge.enable_icc"' | grep -q false; then
        result="PASS"
        message="Inter-container communication restricted"
    fi

    add_check_result "docker_daemon" "2.1" "Restrict network traffic" "$result" "$message"
}

# Check 2.5 - Disable userland proxy
check_userland_proxy() {
    log "Checking 2.5 - Userland proxy configuration"

    local result="FAIL"
    local message="Userland proxy is enabled"

    if docker system info | grep -q "userland-proxy.*false"; then
        result="PASS"
        message="Userland proxy disabled"
    fi

    add_check_result "docker_daemon" "2.5" "Disable userland proxy" "$result" "$message"
}

# Check 3.1 - Verify Docker daemon ownership
check_daemon_ownership() {
    log "Checking 3.1 - Docker daemon ownership"

    local result="PASS"
    local message="Docker daemon ownership correct"

    if [ ! -f /usr/bin/docker ]; then
        result="FAIL"
        message="Docker binary not found"
    else
        local owner
        owner=$(stat -c %U:%G /usr/bin/docker)
        if [ "$owner" != "root:root" ]; then
            result="FAIL"
            message="Docker daemon ownership incorrect: $owner"
        fi
    fi

    add_check_result "docker_files" "3.1" "Docker daemon ownership" "$result" "$message"
}

# Check 4.1 - Ensure images are scanned for vulnerabilities
check_image_scanning() {
    log "Checking 4.1 - Image vulnerability scanning"

    local result="WARN"
    local message="Image scanning not automated"

    # Check if we have vulnerability scanning tools
    if command -v trivy >/dev/null 2>&1 || command -v grype >/dev/null 2>&1; then
        result="PASS"
        message="Vulnerability scanning tools available"
    fi

    add_check_result "container_images" "4.1" "Image vulnerability scanning" "$result" "$message"
}

# Check 4.5 - Enable Content trust for Docker
check_content_trust() {
    log "Checking 4.5 - Content trust configuration"

    local result="FAIL"
    local message="Docker content trust not enabled"

    if [ "$DOCKER_CONTENT_TRUST" = "1" ]; then
        result="PASS"
        message="Docker content trust enabled"
    fi

    add_check_result "container_images" "4.5" "Content trust" "$result" "$message"
}

# Check 5.1 - Verify AppArmor Profile
check_apparmor_profile() {
    log "Checking 5.1 - AppArmor profile verification"

    local result="PASS"
    local message="AppArmor profiles checked"
    local containers_without_apparmor=0

    docker ps --format "{{.Names}}" | while read -r container; do
        local apparmor_profile
        apparmor_profile=$(docker inspect "$container" | jq -r '.[0].AppArmorProfile // "default"')

        if [ "$apparmor_profile" = "" ] || [ "$apparmor_profile" = "unconfined" ]; then
            ((containers_without_apparmor++))
        fi
    done

    if [ "$containers_without_apparmor" -gt 0 ]; then
        result="WARN"
        message="$containers_without_apparmor containers without AppArmor profile"
    fi

    add_check_result "container_runtime" "5.1" "AppArmor profile" "$result" "$message"
}

# Check 5.3 - Restrict Linux Kernel Capabilities
check_kernel_capabilities() {
    log "Checking 5.3 - Linux kernel capabilities"

    local result="PASS"
    local message="Kernel capabilities properly restricted"
    local containers_with_dangerous_caps=0

    docker ps --format "{{.Names}}" | while read -r container; do
        local dangerous_caps
        dangerous_caps=$(docker inspect "$container" | jq -r '.[0].HostConfig.CapAdd[]?' 2>/dev/null || echo "")

        for cap in $dangerous_caps; do
            if [[ "$cap" =~ (SYS_ADMIN|SYS_PTRACE|DAC_OVERRIDE|SYS_MODULE|NET_ADMIN) ]]; then
                ((containers_with_dangerous_caps++))
                break
            fi
        done
    done

    if [ "$containers_with_dangerous_caps" -gt 0 ]; then
        result="FAIL"
        message="$containers_with_dangerous_caps containers with dangerous capabilities"
    fi

    add_check_result "container_runtime" "5.3" "Kernel capabilities" "$result" "$message"
}

# Check 5.4 - Do not use privileged containers
check_privileged_containers() {
    log "Checking 5.4 - Privileged containers"

    local result="PASS"
    local message="No privileged containers found"
    local privileged_count=0

    docker ps --format "{{.Names}}" | while read -r container; do
        if docker inspect "$container" | jq -r '.[0].HostConfig.Privileged' | grep -q true; then
            ((privileged_count++))
        fi
    done

    if [ "$privileged_count" -gt 0 ]; then
        result="FAIL"
        message="$privileged_count privileged containers found"
    fi

    add_check_result "container_runtime" "5.4" "Privileged containers" "$result" "$message"
}

# Add check result to report
add_check_result() {
    local category="$1"
    local check_id="$2"
    local description="$3"
    local result="$4"
    local message="$5"

    # Update the JSON report
    jq --arg cat "$category" --arg id "$check_id" --arg desc "$description" \
       --arg res "$result" --arg msg "$message" \
       '.cis_docker_benchmark.results[$cat] += [{
         "check_id": $id,
         "description": $desc,
         "result": $res,
         "message": $msg,
         "timestamp": now | strftime("%Y-%m-%dT%H:%M:%SZ")
       }]' "$COMPLIANCE_REPORT" > "${COMPLIANCE_REPORT}.tmp" && \
    mv "${COMPLIANCE_REPORT}.tmp" "$COMPLIANCE_REPORT"

    # Update summary
    case "$result" in
        "PASS")
            jq '.cis_docker_benchmark.summary.passed += 1' "$COMPLIANCE_REPORT" > "${COMPLIANCE_REPORT}.tmp" && \
            mv "${COMPLIANCE_REPORT}.tmp" "$COMPLIANCE_REPORT"
            ;;
        "FAIL")
            jq '.cis_docker_benchmark.summary.failed += 1' "$COMPLIANCE_REPORT" > "${COMPLIANCE_REPORT}.tmp" && \
            mv "${COMPLIANCE_REPORT}.tmp" "$COMPLIANCE_REPORT"
            ;;
        "WARN")
            jq '.cis_docker_benchmark.summary.warnings += 1' "$COMPLIANCE_REPORT" > "${COMPLIANCE_REPORT}.tmp" && \
            mv "${COMPLIANCE_REPORT}.tmp" "$COMPLIANCE_REPORT"
            ;;
    esac

    jq '.cis_docker_benchmark.summary.total_checks += 1' "$COMPLIANCE_REPORT" > "${COMPLIANCE_REPORT}.tmp" && \
    mv "${COMPLIANCE_REPORT}.tmp" "$COMPLIANCE_REPORT"
}

# Generate compliance summary
generate_compliance_summary() {
    log "Generating compliance summary..."

    local total passed failed warnings
    total=$(jq -r '.cis_docker_benchmark.summary.total_checks' "$COMPLIANCE_REPORT")
    passed=$(jq -r '.cis_docker_benchmark.summary.passed' "$COMPLIANCE_REPORT")
    failed=$(jq -r '.cis_docker_benchmark.summary.failed' "$COMPLIANCE_REPORT")
    warnings=$(jq -r '.cis_docker_benchmark.summary.warnings' "$COMPLIANCE_REPORT")

    local compliance_score
    compliance_score=$(echo "scale=2; $passed * 100 / $total" | bc)

    echo "===========================================" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "CIS Docker Benchmark Compliance Report" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "===========================================" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "Scan Date: $(date)" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "Benchmark Version: $BENCHMARK_VERSION" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "Summary:" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "  Total Checks: $total" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "  Passed: $passed" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "  Failed: $failed" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "  Warnings: $warnings" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "  Compliance Score: $compliance_score%" | tee -a "$COMPLIANCE_REPORT.txt"
    echo "" | tee -a "$COMPLIANCE_REPORT.txt"

    # List failed checks
    if [ "$failed" -gt 0 ]; then
        echo "FAILED CHECKS:" | tee -a "$COMPLIANCE_REPORT.txt"
        jq -r '.cis_docker_benchmark.results[] | .[] | select(.result=="FAIL") | "  \(.check_id): \(.description) - \(.message)"' "$COMPLIANCE_REPORT" | tee -a "$COMPLIANCE_REPORT.txt"
        echo "" | tee -a "$COMPLIANCE_REPORT.txt"
    fi

    log "✓ Compliance report generated: $COMPLIANCE_REPORT"
    log "✓ Summary report: ${COMPLIANCE_REPORT}.txt"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    log "Starting CIS Docker Benchmark compliance check..."

    init_compliance_report

    # Run compliance checks
    check_container_partition
    check_network_traffic
    check_userland_proxy
    check_daemon_ownership
    check_image_scanning
    check_content_trust
    check_apparmor_profile
    check_kernel_capabilities
    check_privileged_containers

    generate_compliance_summary

    log "CIS Docker Benchmark compliance check completed"
fi
EOF

chmod +x docker-cis-compliance.sh