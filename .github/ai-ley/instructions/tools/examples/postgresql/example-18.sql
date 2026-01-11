-- Insert single record
INSERT INTO users (email, username, password_hash)
VALUES ('user@example.com', 'johndoe', '$2b$12$...')
RETURNING id, created_at;

-- Insert multiple records efficiently
INSERT INTO posts (user_id, title, content)
VALUES
    (1, 'First Post', 'Content here'),
    (1, 'Second Post', 'More content'),
    (2, 'Another Post', 'Different content')
ON CONFLICT (id) DO NOTHING;

-- Upsert (INSERT ... ON CONFLICT)
INSERT INTO users (email, username, password_hash)
VALUES ('user@example.com', 'johndoe', '$2b$12$...')
ON CONFLICT (email)
DO UPDATE SET
    username = EXCLUDED.username,
    updated_at = NOW();