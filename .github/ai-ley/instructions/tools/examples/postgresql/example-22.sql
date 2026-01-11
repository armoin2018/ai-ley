-- Compound index for common query patterns
CREATE INDEX idx_posts_user_published ON posts(user_id, published_at DESC)
WHERE published_at IS NOT NULL;

-- Partial index for active users
CREATE INDEX idx_users_active_email ON users(email) WHERE is_active = true;

-- Expression index
CREATE INDEX idx_users_lower_email ON users(LOWER(email));

-- Covering index (INCLUDE clause)
CREATE INDEX idx_users_id_covering ON users(id) INCLUDE (email, username, created_at);