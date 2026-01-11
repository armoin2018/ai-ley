-- Migration: Add user preferences table
-- Purpose: Store user-specific application preferences
-- Date: 2025-08-06
-- Author: Development Team

-- Forward migration
CREATE TABLE user_preferences (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    preference_key VARCHAR(100) NOT NULL,
    preference_value JSON NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY unique_user_preference (user_id, preference_key),
    FOREIGN KEY (user_id) REFERENCES user_accounts(id) ON DELETE CASCADE,
    INDEX idx_preference_key (preference_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add some default preferences
INSERT INTO user_preferences (user_id, preference_key, preference_value)
SELECT
    id,
    'theme',
    JSON_OBJECT('name', 'default', 'dark_mode', false)
FROM user_accounts
WHERE status = 'active';

-- Rollback migration (if needed)
-- DROP TABLE user_preferences;