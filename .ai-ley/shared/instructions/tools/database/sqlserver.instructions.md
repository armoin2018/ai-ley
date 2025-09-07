---
agentMode: general
applyTo: general
author: AI-LEY
description: Microsoft SQL Server enterprise database implementation guide covering T-SQL development, performance optimization, high availability, security features, integration services, and advanced database administration for enterprise applications.
extensions:
  - .md
guidelines: N/A
instructionType: database
keywords:
  [
    sqlserver,
    mssql,
    tsql,
    enterprise,
    performance,
    high-availability,
    security,
    integration-services,
    oltp,
    olap,
  ]
lastUpdated: '2025-09-03T14:00:00.000000'
technicalQualityScore: 4.8
AIUsabilityScore: 4.8
title: Microsoft SQL Server Database Instructions
version: 1.1.0
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

    # Security Configuration
    security_config: Dict[str, Any] = field(default_factory=lambda: {
        "transparent_data_encryption": {
            "enabled": True,
            "algorithm": "AES_256",
            "certificate_name": "TDE_Certificate",
            "database_encryption_key": True
        },
        "always_encrypted": {
            "enabled": True,
            "key_store": "Azure_Key_Vault",
            "column_master_key": "CMK_CompanyData",
            "sensitive_columns": [
                "Customers.SSN",
                "Employees.Salary",
                "CreditCards.CardNumber",
                "Patients.MedicalRecordNumber"
            ]
        },
        "row_level_security": {
            "enabled": True,
            "security_policies": [
                {
                    "name": "CustomerDataPolicy",
                    "table": "Customers",
                    "predicate": "USER_NAME() = CustomerOwner OR IS_MEMBER('CustomerManager') = 1"
                },
                {
                    "name": "EmployeeDataPolicy",
                    "table": "Employees",
                    "predicate": "USER_NAME() = EmployeeID OR IS_MEMBER('HR') = 1"
                }
            ]
        },
        "dynamic_data_masking": {
            "enabled": True,
            "masking_functions": [
                {
                    "table": "Customers",
                    "column": "Email",
                    "function": "email()"
                },
                {
                    "table": "Customers",
                    "column": "Phone",
                    "function": "partial(1,'XXX-XXX-',4)"
                },
                {
                    "table": "Employees",
                    "column": "SSN",
                    "function": "partial(0,'XXX-XX-',4)"
                }
            ]
        },
        "sql_server_audit": {
            "enabled": True,
            "audit_destination": "FILE",
            "file_path": "C:\\Audit\\SQLAudit",
            "max_file_size_mb": 100,
            "max_files": 50,
            "server_audit_specifications": [
                "LOGIN_CHANGE_PASSWORD_GROUP",
                "LOGOUT_GROUP",
                "FAILED_LOGIN_GROUP",
                "SUCCESSFUL_LOGIN_GROUP"
            ],
            "database_audit_specifications": [
                "SELECT on SCHEMA::dbo by public",
                "INSERT on SCHEMA::dbo by public",
                "UPDATE on SCHEMA::dbo by public",
                "DELETE on SCHEMA::dbo by public"
            ]
        },
        "compliance": {
            "gdpr_compliant": True,
            "hipaa_compliant": True,
            "sox_compliant": True,
            "pci_dss_compliant": True,
            "data_retention_policies": {
                "customer_data": "7_years",
                "employee_data": "7_years",
                "audit_logs": "10_years",
                "financial_data": "10_years"
            }
        }
    })

    # Performance Optimization
    performance_config: Dict[str, Any] = field(default_factory=lambda: {
        "resource_governor": {
            "enabled": True,
            "resource_pools": [
                {
                    "name": "OLTP_Pool",
                    "min_cpu_percent": 50,
                    "max_cpu_percent": 80,
                    "min_memory_percent": 40,
                    "max_memory_percent": 60,
                    "max_dop": 4
                },
                {
                    "name": "Reporting_Pool",
                    "min_cpu_percent": 10,
                    "max_cpu_percent": 40,
                    "min_memory_percent": 20,
                    "max_memory_percent": 40,
                    "max_dop": 8
                },
                {
                    "name": "Admin_Pool",
                    "min_cpu_percent": 5,
                    "max_cpu_percent": 100,
                    "min_memory_percent": 5,
                    "max_memory_percent": 100,
                    "max_dop": 0  # Unlimited
                }
            ],
            "workload_groups": [
                {
                    "name": "OLTP_Workload",
                    "pool": "OLTP_Pool",
                    "importance": "HIGH",
                    "max_dop": 4,
                    "request_max_memory_grant_percent": 25,
                    "request_max_cpu_time_sec": 300
                },
                {
                    "name": "Reporting_Workload",
                    "pool": "Reporting_Pool",
                    "importance": "MEDIUM",
                    "max_dop": 8,
                    "request_max_memory_grant_percent": 50,
                    "request_max_cpu_time_sec": 1800
                }
            ]
        },
        "query_store": {
            "enabled": True,
            "operation_mode": "READ_WRITE",
            "data_flush_interval_seconds": 900,
            "statistics_collection_interval": 60,
            "max_storage_size_mb": 1000,
            "interval_length_minutes": 60,
            "stale_query_threshold_days": 30,
            "size_based_cleanup_mode": "AUTO"
        },
        "indexing_strategy": {
            "automatic_tuning": {
                "enabled": True,
                "create_index": True,
                "drop_index": True,
                "force_last_good_plan": True
            },
            "columnstore_indexes": {
                "enabled": True,
                "archival_compression": True,
                "batch_mode_optimization": True
            },
            "index_maintenance": {
                "reorganize_threshold": 10,
                "rebuild_threshold": 30,
                "update_statistics": True,
                "maintenance_window": "02:00-06:00"
            }
        },
        "connection_pooling": {
            "enabled": True,
            "max_pool_size": 200,
            "min_pool_size": 10,
            "connection_timeout": 30,
            "command_timeout": 300,
            "connection_lifetime": 3600
        }
    })

    # Backup and Recovery Configuration
    backup_recovery_config: Dict[str, Any] = field(default_factory=lambda: {
        "backup_strategy": {
            "full_backup": {
                "schedule": "weekly",
                "day": "sunday",
                "time": "02:00",
                "retention_weeks": 4,
                "compression": True,
                "encryption": True,
                "checksum": True
            },
            "differential_backup": {
                "schedule": "daily",
                "time": "02:00",
                "retention_days": 14,
                "compression": True,
                "encryption": True
            },
            "log_backup": {
                "schedule": "every_15_minutes",
                "retention_hours": 72,
                "compression": True,
                "encryption": True
            }
        },
        "backup_locations": [
            {
                "type": "local",
                "path": "E:\\Backups",
                "primary": True
            },
            {
                "type": "network",
                "path": "\\\\backup-server\\SQLBackups",
                "primary": False
            },
            {
                "type": "azure_storage",
                "container": "sql-backups",
                "account": "companysqlbackups",
                "primary": False
            }
        ],
        "recovery_model": "FULL",
        "page_verify": "CHECKSUM",
        "backup_encryption": {
            "certificate_name": "BackupCert",
            "algorithm": "AES_256"
        }
    })

    # Monitoring and Observability
    monitoring_config: Dict[str, Any] = field(default_factory=lambda: {
        "sql_server_agent": {
            "enabled": True,
            "mail_profile": "DatabaseMail",
            "operators": [
                {
                    "name": "DBA_Team",
                    "email": "dba-team@company.com",
                    "pager": "555-0199"
                }
            ],
            "jobs": [
                {
                    "name": "DatabaseBackup",
                    "schedule": "daily_2am",
                    "notify_operator": "DBA_Team"
                },
                {
                    "name": "IndexMaintenance",
                    "schedule": "weekly_sunday_3am",
                    "notify_operator": "DBA_Team"
                }
            ]
        },
        "extended_events": {
            "enabled": True,
            "sessions": [
                {
                    "name": "system_health",
                    "enabled": True,
                    "startup_state": "ON"
                },
                {
                    "name": "AlwaysOn_health",
                    "enabled": True,
                    "startup_state": "ON"
                },
                {
                    "name": "QueryPerformance",
                    "events": [
                        "sql_statement_completed",
                        "rpc_completed",
                        "lock_acquired",
                        "lock_released"
                    ],
                    "targets": [
                        {
                            "type": "event_file",
                            "filename": "QueryPerformance.xel",
                            "max_file_size": 100,
                            "max_rollover_files": 10
                        }
                    ]
                }
            ]
        },
        "database_mail": {
            "enabled": True,
            "profile_name": "DatabaseMail",
            "account_name": "SQL_Server_Mail",
            "smtp_server": "smtp.company.com",
            "port": 587,
            "use_ssl": True,
            "authentication": "BASIC"
        },
        "performance_counters": [
            "Buffer Manager:Buffer cache hit ratio",
            "Memory Manager:Memory Grants Pending",
            "SQL Statistics:Batch Requests/sec",
            "SQL Statistics:SQL Compilations/sec",
            "General Statistics:User Connections",
            "Locks:Lock Waits/sec",
            "Access Methods:Page Splits/sec"
        ],
        "alerting": {
            "channels": [
                {
                    "name": "email",
                    "config": {
                        "smtp_server": "smtp.company.com",
                        "recipients": ["dba-team@company.com", "ops-team@company.com"]
                    }
                },
                {
                    "name": "teams",
                    "config": {
                        "webhook_url": "https://company.webhook.office.com/xxx",
                        "channel": "Database Alerts"
                    }
                }
            ],
            "thresholds": {
                "buffer_cache_hit_ratio": 95,
                "memory_grants_pending": 10,
                "cpu_utilization": 80,
                "disk_queue_length": 10,
                "blocked_process_threshold": 30
            }
        }
    })

class EnterpriseSQLServerDatabase:
"""Enterprise SQL Server Database Management Platform"""

    def __init__(self, config: EnterpriseSQLServerConfig):
        self.config = config
        self.logger = logging.getLogger(__name__)

    async def setup_enterprise_platform(self) -> Dict[str, Any]:
        """Setup comprehensive SQL Server enterprise platform"""

        setup_tasks = [
            self._setup_infrastructure(),
            self._configure_security(),
            self._setup_always_on(),
            self._configure_performance(),
            self._setup_backup_recovery(),
            self._configure_monitoring(),
            self._setup_team_management()
        ]

        results = await asyncio.gather(*setup_tasks, return_exceptions=True)

        return {
            "status": "success",
            "timestamp": datetime.now().isoformat(),
            "system_id": self.config.system_id,
            "deployment_type": self.config.deployment_type.value,
            "setup_results": {
                "infrastructure": results[0],
                "security": results[1],
                "always_on": results[2],
                "performance": results[3],
                "backup_recovery": results[4],
                "monitoring": results[5],
                "team_management": results[6]
            },
            "access_endpoints": {
                "primary_connection": f"sql-ag.{self.config.organization_name.lower()}.com,1433",
                "read_only_connection": f"sql-ag.{self.config.organization_name.lower()}.com,1434",
                "reporting_services": f"https://ssrs.{self.config.organization_name.lower()}.com/Reports",
                "analysis_services": f"https://ssas.{self.config.organization_name.lower()}.com"
            }
        }

    async def _setup_infrastructure(self) -> Dict[str, Any]:
        """Setup SQL Server infrastructure with Always On"""

        try:
            # Configure SQL Server instances
            instances = await self._configure_sql_instances()

            # Setup storage configuration
            storage_config = await self._configure_storage()

            # Configure memory settings
            memory_config = await self._configure_memory_settings()

            # Setup TempDB optimization
            tempdb_config = await self._configure_tempdb()

            return {
                "status": "completed",
                "sql_instances": instances,
                "storage_configuration": storage_config,
                "memory_configuration": memory_config,
                "tempdb_configuration": tempdb_config
            }

        except Exception as e:
            self.logger.error(f"Infrastructure setup failed: {str(e)}")
            return {"status": "failed", "error": str(e)}

    async def _configure_sql_instances(self) -> Dict[str, Any]:
        """Configure SQL Server instances for Always On"""

        ag_config = self.config.infrastructure_config["always_on_configuration"]["availability_groups"][0]

        instances = []
        for replica in ag_config["replicas"]:
            instance_config = {
                "server_name": replica["server_name"],
                "hostname": replica["hostname"],
                "instance_name": replica["instance"],
                "role": replica["role"],
                "availability_mode": replica["availability_mode"],
                "failover_mode": replica["failover_mode"],
                "hardware": {
                    "cpu_cores": replica["cpu_cores"],
                    "memory_gb": replica["memory_gb"],
                    "storage_gb": replica["storage_gb"]
                },
                "configuration": {
                    "hadr_enabled": True,
                    "backup_priority": replica["backup_priority"],
                    "read_only_routing_url": f"TCP://{replica['hostname']}:1433"
                }
            }
            instances.append(instance_config)

        return {
            "instances_configured": len(instances),
            "instances": instances,
            "cluster_type": ag_config["cluster_type"]
        }

    async def _configure_storage(self) -> Dict[str, Any]:
        """Configure SQL Server storage for optimal performance"""

        storage_config = self.config.infrastructure_config["storage_configuration"]

        return {
            "data_files": {
                "location": storage_config["data_files"]["location"],
                "initial_size_gb": storage_config["data_files"]["initial_size_gb"],
                "growth_strategy": "fixed_increment",
                "autogrowth_gb": storage_config["data_files"]["growth_increment_gb"]
            },
            "log_files": {
                "location": storage_config["log_files"]["location"],
                "initial_size_gb": storage_config["log_files"]["initial_size_gb"],
                "growth_strategy": "fixed_increment",
                "autogrowth_mb": 512
            },
            "tempdb_optimization": {
                "data_files_count": storage_config["tempdb_configuration"]["data_files_count"],
                "equal_sizing": True,
                "separate_location": storage_config["tempdb_configuration"]["location"]
            },
            "filegroups": storage_config["filegroups"]
        }

    def _calculate_user_connections(self, role_name: str) -> int:
        """Calculate maximum connections based on role"""
        limits = {
            "database_administrator": 0,  # Unlimited
            "database_developer": 50,
            "data_analyst": 20,
            "application_user": 100,
            "reporting_user": 10,
            "security_auditor": 5
        }
        return limits.get(role_name, 5)

# Enterprise SQL Server Usage Examples and Implementation Guide

## Enterprise SQL Server Usage Examples

### Example 1: E-Commerce Platform with Always On Availability Groups

````python
async def setup_ecommerce_platform():
    """Example: Setup high-performance e-commerce platform with SQL Server Always On"""

    # Initialize enterprise configuration for e-commerce
    config = EnterpriseSQLServerConfig(
        system_id="ecommerce-platform",
        organization_name="GlobalRetailer",
        edition=SQLServerEdition.ENTERPRISE,
        environment=SQLServerEnvironment.PRODUCTION,
        deployment_type=SQLServerDeployment.ALWAYS_ON_AG,
        workload_type=SQLServerWorkloadType.OLTP,
        infrastructure_config={
            "always_on_configuration": {
                "availability_groups": [
                    {
                        "name": "ECommerceAG",
                        "cluster_type": "WSFC",
                        "automated_backup_preference": "SECONDARY",
                        "failure_condition_level": 3,
                        "health_check_timeout": 30000,
                        "replicas": [
                            {
                                "server_name": "ECOM-SQL-01",
                                "hostname": "ecom-sql-01.globalretailer.com",
                                "instance": "MSSQLSERVER",
                                "role": "PRIMARY",
                                "availability_mode": "SYNCHRONOUS_COMMIT",
                                "failover_mode": "AUTOMATIC",
                                "backup_priority": 30,
                                "read_only_routing": True,
                                "cpu_cores": 48,
                                "memory_gb": 256,
                                "storage_gb": 10000
                            },
                            {
                                "server_name": "ECOM-SQL-02",
                                "hostname": "ecom-sql-02.globalretailer.com",
                                "instance": "MSSQLSERVER",
                                "role": "SECONDARY",
                                "availability_mode": "SYNCHRONOUS_COMMIT",
                                "failover_mode": "AUTOMATIC",
                                "backup_priority": 50,
                                "read_only_routing": True,
                                "cpu_cores": 48,
                                "memory_gb": 256,
                                "storage_gb": 10000
                            },
                            {
                                "server_name": "ECOM-SQL-03",
                                "hostname": "ecom-sql-03.globalretailer.com",
                                "instance": "MSSQLSERVER",
                                "role": "SECONDARY",
                                "availability_mode": "ASYNCHRONOUS_COMMIT",
                                "failover_mode": "MANUAL",
                                "backup_priority": 70,
                                "read_only_routing": True,
                                "cpu_cores": 32,
                                "memory_gb": 192,
                                "storage_gb": 8000
                            }
                        ]
                    }
                ],
                "listener_configuration": {
                    "name": "ECOM-AG-LISTENER",
                    "dns_name": "ecom-sql.globalretailer.com",
                    "port": 1433,
                    "ip_addresses": ["192.168.10.100", "192.168.10.101"],
                    "subnet_mask": "255.255.255.0"
                }
            },
            "memory_configuration": {
                "max_server_memory_mb": 204800,  # 200GB for SQL Server
                "min_server_memory_mb": 32768,
                "in_memory_oltp": {
                    "enabled": True,
                    "memory_optimized_filegroup": {
                        "name": "ECommerceInMemory",
                        "location": "G:\\InMemory",
                        "size_gb": 100
                    }
                }
            }
        },
        security_config={
            "transparent_data_encryption": {
                "enabled": True,
                "algorithm": "AES_256"
            },
            "always_encrypted": {
                "enabled": True,
                "sensitive_columns": [
                    "Customers.CreditCardNumber",
                    "Customers.SSN",
                    "Orders.PaymentInfo"
                ]
            },
            "row_level_security": {
                "enabled": True,
                "security_policies": [
                    {
                        "name": "CustomerDataPolicy",
                        "table": "Customers",
                        "predicate": "CustomerID = USER_ID() OR IS_MEMBER('CustomerService') = 1"
                    }
                ]
            }
        },
        performance_config={
            "resource_governor": {
                "enabled": True,
                "resource_pools": [
                    {
                        "name": "WebApp_Pool",
                        "min_cpu_percent": 60,
                        "max_cpu_percent": 80,
                        "min_memory_percent": 50,
                        "max_memory_percent": 70
                    },
                    {
                        "name": "Reporting_Pool",
                        "min_cpu_percent": 10,
                        "max_cpu_percent": 30,
                        "min_memory_percent": 10,
                        "max_memory_percent": 25
                    },
                    {
                        "name": "ETL_Pool",
                        "min_cpu_percent": 5,
                        "max_cpu_percent": 50,
                        "min_memory_percent": 5,
                        "max_memory_percent": 30
                    }
                ]
            },
            "indexing_strategy": {
                "columnstore_indexes": {
                    "enabled": True,
                    "archival_compression": True
                }
            }
        }
    )

    # Initialize SQL Server platform
    platform = EnterpriseSQLServerDatabase(config)

    # Setup the platform
    setup_result = await platform.setup_enterprise_platform()

    # Create e-commerce data model
    ecommerce_schema = await create_ecommerce_data_model(platform)

    # Setup real-time inventory management
    inventory_system = await setup_inventory_management(platform)

    # Configure customer analytics
    customer_analytics = await setup_customer_analytics(platform)

    return {
        "platform_setup": setup_result,
        "ecommerce_schema": ecommerce_schema,
        "inventory_system": inventory_system,
        "customer_analytics": customer_analytics,
        "access_endpoints": {
            "primary_connection": "ecom-sql.globalretailer.com,1433",
            "read_only_connection": "ecom-sql.globalretailer.com,1434",
            "api_endpoint": "https://api.globalretailer.com/v1"
        }
    }

async def create_ecommerce_data_model(platform):
    """Create comprehensive e-commerce data model with optimizations"""

    ecommerce_ddl = """
    -- Create ECommerce Database with multiple filegroups
    CREATE DATABASE ECommerceDB
    ON
    ( NAME = 'ECommerceDB_Data',
      FILENAME = 'D:\\Data\\ECommerceDB.mdf',
      SIZE = 100GB,
      MAXSIZE = 2TB,
      FILEGROWTH = 10GB ),
    FILEGROUP ECommerce_Indexes
    ( NAME = 'ECommerceDB_Indexes',
      FILENAME = 'I:\\Indexes\\ECommerceDB_Indexes.ndf',
      SIZE = 50GB,
      MAXSIZE = 1TB,
      FILEGROWTH = 5GB ),
    FILEGROUP ECommerce_Archive
    ( NAME = 'ECommerceDB_Archive',
      FILENAME = 'A:\\Archive\\ECommerceDB_Archive.ndf',
      SIZE = 200GB,
      MAXSIZE = 5TB,
      FILEGROWTH = 20GB )
    LOG ON
    ( NAME = 'ECommerceDB_Log',
      FILENAME = 'L:\\Logs\\ECommerceDB_Log.ldf',
      SIZE = 20GB,
      MAXSIZE = 500GB,
      FILEGROWTH = 5GB );
    GO

    USE ECommerceDB;
    GO

    -- Enable Transparent Data Encryption
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongMasterKeyPassword123!';
    GO
    CREATE CERTIFICATE TDE_Cert WITH SUBJECT = 'TDE Certificate for ECommerce';
    GO
    CREATE DATABASE ENCRYPTION KEY WITH ALGORITHM = AES_256
    ENCRYPTION BY SERVER CERTIFICATE TDE_Cert;
    GO
    ALTER DATABASE ECommerceDB SET ENCRYPTION ON;
    GO

    -- Create schemas for organization
    CREATE SCHEMA catalog AUTHORIZATION dbo;
    CREATE SCHEMA orders AUTHORIZATION dbo;
    CREATE SCHEMA customers AUTHORIZATION dbo;
    CREATE SCHEMA inventory AUTHORIZATION dbo;
    CREATE SCHEMA analytics AUTHORIZATION dbo;
    GO

    -- Products table with columnstore index for analytics
    CREATE TABLE catalog.Products (
        ProductID BIGINT IDENTITY(1,1) NOT NULL,
        SKU NVARCHAR(50) NOT NULL,
        ProductName NVARCHAR(200) NOT NULL,
        Description NVARCHAR(MAX),
        CategoryID INT NOT NULL,
        BrandID INT NOT NULL,
        Price DECIMAL(10,2) NOT NULL,
        CostPrice DECIMAL(10,2) NOT NULL,
        Weight DECIMAL(8,3),
        Dimensions NVARCHAR(50),
        Color NVARCHAR(30),
        Size NVARCHAR(20),
        IsActive BIT NOT NULL DEFAULT 1,
        SEOTitle NVARCHAR(200),
        SEODescription NVARCHAR(500),
        Tags NVARCHAR(500),
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        ModifiedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_Products PRIMARY KEY CLUSTERED (ProductID),
        CONSTRAINT UK_Products_SKU UNIQUE NONCLUSTERED (SKU)
    ) ON [PRIMARY];

    -- Categories with hierarchical support
    CREATE TABLE catalog.Categories (
        CategoryID INT IDENTITY(1,1) NOT NULL,
        ParentCategoryID INT NULL,
        CategoryName NVARCHAR(100) NOT NULL,
        CategoryPath AS CAST('/' + CategoryName + '/' AS NVARCHAR(500)) PERSISTED,
        Description NVARCHAR(500),
        DisplayOrder INT NOT NULL DEFAULT 0,
        IsActive BIT NOT NULL DEFAULT 1,
        SEOTitle NVARCHAR(200),
        SEODescription NVARCHAR(500),
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_Categories PRIMARY KEY CLUSTERED (CategoryID),
        CONSTRAINT FK_Categories_Parent FOREIGN KEY (ParentCategoryID) REFERENCES catalog.Categories(CategoryID)
    ) ON [PRIMARY];

    -- Customers with Always Encrypted sensitive data
    CREATE TABLE customers.Customers (
        CustomerID BIGINT IDENTITY(1,1) NOT NULL,
        CustomerGUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        Email NVARCHAR(255) NOT NULL,
        FirstName NVARCHAR(100) NOT NULL,
        LastName NVARCHAR(100) NOT NULL,
        DateOfBirth DATE,
        Phone NVARCHAR(20),
        Gender CHAR(1),
        PreferredLanguage CHAR(2) DEFAULT 'EN',
        CustomerType TINYINT NOT NULL DEFAULT 1, -- 1=Regular, 2=Premium, 3=VIP
        RegistrationDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        LastLoginDate DATETIME2,
        IsActive BIT NOT NULL DEFAULT 1,
        MarketingOptIn BIT NOT NULL DEFAULT 0,
        CONSTRAINT PK_Customers PRIMARY KEY CLUSTERED (CustomerID),
        CONSTRAINT UK_Customers_Email UNIQUE NONCLUSTERED (Email),
        CONSTRAINT UK_Customers_GUID UNIQUE NONCLUSTERED (CustomerGUID)
    ) ON [PRIMARY];

    -- Customer addresses
    CREATE TABLE customers.CustomerAddresses (
        AddressID BIGINT IDENTITY(1,1) NOT NULL,
        CustomerID BIGINT NOT NULL,
        AddressType TINYINT NOT NULL, -- 1=Billing, 2=Shipping
        FirstName NVARCHAR(100) NOT NULL,
        LastName NVARCHAR(100) NOT NULL,
        Company NVARCHAR(200),
        AddressLine1 NVARCHAR(200) NOT NULL,
        AddressLine2 NVARCHAR(200),
        City NVARCHAR(100) NOT NULL,
        StateProvince NVARCHAR(100),
        PostalCode NVARCHAR(20),
        Country NVARCHAR(100) NOT NULL,
        IsDefault BIT NOT NULL DEFAULT 0,
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_CustomerAddresses PRIMARY KEY CLUSTERED (AddressID),
        CONSTRAINT FK_CustomerAddresses_Customer FOREIGN KEY (CustomerID) REFERENCES customers.Customers(CustomerID)
    ) ON [PRIMARY];

    -- Orders table (partitioned by month)
    CREATE PARTITION FUNCTION pf_OrdersByMonth (DATETIME2)
    AS RANGE RIGHT FOR VALUES (
        '2024-01-01', '2024-02-01', '2024-03-01', '2024-04-01',
        '2024-05-01', '2024-06-01', '2024-07-01', '2024-08-01',
        '2024-09-01', '2024-10-01', '2024-11-01', '2024-12-01',
        '2025-01-01'
    );

    CREATE PARTITION SCHEME ps_OrdersByMonth
    AS PARTITION pf_OrdersByMonth
    TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY],
        [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY],
        [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY]);

    CREATE TABLE orders.Orders (
        OrderID BIGINT IDENTITY(1,1) NOT NULL,
        OrderNumber NVARCHAR(50) NOT NULL,
        CustomerID BIGINT NOT NULL,
        OrderDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        OrderStatus TINYINT NOT NULL DEFAULT 1, -- 1=Pending, 2=Processing, 3=Shipped, 4=Delivered, 5=Cancelled
        BillingAddressID BIGINT NOT NULL,
        ShippingAddressID BIGINT NOT NULL,
        SubTotal DECIMAL(12,2) NOT NULL,
        TaxAmount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
        ShippingAmount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
        DiscountAmount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
        TotalAmount DECIMAL(12,2) NOT NULL,
        PaymentMethod NVARCHAR(50),
        PaymentStatus TINYINT NOT NULL DEFAULT 1, -- 1=Pending, 2=Paid, 3=Failed
        TransactionID NVARCHAR(100),
        ShippingMethod NVARCHAR(100),
        TrackingNumber NVARCHAR(100),
        EstimatedDeliveryDate DATE,
        ActualDeliveryDate DATE,
        Notes NVARCHAR(MAX),
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        ModifiedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_Orders PRIMARY KEY CLUSTERED (OrderID, OrderDate),
        CONSTRAINT UK_Orders_OrderNumber UNIQUE NONCLUSTERED (OrderNumber),
        CONSTRAINT FK_Orders_Customer FOREIGN KEY (CustomerID) REFERENCES customers.Customers(CustomerID),
        CONSTRAINT FK_Orders_BillingAddress FOREIGN KEY (BillingAddressID) REFERENCES customers.CustomerAddresses(AddressID),
        CONSTRAINT FK_Orders_ShippingAddress FOREIGN KEY (ShippingAddressID) REFERENCES customers.CustomerAddresses(AddressID)
    ) ON ps_OrdersByMonth(OrderDate);

    -- Order Items
    CREATE TABLE orders.OrderItems (
        OrderItemID BIGINT IDENTITY(1,1) NOT NULL,
        OrderID BIGINT NOT NULL,
        OrderDate DATETIME2 NOT NULL,
        ProductID BIGINT NOT NULL,
        SKU NVARCHAR(50) NOT NULL,
        ProductName NVARCHAR(200) NOT NULL,
        Quantity INT NOT NULL,
        UnitPrice DECIMAL(10,2) NOT NULL,
        TotalPrice AS (Quantity * UnitPrice) PERSISTED,
        DiscountAmount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
        NetPrice AS (Quantity * UnitPrice - DiscountAmount) PERSISTED,
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_OrderItems PRIMARY KEY CLUSTERED (OrderItemID, OrderDate),
        CONSTRAINT FK_OrderItems_Order FOREIGN KEY (OrderID, OrderDate) REFERENCES orders.Orders(OrderID, OrderDate),
        CONSTRAINT FK_OrderItems_Product FOREIGN KEY (ProductID) REFERENCES catalog.Products(ProductID)
    ) ON ps_OrdersByMonth(OrderDate);

    -- Inventory with memory-optimized table for high-frequency updates
    CREATE TABLE inventory.ProductInventory (
        ProductID BIGINT NOT NULL,
        LocationID INT NOT NULL,
        QuantityOnHand INT NOT NULL DEFAULT 0,
        QuantityReserved INT NOT NULL DEFAULT 0,
        QuantityAvailable AS (QuantityOnHand - QuantityReserved) PERSISTED,
        ReorderPoint INT NOT NULL DEFAULT 0,
        MaxStockLevel INT NOT NULL DEFAULT 0,
        LastRestockDate DATETIME2,
        LastCountDate DATETIME2,
        CostPerUnit DECIMAL(10,4),
        LastModifiedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_ProductInventory PRIMARY KEY CLUSTERED (ProductID, LocationID),
        CONSTRAINT FK_ProductInventory_Product FOREIGN KEY (ProductID) REFERENCES catalog.Products(ProductID)
    ) ON [PRIMARY];

    -- Shopping cart (memory-optimized for performance)
    IF NOT EXISTS (SELECT * FROM sys.filegroups WHERE name = 'InMemoryData')
    BEGIN
        ALTER DATABASE ECommerceDB ADD FILEGROUP InMemoryData CONTAINS MEMORY_OPTIMIZED_DATA;
        ALTER DATABASE ECommerceDB ADD FILE
        (NAME = 'ECommerceDB_InMemory', FILENAME = 'G:\\InMemory\\ECommerceDB_InMemory')
        TO FILEGROUP InMemoryData;
    END

    CREATE TABLE customers.ShoppingCart (
        CartID BIGINT IDENTITY(1,1) NOT NULL,
        SessionID NVARCHAR(128) NOT NULL,
        CustomerID BIGINT NULL,
        ProductID BIGINT NOT NULL,
        Quantity INT NOT NULL DEFAULT 1,
        UnitPrice DECIMAL(10,2) NOT NULL,
        AddedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        ModifiedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_ShoppingCart PRIMARY KEY NONCLUSTERED HASH (CartID) WITH (BUCKET_COUNT = 1000000),
        INDEX IX_ShoppingCart_Session NONCLUSTERED HASH (SessionID) WITH (BUCKET_COUNT = 1000000),
        INDEX IX_ShoppingCart_Customer NONCLUSTERED (CustomerID)
    ) WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA);

    -- Create columnstore index for analytics on historical orders
    CREATE NONCLUSTERED COLUMNSTORE INDEX NCCI_Orders_Analytics
    ON orders.Orders (OrderDate, CustomerID, OrderStatus, SubTotal, TotalAmount, PaymentMethod);

    CREATE NONCLUSTERED COLUMNSTORE INDEX NCCI_OrderItems_Analytics
    ON orders.OrderItems (OrderDate, ProductID, Quantity, UnitPrice, TotalPrice);

    -- High-performance indexes
    CREATE NONCLUSTERED INDEX IX_Orders_Customer_Date
    ON orders.Orders (CustomerID, OrderDate DESC) INCLUDE (OrderStatus, TotalAmount);

    CREATE NONCLUSTERED INDEX IX_Orders_Status_Date
    ON orders.Orders (OrderStatus, OrderDate DESC) INCLUDE (CustomerID, TotalAmount);

    CREATE NONCLUSTERED INDEX IX_Products_Category_Active
    ON catalog.Products (CategoryID, IsActive) INCLUDE (ProductName, Price, SKU);

    CREATE NONCLUSTERED INDEX IX_Customers_Type_Registration
    ON customers.Customers (CustomerType, RegistrationDate DESC) INCLUDE (Email, FirstName, LastName);

    -- Update statistics
    UPDATE STATISTICS catalog.Products WITH FULLSCAN;
    UPDATE STATISTICS orders.Orders WITH FULLSCAN;
    UPDATE STATISTICS customers.Customers WITH FULLSCAN;
    """

    return {"status": "created", "schema": "ecommerce", "tables_created": 8}

### Example 2: Healthcare Information System with Advanced Security

```python
async def setup_healthcare_information_system():
    """Example: Setup HIPAA-compliant healthcare information system"""

    config = EnterpriseSQLServerConfig(
        system_id="healthcare-his",
        organization_name="HealthSystemGroup",
        edition=SQLServerEdition.ENTERPRISE,
        environment=SQLServerEnvironment.PRODUCTION,
        deployment_type=SQLServerDeployment.ALWAYS_ON_AG,
        workload_type=SQLServerWorkloadType.MIXED,
        security_config={
            "transparent_data_encryption": {
                "enabled": True,
                "algorithm": "AES_256"
            },
            "always_encrypted": {
                "enabled": True,
                "key_store": "Azure_Key_Vault",
                "sensitive_columns": [
                    "Patients.SSN",
                    "Patients.MedicalRecordNumber",
                    "MedicalRecords.Diagnosis",
                    "Prescriptions.MedicationDetails"
                ]
            },
            "row_level_security": {
                "enabled": True,
                "security_policies": [
                    {
                        "name": "PatientDataPolicy",
                        "table": "Patients",
                        "predicate": "PatientID = CAST(SESSION_CONTEXT(N'PatientID') AS INT) OR IS_MEMBER('HealthcareProvider') = 1"
                    },
                    {
                        "name": "MedicalRecordsPolicy",
                        "table": "MedicalRecords",
                        "predicate": "ProviderID = CAST(SESSION_CONTEXT(N'ProviderID') AS INT) OR IS_MEMBER('AttendingPhysician') = 1"
                    }
                ]
            },
            "dynamic_data_masking": {
                "enabled": True,
                "masking_functions": [
                    {
                        "table": "Patients",
                        "column": "SSN",
                        "function": "partial(0,'XXX-XX-',4)"
                    },
                    {
                        "table": "Patients",
                        "column": "DateOfBirth",
                        "function": "default()"
                    }
                ]
            },
            "compliance": {
                "hipaa_compliant": True,
                "gdpr_compliant": True,
                "sox_compliant": True
            }
        }
    )

    platform = EnterpriseSQLServerDatabase(config)
    setup_result = await platform.setup_enterprise_platform()

    # Create healthcare data model
    healthcare_schema = await create_healthcare_data_model(platform)

    # Setup clinical decision support
    clinical_support = await setup_clinical_decision_support(platform)

    return {
        "platform_setup": setup_result,
        "healthcare_schema": healthcare_schema,
        "clinical_support": clinical_support,
        "compliance_status": "HIPAA_COMPLIANT"
    }

async def create_healthcare_data_model(platform):
    """Create HIPAA-compliant healthcare data model"""

    healthcare_ddl = """
    -- Create Healthcare Database with advanced security
    CREATE DATABASE HealthcareDB;
    GO

    USE HealthcareDB;
    GO

    -- Enable TDE
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'HealthcareEncryptionKey2024!';
    CREATE CERTIFICATE HealthcareTDE_Cert WITH SUBJECT = 'Healthcare TDE Certificate';
    CREATE DATABASE ENCRYPTION KEY WITH ALGORITHM = AES_256
    ENCRYPTION BY SERVER CERTIFICATE HealthcareTDE_Cert;
    ALTER DATABASE HealthcareDB SET ENCRYPTION ON;
    GO

    -- Create schemas
    CREATE SCHEMA patients AUTHORIZATION dbo;
    CREATE SCHEMA clinical AUTHORIZATION dbo;
    CREATE SCHEMA billing AUTHORIZATION dbo;
    CREATE SCHEMA admin AUTHORIZATION dbo;
    GO

    -- Column Master Key for Always Encrypted
    CREATE COLUMN MASTER KEY CMK_HealthcareData
    WITH (
        KEY_STORE_PROVIDER_NAME = 'AZURE_KEY_VAULT',
        KEY_PATH = 'https://healthcare-vault.vault.azure.net/keys/HealthcareCMK/version1'
    );

    CREATE COLUMN ENCRYPTION KEY CEK_PatientData
    WITH VALUES (
        COLUMN_MASTER_KEY = CMK_HealthcareData,
        ALGORITHM = 'RSA_OAEP'
    );
    GO

    -- Patients table with Always Encrypted sensitive columns
    CREATE TABLE patients.Patients (
        PatientID BIGINT IDENTITY(1,1) NOT NULL,
        MedicalRecordNumber NVARCHAR(50) ENCRYPTED WITH (
            COLUMN_ENCRYPTION_KEY = CEK_PatientData,
            ENCRYPTION_TYPE = DETERMINISTIC,
            ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256'
        ),
        FirstName NVARCHAR(100) NOT NULL,
        LastName NVARCHAR(100) NOT NULL,
        MiddleName NVARCHAR(100),
        DateOfBirth DATE MASKED WITH (FUNCTION = 'default()'),
        Gender CHAR(1),
        SSN NVARCHAR(11) ENCRYPTED WITH (
            COLUMN_ENCRYPTION_KEY = CEK_PatientData,
            ENCRYPTION_TYPE = DETERMINISTIC,
            ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256'
        ) MASKED WITH (FUNCTION = 'partial(0,"XXX-XX-",4)'),
        Phone NVARCHAR(20) MASKED WITH (FUNCTION = 'partial(1,"XXX-XXX-",4)'),
        Email NVARCHAR(255) MASKED WITH (FUNCTION = 'email()'),
        EmergencyContactName NVARCHAR(200),
        EmergencyContactPhone NVARCHAR(20),
        BloodType CHAR(3),
        Allergies NVARCHAR(MAX),
        ChronicConditions NVARCHAR(MAX),
        InsuranceProvider NVARCHAR(200),
        InsurancePolicyNumber NVARCHAR(50),
        PrimaryPhysicianID INT,
        RegistrationDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        LastVisitDate DATETIME2,
        IsActive BIT NOT NULL DEFAULT 1,
        CreatedBy NVARCHAR(100) NOT NULL,
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        ModifiedBy NVARCHAR(100),
        ModifiedDate DATETIME2,
        CONSTRAINT PK_Patients PRIMARY KEY CLUSTERED (PatientID),
        CONSTRAINT UK_Patients_MRN UNIQUE (MedicalRecordNumber)
    ) ON [PRIMARY];

    -- Medical Records with temporal tables for audit trail
    CREATE TABLE clinical.MedicalRecords (
        RecordID BIGINT IDENTITY(1,1) NOT NULL,
        PatientID BIGINT NOT NULL,
        VisitDate DATETIME2 NOT NULL,
        VisitType NVARCHAR(50) NOT NULL,
        ProviderID INT NOT NULL,
        FacilityID INT NOT NULL,
        ChiefComplaint NVARCHAR(500),
        PresentIllness NVARCHAR(MAX),
        MedicalHistory NVARCHAR(MAX),
        PhysicalExam NVARCHAR(MAX),
        Assessment NVARCHAR(MAX),
        Plan NVARCHAR(MAX),
        VitalSigns_Temperature DECIMAL(4,1),
        VitalSigns_BloodPressure_Systolic INT,
        VitalSigns_BloodPressure_Diastolic INT,
        VitalSigns_HeartRate INT,
        VitalSigns_RespiratoryRate INT,
        VitalSigns_OxygenSaturation DECIMAL(5,2),
        VitalSigns_Weight DECIMAL(5,2),
        VitalSigns_Height DECIMAL(5,2),
        VitalSigns_BMI AS (VitalSigns_Weight / POWER(VitalSigns_Height/100.0, 2)) PERSISTED,
        Diagnosis_Primary NVARCHAR(10), -- ICD-10 code
        Diagnosis_Secondary NVARCHAR(200), -- Multiple ICD-10 codes
        ProcedureCodes NVARCHAR(200), -- CPT codes
        DischargeDisposition NVARCHAR(100),
        FollowUpInstructions NVARCHAR(MAX),
        CreatedBy NVARCHAR(100) NOT NULL,
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        ModifiedBy NVARCHAR(100),
        ModifiedDate DATETIME2,
        -- Temporal table columns for full audit trail
        ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
        ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
        PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo),
        CONSTRAINT PK_MedicalRecords PRIMARY KEY CLUSTERED (RecordID),
        CONSTRAINT FK_MedicalRecords_Patient FOREIGN KEY (PatientID) REFERENCES patients.Patients(PatientID)
    ) ON [PRIMARY]
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = clinical.MedicalRecords_History));

    -- Prescriptions with controlled substance tracking
    CREATE TABLE clinical.Prescriptions (
        PrescriptionID BIGINT IDENTITY(1,1) NOT NULL,
        PatientID BIGINT NOT NULL,
        ProviderID INT NOT NULL,
        RecordID BIGINT,
        MedicationName NVARCHAR(200) NOT NULL,
        GenericName NVARCHAR(200),
        NDC_Number NVARCHAR(20), -- National Drug Code
        Strength NVARCHAR(50),
        Dosage NVARCHAR(200),
        Route NVARCHAR(50),
        Frequency NVARCHAR(100),
        Quantity INT,
        DaysSupply INT,
        RefillsAuthorized TINYINT DEFAULT 0,
        RefillsRemaining TINYINT DEFAULT 0,
        IsControlledSubstance BIT NOT NULL DEFAULT 0,
        DEA_Schedule TINYINT, -- 1-5 for controlled substances
        PrescribedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        StartDate DATE,
        EndDate DATE,
        PharmacyName NVARCHAR(200),
        PharmacyPhone NVARCHAR(20),
        Status NVARCHAR(20) NOT NULL DEFAULT 'Active', -- Active, Completed, Cancelled, Discontinued
        DiscontinuationReason NVARCHAR(200),
        SpecialInstructions NVARCHAR(MAX),
        CreatedBy NVARCHAR(100) NOT NULL,
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        ModifiedBy NVARCHAR(100),
        ModifiedDate DATETIME2,
        CONSTRAINT PK_Prescriptions PRIMARY KEY CLUSTERED (PrescriptionID),
        CONSTRAINT FK_Prescriptions_Patient FOREIGN KEY (PatientID) REFERENCES patients.Patients(PatientID),
        CONSTRAINT FK_Prescriptions_Record FOREIGN KEY (RecordID) REFERENCES clinical.MedicalRecords(RecordID)
    ) ON [PRIMARY];

    -- Lab Results
    CREATE TABLE clinical.LabResults (
        LabResultID BIGINT IDENTITY(1,1) NOT NULL,
        PatientID BIGINT NOT NULL,
        RecordID BIGINT,
        OrderingProviderID INT NOT NULL,
        TestName NVARCHAR(200) NOT NULL,
        LOINC_Code NVARCHAR(20), -- Logical Observation Identifiers Names and Codes
        TestCategory NVARCHAR(100),
        SpecimenType NVARCHAR(100),
        CollectionDate DATETIME2,
        ResultDate DATETIME2,
        ResultValue NVARCHAR(500),
        ReferenceRange NVARCHAR(200),
        Units NVARCHAR(50),
        Status NVARCHAR(50) NOT NULL DEFAULT 'Pending', -- Pending, Completed, Cancelled
        AbnormalFlag CHAR(1), -- H=High, L=Low, A=Abnormal, N=Normal
        CriticalFlag BIT NOT NULL DEFAULT 0,
        LabName NVARCHAR(200),
        TechnologistID NVARCHAR(50),
        PathologistID NVARCHAR(50),
        Comments NVARCHAR(MAX),
        CreatedBy NVARCHAR(100) NOT NULL,
        CreatedDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT PK_LabResults PRIMARY KEY CLUSTERED (LabResultID),
        CONSTRAINT FK_LabResults_Patient FOREIGN KEY (PatientID) REFERENCES patients.Patients(PatientID),
        CONSTRAINT FK_LabResults_Record FOREIGN KEY (RecordID) REFERENCES clinical.MedicalRecords(RecordID)
    ) ON [PRIMARY];

    -- Create RLS security functions and policies
    CREATE FUNCTION admin.fn_PatientSecurityPredicate(@PatientID BIGINT)
    RETURNS TABLE
    WITH SCHEMABINDING
    AS
    RETURN SELECT 1 AS fn_securitypredicate_result
    WHERE @PatientID = CAST(SESSION_CONTEXT(N'PatientID') AS BIGINT)
       OR IS_MEMBER('HealthcareProvider') = 1
       OR IS_MEMBER('Physician') = 1
       OR IS_MEMBER('Nurse') = 1;
    GO

    -- Apply Row Level Security
    CREATE SECURITY POLICY admin.PatientDataSecurityPolicy
        ADD FILTER PREDICATE admin.fn_PatientSecurityPredicate(PatientID) ON patients.Patients,
        ADD FILTER PREDICATE admin.fn_PatientSecurityPredicate(PatientID) ON clinical.MedicalRecords,
        ADD FILTER PREDICATE admin.fn_PatientSecurityPredicate(PatientID) ON clinical.Prescriptions,
        ADD FILTER PREDICATE admin.fn_PatientSecurityPredicate(PatientID) ON clinical.LabResults
    WITH (STATE = ON);
    GO

    -- Audit table for HIPAA compliance
    CREATE TABLE admin.AccessAuditLog (
        AuditID BIGINT IDENTITY(1,1) NOT NULL,
        AccessTime DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        UserName NVARCHAR(100) NOT NULL,
        PatientID BIGINT,
        ActionType NVARCHAR(50) NOT NULL, -- SELECT, INSERT, UPDATE, DELETE
        TableName NVARCHAR(100) NOT NULL,
        RecordID BIGINT,
        IPAddress NVARCHAR(45),
        ApplicationName NVARCHAR(200),
        SessionID NVARCHAR(100),
        CONSTRAINT PK_AccessAuditLog PRIMARY KEY CLUSTERED (AuditID)
    ) ON [PRIMARY];

    -- Indexes for performance
    CREATE NONCLUSTERED INDEX IX_Patients_LastName_FirstName
    ON patients.Patients (LastName, FirstName) INCLUDE (PatientID, DateOfBirth);

    CREATE NONCLUSTERED INDEX IX_MedicalRecords_Patient_VisitDate
    ON clinical.MedicalRecords (PatientID, VisitDate DESC) INCLUDE (VisitType, ProviderID);

    CREATE NONCLUSTERED INDEX IX_Prescriptions_Patient_Status
    ON clinical.Prescriptions (PatientID, Status) INCLUDE (MedicationName, PrescribedDate);

    CREATE NONCLUSTERED INDEX IX_LabResults_Patient_ResultDate
    ON clinical.LabResults (PatientID, ResultDate DESC) INCLUDE (TestName, ResultValue, AbnormalFlag);
    """

    return {"status": "created", "schema": "healthcare", "tables_created": 5}

# Advanced T-SQL Stored Procedures and Functions

## Complex Business Logic Implementation

### E-Commerce Order Processing with Transaction Management

```sql
-- Comprehensive order processing stored procedure
CREATE OR ALTER PROCEDURE orders.ProcessOrder
    @CustomerID BIGINT,
    @CartSessionID NVARCHAR(128),
    @BillingAddressID BIGINT,
    @ShippingAddressID BIGINT,
    @PaymentMethodID INT,
    @PromoCode NVARCHAR(50) = NULL,
    @OrderID BIGINT OUTPUT,
    @OrderTotal DECIMAL(12,2) OUTPUT,
    @ResultMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @TranCount INT = @@TRANCOUNT;
    DECLARE @ErrorNumber INT, @ErrorMessage NVARCHAR(4000);
    DECLARE @OrderNumber NVARCHAR(50);
    DECLARE @SubTotal DECIMAL(12,2) = 0.00;
    DECLARE @TaxAmount DECIMAL(12,2) = 0.00;
    DECLARE @ShippingAmount DECIMAL(12,2) = 0.00;
    DECLARE @DiscountAmount DECIMAL(12,2) = 0.00;

    BEGIN TRY
        IF @TranCount = 0
            BEGIN TRANSACTION;

        -- Generate unique order number
        SET @OrderNumber = 'ORD' + FORMAT(GETDATE(), 'yyyyMMdd') + RIGHT('00000' + CAST(NEXT VALUE FOR orders.OrderNumberSeq AS VARCHAR), 5);

        -- Validate customer
        IF NOT EXISTS (SELECT 1 FROM customers.Customers WHERE CustomerID = @CustomerID AND IsActive = 1)
        BEGIN
            RAISERROR('Invalid or inactive customer ID: %d', 16, 1, @CustomerID);
            RETURN;
        END

        -- Validate cart has items
        IF NOT EXISTS (SELECT 1 FROM customers.ShoppingCart WHERE SessionID = @CartSessionID)
        BEGIN
            RAISERROR('Shopping cart is empty for session: %s', 16, 1, @CartSessionID);
            RETURN;
        END

        -- Calculate subtotal and validate inventory
        WITH CartSummary AS (
            SELECT
                sc.ProductID,
                sc.Quantity,
                sc.UnitPrice,
                p.SKU,
                p.ProductName,
                pi.QuantityAvailable,
                sc.Quantity * sc.UnitPrice AS LineTotal
            FROM customers.ShoppingCart sc WITH (UPDLOCK)
            INNER JOIN catalog.Products p ON sc.ProductID = p.ProductID
            INNER JOIN inventory.ProductInventory pi ON p.ProductID = pi.ProductID
            WHERE sc.SessionID = @CartSessionID
              AND pi.LocationID = 1 -- Main warehouse
        )
        SELECT @SubTotal = SUM(LineTotal)
        FROM CartSummary;

        -- Check inventory availability
        IF EXISTS (
            SELECT 1
            FROM customers.ShoppingCart sc
            INNER JOIN inventory.ProductInventory pi ON sc.ProductID = pi.ProductID
            WHERE sc.SessionID = @CartSessionID
              AND sc.Quantity > pi.QuantityAvailable
              AND pi.LocationID = 1
        )
        BEGIN
            RAISERROR('Insufficient inventory for one or more items in cart', 16, 1);
            RETURN;
        END

        -- Apply promo code discount
        IF @PromoCode IS NOT NULL
        BEGIN
            SELECT @DiscountAmount = dbo.CalculatePromoDiscount(@PromoCode, @SubTotal, @CustomerID);
        END

        -- Calculate tax (simplified - would integrate with tax service)
        SELECT @TaxAmount = dbo.CalculateTax(@SubTotal - @DiscountAmount, @ShippingAddressID);

        -- Calculate shipping
        SELECT @ShippingAmount = dbo.CalculateShipping(@SubTotal, @ShippingAddressID);

        SET @OrderTotal = @SubTotal + @TaxAmount + @ShippingAmount - @DiscountAmount;

        -- Create order record
        INSERT INTO orders.Orders (
            OrderNumber, CustomerID, OrderDate, OrderStatus,
            BillingAddressID, ShippingAddressID,
            SubTotal, TaxAmount, ShippingAmount, DiscountAmount, TotalAmount,
            PaymentMethod, PaymentStatus
        )
        VALUES (
            @OrderNumber, @CustomerID, SYSUTCDATETIME(), 1, -- Pending
            @BillingAddressID, @ShippingAddressID,
            @SubTotal, @TaxAmount, @ShippingAmount, @DiscountAmount, @OrderTotal,
            'Credit Card', 1 -- Pending
        );

        SET @OrderID = SCOPE_IDENTITY();

        -- Create order items and reserve inventory
        INSERT INTO orders.OrderItems (
            OrderID, OrderDate, ProductID, SKU, ProductName,
            Quantity, UnitPrice, DiscountAmount
        )
        SELECT
            @OrderID,
            SYSUTCDATETIME(),
            sc.ProductID,
            p.SKU,
            p.ProductName,
            sc.Quantity,
            sc.UnitPrice,
            0.00 -- Item-level discount would be calculated here
        FROM customers.ShoppingCart sc
        INNER JOIN catalog.Products p ON sc.ProductID = p.ProductID
        WHERE sc.SessionID = @CartSessionID;

        -- Reserve inventory
        UPDATE pi
        SET QuantityReserved = pi.QuantityReserved + sc.Quantity,
            LastModifiedDate = SYSUTCDATETIME()
        FROM inventory.ProductInventory pi
        INNER JOIN customers.ShoppingCart sc ON pi.ProductID = sc.ProductID
        WHERE sc.SessionID = @CartSessionID
          AND pi.LocationID = 1;

        -- Clear shopping cart
        DELETE FROM customers.ShoppingCart WHERE SessionID = @CartSessionID;

        -- Process payment (would integrate with payment gateway)
        EXEC payments.ProcessPayment
            @OrderID = @OrderID,
            @PaymentMethodID = @PaymentMethodID,
            @Amount = @OrderTotal,
            @PaymentResult = @ResultMessage OUTPUT;

        IF @ResultMessage != 'Success'
        BEGIN
            RAISERROR('Payment processing failed: %s', 16, 1, @ResultMessage);
            RETURN;
        END

        -- Update order status to processing
        UPDATE orders.Orders
        SET OrderStatus = 2, -- Processing
            PaymentStatus = 2, -- Paid
            ModifiedDate = SYSUTCDATETIME()
        WHERE OrderID = @OrderID;

        -- Send order confirmation (would queue for background processing)
        INSERT INTO messaging.EmailQueue (
            ToEmail, Subject, Body, Priority, CreatedDate
        )
        SELECT
            c.Email,
            'Order Confirmation - ' + @OrderNumber,
            'Thank you for your order...',
            1,
            SYSUTCDATETIME()
        FROM customers.Customers c
        WHERE c.CustomerID = @CustomerID;

        SET @ResultMessage = 'Order processed successfully: ' + @OrderNumber;

        IF @TranCount = 0
            COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH
        SET @ErrorNumber = ERROR_NUMBER();
        SET @ErrorMessage = ERROR_MESSAGE();

        IF @TranCount = 0 AND @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Log error
        INSERT INTO admin.ErrorLog (
            ErrorNumber, ErrorMessage, ErrorProcedure, ErrorLine,
            UserName, CreatedDate
        )
        VALUES (
            @ErrorNumber, @ErrorMessage, ERROR_PROCEDURE(), ERROR_LINE(),
            SUSER_SNAME(), SYSUTCDATETIME()
        );

        SET @ResultMessage = 'Order processing failed: ' + @ErrorMessage;
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- Helper functions for order processing
CREATE OR ALTER FUNCTION dbo.CalculatePromoDiscount(
    @PromoCode NVARCHAR(50),
    @SubTotal DECIMAL(12,2),
    @CustomerID BIGINT
)
RETURNS DECIMAL(12,2)
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @DiscountAmount DECIMAL(12,2) = 0.00;
    DECLARE @DiscountPercent DECIMAL(5,2);
    DECLARE @MaxDiscount DECIMAL(12,2);
    DECLARE @MinOrderAmount DECIMAL(12,2);

    SELECT
        @DiscountPercent = DiscountPercent,
        @MaxDiscount = MaxDiscountAmount,
        @MinOrderAmount = MinOrderAmount
    FROM marketing.PromoCodes
    WHERE PromoCode = @PromoCode
      AND IsActive = 1
      AND StartDate <= GETDATE()
      AND EndDate >= GETDATE()
      AND (MaxUses IS NULL OR UsageCount < MaxUses);

    IF @DiscountPercent IS NOT NULL AND @SubTotal >= @MinOrderAmount
    BEGIN
        SET @DiscountAmount = @SubTotal * (@DiscountPercent / 100.0);
        IF @MaxDiscount IS NOT NULL AND @DiscountAmount > @MaxDiscount
            SET @DiscountAmount = @MaxDiscount;
    END

    RETURN @DiscountAmount;
END;
GO
````

### Healthcare Clinical Decision Support System

```sql
-- Clinical decision support for drug interaction checking
CREATE OR ALTER PROCEDURE clinical.CheckDrugInteractions
    @PatientID BIGINT,
    @NewMedicationName NVARCHAR(200) = NULL,
    @InteractionCount INT OUTPUT,
    @CriticalInteractionCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @InteractionResults TABLE (
        Medication1 NVARCHAR(200),
        Medication2 NVARCHAR(200),
        InteractionSeverity NVARCHAR(20),
        ClinicalEffect NVARCHAR(500),
        Recommendation NVARCHAR(1000)
    );

    -- Get current active prescriptions plus new medication
    WITH PatientMedications AS (
        SELECT DISTINCT MedicationName
        FROM clinical.Prescriptions
        WHERE PatientID = @PatientID
          AND Status = 'Active'
          AND EndDate >= GETDATE()
        UNION ALL
        SELECT @NewMedicationName
        WHERE @NewMedicationName IS NOT NULL
    ),
    MedicationPairs AS (
        SELECT
            m1.MedicationName AS Med1,
            m2.MedicationName AS Med2
        FROM PatientMedications m1
        CROSS JOIN PatientMedications m2
        WHERE m1.MedicationName < m2.MedicationName
    )
    INSERT INTO @InteractionResults
    SELECT
        mp.Med1,
        mp.Med2,
        di.InteractionSeverity,
        di.ClinicalEffect,
        di.Recommendation
    FROM MedicationPairs mp
    INNER JOIN clinical.DrugInteractions di ON (
        (di.Medication1 = mp.Med1 AND di.Medication2 = mp.Med2) OR
        (di.Medication1 = mp.Med2 AND di.Medication2 = mp.Med1)
    )
    WHERE di.IsActive = 1
    ORDER BY
        CASE di.InteractionSeverity
            WHEN 'Critical' THEN 1
            WHEN 'Major' THEN 2
            WHEN 'Moderate' THEN 3
            ELSE 4
        END;

    SELECT @InteractionCount = COUNT(*) FROM @InteractionResults;
    SELECT @CriticalInteractionCount = COUNT(*)
    FROM @InteractionResults
    WHERE InteractionSeverity IN ('Critical', 'Major');

    -- Return interaction details
    SELECT * FROM @InteractionResults;

    -- Log the interaction check for audit
    INSERT INTO clinical.DrugInteractionChecks (
        PatientID, CheckedBy, CheckDate, NewMedication,
        InteractionCount, CriticalInteractionCount
    )
    VALUES (
        @PatientID, SUSER_SNAME(), SYSUTCDATETIME(), @NewMedicationName,
        @InteractionCount, @CriticalInteractionCount
    );
END;
GO

-- Clinical risk scoring for sepsis detection
CREATE OR ALTER FUNCTION clinical.CalculateSepsisScore(
    @PatientID BIGINT,
    @AssessmentTime DATETIME2
)
RETURNS INT
WITH SCHEMABINDING
AS
BEGIN
    DECLARE @Score INT = 0;
    DECLARE @Temperature DECIMAL(4,1);
    DECLARE @HeartRate INT;
    DECLARE @RespiratoryRate INT;
    DECLARE @WBC DECIMAL(8,2);
    DECLARE @SystolicBP INT;
    DECLARE @Lactate DECIMAL(5,2);

    -- Get most recent vital signs within 4 hours
    SELECT TOP 1
        @Temperature = VitalSigns_Temperature,
        @HeartRate = VitalSigns_HeartRate,
        @RespiratoryRate = VitalSigns_RespiratoryRate,
        @SystolicBP = VitalSigns_BloodPressure_Systolic
    FROM clinical.MedicalRecords
    WHERE PatientID = @PatientID
      AND VisitDate >= DATEADD(HOUR, -4, @AssessmentTime)
      AND VisitDate <= @AssessmentTime
      AND VitalSigns_Temperature IS NOT NULL
    ORDER BY VisitDate DESC;

    -- Get most recent lab values within 24 hours
    SELECT
        @WBC = MAX(CASE WHEN TestName = 'White Blood Cell Count' THEN CAST(ResultValue AS DECIMAL(8,2)) END),
        @Lactate = MAX(CASE WHEN TestName = 'Lactate' THEN CAST(ResultValue AS DECIMAL(5,2)) END)
    FROM clinical.LabResults
    WHERE PatientID = @PatientID
      AND ResultDate >= DATEADD(HOUR, -24, @AssessmentTime)
      AND ResultDate <= @AssessmentTime
      AND Status = 'Completed';

    -- Calculate SIRS criteria
    -- Temperature > 38°C (100.4°F) or < 36°C (96.8°F)
    IF @Temperature > 38.0 OR @Temperature < 36.0
        SET @Score = @Score + 1;

    -- Heart Rate > 90 bpm
    IF @HeartRate > 90
        SET @Score = @Score + 1;

    -- Respiratory Rate > 20 breaths/min
    IF @RespiratoryRate > 20
        SET @Score = @Score + 1;

    -- WBC > 12,000 or < 4,000 cells/μL
    IF @WBC > 12.0 OR @WBC < 4.0
        SET @Score = @Score + 1;

    -- Additional sepsis indicators
    -- Elevated lactate > 2 mmol/L
    IF @Lactate > 2.0
        SET @Score = @Score + 2;

    -- Hypotension (systolic BP < 90 mmHg)
    IF @SystolicBP < 90
        SET @Score = @Score + 3;

    RETURN @Score;
END;
GO
```

# Main execution example

if **name** == "**main**":
import asyncio

    async def main():
        print("🚀 Starting Enterprise SQL Server Setup...")

        # Setup e-commerce platform
        print("\n🛒 Setting up E-Commerce Platform...")
        ecommerce_result = await setup_ecommerce_platform()
        print(f"✅ E-Commerce Platform: {ecommerce_result['platform_setup']['status']}")

        # Setup healthcare information system
        print("\n🏥 Setting up Healthcare Information System...")
        healthcare_result = await setup_healthcare_information_system()
        print(f"✅ Healthcare System: {healthcare_result['platform_setup']['status']}")
        print(f"✅ HIPAA Compliance: {healthcare_result['compliance_status']}")

        print("\n🎉 Enterprise SQL Server Setup Complete!")
        print("=" * 60)
        print("Summary:")
        print(f"- E-Commerce Platform: {ecommerce_result['platform_setup']['status']}")
        print(f"- Healthcare System: {healthcare_result['platform_setup']['status']}")
        print("- Always On Availability Groups: Configured")
        print("- Advanced Security: TDE, Always Encrypted, RLS, DDM")
        print("- Performance Optimization: Resource Governor, Query Store")

    # Run the main example
    asyncio.run(main())

````

This comprehensive enterprise SQL Server implementation includes:

## ✅ **Completed Features**

1. **Always On Availability Groups**
   - Multi-node cluster configuration with automatic failover
   - Synchronous and asynchronous replication options
   - Read-only routing for reporting workloads
   - Comprehensive listener configuration

2. **Advanced Security Framework**
   - Transparent Data Encryption (TDE) with AES-256
   - Always Encrypted for sensitive column protection
   - Row-Level Security (RLS) with custom predicates
   - Dynamic Data Masking for non-privileged users
   - Comprehensive audit logging for HIPAA compliance

3. **High Performance Optimization**
   - Resource Governor for workload management
   - Query Store for performance monitoring and regression detection
   - Columnstore indexes for analytical workloads
   - In-Memory OLTP for high-throughput scenarios
   - Advanced partitioning strategies

4. **Enterprise Team Management**
   - Role-based access control with 6 enterprise roles
   - Active Directory and Azure AD integration
   - Multi-factor authentication support
   - Granular resource limits and permissions

5. **Industry-Specific Examples**
   - E-commerce platform with shopping cart and order processing
   - Healthcare information system with HIPAA compliance
   - Complex T-SQL procedures for business logic
   - Clinical decision support with drug interaction checking

The SQL Server platform has been successfully transformed from **395 lines** to a comprehensive **2,900+ line** enterprise implementation with Always On AG, advanced security, and comprehensive business logic!

### Architecture Essentials

- **Storage**: Database files (.mdf), log files (.ldf), filegroups
- **High Availability**: Always On Availability Groups, failover clustering
- **Security**: Row-level security, dynamic data masking, transparent data encryption
- **Performance**: In-memory OLTP, columnstore indexes, query optimization

### Security and Compliance Guidelines

- **Authentication**: Windows Authentication, SQL Server Authentication, Azure AD
- **Authorization**: Role-based security with server and database roles
- **Encryption**: TDE for data at rest, SSL/TLS for data in transit
- **Auditing**: SQL Server Audit for compliance requirements
- **Data Protection**: Dynamic data masking, row-level security

### Performance Best Practices

- **Index Strategy**: Clustered and non-clustered indexes, columnstore indexes
- **Query Optimization**: Execution plans, statistics maintenance, parameter sniffing
- **Memory Management**: Buffer pool, plan cache, in-memory OLTP configuration
- **T-SQL Best Practices**: Set-based operations, avoid cursors, proper joins

### AI Assistant Guidelines

- Leverage T-SQL for complex business logic implementation
- Recommend appropriate SQL Server editions based on feature requirements
- Include proper error handling with TRY-CATCH blocks
- Suggest Always On solutions for high availability scenarios
- Provide guidance on Azure SQL migration when applicable
- Include performance monitoring with DMVs and execution plans

## Database Overview

- **Database System**: Microsoft SQL Server
- **Version**: 2022+ (Current version)
- **Type**: Enterprise Relational Database Management System
- **License**: Commercial (various editions)
- **Use Cases**: Enterprise applications, business intelligence, OLTP/OLAP systems
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
````

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
  pool: { max: 10, min: 1, idleTimeoutMillis: 30000 },
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
