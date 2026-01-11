# Create streaming replication
pg_basebackup -h primary_host -D replica_data -U replication -W -v -P -x