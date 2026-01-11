# docker-security-monitor.sh - Runtime security monitoring
cat > docker-security-monitor.sh << 'EOF'
#!/bin/bash
set -euo pipefail

MONITOR_INTERVAL="${MONITOR_INTERVAL:-30}"
LOG_FILE="${LOG_FILE:-/var/log/docker-security.log}"
ALERT_WEBHOOK="${ALERT_WEBHOOK:-}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SECURITY] $*" | tee -a "$LOG_FILE"
}

alert() {
    local level="$1"
    local message="$2"

    log "[$level] $message"

    if [ -n "$ALERT_WEBHOOK" ]; then
        curl -X POST "$ALERT_WEBHOOK" \
            -H "Content-Type: application/json" \
            -d "{\"level\":\"$level\",\"message\":\"$message\",\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}" \
            >/dev/null 2>&1 || true
    fi
}

# Monitor container resource usage
monitor_resources() {
    log "Monitoring container resource usage..."

    docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}" | \
    while IFS=$'\t' read -r container cpu memory mem_perc; do
        if [ "$container" = "CONTAINER" ]; then
            continue
        fi

        # Extract numeric values
        cpu_num=$(echo "$cpu" | sed 's/%//')
        mem_num=$(echo "$mem_perc" | sed 's/%//')

        # Check for resource abuse
        if (( $(echo "$cpu_num > 80" | bc -l) )); then
            alert "WARNING" "High CPU usage detected: $container ($cpu)"
        fi

        if (( $(echo "$mem_num > 85" | bc -l) )); then
            alert "WARNING" "High memory usage detected: $container ($memory)"
        fi
    done
}

# Monitor for privileged containers
monitor_privileged_containers() {
    log "Checking for privileged containers..."

    docker ps --format "table {{.Names}}\t{{.Image}}" | tail -n +2 | while read -r name image; do
        if docker inspect "$name" | jq -r '.[0].HostConfig.Privileged' | grep -q true; then
            alert "HIGH" "Privileged container detected: $name ($image)"
        fi

        # Check for dangerous capabilities
        caps=$(docker inspect "$name" | jq -r '.[0].HostConfig.CapAdd[]?' 2>/dev/null || echo "")
        for cap in $caps; do
            if [[ "$cap" =~ (SYS_ADMIN|SYS_PTRACE|DAC_OVERRIDE|SYS_MODULE) ]]; then
                alert "HIGH" "Dangerous capability detected: $name has $cap"
            fi
        done

        # Check for host network mode
        if docker inspect "$name" | jq -r '.[0].HostConfig.NetworkMode' | grep -q host; then
            alert "MEDIUM" "Host network mode detected: $name"
        fi

        # Check for host PID mode
        if docker inspect "$name" | jq -r '.[0].HostConfig.PidMode' | grep -q host; then
            alert "HIGH" "Host PID mode detected: $name"
        fi
    done
}

# Monitor for suspicious processes
monitor_suspicious_processes() {
    log "Monitoring for suspicious processes in containers..."

    docker ps --format "{{.Names}}" | while read -r container; do
        # Check for shell access
        if docker exec "$container" ps aux 2>/dev/null | grep -E "(bash|sh|zsh|fish)" | grep -v grep; then
            alert "MEDIUM" "Shell process detected in container: $container"
        fi

        # Check for network tools
        if docker exec "$container" ps aux 2>/dev/null | grep -E "(nc|netcat|nmap|wget|curl)" | grep -v grep; then
            alert "MEDIUM" "Network tool detected in container: $container"
        fi

        # Check for privilege escalation tools
        if docker exec "$container" ps aux 2>/dev/null | grep -E "(sudo|su|setuid)" | grep -v grep; then
            alert "HIGH" "Privilege escalation tool detected in container: $container"
        fi
    done
}

# Monitor file system changes
monitor_filesystem_changes() {
    log "Monitoring container filesystem changes..."

    docker ps --format "{{.Names}}" | while read -r container; do
        # Get container filesystem diff
        changes=$(docker diff "$container" 2>/dev/null | wc -l)

        if [ "$changes" -gt 100 ]; then
            alert "MEDIUM" "Excessive filesystem changes detected: $container ($changes changes)"
        fi

        # Check for suspicious file modifications
        docker diff "$container" 2>/dev/null | while read -r change_type file; do
            case "$file" in
                */etc/passwd|*/etc/shadow|*/etc/sudoers|*/root/.ssh/*)
                    alert "HIGH" "Suspicious file modification: $container $change_type $file"
                    ;;
                */bin/*|*/sbin/*|*/usr/bin/*|*/usr/sbin/*)
                    if [ "$change_type" = "A" ] || [ "$change_type" = "C" ]; then
                        alert "MEDIUM" "Binary modification detected: $container $change_type $file"
                    fi
                    ;;
            esac
        done
    done
}

# Monitor network connections
monitor_network_connections() {
    log "Monitoring container network connections..."

    docker ps --format "{{.Names}}" | while read -r container; do
        # Get network connections
        connections=$(docker exec "$container" netstat -tn 2>/dev/null | grep ESTABLISHED | wc -l || echo 0)

        if [ "$connections" -gt 50 ]; then
            alert "MEDIUM" "High number of network connections: $container ($connections connections)"
        fi

        # Check for suspicious ports
        docker exec "$container" netstat -tnlp 2>/dev/null | grep LISTEN | while read -r line; do
            port=$(echo "$line" | awk '{print $4}' | cut -d: -f2)
            case "$port" in
                22|23|21|3389|4444|6666|8080|9999)
                    alert "MEDIUM" "Suspicious listening port detected: $container port $port"
                    ;;
            esac
        done
    done
}

# Generate security report
generate_security_report() {
    local report_file="/tmp/docker-security-report-$(date +%Y%m%d-%H%M%S).json"

    log "Generating security report..."

    cat > "$report_file" << EOF
{
  "security_report": {
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "containers": [
$(docker ps --format "{{.Names}}" | while read -r container; do
    echo "      {"
    echo "        \"name\": \"$container\","
    echo "        \"image\": \"$(docker inspect "$container" | jq -r '.[0].Config.Image')\","
    echo "        \"privileged\": $(docker inspect "$container" | jq -r '.[0].HostConfig.Privileged'),"
    echo "        \"user\": \"$(docker inspect "$container" | jq -r '.[0].Config.User // "root"')\","
    echo "        \"capabilities\": $(docker inspect "$container" | jq -r '.[0].HostConfig.CapAdd // []'),"
    echo "        \"network_mode\": \"$(docker inspect "$container" | jq -r '.[0].HostConfig.NetworkMode')\","
    echo "        \"pid_mode\": \"$(docker inspect "$container" | jq -r '.[0].HostConfig.PidMode // "default"')\","
    echo "        \"filesystem_changes\": $(docker diff "$container" 2>/dev/null | wc -l)"
    echo "      },"
done | sed '$ s/,$//')
    ],
    "summary": {
      "total_containers": $(docker ps -q | wc -l),
      "privileged_containers": $(docker ps --format "{{.Names}}" | xargs -I {} docker inspect {} | jq -r '.[0].HostConfig.Privileged' | grep -c true || echo 0),
      "host_network_containers": $(docker ps --format "{{.Names}}" | xargs -I {} docker inspect {} | jq -r '.[0].HostConfig.NetworkMode' | grep -c host || echo 0)
    }
  }
}
EOF

    log "✓ Security report generated: $report_file"
}

# Main monitoring loop
main() {
    log "Starting Docker security monitoring (interval: ${MONITOR_INTERVAL}s)"

    while true; do
        monitor_resources
        monitor_privileged_containers
        monitor_suspicious_processes
        monitor_filesystem_changes
        monitor_network_connections
        generate_security_report

        sleep "$MONITOR_INTERVAL"
    done
}

# Signal handler for graceful shutdown
cleanup() {
    log "Shutting down Docker security monitor..."
    exit 0
}

trap cleanup SIGTERM SIGINT

# Start monitoring if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
EOF

chmod +x docker-security-monitor.sh