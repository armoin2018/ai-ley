-- Create application-specific roles
CREATE ROLE app_read;
GRANT CONNECT ON DATABASE myapp TO app_read;
GRANT USAGE ON SCHEMA public TO app_read;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_read;

CREATE ROLE app_write;
GRANT app_read TO app_write;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_write;

-- Row Level Security (RLS)
CREATE POLICY user_posts_policy ON posts
    FOR ALL TO app_users
    USING (user_id = current_setting('app.current_user_id')::INTEGER);

ALTER TABLE posts ENABLE ROW LEVEL SECURITY;