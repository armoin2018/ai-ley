---
name: 'pf.instructions'
description: 'Development guidelines and best practices for Pf.Instructions'
keywords: [deployment, api, cloud, avoid, agent, compliance, architecture, assistant, configuration, advanced]
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

See [example-1](./examples/pf/example-1.python)

### Advanced PF Configuration Examples

See [example-2](./examples/pf/example-2.bash)

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
