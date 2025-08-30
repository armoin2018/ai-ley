# Microsoft SQL Server Instructions

## Overview

Microsoft SQL Server is an enterprise relational database management system (RDBMS) supporting OLTP, OLAP, and data warehousing workloads. It offers advanced security, high availability, in-memory features, and powerful tooling (SSMS, Azure Data Studio) across Windows and Linux.

## Core Principles

- ACID transactions, strong consistency
- T-SQL as primary language (procedures, functions, triggers)
- Security-first: least privilege, encryption in transit/at rest
- Performance via indexing, query plans, caching, and in-memory OLTP
- High availability with Always On Availability Groups
- Backup/restore strategy with point-in-time recovery

## Implementation Framework

### Installation (Linux container quickstart)

```bash
# Pull and run SQL Server 2022 container (developer edition)
docker pull mcr.microsoft.com/mssql/server:2022-latest

docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Str0ngP@ss!" \
  -p 1433:1433 --name sql2022 -d mcr.microsoft.com/mssql/server:2022-latest

# Connect with sqlcmd (Docker or local)
docker exec -it sql2022 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Str0ngP@ss!'
```

### Database creation and security

```sql
-- Create database and login
CREATE DATABASE SalesDB;
GO
USE master;
CREATE LOGIN app_login WITH PASSWORD = 'C0mpl3x#Pass', CHECK_POLICY = ON, CHECK_EXPIRATION = ON;
GO
USE SalesDB;
CREATE USER app_user FOR LOGIN app_login;
EXEC sp_addrolemember 'db_datareader', 'app_user';
EXEC sp_addrolemember 'db_datawriter', 'app_user';
-- Principle of least privilege: add only needed perms
```

### Schema and indexing

```sql
-- Schema example
CREATE SCHEMA sales AUTHORIZATION dbo;
GO
CREATE TABLE sales.Customers (
  CustomerId INT IDENTITY(1,1) PRIMARY KEY,
  Email NVARCHAR(255) NOT NULL UNIQUE,
  Name NVARCHAR(200) NOT NULL,
  CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);

CREATE TABLE sales.Orders (
  OrderId BIGINT IDENTITY(1,1) PRIMARY KEY,
  CustomerId INT NOT NULL,
  Amount DECIMAL(18,2) NOT NULL,
  Status TINYINT NOT NULL,
  OrderedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerId)
    REFERENCES sales.Customers(CustomerId)
);

-- Indexing
CREATE INDEX IX_Orders_CustomerId_OrderedAt ON sales.Orders(CustomerId, OrderedAt DESC);
CREATE UNIQUE INDEX IX_Customers_Email ON sales.Customers(Email);
```

### Queries and stored procedures

```sql
-- Parameterized query with proper types
DECLARE @CustomerId INT = 123;
SELECT TOP (50) *
FROM sales.Orders WITH (READPAST)
WHERE CustomerId = @CustomerId
ORDER BY OrderedAt DESC;

-- Stored procedure
CREATE OR ALTER PROCEDURE sales.usp_CreateOrder
  @CustomerId INT,
  @Amount DECIMAL(18,2)
AS
BEGIN
  SET NOCOUNT ON;
  BEGIN TRY
    BEGIN TRAN;

    INSERT INTO sales.Orders (CustomerId, Amount, Status)
    VALUES (@CustomerId, @Amount, 1);

    COMMIT;
  END TRY
  BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK;
    THROW; -- Re-throw for caller/telemetry
  END CATCH
END;
```

### Performance and troubleshooting

```sql
-- Identify slow queries
SELECT TOP 20
  qs.total_elapsed_time / qs.execution_count AS avg_elapsed_ms,
  qs.max_elapsed_time,
  DB_NAME(st.dbid) AS dbname,
  st.text,
  qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY avg_elapsed_ms DESC;

-- Missing indexes (heuristic)
SELECT TOP 25
  migs.avg_total_user_cost * (migs.avg_user_impact/100.0) * (migs.user_seeks + migs.user_scans) AS improvement,
  DB_NAME(mid.database_id) AS dbname,
  mid.statement AS table_name,
  mid.equality_columns,
  mid.inequality_columns,
  mid.included_columns
FROM sys.dm_db_missing_index_group_stats AS migs
JOIN sys.dm_db_missing_index_groups AS mig ON migs.group_handle = mig.index_group_handle
JOIN sys.dm_db_missing_index_details AS mid ON mig.index_handle = mid.index_handle
ORDER BY improvement DESC;

-- Index usage stats
SELECT DB_NAME(database_id) AS dbname, OBJECT_NAME(object_id) AS table_name,
       i.name AS index_name, user_seeks, user_scans, user_lookups, user_updates
FROM sys.dm_db_index_usage_stats ius
JOIN sys.indexes i ON i.object_id = ius.object_id AND i.index_id = ius.index_id
WHERE database_id = DB_ID('SalesDB')
ORDER BY user_updates DESC;
```

### Backup and restore

```sql
-- Full backup
BACKUP DATABASE SalesDB TO DISK = '/var/opt/mssql/backups/SalesDB_full.bak' WITH INIT, COMPRESSION;

-- Log backup (for PITR)
BACKUP LOG SalesDB TO DISK = '/var/opt/mssql/backups/SalesDB_log.trn' WITH INIT, COMPRESSION;

-- Restore (new server)
RESTORE DATABASE SalesDB FROM DISK = '/var/opt/mssql/backups/SalesDB_full.bak' WITH MOVE 'SalesDB' TO '/var/opt/mssql/data/SalesDB.mdf', MOVE 'SalesDB_log' TO '/var/opt/mssql/data/SalesDB_log.ldf', NORECOVERY;
RESTORE LOG SalesDB FROM DISK = '/var/opt/mssql/backups/SalesDB_log.trn' WITH RECOVERY;
```

## Best Practices

- Use contained database users where possible
- Parameterize queries; avoid string concatenation (SQL injection)
- Use appropriate data types and lengths; avoid NVARCHAR(MAX) unless needed
- Keep statistics up to date; run index maintenance as needed
- Monitor wait stats, CPU, memory, IO; size tempdb properly
- Separate data, log, and tempdb storage
- Implement row/page compression where appropriate

## Common Patterns

### App connection (Node.js example)

```ts
// mssql v10+
import sql from 'mssql';

const pool = new sql.ConnectionPool({
  server: process.env.SQL_HOST || 'localhost',
  port: 1433,
  options: { encrypt: true, trustServerCertificate: true },
  database: 'SalesDB',
  user: process.env.SQL_USER,
  password: process.env.SQL_PASS,
  pool: { max: 10, min: 1, idleTimeoutMillis: 30000 }
});

await pool.connect();

export async function createOrder(customerId: number, amount: number) {
  const request = pool.request();
  request.input('CustomerId', sql.Int, customerId);
  request.input('Amount', sql.Decimal(18, 2), amount);
  const result = await request.execute('sales.usp_CreateOrder');
  return result.rowsAffected[0] === 1;
}
```

### Migrations (SQL files + CI)

- Store versioned SQL scripts in VCS
- Use tools like sqlpackage/DACPAC or Flyway/Liquibase for repeatability

## Tools and Resources

- Azure Data Studio (cross-platform), SQL Server Management Studio (Windows)
- sqlcmd, bcp, mssql-tools
- Query Store, Extended Events, Performance Monitor
- Ola Hallengren maintenance scripts

## Quality and Compliance

- Transparent Data Encryption (TDE) for at-rest
- TLS for in-transit (Force Encryption)
- Always Encrypted for sensitive columns
- Row-Level Security, Dynamic Data Masking where applicable
- Auditing and SQL Server Audit specifications

## Troubleshooting

- Use Query Store to identify regressions after upgrades/deployments
- Capture actual execution plans for slow queries; watch for parameter sniffing
- Check tempdb contention (PAGELATCH) and size tempdb files appropriately
- Validate backups and restore regularly; test PITR

## Metrics and Monitoring

- Wait stats: sys.dm_os_wait_stats
- Query Store: top resource-consuming queries
- IO/CPU/memory utilization trends
- Index fragmentation and statistics freshness

## Integration Patterns

- ETL with SSIS or Azure Data Factory
- Replication, CDC, and Change Tracking for downstream systems
- Always On Availability Groups for HA/DR

## Advanced Topics

- In-Memory OLTP (memory-optimized tables, natively compiled procs)
- Columnstore indexes for analytics
- Partitioning large tables for manageability
- Service Broker for reliable messaging

## AI Assistant Guidelines

Use SQL Server when:
- Enterprise-grade RDBMS with strong HA/DR and security is required
- Windows ecosystem or Azure integration is a priority
- Mixed workloads (OLTP + analytics) on a single platform

Avoid when:
- License cost/constraints outweigh benefits for simple workloads
- Fully managed cloud database (e.g., serverless Postgres) is preferred

Code generation rules:
- Generate parameterized T-SQL
- Include TRY/CATCH and transaction handling
- Provide indexes aligned with query predicates and sort orders
- Include migration scripts and rollback steps

Quality enforcement:
- Validate schema with naming conventions and appropriate keys
- Enforce least privilege roles and permissions
- Confirm backup/restore strategy works via tests
- Capture and review execution plans for key queries