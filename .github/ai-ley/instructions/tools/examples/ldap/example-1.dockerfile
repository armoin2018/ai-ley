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