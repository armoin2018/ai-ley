---
name: 'LDAP Directory Services Security Instructions'
description: 'LDAP directory services security implementation guide covering centralized authentication, secure user management, access control, enterprise identity management, production deployment strategies, threat modeling, and advanced security monitoring.'
keywords: [api, (olcaccess), agent, (lightweight, access, architecture, assistant, authentication, authorization, advanced]
---


# LDAP Directory Services Security Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents implementing LDAP directory services, emphasizing centralized authentication, secure user management, access control, enterprise identity management with proper security hardening, production deployment strategies, threat modeling, and advanced security monitoring.

### When to Use LDAP

- **Centralized authentication** across multiple applications and systems
- **Enterprise user management** requiring hierarchical directory structures
- **Single sign-on (SSO)** implementations and identity federation
- **Legacy system integration** requiring standardized directory access
- **Large-scale user management** with complex organizational structures
- **Hybrid cloud environments** requiring on-premises identity integration
- **Compliance requirements** demanding centralized access control

### When to Avoid LDAP

- **Small-scale applications** → consider simpler authentication methods
- **Cloud-native environments** → use cloud identity providers (Azure AD, AWS IAM)
- **Modern applications** → consider OAuth 2.0/OpenID Connect for API access
- **High-performance scenarios** → cache authentication data appropriately

### Architecture Essentials

- **Directory Information Tree (DIT)**: Hierarchical structure for organizing entries
- **Schema Management**: Object classes and attributes defining entry structure
- **Replication**: Multi-master and master-slave replication for high availability
- **Access Control**: ACLs for fine-grained permissions and security policies

## Production Deployment Patterns

### High Availability LDAP Cluster with Security Hardening

See [example-1](./examples/ldap/example-1.dockerfile)

See [example-2](./examples/ldap/example-2.yaml)

### Kubernetes Deployment with Security Hardening

See [example-3](./examples/ldap/example-3.yaml)

- **Protocol**: LDAP v3 (RFC 4511)
- **Implementations**: OpenLDAP, Microsoft Active Directory, Apache Directory Server
- **Type**: Directory Services and Identity Management Protocol
- **License**: Open Standard (IETF)
- **Use Cases**: Authentication, authorization, user management, SSOhor: AI-LEY
  description: LDAP (Lightweight Directory Access Protocol) implementation guide covering directory services, centralized authentication, user management, access control, and enterprise identity management with OpenLDAP and Active Directory integration.
  extensions:
  - .md
    guidelines: N/A
    instructionType: security
    keywords:
    [
    ldap,
    directory-services,
    authentication,
    authorization,
    user-management,
    access-control,
    identity-management,
    openldap,
    active-directory,
    ]
    lastUpdated: '2025-09-03T14:30:00.000000'
    technicalQualityScore: 4.8
    AIUsabilityScore: 4.8
    title: LDAP Directory Services Security Instructions
    version: 1.1.0

---

# LDAP (Lightweight Directory Access Protocol) Instructions

## Overview

LDAP is an open protocol for accessing and maintaining distributed directory information services over an IP network. It’s commonly used for centralized authentication, authorization, and user/group management (e.g., OpenLDAP, Active Directory Lightweight Directory Services).

## Core Concepts

- Entries and DNs: Objects stored as entries identified by Distinguished Names
- Schema: Defines objectClasses and attributes
- DIT: Directory Information Tree hierarchical structure
- Bind: Authentication to the directory
- Search: Querying entries by scope and filter
- Modify: Add/modify/delete entries and attributes
- Access Control: ACLs to control who can read/modify what

## Implementation Framework

### CLI tooling

See [example-4](./examples/ldap/example-4.bash)

### LDIF examples

See [example-5](./examples/ldap/example-5.ldif)

### Access control (olcAccess) example

See [example-6](./examples/ldap/example-6.ldif)

## Best Practices

- Use LDAPS (StartTLS or ldaps://) for all binds and searches
- Hash and salt passwords (SSHA/SSHA512 or external IdP)
- Principle of least privilege in ACLs
- Separate service accounts with narrowly scoped permissions
- Index frequently searched attributes (cn, sn, uid, mail)
- Document your DIT and schema decisions
- Backup regularly (slapcat) and test restore procedures

## Common Patterns

### App authentication pattern

- Application binds with service account
- Searches for user DN via unique attribute (mail/uid)
- Binds as user DN to verify password (password check)
- Optionally check group membership for authorization

Pseudo-config for an app:

See [example-7](./examples/ldap/example-7.yaml)

### Synchronization and federation

- Use LDAP sync tools (syncrepl) for replication
- Integrate with SSO/IdP (SAML/OIDC) for modern auth flows
- Map LDAP groups to application roles

## Tools and Resources

- OpenLDAP: slapd(8), slapcat(8), slapadd(8)
- Schema tooling: ldap-schema, OID management
- Libraries: python-ldap, node-ldapjs, go-ldap
- GUIs: Apache Directory Studio, phpldapadmin

## Quality and Compliance

- Enforce TLS: disable simple binds over plain text
- Rotate service account credentials; store in secret manager
- Audit access and changes (cn=monitor, logs)
- GDPR/PII: minimize attributes, define retention policies

## Troubleshooting

See [example-8](./examples/ldap/example-8.bash)

## Metrics and Monitoring

- Bind success/failure rates
- Search latency and throughput
- Replication lag (syncrepl)
- Entry count and index hit rates

## Integration Patterns

- PAM/NSS for system logins (sssd)
- Reverse proxies and auth gateways mapping LDAP groups to roles
- SCIM for provisioning into SaaS

## Advanced Topics

- Multi-master replication and conflict resolution
- Overlay modules (memberof, ppolicy)
- Custom schema extensions (enterprise attributes)

## AI Assistant Guidelines

Use LDAP when:

- Centralizing authN/authZ for many apps/services
- Need hierarchical, attribute-rich directory
- Integrating legacy systems with standard protocol

Avoid when:

- You need modern OAuth/OIDC flows only (prefer IdP)
- Highly dynamic, document-like data (use DB)

Code generation rules:

- Never hardcode secrets; reference env/secret manager
- Always enforce TLS and validate certificates
- Use parameterized filters to avoid injection
- Paginate searches for large directories

Quality enforcement:

- Valid DN formats and escaped filter values
- Minimal privilege binds
- Documented DIT, schema, and ACLs
- Backups and tested restores

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
