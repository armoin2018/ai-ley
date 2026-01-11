# Optimize MySQL configuration (my.cnf)
[mysqld]
# Set buffer pool to 70-80% of available RAM for dedicated MySQL servers
innodb_buffer_pool_size = 8G
innodb_buffer_pool_instances = 8

# Optimize other memory settings
innodb_log_buffer_size = 32M
key_buffer_size = 256M
tmp_table_size = 64M
max_heap_table_size = 64M
read_buffer_size = 2M
read_rnd_buffer_size = 4M
sort_buffer_size = 4M
join_buffer_size = 4M

# Query cache (disable for MySQL 8.0+)
query_cache_type = 0
query_cache_size = 0