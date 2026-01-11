---
name: 'openwrt.instructions'
description: 'Development guidelines and best practices for Openwrt.Instructions'
keywords: [api, automation, avoid, agent, compliance, architecture, assistant, authentication, configuration, advanced]
---



# OpenWrt Router Security Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents regarding OpenWrt embedded Linux router firmware, covering open-source router customization, network security configuration, package management, UCI system, and edge device deployment for secure networking infrastructure.

### When to Use OpenWrt

- **Custom networking** requirements beyond standard firmware capabilities
- **Security-focused** deployments requiring open-source transparency
- **IoT gateway** applications needing flexible package management
- **Lab networks** and research environments requiring customization
- **Mesh networking** deployments with advanced protocol support

### When to Avoid OpenWrt

- **Enterprise environments** requiring vendor support and warranties
- **Non-technical users** needing simple, maintenance-free operation
- **Legacy hardware** with insufficient resources for modern security features
- **Compliance environments** requiring specific vendor certifications

### Architecture Essentials

- **UCI Configuration**: Unified Configuration Interface for system-wide settings
- **Package System**: opkg package manager with extensive software repository
- **Firewall Engine**: nftables/iptables with zone-based security policies
- **Network Services**: DNS (dnsmasq), DHCP (odhcpd), VPN (WireGuard/OpenVPN)
- **Management Interface**: LuCI web interface and SSH command-line access

### Security and Compliance Guidelines

- **Default Security**: Change default credentials and disable unnecessary services
- **Access Control**: Restrict management interfaces to LAN/VPN networks only
- **Firewall Zones**: Implement proper zone-based policies (LAN/WAN/guest)
- **Update Management**: Maintain current firmware with security patches
- **Certificate Security**: Enable HTTPS for web interface with valid certificates

### Performance Best Practices

- **QoS Implementation**: Use SQM with cake algorithm for bufferbloat control
- **Wi-Fi Optimization**: Channel planning, power management, and roaming features
- **Resource Management**: Monitor CPU, memory, and flash storage utilization
- **Network Segmentation**: VLAN implementation for IoT and guest access
- **Monitoring Integration**: Deploy collectd/telegraf for performance metrics

### AI Assistant Guidelines

- Always provide UCI-compatible configuration examples with proper syntax
- Include comprehensive firewall zone configurations with explicit policies
- Recommend SQM/QoS settings appropriate for connection types and speeds
- Provide security hardening checklists for production deployments
- Include backup and restore procedures for configuration management
- Suggest monitoring and alerting configurations for network health

### Enterprise OpenWrt Automation Framework

See [example-1](./examples/openwrt/example-1.python)

### Advanced Network Security Configuration

See [example-2](./examples/openwrt/example-2.bash)

## AI Implementation Guidelines

### Enterprise OpenWrt Deployment Framework

1. **Network Segmentation and Zero Trust**

   - **VLAN Implementation**: Create isolated network segments for management, IoT, guest, and production traffic
   - **Micro-Segmentation**: Implement granular firewall rules between network segments
   - **Identity-Based Access**: Deploy certificate-based authentication and RADIUS integration
   - **Continuous Monitoring**: Real-time network traffic analysis and behavioral monitoring

2. **Advanced Security Configuration**

   - **Firewall Hardening**: Implement advanced nftables rules with DDoS protection and geo-blocking
   - **Intrusion Detection**: Deploy Suricata IDS/IPS with custom rule sets and threat intelligence feeds
   - **WiFi Security**: WPA3 implementation with enterprise authentication and captive portal
   - **Access Control**: Role-based access control with multi-factor authentication

3. **Automation and Orchestration**
   - **Configuration Management**: Centralized UCI configuration management with version control
   - **Firmware Management**: Automated firmware updates with signature verification and rollback
   - **Monitoring Integration**: Comprehensive metrics collection with Prometheus and Grafana
   - **Backup Automation**: Encrypted configuration backups with disaster recovery procedures

### Production Deployment Patterns

1. **High-Availability Clustering**

   - **Failover Configuration**: Automatic failover with VRRP and link monitoring
   - **Load Balancing**: Multi-WAN load balancing with health checks and failover
   - **State Synchronization**: Configuration synchronization across cluster nodes
   - **Geographic Distribution**: Multi-site deployment with centralized management

2. **Compliance and Governance**

   - **Security Frameworks**: ISO 27001, NIST CSF, and PCI-DSS compliance templates
   - **Audit Logging**: Comprehensive audit trails with tamper-proof logging
   - **Policy Enforcement**: Automated compliance validation and remediation
   - **Risk Management**: Continuous risk assessment and threat modeling

3. **Performance Optimization**
   - **QoS Implementation**: Smart Queue Management (SQM) with traffic shaping
   - **Bandwidth Management**: Per-VLAN and per-user bandwidth allocation
   - **Hardware Acceleration**: Offloading optimization for high-throughput scenarios
   - **Caching Strategies**: DNS caching and content caching for performance

### Troubleshooting and Maintenance

1. **Diagnostic Capabilities**

   - **Network Analysis**: Advanced packet capture and traffic analysis tools
   - **Performance Monitoring**: Real-time system performance and network metrics
   - **Log Correlation**: Centralized log analysis with SIEM integration
   - **Health Checks**: Automated health monitoring with proactive alerting

2. **Maintenance Procedures**
   - **Configuration Versioning**: Git-based configuration management with rollback
   - **Update Procedures**: Staged firmware updates with testing and validation
   - **Capacity Planning**: Proactive resource monitoring and capacity planning
   - **Documentation**: Automated documentation generation and maintenance

## Security Tool Overview

- **System**: OpenWrt Embedded Linux Distribution with Enterprise Extensions
- **Platform**: Multi-architecture support with containerized management infrastructure
- **Type**: Open Source Router Firmware with Advanced Security Framework
- **License**: GPL with extensive package ecosystem and enterprise add-ons
- **Use Cases**: Enterprise edge security, IoT gateways, network segmentation, compliance environments

---
version: 2.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 2.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 2.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
