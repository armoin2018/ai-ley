#!/bin/bash
# docker-entrypoint-galera.sh - Custom entrypoint for Galera cluster initialization

set -eo pipefail

# Initialize Galera-specific configurations
if [ "$GALERA_CLUSTER" = "1" ]; then
    echo "Configuring Galera cluster node: $GALERA_NODE_NAME"

    # Update configuration with runtime values
    sed -i "s/wsrep_node_name = \"mariadb-node1\"/wsrep_node_name = \"$GALERA_NODE_NAME\"/" /etc/mysql/mariadb.conf.d/galera.cnf
    sed -i "s/wsrep_node_address = \"mariadb-node1\"/wsrep_node_address = \"$GALERA_NODE_ADDRESS\"/" /etc/mysql/mariadb.conf.d/galera.cnf
    sed -i "s|wsrep_cluster_address = \"gcomm://mariadb-node1,mariadb-node2,mariadb-node3\"|wsrep_cluster_address = \"$WSREP_CLUSTER_ADDRESS\"|" /etc/mysql/mariadb.conf.d/galera.cnf

    # Calculate InnoDB buffer pool size (70% of available memory)
    TOTAL_MEM=$(free -m | awk 'NR==2{printf "%.0f", $2*0.7}')
    sed -i "s/innodb_buffer_pool_size = 70%/innodb_buffer_pool_size = ${TOTAL_MEM}M/" /etc/mysql/mariadb.conf.d/galera.cnf

    # Bootstrap first node if needed
    if [ "$GALERA_NODE_NAME" = "mariadb-node1" ] && [ ! -f /var/lib/mysql/grastate.dat ]; then
        echo "Bootstrapping Galera cluster..."
        mysqld --wsrep-new-cluster --user=mysql &
        BOOTSTRAP_PID=$!

        # Wait for MySQL to start
        while ! mysqladmin ping -h localhost --silent; do
            sleep 1
        done

        # Create SST user
        mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "
            CREATE USER IF NOT EXISTS 'sstuser'@'%' IDENTIFIED BY 'sstpassword';
            GRANT RELOAD, LOCK TABLES, PROCESS, REPLICATION CLIENT ON *.* TO 'sstuser'@'%';
            FLUSH PRIVILEGES;
        "

        kill $BOOTSTRAP_PID
        wait $BOOTSTRAP_PID
    fi
fi

# Continue with original entrypoint
exec docker-entrypoint.sh "$@"