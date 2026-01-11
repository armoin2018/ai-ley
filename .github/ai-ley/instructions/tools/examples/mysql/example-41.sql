-- Partitioning for large tables
CREATE TABLE user_events (
    id BIGINT UNSIGNED AUTO_INCREMENT,
    organization_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    event_data JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id, created_at),
    INDEX idx_org_user (organization_id, user_id),
    INDEX idx_event_type (event_type)
) ENGINE=InnoDB
PARTITION BY RANGE (YEAR(created_at)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Advanced indexing strategies
-- Covering index for common query patterns
CREATE INDEX idx_tasks_dashboard_covering
ON tasks (organization_id, project_id, status, assignee_id)
INCLUDE (title, priority, due_date, updated_at);

-- Functional index for JSON data
CREATE INDEX idx_user_preferences_theme
ON users ((CAST(JSON_EXTRACT(preferences, '$.theme') AS CHAR(20))));

-- Composite index for multi-column searches
CREATE INDEX idx_tasks_multi_search
ON tasks (organization_id, status, priority, assignee_id, due_date);

-- Query optimization techniques
-- Use of query hints and index hints
SELECT /*+ USE_INDEX(tasks, idx_tasks_multi_search) */
    t.id, t.title, t.status, t.priority,
    u.first_name, u.last_name
FROM tasks t
FORCE INDEX (idx_tasks_multi_search)
LEFT JOIN users u ON t.assignee_id = u.id
WHERE t.organization_id = 1
  AND t.status IN ('todo', 'in_progress')
  AND t.priority IN ('high', 'critical')
ORDER BY t.due_date ASC, t.priority DESC
LIMIT 20;

-- Optimized pagination using cursor-based approach
SELECT t.id, t.title, t.created_at
FROM tasks t
WHERE t.organization_id = 1
  AND t.id > 12345  -- cursor from previous page
ORDER BY t.id ASC
LIMIT 20;