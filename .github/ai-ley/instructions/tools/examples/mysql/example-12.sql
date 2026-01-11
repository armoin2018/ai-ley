-- Soft delete pattern
UPDATE users
SET is_active = 0, updated_at = CURRENT_TIMESTAMP
WHERE id = 1;

-- Hard delete with CASCADE
DELETE FROM users WHERE id = 1;
-- (Related posts and comments will be automatically deleted due to CASCADE)

-- Conditional bulk delete
DELETE FROM posts
WHERE status = 'draft'
  AND created_at < DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- Delete with subquery
DELETE p FROM posts p
JOIN users u ON p.user_id = u.id
WHERE u.is_active = 0;