# lib/monitoring_provider.rb - Enterprise monitoring configuration
class MonitoringProvider
  def self.configure(config, vm, environment)
    vm.vm.provision "shell", inline: <<-SCRIPT
      # Install Prometheus Node Exporter
      wget -q https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
      tar xvfz node_exporter-1.6.1.linux-amd64.tar.gz
      sudo cp node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/
      sudo useradd --no-create-home --shell /bin/false node_exporter

      # Create systemd service for Node Exporter
      sudo tee /etc/systemd/system/node_exporter.service > /dev/null << 'EOF'
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter \
  --web.listen-address=0.0.0.0:9100 \
  --collector.systemd \
  --collector.processes

[Install]
WantedBy=multi-user.target
EOF

      sudo systemctl daemon-reload
      sudo systemctl enable node_exporter
      sudo systemctl start node_exporter

      # Configure Prometheus server if this is the monitoring node
      if [ "#{environment.role}" = "monitoring" ]; then
        wget -q https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz
        tar xvfz prometheus-2.45.0.linux-amd64.tar.gz
        sudo cp prometheus-2.45.0.linux-amd64/prometheus /usr/local/bin/
        sudo cp prometheus-2.45.0.linux-amd64/promtool /usr/local/bin/
        sudo useradd --no-create-home --shell /bin/false prometheus
        sudo mkdir -p /etc/prometheus/{rules,targets} /var/lib/prometheus
        sudo chown prometheus:prometheus /etc/prometheus /var/lib/prometheus

        # Dynamic Prometheus configuration
        sudo tee /etc/prometheus/prometheus.yml > /dev/null << 'PROM_EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  external_labels:
    environment: '#{environment.name}'
    cluster: 'vagrant-enterprise'

rule_files:
  - "/etc/prometheus/rules/*.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets: ['localhost:9093']

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node-exporter'
    static_configs:
      - targets:
PROM_EOF

        # Add all environment nodes to monitoring
        echo "#{config.environments.map { |env| env.nodes.map { |node| "        - '#{node.name}:9100'" } }.flatten.join("\n")}" | sudo tee -a /etc/prometheus/prometheus.yml

        sudo tee -a /etc/prometheus/prometheus.yml > /dev/null << 'PROM_EOF'

  - job_name: 'application-metrics'
    metrics_path: /metrics
    static_configs:
      - targets:
        - 'web01:8080'
        - 'app01:8080'
        - 'api01:8080'

  - job_name: 'database-metrics'
    static_configs:
      - targets:
        - 'db01:9187'  # PostgreSQL exporter
        - 'db01:9104'  # MySQL exporter
PROM_EOF

        # Create enterprise alerting rules
        sudo tee /etc/prometheus/rules/vagrant-alerts.yml > /dev/null << 'ALERT_EOF'
groups:
  - name: vagrant-infrastructure
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Instance {{ \$labels.instance }} down"
          description: "{{ \$labels.instance }} has been down for more than 1 minute."

      - alert: HighCPUUsage
        expr: 100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage on {{ \$labels.instance }}"
          description: "CPU usage is above 80% for more than 5 minutes."

      - alert: HighMemoryUsage
        expr: (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100 > 90
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "High memory usage on {{ \$labels.instance }}"
          description: "Memory usage is above 90% for more than 2 minutes."

      - alert: DiskSpaceLow
        expr: 100 - ((node_filesystem_avail_bytes{mountpoint="/"} * 100) / node_filesystem_size_bytes{mountpoint="/"}) > 85
        for: 1m
        labels:
          severity: warning
        annotations:
          summary: "Low disk space on {{ \$labels.instance }}"
          description: "Disk usage is above 85% on root filesystem."
ALERT_EOF

        # Create Prometheus systemd service
        sudo tee /etc/systemd/system/prometheus.service > /dev/null << 'SERVICE_EOF'
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle \
  --web.enable-admin-api

[Install]
WantedBy=multi-user.target
SERVICE_EOF

        sudo systemctl daemon-reload
        sudo systemctl enable prometheus
        sudo systemctl start prometheus

        echo "Prometheus server started on port 9090"
      fi
    SCRIPT
  end
end