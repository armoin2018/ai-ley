# MySQL Database Instructions

## Database Overview
- **Database System**: MySQL
- **Version**: 8.0+ (Current stable version)
- **Type**: Relational Database Management System (RDBMS)
- **License**: GPL v2 (Open Source) / Commercial License
- **Use Cases**: Web applications, E-commerce, Data warehousing, Logging systems

## Installation & Setup
### Local Installation
```bash
# Package manager installation
# Ubuntu/Debian
sudo apt update && sudo apt install mysql-server

# macOS
brew install mysql

# Start MySQL service
sudo systemctl start mysql

# Secure installation
sudo mysql_secure_installation

# Docker installation
docker run -d --name mysql \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=myapp \
  -e MYSQL_USER=appuser \
  -e MYSQL_PASSWORD=apppassword \
  -v mysql_data:/var/lib/mysql \
  mysql:8.0

# Cloud service setup
# AWS RDS
aws rds create-db-instance --db-instance-identifier mydb \
  --db-instance-class db.t3.micro --engine mysql \
  --master-username admin --master-user-password password
```

### Configuration
```ini
# /etc/mysql/mysql.conf.d/mysqld.cnf - Main configuration file
[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
log-error       = /var/log/mysql/error.log
port            = 3306
bind-address    = 127.0.0.1

# Performance tuning
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
max_connections = 151
query_cache_size = 64M

# Security settings
local_infile = 0
sql_mode = STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION

# Logging
general_log = 1
general_log_file = /var/log/mysql/general.log
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2
```

## Core Concepts
### Databases and Tables
- **Purpose**: Organize data into structured collections with defined schemas
- **Usage**: Create databases for applications, tables for entities
- **Best Practices**: Use appropriate data types, normalize for OLTP systems

### Indexes
- **Purpose**: Accelerate query performance through efficient data access paths
- **Usage**: Create on primary keys, foreign keys, and frequently queried columns
- **Best Practices**: Monitor index usage, avoid over-indexing, use composite indexes

### Storage Engines
- **Purpose**: Determine how data is stored and accessed
- **Usage**: InnoDB for transactions, MyISAM for read-heavy workloads
- **Best Practices**: Use InnoDB as default, choose engine based on requirements

## Connection and Authentication
### Connection Methods
```sql
-- MySQL command line
mysql -h localhost -P 3306 -u username -p database_name

-- Connection string format
mysql://username:password@localhost:3306/database_name
```

```javascript
// Node.js with mysql2
const mysql = require('mysql2/promise');

// Connection configuration
const connection = await mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'appuser',
  password: 'apppassword',
  database: 'myapp',
  ssl: {
    rejectUnauthorized: false
  },
  timezone: 'Z'
});

// Connection pooling
const pool = mysql.createPool({
  host: 'localhost',
  port: 3306,
  user: 'appuser',
  password: 'apppassword',
  database: 'myapp',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});
```

```python
# Python with PyMySQL
import pymysql.cursors
from pymysql import Connection

# Connection with proper error handling
try:
    connection = pymysql.connect(
        host='localhost',
        port=3306,
        user='appuser',
        password='apppassword',
        database='myapp',
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=False
    )
    print("Connected to MySQL successfully")
except pymysql.Error as e:
    print(f"Error connecting to MySQL: {e}")
```

### Authentication & Security
```sql
-- Create application user with limited privileges
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON myapp.* TO 'app_user'@'localhost';
FLUSH PRIVILEGES;

-- Create read-only user
CREATE USER 'readonly_user'@'%' IDENTIFIED BY 'readonly_password';
GRANT SELECT ON myapp.* TO 'readonly_user'@'%';
FLUSH PRIVILEGES;

-- Enable SSL (in my.cnf)
-- ssl-ca=/path/to/ca.pem
-- ssl-cert=/path/to/server-cert.pem
-- ssl-key=/path/to/server-key.pem

-- Password validation
INSTALL COMPONENT 'file://component_validate_password';
SET GLOBAL validate_password.policy = MEDIUM;
```

## Data Modeling
### Schema Design Best Practices
- **Normalization**: Follow 3NF for OLTP systems to reduce redundancy
- **Data Types**: Choose appropriate types (INT vs BIGINT, VARCHAR vs TEXT)
- **Constraints**: Implement proper foreign keys, check constraints, and unique constraints
- **Character Sets**: Use utf8mb4 for full Unicode support

### Example Schema
```sql
-- Users table with proper constraints and indexes
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    profile_data JSON DEFAULT NULL,
    INDEX idx_email (email),
    INDEX idx_username (username),
    INDEX idx_active_created (is_active, created_at),
    INDEX idx_name (first_name, last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Posts table with foreign key relationship
CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    slug VARCHAR(255) UNIQUE,
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    published_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    view_count INT DEFAULT 0,
    tags JSON DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status_published (status, published_at),
    INDEX idx_slug (slug),
    FULLTEXT idx_title_content (title, content)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comments table with hierarchical structure
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    parent_id INT DEFAULT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_approved BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE,
    INDEX idx_post_id (post_id),
    INDEX idx_user_id (user_id),
    INDEX idx_parent_id (parent_id),
    INDEX idx_approved_created (is_approved, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

## CRUD Operations
### Create Operations
```sql
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
```

### Read Operations
```sql
-- Simple select with optimization
SELECT id, email, username, first_name, last_name, created_at 
FROM users 
WHERE is_active = 1 
ORDER BY created_at DESC
LIMIT 50;

-- Complex query with joins and aggregation
SELECT 
    u.username,
    u.email,
    COUNT(p.id) as post_count,
    MAX(p.published_at) as last_post_date,
    AVG(p.view_count) as avg_views
FROM users u
LEFT JOIN posts p ON u.id = p.user_id AND p.status = 'published'
WHERE u.is_active = 1
GROUP BY u.id, u.username, u.email
HAVING post_count > 0
ORDER BY post_count DESC, last_post_date DESC;

-- JSON queries (MySQL 5.7+)
SELECT username, 
       JSON_EXTRACT(profile_data, '$.theme') as theme,
       JSON_EXTRACT(profile_data, '$.language') as language
FROM users 
WHERE JSON_EXTRACT(profile_data, '$.notifications') = true;

-- Full-text search
SELECT title, content, 
       MATCH(title, content) AGAINST('search terms' IN NATURAL LANGUAGE MODE) as relevance_score
FROM posts
WHERE MATCH(title, content) AGAINST('search terms' IN NATURAL LANGUAGE MODE)
  AND status = 'published'
ORDER BY relevance_score DESC;

-- Common Table Expression (MySQL 8.0+)
WITH RECURSIVE comment_tree AS (
    -- Base case: top-level comments
    SELECT id, post_id, user_id, parent_id, content, created_at, 0 as level
    FROM comments 
    WHERE parent_id IS NULL AND post_id = 1
    
    UNION ALL
    
    -- Recursive case: child comments
    SELECT c.id, c.post_id, c.user_id, c.parent_id, c.content, c.created_at, ct.level + 1
    FROM comments c
    INNER JOIN comment_tree ct ON c.parent_id = ct.id
    WHERE ct.level < 5  -- Limit recursion depth
)
SELECT * FROM comment_tree ORDER BY level, created_at;
```

### Update Operations
```sql
-- Update single record with timestamp
UPDATE users 
SET 
    first_name = 'NewFirstName',
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1;

-- Conditional update with JOIN
UPDATE posts p
JOIN users u ON p.user_id = u.id
SET p.status = 'published'
WHERE u.is_active = 1 
  AND p.status = 'draft'
  AND p.created_at < DATE_SUB(NOW(), INTERVAL 1 DAY);

-- JSON updates (MySQL 5.7+)
UPDATE users 
SET profile_data = JSON_SET(
    COALESCE(profile_data, JSON_OBJECT()),
    '$.theme', 'light',
    '$.last_login', NOW()
)
WHERE id = 1;

-- Increment counters atomically
UPDATE posts 
SET view_count = view_count + 1
WHERE id = 1;
```

### Delete Operations
```sql
-- Soft delete pattern
UPDATE users 
SET is_active = 0, updated_at = CURRENT_TIMESTAMP
WHERE id = 1;

-- Hard delete with CASCADE
DELETE FROM users WHERE id = 1;
-- (Related posts and comments will be automatically deleted due to CASCADE)

-- Conditional bulk delete
DELETE FROM posts 
WHERE status = 'draft'
  AND created_at < DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- Delete with subquery
DELETE p FROM posts p
JOIN users u ON p.user_id = u.id
WHERE u.is_active = 0;
```

## Performance Optimization
### Indexing Strategies
```sql
-- Primary key (automatically created)
-- Already defined in table creation

-- Composite index for common query patterns
CREATE INDEX idx_user_status_date ON posts(user_id, status, created_at);

-- Partial index (functional index in MySQL 8.0+)
CREATE INDEX idx_active_users ON users((CASE WHEN is_active = 1 THEN id END));

-- Covering index to avoid key lookups
CREATE INDEX idx_post_list_covering ON posts(status, published_at, id, title, user_id);

-- Analyze index usage
SHOW INDEX FROM posts;
EXPLAIN SELECT * FROM posts WHERE user_id = 1 AND status = 'published';
```

### Query Optimization
```sql
-- Use EXPLAIN to understand query execution
EXPLAIN FORMAT=JSON 
SELECT p.*, u.username 
FROM posts p 
JOIN users u ON p.user_id = u.id 
WHERE p.status = 'published' 
AND p.created_at > DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY p.created_at DESC
LIMIT 20;

-- Optimize pagination with cursor-based approach
SELECT * FROM posts 
WHERE status = 'published'
  AND id > 12345  -- cursor from previous page
ORDER BY id
LIMIT 20;

-- Avoid SELECT * in production queries
SELECT id, title, created_at, user_id
FROM posts 
WHERE status = 'published'
ORDER BY created_at DESC
LIMIT 20;

-- Use EXISTS instead of IN for better performance
SELECT * FROM users u
WHERE EXISTS (
    SELECT 1 FROM posts p 
    WHERE p.user_id = u.id 
    AND p.status = 'published'
    AND p.created_at > DATE_SUB(NOW(), INTERVAL 30 DAY)
);
```

### Monitoring & Profiling
```sql
-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 2;

-- Monitor performance schema
SELECT 
    schema_name,
    digest_text,
    count_star,
    avg_timer_wait/1000000000000 as avg_time_seconds,
    max_timer_wait/1000000000000 as max_time_seconds
FROM performance_schema.events_statements_summary_by_digest 
ORDER BY avg_timer_wait DESC 
LIMIT 10;

-- Check index usage
SELECT 
    object_schema,
    object_name,
    index_name,
    count_read,
    count_write,
    count_fetch,
    count_insert,
    count_update,
    count_delete
FROM performance_schema.table_io_waits_summary_by_index_usage 
WHERE object_schema = 'myapp'
ORDER BY count_read DESC;

-- Connection and thread monitoring
SHOW PROCESSLIST;
SHOW STATUS LIKE 'Threads%';
SHOW STATUS LIKE 'Connections';
```

## Backup and Recovery
### Backup Strategies
```bash
# Full backup with mysqldump
mysqldump -h localhost -u backup_user -p \
  --single-transaction \
  --routines \
  --triggers \
  --all-databases > full_backup.sql

# Database-specific backup
mysqldump -h localhost -u backup_user -p \
  --single-transaction \
  --routines \
  --triggers \
  myapp > myapp_backup.sql

# Compressed backup
mysqldump -h localhost -u backup_user -p \
  --single-transaction \
  myapp | gzip > myapp_backup.sql.gz

# Binary log backup for point-in-time recovery
mysqlbinlog --start-datetime="2024-01-01 00:00:00" \
  --stop-datetime="2024-01-01 23:59:59" \
  /var/log/mysql/mysql-bin.000001 > binlog_backup.sql

# Physical backup with MySQL Enterprise Backup (commercial)
mysqlbackup --backup-dir=/backup/full \
  --with-timestamp \
  backup-and-apply-log
```

### Recovery Procedures
```bash
# Full restore from mysqldump
mysql -h localhost -u root -p < full_backup.sql

# Database-specific restore
mysql -h localhost -u root -p myapp < myapp_backup.sql

# Point-in-time recovery
# 1. Restore from full backup
mysql -h localhost -u root -p < full_backup.sql

# 2. Apply binary logs up to specific point
mysql -h localhost -u root -p < binlog_backup.sql

# Selective table restore
mysqldump -h localhost -u backup_user -p \
  --single-transaction \
  myapp users | mysql -h localhost -u root -p myapp
```

## Scaling and High Availability
### Replication Setup
```sql
-- Master configuration (my.cnf)
-- [mysqld]
-- server-id = 1
-- log-bin = mysql-bin
-- binlog-format = ROW

-- Create replication user on master
CREATE USER 'replicator'@'%' IDENTIFIED BY 'replication_password';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
FLUSH PRIVILEGES;

-- Get master status
SHOW MASTER STATUS;

-- Slave configuration (my.cnf)
-- [mysqld]
-- server-id = 2
-- read-only = 1
-- relay-log = relay-bin

-- Configure slave
CHANGE MASTER TO
    MASTER_HOST='master_host',
    MASTER_USER='replicator',
    MASTER_PASSWORD='replication_password',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=154;

-- Start replication
START SLAVE;

-- Check replication status
SHOW SLAVE STATUS\G
```

### Load Balancing and Clustering
```javascript
// Application-level read/write splitting
const masterPool = mysql.createPool({
  host: 'master.database.com',
  user: 'app_user',
  password: 'password',
  database: 'myapp',
  connectionLimit: 20
});

const slavePool = mysql.createPool({
  host: 'slave.database.com',
  user: 'readonly_user',
  password: 'password',
  database: 'myapp',
  connectionLimit: 10
});

// Route reads to slave, writes to master
class DatabaseManager {
  async read(query, params) {
    return slavePool.execute(query, params);
  }
  
  async write(query, params) {
    return masterPool.execute(query, params);
  }
}
```

## Security Best Practices
### Access Control
```sql
-- Principle of least privilege
CREATE USER 'app_read'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT ON myapp.* TO 'app_read'@'localhost';

CREATE USER 'app_write'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON myapp.* TO 'app_write'@'localhost';

-- Revoke dangerous privileges
REVOKE FILE, PROCESS, SUPER ON *.* FROM 'app_user'@'localhost';

-- Regular security audit
SELECT user, host, account_locked, password_expired 
FROM mysql.user;

-- Remove unused accounts
DROP USER 'unused_user'@'localhost';
```

### Data Encryption
```sql
-- Enable encryption at rest (MySQL 8.0+)
-- In my.cnf:
-- early-plugin-load=keyring_file.so
-- keyring_file_data=/var/lib/mysql-keyring/keyring

-- Create encrypted table
CREATE TABLE sensitive_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ssn VARBINARY(255),
    credit_card_hash VARCHAR(64),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENCRYPTION='Y';

-- Application-level encryption functions
SELECT AES_ENCRYPT('sensitive_data', 'encryption_key') as encrypted;
SELECT AES_DECRYPT(encrypted_column, 'encryption_key') as decrypted 
FROM sensitive_data;
```

## Integration Patterns
### Application Integration
```javascript
// Node.js repository pattern with connection pooling
const mysql = require('mysql2/promise');

class DatabaseConnection {
  constructor() {
    this.pool = mysql.createPool({
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
      acquireTimeout: 60000,
      timeout: 60000,
      reconnect: true
    });
  }

  async query(sql, params) {
    try {
      const [rows] = await this.pool.execute(sql, params);
      return rows;
    } catch (error) {
      console.error('Database query error:', error);
      throw error;
    }
  }

  async transaction(callback) {
    const connection = await this.pool.getConnection();
    await connection.beginTransaction();
    
    try {
      const result = await callback(connection);
      await connection.commit();
      return result;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

class UserRepository {
  constructor(db) {
    this.db = db;
  }

  async findById(id) {
    const sql = `
      SELECT id, email, username, first_name, last_name, created_at 
      FROM users 
      WHERE id = ? AND is_active = 1
    `;
    const users = await this.db.query(sql, [id]);
    return users[0] || null;
  }

  async create(userData) {
    const sql = `
      INSERT INTO users (email, username, password_hash, first_name, last_name)
      VALUES (?, ?, ?, ?, ?)
    `;
    
    return this.db.transaction(async (connection) => {
      const [result] = await connection.execute(sql, [
        userData.email,
        userData.username,
        userData.passwordHash,
        userData.firstName,
        userData.lastName
      ]);
      
      return { id: result.insertId, ...userData };
    });
  }

  async findWithPosts(userId, limit = 10, offset = 0) {
    const sql = `
      SELECT 
        u.id, u.username, u.first_name, u.last_name,
        p.id as post_id, p.title, p.content, p.created_at as post_created_at
      FROM users u
      LEFT JOIN posts p ON u.id = p.user_id AND p.status = 'published'
      WHERE u.id = ? AND u.is_active = 1
      ORDER BY p.created_at DESC
      LIMIT ? OFFSET ?
    `;
    
    const rows = await this.db.query(sql, [userId, limit, offset]);
    
    if (rows.length === 0) return null;
    
    // Transform flat result into nested structure
    const user = {
      id: rows[0].id,
      username: rows[0].username,
      firstName: rows[0].first_name,
      lastName: rows[0].last_name,
      posts: []
    };
    
    for (const row of rows) {
      if (row.post_id) {
        user.posts.push({
          id: row.post_id,
          title: row.title,
          content: row.content,
          createdAt: row.post_created_at
        });
      }
    }
    
    return user;
  }
}
```

```python
# Python integration with PyMySQL
import pymysql
from contextlib import contextmanager
from typing import Optional, List, Dict, Any

class DatabaseManager:
    def __init__(self, config: Dict[str, Any]):
        self.config = config
        self.pool = self._create_pool()
    
    def _create_pool(self):
        return pymysql.connect(
            host=self.config['host'],
            port=self.config['port'],
            user=self.config['user'],
            password=self.config['password'],
            database=self.config['database'],
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=True
        )
    
    @contextmanager
    def get_cursor(self, commit=True):
        cursor = self.pool.cursor()
        try:
            yield cursor
            if commit:
                self.pool.commit()
        except Exception as e:
            self.pool.rollback()
            raise
        finally:
            cursor.close()
    
    def execute_query(self, sql: str, params: tuple = None) -> List[Dict[str, Any]]:
        with self.get_cursor() as cursor:
            cursor.execute(sql, params)
            return cursor.fetchall()
    
    def execute_single(self, sql: str, params: tuple = None) -> Optional[Dict[str, Any]]:
        results = self.execute_query(sql, params)
        return results[0] if results else None

class UserService:
    def __init__(self, db: DatabaseManager):
        self.db = db
    
    def get_user_by_id(self, user_id: int) -> Optional[Dict[str, Any]]:
        sql = """
            SELECT id, email, username, first_name, last_name, created_at 
            FROM users 
            WHERE id = %s AND is_active = 1
        """
        return self.db.execute_single(sql, (user_id,))
    
    def create_user(self, user_data: Dict[str, Any]) -> Dict[str, Any]:
        sql = """
            INSERT INTO users (email, username, password_hash, first_name, last_name)
            VALUES (%(email)s, %(username)s, %(password_hash)s, %(first_name)s, %(last_name)s)
        """
        
        with self.db.get_cursor() as cursor:
            cursor.execute(sql, user_data)
            user_id = cursor.lastrowid
            
            return self.get_user_by_id(user_id)
    
    def search_users(self, search_term: str, limit: int = 20) -> List[Dict[str, Any]]:
        sql = """
            SELECT id, username, first_name, last_name, email
            FROM users 
            WHERE (first_name LIKE %s OR last_name LIKE %s OR username LIKE %s)
              AND is_active = 1
            ORDER BY username
            LIMIT %s
        """
        search_pattern = f"%{search_term}%"
        return self.db.execute_query(sql, (search_pattern, search_pattern, search_pattern, limit))
```

## Monitoring and Alerting
### Key Metrics
- **Performance Metrics**: Query response time, queries per second, connection count
- **Resource Metrics**: CPU usage, memory usage, disk I/O, disk space
- **Database Metrics**: Slow queries, lock waits, replication lag, table size

### Monitoring Setup
```sql
-- Enable Performance Schema
UPDATE performance_schema.setup_instruments 
SET ENABLED = 'YES', TIMED = 'YES' 
WHERE NAME LIKE '%statement%';

-- Monitor slow queries
SELECT 
    schema_name,
    LEFT(digest_text, 64) as query_preview,
    count_star as exec_count,
    avg_timer_wait/1000000000000 as avg_time_sec,
    sum_rows_examined/count_star as avg_rows_examined
FROM performance_schema.events_statements_summary_by_digest 
WHERE avg_timer_wait/1000000000000 > 1
ORDER BY avg_timer_wait DESC 
LIMIT 10;

-- Monitor table sizes
SELECT 
    table_schema as 'Database',
    table_name as 'Table',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) as 'Size (MB)',
    table_rows as 'Rows'
FROM information_schema.tables 
WHERE table_schema = 'myapp'
ORDER BY (data_length + index_length) DESC;

-- Monitor replication lag
SHOW SLAVE STATUS\G
```

### Common Issues & Troubleshooting
#### Performance Issues
**Issue**: Slow query performance
**Solution**: 
- Use EXPLAIN to identify missing indexes
- Optimize WHERE clauses and JOIN conditions
- Consider query rewriting or schema changes
- Monitor and tune MySQL configuration parameters

**Issue**: High connection count
**Solution**:
- Implement connection pooling in applications
- Increase max_connections if hardware allows
- Monitor for connection leaks in applications
- Use persistent connections appropriately

#### Deadlock Issues
**Issue**: Deadlocks between transactions
**Solution**:
- Keep transactions short and focused
- Access tables in consistent order
- Use appropriate isolation levels
- Monitor deadlock logs and implement retry logic

```sql
-- Monitor deadlocks
SHOW ENGINE INNODB STATUS\G

-- Enable deadlock logging
SET GLOBAL innodb_print_all_deadlocks = ON;
```

#### Replication Issues
**Issue**: Replication lag or failure
**Solution**:
- Monitor replication status regularly
- Optimize network between master and slaves
- Use parallel replication (MySQL 5.7+)
- Consider read-only slaves for reporting

```sql
-- Check replication status
SHOW SLAVE STATUS\G

-- Skip replication error (use with caution)
STOP SLAVE;
SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1;
START SLAVE;
```

## AI Assistant Guidelines
When helping with MySQL:

1. **Always use parameterized queries to prevent SQL injection**
2. **Include proper error handling and connection management**
3. **Suggest appropriate indexing strategies for query patterns**
4. **Include transaction management for data consistency**
5. **Recommend connection pooling for production applications**
6. **Provide both raw SQL and ORM examples where applicable**
7. **Include monitoring and performance optimization guidance**
8. **Consider MySQL version-specific features and compatibility**

### Code Generation Rules
- Generate queries that are optimized for MySQL's query optimizer
- Include proper error handling and connection cleanup
- Use prepared statements for all dynamic queries
- Include comments explaining complex queries and performance considerations
- Provide both procedural and ORM-based examples as appropriate
- Consider MySQL-specific features when beneficial (JSON columns, window functions, CTEs)
- Include index recommendations for frequently queried columns
- Use appropriate data types for MySQL (utf8mb4 for Unicode, proper numeric types)
- Include transaction boundaries for multi-statement operations
- Implement proper connection pooling and resource management