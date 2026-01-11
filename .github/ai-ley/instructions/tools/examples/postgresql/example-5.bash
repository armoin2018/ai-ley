# 1. Implement connection pooling with PgBouncer
# pgbouncer.ini
[databases]
myapp = host=localhost port=5432 dbname=myapp

[pgbouncer]
listen_port = 6432
auth_type = md5
pool_mode = transaction
max_client_conn = 1000
default_pool_size = 50
server_reset_query = DISCARD ALL
server_check_delay = 30