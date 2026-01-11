# mysql-master.cnf
[mysqld]
server-id = 1
log-bin = mysql-bin
binlog-format = ROW
gtid-mode = ON
enforce-gtid-consistency = ON
log-slave-updates = ON
binlog-do-db = myapp

# Performance settings
innodb_buffer_pool_size = 2G
innodb_log_file_size = 512M
innodb_flush_log_at_trx_commit = 1
sync_binlog = 1
max_connections = 500
query_cache_type = 0
query_cache_size = 0

# mysql-slave.cnf
[mysqld]
read-only = 1
relay-log = relay-bin
gtid-mode = ON
enforce-gtid-consistency = ON
log-slave-updates = ON
slave-parallel-workers = 4
slave-parallel-type = LOGICAL_CLOCK