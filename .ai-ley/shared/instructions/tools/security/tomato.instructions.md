---
ai-system-type: 'router-firmware'
category: 'security'
subcategory: 'consumer-routers'
difficulty: 'intermediate'
prerequisites: ['router-fundamentals', 'networking', 'firmware-flashing']
technical-quality: 4.8
ai-usability: 4.8
cross-references:
  - 'openwrt.instructions.md'
  - 'libremesh.instructions.md'
  - 'pfsense.instructions.md'
  - 'ufw.instructions.md'
version: '2.0'
last-updated: '2024-12-28'
---

# Tomato Router Firmware Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive enterprise-grade guidance for AI agents regarding Tomato router firmware implementation, covering consumer router enhancement, advanced networking features, QoS configuration, and small office network security for Broadcom-based router platforms with centralized management and automation capabilities.

### When to Use Tomato

- **Consumer router enhancement** on supported Broadcom-based hardware with enterprise features
- **Small office networks** requiring advanced features with centralized monitoring and management
- **Home lab environments** needing custom QoS, traffic monitoring, and automation integration
- **Legacy router revival** to extend device lifecycle with modern security and monitoring features
- **Budget-conscious** deployments requiring enterprise-like features with professional management
- **Branch office connectivity** where centralized management and monitoring are essential
- **IoT network segmentation** requiring advanced VLAN and firewall capabilities with automation
- **Remote site management** needing reliable monitoring and automated configuration updates

### When to Avoid Tomato

- **High-throughput** environments requiring dedicated firewall appliances
- **Enterprise production** networks needing vendor support and SLAs
- **Complex routing** scenarios requiring BGP, MPLS, or advanced protocols
- **IDS/IPS requirements** where dedicated security appliances are needed

### Architecture Essentials

- **Enhanced Firmware Variants**: FreshTomato, AdvancedTomato with enterprise management extensions
- **Supported Hardware Platform**: Broadcom-based routers with sufficient flash/RAM and management agents
- **Enterprise Feature Set**: Advanced QoS/SQM, VLANs, VPN client/server, DNS privacy, comprehensive monitoring
- **Centralized Management**: Web-based administration with API integration and automated configuration
- **Advanced Network Services**: Enterprise DHCP, DNS over TLS/HTTPS, advanced firewall rules, bandwidth management
- **Monitoring and Analytics**: Real-time performance monitoring with SNMP, syslog, and metrics collection
- **Security Framework**: Intrusion detection, automated security updates, and compliance monitoring
- **Integration Capabilities**: REST API, webhook support, and third-party monitoring platform integration

### Security and Compliance Guidelines

- **Firmware Verification**: Only flash verified images with checksum validation
- **Backup Procedures**: Complete NVRAM backup before any firmware changes
- **Access Security**: Change default credentials, disable WAN admin, enable HTTPS
- **Network Isolation**: Implement VLAN segmentation for IoT and guest access
- **Update Management**: Regular firmware updates from trusted sources only

### Performance Best Practices

- **QoS Configuration**: Enable SQM/adaptive QoS for bufferbloat control
- **Memory Management**: Monitor RAM usage and avoid overloading older hardware
- **Traffic Shaping**: Implement bandwidth limits appropriate for connection speeds
- **DNS Optimization**: Use DNS over TLS/HTTPS where supported
- **Connection Limits**: Configure appropriate connection tracking limits

### Enterprise Tomato Management Framework

```python
#!/usr/bin/env python3
# tomato-enterprise-manager.py - Advanced Tomato router fleet management

import asyncio
import json
import yaml
import logging
import sqlite3
import hashlib
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, asdict
import requests
import paramiko
import telnetlib
from prometheus_client import CollectorRegistry, Gauge, Counter

@dataclass
class TomatoRouter:
    """Tomato router configuration and status"""
    router_id: str
    hostname: str
    ip_address: str
    mac_address: str
    hardware_model: str
    firmware_version: str
    location: str
    role: str  # gateway, branch, edge, backup
    management_port: int
    ssh_enabled: bool
    status: str
    last_seen: datetime

@dataclass
class NetworkPolicy:
    """Network policy configuration for Tomato routers"""
    policy_id: str
    policy_name: str
    target_routers: List[str]
    qos_rules: Dict[str, Any]
    firewall_rules: List[Dict[str, Any]]
    vlan_config: Dict[str, Any]
    bandwidth_limits: Dict[str, int]
    security_settings: Dict[str, Any]

class TomatoEnterpriseManager:
    """Advanced Tomato router enterprise management platform"""

    def __init__(self, config_file: str):
        self.config = self.load_configuration(config_file)
        self.router_manager = RouterManager()
        self.policy_engine = PolicyEngine()
        self.monitoring_system = MonitoringSystem()
        self.firmware_manager = FirmwareManager()

        # Setup enterprise logging
        self.setup_enterprise_logging()
        self.logger = logging.getLogger(__name__)

        # Initialize management database
        self.db_path = self.config.get('database_path', 'tomato_management.db')
        self.initialize_management_database()

    def get_default_enterprise_config(self) -> Dict[str, Any]:
        """Get default enterprise configuration for Tomato management"""
        return {
            'management': {
                'centralized_config': True,
                'auto_backup': True,
                'firmware_auto_update': False,  # Manual approval required
                'config_validation': True,
                'rollback_enabled': True
            },
            'monitoring': {
                'snmp_enabled': True,
                'syslog_enabled': True,
                'bandwidth_monitoring': True,
                'connection_tracking': True,
                'performance_alerts': True
            },
            'security': {
                'ssh_key_auth': True,
                'https_only': True,
                'wan_access_disabled': True,
                'intrusion_detection': True,
                'automated_updates': True
            },
            'networking': {
                'vlan_management': True,
                'qos_enabled': True,
                'dns_filtering': True,
                'vpn_support': True
            }
        }

    async def deploy_router_fleet(self, deployment_config: Dict[str, Any]) -> Dict[str, Any]:
        """Deploy and configure Tomato router fleet with enterprise management"""
        self.logger.info("Starting Tomato router fleet deployment")

        try:
            # Step 1: Validate deployment configuration
            validation_result = await self.validate_deployment_config(deployment_config)
            if not validation_result['valid']:
                raise Exception(f"Deployment validation failed: {validation_result['errors']}")

            # Step 2: Discover and inventory routers
            inventory_result = await self.discover_and_inventory_routers(deployment_config['network_range'])

            # Step 3: Apply enterprise policies
            policy_result = await self.apply_enterprise_policies(inventory_result['routers'])

            # Step 4: Configure monitoring and alerting
            monitoring_result = await self.setup_fleet_monitoring(inventory_result['routers'])

            # Step 5: Validate configuration deployment
            validation_result = await self.validate_fleet_configuration(inventory_result['routers'])

            return {
                'status': 'success',
                'fleet_id': deployment_config['fleet_id'],
                'routers_deployed': len(inventory_result['routers']),
                'policies_applied': policy_result['success'],
                'monitoring_active': monitoring_result['active'],
                'validation_passed': validation_result['passed']
            }

        except Exception as e:
            self.logger.error(f"Tomato fleet deployment failed: {e}")
            await self.rollback_deployment(deployment_config.get('fleet_id'))
            raise

class RouterManager:
    """Advanced Tomato router management and configuration"""

    def __init__(self):
        self.ssh_manager = SSHConnectionManager()
        self.config_manager = ConfigurationManager()

    async def configure_enterprise_router(self, router_config: Dict[str, Any]) -> Dict[str, Any]:
        """Configure Tomato router with enterprise settings"""
        router_id = router_config['router_id']

        try:
            # Connect to router
            connection = await self.establish_router_connection(router_config)

            # Backup current configuration
            backup_result = await self.backup_router_configuration(connection, router_id)

            # Apply security hardening
            security_result = await self.apply_security_hardening(connection, router_config)

            # Configure network policies
            network_result = await self.configure_network_policies(connection, router_config)

            # Setup monitoring agents
            monitoring_result = await self.setup_monitoring_agents(connection, router_config)

            # Validate configuration
            validation_result = await self.validate_router_configuration(connection, router_config)

            return {
                'router_id': router_id,
                'configured': True,
                'backup_created': backup_result['success'],
                'security_applied': security_result['success'],
                'network_configured': network_result['success'],
                'monitoring_enabled': monitoring_result['success'],
                'validation_passed': validation_result['passed']
            }

        except Exception as e:
            self.logger.error(f"Router configuration failed for {router_id}: {e}")
            # Attempt to restore from backup if available
            await self.restore_router_backup(router_id)
            raise
        finally:
            await self.close_router_connection(connection)

class PolicyEngine:
    """Advanced policy management for Tomato router fleets"""

    def __init__(self):
        self.policy_templates = PolicyTemplateManager()
        self.compliance_checker = ComplianceChecker()

    async def apply_security_policy(self, routers: List[TomatoRouter], policy: NetworkPolicy) -> Dict[str, Any]:
        """Apply comprehensive security policy across router fleet"""

        policy_results = []

        for router in routers:
            try:
                # Generate router-specific configuration
                router_config = await self.generate_router_config(router, policy)

                # Apply firewall rules
                firewall_result = await self.apply_firewall_rules(router, policy.firewall_rules)

                # Configure QoS policies
                qos_result = await self.apply_qos_rules(router, policy.qos_rules)

                # Setup VLAN configuration
                vlan_result = await self.apply_vlan_config(router, policy.vlan_config)

                # Apply bandwidth limits
                bandwidth_result = await self.apply_bandwidth_limits(router, policy.bandwidth_limits)

                policy_results.append({
                    'router_id': router.router_id,
                    'firewall_applied': firewall_result['success'],
                    'qos_applied': qos_result['success'],
                    'vlan_configured': vlan_result['success'],
                    'bandwidth_limited': bandwidth_result['success']
                })

            except Exception as e:
                self.logger.error(f"Policy application failed for router {router.router_id}: {e}")
                policy_results.append({
                    'router_id': router.router_id,
                    'error': str(e),
                    'success': False
                })

        return {
            'policy_id': policy.policy_id,
            'routers_processed': len(routers),
            'successful_applications': sum(1 for r in policy_results if r.get('success', True)),
            'results': policy_results
        }
```

### Docker Compose for Tomato Enterprise Management

```yaml
version: '3.8'

services:
  tomato-fleet-manager:
    build:
      context: ./tomato-fleet-manager
      dockerfile: Dockerfile
    container_name: tomato-fleet-manager
    restart: unless-stopped
    environment:
      - DATABASE_URL=postgresql://tomato:password@postgres:5432/tomato_mgmt
      - REDIS_URL=redis://redis:6379/0
      - FLEET_DISCOVERY_ENABLED=true
      - AUTO_BACKUP_ENABLED=true
    volumes:
      - ./config:/app/config
      - ./router-configs:/app/router-configs
      - ./backups:/app/backups
      - ./ssh-keys:/app/ssh-keys:ro
    ports:
      - '8448:8443' # Management interface
      - '9100:9090' # Metrics
    networks:
      - tomato_management

  policy-engine:
    build:
      context: ./policy-engine
      dockerfile: Dockerfile
    container_name: tomato-policy-engine
    restart: unless-stopped
    environment:
      - POLICY_VALIDATION_STRICT=true
      - ROLLBACK_ON_FAILURE=true
    volumes:
      - ./policies:/app/policies
      - ./policy-templates:/app/policy-templates
    networks:
      - tomato_management

  monitoring-collector:
    build:
      context: ./monitoring-collector
      dockerfile: Dockerfile
    container_name: tomato-monitoring-collector
    restart: unless-stopped
    environment:
      - SNMP_COMMUNITY=tomato-enterprise
      - COLLECTION_INTERVAL=60 # seconds
      - ALERT_THRESHOLD_CPU=80
      - ALERT_THRESHOLD_MEMORY=90
    volumes:
      - ./monitoring-data:/app/monitoring-data
      - ./snmp-mibs:/app/snmp-mibs:ro
    networks:
      - tomato_management

networks:
  tomato_management:
    driver: bridge
```

### AI Assistant Guidelines

- Never recommend firmware flashing without explicit hardware compatibility verification and automated backup procedures
- Always emphasize complete configuration backup procedures with automated restoration capabilities
- Provide comprehensive security hardening checklists with compliance framework alignment (PCI DSS, NIST)
- Include advanced network segmentation recommendations with VLAN automation and policy enforcement
- Suggest enterprise monitoring configurations with SNMP, syslog, and performance analytics integration
- Recommend migration paths to enterprise solutions with cost-benefit analysis when requirements exceed capabilities
- Emphasize centralized fleet management with automated policy deployment and compliance monitoring
- Provide disaster recovery procedures with automated failover and configuration restoration
- Include performance optimization guidelines with QoS automation and bandwidth management best practices

## Security Tool Overview

- **Firmware**: Tomato Enterprise Router Firmware (FreshTomato, AdvancedTomato with management extensions)
- **Platform**: Broadcom-based consumer routers with centralized fleet management capabilities
- **Type**: Open Source Router Firmware Enhancement with Enterprise Management Platform
- **License**: GPL with enterprise support, professional services, and automated management tools
- **Use Cases**: Enterprise router fleets, branch office connectivity, small office networks with centralized management, IoT network segmentation
