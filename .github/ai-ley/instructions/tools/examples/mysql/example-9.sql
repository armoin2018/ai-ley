-- Insert single record
INSERT INTO users (email, username, password_hash, first_name, last_name)
VALUES ('user@example.com', 'johndoe', '$2b$12$...', 'John', 'Doe');

-- Insert multiple records efficiently
INSERT INTO posts (user_id, title, content, status)
VALUES
    (1, 'First Post', 'Content here', 'published'),
    (1, 'Second Post', 'More content', 'draft'),
    (2, 'Another Post', 'Different content', 'published')
ON DUPLICATE KEY UPDATE
    updated_at = CURRENT_TIMESTAMP;

-- Insert with JSON data
INSERT INTO users (email, username, password_hash, first_name, last_name, profile_data)
VALUES (
    'user2@example.com',
    'janedoe',
    '$2b$12$...',
    'Jane',
    'Doe',
    JSON_OBJECT('theme', 'dark', 'notifications', true, 'language', 'en')
);