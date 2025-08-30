---
applyTo: "**/*.sql,**/migrations/*.php,**/schema/*.php,**/seeds/*.php"
---

# Database Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for database development. These include AI linting hints to automatically enforce database design principles and maintain clean, performant, and secure database code.

⸻

📂 Database Architecture

✅ Rule: Enforce normalized database design

- Follow 3NF (Third Normal Form) principles
- Use appropriate data types for columns
- Implement proper indexing strategies
- Design for scalability and performance

✅ Rule: Naming conventions

- Tables: `snake_case` with plural nouns (e.g., `user_accounts`, `order_items`)
- Columns: `snake_case` (e.g., `first_name`, `created_at`)
- Primary keys: `id` or `table_name_id`
- Foreign keys: `referenced_table_id` (e.g., `user_id`, `product_id`)

✅ Rule: Security practices

- Use parameterized queries/prepared statements
- Implement proper access controls
- Encrypt sensitive data at rest
- Use database connection pooling

✅ Rule: Performance optimization

- Create appropriate indexes
- Optimize query patterns
- Use database-specific features efficiently
- Monitor query performance

⸻

📜 SQL Standards

✅ Rule: SQL formatting

- Use uppercase for SQL keywords
- Use lowercase for table and column names
- Indent subqueries and complex statements
- Use meaningful aliases

✅ Rule: Query structure

- SELECT specific columns instead of `SELECT *`
- Use JOINs instead of subqueries when appropriate
- Implement proper WHERE clause ordering
- Use LIMIT for pagination

⸻

🖋 SQL Coding Standards

✅ Query Formatting

- Use consistent indentation and line breaks
- Align columns in SELECT statements
- Use meaningful table aliases
- Comment complex queries

✅ Example:

```sql
-- Good: Well-formatted query with comments
SELECT 
    u.id,
    u.username,
    u.email,
    p.title AS profile_title,
    COUNT(o.id) AS total_orders
FROM users u
    INNER JOIN user_profiles p ON u.id = p.user_id
    LEFT JOIN orders o ON u.id = o.user_id
WHERE 
    u.status = 'active'
    AND u.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY 
    u.id,
    u.username,
    u.email,
    p.title
HAVING COUNT(o.id) > 0
ORDER BY 
    u.created_at DESC,
    u.username ASC
LIMIT 50;
```

⸻

✅ Table Design

- Use appropriate data types
- Implement proper constraints
- Create meaningful indexes
- Design for referential integrity

✅ Example:

```sql
-- Good: Well-designed table with proper constraints
CREATE TABLE user_accounts (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    status ENUM('active', 'inactive', 'suspended') NOT NULL DEFAULT 'active',
    email_verified_at TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    UNIQUE KEY unique_username (username),
    UNIQUE KEY unique_email (email),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Foreign key table
CREATE TABLE user_profiles (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(200),
    bio TEXT,
    avatar_url VARCHAR(500),
    website_url VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
    UNIQUE KEY unique_user_profile (user_id),
    FOREIGN KEY (user_id) REFERENCES user_accounts(id) ON DELETE CASCADE,
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

⸻

✅ Migration Scripts

- Use reversible migrations
- Include rollback procedures
- Test migrations on sample data
- Document migration purpose and effects

✅ Example:

```sql
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
```

⸻

✅ Performance Optimization

- Create selective indexes
- Use query execution plans
- Optimize JOIN operations
- Implement proper pagination

❌ Bad:

```sql
-- Poor performance: No indexes, SELECT *, unnecessary subquery
SELECT * FROM users 
WHERE id IN (
    SELECT user_id FROM orders 
    WHERE created_at > '2025-01-01'
);
```

✅ Good:

```sql
-- Better performance: Specific columns, proper JOIN, indexed columns
SELECT 
    u.id,
    u.username,
    u.email,
    COUNT(o.id) AS order_count
FROM users u
    INNER JOIN orders o ON u.id = o.user_id
WHERE 
    o.created_at > '2025-01-01'
    AND u.status = 'active'
GROUP BY 
    u.id,
    u.username,
    u.email
ORDER BY order_count DESC;

-- Ensure proper indexes exist:
-- CREATE INDEX idx_orders_user_created ON orders(user_id, created_at);
-- CREATE INDEX idx_users_status ON users(status);
```

⸻

✅ Data Integrity

- Use appropriate constraints
- Implement proper validation
- Use transactions for related operations
- Handle constraint violations gracefully

✅ Example:

```sql
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
```

⸻

✅ Security Practices

- Never use dynamic SQL with user input
- Use parameterized queries/prepared statements
- Implement proper access controls
- Encrypt sensitive data

✅ Example (PHP with PDO):

```php
// Good: Parameterized query
$stmt = $pdo->prepare("
    SELECT id, username, email 
    FROM user_accounts 
    WHERE username = ? AND status = ?
");
$stmt->execute([$username, 'active']);
$user = $stmt->fetch();

// Good: Named parameters
$stmt = $pdo->prepare("
    UPDATE user_accounts 
    SET 
        email = :email,
        updated_at = NOW()
    WHERE id = :user_id AND status = 'active'
");
$stmt->execute([
    'email' => $new_email,
    'user_id' => $user_id
]);
```

⸻

✅ Stored Procedures and Functions

- Use for complex business logic
- Implement proper error handling
- Document parameters and return values
- Use consistent naming conventions

✅ Example:

```sql
-- Stored procedure for user registration
DELIMITER //

CREATE PROCEDURE RegisterUser(
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(255),
    IN p_password_hash VARCHAR(255),
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    OUT p_user_id BIGINT,
    OUT p_result_code INT,
    OUT p_result_message VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_result_code = -1;
        SET p_result_message = 'Database error occurred';
    END;
    
    -- Validate input parameters
    IF p_username IS NULL OR p_username = '' THEN
        SET p_result_code = 1;
        SET p_result_message = 'Username is required';
    ELSEIF p_email IS NULL OR p_email = '' THEN
        SET p_result_code = 2;
        SET p_result_message = 'Email is required';
    ELSE
        START TRANSACTION;
        
        -- Check if username already exists
        IF EXISTS(SELECT 1 FROM user_accounts WHERE username = p_username) THEN
            SET p_result_code = 3;
            SET p_result_message = 'Username already exists';
        ELSEIF EXISTS(SELECT 1 FROM user_accounts WHERE email = p_email) THEN
            SET p_result_code = 4;
            SET p_result_message = 'Email already exists';
        ELSE
            -- Insert new user
            INSERT INTO user_accounts (username, email, password_hash, first_name, last_name)
            VALUES (p_username, p_email, p_password_hash, p_first_name, p_last_name);
            
            SET p_user_id = LAST_INSERT_ID();
            SET p_result_code = 0;
            SET p_result_message = 'User registered successfully';
            
            COMMIT;
        END IF;
    END IF;
END //

DELIMITER ;
```

⸻

🧪 Database Testing

✅ Test Data Management

- Use realistic test data
- Implement data seeding scripts
- Create test data cleanup procedures
- Test with various data volumes

✅ Migration Testing

- Test forward and rollback migrations
- Verify data integrity after migrations
- Test on database copies, not production
- Document migration testing procedures

⸻

🚦 Database AI Enforcement Summary

✅ Enforce proper naming conventions (snake_case)
✅ Require parameterized queries over dynamic SQL
✅ Block SELECT * in production queries
✅ Enforce proper indexing strategies
✅ Require transaction usage for related operations
✅ Enforce data type appropriateness
✅ Block direct user input in SQL strings
✅ Require proper constraint definitions
✅ Enforce migration rollback procedures
✅ Auto-fix violations where possible
