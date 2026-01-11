-- Monitor deadlocks
SHOW ENGINE INNODB STATUS\G

-- Enable deadlock logging
SET GLOBAL innodb_print_all_deadlocks = ON;