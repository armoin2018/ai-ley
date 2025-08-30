# PostgreSQL Database Instructions

## Database Overview
- **Database System**: PostgreSQL
- **Version**: 16+ (Current stable version)
- **Type**: Relational Database Management System (RDBMS)
- **License**: Open Source (PostgreSQL License)
- **Use Cases**: OLTP, OLAP, Analytics, JSON/NoSQL workloads, Time-series data

## Installation & Setup
### Local Installation
```bash
# Package manager installation
# Ubuntu/Debian
sudo apt update && sudo apt install postgresql postgresql-contrib

# macOS
brew install postgresql

# Docker installation
docker run -d --name postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=mypassword \
  -e POSTGRES_DB=myapp \
  postgres:16

# Cloud service setup
# AWS RDS
aws rds create-db-instance --db-instance-identifier mydb \
  --db-instance-class db.t3.micro --engine postgres
```

### Configuration
```ini
# postgresql.conf - Main configuration file
max_connections = 100
shared_buffers = 256MB
effective_cache_size = 1GB
wal_buffers = 16MB
checkpoint_completion_target = 0.7
default_statistics_target = 100

# Enable logging
logging_collector = on
log_directory = 'log'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_statement = 'all'
log_duration = on
```

## Core Concepts
### Schemas and Tables
- **Purpose**: Organize database objects and provide namespace isolation
- **Usage**: Create logical groupings of tables and other objects
- **Best Practices**: Use schemas for multi-tenant applications, separate environments

### Indexes
- **Purpose**: Accelerate query performance through efficient data access paths
- **Usage**: Create on frequently queried columns, foreign keys, and WHERE clauses
- **Best Practices**: Monitor index usage, avoid over-indexing, use partial indexes

### Transactions and ACID
- **Purpose**: Ensure data consistency and reliability through ACID properties
- **Usage**: Wrap related operations in transactions, handle deadlocks
- **Best Practices**: Keep transactions short, use appropriate isolation levels

## Connection and Authentication
### Connection Methods
```sql
-- psql command line
psql -h localhost -p 5432 -U username -d database_name

-- Connection string format
postgresql://username:password@localhost:5432/database_name
```

```python
# Python with psycopg2
import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="myapp",
    user="username",
    password="password",
    port=5432
)

# Connection pooling with psycopg2
from psycopg2 import pool

connection_pool = psycopg2.pool.ThreadedConnectionPool(
    minconn=1,
    maxconn=20,
    host="localhost",
    database="myapp",
    user="username",
    password="password"
)
```

### Authentication & Security
```sql
-- Create user with specific privileges
CREATE USER app_user WITH PASSWORD 'secure_password';
GRANT CONNECT ON DATABASE myapp TO app_user;
GRANT USAGE ON SCHEMA public TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;

-- Enable SSL connection (postgresql.conf)
ssl = on
ssl_cert_file = 'server.crt'
ssl_key_file = 'server.key'

-- Role-based access control
CREATE ROLE readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
GRANT readonly TO app_user;
```

## Data Modeling
### Schema Design Best Practices
- **Normalization**: Follow 3NF for OLTP systems, consider denormalization for analytics
- **Data Types**: Use appropriate types (TEXT vs VARCHAR, TIMESTAMP vs DATE)
- **Constraints**: Implement proper foreign keys, check constraints, and unique constraints

### Example Schema
```sql
-- Users table with proper constraints
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_active BOOLEAN DEFAULT true,
    profile_data JSONB DEFAULT '{}'
);

-- Posts table with foreign key relationship
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    published_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    tags TEXT[] DEFAULT '{}',
    metadata JSONB DEFAULT '{}'
);

-- Indexes for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_published_at ON posts(published_at) WHERE published_at IS NOT NULL;
CREATE INDEX idx_posts_tags ON posts USING GIN(tags);
CREATE INDEX idx_posts_metadata ON posts USING GIN(metadata);
```

## CRUD Operations
### Create Operations
```sql
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
```

### Read Operations
```sql
-- Simple select with optimization
SELECT id, email, username, created_at 
FROM users 
WHERE is_active = true 
ORDER BY created_at DESC
LIMIT 50;

-- Complex query with joins and aggregation
SELECT 
    u.username,
    u.email,
    COUNT(p.id) as post_count,
    MAX(p.published_at) as last_post_date
FROM users u
LEFT JOIN posts p ON u.id = p.user_id AND p.published_at IS NOT NULL
WHERE u.is_active = true
GROUP BY u.id, u.username, u.email
HAVING COUNT(p.id) > 0
ORDER BY post_count DESC, last_post_date DESC;

-- JSON/JSONB queries
SELECT username, profile_data->>'location' as location
FROM users 
WHERE profile_data->'preferences'->>'theme' = 'dark';

-- Full-text search
SELECT title, content, ts_rank(to_tsvector('english', title || ' ' || content), query) as rank
FROM posts, plainto_tsquery('english', 'search terms') query
WHERE to_tsvector('english', title || ' ' || content) @@ query
ORDER BY rank DESC;
```

### Update Operations
```sql
-- Update single record with optimistic locking
UPDATE users 
SET 
    username = 'newusername',
    updated_at = NOW()
WHERE id = 1 AND updated_at = '2024-01-01 00:00:00'
RETURNING updated_at;

-- Bulk update with conditions
UPDATE posts 
SET published_at = NOW()
WHERE user_id = 1 AND published_at IS NULL;

-- JSON updates
UPDATE users 
SET profile_data = jsonb_set(profile_data, '{preferences,theme}', '"light"')
WHERE id = 1;
```

### Delete Operations
```sql
-- Soft delete pattern
UPDATE users 
SET is_active = false, updated_at = NOW()
WHERE id = 1;

-- Hard delete with cascade
DELETE FROM users WHERE id = 1;
-- (Posts will be automatically deleted due to ON DELETE CASCADE)

-- Conditional delete
DELETE FROM posts 
WHERE created_at < NOW() - INTERVAL '1 year'
  AND published_at IS NULL;
```

## Performance Optimization
### Indexing Strategies
- **B-tree indexes**: Default for equality and range queries
- **GIN indexes**: For array, JSONB, and full-text search
- **GiST indexes**: For geometric data and advanced text search
- **Partial indexes**: For filtered queries to reduce index size

```sql
-- Compound index for common query patterns
CREATE INDEX idx_posts_user_published ON posts(user_id, published_at DESC) 
WHERE published_at IS NOT NULL;

-- Partial index for active users
CREATE INDEX idx_users_active_email ON users(email) WHERE is_active = true;

-- Expression index
CREATE INDEX idx_users_lower_email ON users(LOWER(email));

-- Covering index (INCLUDE clause)
CREATE INDEX idx_users_id_covering ON users(id) INCLUDE (email, username, created_at);
```

### Query Optimization
```sql
-- Use EXPLAIN ANALYZE to understand query execution
EXPLAIN (ANALYZE, BUFFERS) 
SELECT * FROM posts p 
JOIN users u ON p.user_id = u.id 
WHERE u.is_active = true 
AND p.published_at > NOW() - INTERVAL '30 days';

-- Optimize with proper WHERE clause ordering
SELECT * FROM posts 
WHERE published_at IS NOT NULL  -- Most selective first
AND user_id = 1                 -- Then foreign key
AND title ILIKE '%search%'      -- Least selective last
ORDER BY published_at DESC
LIMIT 20;

-- Use EXISTS instead of IN for better performance
SELECT * FROM users u
WHERE EXISTS (
    SELECT 1 FROM posts p 
    WHERE p.user_id = u.id 
    AND p.published_at > NOW() - INTERVAL '30 days'
);
```

### Monitoring & Profiling
```sql
-- Enable query statistics
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Monitor slow queries
SELECT 
    query,
    calls,
    total_time,
    mean_time,
    stddev_time
FROM pg_stat_statements 
ORDER BY mean_time DESC 
LIMIT 10;

-- Check index usage
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch
FROM pg_stat_user_indexes 
WHERE idx_scan < 10;
```

## Backup and Recovery
### Backup Strategies
```bash
# Full backup with pg_dump
pg_dump -h localhost -p 5432 -U username -d myapp -f backup.sql

# Compressed backup
pg_dump -h localhost -p 5432 -U username -d myapp | gzip > backup.sql.gz

# Directory format backup (allows parallel restore)
pg_dump -h localhost -p 5432 -U username -d myapp -Fd -f backup_dir

# Continuous archiving (WAL-E or similar)
archive_mode = on
archive_command = 'wal-e wal-push %p'
```

### Recovery Procedures
```bash
# Full restore from pg_dump
psql -h localhost -p 5432 -U username -d myapp -f backup.sql

# Parallel restore from directory format
pg_restore -h localhost -p 5432 -U username -d myapp -j 4 backup_dir

# Point-in-time recovery setup
restore_command = 'wal-e wal-fetch %f %p'
recovery_target_time = '2024-01-15 14:30:00'
```

## Scaling and High Availability
### Read Replicas
```ini
# Primary server configuration
wal_level = replica
max_wal_senders = 3
wal_keep_segments = 64

# Replica server configuration
hot_standby = on
max_standby_streaming_delay = 30s
```

```bash
# Create streaming replication
pg_basebackup -h primary_host -D replica_data -U replication -W -v -P -x
```

### Connection Pooling
```ini
# PgBouncer configuration
[databases]
myapp = host=localhost port=5432 dbname=myapp

[pgbouncer]
listen_port = 6432
auth_type = md5
auth_file = users.txt
pool_mode = transaction
max_client_conn = 100
default_pool_size = 20
```

## Security Best Practices
### Access Control
```sql
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
```

### Data Encryption
```sql
-- Enable encryption at rest (configure in postgresql.conf)
tls_cert_file = 'server.crt'
tls_key_file = 'server.key'
tls_ca_file = 'ca.crt'

-- Application-level encryption
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Hash passwords
INSERT INTO users (email, password_hash) 
VALUES ('user@example.com', crypt('password', gen_salt('bf', 12)));

-- Encrypt sensitive data
UPDATE users SET 
    encrypted_ssn = pgp_sym_encrypt(ssn, 'encryption_key')
WHERE id = 1;
```

## Integration Patterns
### Application Integration
```python
# Repository pattern with connection pooling
import psycopg2.pool
from contextlib import contextmanager

class DatabaseManager:
    def __init__(self, connection_config):
        self.pool = psycopg2.pool.ThreadedConnectionPool(
            minconn=1, maxconn=20, **connection_config
        )
    
    @contextmanager
    def get_connection(self):
        conn = self.pool.getconn()
        try:
            yield conn
        except Exception as e:
            conn.rollback()
            raise
        else:
            conn.commit()
        finally:
            self.pool.putconn(conn)

class UserRepository:
    def __init__(self, db_manager):
        self.db = db_manager
    
    def create_user(self, email, username, password_hash):
        with self.db.get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "INSERT INTO users (email, username, password_hash) "
                    "VALUES (%s, %s, %s) RETURNING id, created_at",
                    (email, username, password_hash)
                )
                return cursor.fetchone()
    
    def get_user_by_email(self, email):
        with self.db.get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "SELECT id, email, username, created_at "
                    "FROM users WHERE email = %s AND is_active = true",
                    (email,)
                )
                return cursor.fetchone()
```

### ORM Integration (SQLAlchemy)
```python
# SQLAlchemy models
from sqlalchemy import create_engine, Column, Integer, String, DateTime, Boolean, Text, JSON
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship
from sqlalchemy.dialects.postgresql import ARRAY, JSONB

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    email = Column(String(255), unique=True, nullable=False)
    username = Column(String(50), unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    is_active = Column(Boolean, default=True)
    profile_data = Column(JSONB, default={})
    
    posts = relationship("Post", back_populates="user", cascade="all, delete-orphan")

class Post(Base):
    __tablename__ = 'posts'
    
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'), nullable=False)
    title = Column(String(255), nullable=False)
    content = Column(Text)
    published_at = Column(DateTime)
    created_at = Column(DateTime, default=datetime.utcnow)
    tags = Column(ARRAY(String), default=[])
    metadata = Column(JSONB, default={})
    
    user = relationship("User", back_populates="posts")

# Database session management
engine = create_engine(
    'postgresql://username:password@localhost:5432/myapp',
    pool_size=20,
    max_overflow=30,
    pool_pre_ping=True,
    echo=False  # Set to True for SQL debugging
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def get_db_session():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
```

## Monitoring and Alerting
### Key Metrics
- **Performance Metrics**: Query response time, throughput (QPS), connection count
- **Resource Metrics**: CPU usage, memory usage, disk I/O, disk space
- **Database Metrics**: Lock waits, deadlocks, cache hit ratio, buffer usage

### Monitoring Setup
```sql
-- Enable statistics collection
shared_preload_libraries = 'pg_stat_statements'
track_activity_query_size = 2048
track_counts = on
track_functions = all

-- Create monitoring views
CREATE VIEW slow_queries AS
SELECT 
    query,
    calls,
    total_time / calls as avg_time,
    total_time,
    (total_time / sum(total_time) OVER ()) * 100 as percent_total
FROM pg_stat_statements
ORDER BY total_time DESC;

CREATE VIEW table_stats AS
SELECT 
    schemaname,
    tablename,
    n_tup_ins + n_tup_upd + n_tup_del as total_writes,
    seq_scan,
    seq_tup_read,
    idx_scan,
    idx_tup_fetch
FROM pg_stat_user_tables;
```

### Common Issues & Troubleshooting
#### Performance Issues
**Issue**: Slow query performance
**Solution**: 
- Use EXPLAIN ANALYZE to identify bottlenecks
- Add appropriate indexes
- Optimize query structure
- Consider query rewriting or denormalization

**Issue**: High connection count
**Solution**:
- Implement connection pooling (PgBouncer)
- Optimize application connection handling
- Monitor for connection leaks

#### Lock Issues
**Issue**: Deadlocks and lock waits
**Solution**:
- Keep transactions short
- Access tables in consistent order
- Use appropriate isolation levels
- Monitor pg_locks for analysis

```sql
-- Monitor active locks
SELECT 
    l.pid,
    l.mode,
    l.granted,
    c.relname,
    a.query
FROM pg_locks l
JOIN pg_class c ON l.relation = c.oid
JOIN pg_stat_activity a ON l.pid = a.pid
WHERE NOT l.granted;
```

## AI Assistant Guidelines
When helping with PostgreSQL:

1. **Always consider performance implications of queries and schema design**
2. **Include proper error handling and connection management**
3. **Suggest appropriate indexing strategies for query patterns**
4. **Include security considerations (SQL injection, access control)**
5. **Recommend connection pooling for production applications**
6. **Provide both raw SQL and ORM examples where applicable**
7. **Include monitoring and troubleshooting guidance**
8. **Consider PostgreSQL-specific features (JSONB, arrays, advanced types)**

### Code Generation Rules
- Generate queries that are optimized for PostgreSQL's query planner
- Include proper error handling and connection management
- Use parameterized queries to prevent SQL injection
- Include comments explaining complex queries and performance considerations
- Provide both transaction and non-transaction examples as appropriate
- Consider using PostgreSQL-specific features when beneficial (RETURNING, UPSERT, etc.)
- Include index suggestions for frequently queried columns
- Use appropriate data types for PostgreSQL (prefer TEXT over VARCHAR for flexibility)