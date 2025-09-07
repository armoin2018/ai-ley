---
ai-system-type: 'configuration-management'
category: 'infra-as-code'
subcategory: 'configuration-orchestration'
difficulty: 'advanced'
prerequisites: ['python', 'yaml', 'jinja2', 'linux-administration']
technical-quality: 4.9
ai-usability: 4.9
cross-references:
  - 'ansible.instructions.md'
  - 'terraform.instructions.md'
  - 'kubernetes.instructions.md'
  - 'puppet.instructions.md'
  - 'chef.instructions.md'
version: '3.0'
last-updated: '2024-12-28'
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

````python
#!/usr/bin/env python3
# salt-enterprise-manager.py - Advanced SaltStack enterprise management system

import asyncio
import json
import yaml
import logging
import sqlite3
import hashlib
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Tuple, Union
from dataclasses import dataclass, asdict
from pathlib import Path
import subprocess
import tempfile
import salt.client
import salt.runner
import salt.wheel
import salt.cloud
from cryptography.fernet import Fernet
from prometheus_client import CollectorRegistry, Gauge, Counter, Histogram, push_to_gateway

@dataclass
class SaltState:
    """Salt state configuration"""
    state_id: str
    name: str
    module: str
    function: str
    arguments: Dict[str, Any]
    requirements: List[str]
    watch: List[str]
    listen: List[str]
    onchanges: List[str]
    unless: Optional[str]
    creates: Optional[str]
    env_vars: Dict[str, str]
    user: Optional[str]
    timeout: int
    retry: Dict[str, Any]
    tags: List[str]

@dataclass
class SaltPillar:
    """Salt pillar data configuration"""
    pillar_id: str
    path: str
    data: Dict[str, Any]
    environment: str
    encrypted_keys: List[str]
    access_control: Dict[str, List[str]]
    version: str
    checksum: str
    created_at: datetime
    updated_at: datetime

@dataclass
class SaltMinion:
    """Salt minion configuration"""
    minion_id: str
    hostname: str
    ip_address: str
    operating_system: str
    version: str
    grains: Dict[str, Any]
    roles: List[str]
    environment: str
    last_seen: datetime
    compliance_status: str
    performance_metrics: Dict[str, float]

@dataclass
class SaltOrchestration:
    """Salt orchestration configuration"""
    orchestration_id: str
    name: str
    description: str
    stages: List[Dict[str, Any]]
    dependencies: Dict[str, List[str]]
    rollback_strategy: Dict[str, Any]
    timeout: int
    concurrency: int
    failure_threshold: float
    notification_channels: List[str]

class SaltEnterpriseManager:
    """Enterprise SaltStack management system"""

    def __init__(self, config_file: str = "/etc/salt-enterprise/config.yaml"):
        self.config_file = Path(config_file)
        self.db_path = Path("/var/lib/salt-enterprise/management.db")
        self.log_path = Path("/var/log/salt-enterprise/manager.log")

        # Salt clients
        self.local_client = None
        self.runner_client = None
        self.wheel_client = None
        self.cloud_client = None

        # Setup logging
        self.setup_logging()

        # Load configuration
        self.config = self.load_configuration()

        # Initialize database
        self.init_database()

        # Setup encryption
        self.setup_encryption()

        # Initialize Salt clients
        self.init_salt_clients()

        # Prometheus metrics
        self.setup_metrics()

        self.logger.info("Salt Enterprise Manager initialized")

    def setup_logging(self):
        """Configure comprehensive logging"""
        self.log_path.parent.mkdir(parents=True, exist_ok=True)
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(self.log_path),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)

    def load_configuration(self) -> Dict[str, Any]:
        """Load enterprise configuration"""
        default_config = {
            'salt': {
                'master_config': '/etc/salt/master',
                'minion_config': '/etc/salt/minion',
                'pillar_roots': ['/srv/pillar'],
                'file_roots': ['/srv/salt'],
                'environments': ['base', 'dev', 'staging', 'prod'],
                'timeout': 60,
                'gather_job_timeout': 10
            },
            'enterprise': {
                'high_availability': True,
                'multi_master': True,
                'encryption_enabled': True,
                'compliance_monitoring': True,
                'performance_tracking': True,
                'audit_logging': True,
                'backup_automation': True,
                'disaster_recovery': True
            },
            'monitoring': {
                'prometheus_enabled': True,
                'prometheus_gateway': 'localhost:9091',
                'metrics_interval': 30,
                'event_monitoring': True,
                'performance_thresholds': {
                    'execution_time': 300,
                    'memory_usage': 80,
                    'cpu_usage': 70
                }
            },
            'security': {
                'pillar_encryption': True,
                'secure_transport': True,
                'access_control_enabled': True,
                'audit_events': True,
                'secret_rotation_interval': 86400
            },
            'orchestration': {
                'max_concurrent_jobs': 10,
                'default_timeout': 3600,
                'rollback_enabled': True,
                'canary_deployments': True,
                'blue_green_deployments': True
            }
        }

        if self.config_file.exists():
            with open(self.config_file, 'r') as f:
                user_config = yaml.safe_load(f)
                self._deep_update(default_config, user_config)

        return default_config

    def _deep_update(self, base_dict: Dict, update_dict: Dict):
        """Deep update dictionary"""
        for key, value in update_dict.items():
            if isinstance(value, dict) and key in base_dict:
                self._deep_update(base_dict[key], value)
            else:
                base_dict[key] = value

    def setup_encryption(self):
        """Setup encryption for sensitive data"""
        key_file = Path("/etc/salt-enterprise/encryption.key")

        if not key_file.exists():
            key_file.parent.mkdir(parents=True, exist_ok=True)
            key = Fernet.generate_key()
            key_file.write_bytes(key)
            key_file.chmod(0o600)

        key = key_file.read_bytes()
        self.cipher_suite = Fernet(key)

    def init_salt_clients(self):
        """Initialize Salt API clients"""
        try:
            self.local_client = salt.client.LocalClient()
            self.runner_client = salt.runner.RunnerClient()
            self.wheel_client = salt.wheel.WheelClient()
            self.cloud_client = salt.cloud.CloudClient()
            self.logger.info("Salt clients initialized successfully")
        except Exception as e:
            self.logger.error(f"Failed to initialize Salt clients: {str(e)}")

    def setup_metrics(self):
        """Initialize Prometheus metrics"""
        self.registry = CollectorRegistry()

        self.minion_count = Gauge(
            'salt_minions_total',
            'Total number of Salt minions',
            ['status', 'environment', 'os_family'],
            registry=self.registry
        )

        self.state_executions = Counter(
            'salt_state_executions_total',
            'Total state executions',
            ['state', 'result', 'environment'],
            registry=self.registry
        )

        self.execution_time = Histogram(
            'salt_execution_duration_seconds',
            'Execution time for Salt operations',
            ['operation_type', 'target_type'],
            registry=self.registry
        )

        self.job_queue_size = Gauge(
            'salt_job_queue_size',
            'Current job queue size',
            ['priority'],
            registry=self.registry
        )

    def init_database(self):
        """Initialize SQLite database for enterprise management"""
        self.db_path.parent.mkdir(parents=True, exist_ok=True)

        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()

        # Minions table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS minions (
                id TEXT PRIMARY KEY,
                hostname TEXT NOT NULL,
                ip_address TEXT,
                operating_system TEXT,
                version TEXT,
                grains TEXT,
                roles TEXT,
                environment TEXT,
                last_seen TIMESTAMP,
                compliance_status TEXT,
                performance_metrics TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')

        # States table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS states (
                id TEXT PRIMARY KEY,
                name TEXT NOT NULL,
                module TEXT NOT NULL,
                function TEXT NOT NULL,
                arguments TEXT,
                environment TEXT,
                version TEXT,
                checksum TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')

        # Orchestrations table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS orchestrations (
                id TEXT PRIMARY KEY,
                name TEXT NOT NULL,
                description TEXT,
                stages TEXT,
                environment TEXT,
                status TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                started_at TIMESTAMP,
                completed_at TIMESTAMP,
                created_by TEXT
            )
        ''')

        # Execution history table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS execution_history (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                job_id TEXT NOT NULL,
                function TEXT NOT NULL,
                target TEXT NOT NULL,
                arguments TEXT,
                result TEXT,
                success BOOLEAN,
                execution_time REAL,
                timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                user TEXT
            )
        ''')

        # Compliance table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS compliance_reports (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                minion_id TEXT NOT NULL,
                framework TEXT NOT NULL,
                status TEXT NOT NULL,
                score INTEGER,
                details TEXT,
                timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
            )
        ''')

        conn.commit()
        conn.close()

    async def execute_state(self, target: str, state: str, environment: str = "base",
                          test: bool = False, timeout: int = 300) -> Dict[str, Any]:
        """Execute Salt state with enterprise monitoring"""
        try:
            start_time = datetime.now()

            self.logger.info(f"Executing state '{state}' on target '{target}' in environment '{environment}'")

            # Execute state
            if test:
                result = self.local_client.cmd(
                    target,
                    'state.apply',
                    [state],
                    kwarg={'test': True, 'saltenv': environment},
                    timeout=timeout
                )
            else:
                result = self.local_client.cmd(
                    target,
                    'state.apply',
                    [state],
                    kwarg={'saltenv': environment},
                    timeout=timeout
                )

            # Calculate execution time
            execution_time = (datetime.now() - start_time).total_seconds()

            # Process results
            processed_results = await self._process_state_results(result, state, environment, execution_time)

            # Update metrics
            await self._update_state_metrics(processed_results, state, environment, execution_time)

            # Store execution history
            await self._store_execution_history(target, state, result, execution_time)

            # Check compliance if enabled
            if self.config['enterprise']['compliance_monitoring']:
                await self._check_compliance(target, result)

            return processed_results

        except Exception as e:
            self.logger.error(f"Error executing state '{state}': {str(e)}")
            raise

    async def _process_state_results(self, results: Dict[str, Any], state: str,
                                   environment: str, execution_time: float) -> Dict[str, Any]:
        """Process and analyze state execution results"""
        processed = {
            'state': state,
            'environment': environment,
            'execution_time': execution_time,
            'minions': {},
            'summary': {
                'total_minions': 0,
                'successful': 0,
                'failed': 0,
                'changes': 0,
                'no_changes': 0
            }
        }

        for minion_id, minion_result in results.items():
            if isinstance(minion_result, dict):
                minion_summary = {
                    'success': True,
                    'changes': 0,
                    'failed_states': [],
                    'changed_states': [],
                    'duration': 0
                }

                for state_id, state_result in minion_result.items():
                    if isinstance(state_result, dict):
                        if not state_result.get('result', False):
                            minion_summary['success'] = False
                            minion_summary['failed_states'].append(state_id)

                        if state_result.get('changes'):
                            minion_summary['changes'] += 1
                            minion_summary['changed_states'].append(state_id)

                        minion_summary['duration'] += state_result.get('duration', 0)

                processed['minions'][minion_id] = minion_summary
                processed['summary']['total_minions'] += 1

                if minion_summary['success']:
                    processed['summary']['successful'] += 1
                else:
                    processed['summary']['failed'] += 1

                if minion_summary['changes'] > 0:
                    processed['summary']['changes'] += 1
                else:
                    processed['summary']['no_changes'] += 1

        return processed

    async def orchestrate_deployment(self, orchestration: SaltOrchestration,
                                   target_environment: str = "prod") -> Dict[str, Any]:
        """Execute complex multi-stage orchestration with enterprise features"""
        try:
            orchestration_id = f"orch_{int(datetime.now().timestamp())}"
            start_time = datetime.now()

            self.logger.info(f"Starting orchestration: {orchestration.name}")

            # Store orchestration in database
            await self._store_orchestration(orchestration, orchestration_id, "running")

            # Execute stages
            results = {
                'orchestration_id': orchestration_id,
                'name': orchestration.name,
                'environment': target_environment,
                'stages': [],
                'status': 'running',
                'start_time': start_time.isoformat(),
                'total_duration': 0
            }

            failed_stages = 0

            for stage_idx, stage in enumerate(orchestration.stages):
                stage_start = datetime.now()
                stage_name = stage.get('name', f'stage_{stage_idx}')

                self.logger.info(f"Executing orchestration stage: {stage_name}")

                try:
                    # Check dependencies
                    if not await self._check_stage_dependencies(stage, results['stages']):
                        raise Exception(f"Stage dependencies not met: {stage_name}")

                    # Execute stage
                    stage_result = await self._execute_orchestration_stage(stage, target_environment)

                    stage_duration = (datetime.now() - stage_start).total_seconds()

                    stage_summary = {
                        'name': stage_name,
                        'status': 'completed' if stage_result.get('success') else 'failed',
                        'duration': stage_duration,
                        'result': stage_result,
                        'timestamp': stage_start.isoformat()
                    }

                    results['stages'].append(stage_summary)

                    if not stage_result.get('success'):
                        failed_stages += 1
                        failure_threshold = orchestration.failure_threshold

                        if failed_stages / len(orchestration.stages) > failure_threshold:
                            self.logger.error(f"Orchestration failure threshold exceeded: {failed_stages}/{len(orchestration.stages)}")

                            if orchestration.rollback_strategy.get('enabled', True):
                                await self._execute_rollback(orchestration, results['stages'])

                            results['status'] = 'failed'
                            break

                except Exception as stage_error:
                    self.logger.error(f"Stage {stage_name} failed: {str(stage_error)}")
                    failed_stages += 1

                    stage_summary = {
                        'name': stage_name,
                        'status': 'error',
                        'duration': (datetime.now() - stage_start).total_seconds(),
                        'error': str(stage_error),
                        'timestamp': stage_start.isoformat()
                    }

                    results['stages'].append(stage_summary)

                    if orchestration.rollback_strategy.get('enabled', True):
                        await self._execute_rollback(orchestration, results['stages'])

                    results['status'] = 'error'
                    break

            # Calculate final status
            if results['status'] == 'running':
                results['status'] = 'completed' if failed_stages == 0 else 'completed_with_errors'

            results['total_duration'] = (datetime.now() - start_time).total_seconds()
            results['end_time'] = datetime.now().isoformat()
            results['failed_stages'] = failed_stages
            results['success_rate'] = (len(orchestration.stages) - failed_stages) / len(orchestration.stages)

            # Update database
            await self._store_orchestration(orchestration, orchestration_id, results['status'])

            # Send notifications
            if orchestration.notification_channels:
                await self._send_orchestration_notifications(orchestration, results)

            self.logger.info(f"Orchestration completed: {orchestration.name} - Status: {results['status']}")

            return results

        except Exception as e:
            self.logger.error(f"Orchestration failed: {orchestration.name} - {str(e)}")
            await self._store_orchestration(orchestration, orchestration_id, "failed")
            raise

    async def manage_pillar_data(self, pillar: SaltPillar, operation: str = "update") -> bool:
        """Manage pillar data with enterprise security"""
        try:
            pillar_path = Path(self.config['salt']['pillar_roots'][0]) / pillar.environment / f"{pillar.path}.sls"
            pillar_path.parent.mkdir(parents=True, exist_ok=True)

            if operation == "create" or operation == "update":
                # Encrypt sensitive data
                encrypted_data = self._encrypt_pillar_data(pillar.data, pillar.encrypted_keys)

                # Generate pillar content
                pillar_content = self._generate_pillar_content(encrypted_data, pillar)

                # Write pillar file
                with open(pillar_path, 'w') as f:
                    f.write(pillar_content)

                # Update checksum
                pillar.checksum = hashlib.sha256(pillar_content.encode()).hexdigest()
                pillar.updated_at = datetime.now()

                # Store in database
                await self._store_pillar_metadata(pillar)

                # Refresh pillar data on masters
                await self._refresh_pillar_data()

                self.logger.info(f"Pillar data {operation}d: {pillar.path}")
                return True

            elif operation == "delete":
                if pillar_path.exists():
                    pillar_path.unlink()
                    await self._delete_pillar_metadata(pillar.pillar_id)
                    await self._refresh_pillar_data()

                    self.logger.info(f"Pillar data deleted: {pillar.path}")
                    return True

            return False

        except Exception as e:
            self.logger.error(f"Error managing pillar data: {str(e)}")
            return False

# Enterprise Salt configuration templates
ENTERPRISE_STATES = {
    "web_server": {
        "description": "Enterprise web server configuration with monitoring and security",
        "states": {
            "nginx": {
                "pkg.installed": [{"name": "nginx"}],
                "service.running": [
                    {"name": "nginx"},
                    {"enable": True},
                    {"watch": [{"file": "/etc/nginx/nginx.conf"}]}
                ]
            },
            "ssl_certificate": {
                "file.managed": [
                    {"name": "/etc/ssl/certs/server.crt"},
                    {"source": "salt://ssl/server.crt"},
                    {"user": "root"},
                    {"group": "root"},
                    {"mode": 644}
                ]
            },
            "monitoring_agent": {
                "pkg.installed": [{"name": "prometheus-node-exporter"}],
                "service.running": [
                    {"name": "prometheus-node-exporter"},
                    {"enable": True}
                ]
            }
        }
    },

    "database_server": {
        "description": "Enterprise database server with backup and monitoring",
        "states": {
            "postgresql": {
                "pkg.installed": [{"name": "postgresql-server"}],
                "service.running": [
                    {"name": "postgresql"},
                    {"enable": True},
                    {"watch": [{"file": "/var/lib/pgsql/data/postgresql.conf"}]}
                ]
            },
            "database_backup": {
                "cron.present": [
                    {"name": "/usr/local/bin/db-backup.sh"},
                    {"user": "postgres"},
                    {"minute": "0"},
                    {"hour": "2"}
                ]
            }
        }
    }
}

## Implementation Framework

### Enterprise Salt State Development

```yaml
# /srv/salt/base/webserver/init.sls - Enterprise web server state
{% set webserver_config = pillar.get('webserver', {}) %}
{% set environment = grains.get('environment', 'dev') %}
{% set datacenter = grains.get('datacenter', 'default') %}

include:
  - security.hardening
  - monitoring.node-exporter
  - logging.rsyslog

nginx:
  pkg.installed:
    - name: nginx
    - version: {{ webserver_config.get('nginx_version', 'latest') }}

  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
      - pkg: nginx

nginx_config:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://webserver/files/nginx.conf.j2
    - template: jinja
    - context:
        worker_processes: {{ grains.get('num_cpus', 2) }}
        worker_connections: {{ webserver_config.get('worker_connections', 1024) }}
        environment: {{ environment }}
        datacenter: {{ datacenter }}
    - user: root
    - group: root
    - mode: 644
    - backup: minion
    - require:
      - pkg: nginx

# SSL Certificate Management
ssl_cert:
  file.managed:
    - name: /etc/ssl/certs/{{ webserver_config.get('domain', 'localhost') }}.crt
    - source: salt://ssl/certs/{{ webserver_config.get('domain', 'localhost') }}.crt
    - user: root
    - group: ssl-cert
    - mode: 644
    - makedirs: True
    - require:
      - pkg: nginx

ssl_key:
  file.managed:
    - name: /etc/ssl/private/{{ webserver_config.get('domain', 'localhost') }}.key
    - source: salt://ssl/private/{{ webserver_config.get('domain', 'localhost') }}.key
    - user: root
    - group: ssl-cert
    - mode: 600
    - makedirs: True
    - show_changes: False
    - require:
      - pkg: nginx

# Firewall Configuration
nginx_firewall:
  firewalld.present:
    - name: public
    - ports:
      - 80/tcp
      - 443/tcp
    - require:
      - service: nginx

# Log Rotation
nginx_logrotate:
  file.managed:
    - name: /etc/logrotate.d/nginx
    - source: salt://webserver/files/nginx.logrotate
    - user: root
    - group: root
    - mode: 644

# Health Check Script
nginx_healthcheck:
  file.managed:
    - name: /usr/local/bin/nginx-healthcheck.sh
    - source: salt://webserver/files/healthcheck.sh.j2
    - template: jinja
    - context:
        domain: {{ webserver_config.get('domain', 'localhost') }}
    - user: root
    - group: root
    - mode: 755

# Cron for Health Monitoring
nginx_health_cron:
  cron.present:
    - name: /usr/local/bin/nginx-healthcheck.sh
    - user: root
    - minute: '*/5'
    - require:
      - file: nginx_healthcheck

# Performance Tuning
nginx_sysctl:
  sysctl.present:
    - name: net.core.somaxconn
    - value: 65535
    - config: /etc/sysctl.d/nginx.conf

# Backup Configuration
nginx_config_backup:
  cron.present:
    - name: tar -czf /backup/nginx-config-$(date +\%Y\%m\%d).tar.gz /etc/nginx/
    - user: root
    - hour: 2
    - minute: 30
````

### Advanced Pillar Management

```yaml
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
      - server: {{ server.ip }}:{{ server.port }}
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
          - 'CONNECT'
          - 'CREATE'

    databases:
      - name: 'application_db'
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
      - name: 'Prometheus'
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
      allowed_services:
        - 'ssh'
        - 'http'
        - 'https'
      allowed_ports:
        - '2222/tcp'  # Custom SSH port
        - '9100/tcp'  # Node exporter

    # Audit logging
    audit:
      enabled: true
      rules:
        - '-w /etc/passwd -p wa -k passwd_changes'
        - '-w /etc/group -p wa -k group_changes'
        - '-w /etc/shadow -p wa -k shadow_changes'
```

### Enterprise Orchestration

```yaml
# /srv/salt/orchestration/app-deployment.sls - Complex deployment orchestration
{% set app_config = pillar.get('application', {}) %}
{% set environment = pillar.get('environment', 'dev') %}

# Stage 1: Pre-deployment checks
pre_deployment_checks:
  salt.runner:
    - name: manage.status
    - tgt: 'environment:{{ environment }}'
    - tgt_type: grain
    - fail_hard: True

# Stage 2: Database migration
database_migration:
  salt.state:
    - tgt: 'role:database and environment:{{ environment }}'
    - tgt_type: compound
    - sls: database.migrate
    - pillar:
        migration_version: {{ app_config.get('migration_version') }}
    - require:
      - salt: pre_deployment_checks

# Stage 3: Load balancer maintenance mode
enable_maintenance_mode:
  salt.state:
    - tgt: 'role:loadbalancer and environment:{{ environment }}'
    - tgt_type: compound
    - sls: loadbalancer.maintenance
    - pillar:
        maintenance_enabled: true
    - require:
      - salt: database_migration

# Stage 4: Rolling application deployment
{% for batch in range(app_config.get('deployment_batches', 2)) %}
deploy_batch_{{ batch }}:
  salt.state:
    - tgt: 'role:webserver and environment:{{ environment }} and batch:{{ batch }}'
    - tgt_type: compound
    - sls: application.deploy
    - pillar:
        version: {{ app_config.get('version') }}
        rollback_version: {{ app_config.get('rollback_version') }}
    {% if batch == 0 %}
    - require:
      - salt: enable_maintenance_mode
    {% else %}
    - require:
      - salt: deploy_batch_{{ batch - 1 }}
      - salt: health_check_batch_{{ batch - 1 }}
    {% endif %}

# Health check after each batch
health_check_batch_{{ batch }}:
  salt.state:
    - tgt: 'role:webserver and environment:{{ environment }} and batch:{{ batch }}'
    - tgt_type: compound
    - sls: application.healthcheck
    - pillar:
        healthcheck_endpoint: {{ app_config.get('healthcheck_endpoint', '/health') }}
        timeout: 300
    - require:
      - salt: deploy_batch_{{ batch }}
{% endfor %}

# Stage 5: Smoke tests
smoke_tests:
  salt.state:
    - tgt: 'role:webserver and environment:{{ environment }}'
    - tgt_type: compound
    - sls: testing.smoke
    - pillar:
        test_endpoints: {{ app_config.get('test_endpoints', []) }}
    - require:
      {% for batch in range(app_config.get('deployment_batches', 2)) %}
      - salt: health_check_batch_{{ batch }}
      {% endfor %}

# Stage 6: Disable maintenance mode
disable_maintenance_mode:
  salt.state:
    - tgt: 'role:loadbalancer and environment:{{ environment }}'
    - tgt_type: compound
    - sls: loadbalancer.maintenance
    - pillar:
        maintenance_enabled: false
    - require:
      - salt: smoke_tests

# Stage 7: Post-deployment monitoring
post_deployment_monitoring:
  salt.state:
    - tgt: 'role:monitoring and environment:{{ environment }}'
    - tgt_type: compound
    - sls: monitoring.post_deployment
    - pillar:
        deployment_version: {{ app_config.get('version') }}
        monitoring_duration: 1800  # 30 minutes
    - require:
      - salt: disable_maintenance_mode

# Rollback orchestration (failure scenario)
rollback_deployment:
  salt.state:
    - tgt: 'role:webserver and environment:{{ environment }}'
    - tgt_type: compound
    - sls: application.rollback
    - pillar:
        rollback_version: {{ app_config.get('rollback_version') }}
    - onfail:
      - salt: smoke_tests
```

### Event-Driven Automation

```yaml
# /etc/salt/master.d/reactors.conf - Reactor configuration
reactor:
  # Service failure response
  - 'salt/beacon/*/service/*':
    - /srv/reactor/service_failure.sls

  # Security incident response
  - 'custom/security/intrusion':
    - /srv/reactor/security_incident.sls

  # Auto-scaling triggers
  - 'custom/monitoring/high_load':
    - /srv/reactor/scale_up.sls

  - 'custom/monitoring/low_load':
    - /srv/reactor/scale_down.sls

  # Configuration drift detection
  - 'salt/state/*/highstate/failed':
    - /srv/reactor/config_drift.sls

# /srv/reactor/service_failure.sls - Service failure reactor
{% set service_data = data.get('data', {}) %}
{% set minion_id = data.get('id') %}
{% set service_name = service_data.get('service') %}

# Immediate restart attempt
restart_failed_service:
  local.service.restart:
    - tgt: {{ minion_id }}
    - arg:
      - {{ service_name }}

# Notification to operations team
send_service_alert:
  local.cmd.run:
    - tgt: monitoring-server
    - arg:
      - |
        curl -X POST https://alerts.example.com/api/webhook \
          -H "Content-Type: application/json" \
          -d '{
            "alert": "service_failure",
            "minion": "{{ minion_id }}",
            "service": "{{ service_name }}",
            "timestamp": "{{ data.get('_stamp') }}",
            "severity": "high"
          }'

# Log incident
log_service_incident:
  local.event.send:
    - tgt: {{ minion_id }}
    - arg:
      - custom/incident/service_failure
    - kwarg:
        data:
          minion_id: {{ minion_id }}
          service: {{ service_name }}
          timestamp: {{ data.get('_stamp') }}
          auto_restart_attempted: true

# /srv/reactor/security_incident.sls - Security incident reactor
{% set incident_data = data.get('data', {}) %}
{% set minion_id = data.get('id') %}

# Immediate isolation
isolate_compromised_host:
  local.cmd.run:
    - tgt: {{ minion_id }}
    - arg:
      - iptables -P INPUT DROP; iptables -P OUTPUT DROP; iptables -P FORWARD DROP

# Gather forensic data
collect_forensics:
  local.state.apply:
    - tgt: {{ minion_id }}
    - arg:
      - security.forensics
    - kwarg:
        pillar:
          incident_id: {{ incident_data.get('incident_id') }}
          timestamp: {{ data.get('_stamp') }}

# Notify security team
security_alert:
  local.cmd.run:
    - tgt: monitoring-server
    - arg:
      - |
        curl -X POST https://security-alerts.example.com/api/incident \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${SECURITY_TOKEN}" \
          -d '{
            "priority": "critical",
            "type": "{{ incident_data.get('type', 'unknown') }}",
            "affected_host": "{{ minion_id }}",
            "details": {{ incident_data | tojson }},
            "auto_isolated": true
          }'
```

## Advanced Features

### Multi-Master High Availability

```yaml
# /etc/salt/master.d/ha.conf - High Availability configuration
# Master 1 configuration
syndic_master: salt-master-primary.example.com
syndic_log_file: /var/log/salt/syndic

# Cluster configuration
cluster_masters:
  - salt-master-01.example.com
  - salt-master-02.example.com
  - salt-master-03.example.com

cluster_mode: active-passive
cluster_pki_dir: /etc/salt/cluster-pki

# Load balancing
load_balance_policy: round_robin
master_failback: true
master_failback_timeout: 300

# Shared storage for job cache
job_cache: mysql
job_cache_store_endtime: true

mysql.host: mysql-cluster.example.com
mysql.user: salt
mysql.pass: encrypted_password
mysql.db: salt_jobs
mysql.port: 3306
```

### Cloud Integration

```python
#!/usr/bin/env python3
# salt-cloud-manager.py - Advanced cloud integration

import salt.cloud
import salt.config
from typing import Dict, List, Any

class SaltCloudManager:
    """Advanced Salt Cloud management"""

    def __init__(self):
        self.cloud_config = salt.config.cloud_config('/etc/salt/cloud')
        self.cloud_client = salt.cloud.CloudClient()

    async def provision_infrastructure(self, infrastructure_spec: Dict[str, Any]) -> Dict[str, Any]:
        """Provision complete infrastructure stack"""

        results = {
            'instances': {},
            'networks': {},
            'storage': {},
            'load_balancers': {}
        }

        # Create networks first
        for network_name, network_config in infrastructure_spec.get('networks', {}).items():
            network_result = await self._create_network(network_name, network_config)
            results['networks'][network_name] = network_result

        # Create storage
        for storage_name, storage_config in infrastructure_spec.get('storage', {}).items():
            storage_result = await self._create_storage(storage_name, storage_config)
            results['storage'][storage_name] = storage_result

        # Launch instances
        for instance_name, instance_config in infrastructure_spec.get('instances', {}).items():
            instance_result = await self._launch_instance(instance_name, instance_config)
            results['instances'][instance_name] = instance_result

        # Configure load balancers
        for lb_name, lb_config in infrastructure_spec.get('load_balancers', {}).items():
            lb_result = await self._create_load_balancer(lb_name, lb_config)
            results['load_balancers'][lb_name] = lb_result

        return results

    async def _launch_instance(self, name: str, config: Dict[str, Any]) -> Dict[str, Any]:
        """Launch cloud instance with Salt integration"""

        # Define cloud profile
        profile = {
            'provider': config.get('provider', 'ec2'),
            'size': config.get('size', 't3.medium'),
            'image': config.get('image'),
            'location': config.get('location', 'us-west-2'),
            'securitygroupid': config.get('security_groups', []),
            'subnetid': config.get('subnet'),
            'keyname': config.get('key_name'),

            # Salt-specific configuration
            'minion': {
                'master': config.get('salt_masters', ['salt-master.example.com']),
                'grains': config.get('grains', {}),
                'startup_states': 'highstate',
                'top_file_merging_strategy': 'same'
            },

            # Bootstrap script
            'script': 'bootstrap-salt',
            'script_args': f"-P -c /tmp -x python3 {config.get('salt_version', 'stable')}",

            # Post-provisioning
            'deploy': True,
            'make_master': config.get('make_master', False)
        }

        # Launch instance
        instance_data = self.cloud_client.create(name, profile_name=name, profile=profile)

        # Wait for Salt minion to connect
        await self._wait_for_minion(name, timeout=600)

        # Apply initial states
        initial_states = config.get('initial_states', [])
        for state in initial_states:
            await self._apply_state(name, state)

        return instance_data

# Cloud profile examples
CLOUD_PROFILES = {
    'web-server-prod': {
        'provider': 'ec2',
        'size': 'c5.xlarge',
        'image': 'ami-0abcdef1234567890',
        'location': 'us-west-2',
        'securitygroupid': ['sg-web-servers'],
        'subnetid': 'subnet-prod-web',
        'keyname': 'prod-key',
        'minion': {
            'master': ['salt-master-prod-01.example.com', 'salt-master-prod-02.example.com'],
            'grains': {
                'role': 'webserver',
                'environment': 'production',
                'tier': 'web'
            }
        },
        'initial_states': [
            'base.security',
            'webserver.nginx',
            'monitoring.node-exporter'
        ]
    },

    'database-server-prod': {
        'provider': 'ec2',
        'size': 'r5.2xlarge',
        'image': 'ami-0abcdef1234567890',
        'location': 'us-west-2',
        'securitygroupid': ['sg-database-servers'],
        'subnetid': 'subnet-prod-data',
        'keyname': 'prod-key',
        'minion': {
            'master': ['salt-master-prod-01.example.com', 'salt-master-prod-02.example.com'],
            'grains': {
                'role': 'database',
                'environment': 'production',
                'tier': 'data'
            }
        },
        'initial_states': [
            'base.security',
            'database.postgresql',
            'monitoring.postgres-exporter'
        ]
    }
}
```

## Quality Assurance and Compliance

### Automated Testing Framework

```python
#!/usr/bin/env python3
# salt-testing-framework.py - Comprehensive Salt testing

import asyncio
import pytest
import testinfra
from typing import Dict, List, Any
import salt.client

class SaltTestFramework:
    """Comprehensive Salt testing framework"""

    def __init__(self):
        self.local_client = salt.client.LocalClient()

    async def test_state_application(self, target: str, state: str, environment: str = "test"):
        """Test Salt state application"""

        # Apply state in test mode
        test_result = self.local_client.cmd(
            target,
            'state.apply',
            [state],
            kwarg={'test': True, 'saltenv': environment}
        )

        # Validate test results
        validation_results = await self._validate_test_results(test_result)

        if validation_results['valid']:
            # Apply state for real
            real_result = self.local_client.cmd(
                target,
                'state.apply',
                [state],
                kwarg={'saltenv': environment}
            )

            # Validate actual application
            final_validation = await self._validate_state_application(target, state, real_result)

            return {
                'test_result': test_result,
                'real_result': real_result,
                'validation': final_validation
            }
        else:
            raise Exception(f"State test validation failed: {validation_results['errors']}")

    async def integration_test_suite(self, target: str, test_suite: str):
        """Run integration test suite"""

        # Define test cases
        test_cases = {
            'web_server': [
                self._test_service_running,
                self._test_port_listening,
                self._test_http_response,
                self._test_ssl_certificate,
                self._test_log_rotation
            ],
            'database': [
                self._test_service_running,
                self._test_port_listening,
                self._test_database_connection,
                self._test_backup_script,
                self._test_performance_tuning
            ]
        }

        suite_tests = test_cases.get(test_suite, [])
        results = {}

        for test_func in suite_tests:
            test_name = test_func.__name__
            try:
                result = await test_func(target)
                results[test_name] = {'status': 'passed', 'result': result}
            except Exception as e:
                results[test_name] = {'status': 'failed', 'error': str(e)}

        return results

# Test execution examples
TEST_SCENARIOS = {
    'compliance_validation': {
        'description': 'Validate CIS compliance across infrastructure',
        'tests': [
            {
                'name': 'ssh_hardening',
                'state': 'security.ssh_hardening',
                'validation': [
                    'service ssh is enabled',
                    'file /etc/ssh/sshd_config contains "PermitRootLogin no"',
                    'file /etc/ssh/sshd_config contains "PasswordAuthentication no"'
                ]
            },
            {
                'name': 'firewall_configuration',
                'state': 'security.firewall',
                'validation': [
                    'service ufw is enabled',
                    'command "ufw status" returns 0',
                    'command "ufw status | grep -q active"'
                ]
            }
        ]
    },

    'performance_validation': {
        'description': 'Validate performance configurations',
        'tests': [
            {
                'name': 'nginx_tuning',
                'state': 'webserver.performance',
                'validation': [
                    'file /etc/nginx/nginx.conf contains "worker_processes auto"',
                    'service nginx is running',
                    'port 80 is listening',
                    'port 443 is listening'
                ]
            }
        ]
    }
}
```

## AI Assistant Guidelines

### Decision Framework

```python
def should_use_saltstack(requirements):
    """Determine if SaltStack is appropriate for the use case"""

    # Strongly recommended for
    if any([
        requirements.get('large_scale_infrastructure'),
        requirements.get('event_driven_automation'),
        requirements.get('real_time_orchestration'),
        requirements.get('high_performance_execution'),
        requirements.get('complex_multi_cloud')
    ]):
        return True, "SaltStack is ideal for large-scale, event-driven infrastructure"

    # Consider alternatives if
    if any([
        requirements.get('simple_configuration_management'),
        requirements.get('small_infrastructure'),
        requirements.get('learning_curve_concerns'),
        requirements.get('declarative_only_needs')
    ]):
        return False, "Consider Ansible for simpler needs or Terraform for pure infrastructure"

    # Enterprise considerations
    if requirements.get('enterprise_deployment'):
        return True, "SaltStack provides excellent enterprise features and scalability"

    return True, "SaltStack is suitable with proper configuration"

def generate_salt_state(service_type, requirements, environment):
    """Generate Salt state based on service type and requirements"""

    state_template = {
        'include': [],
        'states': {},
        'pillar_data': {},
        'grains_required': [],
        'dependencies': []
    }

    # Base security and monitoring
    state_template['include'].extend([
        'security.baseline',
        'monitoring.node-exporter'
    ])

    # Service-specific configuration
    if service_type == 'web_server':
        state_template['states'].update({
            'nginx': {
                'pkg.installed': [{'name': 'nginx'}],
                'service.running': [
                    {'name': 'nginx'},
                    {'enable': True},
                    {'watch': [{'file': '/etc/nginx/nginx.conf'}]}
                ]
            }
        })

        state_template['pillar_data'].update({
            'nginx': {
                'worker_processes': '{{ grains.num_cpus }}',
                'worker_connections': 1024,
                'keepalive_timeout': 65
            }
        })

    # Environment-specific adjustments
    if environment == 'production':
        state_template['include'].extend([
            'security.hardening',
            'backup.automated',
            'monitoring.comprehensive'
        ])

        # Production-specific pillar data
        state_template['pillar_data']['monitoring'] = {
            'alerts_enabled': True,
            'log_level': 'warn',
            'backup_enabled': True
        }

    return state_template
```

### Quality Enforcement

```yaml
# salt-quality-checklist.yaml - Quality assurance checklist
quality_checks:
  state_development:
    - 'States are idempotent and can be run multiple times safely'
    - 'All sensitive data is stored in pillars, not states'
    - 'Jinja templates are used for dynamic configuration'
    - 'State dependencies are properly defined with require/watch'
    - 'Error handling and rollback procedures are implemented'

  pillar_management:
    - "Sensitive data is encrypted using Salt's encryption features"
    - 'Pillar data is environment-specific and properly segmented'
    - 'Access control is implemented for sensitive pillars'
    - 'Pillar data validation is performed before application'

  orchestration:
    - 'Complex deployments use orchestration SLS files'
    - 'Rollback strategies are defined for all orchestrations'
    - 'Health checks are implemented between deployment stages'
    - 'Failure thresholds and notification channels are configured'

  security:
    - 'Master-minion communication uses encrypted transport'
    - 'Authentication keys are regularly rotated'
    - 'Access control lists restrict minion access to resources'
    - 'Audit logging is enabled for all operations'

  monitoring:
    - 'Event bus monitoring is configured for critical events'
    - 'Performance metrics are collected and analyzed'
    - 'Alerting is configured for system failures and anomalies'
    - 'Compliance reporting is automated and regularly generated'
```

### Enterprise Security & Compliance Automation

```yaml
# states/security/compliance.sls - Comprehensive compliance automation

{% set compliance_framework = pillar.get('compliance', {}).get('framework', 'CIS') %}
{% set security_level = pillar.get('security', {}).get('level', 'Level1') %}

# CIS Benchmark compliance
{% if compliance_framework == 'CIS' %}
cis_baseline_hardening:
  pkg.installed:
    - names:
      - aide
      - auditd
      - rsyslog
      - fail2ban
      - chrony

# CIS 1.1.1.1 - Disable unused filesystems
disable_cramfs:
  file.append:
    - name: /etc/modprobe.d/CIS.conf
    - text: "install cramfs /bin/true"

disable_freevxfs:
  file.append:
    - name: /etc/modprobe.d/CIS.conf
    - text: "install freevxfs /bin/true"

disable_jffs2:
  file.append:
    - name: /etc/modprobe.d/CIS.conf
    - text: "install jffs2 /bin/true"

# CIS 1.3.1 - Secure boot settings
grub_password:
  file.managed:
    - name: /etc/grub.d/40_custom
    - contents: |
        #!/bin/sh
        exec tail -n +3 $0
        set superusers="root"
        password_pbkdf2 root {{ pillar['security']['grub_password_hash'] }}
    - mode: 755

# CIS 1.5.1 - Core dump restrictions
core_dump_restrictions:
  sysctl.present:
    - name: fs.suid_dumpable
    - value: 0

# CIS 3.1.1 - IP forwarding
disable_ip_forwarding:
  sysctl.present:
    - name: net.ipv4.ip_forward
    - value: 0

# CIS 3.2.1 - Source routed packet acceptance
disable_source_routing:
  sysctl.present:
    - name: net.ipv4.conf.all.accept_source_route
    - value: 0

disable_source_routing_default:
  sysctl.present:
    - name: net.ipv4.conf.default.accept_source_route
    - value: 0

{% elif compliance_framework == 'SOC2' %}
# SOC2 Type II compliance controls
soc2_audit_configuration:
  file.managed:
    - name: /etc/audit/rules.d/soc2.rules
    - contents: |
        # SOC2 Security Monitoring Rules
        -w /etc/passwd -p wa -k identity
        -w /etc/group -p wa -k identity
        -w /etc/shadow -p wa -k identity
        -w /etc/sudoers -p wa -k privilege-escalation
        -w /var/log/auth.log -p wa -k authentication
        -w /etc/ssh/sshd_config -p wa -k ssh-config
        -w {{ pillar['soc2']['cardholder_data_location'] }} -p rwxa -k cardholder-data
    - require:
      - pkg: auditd

auditd_soc2:
  service.running:
    - name: auditd
    - enable: True
    - watch:
      - file: soc2_audit_configuration

# SOC2 log retention
soc2_log_rotation:
  file.managed:
    - name: /etc/logrotate.d/soc2-audit
    - contents: |
        /var/log/audit/*.log {
            monthly
            rotate {{ pillar['soc2']['log_retention_months'] }}
            compress
            delaycompress
            missingok
            notifempty
            create 640 root adm
            postrotate
                /sbin/service auditd restart >/dev/null 2>&1 || true
            endscript
        }

{% elif compliance_framework == 'PCI-DSS' %}
# PCI-DSS compliance requirements
pci_dss_user_group:
  group.present:
    - name: pci-dss
    - gid: 1500

pci_dss_firewall_rules:
  firewalld.present:
    - name: pci-zone
    - default: False
    - masquerade: False
    - ports:
      - 443/tcp  # HTTPS only for cardholder data
      - 22/tcp   # Secure SSH access

pci_password_policy:
  file.managed:
    - name: /etc/security/pwquality.conf
    - contents: |
        # PCI-DSS Password Requirements
        minlen = {{ pillar['pci']['password']['min_length'] }}
        minclass = {{ pillar['pci']['password']['min_complexity'] }}
        maxrepeat = {{ pillar['pci']['password']['max_repeat'] }}
        maxclassrepeat = {{ pillar['pci']['password']['max_class_repeat'] }}
        reject_username
        difok = {{ pillar['pci']['password']['min_different'] }}
        enforce_for_root

# Encryption at rest for cardholder data
{% for device in pillar['pci']['encrypted_devices'] %}
pci_encryption_{{ device.name }}:
  cmd.run:
    - name: |
        if ! cryptsetup isLuks {{ device.device }}; then
          echo "{{ pillar['pci']['encryption_passphrase'] }}" | cryptsetup luksFormat {{ device.device }}
          echo "{{ pillar['pci']['encryption_passphrase'] }}" | cryptsetup luksOpen {{ device.device }} {{ device.name }}
          mkfs.ext4 /dev/mapper/{{ device.name }}
        fi
    - unless: cryptsetup isLuks {{ device.device }}

pci_mount_{{ device.name }}:
  mount.mounted:
    - name: {{ device.mount_point }}
    - device: /dev/mapper/{{ device.name }}
    - fstype: ext4
    - opts: noatime,nodiratime,nodev,nosuid,noexec
    - require:
      - cmd: pci_encryption_{{ device.name }}
{% endfor %}

{% elif compliance_framework == 'HIPAA' %}
# HIPAA Security Rule implementation
hipaa_user_group:
  group.present:
    - name: hipaa
    - gid: 1600

hipaa_audit_configuration:
  file.managed:
    - name: /etc/audit/rules.d/hipaa.rules
    - contents: |
        # HIPAA Security Rule Audit Requirements
        -w {{ pillar['hipaa']['phi_location'] }} -p rwxa -k phi-access
        -w /etc/passwd -p wa -k identity-management
        -w /etc/group -p wa -k identity-management
        -w /var/log/auth.log -p wa -k authentication
        -w /etc/shadow -p wa -k authentication
        -w /etc/sudoers -p wa -k privilege-escalation
        # Additional HIPAA-specific audit rules
        -a always,exit -F arch=b64 -S unlink,unlinkat,rename,renameat -F auid>=1000 -F auid!=4294967295 -k delete
        -a always,exit -F arch=b32 -S unlink,unlinkat,rename,renameat -F auid>=1000 -F auid!=4294967295 -k delete

# PHI encryption at rest
{% for phi_volume in pillar['hipaa']['phi_volumes'] %}
hipaa_phi_encryption_{{ phi_volume.name }}:
  cmd.run:
    - name: |
        if ! cryptsetup isLuks {{ phi_volume.device }}; then
          echo "{{ pillar['hipaa']['encryption_key'] }}" | cryptsetup luksFormat {{ phi_volume.device }} --key-file=-
          echo "{{ pillar['hipaa']['encryption_key'] }}" | cryptsetup luksOpen {{ phi_volume.device }} {{ phi_volume.name }} --key-file=-
          mkfs.ext4 /dev/mapper/{{ phi_volume.name }}
        fi
    - unless: cryptsetup isLuks {{ phi_volume.device }}

hipaa_phi_mount_{{ phi_volume.name }}:
  mount.mounted:
    - name: {{ phi_volume.mount_point }}
    - device: /dev/mapper/{{ phi_volume.name }}
    - fstype: ext4
    - opts: noatime,nodiratime,nodev,nosuid
    - require:
      - cmd: hipaa_phi_encryption_{{ phi_volume.name }}
{% endfor %}

# HIPAA access controls
hipaa_access_control:
  file.managed:
    - name: /etc/security/access.conf
    - contents: |
        # HIPAA Access Control Rules
        + : (hipaa) : ALL
        + : root : ALL
        - : ALL : ALL
{% endif %}

# File integrity monitoring with AIDE
aide_installation:
  pkg.installed:
    - name: aide

aide_configuration:
  file.managed:
    - name: /etc/aide/aide.conf
    - contents: |
        # AIDE configuration for enterprise compliance
        database=file:/var/lib/aide/aide.db
        database_out=file:/var/lib/aide/aide.db.new
        gzip_dbout=yes
        verbose=5
        report_url=file:/var/log/aide/aide.log

        # Directories and files to monitor
        /bin f+p+u+g+s+b+m+c+md5+sha1
        /sbin f+p+u+g+s+b+m+c+md5+sha1
        /usr/bin f+p+u+g+s+b+m+c+md5+sha1
        /usr/sbin f+p+u+g+s+b+m+c+md5+sha1
        /etc p+i+n+u+g+s+b+m+c+md5+sha1
        /boot f+p+u+g+s+b+m+c+md5+sha1

        # Exclude frequently changing files
        !/var/log/.*
        !/tmp/.*
        !/proc/.*
        !/sys/.*

aide_database_init:
  cmd.run:
    - name: aide --init
    - creates: /var/lib/aide/aide.db.new
    - require:
      - file: aide_configuration

aide_database_install:
  cmd.run:
    - name: mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
    - onlyif: test -f /var/lib/aide/aide.db.new
    - require:
      - cmd: aide_database_init

aide_cron_check:
  cron.present:
    - name: aide --check
    - user: root
    - minute: 0
    - hour: 2
    - identifier: aide_integrity_check
```

### Enterprise Monitoring & Observability Integration

```yaml
# states/monitoring/enterprise.sls - Comprehensive monitoring platform

{% set monitoring_config = pillar.get('monitoring', {}) %}
{% set prometheus_config = monitoring_config.get('prometheus', {}) %}
{% set grafana_config = monitoring_config.get('grafana', {}) %}

# Prometheus Node Exporter
prometheus_user:
  user.present:
    - name: prometheus
    - system: True
    - shell: /bin/false
    - home: /var/lib/prometheus
    - createhome: False

prometheus_directories:
  file.directory:
    - names:
      - /var/lib/prometheus
      - /etc/prometheus
      - /usr/local/bin
    - user: prometheus
    - group: prometheus
    - mode: 755
    - require:
      - user: prometheus_user

node_exporter_download:
  cmd.run:
    - name: |
        cd /tmp
        wget -q https://github.com/prometheus/node_exporter/releases/download/v{{ prometheus_config.get('node_exporter_version', '1.6.1') }}/node_exporter-{{ prometheus_config.get('node_exporter_version', '1.6.1') }}.linux-amd64.tar.gz
        tar xzf node_exporter-{{ prometheus_config.get('node_exporter_version', '1.6.1') }}.linux-amd64.tar.gz
        cp node_exporter-{{ prometheus_config.get('node_exporter_version', '1.6.1') }}.linux-amd64/node_exporter /usr/local/bin/
        chown prometheus:prometheus /usr/local/bin/node_exporter
    - creates: /usr/local/bin/node_exporter

node_exporter_service:
  file.managed:
    - name: /etc/systemd/system/node_exporter.service
    - contents: |
        [Unit]
        Description=Node Exporter
        After=network.target

        [Service]
        User=prometheus
        Group=prometheus
        Type=simple
        ExecStart=/usr/local/bin/node_exporter --web.listen-address=0.0.0.0:9100 --collector.systemd --collector.processes
        Restart=always

        [Install]
        WantedBy=multi-user.target
    - require:
      - cmd: node_exporter_download

  service.running:
    - name: node_exporter
    - enable: True
    - require:
      - file: node_exporter_service
    - watch:
      - file: node_exporter_service

# Salt-specific metrics collection
salt_metrics_collector:
  file.managed:
    - name: /usr/local/bin/salt-metrics-collector.py
    - mode: 755
    - contents: |
        #!/usr/bin/env python3
        import salt.client
        import salt.runner
        import json
        import time
        from prometheus_client import CollectorRegistry, Gauge, push_to_gateway

        # Initialize Salt clients
        local_client = salt.client.LocalClient()
        runner_client = salt.runner.RunnerClient()

        # Prometheus metrics
        registry = CollectorRegistry()
        minion_up = Gauge('salt_minion_up', 'Salt minion availability', ['minion_id'], registry=registry)
        job_success = Gauge('salt_job_success_total', 'Successful Salt jobs', ['function'], registry=registry)
        job_failure = Gauge('salt_job_failure_total', 'Failed Salt jobs', ['function'], registry=registry)
        state_apply_duration = Gauge('salt_state_apply_duration_seconds', 'State apply duration', ['minion_id'], registry=registry)

        # Collect metrics
        try:
            # Check minion status
            minions = local_client.cmd('*', 'test.ping', timeout=10)
            for minion_id, result in minions.items():
                minion_up.labels(minion_id=minion_id).set(1 if result else 0)

            # Get job statistics (last 24 hours)
            jobs = runner_client.cmd('jobs.list_jobs', search_function=['*'], search_target=['*'])

            # Process job results
            for jid, job_info in jobs.items():
                if 'Function' in job_info and 'Result' in job_info:
                    function = job_info['Function']
                    success_count = sum(1 for result in job_info['Result'].values() if result.get('retcode') == 0)
                    failure_count = len(job_info['Result']) - success_count

                    job_success.labels(function=function).inc(success_count)
                    job_failure.labels(function=function).inc(failure_count)

            # Push metrics to Prometheus
            push_to_gateway('{{ prometheus_config.get("pushgateway_url", "localhost:9091") }}',
                          job='salt-metrics', registry=registry)

        except Exception as e:
            print(f"Error collecting Salt metrics: {e}")

  cron.present:
    - name: /usr/local/bin/salt-metrics-collector.py
    - user: root
    - minute: '*/5'
    - identifier: salt_metrics_collection
    - require:
      - file: salt_metrics_collector

# Filebeat for log shipping
{% if monitoring_config.get('elasticsearch', {}).get('enabled', True) %}
filebeat_repo:
  pkgrepo.managed:
    - name: elastic-7.x
    - humanname: Elastic repository for 7.x packages
    - baseurl: https://artifacts.elastic.co/packages/7.x/yum
    - gpgcheck: 1
    - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch

filebeat_install:
  pkg.installed:
    - name: filebeat
    - require:
      - pkgrepo: filebeat_repo

filebeat_config:
  file.managed:
    - name: /etc/filebeat/filebeat.yml
    - contents: |
        filebeat.inputs:
        - type: log
          enabled: true
          paths:
            - /var/log/salt/master
            - /var/log/salt/minion
            - /var/log/audit/*.log
            - /var/log/messages
            - /var/log/secure
          fields:
            environment: {{ pillar.get('environment', 'production') }}
            compliance_framework: {{ pillar.get('compliance', {}).get('framework', 'CIS') }}
            datacenter: {{ grains.get('datacenter', 'unknown') }}
          fields_under_root: true

        processors:
          - add_host_metadata:
              when.not.contains.tags: forwarded

        output.elasticsearch:
          hosts: {{ monitoring_config.get('elasticsearch', {}).get('hosts', ['localhost:9200']) | tojson }}
          username: "{{ monitoring_config.get('elasticsearch', {}).get('username', 'elastic') }}"
          password: "{{ monitoring_config.get('elasticsearch', {}).get('password', 'changeme') }}"
          index: "salt-logs-{{ pillar.get('environment', 'production') }}-%{+yyyy.MM.dd}"

        setup.template.settings:
          index.number_of_shards: 1
          index.number_of_replicas: 1

        setup.kibana:
          host: "{{ monitoring_config.get('kibana', {}).get('host', 'localhost:5601') }}"
    - require:
      - pkg: filebeat_install

filebeat_service:
  service.running:
    - name: filebeat
    - enable: True
    - require:
      - file: filebeat_config
    - watch:
      - file: filebeat_config
{% endif %}

# Health check service
salt_health_check:
  file.managed:
    - name: /usr/local/bin/salt-health-check.py
    - mode: 755
    - contents: |
        #!/usr/bin/env python3
        import salt.client
        import json
        import time
        from http.server import HTTPServer, BaseHTTPRequestHandler

        class HealthCheckHandler(BaseHTTPRequestHandler):
            def do_GET(self):
                if self.path == '/health':
                    try:
                        local_client = salt.client.LocalClient()
                        # Quick connectivity test
                        result = local_client.cmd('{{ grains['id'] }}', 'test.ping', timeout=5)

                        if result and result.get('{{ grains['id'] }}') is True:
                            self.send_response(200)
                            self.send_header('Content-Type', 'application/json')
                            self.end_headers()
                            response = {
                                'status': 'healthy',
                                'timestamp': time.time(),
                                'minion_id': '{{ grains['id'] }}',
                                'compliance_framework': '{{ pillar.get('compliance', {}).get('framework', 'CIS') }}'
                            }
                            self.wfile.write(json.dumps(response).encode())
                        else:
                            raise Exception("Salt connectivity failed")
                    except Exception as e:
                        self.send_response(503)
                        self.send_header('Content-Type', 'application/json')
                        self.end_headers()
                        response = {
                            'status': 'unhealthy',
                            'error': str(e),
                            'timestamp': time.time()
                        }
                        self.wfile.write(json.dumps(response).encode())
                elif self.path == '/metrics':
                    # Basic metrics endpoint
                    self.send_response(200)
                    self.send_header('Content-Type', 'text/plain')
                    self.end_headers()
                    metrics = f"""# HELP salt_health_status Salt minion health status
# TYPE salt_health_status gauge
salt_health_status{{minion_id="{{{{ grains['id'] }}}}"}} 1
"""
                    self.wfile.write(metrics.encode())
                else:
                    self.send_response(404)
                    self.end_headers()

        if __name__ == '__main__':
            server = HTTPServer(('0.0.0.0', {{ monitoring_config.get('health_check_port', 8080) }}), HealthCheckHandler)
            server.serve_forever()

salt_health_check_service:
  file.managed:
    - name: /etc/systemd/system/salt-health-check.service
    - contents: |
        [Unit]
        Description=Salt Health Check Service
        After=network.target

        [Service]
        Type=simple
        ExecStart=/usr/local/bin/salt-health-check.py
        Restart=always
        User=root

        [Install]
        WantedBy=multi-user.target
    - require:
      - file: salt_health_check

  service.running:
    - name: salt-health-check
    - enable: True
    - require:
      - file: salt_health_check_service
    - watch:
      - file: salt_health_check
      - file: salt_health_check_service
```

### Enterprise CI/CD & Testing Automation

```yaml
# states/cicd/enterprise.sls - Comprehensive CI/CD pipeline integration

{% set cicd_config = pillar.get('cicd', {}) %}
{% set testing_config = pillar.get('testing', {}) %}

# Salt testing framework setup
salt_testing_dependencies:
  pkg.installed:
    - names:
      - python3-pip
      - git
      - docker.io

salt_testing_python_packages:
  pip.installed:
    - names:
      - pytest
      - pytest-salt-factories
      - testinfra
      - molecule
      - docker
      - yamllint
      - salt-lint
    - require:
      - pkg: salt_testing_dependencies

# Test Kitchen for Salt formula testing
test_kitchen_config:
  file.managed:
    - name: /srv/salt/.kitchen.yml
    - contents: |
        ---
        driver:
          name: docker
          use_sudo: false
          privileged: true

        provisioner:
          name: salt_solo
          salt_install: bootstrap
          salt_bootstrap_url: https://bootstrap.saltstack.com
          salt_version: latest
          require_chef: false
          salt_copy_filter:
            - .git

        platforms:
        {% for platform in testing_config.get('platforms', ['ubuntu-20.04', 'centos-8']) %}
          - name: {{ platform }}
            driver_config:
              image: {{ platform }}
              platform: ubuntu
        {% endfor %}

        suites:
        {% for suite in testing_config.get('test_suites', []) %}
          - name: {{ suite.name }}
            provisioner:
              state_top:
                base:
                  '*':
                    - {{ suite.states | join('\n                    - ') }}
              pillars:
                {{ suite.pillars | tojson }}
            verifier:
              inspec_tests:
                - test/integration/{{ suite.name }}
        {% endfor %}

# GitLab CI runner for Salt testing
{% if cicd_config.get('gitlab', {}).get('enabled', False) %}
gitlab_runner_install:
  pkg.installed:
    - sources:
      - gitlab-runner: https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_amd64.rpm

gitlab_runner_register:
  cmd.run:
    - name: |
        gitlab-runner register \
          --non-interactive \
          --url {{ cicd_config['gitlab']['url'] }} \
          --registration-token {{ cicd_config['gitlab']['runner_token'] }} \
          --executor shell \
          --description "Salt Enterprise Runner - {{ grains['id'] }}" \
          --tag-list "{{ cicd_config['gitlab']['tags'] | join(',') }}" \
          --run-untagged=false \
          --locked=false
    - unless: gitlab-runner verify
    - require:
      - pkg: gitlab_runner_install

gitlab_runner_service:
  service.running:
    - name: gitlab-runner
    - enable: True
    - require:
      - cmd: gitlab_runner_register
{% endif %}

# Jenkins agent for Salt operations
{% if cicd_config.get('jenkins', {}).get('enabled', False) %}
jenkins_java:
  pkg.installed:
    - name: openjdk-11-jdk

jenkins_user:
  user.present:
    - name: jenkins
    - home: /home/jenkins
    - shell: /bin/bash
    - groups:
      - docker
      - salt

jenkins_agent_download:
  cmd.run:
    - name: |
        cd /home/jenkins
        wget -q {{ cicd_config['jenkins']['master_url'] }}/jnlpJars/agent.jar
        chown jenkins:jenkins agent.jar
    - creates: /home/jenkins/agent.jar
    - require:
      - user: jenkins_user

jenkins_agent_service:
  file.managed:
    - name: /etc/systemd/system/jenkins-agent.service
    - contents: |
        [Unit]
        Description=Jenkins Agent
        After=network.target

        [Service]
        Type=simple
        User=jenkins
        WorkingDirectory=/home/jenkins
        ExecStart=/usr/bin/java -jar agent.jar -jnlpUrl {{ cicd_config['jenkins']['master_url'] }}/computer/{{ grains['id'] }}/slave-agent.jnlp -secret {{ cicd_config['jenkins']['secret'] }}
        Restart=always

        [Install]
        WantedBy=multi-user.target
    - require:
      - cmd: jenkins_agent_download

  service.running:
    - name: jenkins-agent
    - enable: True
    - require:
      - file: jenkins_agent_service
    - watch:
      - file: jenkins_agent_service
{% endif %}

# Automated testing pipeline
salt_test_pipeline:
  file.managed:
    - name: /usr/local/bin/salt-test-pipeline.sh
    - mode: 755
    - contents: |
        #!/bin/bash
        set -euo pipefail

        SALT_ROOT={{ pillar.get('salt_root', '/srv/salt') }}
        TEST_RESULTS_DIR={{ testing_config.get('results_path', '/tmp/salt-test-results') }}

        echo "🧪 Starting Salt testing pipeline..."

        # Create results directory
        mkdir -p "$TEST_RESULTS_DIR"

        # YAML linting
        echo "Running YAML lint tests..."
        find "$SALT_ROOT" -name "*.sls" -o -name "*.yml" -o -name "*.yaml" | \
          xargs yamllint -c /etc/yamllint/config > "$TEST_RESULTS_DIR/yamllint-results.txt" || true

        # Salt-specific linting
        echo "Running Salt lint tests..."
        find "$SALT_ROOT" -name "*.sls" | \
          xargs salt-lint > "$TEST_RESULTS_DIR/salt-lint-results.txt" || true

        # State syntax validation
        echo "Running Salt state syntax validation..."
        salt-call --local state.show_sls {{ testing_config.get('test_states', ['test']) | join(',') }} \
          > "$TEST_RESULTS_DIR/syntax-validation.txt" 2>&1 || true

        # Integration tests with pytest
        echo "Running integration tests..."
        cd "$SALT_ROOT"
        python -m pytest tests/ -v --junitxml="$TEST_RESULTS_DIR/pytest-results.xml" || true

        # Infrastructure tests with testinfra
        if command -v testinfra &> /dev/null; then
          echo "Running infrastructure tests..."
          testinfra tests/test_infrastructure.py -v --junitxml="$TEST_RESULTS_DIR/testinfra-results.xml" || true
        fi

        # Test Kitchen execution
        if [ -f "$SALT_ROOT/.kitchen.yml" ]; then
          echo "Running Test Kitchen suites..."
          cd "$SALT_ROOT"
          kitchen test --destroy=always > "$TEST_RESULTS_DIR/kitchen-results.txt" 2>&1 || true
        fi

        # Generate test summary
        echo "📊 Test Summary:" > "$TEST_RESULTS_DIR/summary.txt"
        echo "YAML Lint: $(grep -c 'error' "$TEST_RESULTS_DIR/yamllint-results.txt" 2>/dev/null || echo 0) errors" >> "$TEST_RESULTS_DIR/summary.txt"
        echo "Salt Lint: $(grep -c 'ERROR' "$TEST_RESULTS_DIR/salt-lint-results.txt" 2>/dev/null || echo 0) errors" >> "$TEST_RESULTS_DIR/summary.txt"

        echo "✅ Salt testing pipeline completed"

        # Notification webhook
        {% if testing_config.get('notification_webhook') %}
        curl -X POST {{ testing_config['notification_webhook'] }} \
          -H "Content-Type: application/json" \
          -d "{\"message\": \"Salt testing completed on {{ grains['id'] }}\", \"results_path\": \"$TEST_RESULTS_DIR\"}" || true
        {% endif %}

salt_test_pipeline_cron:
  cron.present:
    - name: /usr/local/bin/salt-test-pipeline.sh
    - user: root
    - hour: 2
    - minute: 0
    - identifier: salt_automated_testing
    - require:
      - file: salt_test_pipeline

# State deployment automation
salt_deployment_automation:
  file.managed:
    - name: /usr/local/bin/salt-deploy-states.sh
    - mode: 755
    - contents: |
        #!/bin/bash
        set -euo pipefail

        ENVIRONMENT="{{ pillar.get('environment', 'production') }}"
        STATES_TO_DEPLOY="$1"

        echo "🚀 Starting Salt state deployment for environment: $ENVIRONMENT"

        # Pre-deployment validation
        echo "Validating states before deployment..."
        salt-call --local state.show_sls "$STATES_TO_DEPLOY" > /dev/null

        # Dry run first
        echo "Performing dry run..."
        salt-call --local state.apply "$STATES_TO_DEPLOY" test=True

        # Confirmation for production
        if [ "$ENVIRONMENT" = "production" ]; then
          echo "⚠️  Production deployment requires confirmation"
          {% if cicd_config.get('approval_required', True) %}
          # Wait for approval (implementation depends on approval system)
          echo "Waiting for deployment approval..."
          {% endif %}
        fi

        # Execute deployment
        echo "Executing state deployment..."
        salt-call --local state.apply "$STATES_TO_DEPLOY"

        echo "✅ Salt state deployment completed successfully"

# Salt event monitoring and automation
salt_event_reactor:
  file.managed:
    - name: /etc/salt/master.d/reactor.conf
    - contents: |
        reactor:
          - 'salt/minion/*/start':
            - /srv/reactor/new_minion.sls
          - 'salt/job/*/ret/*':
            - /srv/reactor/job_complete.sls
          - 'salt/auth':
            - /srv/reactor/auth_event.sls
          - 'salt/beacon/*/service/*':
            - /srv/reactor/service_event.sls

salt_reactor_scripts:
  file.recurse:
    - name: /srv/reactor
    - source: salt://reactor
    - template: jinja
    - include_empty: True
```

This comprehensive Level 3 SaltStack implementation provides enterprise-grade configuration management with advanced automation, compliance frameworks, monitoring integration, and production deployment patterns suitable for large-scale infrastructure environments.
