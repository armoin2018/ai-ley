# enterprise-deployment-patterns.sh - Advanced deployment automation
#!/bin/bash
set -euo pipefail

DEPLOYMENT_STRATEGY="${DEPLOYMENT_STRATEGY:-blue-green}"
HEALTH_CHECK_TIMEOUT="${HEALTH_CHECK_TIMEOUT:-300}"
ROLLBACK_ENABLED="${ROLLBACK_ENABLED:-true}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [DEPLOYMENT] $*"
}

# Create blue-green deployment playbook
create_blue_green_playbook() {
    log "Creating blue-green deployment automation..."

    mkdir -p playbooks/deployment/{blue-green,canary,rolling,strategies}

    cat > playbooks/deployment/blue-green/main.yml << 'BLUE_GREEN_PLAYBOOK_EOF'
---
- name: Blue-Green Deployment Pipeline
  hosts: localhost
  gather_facts: false
  vars:
    deployment_id: "{{ ansible_date_time.epoch }}"
    blue_environment: "blue"
    green_environment: "green"
    current_environment: "{{ active_environment | default('blue') }}"
    target_environment: "{{ 'green' if current_environment == 'blue' else 'blue' }}"

  pre_tasks:
    - name: Validate deployment prerequisites
      include_tasks: tasks/validate_prerequisites.yml

    - name: Determine current active environment
      include_tasks: tasks/detect_active_environment.yml

    - name: Create deployment backup
      include_tasks: tasks/create_deployment_backup.yml
      when: create_backup_before_deploy | default(true)

  tasks:
    - name: Deploy to target environment ({{ target_environment }})
      include_tasks: tasks/deploy_to_environment.yml
      vars:
        environment: "{{ target_environment }}"
        deployment_version: "{{ application_version }}"

    - name: Run comprehensive health checks
      include_tasks: tasks/health_checks.yml
      vars:
        environment: "{{ target_environment }}"

    - name: Perform smoke tests
      include_tasks: tasks/smoke_tests.yml
      vars:
        environment: "{{ target_environment }}"

    - name: Switch traffic to new environment
      include_tasks: tasks/switch_traffic.yml
      vars:
        from_environment: "{{ current_environment }}"
        to_environment: "{{ target_environment }}"

    - name: Validate traffic switch
      include_tasks: tasks/validate_traffic_switch.yml
      vars:
        environment: "{{ target_environment }}"

    - name: Cleanup old environment
      include_tasks: tasks/cleanup_old_environment.yml
      vars:
        environment: "{{ current_environment }}"
      when: cleanup_after_deployment | default(false)

  post_tasks:
    - name: Update deployment status
      include_tasks: tasks/update_deployment_status.yml
      vars:
        status: "{{ deployment_status | default('success') }}"

    - name: Send deployment notifications
      include_tasks: tasks/send_notifications.yml
      vars:
        notification_type: "deployment_complete"

  rescue:
    - name: Handle deployment failure
      include_tasks: tasks/handle_deployment_failure.yml

    - name: Rollback if enabled
      include_tasks: tasks/rollback_deployment.yml
      when: rollback_enabled | default(true)
BLUE_GREEN_PLAYBOOK_EOF

    # Create traffic switching tasks
    cat > playbooks/deployment/blue-green/tasks/switch_traffic.yml << 'TRAFFIC_SWITCH_EOF'
---
- name: Update load balancer configuration
  template:
    src: loadbalancer_config.j2
    dest: "/etc/nginx/sites-available/{{ application_name }}"
    backup: true
  vars:
    active_backend: "{{ to_environment }}"
  delegate_to: "{{ item }}"
  loop: "{{ load_balancer_servers }}"
  notify: reload nginx

- name: Test load balancer configuration
  command: nginx -t
  delegate_to: "{{ item }}"
  loop: "{{ load_balancer_servers }}"

- name: Gracefully reload load balancer
  systemd:
    name: nginx
    state: reloaded
  delegate_to: "{{ item }}"
  loop: "{{ load_balancer_servers }}"

- name: Update DNS records for gradual traffic shift
  nsupdate:
    server: "{{ dns_server }}"
    zone: "{{ dns_zone }}"
    record: "{{ application_domain }}"
    type: A
    ttl: 60
    value: "{{ hostvars[groups[to_environment + '_servers'][0]]['ansible_default_ipv4']['address'] }}"
  when: dns_traffic_shifting_enabled | default(false)

- name: Wait for DNS propagation
  wait_for:
    timeout: "{{ dns_propagation_timeout | default(60) }}"
  when: dns_traffic_shifting_enabled | default(false)

- name: Validate traffic routing
  uri:
    url: "http://{{ application_domain }}/health"
    method: GET
    status_code: 200
    return_content: true
  register: health_check
  retries: 10
  delay: 30

- name: Update service discovery
  uri:
    url: "{{ consul_api_url }}/v1/agent/service/register"
    method: PUT
    headers:
      X-Consul-Token: "{{ consul_token }}"
    body_format: json
    body:
      ID: "{{ application_name }}-{{ to_environment }}"
      Name: "{{ application_name }}"
      Tags: ["{{ to_environment }}", "active", "v{{ application_version }}"]
      Address: "{{ hostvars[groups[to_environment + '_servers'][0]]['ansible_default_ipv4']['address'] }}"
      Port: "{{ application_port }}"
      Check:
        HTTP: "http://{{ hostvars[groups[to_environment + '_servers'][0]]['ansible_default_ipv4']['address'] }}:{{ application_port }}/health"
        Interval: "10s"
  when: consul_service_discovery_enabled | default(false)

- name: Deregister old environment from service discovery
  uri:
    url: "{{ consul_api_url }}/v1/agent/service/deregister/{{ application_name }}-{{ from_environment }}"
    method: PUT
    headers:
      X-Consul-Token: "{{ consul_token }}"
    status_code: [200, 404]
  when: consul_service_discovery_enabled | default(false)
TRAFFIC_SWITCH_EOF

    log "✓ Blue-green deployment automation created"
}

# Create canary deployment automation
create_canary_deployment() {
    log "Creating canary deployment automation..."

    cat > playbooks/deployment/canary/main.yml << 'CANARY_PLAYBOOK_EOF'
---
- name: Canary Deployment Pipeline with Automated Analysis
  hosts: localhost
  gather_facts: false
  vars:
    canary_percentage: "{{ initial_canary_percentage | default(10) }}"
    canary_increment: "{{ canary_increment_percentage | default(20) }}"
    max_canary_percentage: "{{ max_canary_percentage | default(100) }}"
    analysis_duration: "{{ canary_analysis_duration | default(300) }}"
    success_threshold: "{{ canary_success_threshold | default(0.95) }}"

  tasks:
    - name: Deploy canary version
      include_tasks: tasks/deploy_canary.yml
      vars:
        version: "{{ application_version }}"
        percentage: "{{ canary_percentage }}"

    - name: Configure traffic splitting
      include_tasks: tasks/configure_traffic_split.yml
      vars:
        canary_traffic: "{{ canary_percentage }}"
        stable_traffic: "{{ 100 - canary_percentage }}"

    - name: Start automated canary analysis
      include_tasks: tasks/canary_analysis.yml
      vars:
        analysis_phase: "initial"
        traffic_percentage: "{{ canary_percentage }}"

    - name: Progressively increase canary traffic
      include_tasks: tasks/progressive_rollout.yml
      when: canary_analysis_result.success | default(false)

    - name: Finalize deployment or rollback
      include_tasks: tasks/finalize_canary.yml
      vars:
        final_decision: "{{ canary_final_decision }}"

# Automated canary analysis tasks
- name: Canary Analysis and Decision Making
  include_tasks: tasks/canary_analysis.yml
  vars:
    metrics_to_analyze:
      - name: "success_rate"
        query: "rate(http_requests_total{status!~'5..'}[5m]) / rate(http_requests_total[5m])"
        threshold: "{{ success_threshold }}"
        comparison: "greater_than"
      - name: "response_time_p99"
        query: "histogram_quantile(0.99, rate(http_request_duration_seconds_bucket[5m]))"
        threshold: "{{ response_time_threshold | default(1.0) }}"
        comparison: "less_than"
      - name: "error_rate"
        query: "rate(http_requests_total{status=~'5..'}[5m]) / rate(http_requests_total[5m])"
        threshold: "{{ error_rate_threshold | default(0.05) }}"
        comparison: "less_than"
CANARY_PLAYBOOK_EOF

    # Create canary analysis tasks
    cat > playbooks/deployment/canary/tasks/canary_analysis.yml << 'CANARY_ANALYSIS_EOF'
---
- name: Query Prometheus for canary metrics
  uri:
    url: "{{ prometheus_url }}/api/v1/query"
    method: GET
    body_format: form-urlencoded
    body:
      query: "{{ item.query }}"
    return_content: true
  register: metric_query_result
  loop: "{{ metrics_to_analyze }}"
  loop_control:
    label: "{{ item.name }}"

- name: Analyze canary metrics
  set_fact:
    metric_analysis: "{{ metric_analysis | default([]) + [analysis_result] }}"
  vars:
    query_result: "{{ metric_query_result.results[ansible_loop.index0] }}"
    metric_value: "{{ query_result.json.data.result[0].value[1] | float if query_result.json.data.result | length > 0 else 0 }}"
    analysis_result:
      name: "{{ item.name }}"
      value: "{{ metric_value }}"
      threshold: "{{ item.threshold }}"
      comparison: "{{ item.comparison }}"
      passed: "{{
        (item.comparison == 'greater_than' and metric_value > item.threshold) or
        (item.comparison == 'less_than' and metric_value < item.threshold)
      }}"
  loop: "{{ metrics_to_analyze }}"

- name: Calculate overall canary health score
  set_fact:
    canary_health_score: "{{ (metric_analysis | selectattr('passed') | list | length) / (metric_analysis | length) }}"
    canary_analysis_result:
      success: "{{ (metric_analysis | selectattr('passed') | list | length) == (metric_analysis | length) }}"
      health_score: "{{ (metric_analysis | selectattr('passed') | list | length) / (metric_analysis | length) }}"
      metrics: "{{ metric_analysis }}"
      timestamp: "{{ ansible_date_time.iso8601 }}"

- name: Log canary analysis results
  debug:
    msg: |
      Canary Analysis Results:
      Health Score: {{ canary_health_score * 100 }}%
      Overall Success: {{ canary_analysis_result.success }}
      Metrics Analysis: {{ metric_analysis }}

- name: Make deployment decision
  set_fact:
    canary_decision: "{{ 'proceed' if canary_analysis_result.success else 'rollback' }}"

- name: Send canary analysis notification
  uri:
    url: "{{ webhook_url }}"
    method: POST
    headers:
      Content-Type: "application/json"
    body_format: json
    body:
      text: |
        🔍 **Canary Analysis Results**

        Application: {{ application_name }}
        Version: {{ application_version }}
        Traffic Percentage: {{ traffic_percentage }}%
        Health Score: {{ (canary_health_score * 100) | round(1) }}%
        Decision: {{ canary_decision | upper }}

        Metrics Results:
        {% for metric in metric_analysis %}
        • {{ metric.name }}: {{ metric.value }} ({{ 'PASS' if metric.passed else 'FAIL' }})
        {% endfor %}
      username: "Canary Deployment Bot"
  when: webhook_url is defined
CANARY_ANALYSIS_EOF

    log "✓ Canary deployment automation created"
}

# Create rolling update automation
create_rolling_update() {
    log "Creating rolling update automation..."

    cat > playbooks/deployment/rolling/main.yml << 'ROLLING_PLAYBOOK_EOF'
---
- name: Rolling Update Deployment
  hosts: "{{ target_group }}"
  serial: "{{ rolling_batch_size | default('25%') }}"
  max_fail_percentage: "{{ max_failure_percentage | default(10) }}"
  gather_facts: true

  pre_tasks:
    - name: Remove host from load balancer
      uri:
        url: "{{ load_balancer_api }}/api/v1/backends/{{ backend_name }}/servers/{{ ansible_hostname }}"
        method: DELETE
        headers:
          Authorization: "Bearer {{ lb_api_token }}"
        status_code: [200, 404]
      delegate_to: localhost

    - name: Wait for connections to drain
      wait_for:
        timeout: "{{ connection_drain_timeout | default(30) }}"

    - name: Verify no active connections
      shell: "netstat -an | grep :{{ application_port }} | grep ESTABLISHED | wc -l"
      register: active_connections
      until: active_connections.stdout | int == 0
      retries: 10
      delay: 5

  tasks:
    - name: Stop application services
      systemd:
        name: "{{ item }}"
        state: stopped
      loop: "{{ application_services }}"
      register: service_stop_result

    - name: Backup current application
      archive:
        path: "{{ application_path }}"
        dest: "/backup/{{ application_name }}-{{ ansible_date_time.epoch }}.tar.gz"
        format: gz
      when: backup_before_update | default(true)

    - name: Deploy new application version
      unarchive:
        src: "{{ artifact_url }}"
        dest: "{{ application_path }}"
        remote_src: true
        owner: "{{ application_user }}"
        group: "{{ application_group }}"
        mode: '0755'
      notify: restart application

    - name: Update application configuration
      template:
        src: "{{ item.src }}"
        dest: "{{ item.dest }}"
        backup: true
      loop: "{{ application_configs }}"
      notify: restart application

    - name: Run database migrations
      command: "{{ migration_command }}"
      args:
        chdir: "{{ application_path }}"
      environment: "{{ application_environment }}"
      when: run_migrations | default(false)
      run_once: true

    - name: Start application services
      systemd:
        name: "{{ item }}"
        state: started
        enabled: true
      loop: "{{ application_services }}"

  post_tasks:
    - name: Wait for application to be ready
      uri:
        url: "http://{{ ansible_default_ipv4.address }}:{{ application_port }}/health"
        method: GET
        status_code: 200
      register: health_check
      until: health_check.status == 200
      retries: 30
      delay: 10

    - name: Run application smoke tests
      command: "{{ smoke_test_command }}"
      args:
        chdir: "{{ application_path }}"
      when: smoke_test_command is defined

    - name: Add host back to load balancer
      uri:
        url: "{{ load_balancer_api }}/api/v1/backends/{{ backend_name }}/servers"
        method: POST
        headers:
          Authorization: "Bearer {{ lb_api_token }}"
          Content-Type: "application/json"
        body_format: json
        body:
          name: "{{ ansible_hostname }}"
          address: "{{ ansible_default_ipv4.address }}"
          port: "{{ application_port }}"
          weight: "{{ server_weight | default(100) }}"
        status_code: [200, 201]
      delegate_to: localhost

    - name: Verify host is healthy in load balancer
      uri:
        url: "{{ load_balancer_api }}/api/v1/backends/{{ backend_name }}/servers/{{ ansible_hostname }}/health"
        method: GET
        headers:
          Authorization: "Bearer {{ lb_api_token }}"
      register: lb_health_check
      until: lb_health_check.json.status == "healthy"
      retries: 10
      delay: 5
      delegate_to: localhost
ROLLING_PLAYBOOK_EOF

    log "✓ Rolling update automation created"
}

# Create comprehensive deployment orchestration
create_deployment_orchestration() {
    log "Creating deployment orchestration framework..."

    cat > playbooks/deployment/orchestration.yml << 'ORCHESTRATION_PLAYBOOK_EOF'
---
- name: Enterprise Deployment Orchestration
  hosts: localhost
  gather_facts: false
  vars:
    deployment_strategies:
      - name: "blue-green"
        playbook: "blue-green/main.yml"
        suitable_for: ["web_applications", "apis", "microservices"]
      - name: "canary"
        playbook: "canary/main.yml"
        suitable_for: ["high_traffic_apps", "critical_services"]
      - name: "rolling"
        playbook: "rolling/main.yml"
        suitable_for: ["stateful_services", "databases", "batch_jobs"]
      - name: "recreate"
        playbook: "recreate/main.yml"
        suitable_for: ["dev_environments", "legacy_applications"]

  tasks:
    - name: Validate deployment request
      assert:
        that:
          - application_name is defined
          - application_version is defined
          - target_environment is defined
          - deployment_strategy in deployment_strategies | map(attribute='name') | list
        fail_msg: "Required deployment parameters missing or invalid"

    - name: Get application deployment configuration
      uri:
        url: "{{ deployment_config_api }}/api/v1/applications/{{ application_name }}/config"
        method: GET
        headers:
          Authorization: "Bearer {{ deployment_api_token }}"
      register: app_config

    - name: Determine optimal deployment strategy
      set_fact:
        selected_strategy: "{{ deployment_strategy if deployment_strategy != 'auto' else optimal_strategy }}"
      vars:
        app_characteristics: "{{ app_config.json.characteristics }}"
        optimal_strategy: "{{ deployment_strategies | selectattr('suitable_for', 'intersect', app_characteristics) | map(attribute='name') | first }}"

    - name: Create deployment record
      uri:
        url: "{{ deployment_tracking_api }}/api/v1/deployments"
        method: POST
        headers:
          Authorization: "Bearer {{ deployment_api_token }}"
          Content-Type: "application/json"
        body_format: json
        body:
          application_name: "{{ application_name }}"
          version: "{{ application_version }}"
          environment: "{{ target_environment }}"
          strategy: "{{ selected_strategy }}"
          initiated_by: "{{ ansible_user }}"
          initiated_at: "{{ ansible_date_time.iso8601 }}"
          status: "in_progress"
      register: deployment_record

    - name: Execute deployment strategy
      include: "{{ deployment_strategies | selectattr('name', 'equalto', selected_strategy) | map(attribute='playbook') | first }}"
      vars:
        deployment_id: "{{ deployment_record.json.id }}"

    - name: Update deployment record with results
      uri:
        url: "{{ deployment_tracking_api }}/api/v1/deployments/{{ deployment_record.json.id }}"
        method: PUT
        headers:
          Authorization: "Bearer {{ deployment_api_token }}"
          Content-Type: "application/json"
        body_format: json
        body:
          status: "{{ deployment_status | default('completed') }}"
          completed_at: "{{ ansible_date_time.iso8601 }}"
          success: "{{ deployment_success | default(true) }}"
          logs_url: "{{ deployment_logs_url | default('') }}"
          metrics: "{{ deployment_metrics | default({}) }}"
ORCHESTRATION_PLAYBOOK_EOF

    log "✓ Deployment orchestration framework created"
}

# Main deployment patterns setup
main() {
    log "Setting up enterprise deployment patterns..."
    log "Deployment Strategy: ${DEPLOYMENT_STRATEGY}"
    log "Health Check Timeout: ${HEALTH_CHECK_TIMEOUT}"
    log "Rollback Enabled: ${ROLLBACK_ENABLED}"

    create_blue_green_playbook
    create_canary_deployment
    create_rolling_update
    create_deployment_orchestration

    log "Enterprise deployment patterns setup completed!"
    log ""
    log "Available deployment strategies:"
    log "• Blue-Green: Zero downtime with full environment switch"
    log "• Canary: Gradual rollout with automated analysis"
    log "• Rolling: Sequential updates with health checks"
    log "• Recreate: Full replacement for development environments"
    log ""
    log "Features included:"
    log "• Automated health checks and validation"
    log "• Traffic switching and load balancer integration"
    log "• Rollback automation on failure"
    log "• Metrics-based deployment decisions"
    log "• Integration with monitoring and alerting"
}

# Execute if run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi