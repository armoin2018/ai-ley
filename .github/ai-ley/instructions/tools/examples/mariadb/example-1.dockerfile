# Dockerfile for MariaDB Galera Cluster Node
FROM mariadb:11.2

# Install additional tools for clustering and monitoring
RUN apt-get update && apt-get install -y \
    socat \
    rsync \
    lsof \
    net-tools \
    telnet \
    curl \
    percona-toolkit \
    && rm -rf /var/lib/apt/lists/*

# Create directories for configuration and data
RUN mkdir -p /etc/mysql/mariadb.conf.d/ \
    /var/lib/mysql-files \
    /var/log/mysql

# Copy custom configuration
COPY galera.cnf /etc/mysql/mariadb.conf.d/

# Custom entrypoint for Galera initialization
COPY docker-entrypoint-galera.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint-galera.sh

# Health check for Galera cluster
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SHOW STATUS LIKE 'wsrep_ready';" | grep ON || exit 1

EXPOSE 3306 4444 4567 4568

ENTRYPOINT ["/usr/local/bin/docker-entrypoint-galera.sh"]
CMD ["mysqld"]