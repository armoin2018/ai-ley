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
  bindDN: "uid=app_svc,ou=Services,dc=example,dc=com"
  bindPassword: "${LDAP_BIND_PASSWORD}"
  userSearchBase: "ou=People,dc=example,dc=com"
  userFilter: "(mail={username})"
  groupSearchBase: "ou=Groups,dc=example,dc=com"
  groupFilter: "(&(objectClass=groupOfNames)(member={userDN}))"
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
