-- Update single record with timestamp
UPDATE users
SET
    first_name = 'NewFirstName',
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1;

-- Conditional update with JOIN
UPDATE posts p
JOIN users u ON p.user_id = u.id
SET p.status = 'published'
WHERE u.is_active = 1
  AND p.status = 'draft'
  AND p.created_at < DATE_SUB(NOW(), INTERVAL 1 DAY);

-- JSON updates (MySQL 5.7+)
UPDATE users
SET profile_data = JSON_SET(
    COALESCE(profile_data, JSON_OBJECT()),
    '$.theme', 'light',
    '$.last_login', NOW()
)
WHERE id = 1;

-- Increment counters atomically
UPDATE posts
SET view_count = view_count + 1
WHERE id = 1;