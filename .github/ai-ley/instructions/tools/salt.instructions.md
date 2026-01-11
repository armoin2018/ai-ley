---
name: 'salt.instructions'
description: 'Development guidelines and best practices for Salt.Instructions'
keywords: [alerting, agent, /srv/pillar/base/webserver.sls, backup, architecture, authentication, backend, avoid, /srv/salt/base/webserver/init.sls, certificate]
---



# SaltStack Enterprise Configuration Management Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive enterprise-grade guidance for AI agents implementing SaltStack configuration management and orchestration solutions, emphasizing scalable automation, event-driven infrastructure, secure state management, and production deployment patterns with advanced monitoring, compliance frameworks, and multi-cloud orchestration capabilities.

### When to Use SaltStack

- **Large-scale infrastructure** requiring event-driven automation with real-time orchestration
- **Configuration management** across diverse operating systems with unified control plane
- **Remote execution** for immediate infrastructure operations with enterprise security
- **Event-driven automation** requiring reactive infrastructure management and self-healing systems
- **Multi-cloud orchestration** with consistent configuration management across providers
- **High-performance environments** needing fast execution and scalable architecture
- **Enterprise deployments** requiring compliance automation and audit trails
- **IoT and edge computing** scenarios with intermittent connectivity and distributed management
- **DevOps workflows** integrating with CI/CD pipelines and infrastructure automation
- **Hybrid cloud environments** managing on-premises and cloud infrastructure uniformly

### When to Avoid SaltStack

- **Simple, small-scale** deployments where Ansible might be more appropriate
- **Pure declarative** infrastructure requirements better suited for Terraform
- **Windows-heavy** environments where native tools might be preferred
- **Resource-constrained** environments where agent overhead is problematic

### Architecture Essentials

- **Master-Minion Architecture**: Scalable ZeroMQ-based communication with high-availability clustering
- **Event-Driven System**: Real-time event bus with reactive automation and self-healing capabilities
- **State System**: Declarative configuration management with idempotent operations
- **Pillar System**: Secure data management with encrypted secrets and hierarchical inheritance
- **Grain System**: Dynamic host discovery with custom facts and targeting capabilities
- **Beacon and Reactor**: Event monitoring and automated response with intelligent remediation
- **Salt SSH**: Agentless execution for restricted environments with enterprise authentication
- **Cloud Integration**: Multi-cloud provisioning and management with provider abstraction

## Enterprise SaltStack Management Framework

`See [example-1](./examples/salt/example-1.python)yaml
# /srv/salt/base/webserver/init.sls - Enterprise web server state
{% set webserver_config = pillar.get('webserver', {}) %}
{% set environment = grains.get('environment', 'dev') %}
{% set datacenter = grains.get('datacenter', 'default') %}

include:

nginx:
  pkg.installed:
    
  service.running:
                    
nginx_config:
  file.managed:
                worker_processes: {{ grains.get('num_cpus', 2) }}
        worker_connections: {{ webserver_config.get('worker_connections', 1024) }}
        environment: {{ environment }}
        datacenter: {{ datacenter }}
              
# SSL Certificate Management
ssl_cert:
  file.managed:
                  
ssl_key:
  file.managed:
                    
# Firewall Configuration
nginx_firewall:
  firewalld.present:
                  
# Log Rotation
nginx_logrotate:
  file.managed:
          
# Health Check Script
nginx_healthcheck:
  file.managed:
                domain: {{ webserver_config.get('domain', 'localhost') }}
      
# Cron for Health Monitoring
nginx_health_cron:
  cron.present:
            
# Performance Tuning
nginx_sysctl:
  sysctl.present:
      
# Backup Configuration
nginx_config_backup:
  cron.present:
        `See [example-2](./examples/salt/example-2.txt)yaml
# /srv/pillar/base/webserver.sls - Enterprise pillar data
webserver:
  nginx_version: '1.20.1'
  worker_connections: 4096
  domain: 'app.example.com'

  # Environment-specific settings
  {% if grains.get('environment') == 'prod' %}
  max_clients: 8192
  keepalive_timeout: 65
  gzip_enabled: true
  ssl_protocols: 'TLSv1.2 TLSv1.3'
  {% elif grains.get('environment') == 'staging' %}
  max_clients: 2048
  keepalive_timeout: 30
  gzip_enabled: true
  ssl_protocols: 'TLSv1.2 TLSv1.3'
  {% else %}
  max_clients: 512
  keepalive_timeout: 15
  gzip_enabled: false
  ssl_protocols: 'TLSv1.2'
  {% endif %}

  # Security settings
  security:
    hide_version: true
    server_tokens: off
    client_max_body_size: '10m'
    rate_limiting:
      enabled: true
      requests_per_minute: 300

  # Monitoring endpoints
  monitoring:
    status_endpoint: '/nginx_status'
    metrics_endpoint: '/metrics'
    health_endpoint: '/health'

  # Load balancing configuration
  upstream:
    backend_servers:
      {% for server in pillar.get('app_servers', []) %}
            weight: {{ server.get('weight', 1) }}
        max_fails: {{ server.get('max_fails', 3) }}
        fail_timeout: {{ server.get('fail_timeout', '30s') }}
      {% endfor %}

# Database configuration with encrypted secrets
database:
  postgresql:
    version: '13'
    port: 5432
    max_connections: 200
    shared_buffers: '256MB'
    effective_cache_size: '1GB'

    # Encrypted credentials (using Salt's encryption)
    users:
      app_user:
        password: |
          -----BEGIN PGP MESSAGE-----
          encrypted_password_here
          -----END PGP MESSAGE-----
        privileges:
                
    databases:
            owner: 'app_user'
        encoding: 'UTF8'
        lc_collate: 'en_US.UTF-8'
        lc_ctype: 'en_US.UTF-8'

    # Backup configuration
    backup:
      enabled: true
      schedule: '0 2 * * *'
      retention_days: 30
      s3_bucket: 'backup-bucket-{{ grains.get('environment') }}'
      encryption_key: |
        -----BEGIN PGP MESSAGE-----
        encrypted_backup_key_here
        -----END PGP MESSAGE-----

# Monitoring and alerting configuration
monitoring:
  prometheus:
    enabled: true
    port: 9100
    scrape_interval: '15s'
    metrics_path: '/metrics'

    # Alert thresholds
    alerts:
      high_cpu: 80
      high_memory: 85
      disk_usage: 90
      response_time: 5000
      error_rate: 5

  grafana:
    enabled: true
    admin_password: |
      -----BEGIN PGP MESSAGE-----
      encrypted_grafana_password_here
      -----END PGP MESSAGE-----
    datasources:
            type: 'prometheus'
        url: 'http://prometheus:9090'
        access: 'proxy'
        is_default: true

# Security and compliance settings
security:
  hardening:
    enabled: true
    cis_compliance: true
    automatic_updates: true
    fail2ban: true

    # SSH configuration
    ssh:
      port: 2222
      root_login: false
      password_auth: false
      key_auth: true
      max_auth_tries: 3

    # Firewall rules
    firewall:
      default_policy: 'drop'

*Content optimized for conciseness. See external references for additional details.*

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
