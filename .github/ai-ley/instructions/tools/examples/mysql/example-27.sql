-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;
SET GLOBAL log_queries_not_using_indexes = 'ON';

-- Analyze slow queries with Performance Schema
SELECT
    SUBSTRING(digest_text, 1, 100) as query_sample,
    schema_name,
    count_star as exec_count,
    avg_timer_wait/1000000000000 as avg_seconds,
    sum_timer_wait/1000000000000 as total_seconds,
    sum_rows_examined/count_star as avg_rows_examined,
    sum_rows_sent/count_star as avg_rows_sent,
    ROUND((sum_timer_wait/1000000000000 / SUM(sum_timer_wait/1000000000000) OVER()) * 100, 2) as percent_total
FROM performance_schema.events_statements_summary_by_digest
WHERE schema_name = 'myapp'
  AND avg_timer_wait/1000000000000 > 0.1
ORDER BY avg_timer_wait DESC
LIMIT 20;

-- Find queries with high examination to sent ratio (inefficient queries)
SELECT
    SUBSTRING(digest_text, 1, 80) as query_sample,
    count_star as executions,
    sum_rows_examined as total_rows_examined,
    sum_rows_sent as total_rows_sent,
    ROUND(sum_rows_examined / sum_rows_sent, 2) as examination_ratio
FROM performance_schema.events_statements_summary_by_digest
WHERE sum_rows_sent > 0
  AND sum_rows_examined / sum_rows_sent > 100
ORDER BY examination_ratio DESC
LIMIT 10;