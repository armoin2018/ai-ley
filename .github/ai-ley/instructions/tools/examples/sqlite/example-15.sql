-- Enable query planning analysis
EXPLAIN QUERY PLAN SELECT * FROM tasks WHERE status = 'pending' AND due_date < date('now');

-- Check index usage
.expert
EXPLAIN QUERY PLAN SELECT * FROM tasks WHERE user_id = 123 AND status = 'pending';

-- Analyze table statistics
ANALYZE;
SELECT name, tbl_name, sql FROM sqlite_master WHERE type = 'index';

-- Check database integrity
PRAGMA integrity_check;
PRAGMA foreign_key_check;

-- Monitor query performance
.timer on
.stats on
SELECT COUNT(*) FROM large_table WHERE indexed_column = 'value';