-- Comprehensive slow query analysis
WITH slow_queries AS (
    SELECT
        query,
        calls,
        total_exec_time,
        mean_exec_time,
        stddev_exec_time,
        rows,
        100.0 * shared_blks_hit / nullif(shared_blks_hit + shared_blks_read, 0) AS hit_percent,
        (total_exec_time / sum(total_exec_time) OVER ()) * 100 AS percent_total_time
    FROM pg_stat_statements
    WHERE calls > 100  -- Filter out one-off queries
    ORDER BY mean_exec_time DESC
    LIMIT 20
)
SELECT
    substring(query, 1, 100) || '...' as query_snippet,
    calls,
    round(mean_exec_time::numeric, 2) as avg_time_ms,
    round(hit_percent::numeric, 2) as cache_hit_percent,
    round(percent_total_time::numeric, 2) as percent_of_total_time
FROM slow_queries;

-- Find queries with low cache hit rates
SELECT
    substring(query, 1, 80) as query,
    calls,
    shared_blks_hit,
    shared_blks_read,
    round(100.0 * shared_blks_hit / nullif(shared_blks_hit + shared_blks_read, 0), 2) as hit_percent
FROM pg_stat_statements
WHERE shared_blks_read > 0
ORDER BY hit_percent ASC, calls DESC
LIMIT 10;