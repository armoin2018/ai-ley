# SQLite Database Instructions

## Tool Overview
- **Tool Name**: SQLite
- **Version**: 3.40+ (Latest stable)
- **Category**: Embedded Database System
- **Purpose**: Lightweight, serverless, self-contained SQL database engine
- **Prerequisites**: Minimal - SQLite is often included by default in most systems

## Installation & Setup

### Package Manager Installation
```bash
# Ubuntu/Debian
sudo apt-get install sqlite3

# macOS (via Homebrew)
brew install sqlite

# Windows (via chocolatey)
choco install sqlite

# Python integration
pip install sqlite3  # Usually included with Python
```

### Project Integration
```bash
# Create new database
sqlite3 database_name.db

# Import SQL script
sqlite3 database_name.db < schema.sql

# Backup database
sqlite3 database_name.db .dump > backup.sql
```

## Configuration

### Database Configuration
```sql
-- Enable foreign key constraints
PRAGMA foreign_keys = ON;

-- Set journal mode for better concurrency
PRAGMA journal_mode = WAL;

-- Optimize performance
PRAGMA synchronous = NORMAL;
PRAGMA cache_size = 10000;
PRAGMA temp_store = memory;

-- Enable query planner analysis
PRAGMA optimize;
```

### Connection String Configuration
```python
# Python sqlite3 configuration
import sqlite3

connection = sqlite3.connect(
    'database.db',
    check_same_thread=False,  # Allow multi-threading
    timeout=20.0,  # Connection timeout
    isolation_level=None  # Autocommit mode
)

# Enable foreign keys
connection.execute("PRAGMA foreign_keys = ON")
```

## Core Features

### Database Creation and Schema Design
- **Purpose**: Design and implement database schema
- **Usage**: Create tables, indexes, and relationships
- **Example**:
```sql
-- Create tables with relationships
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create indexes for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_created_at ON posts(created_at);
```

### CRUD Operations
- **Purpose**: Perform standard database operations
- **Usage**: Insert, select, update, and delete data
- **Example**:
```sql
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
```

## Common Commands
```bash
# Essential daily commands
sqlite3 database.db                     # Open database
.tables                                 # List all tables
.schema table_name                      # Show table schema
.dump                                   # Export database
.read script.sql                        # Execute SQL script

# Advanced operations
.backup backup.db                       # Create backup
.restore backup.db                      # Restore from backup
.mode csv                              # Set output mode
.output file.csv                       # Redirect output
.import file.csv table_name            # Import CSV data
```

## Best Practices

### Performance Optimization
- Use indexes on frequently queried columns
- Implement connection pooling for multi-threaded applications
- Use prepared statements to prevent SQL injection
- Enable WAL mode for better concurrency

### Security Considerations
- Always use parameterized queries to prevent SQL injection
- Set appropriate file permissions on database files
- Implement proper error handling and transactions
- Regular database backups and integrity checks

## Common Use Cases

### Use Case 1: Application Database
**Scenario**: Local database for desktop or mobile application
**Implementation**:
```python
import sqlite3
from contextlib import contextmanager

class DatabaseManager:
    def __init__(self, db_path):
        self.db_path = db_path
        self.init_database()
    
    def init_database(self):
        """Initialize database with schema"""
        with self.get_connection() as conn:
            conn.execute("""
                CREATE TABLE IF NOT EXISTS users (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    username TEXT UNIQUE NOT NULL,
                    email TEXT UNIQUE NOT NULL,
                    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
                )
            """)
            conn.execute("PRAGMA foreign_keys = ON")
    
    @contextmanager
    def get_connection(self):
        """Context manager for database connections"""
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        try:
            yield conn
            conn.commit()
        except Exception:
            conn.rollback()
            raise
        finally:
            conn.close()
    
    def create_user(self, username, email):
        """Create new user"""
        with self.get_connection() as conn:
            cursor = conn.execute(
                "INSERT INTO users (username, email) VALUES (?, ?)",
                (username, email)
            )
            return cursor.lastrowid
```

## Troubleshooting

### Common Issues
#### Issue 1: Database Locked Error
**Problem**: Database is locked by another process
**Solution**: Implement retry logic and proper connection handling

#### Issue 2: Performance Issues
**Problem**: Slow query performance
**Solution**: Create appropriate indexes and optimize queries

## AI Assistant Guidelines
When helping with SQLite implementation:

1. **Always recommend parameterized queries** to prevent SQL injection
2. **Suggest appropriate indexes** for query optimization
3. **Include proper error handling** for database operations
4. **Recommend transaction usage** for data consistency
5. **Suggest connection management** best practices
6. **Include backup and recovery** procedures
7. **Emphasize testing** with in-memory databases
8. **Provide performance optimization** guidance

### Code Generation Rules
- Generate safe, parameterized SQL queries
- Include proper error handling and transaction management
- Follow SQLite-specific syntax and features
- Implement connection management best practices
- Include data validation and integrity checks
- Provide comprehensive database design examples