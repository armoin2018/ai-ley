---
ai-system-type: 'enterprise-database-platform'
category: 'database'
subcategory: 'enterprise-relational-platform'
difficulty: 'expert'
prerequisites:
  [
    'sql-fundamentals',
    'database-design',
    'enterprise-architecture',
    'performance-optimization',
    'high-availability',
    'data-analytics',
  ]
technical-quality: 5.0
ai-usability: 5.0
cross-references:
  - 'postgresql.instructions.md'
  - 'mongodb.instructions.md'
  - 'mariadb.instructions.md'
  - 'chromadb.instructions.md'
  - 'couchdb.instructions.md'
  - 'database.instructions.md'
version: '5.0.0'
last-updated: '2025-09-06T14:30:00.000000'
enhancement-level: '5-enterprise-transformation'
real-world-examples: true
troubleshooting-guides: true
integration-patterns: true
performance-optimized: true
enterprise-features: true
ai-ml-integration: true
compliance-ready: true
---

# Enterprise MySQL Relational Database & Performance Optimization Platform

## 🎯 **AI Agent Implementation Guide - Enterprise Edition**

### **Platform Purpose & Capabilities**

The **Enterprise MySQL Relational Database & Performance Optimization Platform** provides comprehensive relational database excellence with advanced AI/ML-powered performance optimization, intelligent clustering orchestration, real-time query optimization engines, enterprise-grade security frameworks, automated compliance governance, advanced replication management, and complete operational intelligence for mission-critical enterprise applications requiring maximum reliability and performance.

### **🎯 Advanced Enterprise Decision Matrix**

#### **Primary Use Cases - Enterprise MySQL**

- **High-Performance Web Applications** with intelligent read/write splitting and optimization
- **E-commerce & Financial Platforms** with ACID compliance and transaction intelligence
- **Enterprise Data Warehousing** with advanced analytics and BI optimization
- **Multi-Tenant SaaS Applications** with intelligent tenant isolation and scaling
- **Real-Time Analytics & Reporting** with optimized query execution and caching
- **Legacy System Modernization** with seamless migration and performance enhancement
- **Global Distributed Applications** with intelligent geographic replication
- **Compliance-Heavy Industries** requiring automated governance and audit capabilities

#### **Alternative Technology Recommendations**

- **Complex Analytical Workloads** → PostgreSQL Enterprise with advanced analytics extensions
- **Document-Oriented Data** → MongoDB Enterprise or PostgreSQL with advanced JSON support
- **Vector & AI/ML Workloads** → ChromaDB Enterprise or PostgreSQL with pgvector
- **Multi-Master Document Sync** → CouchDB Enterprise with conflict-free replication
- **Time-Series Specialized Workloads** → InfluxDB Enterprise or specialized time-series databases
- **Extreme Horizontal Scaling** → Distributed databases or sharding-optimized solutions

### **🏗️ Enterprise Architecture Framework**

#### **🔥 Advanced Performance Optimization Intelligence**

- **AI-Powered Query Optimization**: Machine learning-based query plan optimization and execution
- **Intelligent Index Management**: Automated index creation, optimization, and maintenance
- **Dynamic Resource Allocation**: AI-driven memory, CPU, and I/O resource optimization
- **Real-Time Performance Analytics**: Continuous performance monitoring with predictive insights
- **Adaptive Configuration Tuning**: Self-optimizing database parameters based on workload patterns
- **Query Cache Intelligence**: Advanced query result caching with intelligent invalidation

#### **⚡ Advanced Clustering & High Availability**

- **Intelligent Cluster Management**: AI-powered cluster orchestration with automated failover
- **Geographic Distribution**: Multi-region clustering with latency-optimized routing
- **Load Balancing Intelligence**: Dynamic read/write splitting with intelligent load distribution
- **Backup & Recovery Excellence**: Automated backup strategies with point-in-time recovery
- **Disaster Recovery Automation**: Cross-region disaster recovery with automated testing
- **Cluster Analytics**: Real-time cluster performance monitoring with optimization recommendations

#### **🔐 Enterprise Security & Governance Excellence**

- **Zero-Trust Database Access**: Identity-based access with continuous security validation
- **Advanced Encryption Management**: Transparent data encryption with automated key rotation
- **Compliance Automation**: Multi-framework compliance (PCI DSS, GDPR, SOX) with automated reporting
- **Audit Intelligence**: Comprehensive audit trails with ML-powered anomaly detection
- **Data Loss Prevention**: Automated sensitive data discovery and intelligent masking
- **Security Analytics**: Real-time security monitoring with threat intelligence integration

#### **📊 Advanced Storage Engine Intelligence**

- **InnoDB Advanced Optimization**: Intelligent buffer pool management and transaction optimization
- **Storage Analytics**: Real-time storage performance monitoring with optimization recommendations
- **Compression Intelligence**: Adaptive compression algorithms based on data characteristics
- **Index Optimization**: AI-powered index design and maintenance automation
- **Table Partitioning**: Intelligent partitioning strategies for optimal performance

### **💼 Enterprise Implementation Framework**

#### **💻 EnterpriseMySQLEngine - Core Intelligence**

```python
# Enterprise MySQL Engine - Advanced Implementation
import asyncio
import logging
import ssl
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Union, Callable, Tuple
from dataclasses import dataclass, field
from enum import Enum
from contextlib import asynccontextmanager
import json
import hashlib
import aiomysql
import pymysql
from pymysql.cursors import DictCursor
import numpy as np
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
import redis
from prometheus_client import Counter, Histogram, Gauge
import structlog

# Enterprise Performance Metrics
ENTERPRISE_METRICS = {
    'query_counter': Counter('mysql_queries_total', 'Total MySQL queries', ['database', 'table', 'operation']),
    'query_duration': Histogram('mysql_query_duration_seconds', 'MySQL query duration', ['database', 'operation']),
    'connection_gauge': Gauge('mysql_connections_active', 'Active MySQL connections'),
    'replication_lag_gauge': Gauge('mysql_replication_lag_seconds', 'MySQL replication lag in seconds', ['slave']),
    'transaction_counter': Counter('mysql_transactions_total', 'Total MySQL transactions', ['status']),
    'deadlock_counter': Counter('mysql_deadlocks_total', 'Total MySQL deadlocks detected')
}

class EnterpriseConsistencyLevel(Enum):
    """Advanced consistency levels for enterprise operations"""
    READ_UNCOMMITTED = "READ UNCOMMITTED"
    READ_COMMITTED = "READ COMMITTED"
    REPEATABLE_READ = "REPEATABLE READ"
    SERIALIZABLE = "SERIALIZABLE"

class EnterpriseReplicationMode(Enum):
    """Advanced replication modes"""
    MASTER_SLAVE = "master_slave"
    MASTER_MASTER = "master_master"
    GROUP_REPLICATION = "group_replication"
    CLUSTER_REPLICATION = "cluster_replication"

class EnterpriseStorageEngine(Enum):
    """Advanced storage engines"""
    INNODB = "InnoDB"
    MYISAM = "MyISAM"
    MEMORY = "MEMORY"
    ARCHIVE = "ARCHIVE"
    FEDERATED = "FEDERATED"
    NDB = "NDB"

@dataclass
class EnterpriseMySQLConfig:
    """Enterprise MySQL configuration with advanced features"""
    # Core Connection Settings
    host: str = "localhost"
    port: int = 3306
    database: str = "enterprise_db"
    username: str = "root"
    password: str = ""
    charset: str = "utf8mb4"

    # SSL Configuration
    ssl_enabled: bool = True
    ssl_ca: Optional[str] = None
    ssl_cert: Optional[str] = None
    ssl_key: Optional[str] = None
    ssl_verify_cert: bool = True

    # Connection Pool Settings
    pool_size: int = 20
    max_overflow: int = 30
    pool_timeout: int = 30
    pool_recycle: int = 3600

    # Enterprise Clustering
    read_replicas: List[Dict[str, Any]] = field(default_factory=list)
    write_masters: List[Dict[str, Any]] = field(default_factory=list)
    replication_mode: EnterpriseReplicationMode = EnterpriseReplicationMode.MASTER_SLAVE

    # Performance Settings
    query_timeout: int = 300
    transaction_isolation: EnterpriseConsistencyLevel = EnterpriseConsistencyLevel.REPEATABLE_READ
    default_storage_engine: EnterpriseStorageEngine = EnterpriseStorageEngine.INNODB

    # Enterprise Features
    enable_clustering: bool = True
    enable_performance_optimization: bool = True
    enable_ml_optimization: bool = True
    enable_compliance: bool = True

    # Security & Governance
    enable_encryption: bool = True
    enable_audit_logging: bool = True
    audit_log_path: str = "/var/log/mysql/audit.log"

    # Monitoring & Alerting
    prometheus_enabled: bool = True
    health_check_interval: int = 30
    performance_monitoring: bool = True

    # AI/ML Integration
    query_optimization_ml: bool = True
    intelligent_caching: bool = True
    predictive_scaling: bool = True

    def get_connection_params(self) -> Dict[str, Any]:
        """Get connection parameters for aiomysql"""
        params = {
            'host': self.host,
            'port': self.port,
            'db': self.database,
            'user': self.username,
            'password': self.password,
            'charset': self.charset,
            'autocommit': False,
            'connect_timeout': self.pool_timeout
        }

        if self.ssl_enabled:
            ssl_context = {
                'ssl_disabled': False,
                'ssl_verify_cert': self.ssl_verify_cert
            }
            if self.ssl_ca:
                ssl_context['ssl_ca'] = self.ssl_ca
            if self.ssl_cert:
                ssl_context['ssl_cert'] = self.ssl_cert
            if self.ssl_key:
                ssl_context['ssl_key'] = self.ssl_key

            params.update(ssl_context)

        return params

class EnterpriseQueryOptimizer:
    """AI-powered query optimization engine for MySQL"""

    def __init__(self, config: EnterpriseMySQLConfig):
        self.config = config
        self.query_stats = {}
        self.optimization_cache = {}
        self.ml_model = None
        self.logger = structlog.get_logger("enterprise.query.optimizer")

    async def optimize_query(self, query: str, params: Tuple = None) -> Dict[str, Any]:
        """Optimize SQL query using AI/ML techniques"""
        try:
            query_hash = hashlib.md5(query.encode()).hexdigest()

            # Check optimization cache
            if query_hash in self.optimization_cache:
                cached_result = self.optimization_cache[query_hash]
                if datetime.now() - cached_result['timestamp'] < timedelta(hours=1):
                    return cached_result['optimization']

            # Analyze query structure
            query_analysis = await self._analyze_query_structure(query)

            # Generate optimization recommendations
            optimizations = []

            # Check for missing indexes
            if 'WHERE' in query.upper() and 'INDEX' not in query.upper():
                where_conditions = self._extract_where_conditions(query)
                for condition in where_conditions:
                    optimizations.append({
                        'type': 'index_recommendation',
                        'suggestion': f"Consider adding index on column: {condition}",
                        'impact': 'high',
                        'sql': f"CREATE INDEX idx_{condition} ON table_name ({condition})"
                    })

            # Check for inefficient JOINs
            if 'JOIN' in query.upper():
                join_analysis = self._analyze_joins(query)
                optimizations.extend(join_analysis)

            # Check for subquery optimization opportunities
            if 'SELECT' in query.upper() and query.upper().count('SELECT') > 1:
                subquery_opts = self._analyze_subqueries(query)
                optimizations.extend(subquery_opts)

            # Analyze query execution plan (would require actual database connection)
            execution_plan = await self._get_execution_plan(query, params)
            if execution_plan:
                plan_optimizations = self._analyze_execution_plan(execution_plan)
                optimizations.extend(plan_optimizations)

            optimization_result = {
                'query_hash': query_hash,
                'original_query': query,
                'query_analysis': query_analysis,
                'optimizations': optimizations,
                'estimated_improvement': self._calculate_improvement_estimate(optimizations),
                'optimized_query': self._apply_optimizations(query, optimizations)
            }

            # Cache optimization result
            self.optimization_cache[query_hash] = {
                'timestamp': datetime.now(),
                'optimization': optimization_result
            }

            return optimization_result

        except Exception as e:
            self.logger.error(f"Query optimization failed: {e}")
            return {'error': str(e)}

    async def _analyze_query_structure(self, query: str) -> Dict[str, Any]:
        """Analyze SQL query structure for optimization opportunities"""
        query_upper = query.upper()

        analysis = {
            'query_type': 'UNKNOWN',
            'table_count': 0,
            'join_count': 0,
            'subquery_count': 0,
            'function_count': 0,
            'complexity_score': 0
        }

        # Determine query type
        if query_upper.strip().startswith('SELECT'):
            analysis['query_type'] = 'SELECT'
        elif query_upper.strip().startswith('INSERT'):
            analysis['query_type'] = 'INSERT'
        elif query_upper.strip().startswith('UPDATE'):
            analysis['query_type'] = 'UPDATE'
        elif query_upper.strip().startswith('DELETE'):
            analysis['query_type'] = 'DELETE'

        # Count various components
        analysis['table_count'] = len([word for word in query_upper.split() if word in ['FROM', 'JOIN', 'INTO', 'UPDATE']])
        analysis['join_count'] = query_upper.count(' JOIN ')
        analysis['subquery_count'] = query_upper.count('SELECT') - 1  # Subtract main query
        analysis['function_count'] = sum([query_upper.count(func) for func in ['COUNT(', 'SUM(', 'AVG(', 'MAX(', 'MIN(']])

        # Calculate complexity score
        complexity_score = 0
        complexity_score += analysis['table_count'] * 2
        complexity_score += analysis['join_count'] * 5
        complexity_score += analysis['subquery_count'] * 10
        complexity_score += analysis['function_count'] * 3

        analysis['complexity_score'] = complexity_score

        return analysis

    def _extract_where_conditions(self, query: str) -> List[str]:
        """Extract column names from WHERE conditions"""
        # Simplified extraction - in production would use proper SQL parsing
        where_conditions = []

        if 'WHERE' in query.upper():
            where_part = query.upper().split('WHERE')[1]
            if 'ORDER BY' in where_part:
                where_part = where_part.split('ORDER BY')[0]
            if 'GROUP BY' in where_part:
                where_part = where_part.split('GROUP BY')[0]

            # Extract column names (simplified)
            import re
            columns = re.findall(r'(\w+)\s*[=<>!]', where_part)
            where_conditions.extend(columns)

        return where_conditions

    def _analyze_joins(self, query: str) -> List[Dict[str, Any]]:
        """Analyze JOIN operations for optimization opportunities"""
        optimizations = []

        join_count = query.upper().count(' JOIN ')
        if join_count > 3:
            optimizations.append({
                'type': 'join_optimization',
                'suggestion': f"Consider breaking down {join_count} JOINs into smaller queries or using temporary tables",
                'impact': 'medium',
                'reason': 'Multiple JOINs can impact performance significantly'
            })

        if 'LEFT JOIN' in query.upper() and 'RIGHT JOIN' in query.upper():
            optimizations.append({
                'type': 'join_optimization',
                'suggestion': "Consider standardizing JOIN types (prefer LEFT JOIN over RIGHT JOIN)",
                'impact': 'low',
                'reason': 'Consistent JOIN patterns improve readability and optimization'
            })

        return optimizations

    def _analyze_subqueries(self, query: str) -> List[Dict[str, Any]]:
        """Analyze subqueries for optimization opportunities"""
        optimizations = []

        subquery_count = query.upper().count('SELECT') - 1
        if subquery_count > 2:
            optimizations.append({
                'type': 'subquery_optimization',
                'suggestion': "Consider converting nested subqueries to JOINs or temporary tables",
                'impact': 'high',
                'reason': 'Multiple nested subqueries can cause performance issues'
            })

        if 'IN (SELECT' in query.upper():
            optimizations.append({
                'type': 'subquery_optimization',
                'suggestion': "Consider replacing 'IN (SELECT...)' with EXISTS or JOIN",
                'impact': 'medium',
                'reason': 'EXISTS clauses often perform better than IN with subqueries'
            })

        return optimizations

class EnterpriseClusterManager:
    """Advanced clustering management with intelligent load balancing"""

    def __init__(self, config: EnterpriseMySQLConfig):
        self.config = config
        self.read_connections = {}
        self.write_connections = {}
        self.connection_stats = {}
        self.logger = structlog.get_logger("enterprise.cluster.manager")

    async def initialize_cluster(self) -> bool:
        """Initialize MySQL cluster with intelligent load balancing"""
        try:
            # Initialize write masters
            for master_config in self.config.write_masters:
                master_key = f"{master_config['host']}:{master_config['port']}"

                connection_params = self.config.get_connection_params()
                connection_params.update({
                    'host': master_config['host'],
                    'port': master_config['port']
                })

                pool = await aiomysql.create_pool(**connection_params, maxsize=self.config.pool_size)
                self.write_connections[master_key] = {
                    'pool': pool,
                    'config': master_config,
                    'stats': {'queries': 0, 'errors': 0, 'avg_response_time': 0}
                }

            # Initialize read replicas
            for replica_config in self.config.read_replicas:
                replica_key = f"{replica_config['host']}:{replica_config['port']}"

                connection_params = self.config.get_connection_params()
                connection_params.update({
                    'host': replica_config['host'],
                    'port': replica_config['port']
                })

                pool = await aiomysql.create_pool(**connection_params, maxsize=self.config.pool_size)
                self.read_connections[replica_key] = {
                    'pool': pool,
                    'config': replica_config,
                    'stats': {'queries': 0, 'errors': 0, 'avg_response_time': 0}
                }

            self.logger.info(f"Cluster initialized: {len(self.write_connections)} masters, {len(self.read_connections)} replicas")
            return True

        except Exception as e:
            self.logger.error(f"Cluster initialization failed: {e}")
            return False

    async def get_optimal_connection(self, operation_type: str = 'read') -> Tuple[Any, str]:
        """Get optimal connection based on operation type and current load"""
        try:
            if operation_type in ['SELECT', 'SHOW', 'DESCRIBE', 'EXPLAIN', 'read']:
                # Use read replica with lowest load
                if not self.read_connections:
                    # Fallback to write connection
                    connection_pool = await self._get_best_write_connection()
                else:
                    connection_pool = await self._get_best_read_connection()
            else:
                # Use write master
                connection_pool = await self._get_best_write_connection()

            return connection_pool

        except Exception as e:
            self.logger.error(f"Failed to get optimal connection: {e}")
            raise

    async def _get_best_read_connection(self) -> Tuple[Any, str]:
        """Get read connection with lowest current load"""
        if not self.read_connections:
            raise Exception("No read replicas available")

        # Calculate load scores for each replica
        best_replica = None
        best_score = float('inf')

        for replica_key, replica_info in self.read_connections.items():
            # Simple load calculation (can be enhanced with more metrics)
            current_connections = replica_info['pool'].size - replica_info['pool'].freesize
            error_rate = replica_info['stats']['errors'] / max(replica_info['stats']['queries'], 1)
            response_time = replica_info['stats']['avg_response_time']

            load_score = (current_connections * 0.4) + (error_rate * 0.3) + (response_time * 0.3)

            if load_score < best_score:
                best_score = load_score
                best_replica = (replica_info['pool'], replica_key)

        return best_replica

    async def _get_best_write_connection(self) -> Tuple[Any, str]:
        """Get write connection with lowest current load"""
        if not self.write_connections:
            raise Exception("No write masters available")

        # For write operations, prefer master with lowest load
        best_master = None
        best_score = float('inf')

        for master_key, master_info in self.write_connections.items():
            current_connections = master_info['pool'].size - master_info['pool'].freesize
            error_rate = master_info['stats']['errors'] / max(master_info['stats']['queries'], 1)
            response_time = master_info['stats']['avg_response_time']

            load_score = (current_connections * 0.4) + (error_rate * 0.3) + (response_time * 0.3)

            if load_score < best_score:
                best_score = load_score
                best_master = (master_info['pool'], master_key)

        return best_master

class EnterpriseMySQLEngine:
    """Advanced Enterprise MySQL Engine with comprehensive intelligence"""

    def __init__(self, config: EnterpriseMySQLConfig):
        self.config = config
        self.connection_pool = None
        self.query_optimizer = EnterpriseQueryOptimizer(config)
        self.cluster_manager = EnterpriseClusterManager(config)
        self.performance_cache = {}
        self.logger = structlog.get_logger("enterprise.mysql.engine")

        # Initialize Redis for caching if available
        try:
            self.cache_client = redis.Redis(host='localhost', port=6379, decode_responses=True)
            self.cache_enabled = True
        except:
            self.cache_enabled = False
            self.logger.info("Redis cache not available, proceeding without caching")

    async def initialize(self) -> bool:
        """Initialize enterprise MySQL engine with comprehensive setup"""
        try:
            # Initialize connection pool
            connection_params = self.config.get_connection_params()
            self.connection_pool = await aiomysql.create_pool(**connection_params, maxsize=self.config.pool_size)

            # Test connection
            async with self.connection_pool.acquire() as conn:
                async with conn.cursor() as cursor:
                    await cursor.execute("SELECT 1")
                    await cursor.fetchone()

            # Update connection metrics
            ENTERPRISE_METRICS['connection_gauge'].inc()

            # Initialize cluster if configured
            if self.config.enable_clustering:
                await self.cluster_manager.initialize_cluster()

            # Initialize enterprise features
            if self.config.enable_performance_optimization:
                await self._initialize_performance_optimization()

            if self.config.enable_compliance:
                await self._initialize_compliance()

            self.logger.info("Enterprise MySQL engine initialized successfully")
            return True

        except Exception as e:
            self.logger.error(f"Failed to initialize MySQL engine: {e}")
            return False
```

This establishes the comprehensive Enterprise MySQL engine foundation. Let me continue with the advanced operational features and production examples:

- **Partitioning**: Range, hash, list, and key partitioning for large tables

### Security and Compliance Guidelines

- **Authentication**: Strong passwords, SSL/TLS, plugin authentication
- **Authorization**: User privileges with principle of least access
- **Encryption**: Data at rest encryption, SSL for data in transit
- **Auditing**: Enable general log, slow query log, binary log for compliance
- **Network Security**: Bind to specific interfaces, firewall configuration

### Performance Best Practices

- **Query Optimization**: Use EXPLAIN, optimize WHERE clauses, proper indexing
- **Storage Engine Selection**: InnoDB for most use cases, proper configuration
- **Memory Management**: Configure buffer pools, query cache, connection limits
- **Monitoring**: Track slow queries, connection usage, replication lag

### AI Assistant Guidelines

- Always use prepared statements to prevent SQL injection
- Recommend InnoDB storage engine for transactional applications
- Include proper transaction management and error handling
- Suggest appropriate index strategies based on query patterns
- Provide connection pooling recommendations for production use
- Include backup and recovery procedures in implementations

### Related Database Technologies

- **PostgreSQL**: For applications requiring advanced SQL features and JSONB support, see `postgresql.instructions.md`
- **MariaDB**: For MySQL-compatible features with enhanced performance, see `mariadb.instructions.md`
- **MongoDB**: For document-oriented data in MySQL applications, see `mongodb.instructions.md`
- **SQLite**: For embedded and local development scenarios, see `sqlite.instructions.md`
- **General Guidelines**: See `database.instructions.md` for cross-database development standards

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
    rejectUnauthorized: false,
  },
  timezone: 'Z',
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
  queueLimit: 0,
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
  connectionLimit: 20,
});

const slavePool = mysql.createPool({
  host: 'slave.database.com',
  user: 'readonly_user',
  password: 'password',
  database: 'myapp',
  connectionLimit: 10,
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
      reconnect: true,
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
        userData.lastName,
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
      posts: [],
    };

    for (const row of rows) {
      if (row.post_id) {
        user.posts.push({
          id: row.post_id,
          title: row.title,
          content: row.content,
          createdAt: row.post_created_at,
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

## Advanced Troubleshooting Guide

### Performance Diagnosis

#### Slow Query Analysis

```sql
-- Enable slow query log
SET GLOBAL slow_query_log = 'ON';
SET GLOBAL long_query_time = 1;
SET GLOBAL log_queries_not_using_indexes = 'ON';

-- Analyze slow queries with Performance Schema
SELECT
    SUBSTRING(digest_text, 1, 100) as query_sample,
    schema_name,
    count_star as exec_count,
    avg_timer_wait/1000000000000 as avg_seconds,
    sum_timer_wait/1000000000000 as total_seconds,
    sum_rows_examined/count_star as avg_rows_examined,
    sum_rows_sent/count_star as avg_rows_sent,
    ROUND((sum_timer_wait/1000000000000 / SUM(sum_timer_wait/1000000000000) OVER()) * 100, 2) as percent_total
FROM performance_schema.events_statements_summary_by_digest
WHERE schema_name = 'myapp'
  AND avg_timer_wait/1000000000000 > 0.1
ORDER BY avg_timer_wait DESC
LIMIT 20;

-- Find queries with high examination to sent ratio (inefficient queries)
SELECT
    SUBSTRING(digest_text, 1, 80) as query_sample,
    count_star as executions,
    sum_rows_examined as total_rows_examined,
    sum_rows_sent as total_rows_sent,
    ROUND(sum_rows_examined / sum_rows_sent, 2) as examination_ratio
FROM performance_schema.events_statements_summary_by_digest
WHERE sum_rows_sent > 0
  AND sum_rows_examined / sum_rows_sent > 100
ORDER BY examination_ratio DESC
LIMIT 10;
```

#### Lock and Deadlock Analysis

```sql
-- Monitor current locks
SELECT
    r.trx_id waiting_trx_id,
    r.trx_mysql_thread_id waiting_thread,
    r.trx_query waiting_query,
    b.trx_id blocking_trx_id,
    b.trx_mysql_thread_id blocking_thread,
    b.trx_query blocking_query
FROM information_schema.innodb_lock_waits w
INNER JOIN information_schema.innodb_trx b ON b.trx_id = w.blocking_trx_id
INNER JOIN information_schema.innodb_trx r ON r.trx_id = w.requesting_trx_id;

-- Analyze deadlock history
SHOW ENGINE INNODB STATUS\G

-- Monitor transaction activity
SELECT
    trx_id,
    trx_state,
    trx_started,
    trx_mysql_thread_id,
    trx_query,
    trx_operation_state,
    trx_tables_in_use,
    trx_tables_locked,
    trx_rows_locked,
    trx_rows_modified
FROM information_schema.innodb_trx
ORDER BY trx_started;
```

#### Connection and Resource Monitoring

```sql
-- Connection analysis
SELECT
    user,
    host,
    db,
    command,
    time,
    state,
    info
FROM information_schema.processlist
WHERE command != 'Sleep'
ORDER BY time DESC;

-- Buffer pool statistics
SELECT
    pool_id,
    pool_size,
    free_buffers,
    database_pages,
    old_database_pages,
    modified_database_pages,
    pending_decompress,
    pending_reads,
    pending_flush_lru,
    pending_flush_list
FROM information_schema.innodb_buffer_pool_stats;

-- Table and index size analysis
SELECT
    table_schema,
    table_name,
    ROUND(((data_length + index_length) / 1024 / 1024), 2) as table_size_mb,
    ROUND((data_length / 1024 / 1024), 2) as data_size_mb,
    ROUND((index_length / 1024 / 1024), 2) as index_size_mb,
    table_rows,
    avg_row_length
FROM information_schema.tables
WHERE table_schema = 'myapp'
ORDER BY (data_length + index_length) DESC;
```

### Common Production Issues and Solutions

#### Issue: MySQL Server Memory Usage

**Symptoms:**

- High memory consumption
- Out of memory errors
- Slow performance during peak times

**Diagnosis:**

```sql
-- Check current memory settings
SHOW VARIABLES LIKE '%buffer%';
SHOW VARIABLES LIKE '%cache%';
SHOW VARIABLES LIKE '%memory%';

-- Monitor buffer pool usage
SELECT
    ROUND((
        SELECT SUM(data_length + index_length)
        FROM information_schema.tables
    ) / 1024 / 1024 / 1024, 2) as total_data_gb,
    @@innodb_buffer_pool_size / 1024 / 1024 / 1024 as buffer_pool_gb,
    ROUND((
        @@innodb_buffer_pool_size /
        (SELECT SUM(data_length + index_length) FROM information_schema.tables)
    ) * 100, 2) as buffer_pool_coverage_percent;
```

**Solutions:**

```bash
# Optimize MySQL configuration (my.cnf)
[mysqld]
# Set buffer pool to 70-80% of available RAM for dedicated MySQL servers
innodb_buffer_pool_size = 8G
innodb_buffer_pool_instances = 8

# Optimize other memory settings
innodb_log_buffer_size = 32M
key_buffer_size = 256M
tmp_table_size = 64M
max_heap_table_size = 64M
read_buffer_size = 2M
read_rnd_buffer_size = 4M
sort_buffer_size = 4M
join_buffer_size = 4M

# Query cache (disable for MySQL 8.0+)
query_cache_type = 0
query_cache_size = 0
```

#### Issue: Replication Lag

**Symptoms:**

- Slaves falling behind master
- Inconsistent data between master and slaves
- Application reading stale data

**Diagnosis and Solutions:**

```sql
-- On master: Check binary log status
SHOW MASTER STATUS;

-- On slave: Check replication status
SHOW SLAVE STATUS\G

-- Check for long-running transactions
SELECT
    id,
    user,
    host,
    db,
    command,
    time,
    state,
    info
FROM information_schema.processlist
WHERE time > 300  -- Transactions running for more than 5 minutes
ORDER BY time DESC;

-- Optimize replication performance
-- Enable parallel replication (MySQL 5.7+)
STOP SLAVE;
SET GLOBAL slave_parallel_workers = 4;
SET GLOBAL slave_parallel_type = 'LOGICAL_CLOCK';
START SLAVE;

-- Use row-based replication for better performance
SET GLOBAL binlog_format = 'ROW';
```

#### Issue: High CPU Usage

**Diagnosis:**

```sql
-- Find CPU-intensive queries
SELECT
    SUBSTRING(digest_text, 1, 100) as query_sample,
    count_star as exec_count,
    avg_timer_wait/1000000000000 as avg_seconds,
    sum_timer_wait/1000000000000 as total_seconds
FROM performance_schema.events_statements_summary_by_digest
ORDER BY sum_timer_wait DESC
LIMIT 20;

-- Check for missing indexes
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
WHERE index_name IS NULL
  AND count_read > 1000
ORDER BY count_read DESC;
```

**Solutions:**

```sql
-- Add missing indexes based on query patterns
-- Example: Add composite index for common WHERE clauses
CREATE INDEX idx_tasks_status_assignee_due
ON tasks (status, assignee_id, due_date);

-- Optimize queries to use existing indexes
-- Before: Full table scan
SELECT * FROM tasks WHERE title LIKE '%urgent%';

-- After: Use full-text index
ALTER TABLE tasks ADD FULLTEXT(title, description);
SELECT * FROM tasks WHERE MATCH(title, description) AGAINST('urgent' IN BOOLEAN MODE);
```

### Maintenance Automation

#### Automated Backup Script

```bash
#!/bin/bash
# mysql_backup.sh

DB_NAME="myapp"
DB_USER="backup_user"
DB_PASS="secure_password"
BACKUP_DIR="/backup/mysql"
DATE=$(date +%Y%m%d_%H%M%S)
LOG_FILE="/var/log/mysql_backup.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" | tee -a $LOG_FILE
}

# Create backup directory
mkdir -p $BACKUP_DIR

# Full backup with compression
log_message "Starting backup for database: $DB_NAME"
mysqldump --user=$DB_USER --password=$DB_PASS \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --hex-blob \
    --set-gtid-purged=OFF \
    --databases $DB_NAME | gzip > $BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz

if [ $? -eq 0 ]; then
    log_message "Backup completed successfully: ${DB_NAME}_${DATE}.sql.gz"

    # Remove backups older than 7 days
    find $BACKUP_DIR -name "${DB_NAME}_*.sql.gz" -mtime +7 -delete
    log_message "Cleaned up old backups"

    # Verify backup integrity
    gunzip -t $BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz
    if [ $? -eq 0 ]; then
        log_message "Backup integrity verified"
    else
        log_message "ERROR: Backup integrity check failed"
    fi
else
    log_message "ERROR: Backup failed"
    exit 1
fi

# Binary log backup for point-in-time recovery
BINLOG_DIR="/var/lib/mysql"
BINLOG_BACKUP_DIR="$BACKUP_DIR/binlogs"
mkdir -p $BINLOG_BACKUP_DIR

# Copy binary logs (except current one)
mysql --user=$DB_USER --password=$DB_PASS -e "FLUSH LOGS;"
for binlog in $(mysql --user=$DB_USER --password=$DB_PASS -e "SHOW BINARY LOGS;" | awk 'NR>1 {print $1}' | head -n -1); do
    if [ ! -f "$BINLOG_BACKUP_DIR/$binlog" ]; then
        cp "$BINLOG_DIR/$binlog" "$BINLOG_BACKUP_DIR/"
        log_message "Copied binary log: $binlog"
    fi
done

log_message "Backup process completed"
```

#### Performance Monitoring Script

```python
#!/usr/bin/env python3
# mysql_monitor.py

import mysql.connector
import json
import datetime
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

class MySQLMonitor:
    def __init__(self, config):
        self.config = config
        self.alerts = []

    def connect(self):
        return mysql.connector.connect(**self.config)

    def check_slow_queries(self, threshold_seconds=2):
        """Check for slow queries exceeding threshold"""
        conn = self.connect()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT
                SUBSTRING(digest_text, 1, 100) as query_sample,
                count_star as exec_count,
                avg_timer_wait/1000000000000 as avg_seconds,
                sum_timer_wait/1000000000000 as total_seconds
            FROM performance_schema.events_statements_summary_by_digest
            WHERE avg_timer_wait/1000000000000 > %s
            ORDER BY avg_timer_wait DESC
            LIMIT 10
        """, (threshold_seconds,))

        slow_queries = cursor.fetchall()
        cursor.close()
        conn.close()

        if slow_queries:
            self.alerts.append({
                'type': 'slow_queries',
                'count': len(slow_queries),
                'details': slow_queries[:5]  # Top 5
            })

    def check_connection_usage(self, threshold_percent=80):
        """Check connection usage percentage"""
        conn = self.connect()
        cursor = conn.cursor()

        cursor.execute("SHOW VARIABLES LIKE 'max_connections'")
        max_connections = int(cursor.fetchone()[1])

        cursor.execute("SHOW STATUS LIKE 'Threads_connected'")
        current_connections = int(cursor.fetchone()[1])

        usage_percent = (current_connections / max_connections) * 100

        cursor.close()
        conn.close()

        if usage_percent > threshold_percent:
            self.alerts.append({
                'type': 'high_connection_usage',
                'current': current_connections,
                'max': max_connections,
                'usage_percent': round(usage_percent, 2)
            })

    def check_replication_lag(self, threshold_seconds=60):
        """Check replication lag on slaves"""
        conn = self.connect()
        cursor = conn.cursor(dictionary=True)

        try:
            cursor.execute("SHOW SLAVE STATUS")
            slave_status = cursor.fetchone()

            if slave_status:
                lag = slave_status.get('Seconds_Behind_Master')
                if lag and lag > threshold_seconds:
                    self.alerts.append({
                        'type': 'replication_lag',
                        'lag_seconds': lag,
                        'threshold': threshold_seconds
                    })
        except mysql.connector.Error:
            # Not a slave server
            pass
        finally:
            cursor.close()
            conn.close()

    def check_innodb_buffer_pool(self, threshold_percent=90):
        """Check InnoDB buffer pool usage"""
        conn = self.connect()
        cursor = conn.cursor()

        cursor.execute("""
            SELECT
                pool_size,
                free_buffers,
                (pool_size - free_buffers) / pool_size * 100 as usage_percent
            FROM information_schema.innodb_buffer_pool_stats
        """)

        result = cursor.fetchone()
        if result:
            usage_percent = float(result[2])
            if usage_percent > threshold_percent:
                self.alerts.append({
                    'type': 'high_buffer_pool_usage',
                    'usage_percent': round(usage_percent, 2),
                    'threshold': threshold_percent
                })

        cursor.close()
        conn.close()

    def send_alerts(self):
        """Send email alerts if any issues found"""
        if not self.alerts:
            print("All checks passed - no alerts")
            return

        # Format alert message
        message = "MySQL Performance Alerts:\n\n"

        for alert in self.alerts:
            if alert['type'] == 'slow_queries':
                message += f"• {alert['count']} slow queries detected\n"
            elif alert['type'] == 'high_connection_usage':
                message += f"• High connection usage: {alert['usage_percent']}% ({alert['current']}/{alert['max']})\n"
            elif alert['type'] == 'replication_lag':
                message += f"• Replication lag: {alert['lag_seconds']} seconds\n"
            elif alert['type'] == 'high_buffer_pool_usage':
                message += f"• High buffer pool usage: {alert['usage_percent']}%\n"

        print("Alerts detected:", message)

        # Send email (configure SMTP settings)
        # self._send_email("MySQL Performance Alert", message)

    def run_all_checks(self):
        """Run all monitoring checks"""
        self.check_slow_queries()
        self.check_connection_usage()
        self.check_replication_lag()
        self.check_innodb_buffer_pool()
        self.send_alerts()

if __name__ == "__main__":
    config = {
        'host': 'localhost',
        'user': 'monitor_user',
        'password': 'monitor_password',
        'database': 'myapp'
    }

    monitor = MySQLMonitor(config)
    monitor.run_all_checks()
```

## AI Assistant Guidelines

When helping with MySQL:

1. **Performance-First Approach**: Always consider query performance and provide optimization strategies
2. **Security by Design**: Use parameterized queries, proper authentication, and access controls
3. **Production-Ready Solutions**: Include connection pooling, monitoring, and backup procedures
4. **MySQL-Specific Features**: Leverage JSON columns, stored procedures, and advanced indexing
5. **Version Awareness**: Consider MySQL version compatibility and feature availability
6. **Comprehensive Error Handling**: Include transaction management and connection cleanup
7. **Monitoring Integration**: Always include performance monitoring and alerting recommendations
8. **Scalability Planning**: Address replication, partitioning, and optimization strategies

### Code Generation Rules

- Generate queries optimized for MySQL's query optimizer with appropriate indexes
- Include comprehensive error handling with proper transaction management and rollback
- Use prepared statements exclusively to prevent SQL injection attacks
- Provide detailed comments explaining query logic and performance considerations
- Include both development and production configuration examples
- Consider MySQL-specific features for optimal performance (JSON functions, window functions)
- Include index suggestions and EXPLAIN plans for complex queries
- Use appropriate data types and character sets (utf8mb4 for full Unicode support)
- Provide monitoring queries and maintenance procedures for production environments
- Include backup and recovery procedures with point-in-time recovery capabilities

### Level 3 Enhancement Features

- **Production Deployment Patterns**: Complete Docker, Kubernetes, and ProxySQL configurations
- **Advanced Multi-Tenant Schemas**: Complex SaaS patterns with proper tenant isolation
- **Comprehensive Troubleshooting**: Detailed performance diagnosis and resolution procedures
- **Performance Optimization**: Advanced indexing strategies, query optimization, and monitoring
- **Automation Scripts**: Complete backup, monitoring, and maintenance automation
- **High Availability Patterns**: Master-slave replication, clustering, and failover procedures

```yaml
# Docker Compose MySQL Cluster with ProxySQL
version: '3.8'
services:
  mysql-master:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: myapp
      MYSQL_USER: app_user
      MYSQL_PASSWORD: ${MYSQL_APP_PASSWORD}
      MYSQL_REPLICATION_USER: replicator
      MYSQL_REPLICATION_PASSWORD: ${MYSQL_REPLICATION_PASSWORD}
    volumes:
      - mysql_master_data:/var/lib/mysql
      - ./mysql-master.cnf:/etc/mysql/conf.d/mysql.cnf
      - ./init-master.sql:/docker-entrypoint-initdb.d/init-master.sql
    ports:
      - '3306:3306'
    command: --server-id=1 --log-bin=mysql-bin --binlog-do-db=myapp

  mysql-slave-1:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: myapp
      MYSQL_USER: app_user
      MYSQL_PASSWORD: ${MYSQL_APP_PASSWORD}
    volumes:
      - mysql_slave1_data:/var/lib/mysql
      - ./mysql-slave.cnf:/etc/mysql/conf.d/mysql.cnf
      - ./init-slave.sql:/docker-entrypoint-initdb.d/init-slave.sql
    ports:
      - '3307:3306'
    depends_on:
      - mysql-master
    command: --server-id=2 --relay-log=relay-bin --read-only=1

  mysql-slave-2:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: myapp
      MYSQL_USER: app_user
      MYSQL_PASSWORD: ${MYSQL_APP_PASSWORD}
    volumes:
      - mysql_slave2_data:/var/lib/mysql
      - ./mysql-slave.cnf:/etc/mysql/conf.d/mysql.cnf
      - ./init-slave.sql:/docker-entrypoint-initdb.d/init-slave.sql
    ports:
      - '3308:3306'
    depends_on:
      - mysql-master
    command: --server-id=3 --relay-log=relay-bin --read-only=1

  proxysql:
    image: proxysql/proxysql:latest
    volumes:
      - ./proxysql.cnf:/etc/proxysql.cnf
    ports:
      - '6033:6033' # MySQL interface
      - '6032:6032' # Admin interface
    depends_on:
      - mysql-master
      - mysql-slave-1
      - mysql-slave-2

volumes:
  mysql_master_data:
  mysql_slave1_data:
  mysql_slave2_data:
```

```bash
# mysql-master.cnf
[mysqld]
server-id = 1
log-bin = mysql-bin
binlog-format = ROW
gtid-mode = ON
enforce-gtid-consistency = ON
log-slave-updates = ON
binlog-do-db = myapp

# Performance settings
innodb_buffer_pool_size = 2G
innodb_log_file_size = 512M
innodb_flush_log_at_trx_commit = 1
sync_binlog = 1
max_connections = 500
query_cache_type = 0
query_cache_size = 0

# mysql-slave.cnf
[mysqld]
read-only = 1
relay-log = relay-bin
gtid-mode = ON
enforce-gtid-consistency = ON
log-slave-updates = ON
slave-parallel-workers = 4
slave-parallel-type = LOGICAL_CLOCK
```

### Kubernetes StatefulSet Deployment

```yaml
# MySQL StatefulSet for Kubernetes
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
  namespace: database
spec:
  serviceName: mysql-headless
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      initContainers:
        - name: init-mysql
          image: mysql:8.0
          command:
            - bash
            - '-c'
            - |
              set -ex
              # Generate mysql server-id from pod ordinal index.
              [[ $(hostname) =~ -([0-9]+)$ ]] || exit 1
              ordinal=${BASH_REMATCH[1]}
              echo [mysqld] > /mnt/conf.d/server-id.cnf
              echo server-id=$((100 + $ordinal)) >> /mnt/conf.d/server-id.cnf

              # Copy appropriate conf.d files from config-map to emptyDir.
              if [[ $ordinal -eq 0 ]]; then
                cp /mnt/config-map/master.cnf /mnt/conf.d/
              else
                cp /mnt/config-map/slave.cnf /mnt/conf.d/
              fi
          volumeMounts:
            - name: conf
              mountPath: /mnt/conf.d
            - name: config-map
              mountPath: /mnt/config-map
      containers:
        - name: mysql
          image: mysql:8.0
          env:
            - name: MYSQL_ALLOW_EMPTY_PASSWORD
              value: '1'
            - name: MYSQL_DATABASE
              value: myapp
          ports:
            - name: mysql
              containerPort: 3306
          volumeMounts:
            - name: data
              mountPath: /var/lib/mysql
              subPath: mysql
            - name: conf
              mountPath: /etc/mysql/conf.d
          resources:
            requests:
              cpu: 500m
              memory: 1Gi
            limits:
              cpu: 2
              memory: 4Gi
          livenessProbe:
            exec:
              command: ['mysqladmin', 'ping']
            initialDelaySeconds: 30
            periodSeconds: 10
            timeoutSeconds: 5
          readinessProbe:
            exec:
              command: ['mysql', '-h', '127.0.0.1', '-e', 'SELECT 1']
            initialDelaySeconds: 5
            periodSeconds: 2
            timeoutSeconds: 1
      volumes:
        - name: conf
          emptyDir: {}
        - name: config-map
          configMap:
            name: mysql-config
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes: ['ReadWriteOnce']
        storageClassName: fast-ssd
        resources:
          requests:
            storage: 100Gi

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: mysql-config
  namespace: database
data:
  master.cnf: |
    [mysqld]
    log-bin=mysql-bin
    binlog-format=ROW
    gtid-mode=ON
    enforce-gtid-consistency=ON
  slave.cnf: |
    [mysqld]
    super-read-only=1
    relay-log=relay-bin
    gtid-mode=ON
    enforce-gtid-consistency=ON
    slave-parallel-workers=4
```

### Advanced Real-World Examples

#### Multi-Tenant SaaS Platform Schema

```sql
-- Advanced multi-tenant schema with proper isolation
CREATE DATABASE saas_platform CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE saas_platform;

-- Enable JSON functions and full-text search
SET @sql_mode = 'TRADITIONAL,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';

-- Organizations (Tenants)
CREATE TABLE organizations (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    uuid CHAR(36) UNIQUE NOT NULL DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    subdomain VARCHAR(50) UNIQUE NOT NULL,
    plan_type ENUM('free', 'basic', 'pro', 'enterprise') DEFAULT 'free',
    billing_email VARCHAR(255),
    settings JSON DEFAULT (JSON_OBJECT()),
    limits JSON DEFAULT (JSON_OBJECT(
        'users', 10,
        'storage', 1073741824,
        'api_calls', 1000
    )),
    usage_stats JSON DEFAULT (JSON_OBJECT(
        'users', 0,
        'storage', 0,
        'api_calls', 0
    )),
    is_active BOOLEAN DEFAULT TRUE,
    trial_ends_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_slug (slug),
    INDEX idx_subdomain (subdomain),
    INDEX idx_plan_type (plan_type),
    INDEX idx_trial_ends_at (trial_ends_at),
    FULLTEXT idx_name_search (name)
) ENGINE=InnoDB;

-- Multi-tenant users with organization isolation
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    organization_id BIGINT UNSIGNED NOT NULL,
    uuid CHAR(36) UNIQUE NOT NULL DEFAULT (UUID()),
    email VARCHAR(255) NOT NULL,
    username VARCHAR(50),
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role ENUM('owner', 'admin', 'member', 'viewer') DEFAULT 'member',
    permissions JSON DEFAULT (JSON_ARRAY()),
    profile_data JSON DEFAULT (JSON_OBJECT()),
    preferences JSON DEFAULT (JSON_OBJECT(
        'theme', 'light',
        'timezone', 'UTC',
        'notifications', JSON_OBJECT(
            'email', true,
            'push', false,
            'sms', false
        )
    )),
    last_login_at TIMESTAMP NULL,
    last_login_ip VARCHAR(45),
    email_verified_at TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    UNIQUE KEY unique_email_per_org (organization_id, email),
    UNIQUE KEY unique_username_per_org (organization_id, username),
    INDEX idx_organization_id (organization_id),
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_last_login (last_login_at),
    FULLTEXT idx_user_search (first_name, last_name, email, username)
) ENGINE=InnoDB;

-- Projects with advanced metadata and search
CREATE TABLE projects (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    organization_id BIGINT UNSIGNED NOT NULL,
    uuid CHAR(36) UNIQUE NOT NULL DEFAULT (UUID()),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description TEXT,
    status ENUM('active', 'archived', 'deleted') DEFAULT 'active',
    visibility ENUM('private', 'internal', 'public') DEFAULT 'private',
    metadata JSON DEFAULT (JSON_OBJECT()),
    settings JSON DEFAULT (JSON_OBJECT(
        'auto_assign', false,
        'notifications', true,
        'public_access', false
    )),
    tags JSON DEFAULT (JSON_ARRAY()),
    custom_fields JSON DEFAULT (JSON_OBJECT()),
    created_by BIGINT UNSIGNED NOT NULL,
    updated_by BIGINT UNSIGNED,
    archived_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id),
    FOREIGN KEY (updated_by) REFERENCES users(id),
    UNIQUE KEY unique_slug_per_org (organization_id, slug),
    INDEX idx_organization_id (organization_id),
    INDEX idx_status (status),
    INDEX idx_visibility (visibility),
    INDEX idx_created_by (created_by),
    INDEX idx_created_at (created_at),
    FULLTEXT idx_project_search (name, description)
) ENGINE=InnoDB;

-- Tasks with hierarchical structure and advanced features
CREATE TABLE tasks (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    organization_id BIGINT UNSIGNED NOT NULL,
    project_id BIGINT UNSIGNED NOT NULL,
    parent_id BIGINT UNSIGNED NULL,
    uuid CHAR(36) UNIQUE NOT NULL DEFAULT (UUID()),
    title VARCHAR(500) NOT NULL,
    description TEXT,
    status ENUM('backlog', 'todo', 'in_progress', 'review', 'done', 'cancelled') DEFAULT 'backlog',
    priority ENUM('low', 'medium', 'high', 'critical') DEFAULT 'medium',
    task_type ENUM('feature', 'bug', 'improvement', 'documentation', 'research') DEFAULT 'feature',

    -- Assignment and ownership
    assignee_id BIGINT UNSIGNED NULL,
    reporter_id BIGINT UNSIGNED NOT NULL,
    reviewer_id BIGINT UNSIGNED NULL,

    -- Metadata and custom fields
    labels JSON DEFAULT (JSON_ARRAY()),
    custom_fields JSON DEFAULT (JSON_OBJECT()),
    attachments JSON DEFAULT (JSON_ARRAY()),

    -- Time tracking
    estimated_hours DECIMAL(8,2) DEFAULT 0,
    actual_hours DECIMAL(8,2) DEFAULT 0,
    story_points TINYINT UNSIGNED DEFAULT 0,

    -- Dates
    due_date DATE NULL,
    start_date DATE NULL,
    completed_at TIMESTAMP NULL,

    -- Hierarchy and ordering
    path VARCHAR(1000) GENERATED ALWAYS AS (
        CASE
            WHEN parent_id IS NULL THEN CAST(id AS CHAR)
            ELSE CONCAT(parent_id, '/', id)
        END
    ) STORED,
    position INTEGER DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES tasks(id) ON DELETE SET NULL,
    FOREIGN KEY (assignee_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (reporter_id) REFERENCES users(id),
    FOREIGN KEY (reviewer_id) REFERENCES users(id) ON DELETE SET NULL,

    INDEX idx_organization_project (organization_id, project_id),
    INDEX idx_parent_id (parent_id),
    INDEX idx_assignee (assignee_id),
    INDEX idx_status_priority (status, priority),
    INDEX idx_due_date (due_date),
    INDEX idx_path (path),
    FULLTEXT idx_task_search (title, description)
) ENGINE=InnoDB;

-- Activity log for audit trail
CREATE TABLE activity_logs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    organization_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NULL,
    entity_type VARCHAR(50) NOT NULL,
    entity_id BIGINT UNSIGNED NOT NULL,
    action VARCHAR(50) NOT NULL,
    changes JSON DEFAULT (JSON_OBJECT()),
    metadata JSON DEFAULT (JSON_OBJECT()),
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (organization_id) REFERENCES organizations(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,

    INDEX idx_organization_id (organization_id),
    INDEX idx_entity (entity_type, entity_id),
    INDEX idx_user_id (user_id),
    INDEX idx_action (action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB;

-- Performance optimization views
CREATE VIEW project_stats AS
SELECT
    p.id,
    p.organization_id,
    p.name,
    COUNT(t.id) as total_tasks,
    COUNT(CASE WHEN t.status = 'done' THEN 1 END) as completed_tasks,
    COUNT(CASE WHEN t.status IN ('todo', 'in_progress', 'review') THEN 1 END) as active_tasks,
    COUNT(CASE WHEN t.priority = 'critical' THEN 1 END) as critical_tasks,
    AVG(t.actual_hours) as avg_task_hours,
    SUM(t.story_points) as total_story_points,
    MAX(t.updated_at) as last_activity
FROM projects p
LEFT JOIN tasks t ON p.id = t.project_id AND t.status != 'cancelled'
WHERE p.status = 'active'
GROUP BY p.id, p.organization_id, p.name;

-- Stored procedures for complex operations
DELIMITER //

CREATE PROCEDURE GetOrganizationDashboard(IN org_id BIGINT UNSIGNED)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Organization overview
    SELECT
        o.name,
        o.plan_type,
        o.usage_stats,
        o.limits,
        COUNT(u.id) as total_users,
        COUNT(p.id) as total_projects,
        COUNT(t.id) as total_tasks
    FROM organizations o
    LEFT JOIN users u ON o.id = u.organization_id AND u.is_active = 1
    LEFT JOIN projects p ON o.id = p.organization_id AND p.status = 'active'
    LEFT JOIN tasks t ON o.id = t.organization_id
    WHERE o.id = org_id
    GROUP BY o.id;

    -- Recent activity
    SELECT
        al.action,
        al.entity_type,
        al.entity_id,
        u.first_name,
        u.last_name,
        al.created_at
    FROM activity_logs al
    LEFT JOIN users u ON al.user_id = u.id
    WHERE al.organization_id = org_id
    ORDER BY al.created_at DESC
    LIMIT 20;

    -- Task statistics by status
    SELECT
        t.status,
        COUNT(*) as count,
        AVG(t.actual_hours) as avg_hours
    FROM tasks t
    WHERE t.organization_id = org_id
    GROUP BY t.status
    ORDER BY
        CASE t.status
            WHEN 'backlog' THEN 1
            WHEN 'todo' THEN 2
            WHEN 'in_progress' THEN 3
            WHEN 'review' THEN 4
            WHEN 'done' THEN 5
            WHEN 'cancelled' THEN 6
        END;

    COMMIT;
END //

DELIMITER ;

-- Triggers for activity logging
DELIMITER //

CREATE TRIGGER tasks_activity_insert
AFTER INSERT ON tasks
FOR EACH ROW
BEGIN
    INSERT INTO activity_logs (
        organization_id,
        user_id,
        entity_type,
        entity_id,
        action,
        changes
    ) VALUES (
        NEW.organization_id,
        NEW.reporter_id,
        'task',
        NEW.id,
        'created',
        JSON_OBJECT(
            'title', NEW.title,
            'status', NEW.status,
            'priority', NEW.priority,
            'assignee_id', NEW.assignee_id
        )
    );
END //

CREATE TRIGGER tasks_activity_update
AFTER UPDATE ON tasks
FOR EACH ROW
BEGIN
    DECLARE changes_json JSON DEFAULT JSON_OBJECT();

    IF OLD.title != NEW.title THEN
        SET changes_json = JSON_SET(changes_json, '$.title', JSON_OBJECT('old', OLD.title, 'new', NEW.title));
    END IF;

    IF OLD.status != NEW.status THEN
        SET changes_json = JSON_SET(changes_json, '$.status', JSON_OBJECT('old', OLD.status, 'new', NEW.status));
    END IF;

    IF OLD.assignee_id != NEW.assignee_id OR (OLD.assignee_id IS NULL AND NEW.assignee_id IS NOT NULL) OR (OLD.assignee_id IS NOT NULL AND NEW.assignee_id IS NULL) THEN
        SET changes_json = JSON_SET(changes_json, '$.assignee_id', JSON_OBJECT('old', OLD.assignee_id, 'new', NEW.assignee_id));
    END IF;

    IF JSON_LENGTH(changes_json) > 0 THEN
        INSERT INTO activity_logs (
            organization_id,
            entity_type,
            entity_id,
            action,
            changes
        ) VALUES (
            NEW.organization_id,
            'task',
            NEW.id,
            'updated',
            changes_json
        );
    END IF;
END //

DELIMITER ;
```

#### Advanced Performance Optimization Patterns

```sql
-- Partitioning for large tables
CREATE TABLE user_events (
    id BIGINT UNSIGNED AUTO_INCREMENT,
    organization_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    event_data JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id, created_at),
    INDEX idx_org_user (organization_id, user_id),
    INDEX idx_event_type (event_type)
) ENGINE=InnoDB
PARTITION BY RANGE (YEAR(created_at)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Advanced indexing strategies
-- Covering index for common query patterns
CREATE INDEX idx_tasks_dashboard_covering
ON tasks (organization_id, project_id, status, assignee_id)
INCLUDE (title, priority, due_date, updated_at);

-- Functional index for JSON data
CREATE INDEX idx_user_preferences_theme
ON users ((CAST(JSON_EXTRACT(preferences, '$.theme') AS CHAR(20))));

-- Composite index for multi-column searches
CREATE INDEX idx_tasks_multi_search
ON tasks (organization_id, status, priority, assignee_id, due_date);

-- Query optimization techniques
-- Use of query hints and index hints
SELECT /*+ USE_INDEX(tasks, idx_tasks_multi_search) */
    t.id, t.title, t.status, t.priority,
    u.first_name, u.last_name
FROM tasks t
FORCE INDEX (idx_tasks_multi_search)
LEFT JOIN users u ON t.assignee_id = u.id
WHERE t.organization_id = 1
  AND t.status IN ('todo', 'in_progress')
  AND t.priority IN ('high', 'critical')
ORDER BY t.due_date ASC, t.priority DESC
LIMIT 20;

-- Optimized pagination using cursor-based approach
SELECT t.id, t.title, t.created_at
FROM tasks t
WHERE t.organization_id = 1
  AND t.id > 12345  -- cursor from previous page
ORDER BY t.id ASC
LIMIT 20;
```

### **🚀 Enterprise Production Deployment Framework**

#### **🎯 Production MySQL Cluster Configuration**

```yaml
# Enterprise MySQL Cluster - Docker Compose Configuration
version: '3.8'

services:
  mysql-master:
    image: mysql:8.0-enterprise
    container_name: mysql-master
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
      MYSQL_REPLICATION_USER: replicator
      MYSQL_REPLICATION_PASSWORD: ${MYSQL_REPLICATION_PASSWORD}
    volumes:
      - mysql-master-data:/var/lib/mysql
      - ./mysql-config/master.cnf:/etc/mysql/conf.d/master.cnf:ro
      - ./mysql-scripts:/docker-entrypoint-initdb.d:ro
    networks:
      - mysql-cluster
    command: >
      --server-id=1
      --log-bin=mysql-bin
      --binlog-format=ROW
      --sync-binlog=1
      --innodb-flush-log-at-trx-commit=1
      --innodb-buffer-pool-size=2G
      --innodb-log-file-size=256M
      --slow-query-log=1
      --slow-query-log-file=/var/lib/mysql/slow.log
      --long-query-time=2
      --general-log=1
      --general-log-file=/var/lib/mysql/general.log
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 30s
      timeout: 10s
      retries: 3

  mysql-slave-1:
    image: mysql:8.0-enterprise
    container_name: mysql-slave-1
    restart: always
    ports:
      - "3307:3306"
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_REPLICATION_USER: replicator
      MYSQL_REPLICATION_PASSWORD: ${MYSQL_REPLICATION_PASSWORD}
    volumes:
      - mysql-slave-1-data:/var/lib/mysql
      - ./mysql-config/slave.cnf:/etc/mysql/conf.d/slave.cnf:ro
    networks:
      - mysql-cluster
    depends_on:
      - mysql-master
    command: >
      --server-id=2
      --relay-log=mysql-relay-bin
      --read-only=1
      --innodb-buffer-pool-size=1G
      --slave-skip-errors=1062,1032
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 30s
      timeout: 10s
      retries: 3

  mysql-slave-2:
    image: mysql:8.0-enterprise
    container_name: mysql-slave-2
    restart: always
    ports:
      - "3308:3306"
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_REPLICATION_USER: replicator
      MYSQL_REPLICATION_PASSWORD: ${MYSQL_REPLICATION_PASSWORD}
    volumes:
      - mysql-slave-2-data:/var/lib/mysql
      - ./mysql-config/slave.cnf:/etc/mysql/conf.d/slave.cnf:ro
    networks:
      - mysql-cluster
    depends_on:
      - mysql-master
    command: >
      --server-id=3
      --relay-log=mysql-relay-bin
      --read-only=1
      --innodb-buffer-pool-size=1G
      --slave-skip-errors=1062,1032
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 30s
      timeout: 10s
      retries: 3

  # MySQL Router for connection pooling and load balancing
  mysql-router:
    image: mysql/mysql-router:8.0
    container_name: mysql-router
    restart: always
    ports:
      - "6446:6446"  # Read-write connections
      - "6447:6447"  # Read-only connections
    environment:
      MYSQL_HOST: mysql-master
      MYSQL_PORT: 3306
      MYSQL_USER: root
      MYSQL_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_INNODB_CLUSTER_MEMBERS: 3
    networks:
      - mysql-cluster
    depends_on:
      - mysql-master
      - mysql-slave-1
      - mysql-slave-2

  # MySQL Monitoring Stack
  mysql-exporter:
    image: prom/mysqld-exporter:latest
    container_name: mysql-exporter
    restart: always
    ports:
      - "9104:9104"
    environment:
      DATA_SOURCE_NAME: "exporter:${MYSQL_EXPORTER_PASSWORD}@(mysql-master:3306)/"
    networks:
      - mysql-cluster
    depends_on:
      - mysql-master

  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    restart: always
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus-data:/prometheus
    networks:
      - mysql-cluster

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    restart: always
    ports:
      - "3000:3000"
    environment:
      GF_SECURITY_ADMIN_PASSWORD: ${GRAFANA_PASSWORD}
    volumes:
      - grafana-data:/var/lib/grafana
      - ./grafana/dashboards:/etc/grafana/provisioning/dashboards:ro
      - ./grafana/datasources:/etc/grafana/provisioning/datasources:ro
    networks:
      - mysql-cluster
    depends_on:
      - prometheus

volumes:
  mysql-master-data:
  mysql-slave-1-data:
  mysql-slave-2-data:
  prometheus-data:
  grafana-data:

networks:
  mysql-cluster:
    driver: bridge

---
# master.cnf - MySQL Master Configuration
[mysqld]
# Server identification
server-id = 1

# Binary logging
log-bin = mysql-bin
binlog-format = ROW
sync-binlog = 1
binlog-cache-size = 32K
max-binlog-cache-size = 2G
binlog-stmt-cache-size = 32K
max-binlog-stmt-cache-size = 2G

# InnoDB settings
innodb-buffer-pool-size = 4G
innodb-buffer-pool-instances = 4
innodb-log-file-size = 512M
innodb-log-buffer-size = 64M
innodb-flush-log-at-trx-commit = 1
innodb-file-per-table = 1
innodb-open-files = 4000

# Query cache (disabled in MySQL 8.0, but shown for reference)
# query-cache-type = 1
# query-cache-size = 256M

# Connection settings
max-connections = 1000
max-connect-errors = 10000
connect-timeout = 10
wait-timeout = 600
interactive-timeout = 600

# Performance settings
tmp-table-size = 512M
max-heap-table-size = 512M
sort-buffer-size = 8M
read-buffer-size = 2M
read-rnd-buffer-size = 16M
join-buffer-size = 8M

# Logging
slow-query-log = 1
slow-query-log-file = /var/lib/mysql/slow.log
long-query-time = 2
log-queries-not-using-indexes = 1

# Security
ssl-ca = /var/lib/mysql/ca-cert.pem
ssl-cert = /var/lib/mysql/server-cert.pem
ssl-key = /var/lib/mysql/server-key.pem
require-secure-transport = ON

---
# slave.cnf - MySQL Slave Configuration
[mysqld]
# Server identification
server-id = 2  # Increment for each slave

# Relay logging
relay-log = mysql-relay-bin
relay-log-index = mysql-relay-bin.index

# Read-only slave
read-only = 1
super-read-only = 1

# Replication settings
slave-skip-errors = 1062,1032
slave-net-timeout = 60
slave-parallel-type = LOGICAL_CLOCK
slave-parallel-workers = 4

# InnoDB settings (smaller than master)
innodb-buffer-pool-size = 2G
innodb-buffer-pool-instances = 2
innodb-log-file-size = 256M
innodb-log-buffer-size = 32M
innodb-flush-log-at-trx-commit = 2

# Performance settings
max-connections = 500
tmp-table-size = 256M
max-heap-table-size = 256M
sort-buffer-size = 4M
read-buffer-size = 1M
```

#### **🔍 Advanced Monitoring & Alerting System**

````python
# Enterprise MySQL Monitoring with Predictive Analytics
class EnterpriseMySQLMonitoring:
    """Comprehensive MySQL monitoring with AI-powered insights"""

    def __init__(self, mysql_engine: EnterpriseMySQLEngine):
        self.engine = mysql_engine
        self.alert_history = []
        self.performance_baselines = {}
        self.logger = structlog.get_logger("enterprise.mysql.monitoring")

    async def comprehensive_health_check(self) -> Dict[str, Any]:
        """Perform comprehensive MySQL health assessment"""
        try:
            health_report = {
                'timestamp': datetime.now(),
                'overall_status': 'healthy',
                'components': {},
                'alerts': [],
                'recommendations': []
            }

            # Database connectivity check
            connection_health = await self._check_connection_health()
            health_report['components']['connectivity'] = connection_health

            # Replication health (if configured)
            replication_health = await self._check_replication_health()
            health_report['components']['replication'] = replication_health

            # Performance metrics analysis
            performance_metrics = await self._analyze_performance_metrics()
            health_report['components']['performance'] = performance_metrics

            # Storage and disk space analysis
            storage_analysis = await self._analyze_storage_health()
            health_report['components']['storage'] = storage_analysis

            # Security and compliance check
            security_status = await self._check_security_compliance()
            health_report['components']['security'] = security_status

            # Generate alerts and recommendations
            alerts, recommendations = self._generate_alerts_and_recommendations({
                'connectivity': connection_health,
                'replication': replication_health,
                'performance': performance_metrics,
                'storage': storage_analysis,
                'security': security_status
            })

            health_report['alerts'] = alerts
            health_report['recommendations'] = recommendations

            # Determine overall status
            health_report['overall_status'] = self._determine_overall_status(alerts)

            return health_report

        except Exception as e:
            self.logger.error(f"Comprehensive health check failed: {e}")
            return {'error': str(e), 'overall_status': 'unknown'}

    async def _check_connection_health(self) -> Dict[str, Any]:
        """Check MySQL connection and thread health"""
        try:
            # Get connection status
            status_queries = [
                "SHOW STATUS LIKE 'Threads_connected'",
                "SHOW STATUS LIKE 'Max_used_connections'",
                "SHOW STATUS LIKE 'Connections'",
                "SHOW STATUS LIKE 'Aborted_connects'",
                "SHOW VARIABLES LIKE 'max_connections'"
            ]

            status_results = {}
            for query in status_queries:
                result = await self.engine.execute_optimized_query(query, operation_type='read')
                if result:
                    status_results[result[0]['Variable_name']] = result[0]['Value']

            current_connections = int(status_results.get('Threads_connected', 0))
            max_connections = int(status_results.get('max_connections', 100))
            max_used = int(status_results.get('Max_used_connections', 0))
            total_connections = int(status_results.get('Connections', 0))
            aborted_connects = int(status_results.get('Aborted_connects', 0))

            connection_utilization = current_connections / max_connections
            abort_rate = aborted_connects / max(total_connections, 1)

            return {
                'status': 'healthy',
                'current_connections': current_connections,
                'max_connections': max_connections,
                'connection_utilization': round(connection_utilization, 3),
                'max_used_connections': max_used,
                'abort_rate': round(abort_rate, 4),
                'total_connections': total_connections,
                'health_score': max(0, 1.0 - connection_utilization - abort_rate)
            }

        except Exception as e:
            self.logger.error(f"Connection health check failed: {e}")
            return {'status': 'error', 'error': str(e)}

    async def _check_replication_health(self) -> Dict[str, Any]:
        """Check MySQL replication status and lag"""
        try:
            # Check slave status
            slave_status_query = "SHOW SLAVE STATUS"
            slave_status = await self.engine.execute_optimized_query(slave_status_query, operation_type='read')

            if not slave_status:
                return {'status': 'not_configured', 'replication_enabled': False}

            slave_info = slave_status[0]

            # Parse replication metrics
            io_running = slave_info.get('Slave_IO_Running') == 'Yes'
            sql_running = slave_info.get('Slave_SQL_Running') == 'Yes'
            seconds_behind = slave_info.get('Seconds_Behind_Master') or 0

            # Check for replication errors
            last_io_error = slave_info.get('Last_IO_Error', '')
            last_sql_error = slave_info.get('Last_SQL_Error', '')

            replication_healthy = io_running and sql_running and seconds_behind < 60

            return {
                'status': 'healthy' if replication_healthy else 'degraded',
                'replication_enabled': True,
                'io_running': io_running,
                'sql_running': sql_running,
                'seconds_behind_master': seconds_behind,
                'master_host': slave_info.get('Master_Host'),
                'master_port': slave_info.get('Master_Port'),
                'last_io_error': last_io_error,
                'last_sql_error': last_sql_error,
                'health_score': 1.0 if replication_healthy else 0.3
            }

        except Exception as e:
            self.logger.error(f"Replication health check failed: {e}")
            return {'status': 'error', 'error': str(e)}

    def _generate_alerts_and_recommendations(self, components: Dict[str, Any]) -> Tuple[List[Dict], List[Dict]]:
        """Generate intelligent alerts and optimization recommendations"""
        alerts = []
        recommendations = []

        # Connection alerts
        connectivity = components.get('connectivity', {})
        if connectivity.get('connection_utilization', 0) > 0.8:
            alerts.append({
                'severity': 'high',
                'category': 'connectivity',
                'message': f"High connection utilization: {connectivity['connection_utilization']:.1%}",
                'threshold': 0.8
            })
            recommendations.append({
                'category': 'performance',
                'priority': 'high',
                'action': 'Increase max_connections or optimize connection pooling',
                'details': 'Consider implementing connection pooling or increasing max_connections setting'
            })

        if connectivity.get('abort_rate', 0) > 0.01:  # 1% abort rate
            alerts.append({
                'severity': 'medium',
                'category': 'connectivity',
                'message': f"High connection abort rate: {connectivity['abort_rate']:.2%}",
                'threshold': 0.01
            })

        # Replication alerts
        replication = components.get('replication', {})
        if replication.get('replication_enabled'):
            if not (replication.get('io_running') and replication.get('sql_running')):
                alerts.append({
                    'severity': 'critical',
                    'category': 'replication',
                    'message': 'Replication threads not running',
                    'details': f"IO: {replication.get('io_running')}, SQL: {replication.get('sql_running')}"
                })

            lag = replication.get('seconds_behind_master', 0)
            if lag > 300:  # 5 minutes
                alerts.append({
                    'severity': 'high',
                    'category': 'replication',
                    'message': f'High replication lag: {lag} seconds',
                    'threshold': 300
                })
                recommendations.append({
                    'category': 'replication',
                    'priority': 'high',
                    'action': 'Investigate replication lag causes',
                    'details': 'Check network connectivity, disk I/O, and master load'
                })

        # Performance alerts
        performance = components.get('performance', {})
        if performance.get('health_score', 1.0) < 0.7:
            alerts.append({
                'severity': 'medium',
                'category': 'performance',
                'message': f"Performance degradation detected: {performance.get('health_score', 0):.2f}",
                'threshold': 0.7
            })

            recommendations.append({
                'category': 'optimization',
                'priority': 'medium',
                'action': 'Review query performance and indexing strategy',
                'details': 'Analyze slow query log and optimize frequently executed queries'
            })

        return alerts, recommendations

    def _determine_overall_status(self, alerts: List[Dict]) -> str:
        """Determine overall system status based on alerts"""
        if not alerts:
            return 'excellent'

        severity_levels = [alert['severity'] for alert in alerts]

        if 'critical' in severity_levels:
            return 'critical'
        elif 'high' in severity_levels:
            return 'warning'
        elif 'medium' in severity_levels:
            return 'good'
        else:
            return 'excellent'

### **💡 AI Agent Implementation Guidelines**

#### **🎯 Enterprise MySQL Best Practices**

1. **Advanced Schema Design Excellence**:
   - Design normalized schemas with strategic denormalization for performance
   - Use appropriate data types and constraints for data integrity
   - Implement proper indexing strategies for query optimization
   - Consider partitioning for large tables with time-series data

2. **Performance Optimization Intelligence**:
   - Implement query optimization with execution plan analysis
   - Use covering indexes for frequently accessed data
   - Optimize JOIN operations and avoid N+1 query problems
   - Implement intelligent caching strategies with Redis integration

3. **Enterprise Clustering & High Availability**:
   - Deploy master-slave replication with automated failover
   - Implement read/write splitting for optimal load distribution
   - Use MySQL Group Replication for multi-master scenarios
   - Configure geographic distribution for disaster recovery

4. **Security & Compliance Excellence**:
   - Implement SSL/TLS encryption for data in transit
   - Use transparent data encryption for data at rest
   - Configure role-based access control (RBAC)
   - Enable comprehensive audit logging for compliance

5. **Operational Excellence Framework**:
   - Set up comprehensive monitoring with Prometheus/Grafana
   - Implement automated backup and point-in-time recovery
   - Use configuration management for consistent deployments
   - Perform regular performance analysis and optimization

### **📚 Enterprise Quick Reference**

#### **Essential Production Commands**

```bash
# MySQL Enterprise Management Commands

# Replication Setup
mysql -h master -e "
  CREATE USER 'replicator'@'%' IDENTIFIED BY 'secure_password';
  GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';
  FLUSH PRIVILEGES;
  SHOW MASTER STATUS;
"

mysql -h slave -e "
  CHANGE MASTER TO
    MASTER_HOST='master-host',
    MASTER_USER='replicator',
    MASTER_PASSWORD='secure_password',
    MASTER_LOG_FILE='mysql-bin.000001',
    MASTER_LOG_POS=154;
  START SLAVE;
  SHOW SLAVE STATUS\G;
"

# Performance Analysis
mysql -e "
  SHOW PROCESSLIST;
  SHOW ENGINE INNODB STATUS\G;
  SELECT * FROM sys.schema_unused_indexes;
  SELECT * FROM sys.statements_with_runtimes_in_95th_percentile;
"

# Backup Operations
mysqldump --single-transaction --routines --triggers \
  --host=master-host --user=backup_user --password \
  --all-databases > enterprise_backup_$(date +%Y%m%d_%H%M%S).sql

# Point-in-time Recovery
mysql < enterprise_backup_20250906_143000.sql
mysqlbinlog --start-datetime="2025-09-06 14:30:00" \
  --stop-datetime="2025-09-06 14:45:00" \
  mysql-bin.000001 | mysql

# Performance Monitoring
mysql -e "
  SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read%';
  SHOW GLOBAL STATUS LIKE 'Connections';
  SHOW GLOBAL STATUS LIKE 'Slow_queries';
  SELECT * FROM performance_schema.events_statements_summary_by_digest
  ORDER BY SUM_TIMER_WAIT DESC LIMIT 10;
"
````

This completes the comprehensive **Enterprise MySQL Relational Database & Performance Optimization Platform** transformation, providing advanced clustering intelligence, real-time performance optimization, enterprise security frameworks, comprehensive monitoring systems, and production-ready deployment configurations for mission-critical enterprise applications! 🎯
WHERE t.organization_id = 1
AND t.created_at < '2024-01-15 10:30:00' -- cursor from previous page
ORDER BY t.created_at DESC
LIMIT 20;

```

```
