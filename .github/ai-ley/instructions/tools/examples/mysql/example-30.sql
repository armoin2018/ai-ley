-- Check current memory settings
SHOW VARIABLES LIKE '%buffer%';
SHOW VARIABLES LIKE '%cache%';
SHOW VARIABLES LIKE '%memory%';

-- Monitor buffer pool usage
SELECT
    ROUND((
        SELECT SUM(data_length + index_length)
        FROM information_schema.tables
    ) / 1024 / 1024 / 1024, 2) as total_data_gb,
    @@innodb_buffer_pool_size / 1024 / 1024 / 1024 as buffer_pool_gb,
    ROUND((
        @@innodb_buffer_pool_size /
        (SELECT SUM(data_length + index_length) FROM information_schema.tables)
    ) * 100, 2) as buffer_pool_coverage_percent;