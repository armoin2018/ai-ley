-- Transaction for related operations
START TRANSACTION;

-- Insert user account
INSERT INTO user_accounts (username, email, password_hash, first_name, last_name)
VALUES ('johndoe', 'john@example.com', '$2y$10$hash...', 'John', 'Doe');

SET @user_id = LAST_INSERT_ID();

-- Insert user profile
INSERT INTO user_profiles (user_id, title, bio)
VALUES (@user_id, 'Software Developer', 'Passionate about clean code');

-- Insert default preferences
INSERT INTO user_preferences (user_id, preference_key, preference_value)
VALUES
    (@user_id, 'theme', JSON_OBJECT('name', 'default', 'dark_mode', false)),
    (@user_id, 'notifications', JSON_OBJECT('email', true, 'push', false));

COMMIT;

-- Handle errors (in application code):
-- If any operation fails, ROLLBACK the transaction