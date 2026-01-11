-- Insert data
INSERT INTO users (username, email)
VALUES ('john_doe', 'john@example.com');

INSERT INTO posts (user_id, title, content)
VALUES (1, 'First Post', 'This is my first blog post.');

-- Select data with joins
SELECT
    u.username,
    p.title,
    p.created_at
FROM users u
JOIN posts p ON u.id = p.user_id
WHERE u.username = 'john_doe'
ORDER BY p.created_at DESC;

-- Update data
UPDATE posts
SET title = 'Updated Title'
WHERE id = 1;

-- Delete data
DELETE FROM posts WHERE id = 1;