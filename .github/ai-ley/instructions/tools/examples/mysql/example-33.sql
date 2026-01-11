-- Find CPU-intensive queries
SELECT
    SUBSTRING(digest_text, 1, 100) as query_sample,
    count_star as exec_count,
    avg_timer_wait/1000000000000 as avg_seconds,
    sum_timer_wait/1000000000000 as total_seconds
FROM performance_schema.events_statements_summary_by_digest
ORDER BY sum_timer_wait DESC
LIMIT 20;

-- Check for missing indexes
SELECT
    object_schema,
    object_name,
    index_name,
    count_read,
    count_write,
    count_fetch,
    count_insert,
    count_update,
    count_delete
FROM performance_schema.table_io_waits_summary_by_index_usage
WHERE index_name IS NULL
  AND count_read > 1000
ORDER BY count_read DESC;