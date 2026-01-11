---
name: 'libremesh.instructions'
description: 'Development guidelines and best practices for Libremesh.Instructions'
keywords: [api, cloud, agent, compliance, architecture, authentication, assistant, avoid, compose, community]
---



# LibreMesh Community Networking Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive enterprise-grade guidance for AI agents regarding LibreMesh community mesh networking framework, covering OpenWrt-based mesh networks, decentralized wireless infrastructure, routing protocols, and resilient community networking for secure distributed communications with production deployment automation.

### When to Use LibreMesh

- **Community networks** requiring decentralized, resilient wireless infrastructure with enterprise management
- **Emergency communications** where traditional infrastructure is unavailable with rapid deployment automation
- **Rural connectivity** projects bridging digital divides with comprehensive monitoring and analytics
- **Research environments** studying mesh networking protocols with automated testing frameworks
- **Disaster recovery** scenarios requiring rapid deployment with centralized orchestration
- **Smart city initiatives** needing scalable mesh infrastructure with IoT integration
- **Enterprise campus networks** requiring redundant wireless backbone with centralized management
- **Military/tactical deployments** needing secure, resilient communications with encryption

### When to Avoid LibreMesh

- **Traditional enterprise** networks with centralized management requirements
- **High-bandwidth** applications requiring guaranteed service levels
- **Regulatory environments** with strict wireless compliance requirements
- **Commercial deployments** needing vendor support and SLA guarantees

### Architecture Essentials

- **Advanced Mesh Protocols**: BMX6, BMX7, BATMAN-adv, OLSR/OLSRv2 with ML-based protocol optimization
- **Enterprise Auto-Configuration**: Automated interface setup, SSID management, and routing with centralized policies
- **Scalable Network Layers**: Layer-2 simplicity with BATMAN-adv or Layer-3 scalability with OLSR/BMX
- **Integrated Service Stack**: Captive portal, DHCP/DNS services, monitoring, and network analytics
- **Enhanced OpenWrt Foundation**: Enterprise OpenWrt platform with mesh-specific automation and monitoring
- **Cloud Integration**: Centralized management with cloud-based orchestration and analytics
- **Security Framework**: Built-in encryption, authentication, and intrusion detection systems
- **Performance Analytics**: Real-time network performance monitoring with predictive analytics

### Security and Compliance Guidelines

- **Management Isolation**: Separate management plane from user traffic with VLANs
- **Access Control**: VPN-based remote administration with credential rotation
- **Service Hardening**: Minimize exposed services and enforce HTTPS where available
- **Gateway Filtering**: Implement inbound filtering at internet gateway points
- **Monitoring Security**: Secure monitoring interfaces and data transmission

### Performance Best Practices

- **Protocol Selection**: Choose routing protocol based on scale, mobility, and performance requirements
- **RF Planning**: Comprehensive channel allocation, power management, and antenna optimization
- **QoS Implementation**: Traffic prioritization for fairness and critical applications
- **Power Management**: Stable power sources with backup systems for critical nodes
- **Topology Optimization**: Strategic placement of supernodes and gateway connections

### Enterprise LibreMesh Management Framework

See [example-1](./examples/libremesh/example-1.python)

### Docker Compose for LibreMesh Enterprise Platform

See [example-2](./examples/libremesh/example-2.yaml)

### AI Assistant Guidelines

- Always provide explicit protocol selection criteria with trade-offs and enterprise scalability considerations
- Include comprehensive RF planning guidance with channel allocation strategies and interference analysis
- Provide staged deployment approaches with automated testing, validation, and rollback procedures
- Include monitoring and alerting recommendations with enterprise SIEM integration
- Suggest security hardening measures with compliance framework alignment (ISO 27001, NIST)
- Recommend backup and disaster recovery procedures with automated failover capabilities
- Emphasize centralized management with distributed resilience for enterprise deployments
- Provide performance optimization guidelines with ML-based network analytics
- Include cost analysis and ROI calculations for community and enterprise deployments

## Security Tool Overview

- **Framework**: LibreMesh Enterprise Community Mesh Networking Platform
- **Platform**: Enhanced OpenWrt-based with enterprise mesh networking extensions and automation
- **Type**: Open Source Distributed Wireless Infrastructure with Centralized Management
- **License**: GPL with enterprise support and professional services available
- **Use Cases**: Enterprise mesh networks, community connectivity, emergency communications, smart city infrastructure, tactical deployments

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
