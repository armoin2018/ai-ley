---
ai-system-type: 'network-management-platform'
category: 'security'
subcategory: 'network-management'
difficulty: 'advanced'
prerequisites: ['openwrt', 'network-administration', 'python-django']
technical-quality: 4.8
ai-usability: 4.8
cross-references:
  - 'openwrt.instructions.md'
  - 'libremesh.instructions.md'
  - 'nmap.instructions.md'
  - 'pfsense.instructions.md'
version: '2.0'
last-updated: '2024-12-28'
---

# OpenWISP Network Management Security Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents regarding OpenWISP centralized network management platform for OpenWrt-based devices, covering zero-touch provisioning, configuration management, monitoring, and scalable network infrastructure deployment for enterprise and ISP environments.

### When to Use OpenWISP

- **Large-scale deployments** requiring centralized management of OpenWrt devices
- **ISP operations** with distributed wireless and edge network infrastructure
- **Enterprise networks** needing unified configuration and monitoring across sites
- **Municipal Wi-Fi** projects requiring comprehensive device and user management
- **Campus networks** with complex hierarchical organization and access control

### When to Avoid OpenWISP

- **Small deployments** where manual configuration is more efficient
- **Non-OpenWrt** environments requiring different management approaches
- **Resource-constrained** scenarios lacking infrastructure for centralized management
- **Simple networks** not requiring advanced configuration templating and automation

### Architecture Essentials

- **Controller Platform**: Django-based OpenWISP Controller for centralized management
- **Device Agents**: netjsonconfig agents on devices for secure communication
- **Management Components**: Firmware Upgrader, Monitoring, RADIUS/Portal integration
- **Communication Security**: HTTPS with mutual authentication and certificate management
- **Data Model**: NetJSON configuration format with hierarchical organizations and RBAC

### Security and Compliance Guidelines

- **Authentication**: Enforce device HTTPS with valid certificates and token-based authentication
- **Access Control**: Implement comprehensive RBAC with least-privilege principles
- **Network Isolation**: Restrict device management access to VPN or dedicated management VLANs
- **Credential Management**: Use secure credential storage and regular rotation policies
- **Asset Security**: Maintain comprehensive inventory with ownership and decommissioning procedures

### Performance Best Practices

- **Template Management**: Create reusable configuration templates with parameterization
- **Staged Deployments**: Implement canary rollouts with health checks and auto-rollback
- **Monitoring Integration**: Export metrics to time-series databases with comprehensive alerting
- **Resource Planning**: Size infrastructure for device scale and configuration complexity
- **CI/CD Integration**: Treat configurations as code with version control and validation

### AI Assistant Guidelines

- Always provide parameterized configuration templates rather than device-specific configurations
- Include comprehensive RBAC and security hardening recommendations for all deployments
- Suggest staged rollout procedures with health monitoring and rollback capabilities
- Provide monitoring and alerting configurations tied to critical performance indicators
- Include disaster recovery and backup procedures for centralized management infrastructure
- Recommend integration patterns with existing network management and security tools

### Enterprise OpenWisp Management Framework

```python
#!/usr/bin/env python3
# openwisp-enterprise-orchestrator.py - Advanced OpenWisp enterprise management framework

import asyncio
import json
import yaml
import logging
import requests
import aiohttp
import websockets
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional
from dataclasses import dataclass, asdict
import hashlib
import jwt
import ssl
import os
from urllib.parse import urljoin

@dataclass
class DeviceConfiguration:
    """Device configuration data model"""
    device_id: str
    hostname: str
    organization: str
    config_template: str
    variables: Dict[str, Any]
    tags: List[str]
    location: Dict[str, Any]
    hardware_model: str
    firmware_version: str

@dataclass
class OrganizationPolicy:
    """Organization security and management policy"""
    organization_id: str
    name: str
    security_policy: Dict[str, Any]
    compliance_framework: List[str]
    monitoring_config: Dict[str, Any]
    backup_policy: Dict[str, Any]
    access_control: Dict[str, Any]

class OpenWispEnterpriseOrchestrator:
    """Advanced OpenWisp enterprise orchestration platform"""

    def __init__(self, config_file: str):
        self.config = self.load_configuration(config_file)
        self.session = None
        self.websocket_connections = {}
        self.device_manager = DeviceManager(self.config)
        self.template_engine = ConfigurationTemplateEngine()
        self.monitoring_manager = MonitoringManager(self.config)
        self.compliance_engine = ComplianceEngine()
        self.backup_manager = BackupManager(self.config)

        # Setup logging
        logging.basicConfig(
            level=getattr(logging, self.config.get('log_level', 'INFO')),
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler(self.config.get('log_file', 'openwisp_enterprise.log')),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)

    def load_configuration(self, config_file: str) -> Dict[str, Any]:
        """Load enterprise configuration from YAML file"""
        with open(config_file, 'r') as f:
            return yaml.safe_load(f)

    async def initialize_enterprise_platform(self):
        """Initialize complete enterprise platform"""
        self.logger.info("Initializing OpenWisp Enterprise Platform")

        try:
            # Initialize HTTP session with authentication
            await self.initialize_session()

            # Setup organization hierarchies
            await self.setup_organization_structure()

            # Deploy configuration templates
            await self.deploy_configuration_templates()

            # Initialize device fleet management
            device_results = await self.device_manager.initialize_device_fleet()

            # Setup monitoring and alerting
            monitoring_results = await self.monitoring_manager.setup_comprehensive_monitoring()

            # Initialize compliance framework
            compliance_results = await self.compliance_engine.initialize_compliance_monitoring()

            # Setup automated backup system
            backup_results = await self.backup_manager.initialize_backup_system()

            return {
                'status': 'success',
                'devices_managed': device_results.get('devices_count', 0),
                'monitoring_endpoints': monitoring_results.get('endpoints_count', 0),
                'compliance_policies': compliance_results.get('policies_count', 0),
                'backup_jobs': backup_results.get('jobs_count', 0)
            }

        except Exception as e:
            self.logger.error(f"Platform initialization failed: {e}")
            raise

    async def initialize_session(self):
        """Initialize authenticated HTTP session"""
        auth_url = urljoin(self.config['openwisp_url'], '/api/v1/user/token/')

        credentials = {
            'username': self.config['api_username'],
            'password': self.config['api_password']
        }

        ssl_context = ssl.create_default_context()
        if not self.config.get('verify_ssl', True):
            ssl_context.check_hostname = False
            ssl_context.verify_mode = ssl.CERT_NONE

        connector = aiohttp.TCPConnector(ssl=ssl_context)

        self.session = aiohttp.ClientSession(
            connector=connector,
            timeout=aiohttp.ClientTimeout(total=30),
            headers={
                'Content-Type': 'application/json',
                'User-Agent': 'OpenWisp-Enterprise-Orchestrator/1.0'
            }
        )

        async with self.session.post(auth_url, json=credentials) as response:
            if response.status == 200:
                auth_data = await response.json()
                self.session.headers['Authorization'] = f"Bearer {auth_data['key']}"
                self.logger.info("Authentication successful")
            else:
                raise Exception(f"Authentication failed: {response.status}")

    async def setup_organization_structure(self):
        """Setup hierarchical organization structure"""
        organizations = self.config.get('organizations', [])

        for org_config in organizations:
            org_data = {
                'name': org_config['name'],
                'slug': org_config['slug'],
                'description': org_config.get('description', ''),
                'is_active': True,
                'created': datetime.now().isoformat(),
                'modified': datetime.now().isoformat()
            }

            # Create organization
            org_url = urljoin(self.config['openwisp_url'], '/api/v1/controller/organization/')
            async with self.session.post(org_url, json=org_data) as response:
                if response.status in [200, 201]:
                    org_result = await response.json()
                    self.logger.info(f"Organization '{org_config['name']}' created/updated")

                    # Setup organization-specific policies
                    if 'policy' in org_config:
                        policy = OrganizationPolicy(
                            organization_id=org_result['id'],
                            name=org_config['name'],
                            **org_config['policy']
                        )
                        await self.apply_organization_policy(policy)

                elif response.status != 400:  # 400 might mean already exists
                    self.logger.error(f"Failed to create organization: {response.status}")

    async def deploy_configuration_templates(self):
        """Deploy configuration templates with advanced features"""
        templates = self.config.get('configuration_templates', [])

        for template_config in templates:
            template_data = await self.template_engine.generate_template(template_config)

            # Create/update template
            template_url = urljoin(self.config['openwisp_url'], '/api/v1/controller/template/')
            async with self.session.post(template_url, json=template_data) as response:
                if response.status in [200, 201]:
                    self.logger.info(f"Template '{template_config['name']}' deployed")
                else:
                    self.logger.error(f"Template deployment failed: {response.status}")

class DeviceManager:
    """Advanced device management with enterprise features"""

    def __init__(self, config):
        self.config = config
        self.device_registry = {}
        self.firmware_manager = FirmwareManager(config)
        self.provisioning_engine = ZeroTouchProvisioning(config)
        self.health_monitor = DeviceHealthMonitor()

    async def initialize_device_fleet(self):
        """Initialize and manage device fleet"""
        self.logger = logging.getLogger(f"{__name__}.DeviceManager")

        # Discover existing devices
        await self.discover_existing_devices()

        # Setup zero-touch provisioning
        await self.provisioning_engine.setup_provisioning_server()

        # Initialize health monitoring
        await self.health_monitor.initialize_monitoring()

        # Setup firmware management
        await self.firmware_manager.initialize_firmware_repository()

        return {
            'status': 'success',
            'devices_count': len(self.device_registry),
            'provisioning_enabled': True,
            'monitoring_active': True
        }

    async def discover_existing_devices(self):
        """Discover and catalog existing devices"""
        devices_url = urljoin(self.config['openwisp_url'], '/api/v1/controller/device/')

        async with aiohttp.ClientSession() as session:
            session.headers['Authorization'] = f"Bearer {self.config['api_key']}"

            async with session.get(devices_url) as response:
                if response.status == 200:
                    devices_data = await response.json()

                    for device_data in devices_data['results']:
                        device_config = DeviceConfiguration(
                            device_id=device_data['id'],
                            hostname=device_data['name'],
                            organization=device_data['organization']['name'],
                            config_template=device_data.get('config', {}).get('template', ''),
                            variables=device_data.get('config', {}).get('context', {}),
                            tags=device_data.get('tags', []),
                            location=device_data.get('location', {}),
                            hardware_model=device_data.get('hardware_model', ''),
                            firmware_version=device_data.get('firmware_version', '')
                        )

                        self.device_registry[device_config.device_id] = device_config

                    self.logger.info(f"Discovered {len(self.device_registry)} existing devices")

class ConfigurationTemplateEngine:
    """Advanced configuration template management"""

    def __init__(self):
        self.template_cache = {}
        self.variable_registry = {}

    async def generate_template(self, template_config: Dict[str, Any]) -> Dict[str, Any]:
        """Generate comprehensive configuration template"""

        base_template = {
            'name': template_config['name'],
            'organization': template_config.get('organization'),
            'type': 'generic',
            'tags': template_config.get('tags', []),
            'default': template_config.get('default', False),
            'auto_cert': True,
            'config': await self.generate_netjson_config(template_config)
        }

        # Add advanced features
        if template_config.get('enable_vpn'):
            base_template['config']['vpn'] = await self.generate_vpn_config(template_config)

        if template_config.get('enable_monitoring'):
            base_template['config']['monitoring'] = await self.generate_monitoring_config(template_config)

        if template_config.get('enable_security_policies'):
            base_template['config']['firewall'] = await self.generate_security_policies(template_config)

        return base_template

    async def generate_netjson_config(self, template_config: Dict[str, Any]) -> Dict[str, Any]:
        """Generate NetJSON configuration with enterprise features"""

        config = {
            'interfaces': await self.generate_interface_config(template_config),
            'radios': await self.generate_radio_config(template_config),
            'system': await self.generate_system_config(template_config),
            'firewall': await self.generate_firewall_config(template_config)
        }

        # Add VLAN configuration for enterprise networks
        if template_config.get('vlans'):
            config['switch'] = await self.generate_vlan_config(template_config['vlans'])

        # Add QoS configuration
        if template_config.get('qos_enabled'):
            config['tc'] = await self.generate_qos_config(template_config)

        return config

    async def generate_interface_config(self, template_config: Dict[str, Any]) -> List[Dict[str, Any]]:
        """Generate enterprise interface configuration"""
        interfaces = [
            {
                'name': 'lo',
                'type': 'loopback',
                'addresses': [{'address': '127.0.0.1/8', 'family': 'ipv4'}]
            },
            {
                'name': 'br-lan',
                'type': 'bridge',
                'proto': 'static',
                'addresses': [{'address': '{{lan_ip}}/24', 'family': 'ipv4'}],
                'bridge_members': ['eth0.1']
            },
            {
                'name': 'eth0.2',
                'type': 'ethernet',
                'proto': 'dhcp'
            }
        ]

        # Add management interface
        if template_config.get('management_vlan'):
            interfaces.append({
                'name': f"eth0.{template_config['management_vlan']}",
                'type': 'ethernet',
                'proto': 'static',
                'addresses': [{'address': '{{mgmt_ip}}/24', 'family': 'ipv4'}]
            })

        # Add guest network
        if template_config.get('guest_network'):
            interfaces.append({
                'name': 'br-guest',
                'type': 'bridge',
                'proto': 'static',
                'addresses': [{'address': '192.168.100.1/24', 'family': 'ipv4'}],
                'bridge_members': ['wlan0-guest']
            })

        return interfaces

    async def generate_security_policies(self, template_config: Dict[str, Any]) -> Dict[str, Any]:
        """Generate comprehensive security policies"""

        firewall_config = {
            'defaults': {
                'input': 'REJECT',
                'output': 'ACCEPT',
                'forward': 'REJECT',
                'syn_flood': True,
                'drop_invalid': True
            },
            'zones': [
                {
                    'name': 'lan',
                    'network': ['br-lan'],
                    'input': 'ACCEPT',
                    'output': 'ACCEPT',
                    'forward': 'ACCEPT'
                },
                {
                    'name': 'wan',
                    'network': ['eth0.2'],
                    'input': 'REJECT',
                    'output': 'ACCEPT',
                    'forward': 'REJECT',
                    'masq': True
                }
            ],
            'rules': [
                {
                    'name': 'Allow-DHCP-Renew',
                    'src': 'wan',
                    'proto': 'udp',
                    'dest_port': 68,
                    'target': 'ACCEPT'
                },
                {
                    'name': 'Allow-Ping',
                    'src': 'wan',
                    'proto': 'icmp',
                    'icmp_type': ['echo-request'],
                    'family': 'ipv4',
                    'target': 'ACCEPT'
                }
            ]
        }

        # Add enterprise security rules
        if template_config.get('block_inter_vlan'):
            firewall_config['rules'].extend([
                {
                    'name': 'Block-Guest-to-LAN',
                    'src': 'guest',
                    'dest': 'lan',
                    'target': 'REJECT'
                },
                {
                    'name': 'Block-IoT-to-LAN',
                    'src': 'iot',
                    'dest': 'lan',
                    'target': 'REJECT'
                }
            ])

        # Add DDoS protection
        if template_config.get('ddos_protection'):
            firewall_config['rules'].extend([
                {
                    'name': 'DDoS-Protection',
                    'src': 'wan',
                    'proto': 'tcp',
                    'extra': ['--tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE'],
                    'target': 'DROP'
                },
                {
                    'name': 'Rate-Limit-SSH',
                    'src': 'wan',
                    'proto': 'tcp',
                    'dest_port': 22,
                    'extra': ['--limit 3/min --limit-burst 3'],
                    'target': 'ACCEPT'
                }
            ])

        return firewall_config

class ZeroTouchProvisioning:
    """Zero-touch provisioning system"""

    def __init__(self, config):
        self.config = config
        self.provisioning_server = None
        self.certificate_manager = CertificateManager()

    async def setup_provisioning_server(self):
        """Setup zero-touch provisioning server"""
        # Configure DHCP options for automatic discovery
        dhcp_config = {
            'option_66': self.config['provisioning_server_url'],  # TFTP server
            'option_67': 'provision.sh',  # Boot file
            'option_43': f"openwisp-controller={self.config['openwisp_url']}"
        }

        # Setup provisioning endpoints
        await self.setup_provisioning_endpoints()

        # Initialize certificate authority for device certificates
        await self.certificate_manager.initialize_ca()

        return {'status': 'success', 'provisioning_active': True}

    async def setup_provisioning_endpoints(self):
        """Setup REST endpoints for device provisioning"""
        from aiohttp import web

        app = web.Application()

        # Device registration endpoint
        app.router.add_post('/api/provision/register', self.handle_device_registration)

        # Configuration delivery endpoint
        app.router.add_get('/api/provision/config/{device_id}', self.handle_config_delivery)

        # Certificate signing endpoint
        app.router.add_post('/api/provision/csr', self.handle_csr_signing)

        # Firmware download endpoint
        app.router.add_get('/api/provision/firmware/{model}', self.handle_firmware_download)

        self.provisioning_server = app

    async def handle_device_registration(self, request):
        """Handle new device registration"""
        from aiohttp import web

        try:
            device_data = await request.json()

            # Validate device data
            required_fields = ['mac_address', 'hardware_model', 'serial_number']
            if not all(field in device_data for field in required_fields):
                return web.json_response({'error': 'Missing required fields'}, status=400)

            # Register device in OpenWisp
            registration_result = await self.register_device_in_openwisp(device_data)

            if registration_result['status'] == 'success':
                return web.json_response({
                    'status': 'registered',
                    'device_id': registration_result['device_id'],
                    'config_url': f"/api/provision/config/{registration_result['device_id']}",
                    'next_steps': [
                        'Download configuration',
                        'Apply configuration',
                        'Request certificate',
                        'Establish secure connection'
                    ]
                })
            else:
                return web.json_response({'error': 'Registration failed'}, status=500)

        except Exception as e:
            return web.json_response({'error': str(e)}, status=500)

class MonitoringManager:
    """Comprehensive monitoring and alerting system"""

    def __init__(self, config):
        self.config = config
        self.monitoring_endpoints = {}
        self.alert_manager = AlertManager(config)
        self.metrics_collector = MetricsCollector()

    async def setup_comprehensive_monitoring(self):
        """Setup comprehensive monitoring infrastructure"""

        # Setup device health monitoring
        await self.setup_device_health_monitoring()

        # Setup network performance monitoring
        await self.setup_network_performance_monitoring()

        # Setup security monitoring
        await self.setup_security_monitoring()

        # Setup application monitoring
        await self.setup_application_monitoring()

        # Initialize alerting
        await self.alert_manager.initialize_alerting()

        return {
            'status': 'success',
            'endpoints_count': len(self.monitoring_endpoints),
            'metrics_active': True,
            'alerting_configured': True
        }

    async def setup_device_health_monitoring(self):
        """Setup device health monitoring with comprehensive metrics"""

        health_metrics = [
            'cpu_utilization',
            'memory_usage',
            'disk_usage',
            'network_interface_status',
            'wireless_signal_strength',
            'connected_clients_count',
            'uptime',
            'temperature',
            'power_consumption'
        ]

        for metric in health_metrics:
            endpoint_config = {
                'metric_name': metric,
                'collection_interval': 60,  # seconds
                'alert_thresholds': self.get_metric_thresholds(metric),
                'retention_days': 90
            }

            self.monitoring_endpoints[metric] = endpoint_config

class ComplianceEngine:
    """Enterprise compliance and governance engine"""

    def __init__(self):
        self.compliance_frameworks = {
            'SOC2': self.get_soc2_requirements(),
            'ISO27001': self.get_iso27001_requirements(),
            'HIPAA': self.get_hipaa_requirements(),
            'PCI_DSS': self.get_pci_dss_requirements(),
            'NIST_CSF': self.get_nist_csf_requirements()
        }

    async def initialize_compliance_monitoring(self):
        """Initialize compliance monitoring across all frameworks"""

        active_frameworks = []

        for framework_name, requirements in self.compliance_frameworks.items():
            try:
                compliance_result = await self.setup_framework_monitoring(framework_name, requirements)
                if compliance_result['status'] == 'success':
                    active_frameworks.append(framework_name)

            except Exception as e:
                logging.error(f"Failed to setup {framework_name} compliance: {e}")

        return {
            'status': 'success',
            'active_frameworks': active_frameworks,
            'policies_count': sum(len(reqs) for reqs in self.compliance_frameworks.values())
        }

    def get_iso27001_requirements(self):
        """ISO 27001 compliance requirements for network infrastructure"""
        return {
            'access_control': {
                'A.9.1.1': 'Access control policy',
                'A.9.1.2': 'Access to networks and network services',
                'A.9.2.1': 'User registration and deregistration',
                'A.9.2.2': 'User access provisioning',
                'A.9.2.3': 'Management of privileged access rights',
                'A.9.2.4': 'Management of secret authentication information',
                'A.9.2.5': 'Review of user access rights',
                'A.9.2.6': 'Removal or adjustment of access rights'
            },
            'communications_security': {
                'A.13.1.1': 'Network controls',
                'A.13.1.2': 'Security of network services',
                'A.13.1.3': 'Segregation in networks',
                'A.13.2.1': 'Information transfer policies and procedures',
                'A.13.2.2': 'Agreements on information transfer',
                'A.13.2.3': 'Electronic messaging'
            },
            'operations_security': {
                'A.12.1.1': 'Documented operating procedures',
                'A.12.1.2': 'Change management',
                'A.12.1.3': 'Capacity management',
                'A.12.1.4': 'Separation of development, testing and operational environments',
                'A.12.6.1': 'Management of technical vulnerabilities',
                'A.12.6.2': 'Restrictions on software installation'
            }
        }

# Docker Compose for OpenWisp Enterprise Management
def generate_openwisp_enterprise_stack():
    """Generate Docker Compose stack for OpenWisp enterprise management"""

    docker_compose = '''
version: '3.8'

services:
  openwisp-controller:
    image: openwisp/openwisp-controller:latest
    container_name: openwisp-controller
    restart: unless-stopped
    environment:
      - DEBUG=False
      - DATABASE_URL=postgres://openwisp:password@postgres:5432/openwisp_controller
      - REDIS_URL=redis://redis:6379/0
      - EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
      - EMAIL_HOST=${SMTP_HOST}
      - EMAIL_PORT=${SMTP_PORT}
      - EMAIL_USE_TLS=True
      - DEFAULT_FROM_EMAIL=${FROM_EMAIL}
      - ALLOWED_HOSTS=openwisp.company.com,localhost
      - OPENWISP_CONTROLLER_CONTEXT={'vpn_ca': '/opt/openwisp/certs/ca.crt'}
    volumes:
      - controller_media:/opt/openwisp/media
      - controller_static:/opt/openwisp/static
      - ./certs:/opt/openwisp/certs
      - ./config:/opt/openwisp/config
    ports:
      - "8000:8000"
    networks:
      - openwisp_network
    depends_on:
      - postgres
      - redis

  openwisp-monitoring:
    image: openwisp/openwisp-monitoring:latest
    container_name: openwisp-monitoring
    restart: unless-stopped
    environment:
      - DATABASE_URL=postgres://openwisp:password@postgres:5432/openwisp_monitoring
      - REDIS_URL=redis://redis:6379/1
      - INFLUXDB_URL=http://influxdb:8086
      - INFLUXDB_DATABASE=openwisp
      - OPENWISP_CONTROLLER_URL=http://openwisp-controller:8000
    volumes:
      - monitoring_media:/opt/openwisp/media
    ports:
      - "8001:8000"
    networks:
      - openwisp_network
    depends_on:
      - postgres
      - redis
      - influxdb

  openwisp-radius:
    image: openwisp/openwisp-radius:latest
    container_name: openwisp-radius
    restart: unless-stopped
    environment:
      - DATABASE_URL=postgres://openwisp:password@postgres:5432/openwisp_radius
      - REDIS_URL=redis://redis:6379/2
      - OPENWISP_CONTROLLER_URL=http://openwisp-controller:8000
      - FREERADIUS_ALLOWED_HOSTS=0.0.0.0/0
    volumes:
      - radius_media:/opt/openwisp/media
      - ./freeradius:/etc/freeradius
    ports:
      - "8002:8000"
      - "1812:1812/udp"  # RADIUS Authentication
      - "1813:1813/udp"  # RADIUS Accounting
    networks:
      - openwisp_network
    depends_on:
      - postgres
      - redis

  openwisp-firmware-upgrader:
    image: openwisp/openwisp-firmware-upgrader:latest
    container_name: openwisp-firmware-upgrader
    restart: unless-stopped
    environment:
      - DATABASE_URL=postgres://openwisp:password@postgres:5432/openwisp_firmware
      - REDIS_URL=redis://redis:6379/3
      - OPENWISP_CONTROLLER_URL=http://openwisp-controller:8000
      - FIRMWARE_STORAGE_PATH=/opt/openwisp/firmware
    volumes:
      - firmware_media:/opt/openwisp/media
      - firmware_storage:/opt/openwisp/firmware
    ports:
      - "8003:8000"
    networks:
      - openwisp_network
    depends_on:
      - postgres
      - redis

  nginx:
    image: nginx:alpine
    container_name: openwisp-nginx
    restart: unless-stopped
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/ssl:/etc/nginx/ssl:ro
      - controller_static:/var/www/static
      - controller_media:/var/www/media
    ports:
      - "443:443"
      - "80:80"
    networks:
      - openwisp_network
    depends_on:
      - openwisp-controller
      - openwisp-monitoring
      - openwisp-radius

  postgres:
    image: postgres:14
    container_name: openwisp-postgres
    restart: unless-stopped
    environment:
      - POSTGRES_DB=openwisp_controller
      - POSTGRES_USER=openwisp
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./sql/init.sql:/docker-entrypoint-initdb.d/init.sql
    networks:
      - openwisp_network

  redis:
    image: redis:7-alpine
    container_name: openwisp-redis
    restart: unless-stopped
    volumes:
      - redis_data:/data
    networks:
      - openwisp_network

  influxdb:
    image: influxdb:1.8
    container_name: openwisp-influxdb
    restart: unless-stopped
    environment:
      - INFLUXDB_DB=openwisp
      - INFLUXDB_ADMIN_USER=admin
      - INFLUXDB_ADMIN_PASSWORD=password
      - INFLUXDB_USER=openwisp
      - INFLUXDB_USER_PASSWORD=password
    volumes:
      - influxdb_data:/var/lib/influxdb
    networks:
      - openwisp_network

  grafana:
    image: grafana/grafana:latest
    container_name: openwisp-grafana
    restart: unless-stopped
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASSWORD}
      - GF_SERVER_ROOT_URL=https://openwisp.company.com/grafana
      - GF_DATABASE_TYPE=postgres
      - GF_DATABASE_HOST=postgres:5432
      - GF_DATABASE_NAME=openwisp_grafana
      - GF_DATABASE_USER=openwisp
      - GF_DATABASE_PASSWORD=password
    volumes:
      - grafana_data:/var/lib/grafana
      - ./monitoring/grafana/dashboards:/etc/grafana/provisioning/dashboards
      - ./monitoring/grafana/datasources:/etc/grafana/provisioning/datasources
    ports:
      - "3000:3000"
    networks:
      - openwisp_network
    depends_on:
      - postgres
      - influxdb

  celery:
    image: openwisp/openwisp-controller:latest
    container_name: openwisp-celery
    restart: unless-stopped
    command: celery -A openwisp2 worker -l info
    environment:
      - DATABASE_URL=postgres://openwisp:password@postgres:5432/openwisp_controller
      - REDIS_URL=redis://redis:6379/0
    volumes:
      - controller_media:/opt/openwisp/media
      - ./config:/opt/openwisp/config
    networks:
      - openwisp_network
    depends_on:
      - postgres
      - redis

  celery-beat:
    image: openwisp/openwisp-controller:latest
    container_name: openwisp-celery-beat
    restart: unless-stopped
    command: celery -A openwisp2 beat -l info
    environment:
      - DATABASE_URL=postgres://openwisp:password@postgres:5432/openwisp_controller
      - REDIS_URL=redis://redis:6379/0
    volumes:
      - controller_media:/opt/openwisp/media
      - ./config:/opt/openwisp/config
    networks:
      - openwisp_network
    depends_on:
      - postgres
      - redis

volumes:
  postgres_data:
  redis_data:
  influxdb_data:
  grafana_data:
  controller_media:
  controller_static:
  monitoring_media:
  radius_media:
  firmware_media:
  firmware_storage:

networks:
  openwisp_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.27.0.0/16
'''

    return docker_compose

def main():
    """Main function demonstrating OpenWisp enterprise orchestration"""

    # Example configuration
    config = {
        'openwisp_url': 'https://openwisp.company.com',
        'api_username': 'admin',
        'api_password': 'secure_password',
        'log_level': 'INFO',
        'organizations': [
            {
                'name': 'Enterprise HQ',
                'slug': 'enterprise-hq',
                'policy': {
                    'security_policy': {'encryption_required': True},
                    'compliance_framework': ['ISO27001', 'SOC2'],
                    'monitoring_config': {'metrics_retention': 365}
                }
            }
        ],
        'configuration_templates': [
            {
                'name': 'Enterprise Gateway Template',
                'organization': 'enterprise-hq',
                'enable_vpn': True,
                'enable_monitoring': True,
                'enable_security_policies': True,
                'management_vlan': 100,
                'guest_network': True
            }
        ]
    }

    # Initialize orchestrator
    orchestrator = OpenWispEnterpriseOrchestrator('/tmp/config.yaml')

    # Generate Docker stack
    docker_stack = generate_openwisp_enterprise_stack()
    print("OpenWisp enterprise Docker stack generated")

    # Run async initialization
    async def run_orchestrator():
        result = await orchestrator.initialize_enterprise_platform()
        print(f"OpenWisp enterprise platform initialization: {result}")

    # Run the orchestrator
    asyncio.run(run_orchestrator())

if __name__ == '__main__':
    main()
```

## AI Implementation Guidelines

### Enterprise OpenWisp Deployment Framework

1. **Scalable Architecture Design**

   - **Microservices Architecture**: Deploy controller, monitoring, RADIUS, and firmware upgrader as separate services
   - **High Availability**: Multi-node deployment with load balancing and database clustering
   - **Geographic Distribution**: Multi-region deployment with local management nodes
   - **Container Orchestration**: Kubernetes deployment with auto-scaling and health monitoring

2. **Zero-Touch Provisioning System**

   - **Automated Discovery**: DHCP option-based device discovery with automatic registration
   - **Certificate Management**: Automated PKI with device certificate generation and rotation
   - **Configuration Templates**: Parameterized templates with organization-specific policies
   - **Staged Rollouts**: Canary deployments with health validation and automatic rollback

3. **Comprehensive Security Framework**
   - **Role-Based Access Control**: Granular RBAC with organization hierarchies and delegated administration
   - **Device Authentication**: Mutual TLS authentication with device certificates
   - **Network Segmentation**: VLAN-based isolation with firewall policy automation
   - **Security Monitoring**: Real-time threat detection with SIEM integration

### Advanced Management Capabilities

1. **Configuration Management**

   - **Template Engine**: Advanced NetJSON template generation with variable substitution
   - **Version Control**: Git-based configuration versioning with audit trails
   - **Compliance Validation**: Automated policy compliance checking and remediation
   - **Change Management**: Approval workflows with staged deployment processes

2. **Monitoring and Analytics**

   - **Real-Time Metrics**: Device health, performance, and security metrics collection
   - **Predictive Analytics**: Machine learning-based anomaly detection and capacity planning
   - **Custom Dashboards**: Grafana-based dashboards with organization-specific views
   - **Automated Alerting**: Multi-channel alerting with escalation and correlation

3. **Firmware and Lifecycle Management**
   - **Automated Updates**: Scheduled firmware updates with rollback capabilities
   - **Vulnerability Management**: Security patch deployment with risk assessment
   - **Device Lifecycle**: Automated provisioning, configuration, and decommissioning
   - **Asset Management**: Comprehensive device inventory with warranty tracking

### Enterprise Integration Patterns

1. **Identity and Access Management**

   - **LDAP/AD Integration**: Enterprise directory service integration
   - **SAML/OAuth2**: Single sign-on with enterprise identity providers
   - **RADIUS Integration**: 802.1X authentication with enterprise RADIUS
   - **Multi-Factor Authentication**: MFA integration for administrative access

2. **Network Infrastructure Integration**

   - **IPAM Integration**: IP address management system integration
   - **DNS Management**: Automated DNS record management and updates
   - **VLAN Automation**: Dynamic VLAN provisioning and management
   - **SDN Integration**: Software-defined networking controller integration

3. **Compliance and Governance**
   - **Framework Support**: ISO 27001, SOC 2, HIPAA, PCI DSS compliance templates
   - **Audit Logging**: Comprehensive audit trails with tamper-proof storage
   - **Policy Automation**: Automated compliance policy deployment and validation
   - **Risk Management**: Continuous risk assessment and mitigation automation

### Performance and Scalability

1. **Database Optimization**

   - **Connection Pooling**: Efficient database connection management
   - **Query Optimization**: Optimized queries for large device deployments
   - **Data Partitioning**: Time-based partitioning for metrics and logs
   - **Caching Strategy**: Redis-based caching for configuration and metrics

2. **Network Performance**
   - **API Rate Limiting**: Intelligent rate limiting with burst handling
   - **Bulk Operations**: Batch API operations for large-scale changes
   - **Compression**: Response compression for bandwidth optimization
   - **CDN Integration**: Static content delivery optimization

## Security Tool Overview

- **Platform**: OpenWISP Enterprise Network Management with Advanced Orchestration
- **Framework**: Django-based microservices with container orchestration
- **Type**: Open Source Network Infrastructure Management with Enterprise Extensions
- **License**: BSD/MIT with commercial enterprise support and advanced features
- **Use Cases**: Enterprise networking, ISP management, municipal Wi-Fi, campus networks, compliance environments
