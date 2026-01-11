-- 1. Check for missing statistics
SELECT schemaname, tablename, attname, n_distinct, correlation
FROM pg_stats
WHERE schemaname NOT IN ('information_schema', 'pg_catalog')
  AND n_distinct = -1  -- Indicates potentially stale statistics
ORDER BY schemaname, tablename;

-- Solution: Update statistics
ANALYZE; -- For all tables
-- OR for specific tables:
ANALYZE users;
ANALYZE orders;

-- 2. Check for unused indexes
SELECT
    schemaname,
    tablename,
    indexname,
    idx_scan,
    pg_size_pretty(pg_relation_size(indexrelid)) as size
FROM pg_stat_user_indexes
WHERE idx_scan < 10  -- Rarely used indexes
  AND pg_relation_size(indexrelid) > 1024*1024  -- Larger than 1MB
ORDER BY pg_relation_size(indexrelid) DESC;

-- 3. Check for table bloat requiring VACUUM
SELECT
    schemaname,
    tablename,
    n_dead_tup,
    n_live_tup,
    round(100 * n_dead_tup / GREATEST(n_live_tup + n_dead_tup, 1), 2) as bloat_percent
FROM pg_stat_user_tables
WHERE n_dead_tup > 10000
ORDER BY bloat_percent DESC;

-- Solution: Manual vacuum for heavily bloated tables
VACUUM ANALYZE users;
VACUUM ANALYZE orders;