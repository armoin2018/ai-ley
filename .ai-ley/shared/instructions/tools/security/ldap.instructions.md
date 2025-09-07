---
agentMode: general
applyTo: general
author: AI-LEY
description: LDAP directory services security implementation guide covering centralized authentication, secure user management, access control, enterprise identity management, production deployment strategies, threat modeling, and advanced security monitoring.
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
    identity-management,
    sso,
    security,
    access-control,
    enterprise,
    production-deployment,
    threat-modeling,
    compliance,
    monitoring,
  ]
lastUpdated: '2025-09-03T14:00:00.000000'
technicalQualityScore: 4.9
AIUsabilityScore: 4.9
title: LDAP Directory Services Security Instructions
version: 3.0
enhancement-level: '3-content-enhanced'
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

```dockerfile
# Dockerfile for Production OpenLDAP with Security Hardening
FROM ubuntu:22.04

# Install OpenLDAP and security tools
RUN apt-get update && apt-get install -y \
    slapd \
    ldap-utils \
    openssl \
    ca-certificates \
    rsyslog \
    logrotate \
    fail2ban \
    apparmor-utils \
    auditd \
    && rm -rf /var/lib/apt/lists/*

# Create LDAP user and directories
RUN useradd -r -s /bin/false -d /var/lib/openldap openldap && \
    mkdir -p /etc/ldap/ssl /var/lib/openldap /var/log/openldap && \
    chown -R openldap:openldap /var/lib/openldap /var/log/openldap

# Copy configuration files
COPY slapd.conf /etc/ldap/
COPY security/ /etc/ldap/security/
COPY scripts/ /usr/local/bin/

# Set proper permissions for security
RUN chmod 600 /etc/ldap/slapd.conf && \
    chmod 700 /etc/ldap/security && \
    chmod +x /usr/local/bin/*.sh

# Create SSL certificates directory
RUN mkdir -p /etc/ldap/ssl && \
    chown openldap:openldap /etc/ldap/ssl && \
    chmod 700 /etc/ldap/ssl

# Configure logging
COPY rsyslog-ldap.conf /etc/rsyslog.d/49-ldap.conf
COPY logrotate-ldap /etc/logrotate.d/openldap

# Security hardening
RUN echo "openldap soft nofile 65536" >> /etc/security/limits.conf && \
    echo "openldap hard nofile 65536" >> /etc/security/limits.conf

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD ldapsearch -x -H ldap://localhost:389 -b "" -s base "(objectclass=*)" namingContexts || exit 1

EXPOSE 389 636

USER openldap
ENTRYPOINT ["/usr/local/bin/ldap-entrypoint.sh"]
CMD ["slapd", "-d", "256", "-f", "/etc/ldap/slapd.conf"]
```

```yaml
# docker-compose.yml for HA LDAP Cluster with Monitoring
version: '3.8'

services:
  ldap-master:
    build: .
    container_name: ldap-master
    hostname: ldap-master
    restart: unless-stopped
    environment:
      - LDAP_DOMAIN=company.com
      - LDAP_ORGANIZATION="Company Inc"
      - LDAP_ADMIN_PASSWORD_FILE=/run/secrets/ldap_admin_password
      - LDAP_CONFIG_PASSWORD_FILE=/run/secrets/ldap_config_password
      - LDAP_SSL_CERT_FILE=/etc/ldap/ssl/server.crt
      - LDAP_SSL_KEY_FILE=/etc/ldap/ssl/server.key
      - LDAP_SSL_CA_FILE=/etc/ldap/ssl/ca.crt
      - REPLICATION_ROLE=master
      - ENABLE_SECURITY_AUDIT=true
    volumes:
      - ldap_data_master:/var/lib/openldap
      - ldap_config_master:/etc/ldap
      - ldap_ssl:/etc/ldap/ssl:ro
      - ldap_logs_master:/var/log/openldap
    ports:
      - '389:389'
      - '636:636'
    networks:
      ldap_cluster:
        ipv4_address: 172.25.0.10
    secrets:
      - ldap_admin_password
      - ldap_config_password
    logging:
      driver: 'json-file'
      options:
        max-size: '10m'
        max-file: '3'
    deploy:
      resources:
        limits:
          memory: 1G
          cpus: '0.5'
        reservations:
          memory: 512M
          cpus: '0.25'

  ldap-replica1:
    build: .
    container_name: ldap-replica1
    hostname: ldap-replica1
    restart: unless-stopped
    environment:
      - LDAP_DOMAIN=company.com
      - LDAP_ORGANIZATION="Company Inc"
      - LDAP_ADMIN_PASSWORD_FILE=/run/secrets/ldap_admin_password
      - LDAP_CONFIG_PASSWORD_FILE=/run/secrets/ldap_config_password
      - LDAP_SSL_CERT_FILE=/etc/ldap/ssl/server.crt
      - LDAP_SSL_KEY_FILE=/etc/ldap/ssl/server.key
      - LDAP_SSL_CA_FILE=/etc/ldap/ssl/ca.crt
      - REPLICATION_ROLE=replica
      - REPLICATION_MASTER=ldap-master
      - ENABLE_SECURITY_AUDIT=true
    volumes:
      - ldap_data_replica1:/var/lib/openldap
      - ldap_config_replica1:/etc/ldap
      - ldap_ssl:/etc/ldap/ssl:ro
      - ldap_logs_replica1:/var/log/openldap
    ports:
      - '390:389'
      - '637:636'
    networks:
      ldap_cluster:
        ipv4_address: 172.25.0.11
    depends_on:
      - ldap-master
    secrets:
      - ldap_admin_password
      - ldap_config_password

  ldap-replica2:
    build: .
    container_name: ldap-replica2
    hostname: ldap-replica2
    restart: unless-stopped
    environment:
      - LDAP_DOMAIN=company.com
      - LDAP_ORGANIZATION="Company Inc"
      - LDAP_ADMIN_PASSWORD_FILE=/run/secrets/ldap_admin_password
      - LDAP_CONFIG_PASSWORD_FILE=/run/secrets/ldap_config_password
      - LDAP_SSL_CERT_FILE=/etc/ldap/ssl/server.crt
      - LDAP_SSL_KEY_FILE=/etc/ldap/ssl/server.key
      - LDAP_SSL_CA_FILE=/etc/ldap/ssl/ca.crt
      - REPLICATION_ROLE=replica
      - REPLICATION_MASTER=ldap-master
      - ENABLE_SECURITY_AUDIT=true
    volumes:
      - ldap_data_replica2:/var/lib/openldap
      - ldap_config_replica2:/etc/ldap
      - ldap_ssl:/etc/ldap/ssl:ro
      - ldap_logs_replica2:/var/log/openldap
    ports:
      - '391:389'
      - '638:636'
    networks:
      ldap_cluster:
        ipv4_address: 172.25.0.12
    depends_on:
      - ldap-master
    secrets:
      - ldap_admin_password
      - ldap_config_password

  # HAProxy Load Balancer for LDAP
  ldap-lb:
    image: haproxy:latest
    container_name: ldap-haproxy
    restart: unless-stopped
    ports:
      - '8389:389' # Load balanced LDAP
      - '8636:636' # Load balanced LDAPS
      - '8404:8404' # HAProxy stats
    volumes:
      - ./haproxy-ldap.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro
    networks:
      ldap_cluster:
        ipv4_address: 172.25.0.5
    depends_on:
      - ldap-master
      - ldap-replica1
      - ldap-replica2

  # LDAP Security Monitoring
  ldap-monitor:
    image: prom/prometheus:latest
    container_name: ldap-prometheus
    restart: unless-stopped
    ports:
      - '9090:9090'
    volumes:
      - ./prometheus-ldap.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus_data:/prometheus
    networks:
      - ldap_cluster
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=30d'
      - '--web.enable-lifecycle'

  # Security Event Collector
  security-collector:
    image: elastic/filebeat:7.17.0
    container_name: ldap-security-collector
    restart: unless-stopped
    user: root
    volumes:
      - ldap_logs_master:/var/log/ldap/master:ro
      - ldap_logs_replica1:/var/log/ldap/replica1:ro
      - ldap_logs_replica2:/var/log/ldap/replica2:ro
      - ./filebeat-ldap.yml:/usr/share/filebeat/filebeat.yml:ro
    networks:
      - ldap_cluster
    environment:
      - ELASTICSEARCH_HOST=elasticsearch:9200

volumes:
  ldap_data_master:
    driver: local
  ldap_data_replica1:
    driver: local
  ldap_data_replica2:
    driver: local
  ldap_config_master:
    driver: local
  ldap_config_replica1:
    driver: local
  ldap_config_replica2:
    driver: local
  ldap_ssl:
    driver: local
  ldap_logs_master:
    driver: local
  ldap_logs_replica1:
    driver: local
  ldap_logs_replica2:
    driver: local
  prometheus_data:
    driver: local

networks:
  ldap_cluster:
    driver: bridge
    ipam:
      config:
        - subnet: 172.25.0.0/16

secrets:
  ldap_admin_password:
    file: ./secrets/ldap_admin_password.txt
  ldap_config_password:
    file: ./secrets/ldap_config_password.txt
```

### Kubernetes Deployment with Security Hardening

```yaml
# ldap-cluster-k8s.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: ldap-config
data:
  slapd.conf: |
    # OpenLDAP Security-Hardened Configuration
    include /etc/ldap/schema/core.schema
    include /etc/ldap/schema/cosine.schema
    include /etc/ldap/schema/nis.schema
    include /etc/ldap/schema/inetorgperson.schema

    # Process ID and arguments files
    pidfile /var/run/openldap/slapd.pid
    argsfile /var/run/openldap/slapd.args

    # Load dynamic backend modules
    modulepath /usr/lib/ldap
    moduleload back_mdb.la
    moduleload syncprov.la
    moduleload accesslog.la
    moduleload auditlog.la

    # SSL/TLS Configuration
    TLSCertificateFile /etc/ldap/ssl/server.crt
    TLSCertificateKeyFile /etc/ldap/ssl/server.key
    TLSCACertificateFile /etc/ldap/ssl/ca.crt
    TLSCipherSuite HIGH:MEDIUM:!aNULL:!MD5:!RC4
    TLSProtocolMin 3.3
    TLSVerifyClient demand

    # Security Settings
    security ssf=128
    require authc
    disallow bind_anon

    # Logging for security audit
    loglevel stats sync config

    # Access Control Lists
    access to attrs=userPassword
        by self write
        by anonymous auth
        by group.exact="cn=admin,ou=groups,dc=company,dc=com" write
        by * none

    access to attrs=shadowLastChange
        by self write
        by * read

    access to *
        by group.exact="cn=admin,ou=groups,dc=company,dc=com" write
        by users read
        by * none

    # Database Configuration
    database mdb
    suffix "dc=company,dc=com"
    rootdn "cn=admin,dc=company,dc=com"
    rootpw {SSHA}generated_password_hash

    directory /var/lib/openldap
    maxsize 1073741824

    # Indexes for performance
    index objectClass eq
    index cn eq,sub
    index uid eq
    index uidNumber eq
    index gidNumber eq
    index memberUid eq
    index mail eq,sub
    index entryCSN eq
    index entryUUID eq

    # Replication Configuration
    overlay syncprov
    syncprov-checkpoint 100 10
    syncprov-sessionlog 100

    # Audit Logging
    overlay auditlog
    auditlog /var/log/openldap/audit.log

    # Access Log for Security Monitoring
    database mdb
    suffix "cn=accesslog"
    rootdn "cn=accesslog"
    directory /var/lib/openldap/accesslog
    maxsize 104857600

    index default eq
    index entryCSN,objectClass,reqEnd,reqResult,reqStart

    overlay accesslog
    logdb cn=accesslog
    logops writes
    logold (objectclass=person)
    logpurge 30+00:00 1+00:00

---
apiVersion: v1
kind: Secret
metadata:
  name: ldap-secrets
type: Opaque
data:
  admin-password: YWRtaW5fcGFzc3dvcmQ= # admin_password (base64)
  config-password: Y29uZmlnX3Bhc3N3b3Jk # config_password (base64)

---
apiVersion: v1
kind: Secret
metadata:
  name: ldap-tls
type: kubernetes.io/tls
data:
  tls.crt: LS0tLS1CRUdJTi... # Base64 encoded certificate
  tls.key: LS0tLS1CRUdJTi... # Base64 encoded private key
  ca.crt: LS0tLS1CRUdJTi... # Base64 encoded CA certificate

---
apiVersion: v1
kind: Service
metadata:
  name: ldap-service
  labels:
    app: ldap
spec:
  ports:
    - port: 389
      name: ldap
    - port: 636
      name: ldaps
  clusterIP: None
  selector:
    app: ldap

---
apiVersion: v1
kind: Service
metadata:
  name: ldap-lb
  labels:
    app: ldap
spec:
  type: LoadBalancer
  ports:
    - port: 389
      targetPort: 389
      name: ldap
    - port: 636
      targetPort: 636
      name: ldaps
  selector:
    app: ldap

---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: ldap
spec:
  serviceName: ldap-service
  replicas: 3
  selector:
    matchLabels:
      app: ldap
  template:
    metadata:
      labels:
        app: ldap
      annotations:
        prometheus.io/scrape: 'true'
        prometheus.io/port: '9115'
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        runAsGroup: 1000
        fsGroup: 1000
      containers:
        - name: ldap
          image: osixia/openldap:latest
          ports:
            - containerPort: 389
              name: ldap
            - containerPort: 636
              name: ldaps
          env:
            - name: LDAP_ORGANISATION
              value: 'Company Inc'
            - name: LDAP_DOMAIN
              value: 'company.com'
            - name: LDAP_ADMIN_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: ldap-secrets
                  key: admin-password
            - name: LDAP_CONFIG_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: ldap-secrets
                  key: config-password
            - name: LDAP_TLS
              value: 'true'
            - name: LDAP_TLS_VERIFY_CLIENT
              value: 'demand'
            - name: LDAP_TLS_PROTOCOL_MIN
              value: '3.3'
            - name: LDAP_TLS_CIPHER_SUITE
              value: 'HIGH:MEDIUM:!aNULL:!MD5:!RC4'
          volumeMounts:
            - name: ldap-data
              mountPath: /var/lib/ldap
            - name: ldap-config
              mountPath: /etc/ldap/slapd.d
            - name: ldap-tls
              mountPath: /container/service/slapd/assets/certs
              readOnly: true
            - name: ldap-logs
              mountPath: /var/log/openldap
          resources:
            requests:
              memory: '512Mi'
              cpu: '250m'
            limits:
              memory: '1Gi'
              cpu: '500m'
          livenessProbe:
            tcpSocket:
              port: 389
            initialDelaySeconds: 30
            periodSeconds: 30
          readinessProbe:
            exec:
              command:
                - ldapsearch
                - -x
                - -H
                - ldap://localhost:389
                - -b
                - ''
                - -s
                - base
                - '(objectclass=*)'
            initialDelaySeconds: 10
            periodSeconds: 10

        # Security Monitoring Sidecar
        - name: security-monitor
          image: prom/node-exporter:latest
          ports:
            - containerPort: 9100
              name: metrics
          volumeMounts:
            - name: ldap-logs
              mountPath: /var/log/openldap
              readOnly: true
          resources:
            requests:
              memory: '64Mi'
              cpu: '50m'
            limits:
              memory: '128Mi'
              cpu: '100m'

      volumes:
        - name: ldap-tls
          secret:
            secretName: ldap-tls
        - name: ldap-logs
          emptyDir: {}

  volumeClaimTemplates:
    - metadata:
        name: ldap-data
      spec:
        accessModes: ['ReadWriteOnce']
        storageClassName: fast-ssd
        resources:
          requests:
            storage: 10Gi
    - metadata:
        name: ldap-config
      spec:
        accessModes: ['ReadWriteOnce']
        storageClassName: fast-ssd
        resources:
          requests:
            storage: 1Gi

---
# Security Monitoring and Alerting
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-ldap-config
data:
  prometheus.yml: |
    global:
      scrape_interval: 30s
      evaluation_interval: 30s

    rule_files:
      - "/etc/prometheus/ldap-alerts.yml"

    scrape_configs:
      - job_name: 'ldap-nodes'
        static_configs:
          - targets: ['ldap-0:9100', 'ldap-1:9100', 'ldap-2:9100']
        metrics_path: /metrics
        scrape_interval: 30s

    alerting:
      alertmanagers:
        - static_configs:
            - targets: ['alertmanager:9093']

---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: ldap-security-audit
spec:
  schedule: '0 2 * * *' # Daily at 2 AM
  jobTemplate:
    spec:
      template:
        spec:
          containers:
            - name: security-audit
              image: alpine:latest
              command:
                - sh
                - -c
                - |
                  apk add --no-cache openldap-clients

                  # Security audit script
                  echo "LDAP Security Audit - $(date)"

                  # Check for unused accounts
                  ldapsearch -x -H ldap://ldap-service:389 \
                    -D "cn=admin,dc=company,dc=com" \
                    -w "$LDAP_ADMIN_PASSWORD" \
                    -b "ou=people,dc=company,dc=com" \
                    "(lastLogonTimestamp<=$(date -d '90 days ago' +%Y%m%d%H%M%S)Z)" \
                    dn > /tmp/unused_accounts.txt

                  # Check for accounts without password expiry
                  ldapsearch -x -H ldap://ldap-service:389 \
                    -D "cn=admin,dc=company,dc=com" \
                    -w "$LDAP_ADMIN_PASSWORD" \
                    -b "ou=people,dc=company,dc=com" \
                    "(&(objectClass=person)(!(passwordExpirationTime=*)))" \
                    dn > /tmp/no_expiry_accounts.txt

                  # Check for privileged accounts
                  ldapsearch -x -H ldap://ldap-service:389 \
                    -D "cn=admin,dc=company,dc=com" \
                    -w "$LDAP_ADMIN_PASSWORD" \
                    -b "ou=groups,dc=company,dc=com" \
                    "(cn=admin)" member > /tmp/admin_members.txt

                  echo "Security audit completed. Results stored in /tmp/"
              env:
                - name: LDAP_ADMIN_PASSWORD
                  valueFrom:
                    secretKeyRef:
                      name: ldap-secrets
                      key: admin-password
              volumeMounts:
                - name: audit-logs
                  mountPath: /tmp
          volumes:
            - name: audit-logs
              persistentVolumeClaim:
                claimName: ldap-audit-pvc
          restartPolicy: OnFailure
```

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

```bash
# OpenLDAP client tools (Debian/Ubuntu)
sudo apt-get install ldap-utils

# Basic connectivity test
ldapwhoami -x -H ldap://ldap.example.com -D "cn=admin,dc=example,dc=com" -w 'password'

# Search examples (anonymous or bound)
ldapsearch -x -H ldap://ldap.example.com -b "dc=example,dc=com" "(objectClass=person)" cn mail

# Add entries from LDIF
ldapadd -H ldap://ldap.example.com -D "cn=admin,dc=example,dc=com" -w 'password' -f users.ldif

# Modify entries
ldapmodify -H ldap://ldap.example.com -D "cn=admin,dc=example,dc=com" -w 'password' <<'EOF'
dn: uid=jdoe,ou=People,dc=example,dc=com
changetype: modify
replace: mail
mail: jdoe@example.com
EOF

# Delete entries
ldapdelete -H ldap://ldap.example.com -D "cn=admin,dc=example,dc=com" -w 'password' "uid=jdoe,ou=People,dc=example,dc=com"
```

### LDIF examples

```ldif
# Base DIT
dn: dc=example,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Example Corp
dc: example

# Organizational Units
dn: ou=People,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: People

dn: ou=Groups,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: Groups

# User entry
dn: uid=jdoe,ou=People,dc=example,dc=com
objectClass: inetOrgPerson
cn: John Doe
sn: Doe
uid: jdoe
mail: john.doe@example.com
userPassword: {SSHA}H9C7...   # hashed

# Group entry
dn: cn=engineering,ou=Groups,dc=example,dc=com
objectClass: groupOfNames
cn: engineering
member: uid=jdoe,ou=People,dc=example,dc=com
```

### Access control (olcAccess) example

```ldif
# Grant self-service password change; allow admins full control
# Apply to database config (cn=config) or specific DB as appropriate

dn: olcDatabase={1}mdb,cn=config
changetype: modify
add: olcAccess
olcAccess: to attrs=userPassword
  by self write
  by dn="cn=admin,dc=example,dc=com" write
  by anonymous auth
  by * none
-
olcAccess: to *
  by dn="cn=admin,dc=example,dc=com" write
  by users read
  by anonymous auth
```

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

```yaml
ldap:
  url: ldaps://ldap.example.com:636
  bindDN: 'uid=app_svc,ou=Services,dc=example,dc=com'
  bindPassword: '${LDAP_BIND_PASSWORD}'
  userSearchBase: 'ou=People,dc=example,dc=com'
  userFilter: '(mail={username})'
  groupSearchBase: 'ou=Groups,dc=example,dc=com'
  groupFilter: '(&(objectClass=groupOfNames)(member={userDN}))'
  tls:
    caFile: /etc/ssl/certs/ca-bundle.crt
    requireValidCert: true
```

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

```bash
# Verbose client logging
LDAPTLS_REQCERT=demand LDAPDEBUG=1 ldapsearch -ZZ -H ldap://ldap.example.com -b dc=example,dc=com "(uid=jdoe)"

# Check server cert/chain
openssl s_client -connect ldap.example.com:636 -showcerts

# Index issues
sudo grep index /etc/ldap/slapd.d/cn=config/olcDatabase=*/olcDbIndex*.ldif
```

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
