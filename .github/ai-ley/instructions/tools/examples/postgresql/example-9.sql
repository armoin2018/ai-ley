-- 1. Increase WAL settings on primary
-- In postgresql.conf:
-- wal_keep_size = 2GB
-- max_wal_senders = 5
-- wal_sender_timeout = 60s

-- 2. Check network connectivity and bandwidth
-- 3. Consider switching to logical replication for specific tables
CREATE PUBLICATION my_publication FOR TABLE users, orders;
-- On replica:
CREATE SUBSCRIPTION my_subscription
CONNECTION 'host=primary_host port=5432 user=replicator dbname=myapp'
PUBLICATION my_publication;