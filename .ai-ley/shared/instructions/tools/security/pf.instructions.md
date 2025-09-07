---
ai-system-type: 'firewall-system'
category: 'security'
subcategory: 'packet-filtering'
difficulty: 'advanced'
prerequisites: ['bsd-systems', 'network-security', 'firewall-concepts']
technical-quality: 4.8
ai-usability: 4.8
cross-references:
  - 'pfsense.instructions.md'
  - 'opnsense.instructions.md'
  - 'ipfire.instructions.md'
  - 'ufw.instructions.md'
version: '2.0'
last-updated: '2024-12-28'
---

# PF Packet Filter Security Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents regarding PF (Packet Filter) firewall implementation, covering FreeBSD/OpenBSD stateful packet filtering, NAT configuration, QoS management, rule optimization, and advanced network security for BSD-based systems.

### When to Use PF

- **BSD systems** requiring high-performance packet filtering (FreeBSD, OpenBSD)
- **Advanced firewalling** needs with complex rule sets and state management
- **High-throughput** environments where performance is critical
- **Security appliances** based on pfSense, OPNsense, or custom BSD builds
- **Complex NAT** scenarios requiring sophisticated port forwarding and traffic shaping

### When to Avoid PF

- **Linux-only** environments where iptables/netfilter is more appropriate
- **Simple requirements** where basic firewall functionality is sufficient
- **Windows environments** lacking BSD foundation
- **Cloud environments** with managed firewall services

### Architecture Essentials

- **Stateful Filtering**: Connection tracking with established/related state management
- **Rule Processing**: Last-matching rule wins unless 'quick' keyword used
- **Tables and Anchors**: Modular rule organization and dynamic IP/domain management
- **NAT Engine**: Comprehensive network address translation with port forwarding
- **Traffic Normalization**: Packet scrubbing and reassembly for security

### Security and Compliance Guidelines

- **Default Deny**: Implement default-deny inbound policies with explicit allow rules
- **State Management**: Use stateful connections for performance and security
- **Traffic Normalization**: Enable scrub rules for packet validation and reassembly
- **Rate Limiting**: Implement connection rate limiting for brute-force protection
- **Logging**: Comprehensive logging of security events with pflog interface

### Performance Best Practices

- **Rule Optimization**: Minimize rule count and use tables for large IP sets
- **State Limits**: Configure appropriate connection limits and timeouts
- **Interface Handling**: Use 'set skip' for management interfaces appropriately
- **Table Management**: Efficient table updates and maintenance procedures
- **Quick Rules**: Strategic use of 'quick' keyword for performance optimization

### AI Assistant Guidelines

- Always provide complete, minimal rule sets with proper syntax and structure
- Include proper NAT rules with corresponding pass rules for port forwards
- Recommend table usage for dynamic IP sets and large allow/block lists
- Provide logging configuration with pflog analysis procedures
- Include security hardening recommendations with appropriate state limits
- Suggest monitoring and troubleshooting procedures for rule debugging

### Enterprise PF Management Framework

```python
#!/usr/bin/env python3
# pf-enterprise-manager.py - Advanced PF firewall management framework

import asyncio
import json
import yaml
import logging
import subprocess
import re
import time
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, asdict
from pathlib import Path
import ipaddress
import threading
import signal

@dataclass
class PFRule:
    """PF rule configuration model"""
    rule_id: str
    action: str  # pass, block, match, etc.
    direction: str  # in, out
    interface: Optional[str] = None
    protocol: Optional[str] = None
    source: Optional[str] = None
    destination: Optional[str] = None
    port: Optional[str] = None
    flags: List[str] = None
    options: Dict[str, Any] = None
    label: Optional[str] = None
    quick: bool = False
    log: bool = False

    def __post_init__(self):
        if self.flags is None:
            self.flags = []
        if self.options is None:
            self.options = {}

@dataclass
class PFTable:
    """PF table configuration model"""
    table_name: str
    addresses: List[str]
    persistent: bool = True
    counters: bool = False
    file_source: Optional[str] = None

@dataclass
class NATRule:
    """NAT rule configuration model"""
    rule_id: str
    type: str  # nat, rdr, binat
    interface: str
    source: Optional[str] = None
    destination: Optional[str] = None
    target: Optional[str] = None
    port_mapping: Optional[Dict[str, str]] = None

class PFEnterpriseManager:
    """Advanced PF firewall enterprise management platform"""

    def __init__(self, config_file: str):
        self.config = self.load_configuration(config_file)
        self.rules_manager = RulesManager()
        self.tables_manager = TablesManager()
        self.nat_manager = NATManager()
        self.monitoring_manager = MonitoringManager()
        self.performance_optimizer = PerformanceOptimizer()
        self.security_analyzer = SecurityAnalyzer()
        self.compliance_engine = ComplianceEngine()

        # State tracking
        self.current_ruleset = {}
        self.active_tables = {}
        self.nat_rules = {}
        self.performance_metrics = {}

        # Setup logging
        self.setup_logging()
        self.logger = logging.getLogger(__name__)

    def setup_logging(self):
        """Setup comprehensive logging system"""
        log_config = {
            'version': 1,
            'disable_existing_loggers': False,
            'formatters': {
                'detailed': {
                    'format': '%(asctime)s - %(name)s - %(levelname)s - %(funcName)s:%(lineno)d - %(message)s'
                },
                'simple': {
                    'format': '%(levelname)s - %(message)s'
                }
            },
            'handlers': {
                'file': {
                    'class': 'logging.handlers.RotatingFileHandler',
                    'filename': 'pf_enterprise.log',
                    'maxBytes': 10485760,  # 10MB
                    'backupCount': 10,
                    'formatter': 'detailed',
                    'level': 'INFO'
                },
                'console': {
                    'class': 'logging.StreamHandler',
                    'formatter': 'simple',
                    'level': 'INFO'
                },
                'security': {
                    'class': 'logging.handlers.SysLogHandler',
                    'address': ('localhost', 514),
                    'formatter': 'detailed',
                    'level': 'WARNING'
                }
            },
            'loggers': {
                '': {
                    'handlers': ['file', 'console', 'security'],
                    'level': 'INFO',
                    'propagate': False
                }
            }
        }

        logging.config.dictConfig(log_config)

    def load_configuration(self, config_file: str) -> Dict[str, Any]:
        """Load enterprise PF configuration"""
        try:
            with open(config_file, 'r') as f:
                config = yaml.safe_load(f)
            return config
        except FileNotFoundError:
            self.logger.warning(f"Config file {config_file} not found, using defaults")
            return self.get_default_config()

    def get_default_config(self) -> Dict[str, Any]:
        """Get default enterprise configuration"""
        return {
            'interfaces': {
                'wan': 'em0',
                'lan': 'em1',
                'dmz': 'em2',
                'mgmt': 'em3'
            },
            'networks': {
                'lan': '192.168.1.0/24',
                'dmz': '192.168.10.0/24',
                'mgmt': '192.168.100.0/24',
                'vpn': '10.0.0.0/16'
            },
            'security_policies': {
                'default_deny': True,
                'log_blocked': True,
                'scrub_all': True,
                'rate_limit_enabled': True
            },
            'performance': {
                'optimization_level': 'high',
                'state_table_size': 100000,
                'connection_timeout': 3600
            },
            'monitoring': {
                'enabled': True,
                'metrics_interval': 60,
                'log_analysis': True
            }
        }

    async def initialize_enterprise_firewall(self):
        """Initialize complete enterprise firewall system"""
        self.logger.info("Initializing PF Enterprise Firewall System")

        try:
            # Initialize core components
            await self.initialize_core_components()

            # Generate and deploy base ruleset
            base_ruleset = await self.generate_enterprise_ruleset()
            await self.deploy_ruleset(base_ruleset)

            # Setup tables and dynamic content
            await self.initialize_tables()

            # Configure NAT rules
            await self.configure_nat_rules()

            # Initialize monitoring and alerting
            monitoring_result = await self.monitoring_manager.initialize_monitoring()

            # Setup performance optimization
            perf_result = await self.performance_optimizer.initialize_optimization()

            # Initialize security analysis
            security_result = await self.security_analyzer.initialize_analysis()

            # Setup compliance monitoring
            compliance_result = await self.compliance_engine.initialize_compliance()

            return {
                'status': 'success',
                'components_initialized': True,
                'rules_deployed': len(base_ruleset),
                'tables_active': len(self.active_tables),
                'monitoring_active': monitoring_result.get('active', False),
                'performance_optimized': perf_result.get('optimized', False),
                'security_analysis_active': security_result.get('active', False),
                'compliance_monitoring': compliance_result.get('active', False)
            }

        except Exception as e:
            self.logger.error(f"Firewall initialization failed: {e}")
            raise

    async def initialize_core_components(self):
        """Initialize core PF components"""
        # Enable PF if not already enabled
        await self.execute_pf_command(['pfctl', '-e'])

        # Configure basic kernel parameters
        await self.configure_kernel_parameters()

        # Setup pflog interface for logging
        await self.setup_pflog_interface()

        # Initialize state table limits
        await self.configure_state_limits()

    async def configure_kernel_parameters(self):
        """Configure kernel parameters for optimal PF performance"""
        kernel_params = {
            'net.pf.states_hashsize': '32768',
            'net.pf.src_nodes_hashsize': '32768',
            'net.pf.frags_hashsize': '8192',
            'net.inet.ip.forwarding': '1',
            'net.inet6.ip6.forwarding': '1',
            'net.inet.tcp.blackhole': '2',
            'net.inet.udp.blackhole': '1'
        }

        for param, value in kernel_params.items():
            await self.execute_system_command(['sysctl', f'{param}={value}'])

    async def setup_pflog_interface(self):
        """Setup pflog interface for comprehensive logging"""
        try:
            # Create pflog interface if it doesn't exist
            await self.execute_system_command(['ifconfig', 'pflog0', 'create'])
            await self.execute_system_command(['ifconfig', 'pflog0', 'up'])

            # Start pflogd for log file writing
            pflogd_cmd = [
                'pflogd', '-s', '160', '-i', 'pflog0',
                '-f', '/var/log/pflog', '-D'
            ]
            await self.execute_system_command(pflogd_cmd)

            self.logger.info("pflog interface configured successfully")

        except Exception as e:
            self.logger.error(f"Failed to setup pflog interface: {e}")

    async def generate_enterprise_ruleset(self) -> List[PFRule]:
        """Generate comprehensive enterprise ruleset"""
        rules = []

        # Base scrub rules for security
        rules.extend(await self.generate_scrub_rules())

        # Core security rules
        rules.extend(await self.generate_security_rules())

        # Network segmentation rules
        rules.extend(await self.generate_segmentation_rules())

        # Application-specific rules
        rules.extend(await self.generate_application_rules())

        # Monitoring and logging rules
        rules.extend(await self.generate_monitoring_rules())

        # Performance optimization rules
        rules.extend(await self.performance_optimizer.generate_performance_rules())

        return rules

    async def generate_scrub_rules(self) -> List[PFRule]:
        """Generate packet scrubbing rules for security"""
        scrub_rules = [
            PFRule(
                rule_id='scrub_001',
                action='match',
                direction='in',
                options={'scrub': {'reassemble tcp', 'random-id'}},
                label='Scrub inbound traffic'
            ),
            PFRule(
                rule_id='scrub_002',
                action='match',
                direction='out',
                options={'scrub': {'reassemble tcp', 'random-id'}},
                label='Scrub outbound traffic'
            ),
            PFRule(
                rule_id='scrub_003',
                action='match',
                direction='in',
                interface='$wan_if',
                options={'scrub': {'no-df', 'max-mss 1440'}},
                label='WAN interface scrubbing'
            )
        ]

        return scrub_rules

    async def generate_security_rules(self) -> List[PFRule]:
        """Generate core security rules"""
        security_rules = [
            # Default deny rule
            PFRule(
                rule_id='security_001',
                action='block',
                direction='in',
                log=True,
                label='Default deny inbound',
                quick=True
            ),

            # Anti-spoofing rules
            PFRule(
                rule_id='security_002',
                action='block',
                direction='in',
                quick=True,
                source='<private_nets>',
                interface='$wan_if',
                log=True,
                label='Block private IPs from WAN'
            ),

            # Rate limiting for SSH
            PFRule(
                rule_id='security_003',
                action='pass',
                direction='in',
                protocol='tcp',
                port='ssh',
                options={
                    'max-src-conn': 5,
                    'max-src-conn-rate': '3/60',
                    'overload': '<bruteforce>',
                    'flush global'
                },
                flags=['S/SA'],
                log=True,
                label='SSH with rate limiting'
            ),

            # DDoS protection
            PFRule(
                rule_id='security_004',
                action='block',
                direction='in',
                quick=True,
                options={'max-src-states': 100},
                log=True,
                label='DDoS protection - state limit'
            )
        ]

        return security_rules

    async def generate_segmentation_rules(self) -> List[PFRule]:
        """Generate network segmentation rules"""
        segmentation_rules = [
            # LAN to Internet
            PFRule(
                rule_id='segment_001',
                action='pass',
                direction='out',
                interface='$lan_if',
                source='$lan_net',
                label='LAN to Internet access'
            ),

            # DMZ isolation
            PFRule(
                rule_id='segment_002',
                action='block',
                direction='in',
                interface='$dmz_if',
                destination='$lan_net',
                log=True,
                label='Block DMZ to LAN'
            ),

            # Management network access
            PFRule(
                rule_id='segment_003',
                action='pass',
                direction='in',
                interface='$mgmt_if',
                source='$mgmt_net',
                protocol='tcp',
                port=['ssh', 'https'],
                label='Management access'
            ),

            # Inter-VLAN communication control
            PFRule(
                rule_id='segment_004',
                action='pass',
                direction='in',
                interface='$lan_if',
                source='$lan_net',
                destination='$dmz_net',
                protocol='tcp',
                port=['http', 'https'],
                options={'state': 'new'},
                label='LAN to DMZ web services'
            )
        ]

        return segmentation_rules

class RulesManager:
    """Advanced PF rules management system"""

    def __init__(self):
        self.rule_templates = {}
        self.rule_validation = RuleValidator()
        self.rule_optimizer = RuleOptimizer()

    async def compile_ruleset(self, rules: List[PFRule]) -> str:
        """Compile PF rules into pf.conf format"""
        config_sections = {
            'macros': [],
            'tables': [],
            'options': [],
            'scrub': [],
            'nat': [],
            'filter': []
        }

        # Add macros
        config_sections['macros'].extend([
            'wan_if = "em0"',
            'lan_if = "em1"',
            'dmz_if = "em2"',
            'mgmt_if = "em3"',
            'lan_net = "192.168.1.0/24"',
            'dmz_net = "192.168.10.0/24"',
            'mgmt_net = "192.168.100.0/24"'
        ])

        # Add tables
        config_sections['tables'].extend([
            'table <private_nets> { 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16 }',
            'table <bruteforce> persist',
            'table <malware_ips> persist file "/etc/pf/malware_ips.txt"',
            'table <allowed_ssh> persist file "/etc/pf/allowed_ssh.txt"'
        ])

        # Add options
        config_sections['options'].extend([
            'set timeout { tcp.first 120, tcp.established 86400 }',
            'set timeout { tcp.closing 60, tcp.finwait 45 }',
            'set timeout { tcp.closed 90 }',
            'set limit states 100000',
            'set limit src-nodes 50000',
            'set limit frags 25000',
            'set optimization normal',
            'set block-policy return',
            'set loginterface $wan_if',
            'set skip on lo0'
        ])

        # Process rules by type
        for rule in rules:
            rule_text = await self.rule_to_pf_syntax(rule)

            if rule.action in ['match'] and 'scrub' in rule.options:
                config_sections['scrub'].append(rule_text)
            elif rule.action in ['nat', 'rdr', 'binat']:
                config_sections['nat'].append(rule_text)
            else:
                config_sections['filter'].append(rule_text)

        # Compile final configuration
        pf_config = []

        for section_name, section_rules in config_sections.items():
            if section_rules:
                pf_config.append(f"# {section_name.upper()} SECTION")
                pf_config.extend(section_rules)
                pf_config.append("")  # Add blank line

        return "\n".join(pf_config)

    async def rule_to_pf_syntax(self, rule: PFRule) -> str:
        """Convert PFRule object to PF syntax"""
        parts = []

        # Action
        parts.append(rule.action)

        # Direction
        if rule.direction:
            parts.append(rule.direction)

        # Quick
        if rule.quick:
            parts.append("quick")

        # Interface
        if rule.interface:
            parts.append(f"on {rule.interface}")

        # Protocol
        if rule.protocol:
            parts.append(f"proto {rule.protocol}")

        # Source
        if rule.source:
            parts.append(f"from {rule.source}")

        # Destination
        if rule.destination:
            parts.append(f"to {rule.destination}")

        # Port
        if rule.port:
            if isinstance(rule.port, list):
                port_list = "{" + ", ".join(rule.port) + "}"
                parts.append(f"port {port_list}")
            else:
                parts.append(f"port {rule.port}")

        # Flags
        if rule.flags:
            flags_str = "/".join(rule.flags)
            parts.append(f"flags {flags_str}")

        # Options
        if rule.options:
            for option, value in rule.options.items():
                if isinstance(value, list):
                    value_str = " ".join(value)
                elif isinstance(value, dict):
                    value_str = " ".join(f"{k} {v}" for k, v in value.items())
                else:
                    value_str = str(value)
                parts.append(f"{option} {value_str}")

        # Log
        if rule.log:
            parts.append("log")

        # Label
        if rule.label:
            parts.append(f'label "{rule.label}"')

        return " ".join(parts)

class TablesManager:
    """Advanced PF tables management"""

    def __init__(self):
        self.threat_intelligence = ThreatIntelligenceManager()
        self.geo_blocking = GeoBlockingManager()

    async def initialize_tables(self):
        """Initialize all PF tables"""
        tables = [
            await self.create_private_networks_table(),
            await self.create_threat_intelligence_table(),
            await self.create_geo_blocking_tables(),
            await self.create_application_tables()
        ]

        for table in tables:
            await self.deploy_table(table)

    async def create_threat_intelligence_table(self) -> PFTable:
        """Create threat intelligence table with dynamic updates"""
        # Fetch latest threat intelligence feeds
        malicious_ips = await self.threat_intelligence.get_malicious_ips()

        return PFTable(
            table_name='malware_ips',
            addresses=malicious_ips,
            persistent=True,
            counters=True
        )

    async def create_geo_blocking_tables(self) -> List[PFTable]:
        """Create geo-blocking tables"""
        geo_tables = []

        blocked_countries = ['CN', 'RU', 'KP']  # Example blocked countries

        for country in blocked_countries:
            country_ips = await self.geo_blocking.get_country_ip_ranges(country)

            table = PFTable(
                table_name=f'geo_block_{country.lower()}',
                addresses=country_ips,
                persistent=True,
                counters=True
            )
            geo_tables.append(table)

        return geo_tables

    async def deploy_table(self, table: PFTable):
        """Deploy table to PF"""
        # Create table file if needed
        if table.addresses:
            table_file = f"/etc/pf/{table.table_name}.txt"
            with open(table_file, 'w') as f:
                for address in table.addresses:
                    f.write(f"{address}\n")

        # Load table into PF
        cmd = ['pfctl', '-t', table.table_name, '-T', 'add', '-f', table_file]
        await self.execute_pf_command(cmd)

        self.logger.info(f"Table {table.table_name} deployed with {len(table.addresses)} entries")

class MonitoringManager:
    """Comprehensive PF monitoring and alerting system"""

    def __init__(self):
        self.metrics_collector = MetricsCollector()
        self.log_analyzer = LogAnalyzer()
        self.alert_manager = AlertManager()

    async def initialize_monitoring(self):
        """Initialize comprehensive monitoring system"""
        # Setup metrics collection
        await self.metrics_collector.start_collection()

        # Initialize log analysis
        await self.log_analyzer.start_analysis()

        # Configure alerting
        await self.alert_manager.setup_alerts()

        return {'active': True, 'components': ['metrics', 'logs', 'alerts']}

    async def collect_pf_statistics(self) -> Dict[str, Any]:
        """Collect comprehensive PF statistics"""
        stats = {}

        # Basic PF info
        info_result = await self.execute_pf_command(['pfctl', '-si'])
        stats['info'] = self.parse_pf_info(info_result)

        # State table statistics
        states_result = await self.execute_pf_command(['pfctl', '-ss'])
        stats['states'] = self.parse_pf_states(states_result)

        # Table statistics
        tables_result = await self.execute_pf_command(['pfctl', '-sT'])
        stats['tables'] = self.parse_pf_tables(tables_result)

        # Rule statistics
        rules_result = await self.execute_pf_command(['pfctl', '-sr', '-v'])
        stats['rules'] = self.parse_pf_rules(rules_result)

        return stats

    def parse_pf_info(self, info_output: str) -> Dict[str, Any]:
        """Parse pfctl -si output"""
        info = {}

        for line in info_output.split('\n'):
            if ':' in line:
                key, value = line.split(':', 1)
                info[key.strip()] = value.strip()

        return info

class PerformanceOptimizer:
    """PF performance optimization engine"""

    def __init__(self):
        self.optimization_strategies = {
            'rule_ordering': self.optimize_rule_ordering,
            'table_optimization': self.optimize_tables,
            'state_optimization': self.optimize_state_handling,
            'kernel_tuning': self.optimize_kernel_parameters
        }

    async def initialize_optimization(self):
        """Initialize performance optimization"""
        optimizations_applied = []

        for strategy_name, strategy_func in self.optimization_strategies.items():
            try:
                result = await strategy_func()
                if result['success']:
                    optimizations_applied.append(strategy_name)

            except Exception as e:
                self.logger.error(f"Optimization strategy {strategy_name} failed: {e}")

        return {
            'optimized': len(optimizations_applied) > 0,
            'strategies_applied': optimizations_applied
        }

    async def optimize_rule_ordering(self) -> Dict[str, Any]:
        """Optimize rule ordering for performance"""
        # Implement rule ordering optimization logic
        # Most frequently matched rules should be first
        # Quick rules should be used strategically

        return {'success': True, 'rules_reordered': 0}

    async def optimize_tables(self) -> Dict[str, Any]:
        """Optimize table performance"""
        # Implement table optimization
        # Use radix tables for large IP sets
        # Optimize table loading and updating

        return {'success': True, 'tables_optimized': 0}

    async def generate_performance_rules(self) -> List[PFRule]:
        """Generate performance-optimized rules"""
        perf_rules = [
            # Skip localhost traffic
            PFRule(
                rule_id='perf_001',
                action='set',
                options={'skip': 'on lo0'},
                label='Skip localhost interface'
            ),

            # Optimize established connections
            PFRule(
                rule_id='perf_002',
                action='pass',
                direction='in',
                quick=True,
                options={'state': 'established'},
                label='Fast path for established connections'
            )
        ]

        return perf_rules

class SecurityAnalyzer:
    """Advanced PF security analysis engine"""

    def __init__(self):
        self.vulnerability_scanner = VulnerabilityScanner()
        self.threat_detector = ThreatDetector()
        self.policy_analyzer = PolicyAnalyzer()

    async def initialize_analysis(self):
        """Initialize security analysis system"""
        # Start vulnerability scanning
        vuln_result = await self.vulnerability_scanner.start_scanning()

        # Initialize threat detection
        threat_result = await self.threat_detector.start_detection()

        # Setup policy analysis
        policy_result = await self.policy_analyzer.start_analysis()

        return {
            'active': True,
            'vulnerability_scanning': vuln_result.get('active', False),
            'threat_detection': threat_result.get('active', False),
            'policy_analysis': policy_result.get('active', False)
        }

    async def analyze_firewall_security(self) -> Dict[str, Any]:
        """Perform comprehensive security analysis"""
        analysis = {
            'timestamp': datetime.now().isoformat(),
            'vulnerabilities': await self.vulnerability_scanner.scan_configuration(),
            'threats': await self.threat_detector.analyze_traffic(),
            'policy_issues': await self.policy_analyzer.analyze_policies(),
            'recommendations': []
        }

        # Generate security recommendations
        analysis['recommendations'] = await self.generate_security_recommendations(analysis)

        return analysis

# Docker Compose for PF Enterprise Management
def generate_pf_management_stack():
    """Generate Docker Compose stack for PF enterprise management"""

    docker_compose = '''
version: '3.8'

services:
  pf-manager:
    build:
      context: ./pf-manager
      dockerfile: Dockerfile
    container_name: pf-enterprise-manager
    restart: unless-stopped
    privileged: true
    network_mode: host
    environment:
      - DATABASE_URL=postgresql://pf:password@postgres:5432/pf_mgmt
      - REDIS_URL=redis://redis:6379/0
      - LOG_LEVEL=INFO
    volumes:
      - ./config:/app/config
      - ./rules:/app/rules
      - ./logs:/app/logs
      - /etc/pf:/etc/pf
      - /var/log:/var/log
    depends_on:
      - postgres
      - redis

  pf-monitor:
    build:
      context: ./pf-monitor
      dockerfile: Dockerfile
    container_name: pf-monitor
    restart: unless-stopped
    privileged: true
    network_mode: host
    environment:
      - PROMETHEUS_URL=http://localhost:9090
      - ALERT_WEBHOOK_URL=${ALERT_WEBHOOK_URL}
    volumes:
      - ./monitoring:/app/monitoring
      - /var/log/pflog:/var/log/pflog:ro

  prometheus:
    image: prom/prometheus:latest
    container_name: pf-prometheus
    restart: unless-stopped
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=90d'
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus_data:/prometheus
    ports:
      - "9097:9090"
    networks:
      - pf_mgmt

  grafana:
    image: grafana/grafana:latest
    container_name: pf-grafana
    restart: unless-stopped
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASSWORD}
      - GF_SERVER_ROOT_URL=https://pf-monitoring.company.com/grafana
    volumes:
      - grafana_data:/var/lib/grafana
      - ./monitoring/grafana/dashboards:/etc/grafana/provisioning/dashboards
      - ./monitoring/grafana/datasources:/etc/grafana/provisioning/datasources
    ports:
      - "3004:3000"
    networks:
      - pf_mgmt
    depends_on:
      - prometheus

  postgres:
    image: postgres:14
    container_name: pf-postgres
    restart: unless-stopped
    environment:
      - POSTGRES_DB=pf_mgmt
      - POSTGRES_USER=pf
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - pf_mgmt

  redis:
    image: redis:7-alpine
    container_name: pf-redis
    restart: unless-stopped
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    networks:
      - pf_mgmt

volumes:
  postgres_data:
  redis_data:
  prometheus_data:
  grafana_data:

networks:
  pf_mgmt:
    driver: bridge
'''

    return docker_compose

def main():
    """Main function demonstrating PF enterprise management"""

    # Example usage
    config = {
        'interfaces': {
            'wan': 'em0',
            'lan': 'em1',
            'dmz': 'em2'
        },
        'networks': {
            'lan': '192.168.1.0/24',
            'dmz': '192.168.10.0/24'
        }
    }

    # Initialize PF manager
    pf_manager = PFEnterpriseManager('/tmp/pf_config.yaml')

    # Generate Docker stack
    docker_stack = generate_pf_management_stack()
    print("PF enterprise management stack generated")

    # Run async initialization
    async def run_manager():
        result = await pf_manager.initialize_enterprise_firewall()
        print(f"PF enterprise firewall initialization: {result}")

    # Run the manager
    asyncio.run(run_manager())

if __name__ == '__main__':
    main()
```

### Advanced PF Configuration Examples

```bash
#!/bin/bash
# pf-enterprise-config.sh - Advanced PF configuration for enterprise deployment

set -euo pipefail

# Configuration variables
WAN_IF="em0"
LAN_IF="em1"
DMZ_IF="em2"
MGMT_IF="em3"
LAN_NET="192.168.1.0/24"
DMZ_NET="192.168.10.0/24"
MGMT_NET="192.168.100.0/24"

generate_enterprise_pf_conf() {
    cat > /etc/pf.conf << 'EOF'
# PF Enterprise Configuration
# Generated by PF Enterprise Manager

#========================================
# MACROS
#========================================
wan_if = "em0"
lan_if = "em1"
dmz_if = "em2"
mgmt_if = "em3"

# Networks
lan_net = "192.168.1.0/24"
dmz_net = "192.168.10.0/24"
mgmt_net = "192.168.100.0/24"
vpn_net = "10.0.0.0/16"

# Services
web_ports = "{ 80, 443 }"
mail_ports = "{ 25, 465, 587, 993, 995 }"
ssh_port = "22"

#========================================
# TABLES
#========================================
table <private_nets> { 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, 127.0.0.0/8 }
table <bruteforce> persist
table <malware_ips> persist file "/etc/pf/malware_ips.txt"
table <allowed_ssh> persist file "/etc/pf/allowed_ssh.txt"
table <geo_block_cn> persist file "/etc/pf/geo_block_cn.txt"
table <geo_block_ru> persist file "/etc/pf/geo_block_ru.txt"
table <whitelist_ips> persist file "/etc/pf/whitelist_ips.txt"

#========================================
# OPTIONS
#========================================
set timeout { tcp.first 120, tcp.established 86400 }
set timeout { tcp.closing 60, tcp.finwait 45, tcp.closed 90 }
set timeout { udp.first 60, udp.single 30, udp.multiple 120 }
set timeout { icmp.first 20, icmp.error 10 }
set timeout { other.first 60, other.single 30, other.multiple 60 }
set timeout { frag 30 }
set timeout { interval 10 }
set timeout { src.track 0 }

set limit states 100000
set limit src-nodes 50000
set limit frags 25000
set limit table-entries 200000

set optimization normal
set block-policy return
set loginterface $wan_if
set fingerprints "/etc/pf.os"

# Skip localhost
set skip on lo0

#========================================
# SCRUB RULES
#========================================
# Scrub all traffic for security
match in all scrub (no-df reassemble tcp random-id)
match out all scrub (reassemble tcp random-id)

# Specific WAN scrubbing
match in on $wan_if scrub (no-df max-mss 1440)

#========================================
# NAT RULES
#========================================
# Outbound NAT for LAN
nat on $wan_if from $lan_net to any -> ($wan_if)

# Outbound NAT for DMZ
nat on $wan_if from $dmz_net to any -> ($wan_if)

# Port forwards for DMZ services
rdr on $wan_if proto tcp from any to ($wan_if) port 80 -> 192.168.10.10 port 80
rdr on $wan_if proto tcp from any to ($wan_if) port 443 -> 192.168.10.10 port 443
rdr on $wan_if proto tcp from any to ($wan_if) port 25 -> 192.168.10.20 port 25

#========================================
# FILTER RULES
#========================================

# Default policies
block all
block return-rst in on $wan_if proto tcp all
block return-icmp in on $wan_if proto udp all
block in quick on $wan_if from <private_nets> to any
block in quick on $wan_if from <malware_ips> to any
block in quick from <geo_block_cn> to any
block in quick from <geo_block_ru> to any

# Anti-spoofing
antispoof for $wan_if inet
antispoof for $lan_if inet
antispoof for $dmz_if inet

# Loopback
pass quick on lo0 all

# ICMP
pass inet proto icmp from any to ($wan_if) icmp-type { echoreq, unreach }
pass inet proto icmp from $lan_net to any icmp-type { echoreq, unreach, timex }

# Management access
pass in on $mgmt_if proto tcp from $mgmt_net to ($mgmt_if) port { ssh, https } \
    flags S/SA modulate state \
    (max-src-conn 10, max-src-conn-rate 5/60, overload <bruteforce> flush global)

# SSH with rate limiting and whitelisting
pass in on $wan_if proto tcp from <allowed_ssh> to ($wan_if) port ssh \
    flags S/SA modulate state \
    (max-src-conn 3, max-src-conn-rate 2/60, overload <bruteforce> flush global)

# DMZ services from Internet
pass in on $wan_if proto tcp from any to 192.168.10.10 port $web_ports \
    flags S/SA modulate state \
    (max-src-conn 100, max-src-conn-rate 20/60)

pass in on $wan_if proto tcp from any to 192.168.10.20 port $mail_ports \
    flags S/SA modulate state \
    (max-src-conn 50, max-src-conn-rate 10/60)

# LAN to Internet
pass out on $wan_if proto tcp from $lan_net to any port { 21, 22, 53, 80, 443, 993, 995 } \
    flags S/SA modulate state

pass out on $wan_if proto udp from $lan_net to any port { 53, 123 } \
    modulate state

# LAN to DMZ (specific services only)
pass in on $lan_if proto tcp from $lan_net to $dmz_net port $web_ports \
    flags S/SA modulate state

# DMZ to Internet (limited)
pass out on $wan_if proto tcp from $dmz_net to any port { 53, 80, 443, 25, 587 } \
    flags S/SA modulate state

pass out on $wan_if proto udp from $dmz_net to any port { 53, 123 } \
    modulate state

# Block DMZ to LAN
block in on $dmz_if from $dmz_net to $lan_net

# Logging rules for security events
pass in log on $wan_if proto tcp from any to ($wan_if) port { 21, 23, 135, 139, 445 }
block return in log on $wan_if proto tcp from any to any port { 1433, 3389, 5900 }

# Rate limiting for brute force protection
block in quick from <bruteforce> to any

EOF
}

setup_pf_tables() {
    echo "Setting up PF tables..."

    # Create tables directory
    mkdir -p /etc/pf

    # Download and setup malware IP list
    fetch -o /tmp/malware_ips.txt "https://lists.blocklist.de/lists/all.txt" || \
    curl -o /tmp/malware_ips.txt "https://lists.blocklist.de/lists/all.txt" || true

    if [[ -f /tmp/malware_ips.txt ]]; then
        # Filter and format for PF
        grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' /tmp/malware_ips.txt > /etc/pf/malware_ips.txt
    else
        touch /etc/pf/malware_ips.txt
    fi

    # Setup SSH whitelist
    cat > /etc/pf/allowed_ssh.txt << 'EOF'
# SSH allowed IPs
192.168.100.0/24
10.0.0.0/16
# Add trusted IP ranges here
EOF

    # Setup geo-blocking lists (example for China)
    cat > /etc/pf/geo_block_cn.txt << 'EOF'
# China IP ranges (example - use proper geolocation data)
1.2.4.0/22
1.2.8.0/21
1.4.1.0/24
1.4.2.0/23
EOF

    # Setup geo-blocking lists (example for Russia)
    cat > /etc/pf/geo_block_ru.txt << 'EOF'
# Russia IP ranges (example - use proper geolocation data)
5.8.0.0/19
5.34.192.0/18
5.39.0.0/18
5.44.0.0/18
EOF

    # Setup whitelist
    cat > /etc/pf/whitelist_ips.txt << 'EOF'
# Whitelisted IPs
192.168.0.0/16
10.0.0.0/8
172.16.0.0/12
EOF
}

configure_pf_logging() {
    echo "Configuring PF logging..."

    # Create pflog interface
    ifconfig pflog0 create 2>/dev/null || true
    ifconfig pflog0 up

    # Start pflogd
    pflogd -s 160 -i pflog0 -f /var/log/pflog

    # Setup log rotation
    cat > /etc/newsyslog.conf.d/pf.conf << 'EOF'
# PF log rotation
/var/log/pflog    644  7   1000  *   B   /var/run/pflogd.pid  30
EOF

    # Setup syslog for PF
    echo "local0.*    /var/log/pf.log" >> /etc/syslog.conf
    service syslogd restart
}

setup_pf_monitoring() {
    echo "Setting up PF monitoring..."

    # Create monitoring script
    cat > /usr/local/bin/pf-monitor.sh << 'EOF'
#!/bin/bash
# PF monitoring script

LOG_FILE="/var/log/pf-monitor.log"
ALERT_THRESHOLD=1000

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG_FILE
}

check_state_table() {
    current_states=$(pfctl -si | grep "current entries" | awk '{print $3}')
    if [[ $current_states -gt $ALERT_THRESHOLD ]]; then
        log_message "WARNING: High state table usage: $current_states"
        # Send alert (implement your alerting mechanism)
    fi
}

check_blocked_packets() {
    blocked_packets=$(pfctl -si | grep "packets blocked" | awk '{print $3}')
    log_message "INFO: Blocked packets: $blocked_packets"
}

analyze_pflog() {
    # Analyze recent pflog entries for patterns
    tcpdump -nr /var/log/pflog -c 100 2>/dev/null | \
    awk '/blocked/ {print $0}' | \
    tail -10 >> $LOG_FILE
}

main() {
    log_message "Starting PF monitoring check"
    check_state_table
    check_blocked_packets
    analyze_pflog
}

main "$@"
EOF

    chmod +x /usr/local/bin/pf-monitor.sh

    # Add cron job for regular monitoring
    echo "*/5 * * * * /usr/local/bin/pf-monitor.sh" | crontab -
}

optimize_pf_performance() {
    echo "Optimizing PF performance..."

    # Kernel tuning for PF
    cat >> /etc/sysctl.conf << 'EOF'
# PF Performance Tuning
net.pf.states_hashsize=32768
net.pf.src_nodes_hashsize=32768
net.pf.frags_hashsize=8192

# Network performance
net.inet.ip.forwarding=1
net.inet6.ip6.forwarding=1
net.inet.tcp.blackhole=2
net.inet.udp.blackhole=1
net.inet.tcp.delayed_ack=0

# Buffer sizes
kern.ipc.maxsockbuf=16777216
net.inet.tcp.sendspace=65536
net.inet.tcp.recvspace=65536
EOF

    # Apply sysctl settings
    sysctl -f /etc/sysctl.conf
}

validate_pf_configuration() {
    echo "Validating PF configuration..."

    # Test configuration syntax
    if pfctl -nf /etc/pf.conf; then
        echo "PF configuration syntax is valid"
    else
        echo "ERROR: PF configuration syntax errors found"
        exit 1
    fi

    # Check for common misconfigurations
    if grep -q "pass.*any.*any" /etc/pf.conf; then
        echo "WARNING: Overly permissive rules found"
    fi

    # Verify tables exist
    for table in malware_ips allowed_ssh geo_block_cn geo_block_ru; do
        if [[ ! -f "/etc/pf/${table}.txt" ]]; then
            echo "WARNING: Table file /etc/pf/${table}.txt not found"
        fi
    done
}

main() {
    echo "Setting up enterprise PF configuration..."

    # Generate configuration
    generate_enterprise_pf_conf

    # Setup tables
    setup_pf_tables

    # Configure logging
    configure_pf_logging

    # Setup monitoring
    setup_pf_monitoring

    # Optimize performance
    optimize_pf_performance

    # Validate configuration
    validate_pf_configuration

    # Load configuration
    pfctl -f /etc/pf.conf

    # Enable PF
    pfctl -e

    echo "Enterprise PF configuration completed successfully"
}

main "$@"
```

## AI Implementation Guidelines

### Enterprise PF Deployment Framework

1. **High-Performance Architecture**

   - **Rule Optimization**: Strategic rule ordering with quick rules for performance-critical paths
   - **State Management**: Optimized state table sizing and connection tracking for high-throughput environments
   - **Table Optimization**: Efficient table structures with radix trees for large IP sets and dynamic updates
   - **Memory Management**: Kernel parameter tuning for optimal memory utilization and performance scaling

2. **Advanced Security Features**

   - **Threat Intelligence Integration**: Automated malware IP feeds with real-time table updates
   - **Geographic Blocking**: Country-based IP blocking with automated geolocation data updates
   - **Anti-DDoS Protection**: Rate limiting, connection limits, and automatic blacklisting capabilities
   - **Deep Packet Inspection**: Packet normalization and scrubbing for advanced threat mitigation

3. **Enterprise Management and Automation**
   - **Configuration Management**: Version-controlled rule sets with automated deployment and rollback
   - **Dynamic Rule Generation**: Template-based rule generation with parameterized configurations
   - **Centralized Logging**: Comprehensive pflog analysis with SIEM integration and correlation
   - **Performance Monitoring**: Real-time statistics collection with alerting and capacity planning

### Production Deployment Patterns

1. **High-Availability Configuration**

   - **Clustering**: pfsync state synchronization with CARP failover for seamless redundancy
   - **Load Balancing**: Traffic distribution with health monitoring and automatic failover
   - **Geographic Distribution**: Multi-site deployment with WAN optimization and state replication
   - **Disaster Recovery**: Automated backup and restoration with configuration versioning

2. **Compliance and Governance**

   - **Audit Logging**: Comprehensive audit trails with tamper-proof logging and retention policies
   - **Policy Management**: Automated policy validation and compliance checking against security frameworks
   - **Change Management**: Approval workflows with staged deployments and impact analysis
   - **Risk Assessment**: Continuous security posture assessment with vulnerability management

3. **Monitoring and Analytics**
   - **Real-Time Metrics**: Prometheus integration with custom PF exporters and Grafana dashboards
   - **Log Analysis**: Automated log correlation with machine learning anomaly detection
   - **Performance Analytics**: Capacity planning with predictive scaling and optimization recommendations
   - **Security Intelligence**: Threat hunting capabilities with behavioral analysis and correlation

### Troubleshooting and Optimization

1. **Performance Optimization**

   - **Rule Efficiency**: Automated rule analysis with optimization recommendations and performance impact assessment
   - **Table Management**: Efficient table operations with incremental updates and memory optimization
   - **Connection Optimization**: TCP optimization with connection pooling and state management tuning
   - **Hardware Utilization**: Multi-core processing optimization with CPU affinity and interrupt handling

2. **Security Enhancement**
   - **Vulnerability Assessment**: Automated security scanning with configuration analysis and recommendations
   - **Threat Detection**: Real-time threat analysis with automated response and incident management
   - **Policy Analysis**: Security policy effectiveness analysis with gap identification and remediation
   - **Compliance Validation**: Continuous compliance monitoring with automated reporting and attestation

## Security Tool Overview

- **System**: PF (Packet Filter) Enterprise Stateful Firewall with Advanced Management Framework
- **Platform**: FreeBSD, OpenBSD, and derivatives with enterprise automation and monitoring
- **Type**: High-Performance Packet Filtering Engine with Enterprise Security Features
- **License**: BSD with comprehensive enterprise support and commercial integrations
- **Use Cases**: Enterprise firewalls, security appliances, high-throughput filtering, compliance environments
