-- Soft delete pattern
UPDATE users
SET is_active = false, updated_at = NOW()
WHERE id = 1;

-- Hard delete with cascade
DELETE FROM users WHERE id = 1;
-- (Posts will be automatically deleted due to ON DELETE CASCADE)

-- Conditional delete
DELETE FROM posts
WHERE created_at < NOW() - INTERVAL '1 year'
  AND published_at IS NULL;