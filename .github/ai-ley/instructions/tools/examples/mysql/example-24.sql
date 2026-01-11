-- Enable Performance Schema
UPDATE performance_schema.setup_instruments
SET ENABLED = 'YES', TIMED = 'YES'
WHERE NAME LIKE '%statement%';

-- Monitor slow queries
SELECT
    schema_name,
    LEFT(digest_text, 64) as query_preview,
    count_star as exec_count,
    avg_timer_wait/1000000000000 as avg_time_sec,
    sum_rows_examined/count_star as avg_rows_examined
FROM performance_schema.events_statements_summary_by_digest
WHERE avg_timer_wait/1000000000000 > 1
ORDER BY avg_timer_wait DESC
LIMIT 10;

-- Monitor table sizes
SELECT
    table_schema as 'Database',
    table_name as 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) as 'Size (MB)',
    table_rows as 'Rows'
FROM information_schema.tables
WHERE table_schema = 'myapp'
ORDER BY (data_length + index_length) DESC;

-- Monitor replication lag
SHOW SLAVE STATUS\G