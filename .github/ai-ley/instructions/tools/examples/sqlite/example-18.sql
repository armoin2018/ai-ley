-- Problem: Database file growing too large
-- Solution: Implement data archiving and maintenance

-- Check database size and page usage
PRAGMA page_count;
PRAGMA page_size;
PRAGMA freelist_count;

-- Calculate actual database size
SELECT
    page_count * page_size / 1024 / 1024 AS size_mb,
    freelist_count * page_size / 1024 / 1024 AS free_space_mb
FROM (
    SELECT
        CAST((SELECT * FROM pragma_page_count()) AS INTEGER) AS page_count,
        CAST((SELECT * FROM pragma_page_size()) AS INTEGER) AS page_size,
        CAST((SELECT * FROM pragma_freelist_count()) AS INTEGER) AS freelist_count
);

-- Archive old data to reduce size
CREATE TABLE tasks_archive AS
SELECT * FROM tasks
WHERE created_at < date('now', '-1 year')
AND status = 'completed';

DELETE FROM tasks
WHERE created_at < date('now', '-1 year')
AND status = 'completed';

-- Reclaim free space
VACUUM;

-- Enable auto-vacuum for future maintenance
PRAGMA auto_vacuum = INCREMENTAL;

-- Incremental vacuum to reclaim some space without blocking
PRAGMA incremental_vacuum(1000); -- Reclaim up to 1000 pages