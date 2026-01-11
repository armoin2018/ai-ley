# Enterprise monitoring stack setup
cat > ~/.local/bin/setup-monitoring-stack.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [MONITORING] $*"
}

log "Setting up enterprise monitoring stack for Podman..."

# Prometheus configuration
setup_prometheus() {
    log "Setting up Prometheus monitoring..."

    mkdir -p ~/.config/prometheus
    cat > ~/.config/prometheus/prometheus.yml << 'PROMETHEUS_EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  external_labels:
    cluster: 'enterprise-podman'
    environment: 'production'

rule_files:
  - "/etc/prometheus/rules/*.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets:
          - alertmanager:9093

scrape_configs:
  # Prometheus self-monitoring
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  # Podman containers monitoring
  - job_name: 'podman-containers'
    static_configs:
      - targets: ['10.100.0.10:9090', '10.100.0.11:9090', '10.100.0.12:9090']
    scrape_interval: 30s
    metrics_path: '/metrics'

  # Node exporter (system metrics)
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['localhost:9100']

  # cAdvisor (container metrics)
  - job_name: 'cadvisor'
    static_configs:
      - targets: ['localhost:8080']
    scrape_interval: 30s
    metrics_path: '/metrics'

  # Podman socket metrics
  - job_name: 'podman-socket'
    static_configs:
      - targets: ['localhost:9874']
    scrape_interval: 60s
PROMETHEUS_EOF

    # Prometheus alerting rules
    mkdir -p ~/.config/prometheus/rules
    cat > ~/.config/prometheus/rules/podman-alerts.yml << 'ALERTS_EOF'
groups:
- name: podman-enterprise
  rules:
  - alert: ContainerDown
    expr: up{job="podman-containers"} == 0
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "Container {{ $labels.instance }} is down"
      description: "Container {{ $labels.instance }} has been down for more than 5 minutes"

  - alert: HighCPUUsage
    expr: rate(container_cpu_usage_seconds_total[5m]) > 0.8
    for: 10m
    labels:
      severity: warning
    annotations:
      summary: "High CPU usage on {{ $labels.container_label_io_podman_name }}"
      description: "Container {{ $labels.container_label_io_podman_name }} CPU usage is above 80%"

  - alert: HighMemoryUsage
    expr: container_memory_usage_bytes / container_spec_memory_limit_bytes > 0.9
    for: 10m
    labels:
      severity: critical
    annotations:
      summary: "High memory usage on {{ $labels.container_label_io_podman_name }}"
      description: "Container {{ $labels.container_label_io_podman_name }} memory usage is above 90%"

  - alert: ContainerRestarting
    expr: rate(container_start_time_seconds[15m]) > 0
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Container {{ $labels.container_label_io_podman_name }} is restarting"
      description: "Container {{ $labels.container_label_io_podman_name }} has restarted {{ $value }} times in the last 15 minutes"
ALERTS_EOF
}

# Grafana dashboards
setup_grafana_dashboards() {
    log "Setting up Grafana dashboards..."

    mkdir -p ~/.config/grafana/dashboards
    cat > ~/.config/grafana/dashboards/podman-enterprise.json << 'DASHBOARD_EOF'
{
  "dashboard": {
    "id": null,
    "title": "Podman Enterprise Dashboard",
    "tags": ["podman", "containers", "enterprise"],
    "timezone": "utc",
    "panels": [
      {
        "id": 1,
        "title": "Container Overview",
        "type": "stat",
        "targets": [
          {
            "expr": "count(up{job=\"podman-containers\"})",
            "legendFormat": "Total Containers"
          },
          {
            "expr": "count(up{job=\"podman-containers\"} == 1)",
            "legendFormat": "Running Containers"
          },
          {
            "expr": "count(up{job=\"podman-containers\"} == 0)",
            "legendFormat": "Failed Containers"
          }
        ]
      },
      {
        "id": 2,
        "title": "CPU Usage by Container",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(container_cpu_usage_seconds_total[5m]) * 100",
            "legendFormat": "{{ container_label_io_podman_name }}"
          }
        ],
        "yAxes": [
          {
            "label": "CPU %",
            "max": 100
          }
        ]
      },
      {
        "id": 3,
        "title": "Memory Usage by Container",
        "type": "graph",
        "targets": [
          {
            "expr": "container_memory_usage_bytes / 1024 / 1024",
            "legendFormat": "{{ container_label_io_podman_name }}"
          }
        ],
        "yAxes": [
          {
            "label": "Memory (MB)"
          }
        ]
      },
      {
        "id": 4,
        "title": "Network I/O",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(container_network_receive_bytes_total[5m]) * 8",
            "legendFormat": "{{ container_label_io_podman_name }} RX"
          },
          {
            "expr": "rate(container_network_transmit_bytes_total[5m]) * 8",
            "legendFormat": "{{ container_label_io_podman_name }} TX"
          }
        ]
      }
    ],
    "time": {
      "from": "now-1h",
      "to": "now"
    },
    "refresh": "30s"
  }
}
DASHBOARD_EOF
}

# Logging integration with Fluent Bit
setup_logging() {
    log "Setting up centralized logging..."

    mkdir -p ~/.config/fluent-bit
    cat > ~/.config/fluent-bit/fluent-bit.conf << 'FLUENT_EOF'
[SERVICE]
    Flush         1
    Log_Level     info
    Daemon        off
    Parsers_File  parsers.conf
    HTTP_Server   On
    HTTP_Listen   0.0.0.0
    HTTP_Port     2020

[INPUT]
    Name              tail
    Path              /home/$(whoami)/.local/share/containers/storage/overlay-containers/*/userdata/*/shm/*/logs/*.log
    Parser            json
    Tag               podman.*
    Refresh_Interval  5

[INPUT]
    Name systemd
    Tag  systemd.*
    Systemd_Filter _SYSTEMD_UNIT=user@$(id -u).service

[FILTER]
    Name modify
    Match podman.*
    Add environment enterprise
    Add source podman

[OUTPUT]
    Name  es
    Match podman.*
    Host  elasticsearch.enterprise.local
    Port  9200
    Index podman-logs
    Type  _doc

[OUTPUT]
    Name  prometheus_exporter
    Match *
    Host  0.0.0.0
    Port  2021
EOF

    # Fluent Bit parsers
    cat > ~/.config/fluent-bit/parsers.conf << 'PARSERS_EOF'
[PARSER]
    Name        json
    Format      json
    Time_Key    time
    Time_Format %Y-%m-%dT%H:%M:%S.%L
    Time_Keep   On

[PARSER]
    Name        podman
    Format      regex
    Regex       ^(?<time>[^ ]+) (?<stream>stdout|stderr) (?<logtag>[^ ]*) (?<log>.*)$
    Time_Key    time
    Time_Format %Y-%m-%dT%H:%M:%S.%L%z
PARSERS_EOF
}

# Container metrics exporter
setup_metrics_exporter() {
    log "Setting up container metrics exporter..."

    cat > ~/.local/bin/podman-metrics-exporter.sh << 'METRICS_EOF'
#!/bin/bash
set -euo pipefail

METRICS_PORT=${1:-9874}
METRICS_FILE="/tmp/podman_metrics.prom"

# Generate Prometheus metrics
generate_metrics() {
    cat > "$METRICS_FILE" << PROM_EOF
# HELP podman_containers_total Total number of containers
# TYPE podman_containers_total gauge
podman_containers_total $(podman ps -aq | wc -l)

# HELP podman_containers_running Number of running containers
# TYPE podman_containers_running gauge
podman_containers_running $(podman ps -q | wc -l)

# HELP podman_containers_stopped Number of stopped containers
# TYPE podman_containers_stopped gauge
podman_containers_stopped $(podman ps -aq --filter status=exited | wc -l)

# HELP podman_images_total Total number of images
# TYPE podman_images_total gauge
podman_images_total $(podman images -q | wc -l)

# HELP podman_volumes_total Total number of volumes
# TYPE podman_volumes_total gauge
podman_volumes_total $(podman volume ls -q | wc -l)

# HELP podman_networks_total Total number of networks
# TYPE podman_networks_total gauge
podman_networks_total $(podman network ls -q | wc -l)
PROM_EOF

    # Per-container metrics
    podman ps --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            # Container status
            STATUS=$(podman inspect "$container" | jq -r '.[0].State.Status')
            echo "# HELP podman_container_up Container is running (1) or not (0)"
            echo "# TYPE podman_container_up gauge"
            echo "podman_container_up{container=\"$container\"} $([ "$STATUS" = "running" ] && echo 1 || echo 0)"

            # Container restart count
            RESTARTS=$(podman inspect "$container" | jq -r '.[0].RestartCount // 0')
            echo "# HELP podman_container_restarts Total container restarts"
            echo "# TYPE podman_container_restarts counter"
            echo "podman_container_restarts{container=\"$container\"} $RESTARTS"
        fi
    done >> "$METRICS_FILE"
}

# Serve metrics
serve_metrics() {
    while true; do
        generate_metrics
        python3 -c "
import http.server
import socketserver
import os

os.chdir('/tmp')
Handler = http.server.SimpleHTTPRequestHandler

class MetricsHandler(Handler):
    def do_GET(self):
        if self.path == '/metrics':
            self.send_response(200)
            self.send_header('Content-type', 'text/plain; version=0.0.4')
            self.end_headers()
            with open('podman_metrics.prom', 'rb') as f:
                self.wfile.write(f.read())
        else:
            super().do_GET()

with socketserver.TCPServer(('', $METRICS_PORT), MetricsHandler) as httpd:
    print(f'Serving Podman metrics on port $METRICS_PORT')
    httpd.serve_forever()
" &
        sleep 30
        kill $! 2>/dev/null || true
    done
}

serve_metrics
METRICS_EOF

    chmod +x ~/.local/bin/podman-metrics-exporter.sh
}

# Execute monitoring setup
setup_prometheus
setup_grafana_dashboards
setup_logging
setup_metrics_exporter

log "Enterprise monitoring stack setup completed"
EOF

chmod +x ~/.local/bin/setup-monitoring-stack.sh
~/.local/bin/setup-monitoring-stack.sh