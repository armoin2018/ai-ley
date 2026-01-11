-- Update single record with optimistic locking
UPDATE users
SET
    username = 'newusername',
    updated_at = NOW()
WHERE id = 1 AND updated_at = '2024-01-01 00:00:00'
RETURNING updated_at;

-- Bulk update with conditions
UPDATE posts
SET published_at = NOW()
WHERE user_id = 1 AND published_at IS NULL;

-- JSON updates
UPDATE users
SET profile_data = jsonb_set(profile_data, '{preferences,theme}', '"light"')
WHERE id = 1;