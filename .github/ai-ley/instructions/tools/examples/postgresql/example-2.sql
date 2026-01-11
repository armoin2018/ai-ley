-- Detailed lock analysis
SELECT DISTINCT
    pl.pid,
    pl.mode,
    pl.granted,
    psa.usename,
    psa.query,
    psa.query_start,
    psa.state,
    c.relname as table_name,
    nsp.nspname as schema_name
FROM pg_locks pl
LEFT JOIN pg_stat_activity psa ON pl.pid = psa.pid
LEFT JOIN pg_class c ON pl.relation = c.oid
LEFT JOIN pg_namespace nsp ON c.relnamespace = nsp.oid
WHERE NOT pl.granted
ORDER BY psa.query_start;

-- Find blocking queries
SELECT
    blocking.pid AS blocking_pid,
    blocking_query.query AS blocking_query,
    blocked.pid AS blocked_pid,
    blocked_query.query AS blocked_query,
    blocked_query.state AS blocked_state
FROM pg_locks blocked
JOIN pg_stat_activity blocked_query ON blocked_query.pid = blocked.pid
JOIN pg_locks blocking ON blocking.locktype = blocked.locktype
    AND blocking.database IS NOT DISTINCT FROM blocked.database
    AND blocking.relation IS NOT DISTINCT FROM blocked.relation
    AND blocking.page IS NOT DISTINCT FROM blocked.page
    AND blocking.tuple IS NOT DISTINCT FROM blocked.tuple
    AND blocking.virtualxid IS NOT DISTINCT FROM blocked.virtualxid
    AND blocking.transactionid IS NOT DISTINCT FROM blocked.transactionid
    AND blocking.classid IS NOT DISTINCT FROM blocked.classid
    AND blocking.objid IS NOT DISTINCT FROM blocked.objid
    AND blocking.objsubid IS NOT DISTINCT FROM blocked.objsubid
    AND blocking.pid != blocked.pid
JOIN pg_stat_activity blocking_query ON blocking_query.pid = blocking.pid
WHERE NOT blocked.granted;

-- Kill problematic queries (use with caution)
-- SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE query_start < NOW() - INTERVAL '30 minutes' AND state = 'active';