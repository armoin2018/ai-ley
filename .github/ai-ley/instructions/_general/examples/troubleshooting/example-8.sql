-- Database performance troubleshooting queries

-- 1. Identify slow queries
SELECT 
    query_time,
    lock_time,
    rows_sent,
    rows_examined,
    sql_text
FROM mysql.slow_log 
WHERE start_time >= DATE_SUB(NOW(), INTERVAL 1 HOUR)
ORDER BY query_time DESC
LIMIT 20;

-- 2. Check for blocking queries
SHOW PROCESSLIST;

-- 3. Analyze index usage
EXPLAIN SELECT * FROM users WHERE email = 'user@example.com';

-- 4. Check table locks
SHOW OPEN TABLES WHERE In_use > 0;

-- 5. Monitor connection usage
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Max_used_connections';