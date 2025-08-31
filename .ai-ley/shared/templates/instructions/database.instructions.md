# Database Tool Instructions Template

## Database Overview
- **Database System**: [Name of the database system]
- **Version**: [Current stable version or version range]
- **Type**: [Relational, NoSQL, Graph, Time-Series, etc.]
- **License**: [Open Source, Commercial, Cloud Service]
- **Use Cases**: [OLTP, OLAP, Analytics, Caching, etc.]

## Installation & Setup
### Local Installation
```bash
# Package manager installation
[package-manager] install [database-name]

# Docker installation
docker run -d --name [db-name] \
  -p [port]:[port] \
  -e [ENV_VAR]=[value] \
  [docker-image]

# Cloud service setup
[cloud-cli] [database-service] create [parameters]
```

### Configuration
```[config-format]
# Main configuration file ([config-file-name])
[configuration-example]
```

## Core Concepts
### [Concept 1: e.g., Collections/Tables]
- **Purpose**: [What this concept represents]
- **Usage**: [How to work with it]
- **Best Practices**: [Optimization tips]

### [Concept 2: e.g., Indexes]
- **Purpose**: [What this concept represents]
- **Usage**: [How to work with it]
- **Best Practices**: [Optimization tips]

### [Concept 3: e.g., Transactions]
- **Purpose**: [What this concept represents]
- **Usage**: [How to work with it]
- **Best Practices**: [Optimization tips]

## Connection and Authentication
### Connection Methods
```[language]
// Native driver connection
[connection-example-1]

// ORM/ODM connection
[connection-example-2]

// Connection pooling
[connection-pooling-example]
```

### Authentication & Security
```[language]
// Basic authentication
[auth-example-1]

// SSL/TLS connection
[ssl-connection-example]

// Role-based access
[rbac-example]
```

## Data Modeling
### Schema Design Best Practices
- [Best practice 1 for data modeling]
- [Best practice 2 for relationships]
- [Best practice 3 for normalization/denormalization]

### Example Schema
```sql
-- [Schema example in SQL or equivalent]
[schema-definition]

-- Indexes for performance
[index-definitions]
```

## CRUD Operations
### Create Operations
```[query-language]
-- Insert single record
[insert-single-example]

-- Insert multiple records
[insert-bulk-example]
```

### Read Operations
```[query-language]
-- Simple select
[select-simple-example]

-- Complex query with joins
[select-complex-example]

-- Aggregation queries
[aggregation-example]
```

### Update Operations
```[query-language]
-- Update single record
[update-single-example]

-- Update multiple records
[update-bulk-example]
```

### Delete Operations
```[query-language]
-- Delete single record
[delete-single-example]

-- Delete with conditions
[delete-conditional-example]
```

## Performance Optimization
### Indexing Strategies
- [Indexing best practice 1]
- [Indexing best practice 2]
- [Composite index guidelines]

```[query-language]
-- Index creation examples
[index-example-1]
[index-example-2]
```

### Query Optimization
- [Query optimization technique 1]
- [Query optimization technique 2]
- [Explain plan analysis]

```[query-language]
-- Optimized query examples
[optimized-query-1]
[optimized-query-2]
```

### Monitoring & Profiling
```bash
# Performance monitoring commands
[monitoring-command-1]
[monitoring-command-2]

# Query profiling
[profiling-command]
```

## Backup and Recovery
### Backup Strategies
```bash
# Full backup
[full-backup-command]

# Incremental backup
[incremental-backup-command]

# Point-in-time recovery backup
[pitr-backup-command]
```

### Recovery Procedures
```bash
# Full restore
[restore-command]

# Point-in-time recovery
[pitr-restore-command]
```

### Disaster Recovery
- [DR best practice 1]
- [DR best practice 2]
- [Cross-region replication setup]

## Scaling and High Availability
### Horizontal Scaling
```[config-format]
# Sharding configuration
[sharding-config]

# Read replicas setup
[replica-config]
```

### Vertical Scaling
- [Resource scaling guidelines]
- [Configuration tuning for scale]
- [Hardware recommendations]

### High Availability Setup
```[config-format]
# Master-slave configuration
[ha-config-example]

# Cluster setup
[cluster-config-example]
```

## Security Best Practices
### Access Control
```sql
-- User management
[user-creation-example]

-- Role-based permissions
[permission-example]

-- Grant/revoke privileges
[privilege-management]
```

### Data Encryption
- [Encryption at rest configuration]
- [Encryption in transit setup]
- [Key management best practices]

### Auditing and Compliance
```[config-format]
# Audit logging configuration
[audit-config]
```

## Integration Patterns
### Application Integration
```[language]
// Repository pattern
[repository-pattern-example]

// Connection pooling
[pool-management-example]

// Error handling
[error-handling-example]
```

### ORM/ODM Integration
```[language]
// [ORM-name] configuration
[orm-config-example]

// Model definitions
[model-example]

// Query examples
[orm-query-example]
```

### API Integration
```[language]
// REST API with database
[rest-api-example]

// GraphQL with database
[graphql-example]
```

## Development Workflow
### Local Development
```bash
# Development database setup
[dev-setup-commands]

# Database seeding
[seed-command]

# Schema migrations
[migration-commands]
```

### Testing Strategies
```[language]
// Unit testing with database
[unit-test-example]

// Integration testing
[integration-test-example]

// Test data management
[test-data-example]
```

### CI/CD Integration
```yaml
# CI pipeline with database testing
[ci-pipeline-example]

# Database deployment pipeline
[deployment-pipeline]
```

## Monitoring and Alerting
### Key Metrics
- **Performance Metrics**: [List of important performance indicators]
- **Resource Metrics**: [CPU, Memory, Disk, Network indicators]
- **Application Metrics**: [Connection pools, query performance, etc.]

### Monitoring Setup
```[config-format]
# Monitoring agent configuration
[monitoring-config]

# Alert rules
[alert-config]
```

### Troubleshooting
#### Common Issues
- **Issue 1**: [Description and solution]
- **Issue 2**: [Description and solution]
- **Issue 3**: [Description and solution]

#### Diagnostic Commands
```bash
# Performance diagnostics
[diagnostic-command-1]

# Connection diagnostics
[diagnostic-command-2]

# Log analysis
[log-analysis-command]
```

## Migration and Versioning
### Schema Versioning
```[migration-format]
# Migration file example
[migration-example]

# Rollback example
[rollback-example]
```

### Data Migration
```bash
# Data export
[export-command]

# Data import
[import-command]

# Cross-database migration
[migration-command]
```

## Best Practices Summary
### Development Best Practices
- [Development best practice 1]
- [Development best practice 2]
- [Development best practice 3]

### Production Best Practices
- [Production best practice 1]
- [Production best practice 2]
- [Production best practice 3]

### Security Best Practices
- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Common Anti-Patterns to Avoid
- **Anti-Pattern 1**: [Description and why to avoid]
- **Anti-Pattern 2**: [Description and why to avoid]
- **Anti-Pattern 3**: [Description and why to avoid]

## Useful Resources
- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools and GUIs**: [List of helpful tools]
- **Performance Tuning Guides**: [URLs]

## AI Assistant Guidelines
When helping with [Database Name]:

1. **Always consider data modeling implications**
2. **Include performance considerations in queries**
3. **Suggest appropriate indexing strategies**
4. **Include error handling in database code**
5. **Consider security implications of database operations**
6. **Provide migration and versioning guidance**
7. **Include monitoring and alerting recommendations**
8. **Reference connection pooling and resource management**

### Code Generation Rules
- Generate queries that are optimized for performance
- Include proper error handling and connection management
- Follow database-specific naming conventions
- Include comments explaining complex queries
- Provide both raw queries and ORM/ODM examples where applicable
- Consider security implications (SQL injection prevention, etc.)
- Include transaction management where appropriate