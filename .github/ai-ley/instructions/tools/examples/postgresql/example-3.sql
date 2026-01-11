-- Current connections analysis
SELECT
    datname,
    usename,
    client_addr,
    state,
    COUNT(*) as connection_count,
    MAX(now() - query_start) as longest_query_time,
    MAX(now() - state_change) as longest_idle_time
FROM pg_stat_activity
WHERE datname IS NOT NULL
GROUP BY datname, usename, client_addr, state
ORDER BY connection_count DESC;

-- Memory usage analysis
SELECT
    name,
    setting,
    unit,
    context,
    source
FROM pg_settings
WHERE name IN (
    'shared_buffers', 'work_mem', 'maintenance_work_mem',
    'effective_cache_size', 'wal_buffers', 'max_connections'
)
ORDER BY name;

-- Table bloat analysis
SELECT
    schemaname,
    tablename,
    n_tup_ins as inserts,
    n_tup_upd as updates,
    n_tup_del as deletes,
    n_live_tup as live_tuples,
    n_dead_tup as dead_tuples,
    round(100 * n_dead_tup / GREATEST(n_live_tup + n_dead_tup, 1), 2) as dead_tuple_percent,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE n_dead_tup > 1000
ORDER BY dead_tuple_percent DESC, n_dead_tup DESC
LIMIT 20;