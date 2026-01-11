---
name: 'tomato.instructions'
description: 'Development guidelines and best practices for Tomato.Instructions'
keywords: [api, enterprise, agent, compliance, docker, architecture, assistant, avoid, cli, compose]
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

See [example-1](./examples/tomato/example-1.python)

### Docker Compose for Tomato Enterprise Management

See [example-2](./examples/tomato/example-2.yaml)

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
