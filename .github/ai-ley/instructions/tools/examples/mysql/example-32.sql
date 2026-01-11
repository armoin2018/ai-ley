-- On master: Check binary log status
SHOW MASTER STATUS;

-- On slave: Check replication status
SHOW SLAVE STATUS\G

-- Check for long-running transactions
SELECT
    id,
    user,
    host,
    db,
    command,
    time,
    state,
    info
FROM information_schema.processlist
WHERE time > 300  -- Transactions running for more than 5 minutes
ORDER BY time DESC;

-- Optimize replication performance
-- Enable parallel replication (MySQL 5.7+)
STOP SLAVE;
SET GLOBAL slave_parallel_workers = 4;
SET GLOBAL slave_parallel_type = 'LOGICAL_CLOCK';
START SLAVE;

-- Use row-based replication for better performance
SET GLOBAL binlog_format = 'ROW';