# Advanced health monitoring
cat > ~/.local/bin/enterprise-health-monitor.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [HEALTH] $*"
}

# Comprehensive health checks
perform_health_checks() {
    log "Performing comprehensive health checks..."

    local health_report="/tmp/podman-health-$(date +%Y%m%d-%H%M%S).json"

    cat > "$health_report" << HEALTH_EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "platform": "Podman Enterprise",
  "version": "$(podman --version)",
  "host": "$(hostname)",
  "user": "$(whoami)",
  "checks": {
HEALTH_EOF

    # System health
    check_system_health() {
        local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
        local memory_usage=$(free | grep '^Mem' | awk '{printf "%.1f", $3/$2 * 100.0}')
        local disk_usage=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)

        cat >> "$health_report" << SYSTEM_EOF
    "system": {
      "status": "$([ ${cpu_usage%.*} -lt 80 ] && [ ${memory_usage%.*} -lt 80 ] && [ $disk_usage -lt 85 ] && echo "healthy" || echo "warning")",
      "cpu_usage_percent": $cpu_usage,
      "memory_usage_percent": $memory_usage,
      "disk_usage_percent": $disk_usage,
      "load_average": "$(uptime | awk -F'load average:' '{print $2}')"
    },
SYSTEM_EOF
    }

    # Container health
    check_container_health() {
        local total_containers=$(podman ps -aq | wc -l)
        local running_containers=$(podman ps -q | wc -l)
        local failed_containers=$(podman ps -aq --filter status=exited | wc -l)

        cat >> "$health_report" << CONTAINER_EOF
    "containers": {
      "status": "$([ $failed_containers -eq 0 ] && echo "healthy" || echo "degraded")",
      "total": $total_containers,
      "running": $running_containers,
      "stopped": $((total_containers - running_containers)),
      "failed": $failed_containers,
      "details": [
CONTAINER_EOF

        # Individual container health
        local first=true
        podman ps -a --format "{{.Names}}" | while read container; do
            if [[ -n "$container" ]]; then
                [[ $first == true ]] && first=false || echo "," >> "$health_report"

                local status=$(podman inspect "$container" | jq -r '.[0].State.Status')
                local health=$(podman inspect "$container" | jq -r '.[0].State.Health.Status // "none"')
                local restarts=$(podman inspect "$container" | jq -r '.[0].RestartCount // 0')

                cat >> "$health_report" << CONTAINER_DETAIL_EOF
        {
          "name": "$container",
          "status": "$status",
          "health": "$health",
          "restarts": $restarts
        }
CONTAINER_DETAIL_EOF
            fi
        done

        echo "      ]" >> "$health_report"
        echo "    }," >> "$health_report"
    }

    # Network health
    check_network_health() {
        local network_count=$(podman network ls -q | wc -l)

        cat >> "$health_report" << NETWORK_EOF
    "networking": {
      "status": "healthy",
      "networks": $network_count,
      "connectivity": [
NETWORK_EOF

        # Test external connectivity
        local google_status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 https://google.com || echo "000")
        local dns_status=$(nslookup google.com >/dev/null 2>&1 && echo "ok" || echo "failed")

        cat >> "$health_report" << CONNECTIVITY_EOF
        {
          "target": "google.com",
          "http_status": $google_status,
          "dns_resolution": "$dns_status"
        }
      ]
    },
CONNECTIVITY_EOF
    }

    # Storage health
    check_storage_health() {
        local storage_driver=$(podman info | grep -i "storage driver" | awk '{print $3}' || echo "unknown")
        local images_count=$(podman images -q | wc -l)
        local volumes_count=$(podman volume ls -q | wc -l)

        cat >> "$health_report" << STORAGE_EOF
    "storage": {
      "status": "healthy",
      "driver": "$storage_driver",
      "images": $images_count,
      "volumes": $volumes_count,
      "space_usage": "$(du -sh ~/.local/share/containers/storage | cut -f1)"
    }
STORAGE_EOF
    }

    # Execute all health checks
    check_system_health
    check_container_health
    check_network_health
    check_storage_health

    # Close JSON
    echo "  }" >> "$health_report"
    echo "}" >> "$health_report"

    # Display health summary
    log "Health check completed. Report: $health_report"
    jq -r '.checks | to_entries[] | "\(.key): \(.value.status)"' "$health_report"

    return 0
}

# Automated remediation
perform_automated_remediation() {
    log "Performing automated remediation..."

    # Clean up stopped containers
    local stopped_containers=$(podman ps -aq --filter status=exited | wc -l)
    if [[ $stopped_containers -gt 10 ]]; then
        log "Cleaning up $stopped_containers stopped containers"
        podman container prune -f
    fi

    # Clean up unused images
    local unused_images=$(podman images -f "dangling=true" -q | wc -l)
    if [[ $unused_images -gt 5 ]]; then
        log "Cleaning up $unused_images unused images"
        podman image prune -f
    fi

    # Clean up unused volumes
    local unused_volumes=$(podman volume ls -f "dangling=true" -q | wc -l)
    if [[ $unused_volumes -gt 3 ]]; then
        log "Cleaning up $unused_volumes unused volumes"
        podman volume prune -f
    fi

    # Restart failed containers
    podman ps -a --filter status=exited --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            local restart_policy=$(podman inspect "$container" | jq -r '.[0].HostConfig.RestartPolicy.Name')
            if [[ "$restart_policy" != "no" ]]; then
                log "Attempting to restart failed container: $container"
                podman restart "$container" || true
            fi
        fi
    done
}

# Execute health monitoring
log "Starting enterprise health monitoring..."
perform_health_checks
perform_automated_remediation
log "Enterprise health monitoring completed"
EOF

chmod +x ~/.local/bin/enterprise-health-monitor.sh

# Set up periodic health monitoring
cat > ~/.config/containers/systemd/health-monitor.timer << 'EOF'
[Unit]
Description=Enterprise Podman Health Monitor Timer
Requires=health-monitor.service

[Timer]
OnBootSec=15min
OnUnitActiveSec=30min
Persistent=true

[Install]
WantedBy=timers.target
EOF

cat > ~/.config/containers/systemd/health-monitor.service << 'EOF'
[Unit]
Description=Enterprise Podman Health Monitor
After=network-online.target

[Service]
Type=oneshot
ExecStart=/home/%i/.local/bin/enterprise-health-monitor.sh
User=%i
EOF

# Enable health monitoring timer
systemctl --user daemon-reload
systemctl --user enable health-monitor.timer
systemctl --user start health-monitor.timer

## 🚀 Enterprise CI/CD Integration & Automation

### GitLab CI/CD Integration