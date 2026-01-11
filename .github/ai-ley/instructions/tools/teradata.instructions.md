---
name: 'Teradata Enterprise Data Warehouse Instructions'
description: 'Enterprise data warehouse guidance for Teradata Vantage MPP database system, covering advanced SQL, workload management, performance optimization, and analytics for large-scale data operations.'
keywords: [api, cloud, agent, async, architecture, authentication, avoid, cli, azure, aws]
---


# Enterprise Teradata Vantage Data Warehouse Platform

## AI Agent Implementation Guide

### Purpose

Provide comprehensive enterprise-grade guidance for AI agents implementing Teradata Vantage solutions, emphasizing advanced data warehousing, MPP architecture, enterprise analytics, workload management, and governance for large-scale data operations across multi-petabyte environments.

### When to Use Teradata Vantage

- **Enterprise data warehousing** with massive datasets (multi-TB to PB scale) requiring guaranteed performance SLAs
- **Complex analytical queries** requiring advanced SQL, temporal analytics, and parallel processing at scale
- **Mixed workloads** with predictable performance under heavy concurrency and strict resource governance
- **Regulatory environments** requiring comprehensive governance, data lineage, and audit capabilities
- **Mission-critical analytics** where downtime is not acceptable and enterprise support is required
- **Advanced analytics** requiring in-database machine learning, graph analytics, and time-series processing

### When to Avoid Teradata Vantage

- **Cloud-first strategies** with elastic scaling requirements → consider Snowflake, BigQuery, or Redshift Serverless
- **Cost-sensitive projects** with limited enterprise budgets → consider open-source alternatives
- **Simple OLTP applications** → use PostgreSQL, MySQL, or specialized OLTP solutions
- **Rapid prototyping** where complex setup and licensing are prohibitive
- **Small to medium datasets** (<1TB) → consider cloud-native or managed database services
- **Real-time streaming analytics** → consider Apache Kafka, Apache Flink, or cloud streaming services

### Architecture Essentials

- **MPP Architecture**: Massively parallel processing with automatic data distribution across hundreds of nodes
- **Multi-Temperature Storage**: Intelligent data placement across hot, warm, and cold storage tiers
- **Advanced Analytics Engine**: Built-in machine learning, graph analytics, and time-series functions
- **Workload Management**: Enterprise-grade TASM/WLM for query prioritization and resource allocation
- **Multi-Cloud Support**: Deploy across AWS, Azure, Google Cloud, or on-premises infrastructure

import asyncio
import logging
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Union
from datetime import datetime, timedelta
from enum import Enum
import json

class TeradataTier(Enum):
DEVELOPER = "developer"
STANDARD = "standard"
ENTERPRISE = "enterprise"
PREMIUM = "premium"

class TeradataEnvironment(Enum):
DEVELOPMENT = "development"
TESTING = "testing"
STAGING = "staging"
PRODUCTION = "production"

class TeradataDeployment(Enum):
ON_PREMISES = "on_premises"
CLOUD_NATIVE = "cloud_native"
HYBRID = "hybrid"

class TeradataWorkloadType(Enum):
OLAP = "olap"
ETL = "etl"
MIXED = "mixed"
ANALYTICS = "analytics"
REPORTING = "reporting"

@dataclass
class EnterpriseTeradataConfig:
"""Enterprise-level Teradata Vantage configuration for advanced data warehousing"""

    # System Configuration
    system_id: str
    organization_name: str
    tier: TeradataTier = TeradataTier.ENTERPRISE
    environment: TeradataEnvironment = TeradataEnvironment.PRODUCTION
    deployment_type: TeradataDeployment = TeradataDeployment.CLOUD_NATIVE
    workload_type: TeradataWorkloadType = TeradataWorkloadType.MIXED

    # Infrastructure Configuration
    infrastructure_config: Dict[str, Any] = field(default_factory=lambda: {
        "amp_configuration": {
            "total_amps": 256,  # Number of Access Module Processors
            "amps_per_node": 8,
            "nodes": 32,
            "cpu_cores_per_node": 64,
            "memory_per_node_gb": 512,
            "storage_per_node_tb": 50
        },
        "storage_configuration": {
            "hot_storage_tb": 500,
            "warm_storage_tb": 2000,
            "cold_storage_tb": 10000,
            "compression_enabled": True,
            "encryption_at_rest": True,
            "backup_strategy": "incremental_daily"
        },
        "network_configuration": {
            "bynet_speed": "100Gbps",
            "client_network_speed": "10Gbps",
            "network_redundancy": True,
            "load_balancing": True
        }
    })

    # Team Management and Access Control
    team_management: Dict[str, Any] = field(default_factory=lambda: {
        "sso_enabled": True,
        "sso_provider": "active_directory",  # active_directory, ldap, kerberos, okta
        "multi_factor_authentication": True,
        "role_based_access": True,
        "roles": [
            {
                "name": "dba_admin",
                "permissions": [
                    "system_administration", "user_management", "database_creation",
                    "workload_management", "backup_restore", "security_configuration"
                ],
                "resource_limits": {
                    "spool_space_gb": "unlimited",
                    "temp_space_gb": "unlimited",
                    "priority": "rush"
                }
            },
            {
                "name": "data_architect",
                "permissions": [
                    "database_design", "table_creation", "index_management",
                    "statistics_management", "performance_tuning"
                ],
                "resource_limits": {
                    "spool_space_gb": 100000,
                    "temp_space_gb": 50000,
                    "priority": "high"
                }
            },
            {
                "name": "analytics_engineer",
                "permissions": [
                    "data_analysis", "view_creation", "macro_execution",
                    "stored_procedure_execution", "ml_model_training"
                ],
                "resource_limits": {
                    "spool_space_gb": 50000,
                    "temp_space_gb": 25000,
                    "priority": "medium"
                }
            },
            {
                "name": "data_scientist",
                "permissions": [
                    "data_analysis", "ml_model_training", "advanced_analytics",
                    "r_integration", "python_integration"
                ],
                "resource_limits": {
                    "spool_space_gb": 25000,
                    "temp_space_gb": 12500,
                    "priority": "medium"
                }
            },
            {
                "name": "business_analyst",
                "permissions": [
                    "data_query", "view_access", "basic_reporting",
                    "dashboard_creation"
                ],
                "resource_limits": {
                    "spool_space_gb": 5000,
                    "temp_space_gb": 2500,
                    "priority": "low"
                }
            },
            {
                "name": "report_user",
                "permissions": [
                    "data_query", "view_access", "basic_reporting"
                ],
                "resource_limits": {
                    "spool_space_gb": 1000,
                    "temp_space_gb": 500,
                    "priority": "low"
                }
            }
        ],
        "session_management": {
            "session_timeout_minutes": 480,  # 8 hours
            "idle_timeout_minutes": 60,
            "max_concurrent_sessions": 10,
            "password_policy": {
                "min_length": 12,
                "complexity_required": True,
                "expiry_days": 90,
                "history_count": 12
            }
        }
    })

    # Workload Management Configuration
    workload_management: Dict[str, Any] = field(default_factory=lambda: {
        "tasm_enabled": True,
        "workload_definitions": [
            {
                "name": "Critical_ETL",
                "classification_criteria": {
                    "user_groups": ["etl_users"],
                    "applications": ["informatica", "datastage", "talend"],
                    "query_band": "ApplicationName=ETL"
                },
                "performance_goals": {
                    "response_time_goal": 300,  # seconds
                    "priority": 1,
                    "concurrency_limit": 5
                },
                "resource_allocation": {
                    "amp_usage_limit": 100,  # percentage
                    "cpu_usage_limit": 80,
                    "io_usage_limit": 90
                }
            },
            {
                "name": "Executive_Reports",
                "classification_criteria": {
                    "user_groups": ["executives"],
                    "query_band": "Priority=Executive"
                },
                "performance_goals": {
                    "response_time_goal": 30,
                    "priority": 2,
                    "concurrency_limit": 10
                },
                "resource_allocation": {
                    "amp_usage_limit": 60,
                    "cpu_usage_limit": 50,
                    "io_usage_limit": 40
                }
            },
            {
                "name": "Analytics_Workload",
                "classification_criteria": {
                    "user_groups": ["data_scientists", "analytics_engineers"],
                    "query_band": "WorkloadType=Analytics"
                },
                "performance_goals": {
                    "response_time_goal": 600,
                    "priority": 3,
                    "concurrency_limit": 20
                },
                "resource_allocation": {
                    "amp_usage_limit": 80,
                    "cpu_usage_limit": 70,
                    "io_usage_limit": 60
                }
            },
            {
                "name": "Ad_Hoc_Queries",
                "classification_criteria": {
                    "user_groups": ["business_analysts", "report_users"],
                    "default": True
                },
                "performance_goals": {
                    "response_time_goal": 120,
                    "priority": 4,
                    "concurrency_limit": 50
                },
                "resource_allocation": {
                    "amp_usage_limit": 40,
                    "cpu_usage_limit": 30,
                    "io_usage_limit": 30
                }
            }
        ],
        "exception_handling": {
            "runaway_query_timeout": 3600,  # 1 hour
            "spool_space_threshold": 75,  # percentage
            "automatic_abort_enabled": True,
            "notification_enabled": True
        }
    })

    # Security and Compliance Configuration
    security_config: Dict[str, Any] = field(default_factory=lambda: {
        "encryption": {
            "data_at_rest": {
                "enabled": True,
                "algorithm": "AES-256",
                "key_management": "enterprise_vault"
            },
            "data_in_transit": {
                "enabled": True,
                "tls_version": "1.3",
                "certificate_management": "automated"
            },
            "column_level_encryption": {
                "enabled": True,
                "sensitive_columns": ["ssn", "credit_card", "bank_account"]
            }
        },

*Content optimized for conciseness. See source history or external references for full details.*

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
