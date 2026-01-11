---
name: 'openwisp.instructions'
description: 'Development guidelines and best practices for Openwisp.Instructions'
keywords: [api, avoid, agent, compliance, architecture, assistant, authentication, database, advanced, capabilities]
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

See [example-1](./examples/openwisp/example-1.python)

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
