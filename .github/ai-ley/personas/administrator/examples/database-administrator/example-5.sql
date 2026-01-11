-- Master configuration (postgresql.conf)
wal_level = replica
max_wal_senders = 10
max_replication_slots = 10
hot_standby = on
archive_mode = on
archive_command = 'cp %p /archive/%f'

-- Replica setup
standby_mode = 'on'
primary_conninfo = 'host=master-db port=5432 user=replicator'
recovery_target_timeline = 'latest'