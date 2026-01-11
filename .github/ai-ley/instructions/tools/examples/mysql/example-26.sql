-- Check replication status
SHOW SLAVE STATUS\G

-- Skip replication error (use with caution)
STOP SLAVE;
SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1;
START SLAVE;