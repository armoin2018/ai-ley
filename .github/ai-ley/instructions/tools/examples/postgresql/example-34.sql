-- Enable statistics collection
shared_preload_libraries = 'pg_stat_statements'
track_activity_query_size = 2048
track_counts = on
track_functions = all

-- Create monitoring views
CREATE VIEW slow_queries AS
SELECT
    query,
    calls,
    total_time / calls as avg_time,
    total_time,
    (total_time / sum(total_time) OVER ()) * 100 as percent_total
FROM pg_stat_statements
ORDER BY total_time DESC;

CREATE VIEW table_stats AS
SELECT
    schemaname,
    tablename,
    n_tup_ins + n_tup_upd + n_tup_del as total_writes,
    seq_scan,
    seq_tup_read,
    idx_scan,
    idx_tup_fetch
FROM pg_stat_user_tables;