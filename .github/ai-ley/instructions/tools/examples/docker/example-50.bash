# docker-logging-setup.sh - Enterprise logging configuration
cat > docker-logging-setup.sh << 'EOF'
#!/bin/bash
set -euo pipefail

LOGGING_DRIVER="${LOGGING_DRIVER:-json-file}"
LOG_MAX_SIZE="${LOG_MAX_SIZE:-10m}"
LOG_MAX_FILE="${LOG_MAX_FILE:-3}"
SYSLOG_ADDRESS="${SYSLOG_ADDRESS:-}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [LOGGING] $*"
}

# Configure Docker daemon logging
configure_daemon_logging() {
    log "Configuring Docker daemon logging..."

    local daemon_config="/etc/docker/daemon.json"

    # Backup existing configuration
    if [ -f "$daemon_config" ]; then
        cp "$daemon_config" "$daemon_config.backup.$(date +%Y%m%d-%H%M%S)"
    fi

    # Create logging configuration
    cat > "$daemon_config" << DAEMON_EOF
{
  "log-driver": "$LOGGING_DRIVER",
  "log-opts": {
    "max-size": "$LOG_MAX_SIZE",
    "max-file": "$LOG_MAX_FILE",
    "compress": "true"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ],
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-level": "info",
  "userland-proxy": false,
  "live-restore": true,
  "default-ulimits": {
    "nofile": {
      "Hard": 64000,
      "Name": "nofile",
      "Soft": 64000
    }
  }
}
DAEMON_EOF

    log "✓ Docker daemon logging configured"
}

# Setup centralized logging with Fluentd
setup_fluentd_logging() {
    log "Setting up Fluentd centralized logging..."

    mkdir -p ./fluentd/conf

    cat > ./fluentd/conf/fluent.conf << FLUENT_EOF
<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<match docker.**>
  @type elasticsearch
  host elasticsearch
  port 9200
  logstash_format true
  logstash_prefix docker
  logstash_dateformat %Y%m%d
  include_tag_key true
  type_name access_log
  tag_key @log_name
  flush_interval 1s
  <buffer>
    @type file
    path /fluentd/log/docker
    chunk_limit_size 32m
    total_limit_size 512m
    flush_at_shutdown true
  </buffer>
</match>

<match **>
  @type stdout
</match>
FLUENT_EOF

    # Create Fluentd Dockerfile
    cat > ./fluentd/Dockerfile << FLUENT_DOCKERFILE
FROM fluent/fluentd:v1.16-debian-1
USER root
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-document", "--version", "5.2.4"]
USER fluent
FLUENT_DOCKERFILE

    log "✓ Fluentd logging configuration created"
}

# Create log analysis scripts
create_log_analysis_scripts() {
    log "Creating log analysis scripts..."

    cat > ./docker-log-analyzer.sh << 'ANALYZER_EOF'
#!/bin/bash
set -euo pipefail

CONTAINER_NAME="${1:-}"
ANALYSIS_TYPE="${2:-errors}"
TIME_RANGE="${3:-1h}"

analyze_container_logs() {
    local container="$1"
    local analysis="$2"
    local range="$3"

    echo "Analyzing logs for container: $container"
    echo "Analysis type: $analysis"
    echo "Time range: $range"
    echo "=================================="

    case "$analysis" in
        "errors")
            docker logs --since="$range" "$container" 2>&1 | \
            grep -i -E "(error|exception|fail|panic|fatal)" | \
            head -50
            ;;
        "performance")
            docker logs --since="$range" "$container" 2>&1 | \
            grep -i -E "(slow|timeout|latency|response.*time)" | \
            head -50
            ;;
        "security")
            docker logs --since="$range" "$container" 2>&1 | \
            grep -i -E "(unauthorized|forbidden|attack|intrusion|malware)" | \
            head -50
            ;;
        "stats")
            echo "Log statistics for last $range:"
            echo "Total lines: $(docker logs --since="$range" "$container" 2>&1 | wc -l)"
            echo "Error lines: $(docker logs --since="$range" "$container" 2>&1 | grep -i error | wc -l)"
            echo "Warning lines: $(docker logs --since="$range" "$container" 2>&1 | grep -i warn | wc -l)"
            echo "Info lines: $(docker logs --since="$range" "$container" 2>&1 | grep -i info | wc -l)"
            ;;
        *)
            docker logs --since="$range" "$container"
            ;;
    esac
}

if [ -z "$CONTAINER_NAME" ]; then
    echo "Usage: $0 <container_name> [errors|performance|security|stats|all] [time_range]"
    echo "Example: $0 webapp errors 1h"
    exit 1
fi

analyze_container_logs "$CONTAINER_NAME" "$ANALYSIS_TYPE" "$TIME_RANGE"
ANALYZER_EOF

    chmod +x ./docker-log-analyzer.sh

    log "✓ Log analysis scripts created"
}

# Setup log rotation for host
setup_log_rotation() {
    log "Setting up log rotation for Docker containers..."

    cat > /etc/logrotate.d/docker-containers << LOGROTATE_EOF
/var/lib/docker/containers/*/*.log {
    rotate 7
    daily
    compress
    size=1M
    missingok
    delaycompress
    copytruncate
}
LOGROTATE_EOF

    log "✓ Log rotation configured"
}

# Create monitoring alerts for logs
create_log_alerts() {
    log "Creating log monitoring alerts..."

    cat > ./prometheus/rules/docker-log-alerts.yml << ALERT_EOF
groups:
- name: docker-log-alerts
  rules:
  - alert: DockerContainerHighErrorRate
    expr: increase(container_log_errors_total[5m]) > 10
    for: 2m
    labels:
      severity: warning
    annotations:
      summary: "High error rate in container logs"
      description: "Container {{ \$labels.container }} has more than 10 errors in the last 5 minutes"

  - alert: DockerContainerLogVolumeHigh
    expr: rate(container_log_lines_total[5m]) > 1000
    for: 5m
    labels:
      severity: info
    annotations:
      summary: "High log volume from container"
      description: "Container {{ \$labels.container }} is generating more than 1000 log lines per minute"

  - alert: DockerContainerNoLogs
    expr: increase(container_log_lines_total[10m]) == 0
    for: 10m
    labels:
      severity: warning
    annotations:
      summary: "Container not generating logs"
      description: "Container {{ \$labels.container }} has not generated any logs in the last 10 minutes"
ALERT_EOF

    log "✓ Log monitoring alerts created"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    log "Setting up enterprise Docker logging..."

    configure_daemon_logging
    setup_fluentd_logging
    create_log_analysis_scripts
    setup_log_rotation
    create_log_alerts

    log "Enterprise Docker logging setup completed"
    log "Remember to restart Docker daemon: sudo systemctl restart docker"
fi
EOF

chmod +x docker-logging-setup.sh