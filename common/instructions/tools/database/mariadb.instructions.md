`
---
applyTo: "mariadb, **/*.sql, **/mariadb/**"
---

# MariaDB Database Instructions

## Overview
- **Domain**: Relational Database Management and MySQL-Compatible Database Systems
- **Purpose**: Build scalable, high-performance database solutions using MariaDB
- **Applicable To**: Web applications, enterprise systems, data analytics, and high-availability environments
- **Integration Level**: Database layer with application frameworks and data processing pipelines

## Core Principles

### Fundamental Concepts
1. **MySQL Compatibility**: Drop-in replacement for MySQL with enhanced features
2. **Open Source Advantage**: Community-driven development with enterprise features
3. **Performance Optimization**: Advanced storage engines and query optimization
4. **High Availability**: Built-in clustering and replication capabilities

### Key Benefits
- Full MySQL compatibility with enhanced performance
- Advanced storage engines (InnoDB, Aria, ColumnStore)
- Comprehensive JSON support and NoSQL capabilities
- Strong security features and compliance support
- Active open-source community and enterprise backing

### Common Misconceptions
- **Myth**: MariaDB is just a MySQL fork without significant improvements
  **Reality**: MariaDB includes many performance enhancements and features not available in MySQL
- **Myth**: Migrating from MySQL to MariaDB is complex
  **Reality**: MariaDB is designed as a drop-in replacement with minimal migration effort

## Implementation Framework

### Getting Started
#### Prerequisites
- Linux/macOS/Windows operating system
- Basic SQL knowledge and database concepts
- Understanding of application data requirements

#### Initial Setup
```bash
# Ubuntu/Debian installation
sudo apt update
sudo apt install mariadb-server mariadb-client

# CentOS/RHEL installation
sudo yum install mariadb-server mariadb

# macOS installation with Homebrew
brew install mariadb

# Start and enable MariaDB service
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Secure installation
sudo mysql_secure_installation
```

### Core Methodologies
#### Database Design and Normalization
- **Purpose**: Create efficient, maintainable database structures
- **When to Use**: All new database projects and schema redesigns
- **Implementation Steps**:
  1. Analyze data requirements and relationships
  2. Apply normalization principles (1NF, 2NF, 3NF)
  3. Define primary keys, foreign keys, and constraints
  4. Optimize for query patterns and performance
- **Success Metrics**: Efficient queries, data integrity, and minimal redundancy

#### Performance Optimization
- **Purpose**: Maximize database performance and scalability
- **When to Use**: Production environments and performance-critical applications
- **Implementation Steps**:
  1. Analyze query performance with EXPLAIN
  2. Create appropriate indexes for query patterns
  3. Configure buffer pools and memory settings
  4. Monitor and tune storage engine parameters
- **Success Metrics**: Fast query response times and efficient resource utilization

### Process Integration
#### Development Workflow
```bash
# Development environment setup
docker run --name mariadb-dev \
  -e MYSQL_ROOT_PASSWORD=development \
  -e MYSQL_DATABASE=myapp \
  -e MYSQL_USER=developer \
  -e MYSQL_PASSWORD=devpass \
  -p 3306:3306 \
  -d mariadb:10.11

# Production deployment with configuration
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb
```

#### Backup and Recovery Strategy
```bash
# Full database backup
mysqldump -u root -p --all-databases --single-transaction --routines --triggers > full_backup.sql

# Incremental backup with binary logs
mysqlbinlog mysql-bin.000001 > incremental_backup.sql

# Point-in-time recovery
mysql -u root -p < full_backup.sql
mysql -u root -p < incremental_backup.sql
```

## Best Practices

### Database Schema Design
```sql
-- Modern MariaDB schema with best practices
CREATE DATABASE ecommerce
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE ecommerce;

-- Users table with proper indexing and constraints
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    uuid CHAR(36) NOT NULL UNIQUE DEFAULT (UUID()),
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email_verified_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    -- Indexes for performance
    INDEX idx_email (email),
    INDEX idx_uuid (uuid),
    INDEX idx_created_at (created_at),
    INDEX idx_deleted_at (deleted_at)
) ENGINE=InnoDB;

-- Products table with JSON support
CREATE TABLE products (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    cost DECIMAL(10,2),
    stock_quantity INT UNSIGNED DEFAULT 0,
    
    -- JSON attributes for flexible product data
    attributes JSON DEFAULT NULL,
    
    -- Category and brand relationships
    category_id BIGINT UNSIGNED,
    brand_id BIGINT UNSIGNED,
    
    -- Status and timestamps
    status ENUM('active', 'inactive', 'discontinued') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_sku (sku),
    INDEX idx_category (category_id),
    INDEX idx_brand (brand_id),
    INDEX idx_status (status),
    INDEX idx_price (price),
    FULLTEXT INDEX ft_name_description (name, description),
    
    -- JSON functional indexes (MariaDB 10.3+)
    INDEX idx_attributes_color ((CAST(JSON_EXTRACT(attributes, '$.color') AS CHAR(50)))),
    INDEX idx_attributes_size ((CAST(JSON_EXTRACT(attributes, '$.size') AS CHAR(20))))
) ENGINE=InnoDB;

-- Orders table with proper foreign keys
CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(50) NOT NULL UNIQUE,
    user_id BIGINT UNSIGNED NOT NULL,
    
    -- Order totals
    subtotal DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    shipping_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    
    -- Order status and tracking
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    payment_status ENUM('pending', 'paid', 'failed', 'refunded') DEFAULT 'pending',
    
    -- Shipping information stored as JSON
    shipping_address JSON NOT NULL,
    billing_address JSON NOT NULL,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    shipped_at TIMESTAMP NULL,
    delivered_at TIMESTAMP NULL,
    
    -- Foreign key constraints
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
    
    -- Indexes
    INDEX idx_user_id (user_id),
    INDEX idx_order_number (order_number),
    INDEX idx_status (status),
    INDEX idx_payment_status (payment_status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB;

-- Order items with proper relationships
CREATE TABLE order_items (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    
    -- Product snapshot for historical accuracy
    product_snapshot JSON NOT NULL,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT,
    
    -- Indexes
    INDEX idx_order_id (order_id),
    INDEX idx_product_id (product_id),
    
    -- Unique constraint to prevent duplicate items
    UNIQUE KEY uk_order_product (order_id, product_id)
) ENGINE=InnoDB;
```

### Advanced Query Patterns
```sql
-- Complex queries with CTEs and window functions
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(created_at, '%Y-%m') as month,
        COUNT(*) as order_count,
        SUM(total_amount) as revenue,
        AVG(total_amount) as avg_order_value
    FROM orders 
    WHERE status IN ('delivered', 'shipped')
        AND created_at >= DATE_SUB(NOW(), INTERVAL 12 MONTH)
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
),
running_totals AS (
    SELECT 
        month,
        order_count,
        revenue,
        avg_order_value,
        SUM(revenue) OVER (ORDER BY month) as cumulative_revenue,
        LAG(revenue) OVER (ORDER BY month) as prev_month_revenue,
        (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month) * 100 as growth_rate
    FROM monthly_sales
)
SELECT 
    month,
    order_count,
    FORMAT(revenue, 2) as revenue,
    FORMAT(avg_order_value, 2) as avg_order_value,
    FORMAT(cumulative_revenue, 2) as cumulative_revenue,
    ROUND(growth_rate, 2) as growth_rate_percent
FROM running_totals
ORDER BY month;

-- JSON queries for product attributes
SELECT 
    p.name,
    p.price,
    JSON_EXTRACT(p.attributes, '$.color') as color,
    JSON_EXTRACT(p.attributes, '$.size') as size,
    JSON_EXTRACT(p.attributes, '$.material') as material
FROM products p
WHERE JSON_EXTRACT(p.attributes, '$.color') = 'blue'
    AND p.price BETWEEN 50 AND 200
    AND p.status = 'active';

-- Full-text search with relevance scoring
SELECT 
    p.id,
    p.name,
    p.description,
    p.price,
    MATCH(p.name, p.description) AGAINST ('wireless bluetooth headphones' IN NATURAL LANGUAGE MODE) as relevance_score
FROM products p
WHERE MATCH(p.name, p.description) AGAINST ('wireless bluetooth headphones' IN NATURAL LANGUAGE MODE)
    AND p.status = 'active'
ORDER BY relevance_score DESC, p.price ASC
LIMIT 20;

-- Advanced aggregation with multiple dimensions
SELECT 
    c.name as category,
    COUNT(DISTINCT p.id) as product_count,
    COUNT(DISTINCT o.id) as order_count,
    SUM(oi.quantity) as total_items_sold,
    SUM(oi.total_price) as total_revenue,
    AVG(p.price) as avg_product_price,
    MIN(p.price) as min_price,
    MAX(p.price) as max_price
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
LEFT JOIN order_items oi ON p.id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.id 
    AND o.status IN ('delivered', 'shipped')
    AND o.created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
GROUP BY c.id, c.name
HAVING total_revenue > 0
ORDER BY total_revenue DESC;
```

### Performance Optimization Configuration
```sql
-- Query optimization and indexing strategies
-- Analyze query performance
EXPLAIN EXTENDED
SELECT o.*, u.email, u.first_name, u.last_name
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    AND o.status = 'delivered'
ORDER BY o.created_at DESC;

-- Create composite indexes for common query patterns
CREATE INDEX idx_orders_status_created ON orders(status, created_at);
CREATE INDEX idx_orders_user_status ON orders(user_id, status, created_at);

-- Optimize for specific query patterns
CREATE INDEX idx_products_category_status_price ON products(category_id, status, price);
CREATE INDEX idx_order_items_product_order ON order_items(product_id, order_id);

-- Partition large tables by date
ALTER TABLE orders 
PARTITION BY RANGE (YEAR(created_at)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);
```

## Common Patterns and Examples

### Pattern 1: Audit Trail Implementation
**Scenario**: Track all changes to critical data for compliance and debugging
**Implementation**:
```sql
-- Create audit table
CREATE TABLE audit_log (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(64) NOT NULL,
    record_id BIGINT UNSIGNED NOT NULL,
    action ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_values JSON NULL,
    new_values JSON NULL,
    changed_by BIGINT UNSIGNED NULL,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_table_record (table_name, record_id),
    INDEX idx_changed_at (changed_at),
    INDEX idx_changed_by (changed_by)
) ENGINE=InnoDB;

-- Trigger for user updates
DELIMITER //
CREATE TRIGGER users_audit_update
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (
        table_name, 
        record_id, 
        action, 
        old_values, 
        new_values,
        changed_by
    ) VALUES (
        'users',
        NEW.id,
        'UPDATE',
        JSON_OBJECT(
            'email', OLD.email,
            'first_name', OLD.first_name,
            'last_name', OLD.last_name,
            'phone', OLD.phone
        ),
        JSON_OBJECT(
            'email', NEW.email,
            'first_name', NEW.first_name,
            'last_name', NEW.last_name,
            'phone', NEW.phone
        ),
        @current_user_id
    );
END//
DELIMITER ;
```
**Expected Outcomes**: Complete audit trail for regulatory compliance and debugging

### Pattern 2: Data Archiving Strategy
**Scenario**: Archive old data while maintaining performance
**Implementation**:
```sql
-- Create archive tables
CREATE TABLE orders_archive LIKE orders;
CREATE TABLE order_items_archive LIKE order_items;

-- Archive old completed orders
DELIMITER //
CREATE PROCEDURE ArchiveOldOrders()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE cutoff_date DATE DEFAULT DATE_SUB(CURDATE(), INTERVAL 2 YEAR);
    
    -- Start transaction
    START TRANSACTION;
    
    -- Move order items first (foreign key dependency)
    INSERT INTO order_items_archive
    SELECT oi.* 
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.id
    WHERE o.created_at < cutoff_date
        AND o.status IN ('delivered', 'cancelled');
    
    -- Move orders
    INSERT INTO orders_archive
    SELECT * 
    FROM orders 
    WHERE created_at < cutoff_date
        AND status IN ('delivered', 'cancelled');
    
    -- Delete from original tables
    DELETE oi FROM order_items oi
    JOIN orders o ON oi.order_id = o.id
    WHERE o.created_at < cutoff_date
        AND o.status IN ('delivered', 'cancelled');
    
    DELETE FROM orders 
    WHERE created_at < cutoff_date
        AND status IN ('delivered', 'cancelled');
    
    COMMIT;
END//
DELIMITER ;

-- Schedule archiving (run monthly)
CREATE EVENT ArchiveOldOrdersEvent
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-01-01 02:00:00'
DO CALL ArchiveOldOrders();
```
**Expected Outcomes**: Improved performance through data lifecycle management

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Using SELECT * in Production Queries
- **Description**: Selecting all columns when only specific fields are needed
- **Why It's Problematic**: Increases network traffic and memory usage
- **Better Approach**: Explicitly specify required columns

#### Anti-Pattern 2: Missing Foreign Key Constraints
- **Description**: Relying on application-level referential integrity
- **Why It's Problematic**: Data integrity issues and orphaned records
- **Better Approach**: Define proper foreign key constraints at database level

## Tools and Resources

### Essential Tools
#### Database Administration
```bash
# MariaDB command-line tools
mysql -u username -p database_name
mysqladmin -u root -p status
mysqldump -u root -p --databases mydb > backup.sql
mysqlcheck -u root -p --optimize --all-databases

# Performance monitoring
mysqladmin -u root -p extended-status
mysqladmin -u root -p processlist
```

#### Configuration Optimization
```ini
# /etc/mysql/mariadb.conf.d/50-server.cnf
[mysqld]
# Basic settings
bind-address = 0.0.0.0
port = 3306
max_connections = 200
max_user_connections = 190

# InnoDB settings for performance
innodb_buffer_pool_size = 2G
innodb_buffer_pool_instances = 8
innodb_log_file_size = 256M
innodb_log_buffer_size = 16M
innodb_flush_log_at_trx_commit = 2
innodb_file_per_table = 1

# Query cache
query_cache_type = 1
query_cache_size = 128M
query_cache_limit = 2M

# Binary logging for replication
log_bin = mysql-bin
binlog_format = ROW
expire_logs_days = 7

# Slow query log
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 2
log_queries_not_using_indexes = 1
```

### Learning Resources
- **MariaDB Documentation**: https://mariadb.com/kb/
- **MariaDB Performance Tuning**: https://mariadb.com/kb/en/optimization-and-indexes/
- **SQL Optimization Guide**: https://mariadb.com/kb/en/query-optimizations/
- **MariaDB Security**: https://mariadb.com/kb/en/securing-mariadb/

## Quality and Compliance

### Quality Standards
- All tables must have primary keys and appropriate indexes
- Foreign key constraints enforced for referential integrity
- Query performance monitored with EXPLAIN analysis
- Regular backup verification and disaster recovery testing

### Security Standards
- SSL/TLS encryption for client connections
- Proper user privileges following principle of least privilege
- Regular security updates and patch management
- Audit logging for sensitive operations

### Performance Standards
- Query response times <100ms for simple queries
- Complex analytical queries <5 seconds
- Database availability >99.9% uptime
- Regular performance monitoring and optimization

## AI Assistant Guidelines

When helping with MariaDB Development:

1. **Schema Design First**: Always analyze data relationships and access patterns before creating tables
2. **Performance Focus**: Include indexing strategies and query optimization from the start
3. **Security Priority**: Implement proper authentication, authorization, and data protection
4. **Modern Features**: Leverage MariaDB-specific features like JSON support and window functions
5. **Scalability Planning**: Consider partitioning, replication, and clustering requirements
6. **Data Integrity**: Enforce constraints and implement proper transaction handling
7. **Monitoring Strategy**: Include performance monitoring and alerting considerations
8. **Backup Planning**: Design comprehensive backup and recovery strategies

### Decision Making Framework
When helping teams choose MariaDB approaches:

1. **Requirements Analysis**: Understand performance, scalability, and feature requirements
2. **Schema Design**: Plan normalized schema with proper relationships and constraints
3. **Performance Planning**: Design indexing strategy and query optimization approach
4. **Security Assessment**: Implement appropriate security measures and access controls
5. **High Availability**: Plan for clustering, replication, and disaster recovery
6. **Migration Strategy**: Plan migration from other database systems if applicable

### Code Generation Rules
- Generate normalized schemas with proper constraints and indexes
- Include comprehensive error handling and transaction management
- Use prepared statements and parameterized queries for security
- Implement proper data types and character sets (utf8mb4)
- Generate efficient queries with appropriate JOIN strategies
- Include performance monitoring and optimization queries
- Follow MariaDB naming conventions and best practices
- Provide backup and maintenance procedures

### Quality Enforcement
- ✅ Enforce foreign key constraints for referential integrity
- ✅ Require proper indexing strategies for query performance
- ✅ Block queries without WHERE clauses on large tables
- ✅ Enforce prepared statements for dynamic queries
- ✅ Require proper transaction handling for data consistency
- ✅ Enforce proper character sets and collations (utf8mb4)
- ✅ Require backup and recovery procedures
- ✅ Promote security best practices and access controls