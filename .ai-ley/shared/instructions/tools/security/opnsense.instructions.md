---
agentMode: general
applyTo: general
author: AI-LEY
description: OPNsense hardened firewall and router platform guide covering FreeBSD-based security appliance deployment, packet filtering, VPN configuration, intrusion detection, and enterprise network security with modern web interface.
extensions:
  - .md
guidelines: N/A
instructionType: security
keywords:
  [
    opnsense,
    firewall,
    router,
    freebsd,
    packet-filter,
    vpn,
    intrusion-detection,
    network-security,
    hardened,
    enterprise,
  ]
lastUpdated: '2025-09-03T14:30:00.000000'
technicalQualityScore: 4.8
AIUsabilityScore: 4.8
title: OPNsense Hardened Firewall Security Instructions
version: 1.1.0
---

# OPNsense Hardened Firewall Security Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents implementing OPNsense solutions, emphasizing hardened security configurations, modern firewall management, enterprise-grade network protection, and secure appliance deployment.

### When to Use OPNsense

- **Hardened security environments** requiring enhanced security features
- **Modern firewall management** with contemporary web interface and frequent updates
- **Open-source preference** with active community development
- **Advanced networking** with comprehensive VPN and routing capabilities
- **pfSense alternative** seeking modern UI and enhanced security features

### When to Avoid OPNsense

- **Simple home networks** → consider basic router/firewall appliances
- **Legacy pfSense environments** with extensive custom configurations
- **Very large enterprise** → consider specialized enterprise firewall solutions
- **Limited technical expertise** → provide managed firewall services

### Architecture Essentials

- **FreeBSD Foundation**: HardenedBSD-based secure operating system
- **Modern Interface**: Contemporary web UI with responsive design and API
- **Plugin Ecosystem**: Extensible platform with community and commercial plugins
- **Security Focus**: Enhanced security features and frequent security updates

### Security and Compliance Guidelines

- **Administrative Security**: Multi-factor authentication, API key management, secure access
- **Network Hardening**: DNSSEC, DNS over TLS, secure default configurations
- **Access Control**: Role-based permissions, audit logging, session management
- **Vulnerability Management**: Regular updates, security monitoring, patch management
- **Compliance Features**: Logging, reporting, and audit trail capabilities

### Performance Best Practices

- **Hardware Optimization**: Appropriate sizing for throughput and feature requirements
- **Configuration Tuning**: Performance optimization for specific use cases
- **Resource Monitoring**: System performance tracking and capacity planning
- **High Availability**: CARP and pfsync configuration for redundancy

### Enterprise OpnSense Management Framework

```python
#!/usr/bin/env python3
# opnsense-enterprise-manager.py - Advanced OpnSense enterprise management framework

import asyncio
import json
import yaml
import logging
import requests
import ssl
import time
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional
from dataclasses import dataclass, asdict
import hashlib
import xml.etree.ElementTree as ET
from urllib.parse import urljoin
import aiohttp
import paramiko

@dataclass
class OpnSenseDevice:
    """OpnSense device configuration model"""
    device_id: str
    hostname: str
    management_ip: str
    api_key: str
    api_secret: str
    version: str
    role: str  # primary, secondary, standalone
    cluster_id: Optional[str] = None
    organization: Optional[str] = None
    location: Optional[Dict[str, Any]] = None

@dataclass
class SecurityPolicy:
    """Security policy configuration"""
    policy_id: str
    name: str
    description: str
    firewall_rules: List[Dict[str, Any]]
    ids_rules: List[Dict[str, Any]]
    vpn_policies: List[Dict[str, Any]]
    compliance_frameworks: List[str]
    monitoring_config: Dict[str, Any]

class OpnSenseEnterpriseManager:
    """Advanced OpnSense enterprise management platform"""

    def __init__(self, config_file: str):
        self.config = self.load_configuration(config_file)
        self.devices = {}
        self.security_policies = {}
        self.ha_manager = HighAvailabilityManager()
        self.compliance_engine = ComplianceEngine()
        self.monitoring_manager = MonitoringManager()
        self.backup_manager = BackupManager()
        self.automation_engine = AutomationEngine()

        # Setup comprehensive logging
        logging.basicConfig(
            level=getattr(logging, self.config.get('log_level', 'INFO')),
            format='%(asctime)s - %(name)s - %(levelname)s - %(funcName)s:%(lineno)d - %(message)s',
            handlers=[
                logging.FileHandler('opnsense_enterprise.log'),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)

    def load_configuration(self, config_file: str) -> Dict[str, Any]:
        """Load enterprise configuration"""
        try:
            with open(config_file, 'r') as f:
                return yaml.safe_load(f)
        except FileNotFoundError:
            self.logger.warning(f"Config file {config_file} not found, using defaults")
            return self.get_default_config()

    def get_default_config(self) -> Dict[str, Any]:
        """Get default enterprise configuration"""
        return {
            'devices': [],
            'security_policies': [],
            'monitoring': {
                'prometheus_endpoint': 'http://localhost:9090',
                'grafana_endpoint': 'http://localhost:3000',
                'syslog_server': 'localhost:514'
            },
            'backup': {
                'schedule': '0 2 * * *',
                'retention_days': 30,
                'encryption_enabled': True
            },
            'compliance': {
                'frameworks': ['NIST_CSF', 'ISO27001'],
                'audit_logging': True,
                'vulnerability_scanning': True
            }
        }

    async def initialize_enterprise_platform(self):
        """Initialize complete OpnSense enterprise platform"""
        self.logger.info("Initializing OpnSense Enterprise Management Platform")

        try:
            # Register and validate devices
            await self.register_devices()

            # Deploy security policies
            await self.deploy_security_policies()

            # Setup high availability clusters
            await self.ha_manager.initialize_ha_clusters(self.devices)

            # Initialize comprehensive monitoring
            monitoring_result = await self.monitoring_manager.setup_enterprise_monitoring(self.devices)

            # Setup compliance monitoring
            compliance_result = await self.compliance_engine.initialize_compliance_framework(self.devices)

            # Initialize backup system
            backup_result = await self.backup_manager.setup_enterprise_backup(self.devices)

            # Setup automation engine
            automation_result = await self.automation_engine.initialize_automation(self.devices)

            platform_status = {
                'status': 'success',
                'devices_managed': len(self.devices),
                'policies_deployed': len(self.security_policies),
                'monitoring_active': monitoring_result.get('active', False),
                'compliance_frameworks': compliance_result.get('frameworks_count', 0),
                'backup_jobs_configured': backup_result.get('jobs_count', 0),
                'automation_rules': automation_result.get('rules_count', 0)
            }

            self.logger.info(f"Platform initialization completed: {platform_status}")
            return platform_status

        except Exception as e:
            self.logger.error(f"Platform initialization failed: {e}")
            raise

    async def register_devices(self):
        """Register and validate OpnSense devices"""
        for device_config in self.config.get('devices', []):
            try:
                device = OpnSenseDevice(**device_config)

                # Validate device connectivity and authentication
                if await self.validate_device_connection(device):
                    self.devices[device.device_id] = device
                    self.logger.info(f"Device {device.hostname} registered successfully")
                else:
                    self.logger.error(f"Failed to validate device {device.hostname}")

            except Exception as e:
                self.logger.error(f"Device registration failed: {e}")

    async def validate_device_connection(self, device: OpnSenseDevice) -> bool:
        """Validate device connectivity and API access"""
        try:
            api_client = OpnSenseAPIClient(device)
            status = await api_client.get_system_status()

            if status and status.get('status') == 'online':
                # Update device version information
                device.version = status.get('version', 'unknown')
                return True

            return False

        except Exception as e:
            self.logger.error(f"Device validation failed for {device.hostname}: {e}")
            return False

    async def deploy_security_policies(self):
        """Deploy comprehensive security policies to all devices"""
        policies = self.config.get('security_policies', [])

        for policy_config in policies:
            policy = SecurityPolicy(**policy_config)
            self.security_policies[policy.policy_id] = policy

            # Apply policy to applicable devices
            for device_id, device in self.devices.items():
                if self.is_policy_applicable(device, policy):
                    await self.apply_security_policy(device, policy)

    def is_policy_applicable(self, device: OpnSenseDevice, policy: SecurityPolicy) -> bool:
        """Determine if a security policy applies to a device"""
        # Implement policy targeting logic based on device attributes
        return True  # Simplified for example

    async def apply_security_policy(self, device: OpnSenseDevice, policy: SecurityPolicy):
        """Apply security policy to a specific device"""
        api_client = OpnSenseAPIClient(device)

        try:
            # Apply firewall rules
            for rule in policy.firewall_rules:
                await api_client.create_firewall_rule(rule)

            # Apply IDS rules
            for ids_rule in policy.ids_rules:
                await api_client.configure_ids_rule(ids_rule)

            # Configure VPN policies
            for vpn_policy in policy.vpn_policies:
                await api_client.configure_vpn(vpn_policy)

            self.logger.info(f"Security policy {policy.name} applied to {device.hostname}")

        except Exception as e:
            self.logger.error(f"Failed to apply policy {policy.name} to {device.hostname}: {e}")

class OpnSenseAPIClient:
    """OpnSense API client with enterprise features"""

    def __init__(self, device: OpnSenseDevice):
        self.device = device
        self.base_url = f"https://{device.management_ip}"
        self.session = None

    async def __aenter__(self):
        """Async context manager entry"""
        connector = aiohttp.TCPConnector(ssl=False)  # Configure SSL properly in production
        self.session = aiohttp.ClientSession(
            connector=connector,
            auth=aiohttp.BasicAuth(self.device.api_key, self.device.api_secret),
            timeout=aiohttp.ClientTimeout(total=30)
        )
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        """Async context manager exit"""
        if self.session:
            await self.session.close()

    async def get_system_status(self) -> Dict[str, Any]:
        """Get system status and information"""
        async with self.session.get(f"{self.base_url}/api/core/system/status") as response:
            if response.status == 200:
                return await response.json()
            else:
                raise Exception(f"API call failed with status {response.status}")

    async def create_firewall_rule(self, rule_config: Dict[str, Any]):
        """Create firewall rule via API"""
        endpoint = f"{self.base_url}/api/firewall/filter/addRule"

        async with self.session.post(endpoint, json=rule_config) as response:
            if response.status not in [200, 201]:
                raise Exception(f"Failed to create firewall rule: {response.status}")

            result = await response.json()
            return result

    async def configure_ids_rule(self, ids_config: Dict[str, Any]):
        """Configure IDS rule"""
        endpoint = f"{self.base_url}/api/suricata/config/set"

        async with self.session.post(endpoint, json=ids_config) as response:
            if response.status not in [200, 201]:
                raise Exception(f"Failed to configure IDS rule: {response.status}")

    async def configure_vpn(self, vpn_config: Dict[str, Any]):
        """Configure VPN settings"""
        endpoint = f"{self.base_url}/api/ipsec/config/set"

        async with self.session.post(endpoint, json=vpn_config) as response:
            if response.status not in [200, 201]:
                raise Exception(f"Failed to configure VPN: {response.status}")

    async def get_configuration_backup(self) -> bytes:
        """Get complete configuration backup"""
        endpoint = f"{self.base_url}/api/core/backup/backup"

        async with self.session.get(endpoint) as response:
            if response.status == 200:
                return await response.read()
            else:
                raise Exception(f"Backup failed: {response.status}")

class HighAvailabilityManager:
    """High availability cluster management"""

    def __init__(self):
        self.clusters = {}
        self.sync_status = {}

    async def initialize_ha_clusters(self, devices: Dict[str, OpnSenseDevice]):
        """Initialize high availability clusters"""
        cluster_configs = self.identify_clusters(devices)

        for cluster_id, cluster_devices in cluster_configs.items():
            try:
                await self.setup_cluster(cluster_id, cluster_devices)
                self.logger.info(f"HA cluster {cluster_id} initialized")
            except Exception as e:
                self.logger.error(f"Failed to initialize cluster {cluster_id}: {e}")

    def identify_clusters(self, devices: Dict[str, OpnSenseDevice]) -> Dict[str, List[OpnSenseDevice]]:
        """Identify device clusters based on cluster_id"""
        clusters = {}

        for device in devices.values():
            if device.cluster_id:
                if device.cluster_id not in clusters:
                    clusters[device.cluster_id] = []
                clusters[device.cluster_id].append(device)

        return clusters

    async def setup_cluster(self, cluster_id: str, devices: List[OpnSenseDevice]):
        """Setup high availability cluster"""
        if len(devices) < 2:
            raise Exception(f"Cluster {cluster_id} requires at least 2 devices")

        # Identify primary and secondary devices
        primary_device = next((d for d in devices if d.role == 'primary'), devices[0])
        secondary_devices = [d for d in devices if d != primary_device]

        # Configure CARP on primary device
        await self.configure_carp_primary(primary_device, secondary_devices)

        # Configure CARP on secondary devices
        for secondary in secondary_devices:
            await self.configure_carp_secondary(secondary, primary_device)

        # Setup configuration synchronization
        await self.setup_config_sync(primary_device, secondary_devices)

        self.clusters[cluster_id] = {
            'primary': primary_device,
            'secondaries': secondary_devices,
            'status': 'active'
        }

    async def configure_carp_primary(self, primary: OpnSenseDevice, secondaries: List[OpnSenseDevice]):
        """Configure CARP on primary device"""
        async with OpnSenseAPIClient(primary) as api:
            carp_config = {
                'interface': 'lan',
                'vhid': 1,
                'advskew': 0,  # Primary has lowest skew
                'advbase': 1,
                'password': self.generate_carp_password(),
                'type': 'carp'
            }

            await api.configure_carp(carp_config)

    async def configure_carp_secondary(self, secondary: OpnSenseDevice, primary: OpnSenseDevice):
        """Configure CARP on secondary device"""
        async with OpnSenseAPIClient(secondary) as api:
            carp_config = {
                'interface': 'lan',
                'vhid': 1,
                'advskew': 100,  # Higher skew for backup
                'advbase': 1,
                'password': self.generate_carp_password(),
                'type': 'carp'
            }

            await api.configure_carp(carp_config)

    def generate_carp_password(self) -> str:
        """Generate secure CARP password"""
        import secrets
        return secrets.token_urlsafe(16)

class ComplianceEngine:
    """Enterprise compliance and governance engine"""

    def __init__(self):
        self.frameworks = {
            'NIST_CSF': self.get_nist_csf_controls(),
            'ISO27001': self.get_iso27001_controls(),
            'PCI_DSS': self.get_pci_dss_controls(),
            'HIPAA': self.get_hipaa_controls(),
            'SOX': self.get_sox_controls()
        }
        self.compliance_status = {}

    async def initialize_compliance_framework(self, devices: Dict[str, OpnSenseDevice]):
        """Initialize compliance monitoring framework"""
        active_frameworks = []

        for framework_name, controls in self.frameworks.items():
            try:
                await self.setup_compliance_monitoring(framework_name, controls, devices)
                active_frameworks.append(framework_name)
                self.logger.info(f"Compliance framework {framework_name} initialized")
            except Exception as e:
                self.logger.error(f"Failed to initialize {framework_name}: {e}")

        return {
            'status': 'success',
            'frameworks_count': len(active_frameworks),
            'active_frameworks': active_frameworks
        }

    def get_nist_csf_controls(self) -> Dict[str, Any]:
        """Get NIST Cybersecurity Framework controls"""
        return {
            'identify': {
                'ID.AM-1': 'Physical devices and systems within the organization are inventoried',
                'ID.AM-2': 'Software platforms and applications are inventoried',
                'ID.AM-3': 'Organizational communication and data flows are mapped',
                'ID.AM-4': 'External information systems are catalogued',
                'ID.AM-5': 'Resources are prioritized based on classification, criticality, and business value',
                'ID.AM-6': 'Cybersecurity roles and responsibilities are established'
            },
            'protect': {
                'PR.AC-1': 'Identities and credentials are issued, managed, verified, revoked, and audited',
                'PR.AC-3': 'Remote access is managed',
                'PR.AC-4': 'Access permissions and authorizations are managed',
                'PR.AC-5': 'Network integrity is protected',
                'PR.AC-6': 'Identities are proofed and bound to credentials',
                'PR.AC-7': 'Users, devices, and other assets are authenticated'
            },
            'detect': {
                'DE.AE-1': 'A baseline of network operations and expected data flows is established',
                'DE.AE-2': 'Detected events are analyzed to understand attack targets and methods',
                'DE.AE-3': 'Event data are collected and correlated from multiple sources',
                'DE.AE-4': 'Impact of events is determined',
                'DE.AE-5': 'Incident alert thresholds are established'
            },
            'respond': {
                'RS.RP-1': 'Response plan is executed during or after an incident',
                'RS.CO-1': 'Personnel know their roles and order of operations',
                'RS.CO-2': 'Incidents are reported consistent with established criteria',
                'RS.CO-3': 'Information is shared with designated parties',
                'RS.CO-4': 'Coordination with stakeholders occurs',
                'RS.CO-5': 'Voluntary information sharing occurs with external stakeholders'
            },
            'recover': {
                'RC.RP-1': 'Recovery plan is executed during or after a cybersecurity incident',
                'RC.IM-1': 'Recovery plans incorporate lessons learned',
                'RC.IM-2': 'Recovery strategies are updated',
                'RC.CO-1': 'Public relations are managed',
                'RC.CO-2': 'Reputation is repaired after an incident',
                'RC.CO-3': 'Recovery activities are communicated to internal and external parties'
            }
        }

    async def setup_compliance_monitoring(self, framework: str, controls: Dict[str, Any], devices: Dict[str, OpnSenseDevice]):
        """Setup compliance monitoring for specific framework"""
        for device_id, device in devices.items():
            compliance_config = await self.generate_compliance_config(framework, controls, device)

            async with OpnSenseAPIClient(device) as api:
                # Configure compliance logging
                await api.configure_compliance_logging(compliance_config)

                # Setup audit rules
                await api.configure_audit_rules(compliance_config)

                # Configure compliance reporting
                await api.configure_compliance_reporting(compliance_config)

class MonitoringManager:
    """Comprehensive monitoring and alerting system"""

    def __init__(self):
        self.monitoring_endpoints = {}
        self.alert_rules = {}
        self.dashboards = {}

    async def setup_enterprise_monitoring(self, devices: Dict[str, OpnSenseDevice]):
        """Setup comprehensive enterprise monitoring"""
        # Setup Prometheus metrics collection
        await self.setup_prometheus_monitoring(devices)

        # Setup Grafana dashboards
        await self.setup_grafana_dashboards(devices)

        # Setup SIEM integration
        await self.setup_siem_integration(devices)

        # Setup alerting rules
        await self.setup_alerting_rules(devices)

        return {
            'status': 'success',
            'active': True,
            'endpoints_count': len(self.monitoring_endpoints),
            'dashboards_count': len(self.dashboards)
        }

    async def setup_prometheus_monitoring(self, devices: Dict[str, OpnSenseDevice]):
        """Setup Prometheus metrics collection"""
        for device_id, device in devices.items():
            # Configure Telegraf on OpnSense device
            telegraf_config = self.generate_telegraf_config(device)

            async with OpnSenseAPIClient(device) as api:
                await api.install_plugin('os-telegraf')
                await api.configure_telegraf(telegraf_config)

            self.monitoring_endpoints[device_id] = f"http://{device.management_ip}:9273/metrics"

    def generate_telegraf_config(self, device: OpnSenseDevice) -> Dict[str, Any]:
        """Generate Telegraf configuration for OpnSense device"""
        return {
            'agent': {
                'interval': '60s',
                'round_interval': True,
                'metric_batch_size': 1000,
                'metric_buffer_limit': 10000,
                'collection_jitter': '0s',
                'flush_interval': '10s',
                'flush_jitter': '0s',
                'precision': '',
                'hostname': device.hostname,
                'omit_hostname': False
            },
            'outputs': {
                'prometheus_client': {
                    'listen': ':9273',
                    'metric_version': 2
                },
                'influxdb': {
                    'urls': ['http://influxdb:8086'],
                    'database': 'opnsense',
                    'username': 'telegraf',
                    'password': 'password'
                }
            },
            'inputs': {
                'system': {},
                'cpu': {'percpu': True, 'totalcpu': True},
                'disk': {'ignore_fs': ['tmpfs', 'devtmpfs', 'devfs', 'overlay', 'aufs', 'squashfs']},
                'diskio': {},
                'kernel': {},
                'mem': {},
                'processes': {},
                'swap': {},
                'netstat': {},
                'interrupts': {},
                'linux_sysctl_fs': {},
                'net': {'interfaces': ['*']},
                'exec': [
                    {
                        'commands': ['/usr/local/bin/pfctl -si'],
                        'name_override': 'pf_info',
                        'data_format': 'value',
                        'data_type': 'string'
                    },
                    {
                        'commands': ['/usr/local/bin/pfctl -sr | wc -l'],
                        'name_override': 'pf_rules_count',
                        'data_format': 'value',
                        'data_type': 'integer'
                    }
                ]
            }
        }

class BackupManager:
    """Enterprise backup and disaster recovery system"""

    def __init__(self):
        self.backup_jobs = {}
        self.restore_points = {}

    async def setup_enterprise_backup(self, devices: Dict[str, OpnSenseDevice]):
        """Setup enterprise backup system"""
        backup_jobs_created = 0

        for device_id, device in devices.items():
            try:
                # Setup automated configuration backup
                backup_job = await self.create_backup_job(device)
                self.backup_jobs[device_id] = backup_job

                # Create initial backup
                await self.create_backup(device)

                backup_jobs_created += 1
                self.logger.info(f"Backup configured for {device.hostname}")

            except Exception as e:
                self.logger.error(f"Failed to setup backup for {device.hostname}: {e}")

        return {
            'status': 'success',
            'jobs_count': backup_jobs_created
        }

    async def create_backup_job(self, device: OpnSenseDevice) -> Dict[str, Any]:
        """Create automated backup job for device"""
        backup_config = {
            'device_id': device.device_id,
            'hostname': device.hostname,
            'schedule': '0 2 * * *',  # Daily at 2 AM
            'retention_days': 30,
            'encryption_enabled': True,
            'compression_enabled': True,
            'backup_location': f'/backups/{device.hostname}',
            'notification_enabled': True
        }

        return backup_config

    async def create_backup(self, device: OpnSenseDevice) -> str:
        """Create configuration backup for device"""
        async with OpnSenseAPIClient(device) as api:
            backup_data = await api.get_configuration_backup()

            # Encrypt and store backup
            backup_filename = f"{device.hostname}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.xml.enc"
            encrypted_backup = await self.encrypt_backup(backup_data)

            backup_path = f"/backups/{device.hostname}/{backup_filename}"
            await self.store_backup(backup_path, encrypted_backup)

            return backup_path

    async def encrypt_backup(self, backup_data: bytes) -> bytes:
        """Encrypt backup data"""
        from cryptography.fernet import Fernet

        key = Fernet.generate_key()
        f = Fernet(key)
        encrypted_data = f.encrypt(backup_data)

        # Store key securely (implement proper key management)
        return encrypted_data

# Docker Compose for OpnSense Enterprise Management
def generate_opnsense_management_stack():
    """Generate Docker Compose stack for OpnSense enterprise management"""

    docker_compose = '''
version: '3.8'

services:
  opnsense-manager:
    build:
      context: ./opnsense-manager
      dockerfile: Dockerfile
    container_name: opnsense-enterprise-manager
    restart: unless-stopped
    environment:
      - DATABASE_URL=postgresql://opnsense:password@postgres:5432/opnsense_mgmt
      - REDIS_URL=redis://redis:6379/0
      - LOG_LEVEL=INFO
      - API_ENCRYPTION_KEY=${API_ENCRYPTION_KEY}
    volumes:
      - ./config:/app/config
      - ./backups:/app/backups
      - ./certificates:/app/certificates
      - ./logs:/app/logs
    ports:
      - "8445:8443"  # Management UI
      - "9094:9090"  # Metrics
    networks:
      - opnsense_mgmt
    depends_on:
      - postgres
      - redis

  prometheus:
    image: prom/prometheus:latest
    container_name: opnsense-prometheus
    restart: unless-stopped
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=30d'
      - '--web.enable-lifecycle'
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - ./monitoring/rules:/etc/prometheus/rules:ro
      - prometheus_data:/prometheus
    ports:
      - "9095:9090"
    networks:
      - opnsense_mgmt

  grafana:
    image: grafana/grafana:latest
    container_name: opnsense-grafana
    restart: unless-stopped
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASSWORD}
      - GF_SERVER_ROOT_URL=https://opnsense-monitoring.company.com/grafana
      - GF_DATABASE_TYPE=postgres
      - GF_DATABASE_HOST=postgres:5432
      - GF_DATABASE_NAME=opnsense_grafana
      - GF_DATABASE_USER=opnsense
      - GF_DATABASE_PASSWORD=password
      - GF_INSTALL_PLUGINS=grafana-piechart-panel,grafana-worldmap-panel
    volumes:
      - grafana_data:/var/lib/grafana
      - ./monitoring/grafana/dashboards:/etc/grafana/provisioning/dashboards
      - ./monitoring/grafana/datasources:/etc/grafana/provisioning/datasources
    ports:
      - "3003:3000"
    networks:
      - opnsense_mgmt
    depends_on:
      - postgres
      - prometheus

  influxdb:
    image: influxdb:2.7
    container_name: opnsense-influxdb
    restart: unless-stopped
    environment:
      - DOCKER_INFLUXDB_INIT_MODE=setup
      - DOCKER_INFLUXDB_INIT_USERNAME=admin
      - DOCKER_INFLUXDB_INIT_PASSWORD=password
      - DOCKER_INFLUXDB_INIT_ORG=opnsense
      - DOCKER_INFLUXDB_INIT_BUCKET=metrics
      - DOCKER_INFLUXDB_INIT_ADMIN_TOKEN=opnsense-token
    volumes:
      - influxdb_data:/var/lib/influxdb2
    ports:
      - "8087:8086"
    networks:
      - opnsense_mgmt

  postgres:
    image: postgres:14
    container_name: opnsense-postgres
    restart: unless-stopped
    environment:
      - POSTGRES_DB=opnsense_mgmt
      - POSTGRES_USER=opnsense
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./sql/init.sql:/docker-entrypoint-initdb.d/init.sql
    networks:
      - opnsense_mgmt

  redis:
    image: redis:7-alpine
    container_name: opnsense-redis
    restart: unless-stopped
    command: redis-server --appendonly yes --requirepass password
    volumes:
      - redis_data:/data
    networks:
      - opnsense_mgmt

  backup-service:
    build:
      context: ./backup-service
      dockerfile: Dockerfile
    container_name: opnsense-backup-service
    restart: unless-stopped
    environment:
      - BACKUP_SCHEDULE=0 2 * * *
      - S3_BUCKET=${BACKUP_S3_BUCKET}
      - S3_ACCESS_KEY=${BACKUP_S3_ACCESS_KEY}
      - S3_SECRET_KEY=${BACKUP_S3_SECRET_KEY}
      - ENCRYPTION_KEY=${BACKUP_ENCRYPTION_KEY}
    volumes:
      - ./backups:/app/backups
      - ./config:/app/config:ro
    networks:
      - opnsense_mgmt
    depends_on:
      - opnsense-manager

  alertmanager:
    image: prom/alertmanager:latest
    container_name: opnsense-alertmanager
    restart: unless-stopped
    command:
      - '--config.file=/etc/alertmanager/alertmanager.yml'
      - '--storage.path=/alertmanager'
      - '--web.external-url=http://localhost:9093'
    volumes:
      - ./monitoring/alertmanager.yml:/etc/alertmanager/alertmanager.yml:ro
      - alertmanager_data:/alertmanager
    ports:
      - "9096:9093"
    networks:
      - opnsense_mgmt

volumes:
  postgres_data:
  redis_data:
  prometheus_data:
  grafana_data:
  influxdb_data:
  alertmanager_data:

networks:
  opnsense_mgmt:
    driver: bridge
    ipam:
      config:
        - subnet: 172.28.0.0/16
'''

    return docker_compose

def main():
    """Main function demonstrating OpnSense enterprise management"""

    # Example configuration
    config = {
        'devices': [
            {
                'device_id': 'fw-001',
                'hostname': 'opnsense-primary',
                'management_ip': '192.168.1.1',
                'api_key': 'admin',
                'api_secret': 'secure_secret',
                'version': '23.7',
                'role': 'primary',
                'cluster_id': 'cluster-01',
                'organization': 'headquarters'
            },
            {
                'device_id': 'fw-002',
                'hostname': 'opnsense-secondary',
                'management_ip': '192.168.1.2',
                'api_key': 'admin',
                'api_secret': 'secure_secret',
                'version': '23.7',
                'role': 'secondary',
                'cluster_id': 'cluster-01',
                'organization': 'headquarters'
            }
        ],
        'security_policies': [
            {
                'policy_id': 'enterprise-policy-01',
                'name': 'Enterprise Security Policy',
                'description': 'Comprehensive enterprise security policy',
                'firewall_rules': [],
                'ids_rules': [],
                'vpn_policies': [],
                'compliance_frameworks': ['NIST_CSF', 'ISO27001'],
                'monitoring_config': {}
            }
        ]
    }

    # Generate Docker stack
    docker_stack = generate_opnsense_management_stack()
    print("OpnSense enterprise management stack generated")

    # Initialize enterprise manager
    manager = OpnSenseEnterpriseManager('/tmp/opnsense_config.yaml')

    # Run async initialization
    async def run_manager():
        result = await manager.initialize_enterprise_platform()
        print(f"OpnSense enterprise platform initialization: {result}")

    # Run the manager
    asyncio.run(run_manager())

if __name__ == '__main__':
    main()
```

## AI Implementation Guidelines

### Enterprise OpnSense Deployment Framework

1. **Advanced Security Architecture**

   - **Zero-Trust Network**: Implement micro-segmentation with dynamic firewall rules and continuous verification
   - **Threat Intelligence**: Integration with commercial and open-source threat feeds for real-time blocking
   - **Advanced IDS/IPS**: Suricata with custom rules, machine learning anomaly detection, and automated response
   - **Certificate Management**: Automated PKI with device certificates, ACME integration, and lifecycle management

2. **High-Availability and Clustering**

   - **CARP Configuration**: Advanced CARP setup with health monitoring and automated failover
   - **State Synchronization**: Real-time state table and configuration synchronization across cluster nodes
   - **Geographic Distribution**: Multi-site deployment with WAN optimization and site-to-site VPN
   - **Load Balancing**: Intelligent traffic distribution with health checks and failover mechanisms

3. **Enterprise Management and Automation**
   - **Centralized Management**: RESTful API-based management with role-based access control
   - **Configuration Templates**: Parameterized configuration templates with organization-specific policies
   - **Automated Provisioning**: Zero-touch provisioning with automated device registration and configuration
   - **Change Management**: Version-controlled configurations with approval workflows and rollback capabilities

### Advanced Monitoring and Compliance

1. **Comprehensive Monitoring Stack**

   - **Metrics Collection**: Prometheus, Telegraf, and InfluxDB integration for comprehensive metrics
   - **Visualization**: Grafana dashboards with drill-down capabilities and custom alerting
   - **Log Management**: Centralized logging with ELK stack integration and real-time analysis
   - **Performance Analytics**: Capacity planning and performance optimization recommendations

2. **Enterprise Compliance Framework**

   - **Multi-Framework Support**: NIST CSF, ISO 27001, PCI DSS, HIPAA, and SOX compliance templates
   - **Automated Auditing**: Continuous compliance monitoring with automated remediation
   - **Reporting**: Automated compliance reports with executive dashboards and drill-down capabilities
   - **Risk Assessment**: Continuous risk assessment with vulnerability management integration

3. **Security Orchestration and Response**
   - **SIEM Integration**: Real-time security event correlation with automated incident response
   - **Threat Hunting**: Advanced analytics for proactive threat detection and investigation
   - **Incident Response**: Automated containment and remediation with escalation workflows
   - **Forensics**: Comprehensive audit trails with tamper-proof logging and chain of custody

### Performance Optimization and Scaling

1. **Network Performance Optimization**

   - **Hardware Acceleration**: Leverage AES-NI, Intel DPDK, and hardware offloading capabilities
   - **Traffic Engineering**: QoS implementation with traffic shaping and bandwidth management
   - **Connection Optimization**: TCP optimization, connection pooling, and session persistence
   - **Caching Strategies**: DNS caching, content caching, and proxy optimization

2. **Scalability and Resource Management**
   - **Horizontal Scaling**: Multi-node deployment with load balancing and service distribution
   - **Resource Monitoring**: Real-time resource utilization monitoring with predictive scaling
   - **Capacity Planning**: Automated capacity planning with growth projections and recommendations
   - **Performance Tuning**: Automated performance optimization based on traffic patterns and usage

### Integration and Ecosystem

1. **Enterprise Integration**

   - **Identity Management**: LDAP/AD integration with SSO and multi-factor authentication
   - **Network Integration**: IPAM integration, DNS automation, and VLAN management
   - **Security Integration**: SIEM, vulnerability scanners, and threat intelligence platforms
   - **Orchestration**: Ansible, Terraform, and Infrastructure-as-Code integration

2. **API and Automation**
   - **RESTful API**: Comprehensive API coverage with OpenAPI documentation and SDKs
   - **Webhook Integration**: Real-time event notifications with webhook and messaging integration
   - **Automation Framework**: Python SDK with enterprise automation patterns and best practices
   - **CI/CD Integration**: GitOps workflows with automated testing and deployment

## Security Tool Overview

- **Platform**: OpnSense Enterprise Firewall with Advanced Management Framework
- **Version**: 23.7+ with Enterprise Extensions and Automation Platform
- **Type**: Hardened Firewall and Enterprise Security Appliance
- **License**: BSD License with Commercial Enterprise Support
- **Use Cases**: Enterprise security, network segmentation, compliance environments, managed security services
