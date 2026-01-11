---
name: 'Oracle Database Instructions'
description: 'Comprehensive Oracle Database implementation guide covering enterprise RDBMS features, PL/SQL development, performance optimization, security, and advanced database administration for mission-critical applications.'
keywords: [oracle, rdbms, enterprise, plsql, performance, security, administration, database, sql]
---

# Oracle Database Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents implementing Oracle Database solutions, emphasizing enterprise-grade features, PL/SQL development, performance optimization, and mission-critical database administration.

### When to Use Oracle Database

- **Enterprise applications** requiring maximum reliability and performance
- **Complex business logic** best implemented with PL/SQL stored procedures
- **Large-scale data warehousing** with advanced analytics capabilities
- **Mission-critical systems** requiring 99.99%+ uptime
- **Regulatory compliance** in financial and healthcare industries

### When to Avoid Oracle Database

- **Cost-sensitive projects** with limited budgets → consider PostgreSQL or MySQL
- **Simple applications** not requiring enterprise features → use lighter alternatives
- **Rapid prototyping** where licensing complexity is prohibitive
- **Cloud-native applications** preferring managed database services

### Architecture Essentials

- **Enterprise Features**: RAC clustering, Data Guard, Advanced Security Option
- **Storage Management**: Automatic Storage Management (ASM), tablespaces
- **High Availability**: Real Application Clusters, standby databases
- **Performance**: Cost-based optimizer, parallel processing, partitioning

# Enterprise Oracle Database Configuration

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Union
from enum import Enum
import asyncio
import logging
from datetime import datetime, timedelta

class OracleTier(Enum):
STANDARD = "standard"
ENTERPRISE = "enterprise"  
 ENTERPRISE_PLUS = "enterprise_plus"
EXADATA = "exadata"

class OracleEnvironment(Enum):
DEVELOPMENT = "development"
TESTING = "testing"
STAGING = "staging"
PRODUCTION = "production"
DISASTER_RECOVERY = "disaster_recovery"

class OracleDeployment(Enum):
SINGLE_INSTANCE = "single_instance"
RAC_CLUSTER = "rac_cluster"
CLOUD_AUTONOMOUS = "cloud_autonomous"
EXADATA_CLOUD = "exadata_cloud"
HYBRID_CLOUD = "hybrid_cloud"

class OracleWorkloadType(Enum):
OLTP = "oltp"
OLAP = "olap"
MIXED = "mixed"
DATA_WAREHOUSE = "data_warehouse"
JSON_WORKLOAD = "json_workload"

@dataclass
class EnterpriseOracleConfig:
"""Comprehensive Oracle Database enterprise configuration"""

    # System Identification
    system_id: str
    organization_name: str
    tier: OracleTier = OracleTier.ENTERPRISE
    environment: OracleEnvironment = OracleEnvironment.PRODUCTION
    deployment_type: OracleDeployment = OracleDeployment.RAC_CLUSTER
    workload_type: OracleWorkloadType = OracleWorkloadType.MIXED

    # Team Management and SSO Integration
    team_management: Dict[str, Any] = field(default_factory=lambda: {
        "sso_enabled": True,
        "sso_provider": "active_directory",  # active_directory, ldap, oauth2, saml
        "multi_factor_authentication": True,
        "password_policy": {
            "complexity_required": True,
            "min_length": 12,
            "rotation_days": 90,
            "history_count": 12
        },
        "role_based_access": True,
        "roles": [
            {
                "name": "database_administrator",
                "permissions": [
                    "system_admin", "backup_recovery", "security_admin",
                    "performance_tuning", "schema_management", "user_management"
                ],
                "oracle_roles": ["DBA", "SYSDBA", "SYSOPER"],
                "resource_limits": {
                    "sessions_per_user": "UNLIMITED",
                    "cpu_per_session": "UNLIMITED",
                    "logical_reads_per_session": "UNLIMITED",
                    "connect_time": "UNLIMITED"
                }
            },
            {
                "name": "data_architect",
                "permissions": [
                    "schema_design", "data_modeling", "performance_analysis",
                    "partitioning_design", "index_management"
                ],
                "oracle_roles": ["RESOURCE", "CREATE VIEW", "CREATE MATERIALIZED VIEW"],
                "resource_limits": {
                    "sessions_per_user": "10",
                    "cpu_per_session": "UNLIMITED",
                    "logical_reads_per_session": "50000000",
                    "connect_time": "480"  # 8 hours
                }
            },
            {
                "name": "application_developer",
                "permissions": [
                    "pl_sql_development", "package_creation", "procedure_creation",
                    "function_creation", "trigger_development"
                ],
                "oracle_roles": ["RESOURCE", "CREATE PROCEDURE", "CREATE TRIGGER"],
                "resource_limits": {
                    "sessions_per_user": "5",
                    "cpu_per_session": "600000",  # 10 minutes
                    "logical_reads_per_session": "10000000",
                    "connect_time": "480"
                }
            },
            {
                "name": "data_analyst",
                "permissions": [
                    "data_querying", "report_generation", "analytics_functions",
                    "statistical_analysis"
                ],
                "oracle_roles": ["CONNECT", "SELECT_CATALOG_ROLE"],
                "resource_limits": {
                    "sessions_per_user": "3",
                    "cpu_per_session": "300000",  # 5 minutes
                    "logical_reads_per_session": "5000000",
                    "connect_time": "240"  # 4 hours
                }
            },
            {
                "name": "business_user",
                "permissions": [
                    "read_only_access", "basic_reporting", "dashboard_view"
                ],
                "oracle_roles": ["CONNECT"],
                "resource_limits": {
                    "sessions_per_user": "2",
                    "cpu_per_session": "120000",  # 2 minutes
                    "logical_reads_per_session": "1000000",
                    "connect_time": "120"  # 2 hours
                }
            },
            {
                "name": "security_officer",
                "permissions": [
                    "audit_management", "security_monitoring", "compliance_reporting",
                    "vault_management"
                ],
                "oracle_roles": ["AUDIT_ADMIN", "DV_OWNER", "DV_ADMIN"],
                "resource_limits": {
                    "sessions_per_user": "5",
                    "cpu_per_session": "UNLIMITED",
                    "logical_reads_per_session": "UNLIMITED",
                    "connect_time": "UNLIMITED"
                }
            }
        ]
    })

    # Infrastructure Configuration
    infrastructure_config: Dict[str, Any] = field(default_factory=lambda: {
        "rac_configuration": {
            "cluster_nodes": [
                {
                    "node_name": "orcl-node1",
                    "hostname": "orcl-node1.company.com",
                    "instance_name": "ORCL1",
                    "instance_number": 1,
                    "cpu_cores": 32,
                    "memory_gb": 256,
                    "storage_gb": 10000
                },
                {
                    "node_name": "orcl-node2",
                    "hostname": "orcl-node2.company.com",
                    "instance_name": "ORCL2",
                    "instance_number": 2,
                    "cpu_cores": 32,
                    "memory_gb": 256,
                    "storage_gb": 10000
                }
            ],
            "interconnect_network": {
                "private_network": "192.168.100.0/24",
                "bandwidth_gbps": 10,
                "redundancy": "dual"
            },
            "shared_storage": {
                "asm_enabled": True,
                "disk_groups": [
                    {
                        "name": "DATA",
                        "redundancy": "EXTERNAL",
                        "size_tb": 20,
                        "disk_type": "SSD"
                    },
                    {
                        "name": "FRA",
                        "redundancy": "EXTERNAL",
                        "size_tb": 10,
                        "disk_type": "SSD"
                    },
                    {
                        "name": "REDO",
                        "redundancy": "NORMAL",
                        "size_tb": 2,
                        "disk_type": "NVME"
                    }
                ]
            }
        },
        "memory_configuration": {
            "sga_target_gb": 128,
            "pga_aggregate_target_gb": 64,
            "buffer_cache_gb": 80,
            "shared_pool_gb": 32,
            "large_pool_gb": 8,
            "java_pool_gb": 4,
            "streams_pool_gb": 4,
            "automatic_memory_management": True
        },
        "storage_configuration": {
            "tablespaces": [
                {
                    "name": "USERS",
                    "type": "PERMANENT",
                    "size_gb": 1000,
                    "autoextend": True,
                    "compression": "ADVANCED"
                },
                {
                    "name": "TEMP",
                    "type": "TEMPORARY",
                    "size_gb": 500,
                    "autoextend": True
                },
                {
                    "name": "UNDO",
                    "type": "UNDO",
                    "size_gb": 200,
                    "autoextend": True,
                    "retention_seconds": 3600
                }
            ],
            "archivelog_mode": True,
            "archive_destination": "/oracle/archive",
            "archive_compression": True
        }
    })

    # Advanced Security Configuration
    security_config: Dict[str, Any] = field(default_factory=lambda: {
        "encryption": {
            "tde_enabled": True,
            "tde_algorithm": "AES256",
            "wallet_location": "/oracle/wallet",
            "tablespace_encryption": True,
            "column_encryption": {
                "enabled": True,
                "sensitive_columns": ["ssn", "credit_card", "bank_account", "salary"]
            },
            "network_encryption": {
                "sqlnet_encryption": "REQUIRED",
                "sqlnet_encryption_types": ["AES256", "AES192", "AES128"],
                "sqlnet_crypto_checksum": "REQUIRED",
                "sqlnet_crypto_checksum_types": ["SHA256", "SHA1"]
            }
        },
        "database_vault": {
            "enabled": True,
            "realms": [
                {
                    "name": "HR_REALM",
                    "description": "Human Resources Data Protection",
                    "objects": ["HR.EMPLOYEES", "HR.SALARIES", "HR.BENEFITS"],
                    "authorized_users": ["hr_admin", "hr_manager"]
                },
                {

*Content optimized for conciseness. See source history or external references for full details.*

---
version: 1.1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
