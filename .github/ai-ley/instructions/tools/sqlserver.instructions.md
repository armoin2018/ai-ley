---
name: 'Microsoft SQL Server Database Instructions'
description: 'Microsoft SQL Server enterprise database implementation guide covering T-SQL development, performance optimization, high availability, security features, integration services, and advanced database administration for enterprise applications.'
keywords: [cloud, enterprise, agent, async, gui, authentication, configuration, database, avoid, azure]
---


# Microsoft SQL Server Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents implementing Microsoft SQL Server solutions, emphasizing T-SQL development, enterprise features, performance optimization, and .NET ecosystem integration.

### When to Use SQL Server

- **Microsoft ecosystem** applications with .NET, Azure integration
- **Enterprise applications** requiring advanced security and compliance features
- **Business intelligence** with integrated reporting and analytics services
- **High-performance OLTP** with in-memory capabilities
- **Mixed workloads** combining OLTP and OLAP requirements

### When to Avoid SQL Server

- **Cross-platform flexibility** requirements → consider PostgreSQL
- **Cost-sensitive projects** with licensing constraints → use open source alternatives
- **Simple applications** not requiring enterprise features
- **Document-oriented data** → consider MongoDB or PostgreSQL

# Enterprise SQL Server Configuration

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Union
from enum import Enum
import asyncio
import logging
from datetime import datetime, timedelta

class SQLServerEdition(Enum):
EXPRESS = "express"
STANDARD = "standard"
ENTERPRISE = "enterprise"
DEVELOPER = "developer"

class SQLServerEnvironment(Enum):
DEVELOPMENT = "development"
TESTING = "testing"
STAGING = "staging"
PRODUCTION = "production"
DISASTER_RECOVERY = "disaster_recovery"

class SQLServerDeployment(Enum):
STANDALONE = "standalone"
FAILOVER_CLUSTER = "failover_cluster"
ALWAYS_ON_AG = "always_on_availability_groups"
AZURE_SQL_MI = "azure_sql_managed_instance"
HYBRID_CLOUD = "hybrid_cloud"

class SQLServerWorkloadType(Enum):
OLTP = "oltp"
OLAP = "olap"
MIXED = "mixed"
DATA_WAREHOUSE = "data_warehouse"
IN_MEMORY = "in_memory"

@dataclass
class EnterpriseSQLServerConfig:
"""Comprehensive SQL Server enterprise configuration"""

    # System Identification
    system_id: str
    organization_name: str
    edition: SQLServerEdition = SQLServerEdition.ENTERPRISE
    environment: SQLServerEnvironment = SQLServerEnvironment.PRODUCTION
    deployment_type: SQLServerDeployment = SQLServerDeployment.ALWAYS_ON_AG
    workload_type: SQLServerWorkloadType = SQLServerWorkloadType.MIXED

    # Team Management and Authentication
    team_management: Dict[str, Any] = field(default_factory=lambda: {
        "authentication_mode": "mixed",  # windows, sql, mixed
        "active_directory_integration": True,
        "azure_ad_integration": True,
        "multi_factor_authentication": True,
        "password_policy": {
            "enforce_policy": True,
            "enforce_expiration": True,
            "min_length": 12,
            "complexity_required": True,
            "lockout_threshold": 5,
            "lockout_duration_minutes": 30
        },
        "role_based_access": True,
        "roles": [
            {
                "name": "database_administrator",
                "permissions": [
                    "sysadmin", "system_management", "backup_restore",
                    "security_admin", "performance_tuning", "always_on_management"
                ],
                "server_roles": ["sysadmin", "securityadmin", "serveradmin"],
                "database_roles": ["db_owner", "db_securityadmin"],
                "resource_limits": {
                    "max_connections": "unlimited",
                    "query_timeout": "unlimited",
                    "memory_allocation": "unlimited"
                }
            },
            {
                "name": "database_developer",
                "permissions": [
                    "schema_design", "stored_procedure_development", "function_creation",
                    "view_creation", "index_management", "data_access"
                ],
                "server_roles": [],
                "database_roles": ["db_ddladmin", "db_datareader", "db_datawriter"],
                "resource_limits": {
                    "max_connections": "50",
                    "query_timeout": "300",
                    "memory_allocation": "10240"  # MB
                }
            },
            {
                "name": "data_analyst",
                "permissions": [
                    "data_querying", "report_generation", "view_creation",
                    "statistical_functions"
                ],
                "server_roles": [],
                "database_roles": ["db_datareader", "db_denydatawriter"],
                "resource_limits": {
                    "max_connections": "20",
                    "query_timeout": "600",
                    "memory_allocation": "4096"
                }
            },
            {
                "name": "application_user",
                "permissions": [
                    "crud_operations", "stored_procedure_execution",
                    "limited_data_access"
                ],
                "server_roles": [],
                "database_roles": ["db_datareader", "db_datawriter", "db_executor"],
                "resource_limits": {
                    "max_connections": "100",
                    "query_timeout": "120",
                    "memory_allocation": "2048"
                }
            },
            {
                "name": "reporting_user",
                "permissions": [
                    "read_only_access", "report_execution", "dashboard_access"
                ],
                "server_roles": [],
                "database_roles": ["db_datareader"],
                "resource_limits": {
                    "max_connections": "10",
                    "query_timeout": "900",
                    "memory_allocation": "1024"
                }
            },
            {
                "name": "security_auditor",
                "permissions": [
                    "audit_log_access", "security_monitoring", "compliance_reporting"
                ],
                "server_roles": ["securityadmin"],
                "database_roles": ["db_securityadmin"],
                "resource_limits": {
                    "max_connections": "5",
                    "query_timeout": "unlimited",
                    "memory_allocation": "2048"
                }
            }
        ]
    })

    # Infrastructure Configuration
    infrastructure_config: Dict[str, Any] = field(default_factory=lambda: {
        "always_on_configuration": {
            "availability_groups": [
                {
                    "name": "PrimaryAG",
                    "cluster_type": "WSFC",  # Windows Server Failover Cluster
                    "automated_backup_preference": "SECONDARY",
                    "failure_condition_level": 3,
                    "health_check_timeout": 30000,
                    "replicas": [
                        {
                            "server_name": "SQL-NODE-01",
                            "hostname": "sql-node-01.company.com",
                            "instance": "MSSQLSERVER",
                            "role": "PRIMARY",
                            "availability_mode": "SYNCHRONOUS_COMMIT",
                            "failover_mode": "AUTOMATIC",
                            "backup_priority": 30,
                            "read_only_routing": True,
                            "cpu_cores": 32,
                            "memory_gb": 128,
                            "storage_gb": 5000
                        },
                        {
                            "server_name": "SQL-NODE-02",
                            "hostname": "sql-node-02.company.com",
                            "instance": "MSSQLSERVER",
                            "role": "SECONDARY",
                            "availability_mode": "SYNCHRONOUS_COMMIT",
                            "failover_mode": "AUTOMATIC",
                            "backup_priority": 50,
                            "read_only_routing": True,
                            "cpu_cores": 32,
                            "memory_gb": 128,
                            "storage_gb": 5000
                        },
                        {
                            "server_name": "SQL-NODE-03",
                            "hostname": "sql-node-03.company.com",
                            "instance": "MSSQLSERVER",
                            "role": "SECONDARY",
                            "availability_mode": "ASYNCHRONOUS_COMMIT",
                            "failover_mode": "MANUAL",
                            "backup_priority": 70,
                            "read_only_routing": True,
                            "cpu_cores": 24,
                            "memory_gb": 96,
                            "storage_gb": 5000
                        }
                    ]
                }
            ],
            "listener_configuration": {
                "name": "AG-LISTENER",
                "dns_name": "sql-ag.company.com",
                "port": 1433,
                "ip_addresses": ["192.168.1.100", "192.168.1.101"],
                "subnet_mask": "255.255.255.0"
            }
        },
        "memory_configuration": {
            "max_server_memory_mb": 98304,  # Leave 30GB for OS on 128GB system
            "min_server_memory_mb": 16384,
            "buffer_pool_extension": {
                "enabled": True,
                "size_gb": 500,
                "location": "F:\\BPE\\BPE.BPE"
            },
            "in_memory_oltp": {
                "enabled": True,
                "memory_optimized_filegroup": {
                    "name": "InMemoryData",
                    "location": "G:\\InMemory",
                    "size_gb": 50
                }
            }
        },
        "storage_configuration": {
            "data_files": {
                "location": "D:\\Data",
                "initial_size_gb": 100,
                "growth_increment_gb": 10,
                "max_size_gb": 2000,
                "filegrowth": "10%"
            },
            "log_files": {
                "location": "L:\\Logs",
                "initial_size_gb": 20,
                "growth_increment_gb": 5,
                "max_size_gb": 500,
                "filegrowth": "512MB"
            },
            "tempdb_configuration": {
                "data_files_count": 8,  # One per CPU core up to 8
                "data_file_size_gb": 8,
                "log_file_size_gb": 2,
                "location": "T:\\TempDB"
            },
            "filegroups": [
                {
                    "name": "PRIMARY",
                    "type": "ROWS",
                    "files": ["CompanyDB.mdf"]
                },
                {
                    "name": "INDEXES",
                    "type": "ROWS",
                    "files": ["CompanyDB_Indexes.ndf"]
                },
                {
                    "name": "ARCHIVE",
                    "type": "ROWS",
                    "files": ["CompanyDB_Archive.ndf"]
                }
            ]
        },
        "cpu_configuration": {
            "max_degree_of_parallelism": 8,
            "cost_threshold_for_parallelism": 50,
            "processor_affinity": "AUTO",
            "numa_node_configuration": True
        }
    })

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
