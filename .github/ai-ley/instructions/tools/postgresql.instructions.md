---
name: 'postgresql.instructions'
description: 'Development guidelines and best practices for Postgresql.Instructions'
keywords: [automation, application, agent, access, architecture, assistant, authentication, authorization, advanced, (sqlalchemy)]
---



# PostgreSQL Database Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents when implementing PostgreSQL solutions, emphasizing ACID compliance, advanced SQL features, performance optimization, and enterprise-grade database administration.

### When to Use PostgreSQL

- **ACID compliance** and strong consistency requirements
- **Complex queries** with joins, subqueries, and advanced SQL features
- **JSON/NoSQL workloads** alongside relational data (JSONB support)
- **Data analytics** and reporting with window functions and CTEs
- **Enterprise applications** requiring reliability and scalability

### When to Avoid PostgreSQL

- **Simple key-value storage** → consider Redis or lightweight alternatives
- **Massive horizontal scaling** → consider distributed databases like MongoDB or Cassandra
- **Real-time analytics** at extreme scale → consider specialized time-series databases
- **Document-only workflows** → consider dedicated document databases

### Architecture Essentials

- **Storage**: MVCC (Multi-Version Concurrency Control) with VACUUM for cleanup
- **Indexing**: B-tree, Hash, GiST, GIN, BRIN indexes for different use cases
- **Extensions**: Rich ecosystem (PostGIS, pg_stat_statements, etc.)
- **Replication**: Streaming replication, logical replication, read replicas

### Security and Compliance Guidelines

- **Authentication**: Use strong passwords, SSL/TLS, certificate-based auth
- **Authorization**: Role-based access control (RBAC) with least privilege
- **Encryption**: TLS for transit, transparent data encryption for rest
- **Auditing**: Enable logging, use pg_audit extension for compliance
- **Backup Strategy**: Point-in-time recovery, automated backups, cross-region replication

### Performance Best Practices

- **Query Optimization**: Use EXPLAIN ANALYZE, optimize indexes, avoid N+1 queries
- **Connection Management**: Use connection pooling (PgBouncer, pgpool)
- **Memory Tuning**: Configure shared_buffers, work_mem, maintenance_work_mem
- **Monitoring**: Track slow queries, connection counts, lock waits, replication lag

## Advanced Troubleshooting Guide

### Performance Diagnosis

#### Slow Query Investigation

See [example-1](./examples/postgresql/example-1.sql)

#### Lock Analysis and Resolution

See [example-2](./examples/postgresql/example-2.sql)

#### Connection and Resource Monitoring

See [example-3](./examples/postgresql/example-3.sql)

### Common Production Issues and Solutions

#### Issue: Database Connection Exhaustion

**Symptoms:**

- "FATAL: sorry, too many clients already" errors
- Application timeouts and connection failures
- High connection count in monitoring

**Diagnosis:**

See [example-4](./examples/postgresql/example-4.sql)

**Solutions:**

See [example-5](./examples/postgresql/example-5.bash)

See [example-6](./examples/postgresql/example-6.python)

#### Issue: Sudden Performance Degradation

**Symptoms:**

- Previously fast queries become slow
- Increased I/O wait times
- High CPU usage

**Diagnosis and Solutions:**

See [example-7](./examples/postgresql/example-7.sql)

#### Issue: Replication Lag

**Diagnosis:**

See [example-8](./examples/postgresql/example-8.sql)

**Solutions:**

See [example-9](./examples/postgresql/example-9.sql)

### Maintenance Automation Scripts

#### Automated Vacuum and Analyze

See [example-10](./examples/postgresql/example-10.bash)

#### Performance Monitoring Script

See [example-11](./examples/postgresql/example-11.python)

## AI Assistant Guidelines

When helping with PostgreSQL:

1. **Performance-First Approach**: Always consider query performance and provide EXPLAIN ANALYZE guidance
2. **Security by Design**: Include parameterized queries, access controls, and encryption recommendations
3. **Production-Ready Solutions**: Provide connection pooling, monitoring, and backup strategies
4. **PostgreSQL-Specific Features**: Leverage JSONB, arrays, CTEs, window functions, and extensions
5. **Comprehensive Error Handling**: Include transaction management and retry logic
6. **Monitoring Integration**: Always include monitoring and alerting recommendations
7. **Scalability Considerations**: Address partitioning, replication, and optimization strategies
8. **Real-World Context**: Provide complete, deployable examples with proper configuration

### Code Generation Rules

- Generate queries optimized for PostgreSQL's query planner with appropriate indexes
- Include comprehensive error handling with proper transaction management
- Use parameterized queries exclusively to prevent SQL injection
- Provide detailed comments explaining complex queries and performance considerations
- Include both development and production configuration examples
- Consider PostgreSQL-specific features for optimal performance and functionality
- Include index suggestions and EXPLAIN plans for complex queries
- Use appropriate data types and constraints for data integrity
- Provide monitoring queries and maintenance procedures
- Include backup and recovery procedures in production examples

### Level 3 Enhancement Features

- **Production Deployment Patterns**: Complete Docker, Kubernetes, and cloud deployment examples
- **Advanced Real-World Schemas**: Complex e-commerce, analytics, and multi-tenant patterns
- **Comprehensive Troubleshooting**: Detailed diagnosis and resolution procedures
- **Performance Optimization**: Advanced indexing, query optimization, and monitoring
- **Automation Scripts**: Maintenance, monitoring, and alerting automation
- **Integration Patterns**: Complete application integration with error handling and connection management

### Related Database Technologies

- **MySQL**: For applications requiring MySQL ecosystem compatibility, see `mysql.instructions.md`
- **MongoDB**: For document-oriented data with PostgreSQL's JSONB limitations, see `mongodb.instructions.md`
- **SQLite**: For embedded applications, consider `sqlite.instructions.md` for simpler deployment
- **Oracle**: For enterprise migration scenarios, consult `oracle.instructions.md`
- **General Guidelines**: See `database.instructions.md` for cross-database development standards

## Database Overview

- **Database System**: PostgreSQL
- **Version**: 16+ (Current stable version)
- **Type**: Relational Database Management System (RDBMS)
- **License**: Open Source (PostgreSQL License)
- **Use Cases**: OLTP, OLAP, Analytics, JSON/NoSQL workloads, Time-series data

## Installation & Setup

### Local Installation

See [example-12](./examples/postgresql/example-12.bash)

### Configuration

See [example-13](./examples/postgresql/example-13.ini)

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

See [example-14](./examples/postgresql/example-14.sql)

See [example-15](./examples/postgresql/example-15.python)

### Authentication & Security

See [example-16](./examples/postgresql/example-16.sql)

## Data Modeling

### Schema Design Best Practices

- **Normalization**: Follow 3NF for OLTP systems, consider denormalization for analytics
- **Data Types**: Use appropriate types (TEXT vs VARCHAR, TIMESTAMP vs DATE)
- **Constraints**: Implement proper foreign keys, check constraints, and unique constraints

### Example Schema

See [example-17](./examples/postgresql/example-17.sql)

## CRUD Operations

### Create Operations

See [example-18](./examples/postgresql/example-18.sql)

### Read Operations

See [example-19](./examples/postgresql/example-19.sql)

### Update Operations

See [example-20](./examples/postgresql/example-20.sql)

### Delete Operations

See [example-21](./examples/postgresql/example-21.sql)

## Performance Optimization

### Indexing Strategies

- **B-tree indexes**: Default for equality and range queries
- **GIN indexes**: For array, JSONB, and full-text search
- **GiST indexes**: For geometric data and advanced text search
- **Partial indexes**: For filtered queries to reduce index size

See [example-22](./examples/postgresql/example-22.sql)

### Query Optimization

See [example-23](./examples/postgresql/example-23.sql)

### Monitoring & Profiling

See [example-24](./examples/postgresql/example-24.sql)

## Backup and Recovery

### Backup Strategies

See [example-25](./examples/postgresql/example-25.bash)

### Recovery Procedures

See [example-26](./examples/postgresql/example-26.bash)

## Scaling and High Availability

### Read Replicas

See [example-27](./examples/postgresql/example-27.ini)

See [example-28](./examples/postgresql/example-28.bash)

### Connection Pooling

See [example-29](./examples/postgresql/example-29.ini)

## Security Best Practices

### Access Control

See [example-30](./examples/postgresql/example-30.sql)

### Data Encryption

See [example-31](./examples/postgresql/example-31.sql)

## Integration Patterns

### Application Integration

See [example-32](./examples/postgresql/example-32.python)

### ORM Integration (SQLAlchemy)

See [example-33](./examples/postgresql/example-33.python)

*Content optimized for conciseness. See external references for additional details.*

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
