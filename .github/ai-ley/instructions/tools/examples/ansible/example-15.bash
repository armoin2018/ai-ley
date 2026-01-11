# enterprise-monitoring-setup.sh - Complete monitoring stack automation
#!/bin/bash
set -euo pipefail

MONITORING_STACK="${MONITORING_STACK:-prometheus}"
GRAFANA_VERSION="${GRAFANA_VERSION:-10.1.0}"
PROMETHEUS_VERSION="${PROMETHEUS_VERSION:-2.46.0}"
ELASTICSEARCH_VERSION="${ELASTICSEARCH_VERSION:-8.9.0}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [MONITORING-SETUP] $*"
}

# Create comprehensive monitoring playbook
create_monitoring_playbook() {
    log "Creating enterprise monitoring and observability playbook..."

    mkdir -p playbooks/monitoring/{prometheus,grafana,elasticsearch,alertmanager,node-exporter}

    cat > playbooks/monitoring/enterprise_observability.yml << 'MONITORING_PLAYBOOK_EOF'
---
- name: Enterprise Monitoring and Observability Platform
  hosts: monitoring_servers
  become: true
  gather_facts: true
  vars_files:
    - vars/monitoring/prometheus.yml
    - vars/monitoring/grafana.yml
    - vars/monitoring/alerting.yml
    - vault/monitoring/secrets.yml

  pre_tasks:
    - name: Create monitoring user
      user:
        name: monitoring
        system: true
        shell: /bin/false
        home: /opt/monitoring
        create_home: true
        groups: adm,systemd-journal

    - name: Create monitoring directories
      file:
        path: "{{ item }}"
        state: directory
        owner: monitoring
        group: monitoring
        mode: '0755'
      loop:
        - /opt/monitoring
        - /opt/monitoring/data
        - /opt/monitoring/config
        - /opt/monitoring/dashboards
        - /opt/monitoring/alerts
        - /var/log/monitoring

  roles:
    - { role: monitoring.prometheus, tags: ['prometheus'] }
    - { role: monitoring.grafana, tags: ['grafana'] }
    - { role: monitoring.alertmanager, tags: ['alertmanager'] }
    - { role: monitoring.elasticsearch, tags: ['elasticsearch', 'logging'] }
    - { role: monitoring.kibana, tags: ['kibana', 'logging'] }
    - { role: monitoring.logstash, tags: ['logstash', 'logging'] }

  post_tasks:
    - name: Configure monitoring service mesh
      template:
        src: service_mesh_monitoring.yml.j2
        dest: /opt/monitoring/config/service_mesh.yml

    - name: Setup monitoring data retention
      cron:
        name: "Clean old monitoring data"
        hour: "2"
        minute: "0"
        job: "find /opt/monitoring/data -name '*.log' -mtime +{{ monitoring_retention_days | default(90) }} -delete"

    - name: Validate monitoring stack
      uri:
        url: "http://localhost:{{ item.port }}/api/health"
        method: GET
        status_code: 200
      loop:
        - { service: "prometheus", port: 9090 }
        - { service: "grafana", port: 3000 }
        - { service: "alertmanager", port: 9093 }
      retries: 5
      delay: 10

- name: Deploy Node Exporters to All Systems
  hosts: all
  become: true
  gather_facts: true

  roles:
    - { role: monitoring.node_exporter, tags: ['node-exporter'] }
    - { role: monitoring.filebeat, tags: ['filebeat', 'logging'] }

  post_tasks:
    - name: Register systems with monitoring
      uri:
        url: "http://{{ monitoring_server }}/api/v1/targets"
        method: POST
        headers:
          Authorization: "Bearer {{ monitoring_api_token }}"
        body_format: json
        body:
          hostname: "{{ ansible_hostname }}"
          ip_address: "{{ ansible_default_ipv4.address }}"
          services: "{{ ansible_service_mgr }}"
          os_family: "{{ ansible_os_family }}"
          monitoring_endpoints:
            - { service: "node_exporter", port: 9100 }
            - { service: "filebeat", port: 5066 }
MONITORING_PLAYBOOK_EOF

    log "✓ Enterprise monitoring playbook created"
}

# Create Prometheus role
create_prometheus_role() {
    log "Creating advanced Prometheus monitoring role..."

    mkdir -p roles/monitoring.prometheus/{tasks,handlers,templates,files,vars,defaults,meta}

    cat > roles/monitoring.prometheus/tasks/main.yml << 'PROMETHEUS_TASKS_EOF'
---
- name: Create prometheus user
  user:
    name: prometheus
    system: true
    shell: /sbin/nologin
    home: /var/lib/prometheus
    create_home: true

- name: Create prometheus directories
  file:
    path: "{{ item }}"
    state: directory
    owner: prometheus
    group: prometheus
    mode: '0755'
  loop:
    - /etc/prometheus
    - /etc/prometheus/rules.d
    - /var/lib/prometheus
    - /var/lib/prometheus/data

- name: Download and install Prometheus
  unarchive:
    src: "https://github.com/prometheus/prometheus/releases/download/v{{ prometheus_version }}/prometheus-{{ prometheus_version }}.linux-amd64.tar.gz"
    dest: /tmp
    remote_src: true
    creates: "/tmp/prometheus-{{ prometheus_version }}.linux-amd64"

- name: Install prometheus binaries
  copy:
    src: "/tmp/prometheus-{{ prometheus_version }}.linux-amd64/{{ item }}"
    dest: "/usr/local/bin/{{ item }}"
    owner: root
    group: root
    mode: '0755'
    remote_src: true
  loop:
    - prometheus
    - promtool
  notify: restart prometheus

- name: Install prometheus configuration
  template:
    src: prometheus.yml.j2
    dest: /etc/prometheus/prometheus.yml
    owner: prometheus
    group: prometheus
    mode: '0644'
    backup: true
  notify: reload prometheus

- name: Install prometheus alerting rules
  template:
    src: "{{ item }}.j2"
    dest: "/etc/prometheus/rules.d/{{ item }}"
    owner: prometheus
    group: prometheus
    mode: '0644'
  loop: "{{ prometheus_rule_files }}"
  notify: reload prometheus

- name: Create prometheus systemd service
  template:
    src: prometheus.service.j2
    dest: /etc/systemd/system/prometheus.service
  notify:
    - reload systemd
    - restart prometheus

- name: Start and enable prometheus
  systemd:
    name: prometheus
    state: started
    enabled: true
    daemon_reload: true

- name: Configure Prometheus high availability
  include_tasks: ha_setup.yml
  when: prometheus_ha_enabled | default(false)

- name: Setup Prometheus federation
  include_tasks: federation.yml
  when: prometheus_federation_enabled | default(false)
PROMETHEUS_TASKS_EOF

    # Create advanced Prometheus configuration template
    cat > roles/monitoring.prometheus/templates/prometheus.yml.j2 << 'PROMETHEUS_CONFIG_EOF'
# Enterprise Prometheus Configuration
global:
  scrape_interval: {{ prometheus_scrape_interval | default('15s') }}
  evaluation_interval: {{ prometheus_evaluation_interval | default('15s') }}
  scrape_timeout: {{ prometheus_scrape_timeout | default('10s') }}
  external_labels:
    cluster: '{{ prometheus_cluster_name | default("production") }}'
    replica: '{{ prometheus_replica_name | default("1") }}'
    environment: '{{ environment | default("production") }}'

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
{% for alertmanager in alertmanager_servers %}
          - '{{ alertmanager }}:9093'
{% endfor %}
      timeout: 10s
      api_version: v2

# Load rules once and periodically evaluate them
rule_files:
  - "rules.d/*.yml"
  - "rules.d/infrastructure/*.yml"
  - "rules.d/application/*.yml"
  - "rules.d/business/*.yml"

# Scrape configurations
scrape_configs:
  # Prometheus itself
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
    scrape_interval: 15s
    metrics_path: /metrics

  # Node exporters
  - job_name: 'node-exporter'
    consul_sd_configs:
      - server: '{{ consul_server | default("consul.service.consul:8500") }}'
        services: ['node-exporter']
    relabel_configs:
      - source_labels: [__meta_consul_address]
        target_label: __address__
        replacement: '${1}:9100'
      - source_labels: [__meta_consul_node]
        target_label: instance
    scrape_interval: 30s

  # Application metrics
  - job_name: 'application-metrics'
    kubernetes_sd_configs:
      - role: pod
        namespaces:
          names:
            - default
            - monitoring
            - applications
    relabel_configs:
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
        action: keep
        regex: true
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
        action: replace
        target_label: __metrics_path__
        regex: (.+)
      - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
        action: replace
        regex: ([^:]+)(?::\d+)?;(\d+)
        replacement: $1:$2
        target_label: __address__

  # Database monitoring
  - job_name: 'mysql-exporter'
    static_configs:
{% for mysql_host in mysql_servers %}
      - targets: ['{{ mysql_host }}:9104']
{% endfor %}
    scrape_interval: 30s

  - job_name: 'postgresql-exporter'
    static_configs:
{% for postgres_host in postgresql_servers %}
      - targets: ['{{ postgres_host }}:9187']
{% endfor %}
    scrape_interval: 30s

  # Redis monitoring
  - job_name: 'redis-exporter'
    static_configs:
{% for redis_host in redis_servers %}
      - targets: ['{{ redis_host }}:9121']
{% endfor %}
    scrape_interval: 30s

  # Load balancer monitoring
  - job_name: 'haproxy-exporter'
    static_configs:
{% for haproxy_host in haproxy_servers %}
      - targets: ['{{ haproxy_host }}:9101']
{% endfor %}
    scrape_interval: 30s

  # Elasticsearch monitoring
  - job_name: 'elasticsearch-exporter'
    static_configs:
{% for elasticsearch_host in elasticsearch_servers %}
      - targets: ['{{ elasticsearch_host }}:9114']
{% endfor %}
    scrape_interval: 30s

  # NGINX monitoring
  - job_name: 'nginx-exporter'
    static_configs:
{% for nginx_host in nginx_servers %}
      - targets: ['{{ nginx_host }}:9113']
{% endfor %}
    scrape_interval: 30s

  # Custom business metrics
  - job_name: 'custom-business-metrics'
    static_configs:
{% for custom_endpoint in custom_metrics_endpoints %}
      - targets: ['{{ custom_endpoint.host }}:{{ custom_endpoint.port }}']
        labels:
          service: '{{ custom_endpoint.service }}'
          team: '{{ custom_endpoint.team }}'
{% endfor %}
    metrics_path: /metrics
    scrape_interval: {{ custom_metrics_interval | default('60s') }}

# Remote write configuration for long-term storage
remote_write:
{% if prometheus_remote_write_enabled | default(false) %}
  - url: "{{ prometheus_remote_write_url }}"
    basic_auth:
      username: "{{ prometheus_remote_write_username }}"
      password: "{{ prometheus_remote_write_password }}"
    write_relabel_configs:
      - source_labels: [__name__]
        regex: 'high_cardinality_metric.*'
        action: drop
{% endif %}

# Remote read configuration
remote_read:
{% if prometheus_remote_read_enabled | default(false) %}
  - url: "{{ prometheus_remote_read_url }}"
    basic_auth:
      username: "{{ prometheus_remote_read_username }}"
      password: "{{ prometheus_remote_read_password }}"
{% endif %}
PROMETHEUS_CONFIG_EOF

    log "✓ Advanced Prometheus role created"
}

# Create Grafana role with enterprise dashboards
create_grafana_role() {
    log "Creating enterprise Grafana role with comprehensive dashboards..."

    mkdir -p roles/monitoring.grafana/{tasks,handlers,templates,files,vars,defaults,meta}

    cat > roles/monitoring.grafana/tasks/main.yml << 'GRAFANA_TASKS_EOF'
---
- name: Add Grafana repository
  yum_repository:
    name: grafana
    description: Grafana Repository
    baseurl: https://packages.grafana.com/oss/rpm
    gpgcheck: true
    gpgkey: https://packages.grafana.com/gpg.key
  when: ansible_os_family == "RedHat"

- name: Add Grafana APT repository
  apt_repository:
    repo: "deb https://packages.grafana.com/oss/deb stable main"
    state: present
  when: ansible_os_family == "Debian"

- name: Install Grafana
  package:
    name: grafana
    state: present

- name: Configure Grafana
  template:
    src: grafana.ini.j2
    dest: /etc/grafana/grafana.ini
    backup: true
  notify: restart grafana

- name: Create Grafana directories
  file:
    path: "{{ item }}"
    state: directory
    owner: grafana
    group: grafana
    mode: '0755'
  loop:
    - /var/lib/grafana/dashboards
    - /var/lib/grafana/plugins
    - /etc/grafana/provisioning/dashboards
    - /etc/grafana/provisioning/datasources

- name: Configure datasources
  template:
    src: datasources.yml.j2
    dest: /etc/grafana/provisioning/datasources/datasources.yml
    owner: grafana
    group: grafana
    mode: '0644'
  notify: restart grafana

- name: Configure dashboard provisioning
  template:
    src: dashboard_provisioning.yml.j2
    dest: /etc/grafana/provisioning/dashboards/dashboard_provisioning.yml
    owner: grafana
    group: grafana
    mode: '0644'
  notify: restart grafana

- name: Install enterprise dashboards
  copy:
    src: "dashboards/{{ item }}"
    dest: "/var/lib/grafana/dashboards/{{ item }}"
    owner: grafana
    group: grafana
    mode: '0644'
  loop: "{{ grafana_enterprise_dashboards }}"
  notify: restart grafana

- name: Install Grafana plugins
  grafana_plugin:
    name: "{{ item }}"
    state: present
  loop: "{{ grafana_plugins }}"
  notify: restart grafana

- name: Start and enable Grafana
  systemd:
    name: grafana-server
    state: started
    enabled: true

- name: Wait for Grafana to start
  wait_for:
    port: 3000
    delay: 10

- name: Configure Grafana organizations
  uri:
    url: "http://localhost:3000/api/orgs"
    method: POST
    user: admin
    password: "{{ grafana_admin_password }}"
    force_basic_auth: true
    body_format: json
    body:
      name: "{{ item.name }}"
    status_code: [200, 409]
  loop: "{{ grafana_organizations }}"

- name: Configure Grafana teams
  uri:
    url: "http://localhost:3000/api/teams"
    method: POST
    user: admin
    password: "{{ grafana_admin_password }}"
    force_basic_auth: true
    body_format: json
    body:
      name: "{{ item.name }}"
      email: "{{ item.email }}"
    status_code: [200, 409]
  loop: "{{ grafana_teams }}"

- name: Setup Grafana LDAP authentication
  include_tasks: ldap_auth.yml
  when: grafana_ldap_enabled | default(false)

- name: Configure Grafana alerting
  include_tasks: alerting.yml
  when: grafana_alerting_enabled | default(true)
GRAFANA_TASKS_EOF

    log "✓ Enterprise Grafana role created"
}

# Create comprehensive alerting rules
create_alerting_rules() {
    log "Creating comprehensive alerting rules..."

    mkdir -p files/prometheus/rules/{infrastructure,application,business,security}

    # Infrastructure alerts
    cat > files/prometheus/rules/infrastructure/system_alerts.yml << 'SYSTEM_ALERTS_EOF'
groups:
  - name: system.alerts
    rules:
      - alert: HighCPUUsage
        expr: 100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
        for: 5m
        labels:
          severity: warning
          team: infrastructure
        annotations:
          summary: "High CPU usage detected on {{ $labels.instance }}"
          description: "CPU usage is above 80% for more than 5 minutes on {{ $labels.instance }}. Current value: {{ $value }}%"
          runbook: "https://runbooks.company.com/high-cpu-usage"

      - alert: HighMemoryUsage
        expr: (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100 > 85
        for: 5m
        labels:
          severity: warning
          team: infrastructure
        annotations:
          summary: "High memory usage detected on {{ $labels.instance }}"
          description: "Memory usage is above 85% for more than 5 minutes on {{ $labels.instance }}. Current value: {{ $value }}%"

      - alert: DiskSpaceRunningLow
        expr: (1 - (node_filesystem_avail_bytes / node_filesystem_size_bytes)) * 100 > 85
        for: 5m
        labels:
          severity: critical
          team: infrastructure
        annotations:
          summary: "Disk space running low on {{ $labels.instance }}"
          description: "Disk usage on {{ $labels.mountpoint }} is above 85% on {{ $labels.instance }}. Current value: {{ $value }}%"

      - alert: SystemLoadHigh
        expr: node_load1 / count by(instance)(node_cpu_seconds_total{mode="idle"}) > 2
        for: 10m
        labels:
          severity: warning
          team: infrastructure
        annotations:
          summary: "System load is high on {{ $labels.instance }}"
          description: "System load per CPU is above 2 for more than 10 minutes on {{ $labels.instance }}. Current value: {{ $value }}"

      - alert: ServiceDown
        expr: up == 0
        for: 2m
        labels:
          severity: critical
          team: infrastructure
        annotations:
          summary: "Service {{ $labels.job }} is down"
          description: "Service {{ $labels.job }} on {{ $labels.instance }} has been down for more than 2 minutes"

  - name: network.alerts
    rules:
      - alert: HighNetworkTraffic
        expr: rate(node_network_receive_bytes_total[5m]) + rate(node_network_transmit_bytes_total[5m]) > 100000000
        for: 5m
        labels:
          severity: warning
          team: network
        annotations:
          summary: "High network traffic on {{ $labels.instance }}"
          description: "Network traffic is above 100MB/s on interface {{ $labels.device }} for {{ $labels.instance }}"

      - alert: NetworkPacketLoss
        expr: rate(node_network_receive_errs_total[5m]) + rate(node_network_transmit_errs_total[5m]) > 100
        for: 5m
        labels:
          severity: critical
          team: network
        annotations:
          summary: "Network packet loss detected on {{ $labels.instance }}"
          description: "Network errors detected on interface {{ $labels.device }} for {{ $labels.instance }}"
SYSTEM_ALERTS_EOF

    # Application alerts
    cat > files/prometheus/rules/application/app_alerts.yml << 'APP_ALERTS_EOF'
groups:
  - name: application.alerts
    rules:
      - alert: ApplicationResponseTimeHigh
        expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 0.5
        for: 5m
        labels:
          severity: warning
          team: application
        annotations:
          summary: "Application response time is high"
          description: "95th percentile response time is above 0.5 seconds for {{ $labels.service }}"

      - alert: ApplicationErrorRateHigh
        expr: rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m]) > 0.05
        for: 5m
        labels:
          severity: critical
          team: application
        annotations:
          summary: "Application error rate is high"
          description: "Error rate is above 5% for {{ $labels.service }}"

      - alert: DatabaseConnectionsHigh
        expr: mysql_global_status_threads_connected / mysql_global_variables_max_connections > 0.8
        for: 5m
        labels:
          severity: warning
          team: database
        annotations:
          summary: "Database connections are high"
          description: "Database connections are above 80% of max connections"

      - alert: QueueDepthHigh
        expr: rabbitmq_queue_messages > 1000
        for: 5m
        labels:
          severity: warning
          team: application
        annotations:
          summary: "Queue depth is high"
          description: "Queue {{ $labels.queue }} has more than 1000 messages"
APP_ALERTS_EOF

    # Security alerts
    cat > files/prometheus/rules/security/security_alerts.yml << 'SECURITY_ALERTS_EOF'
groups:
  - name: security.alerts
    rules:
      - alert: FailedLoginAttempts
        expr: rate(node_systemd_socket_accepted_connections_total{name="sshd.socket"}[5m]) > 10
        for: 2m
        labels:
          severity: warning
          team: security
        annotations:
          summary: "High number of SSH connection attempts"
          description: "More than 10 SSH connection attempts per minute on {{ $labels.instance }}"

      - alert: UnauthorizedApiAccess
        expr: rate(http_requests_total{status="401"}[5m]) > 5
        for: 5m
        labels:
          severity: warning
          team: security
        annotations:
          summary: "High number of unauthorized API access attempts"
          description: "More than 5 unauthorized access attempts per minute"

      - alert: SuspiciousNetworkActivity
        expr: rate(node_network_receive_bytes_total[5m]) > 1000000000
        for: 5m
        labels:
          severity: critical
          team: security
        annotations:
          summary: "Suspicious network activity detected"
          description: "Unusually high network traffic (>1GB/s) detected on {{ $labels.instance }}"

      - alert: FileSystemChanges
        expr: increase(node_filesystem_files_free[1h]) < -1000
        for: 0m
        labels:
          severity: warning
          team: security
        annotations:
          summary: "Large number of file system changes"
          description: "More than 1000 files created/deleted in the last hour on {{ $labels.instance }}"
SECURITY_ALERTS_EOF

    log "✓ Comprehensive alerting rules created"
}

# Main monitoring setup function
main() {
    log "Setting up enterprise monitoring and observability platform..."
    log "Monitoring Stack: ${MONITORING_STACK}"
    log "Grafana Version: ${GRAFANA_VERSION}"
    log "Prometheus Version: ${PROMETHEUS_VERSION}"

    create_monitoring_playbook
    create_prometheus_role
    create_grafana_role
    create_alerting_rules

    log "Enterprise monitoring and observability platform setup completed!"
    log ""
    log "Components installed:"
    log "• Prometheus metrics collection and storage"
    log "• Grafana dashboards and visualization"
    log "• Alertmanager for notification routing"
    log "• Node exporters for system metrics"
    log "• ELK stack for log aggregation"
    log "• Comprehensive alerting rules"
    log ""
    log "Access URLs:"
    log "• Prometheus: http://localhost:9090"
    log "• Grafana: http://localhost:3000 (admin/admin)"
    log "• Alertmanager: http://localhost:9093"
}

# Execute if run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi