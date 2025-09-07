---
agentMode: general
applyTo: '**/*.sql,**/migrations/*.php,**/schema/*.php,**/seeds/*.php'
author: AI-LEY
description: Comprehensive database coding and style guide with AI linting hints for database development, covering SQL best practices, schema design, performance optimization, and security standards across multiple database systems.
extensions:
  - .md
guidelines: N/A
instructionType: database
keywords:
  [
    database,
    sql,
    schema,
    migrations,
    performance,
    security,
    best-practices,
    coding-standards,
    ai-linting,
  ]
lastUpdated: '2025-09-03T14:00:00.000000'
technicalQualityScore: 4.8
AIUsabilityScore: 4.8
title: Database Development Instructions
version: 1.1.0
---

# Database Development Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive database development guidelines for AI agents across all database systems, emphasizing SQL best practices, schema design, performance optimization, and security standards for maintainable and scalable database solutions.

### When to Use These Guidelines

- **Multi-database projects** requiring consistent coding standards
- **Team development** where standardization is critical
- **Enterprise applications** with strict code quality requirements
- **Database migrations** and schema management across different systems
- **Cross-platform database development** requiring universal best practices

### Core Principles

- **Database Agnostic**: Guidelines applicable across PostgreSQL, MySQL, MongoDB, etc.
- **Security First**: Parameterized queries, access controls, encryption standards
- **Performance Focused**: Optimization strategies for queries and schema design
- **Maintainability**: Clear naming conventions and documentation standards

# Enterprise Database Management & Strategy Framework

from dataclasses import dataclass, field
from typing import Dict, List, Optional, Any, Union
from enum import Enum
import asyncio
import logging
from datetime import datetime, timedelta

class DatabaseType(Enum):
RELATIONAL = "relational"
DOCUMENT = "document"
GRAPH = "graph"
TIME_SERIES = "time_series"
SEARCH = "search"
CACHE = "cache"
DATA_WAREHOUSE = "data_warehouse"

class DatabaseTier(Enum):
DEVELOPMENT = "development"
TESTING = "testing"
STAGING = "staging"
PRODUCTION = "production"
ANALYTICS = "analytics"
ARCHIVE = "archive"

class DataClassification(Enum):
PUBLIC = "public"
INTERNAL = "internal"
CONFIDENTIAL = "confidential"
RESTRICTED = "restricted"

@dataclass
class EnterpriseDatabaseConfig:
"""Comprehensive enterprise database management configuration"""

    # System Identification
    system_id: str
    organization_name: str
    database_tier: DatabaseTier = DatabaseTier.PRODUCTION
    primary_database_type: DatabaseType = DatabaseType.RELATIONAL

    # Enterprise Architecture Strategy
    architecture_strategy: Dict[str, Any] = field(default_factory=lambda: {
        "polyglot_persistence": {
            "enabled": True,
            "database_mapping": {
                "transactional_data": ["postgresql", "mysql", "sqlserver"],
                "document_data": ["mongodb", "couchdb"],
                "search_data": ["elasticsearch", "solr"],
                "cache_data": ["redis", "memcached"],
                "analytics_data": ["clickhouse", "snowflake", "bigquery"],
                "graph_data": ["neo4j", "amazon_neptune"],
                "time_series_data": ["influxdb", "timescaledb"]
            },
            "data_routing_rules": [
                {
                    "data_type": "user_profiles",
                    "primary_storage": "postgresql",
                    "cache_layer": "redis",
                    "search_index": "elasticsearch"
                },
                {
                    "data_type": "product_catalog",
                    "primary_storage": "mongodb",
                    "cache_layer": "redis",
                    "search_index": "elasticsearch"
                },
                {
                    "data_type": "financial_transactions",
                    "primary_storage": "postgresql",
                    "analytics_storage": "clickhouse",
                    "archive_storage": "s3_parquet"
                }
            ]
        },
        "microservices_data_patterns": {
            "database_per_service": True,
            "shared_databases": False,
            "event_sourcing": {
                "enabled": True,
                "event_store": "postgresql",
                "snapshot_store": "postgresql",
                "projection_stores": ["mongodb", "redis"]
            },
            "cqrs_pattern": {
                "enabled": True,
                "command_store": "postgresql",
                "read_stores": ["mongodb", "redis", "elasticsearch"]
            }
        },
        "data_mesh_architecture": {
            "enabled": True,
            "domain_boundaries": [
                {
                    "domain": "customer_domain",
                    "databases": ["customer_db", "customer_cache", "customer_search"],
                    "data_products": ["customer_profile", "customer_analytics", "customer_events"]
                },
                {
                    "domain": "product_domain",
                    "databases": ["product_db", "product_cache", "product_search"],
                    "data_products": ["product_catalog", "inventory_analytics", "product_events"]
                },
                {
                    "domain": "order_domain",
                    "databases": ["order_db", "order_analytics", "order_events"],
                    "data_products": ["order_history", "order_analytics", "order_events"]
                }
            ]
        }
    })

    # Data Governance Framework
    data_governance: Dict[str, Any] = field(default_factory=lambda: {
        "data_classification": {
            "enabled": True,
            "classification_levels": ["public", "internal", "confidential", "restricted"],
            "automatic_classification_rules": [
                {
                    "pattern": ".*password.*|.*secret.*|.*key.*",
                    "classification": "restricted",
                    "encryption_required": True
                },
                {
                    "pattern": ".*ssn.*|.*social.*|.*tax.*|.*credit.*",
                    "classification": "restricted",
                    "encryption_required": True,
                    "access_audit_required": True
                },
                {
                    "pattern": ".*email.*|.*phone.*|.*address.*",
                    "classification": "confidential",
                    "masking_required": True
                }
            ]
        },
        "data_lineage": {
            "enabled": True,
            "lineage_tracking": "automatic",
            "tools": ["apache_atlas", "datahub", "amundsen"],
            "metadata_store": "postgresql",
            "lineage_visualization": True,
            "impact_analysis": True
        },
        "data_quality": {
            "enabled": True,
            "quality_rules": [
                {
                    "rule_name": "email_format_validation",
                    "rule_type": "format_validation",
                    "pattern": r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    "severity": "error"
                },
                {
                    "rule_name": "phone_format_validation",
                    "rule_type": "format_validation",
                    "pattern": r'^\+?1?[-.\s]?\(?[0-9]{3}\)?[-.\s]?[0-9]{3}[-.\s]?[0-9]{4}$',
                    "severity": "warning"
                },
                {
                    "rule_name": "completeness_check",
                    "rule_type": "completeness",
                    "threshold": 95,
                    "severity": "error"
                }
            ],
            "quality_monitoring": {
                "scheduled_checks": True,
                "real_time_validation": True,
                "quality_dashboard": True
            }
        },
        "data_privacy": {
            "enabled": True,
            "privacy_frameworks": ["gdpr", "ccpa", "hipaa"],
            "right_to_erasure": True,
            "data_portability": True,
            "consent_management": {
                "enabled": True,
                "consent_store": "postgresql",
                "consent_versioning": True
            },
            "anonymization": {
                "techniques": ["k_anonymity", "differential_privacy", "pseudonymization"],
                "anonymization_levels": {
                    "low_risk": "pseudonymization",
                    "medium_risk": "k_anonymity",
                    "high_risk": "differential_privacy"
                }
            }
        }
    })

    # Multi-Database Security Framework
    security_framework: Dict[str, Any] = field(default_factory=lambda: {
        "unified_authentication": {
            "enabled": True,
            "sso_providers": ["active_directory", "okta", "auth0"],
            "multi_factor_authentication": True,
            "certificate_authentication": True,
            "api_key_management": True
        },
        "authorization_strategy": {
            "rbac_enabled": True,
            "abac_enabled": True,
            "database_specific_roles": {
                "postgresql": ["readonly", "readwrite", "admin", "superuser"],
                "mongodb": ["read", "readWrite", "dbAdmin", "userAdmin", "root"],
                "redis": ["default", "readonly", "readwrite"],
                "elasticsearch": ["viewer", "editor", "admin", "superuser"]
            },
            "cross_database_roles": [
                {
                    "role_name": "data_analyst",
                    "permissions": {
                        "postgresql": ["readonly"],
                        "mongodb": ["read"],
                        "elasticsearch": ["viewer"],
                        "redis": ["readonly"]
                    }
                },
                {
                    "role_name": "application_service",
                    "permissions": {
                        "postgresql": ["readwrite"],
                        "mongodb": ["readWrite"],
                        "redis": ["readwrite"]
                    }
                }
            ]
        },
        "encryption_standards": {
            "encryption_at_rest": {
                "enabled": True,
                "algorithms": {
                    "postgresql": "AES-256",
                    "mongodb": "AES-256",
                    "redis": "AES-256",
                    "elasticsearch": "AES-256"
                }
            },
            "encryption_in_transit": {
                "enabled": True,
                "tls_version": "1.3",
                "certificate_management": "automated",
                "mutual_tls": True
            },
            "application_level_encryption": {
                "enabled": True,
                "field_level_encryption": True,
                "key_management": "vault_integration",
                "key_rotation": "automatic"
            }
        },
        "audit_framework": {
            "enabled": True,
            "audit_all_access": True,
            "audit_schema_changes": True,
            "audit_data_changes": True,
            "audit_administrative_operations": True,
            "centralized_audit_log": {
                "enabled": True,
                "log_store": "elasticsearch",
                "log_retention_days": 2555,  # 7 years
                "log_archival": "s3_glacier"
            }
        }
    })

    # Performance and Optimization Strategy
    performance_strategy: Dict[str, Any] = field(default_factory=lambda: {
        "caching_strategy": {
            "multi_level_caching": {
                "enabled": True,
                "levels": [
                    {
                        "level": "application_cache",
                        "technology": "caffeine",
                        "ttl_seconds": 300,
                        "max_size": 10000
                    },
                    {
                        "level": "distributed_cache",
                        "technology": "redis_cluster",
                        "ttl_seconds": 3600,
                        "max_memory": "8gb"
                    },
                    {
                        "level": "database_cache",
                        "technology": "database_specific",
                        "buffer_pool_size": "16gb"
                    }
                ]
            },
            "cache_patterns": [
                {
                    "pattern": "cache_aside",
                    "use_case": "read_heavy_workloads",
                    "implementation": "application_managed"
                },
                {
                    "pattern": "write_through",
                    "use_case": "consistency_critical",
                    "implementation": "cache_managed"
                },
                {
                    "pattern": "write_behind",
                    "use_case": "write_heavy_workloads",
                    "implementation": "async_write"
                }
            ]
        },
        "database_sharding": {
            "enabled": True,
            "sharding_strategies": {
                "horizontal_sharding": {
                    "enabled": True,
                    "shard_key_strategies": [
                        {
                            "table": "users",
                            "shard_key": "user_id",
                            "strategy": "hash_based",
                            "shard_count": 16
                        },
                        {
                            "table": "transactions",
                            "shard_key": "transaction_date",
                            "strategy": "range_based",
                            "partition_interval": "monthly"
                        }
                    ]
                },
                "vertical_sharding": {
                    "enabled": True,
                    "feature_based_separation": True,
                    "microservice_alignment": True
                }
            },
            "cross_shard_queries": {
                "aggregation_service": "presto",
                "federation_layer": "graphql_federation",
                "distributed_transactions": "saga_pattern"
            }
        },
        "read_replica_strategy": {
            "enabled": True,
            "replica_configurations": [
                {
                    "primary_db": "postgresql_primary",
                    "read_replicas": [
                        {
                            "name": "replica_analytics",
                            "location": "same_region",
                            "lag_tolerance_ms": 1000,
                            "workload": "analytics"
                        },
                        {
                            "name": "replica_reporting",
                            "location": "different_region",
                            "lag_tolerance_ms": 5000,
                            "workload": "reporting"
                        }
                    ]
                }
            ],
            "load_balancing": {
                "read_write_split": True,
                "connection_pooling": True,
                "failover_automatic": True
            }
        },
        "query_optimization": {
            "automatic_indexing": {
                "enabled": True,
                "missing_index_detection": True,
                "unused_index_detection": True,
                "index_recommendations": True
            },
            "query_plan_analysis": {
                "enabled": True,
                "slow_query_detection": True,
                "execution_plan_caching": True,
                "query_rewriting": True
            },
            "statistics_management": {
                "auto_update_statistics": True,
                "histogram_generation": True,
                "cardinality_estimation": True
            }
        }
    })

    # Backup and Disaster Recovery
    backup_disaster_recovery: Dict[str, Any] = field(default_factory=lambda: {
        "backup_strategy": {
            "multi_tier_backup": {
                "enabled": True,
                "tiers": [
                    {
                        "tier": "hot_backup",
                        "frequency": "continuous",
                        "technology": "streaming_replication",
                        "rto_minutes": 5,
                        "rpo_minutes": 1
                    },
                    {
                        "tier": "warm_backup",
                        "frequency": "hourly",
                        "technology": "incremental_backup",
                        "rto_minutes": 60,
                        "rpo_minutes": 60,
                        "storage": "ssd"
                    },
                    {
                        "tier": "cold_backup",
                        "frequency": "daily",
                        "technology": "full_backup",
                        "rto_hours": 24,
                        "rpo_hours": 24,
                        "storage": "s3_standard"
                    },
                    {
                        "tier": "archive_backup",
                        "frequency": "weekly",
                        "technology": "compressed_full_backup",
                        "rto_days": 7,
                        "rpo_days": 7,
                        "storage": "s3_glacier"
                    }
                ]
            },
            "cross_region_replication": {
                "enabled": True,
                "primary_region": "us-east-1",
                "backup_regions": ["us-west-2", "eu-west-1"],
                "replication_mode": "asynchronous",
                "failover_automation": True
            },
            "point_in_time_recovery": {
                "enabled": True,
                "retention_days": 35,
                "granularity_minutes": 5,
                "automated_testing": True
            }
        },
        "disaster_recovery": {
            "dr_scenarios": [
                {
                    "scenario": "regional_outage",
                    "rto_hours": 4,
                    "rpo_minutes": 15,
                    "strategy": "cross_region_failover"
                },
                {
                    "scenario": "database_corruption",
                    "rto_hours": 2,
                    "rpo_minutes": 5,
                    "strategy": "point_in_time_recovery"
                },
                {
                    "scenario": "data_center_failure",
                    "rto_hours": 1,
                    "rpo_minutes": 1,
                    "strategy": "hot_standby_activation"
                }
            ],
            "dr_testing": {
                "frequency": "monthly",
                "automated_testing": True,
                "chaos_engineering": True,
                "failover_drills": True
            }
        }
    })

    # Database DevOps and CI/CD
    devops_strategy: Dict[str, Any] = field(default_factory=lambda: {
        "database_as_code": {
            "enabled": True,
            "schema_versioning": {
                "tool": "flyway",
                "version_control": "git",
                "environment_promotion": "automated",
                "rollback_strategy": "automated"
            },
            "infrastructure_as_code": {
                "tool": "terraform",
                "configuration_management": "ansible",
                "environment_provisioning": "automated"
            }
        },
        "ci_cd_pipeline": {
            "database_testing": {
                "unit_tests": True,
                "integration_tests": True,
                "performance_tests": True,
                "security_tests": True
            },
            "deployment_strategies": [
                {
                    "environment": "development",
                    "strategy": "direct_deployment",
                    "automation_level": "full"
                },
                {
                    "environment": "staging",
                    "strategy": "blue_green",
                    "automation_level": "full",
                    "approval_required": False
                },
                {
                    "environment": "production",
                    "strategy": "canary",
                    "automation_level": "semi",
                    "approval_required": True
                }
            ],
            "monitoring_integration": {
                "deployment_monitoring": True,
                "performance_regression_detection": True,
                "automatic_rollback": True
            }
        },
        "environment_management": {
            "environment_isolation": "complete",
            "data_refresh_strategy": {
                "frequency": "weekly",
                "data_masking": True,
                "subset_generation": True
            },
            "environment_provisioning": {
                "on_demand": True,
                "template_based": True,
                "self_service": True
            }
        }
    })

class EnterpriseDatabaseManager:
"""Enterprise Database Management Platform"""

    def __init__(self, config: EnterpriseDatabaseConfig):
        self.config = config
        self.logger = logging.getLogger(__name__)

    async def setup_enterprise_database_platform(self) -> Dict[str, Any]:
        """Setup comprehensive enterprise database management platform"""

        setup_tasks = [
            self._setup_polyglot_architecture(),
            self._configure_data_governance(),
            self._setup_security_framework(),
            self._configure_performance_optimization(),
            self._setup_backup_disaster_recovery(),
            self._configure_devops_pipeline(),
            self._setup_monitoring_observability()
        ]

        results = await asyncio.gather(*setup_tasks, return_exceptions=True)

        return {
            "status": "success",
            "timestamp": datetime.now().isoformat(),
            "system_id": self.config.system_id,
            "architecture_type": "enterprise_polyglot",
            "setup_results": {
                "polyglot_architecture": results[0],
                "data_governance": results[1],
                "security_framework": results[2],
                "performance_optimization": results[3],
                "backup_disaster_recovery": results[4],
                "devops_pipeline": results[5],
                "monitoring_observability": results[6]
            },
            "database_ecosystem": {
                "relational_databases": ["postgresql", "mysql", "sqlserver", "oracle"],
                "document_databases": ["mongodb", "couchdb"],
                "search_engines": ["elasticsearch", "solr"],
                "cache_stores": ["redis", "memcached"],
                "analytics_platforms": ["clickhouse", "snowflake"],
                "graph_databases": ["neo4j", "amazon_neptune"]
            }
        }

    async def _setup_polyglot_architecture(self) -> Dict[str, Any]:
        """Setup polyglot persistence architecture"""

        try:
            # Configure database routing
            routing_config = await self._configure_data_routing()

            # Setup microservices data patterns
            microservices_patterns = await self._setup_microservices_patterns()

            # Configure data mesh architecture
            data_mesh = await self._configure_data_mesh()

            return {
                "status": "completed",
                "routing_configuration": routing_config,
                "microservices_patterns": microservices_patterns,
                "data_mesh_architecture": data_mesh
            }

        except Exception as e:
            self.logger.error(f"Polyglot architecture setup failed: {str(e)}")
            return {"status": "failed", "error": str(e)}

    async def _configure_data_routing(self) -> Dict[str, Any]:
        """Configure intelligent data routing across databases"""

        routing_rules = []
        for rule in self.config.architecture_strategy["polyglot_persistence"]["data_routing_rules"]:
            routing_rule = {
                "data_type": rule["data_type"],
                "routing_strategy": {
                    "primary": rule["primary_storage"],
                    "cache": rule.get("cache_layer"),
                    "search": rule.get("search_index"),
                    "analytics": rule.get("analytics_storage"),
                    "archive": rule.get("archive_storage")
                },
                "consistency_level": "eventual" if rule.get("cache_layer") else "strong",
                "failover_strategy": "automatic"
            }
            routing_rules.append(routing_rule)

        return {
            "routing_rules_configured": len(routing_rules),
            "routing_rules": routing_rules,
            "load_balancing": "intelligent",
            "health_checking": "enabled"
        }

    def _calculate_database_connections(self, database_type: str) -> int:
        """Calculate optimal connection pool size based on database type"""
        connection_limits = {
            "postgresql": 200,
            "mysql": 151,  # MySQL default max_connections
            "mongodb": 65536,  # MongoDB connection limit
            "redis": 10000,
            "elasticsearch": 100
        }
        return connection_limits.get(database_type, 100)

class DatabaseDevOpsManager:
"""Advanced Database DevOps and Deployment Management"""

    def __init__(self, config: EnterpriseDatabaseConfig):
        self.config = config
        self.logger = logging.getLogger(__name__)

    async def setup_database_devops_pipeline(self) -> Dict[str, Any]:
        """Setup comprehensive database DevOps pipeline"""

        pipeline_components = {
            "schema_versioning": await self._setup_schema_versioning(),
            "database_testing": await self._setup_database_testing(),
            "deployment_automation": await self._setup_deployment_automation(),
            "monitoring_integration": await self._setup_monitoring(),
            "compliance_automation": await self._setup_compliance_automation()
        }

        return {
            "status": "success",
            "pipeline_components": pipeline_components,
            "automation_level": "full",
            "compliance_frameworks": ["sox", "gdpr", "hipaa", "pci_dss"]
        }

    async def _setup_schema_versioning(self) -> Dict[str, Any]:
        """Advanced schema versioning with automated deployment"""

        schema_config = {
            "versioning_strategy": {
                "tool": "flyway_enterprise",
                "version_format": "V{major}_{minor}_{patch}__{description}.sql",
                "baseline_version": "1.0.0",
                "environment_specific_migrations": True,
                "conditional_migrations": True
            },
            "migration_patterns": [
                {
                    "pattern": "blue_green_migrations",
                    "description": "Zero-downtime schema changes",
                    "implementation": {
                        "step_1": "create_new_columns_nullable",
                        "step_2": "dual_write_old_and_new",
                        "step_3": "backfill_new_columns",
                        "step_4": "switch_reads_to_new",
                        "step_5": "remove_old_columns"
                    }
                },
                {
                    "pattern": "expand_contract",
                    "description": "Safe schema evolution",
                    "phases": ["expand", "migrate", "contract"]
                }
            ],
            "rollback_strategies": {
                "automatic_rollback_triggers": [
                    "migration_failure",
                    "performance_degradation",
                    "data_integrity_violation"
                ],
                "rollback_testing": "automated",
                "rollback_validation": True
            }
        }

        return schema_config

    async def _setup_database_testing(self) -> Dict[str, Any]:
        """Comprehensive database testing framework"""

        testing_framework = {
            "testing_pyramid": {
                "unit_tests": {
                    "framework": "pytest_postgresql",
                    "test_data_fixtures": True,
                    "mock_external_dependencies": True,
                    "coverage_threshold": 90
                },
                "integration_tests": {
                    "database_containers": "testcontainers",
                    "test_data_builders": True,
                    "cross_database_testing": True,
                    "api_integration_tests": True
                },
                "performance_tests": {
                    "load_testing": "jmeter",
                    "stress_testing": "gatling",
                    "endurance_testing": True,
                    "scalability_testing": True
                },
                "security_tests": {
                    "sql_injection_testing": True,
                    "access_control_testing": True,
                    "encryption_testing": True,
                    "audit_trail_testing": True
                }
            },
            "test_data_management": {
                "synthetic_data_generation": {
                    "enabled": True,
                    "tools": ["faker", "mockaroo", "synthetica"],
                    "data_privacy_compliant": True,
                    "referential_integrity": True
                },
                "production_data_subset": {
                    "enabled": True,
                    "data_masking": True,
                    "gdpr_compliant": True,
                    "subset_rules": "intelligent_sampling"
                },
                "test_data_refresh": {
                    "frequency": "nightly",
                    "automated": True,
                    "version_controlled": True
                }
            },
            "continuous_testing": {
                "test_automation": "full",
                "parallel_execution": True,
                "test_result_analytics": True,
                "flaky_test_detection": True
            }
        }

        return testing_framework

class DatabaseSecurityManager:
"""Comprehensive Database Security Management"""

    def __init__(self, config: EnterpriseDatabaseConfig):
        self.config = config
        self.security_config = config.security_framework

    async def implement_zero_trust_database_security(self) -> Dict[str, Any]:
        """Implement zero trust security model for databases"""

        zero_trust_components = {
            "identity_verification": await self._setup_identity_verification(),
            "access_controls": await self._implement_fine_grained_access_controls(),
            "network_security": await self._setup_network_security(),
            "data_protection": await self._implement_data_protection(),
            "continuous_monitoring": await self._setup_security_monitoring()
        }

        return {
            "security_model": "zero_trust",
            "implementation_status": "complete",
            "security_components": zero_trust_components,
            "compliance_certifications": ["iso_27001", "soc_2", "pci_dss"]
        }

    async def _setup_identity_verification(self) -> Dict[str, Any]:
        """Advanced identity verification for database access"""

        identity_config = {
            "multi_factor_authentication": {
                "enabled": True,
                "factors": ["password", "certificate", "biometric", "hardware_token"],
                "adaptive_authentication": True,
                "risk_based_authentication": True
            },
            "certificate_based_authentication": {
                "enabled": True,
                "certificate_authority": "internal_ca",
                "certificate_rotation": "automatic",
                "certificate_validation": "strict"
            },
            "service_account_management": {
                "service_identity": "managed_identity",
                "credential_rotation": "automatic",
                "least_privilege": True,
                "access_reviews": "quarterly"
            }
        }

        return identity_config

    async def _implement_fine_grained_access_controls(self) -> Dict[str, Any]:
        """Implement attribute-based access control (ABAC)"""

        abac_config = {
            "policy_engine": {
                "engine": "open_policy_agent",
                "policy_language": "rego",
                "policy_versioning": True,
                "policy_testing": True
            },
            "attribute_sources": [
                {
                    "source": "user_attributes",
                    "attributes": ["department", "role", "clearance_level", "location"]
                },
                {
                    "source": "resource_attributes",
                    "attributes": ["data_classification", "database_type", "table_sensitivity"]
                },
                {
                    "source": "environment_attributes",
                    "attributes": ["time_of_day", "ip_address", "device_trust_level"]
                },
                {
                    "source": "action_attributes",
                    "attributes": ["operation_type", "query_complexity", "data_volume"]
                }
            ],
            "dynamic_policies": [
                {
                    "policy_name": "time_based_access",
                    "rule": "allow_access if time_of_day between business_hours",
                    "enforcement": "strict"
                },
                {
                    "policy_name": "data_classification_access",
                    "rule": "allow_access if user_clearance >= data_classification",
                    "enforcement": "strict"
                },
                {
                    "policy_name": "location_based_access",
                    "rule": "deny_access if user_location not in allowed_countries",
                    "enforcement": "strict"
                }
            ]
        }

        return abac_config

class DatabasePerformanceOptimizer:
"""Advanced Database Performance Optimization Engine"""

    def __init__(self, config: EnterpriseDatabaseConfig):
        self.config = config
        self.performance_config = config.performance_strategy

    async def setup_intelligent_performance_optimization(self) -> Dict[str, Any]:
        """Setup AI-driven performance optimization"""

        optimization_engine = {
            "query_optimization": await self._setup_query_optimization(),
            "resource_optimization": await self._setup_resource_optimization(),
            "caching_optimization": await self._setup_intelligent_caching(),
            "index_optimization": await self._setup_index_optimization(),
            "capacity_planning": await self._setup_capacity_planning()
        }

        return {
            "optimization_engine": "ai_driven",
            "automation_level": "full",
            "optimization_components": optimization_engine,
            "performance_improvements": {
                "query_performance": "40-60% improvement",
                "resource_utilization": "30-50% improvement",
                "cache_hit_ratio": "80-95% target"
            }
        }

    async def _setup_query_optimization(self) -> Dict[str, Any]:
        """AI-driven query optimization"""

        query_optimization = {
            "machine_learning_optimizer": {
                "enabled": True,
                "algorithm": "reinforcement_learning",
                "training_data": "query_execution_history",
                "optimization_targets": ["execution_time", "resource_usage", "cost"]
            },
            "query_rewriting": {
                "enabled": True,
                "rewrite_rules": [
                    "subquery_to_join",
                    "predicate_pushdown",
                    "projection_pruning",
                    "join_reordering"
                ],
                "cost_based_optimization": True
            },
            "execution_plan_caching": {
                "enabled": True,
                "cache_size": "10gb",
                "cache_eviction": "lru",
                "plan_staleness_detection": True
            },
            "adaptive_query_execution": {
                "enabled": True,
                "runtime_reoptimization": True,
                "statistics_feedback": True,
                "parallel_execution": True
            }
        }

        return query_optimization

class DatabaseObservabilityManager:
"""Comprehensive Database Observability and Monitoring"""

    def __init__(self, config: EnterpriseDatabaseConfig):
        self.config = config

    async def setup_comprehensive_observability(self) -> Dict[str, Any]:
        """Setup full-spectrum database observability"""

        observability_stack = {
            "metrics_collection": await self._setup_metrics_collection(),
            "distributed_tracing": await self._setup_distributed_tracing(),
            "log_aggregation": await self._setup_log_aggregation(),
            "alerting_system": await self._setup_intelligent_alerting(),
            "performance_dashboards": await self._setup_performance_dashboards(),
            "anomaly_detection": await self._setup_anomaly_detection()
        }

        return {
            "observability_platform": "enterprise_grade",
            "coverage": "full_stack",
            "automation": "ai_powered",
            "components": observability_stack
        }

    async def _setup_metrics_collection(self) -> Dict[str, Any]:
        """Comprehensive metrics collection across all databases"""

        metrics_config = {
            "metric_categories": {
                "performance_metrics": [
                    "query_execution_time",
                    "throughput_qps",
                    "connection_pool_utilization",
                    "buffer_hit_ratio",
                    "index_usage_statistics"
                ],
                "resource_metrics": [
                    "cpu_utilization",
                    "memory_usage",
                    "disk_io_ops",
                    "network_bandwidth",
                    "storage_utilization"
                ],
                "availability_metrics": [
                    "uptime_percentage",
                    "failover_time",
                    "backup_success_rate",
                    "replication_lag"
                ],
                "security_metrics": [
                    "authentication_attempts",
                    "authorization_failures",
                    "data_access_patterns",
                    "privilege_escalations"
                ]
            },
            "collection_strategy": {
                "collection_interval": "10_seconds",
                "aggregation_windows": ["1m", "5m", "15m", "1h", "1d"],
                "retention_policy": {
                    "raw_metrics": "7_days",
                    "aggregated_metrics": "90_days",
                    "long_term_storage": "2_years"
                }
            },
            "metric_exporters": {
                "prometheus": True,
                "grafana_cloud": True,
                "datadog": True,
                "custom_endpoints": True
            }
        }

        return metrics_config

# Enterprise SQL Standards and Best Practices

class SQLStandardsFramework:
"""Enterprise SQL coding standards and best practices"""

    @staticmethod
    def get_naming_conventions() -> Dict[str, Any]:
        """Comprehensive naming conventions for enterprise databases"""

        return {
            "table_naming": {
                "convention": "snake_case",
                "prefix_rules": {
                    "fact_tables": "fact_",
                    "dimension_tables": "dim_",
                    "lookup_tables": "lkp_",
                    "staging_tables": "stg_",
                    "temporary_tables": "tmp_",
                    "audit_tables": "_audit"
                },
                "examples": [
                    "customer_orders",
                    "fact_sales",
                    "dim_product",
                    "lkp_country_codes"
                ]
            },
            "column_naming": {
                "convention": "snake_case",
                "id_columns": "{table_name}_id",
                "foreign_keys": "{referenced_table}_id",
                "boolean_columns": "is_{description}",
                "timestamp_columns": "{action}_at",
                "examples": [
                    "customer_id",
                    "order_date",
                    "is_active",
                    "created_at"
                ]
            },
            "index_naming": {
                "primary_key": "pk_{table_name}",
                "foreign_key": "fk_{table_name}_{referenced_table}",
                "unique_index": "uk_{table_name}_{column_list}",
                "regular_index": "ix_{table_name}_{column_list}",
                "examples": [
                    "pk_customers",
                    "fk_orders_customers",
                    "uk_users_email",
                    "ix_orders_order_date"
                ]
            },
            "constraint_naming": {
                "check_constraint": "chk_{table_name}_{description}",
                "default_constraint": "df_{table_name}_{column_name}",
                "examples": [
                    "chk_orders_quantity_positive",
                    "df_users_created_at"
                ]
            }
        }

    @staticmethod
    def get_query_formatting_standards() -> Dict[str, Any]:
        """Enterprise SQL query formatting standards"""

        return {
            "formatting_rules": {
                "reserved_words": "UPPERCASE",
                "identifiers": "snake_case",
                "indentation": "2_spaces",
                "line_length": "100_characters",
                "comma_placement": "leading"
            },
            "query_structure": {
                "select_clause": {
                    "format": "each_column_new_line",
                    "alias_alignment": True,
                    "table_prefix": "required_for_joins"
                },
                "from_clause": {
                    "table_aliases": "short_meaningful",
                    "join_placement": "new_line_indented"
                },
                "where_clause": {
                    "condition_grouping": "logical_groups",
                    "parentheses_usage": "explicit"
                }
            },
            "example_formatted_query": '''

SELECT
o.order_id,
o.order_date,
c.customer_name,
c.customer_email,
SUM(oi.quantity _ oi.unit_price) AS total_amount
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
WHERE
o.order_date >= '2023-01-01'
AND o.status = 'completed'
AND c.is_active = true
GROUP BY
o.order_id,
o.order_date,
c.customer_name,
c.customer_email
HAVING
SUM(oi.quantity _ oi.unit_price) > 100
ORDER BY
o.order_date DESC,
total_amount DESC;
'''
}

    @staticmethod
    def get_performance_optimization_patterns() -> Dict[str, Any]:
        """Enterprise performance optimization patterns"""

        return {
            "indexing_strategies": {
                "primary_key_indexes": {
                    "always_required": True,
                    "clustering": True,
                    "auto_increment_preferred": True
                },
                "foreign_key_indexes": {
                    "always_create": True,
                    "composite_when_needed": True
                },
                "covering_indexes": {
                    "use_for_frequent_queries": True,
                    "include_columns": "non_key_columns"
                },
                "partial_indexes": {
                    "use_for_filtered_queries": True,
                    "reduces_index_size": True
                }
            },
            "query_optimization_techniques": {
                "avoid_select_star": {
                    "rule": "specify_required_columns_only",
                    "benefit": "reduced_io_and_memory"
                },
                "use_appropriate_joins": {
                    "inner_join": "default_choice",
                    "left_join": "when_null_values_needed",
                    "avoid_cross_join": "unless_intentional"
                },
                "limit_result_sets": {
                    "use_limit_top": True,
                    "implement_pagination": True
                },
                "use_exists_vs_in": {
                    "exists": "better_for_large_datasets",
                    "in": "good_for_small_lists"
                }
            },
            "data_type_optimization": {
                "string_types": {
                    "varchar_vs_char": "varchar_for_variable_length",
                    "text_for_large_content": True,
                    "avoid_excessive_length": True
                },
                "numeric_types": {
                    "smallest_appropriate_type": True,
                    "decimal_for_currency": True,
                    "bigint_for_large_numbers": True
                },
                "date_time_types": {
                    "use_appropriate_precision": True,
                    "timezone_awareness": True
                }
            }
        }

# Database Security Implementation Patterns

class DatabaseSecurityPatterns:
"""Enterprise database security implementation patterns"""

    @staticmethod
    def get_access_control_patterns() -> Dict[str, Any]:
        """Comprehensive access control patterns"""

        return {
            "role_based_access_control": {
                "role_hierarchy": {
                    "database_administrator": {
                        "permissions": ["all_privileges"],
                        "restrictions": ["audit_log_access_logged"]
                    },
                    "application_admin": {
                        "permissions": ["ddl_operations", "dml_operations"],
                        "restrictions": ["no_user_management"]
                    },
                    "application_user": {
                        "permissions": ["dml_operations"],
                        "restrictions": ["specific_schemas_only"]
                    },
                    "read_only_user": {
                        "permissions": ["select_only"],
                        "restrictions": ["no_sensitive_data"]
                    },
                    "report_user": {
                        "permissions": ["select_aggregated_data"],
                        "restrictions": ["reporting_views_only"]
                    }
                }
            },
            "row_level_security": {
                "implementation_patterns": [
                    {
                        "pattern": "user_based_filtering",
                        "example": "WHERE created_by = CURRENT_USER",
                        "use_case": "user_owned_data"
                    },
                    {
                        "pattern": "department_based_filtering",
                        "example": "WHERE department_id IN (SELECT department_id FROM user_departments WHERE user_id = CURRENT_USER_ID)",
                        "use_case": "departmental_data_access"
                    },
                    {
                        "pattern": "classification_based_filtering",
                        "example": "WHERE data_classification <= USER_CLEARANCE_LEVEL()",
                        "use_case": "classified_information"
                    }
                ]
            },
            "column_level_security": {
                "data_masking": {
                    "credit_card_masking": "XXXX-XXXX-XXXX-1234",
                    "ssn_masking": "XXX-XX-1234",
                    "email_masking": "user***@domain.com",
                    "phone_masking": "XXX-XXX-1234"
                },
                "dynamic_data_masking": {
                    "role_based_masking": True,
                    "context_aware_masking": True,
                    "audit_masked_access": True
                }
            }
        }

    @staticmethod
    def get_encryption_patterns() -> Dict[str, Any]:
        """Comprehensive encryption implementation patterns"""

        return {
            "encryption_at_rest": {
                "transparent_data_encryption": {
                    "enabled": True,
                    "algorithm": "AES_256",
                    "key_management": "external_key_vault"
                },
                "column_level_encryption": {
                    "sensitive_columns": [
                        "credit_card_number",
                        "social_security_number",
                        "bank_account_number",
                        "medical_record_number"
                    ],
                    "encryption_function": "ENCRYPT_DETERMINISTIC",
                    "search_capability": "encrypted_search"
                }
            },
            "encryption_in_transit": {
                "ssl_tls_configuration": {
                    "version": "TLS_1_3",
                    "cipher_suites": ["TLS_AES_256_GCM_SHA384"],
                    "certificate_validation": "strict"
                },
                "connection_encryption": {
                    "force_ssl": True,
                    "client_certificates": True,
                    "certificate_pinning": True
                }
            },
            "key_management": {
                "key_rotation": {
                    "automatic_rotation": True,
                    "rotation_frequency": "quarterly",
                    "zero_downtime_rotation": True
                },
                "key_storage": {
                    "hardware_security_module": True,
                    "key_escrow": True,
                    "multi_party_key_control": True
                }
            }
        }

# Database Testing Framework

class DatabaseTestingFramework:
"""Comprehensive database testing patterns and practices"""

    @staticmethod
    def get_testing_strategies() -> Dict[str, Any]:
        """Enterprise database testing strategies"""

        return {
            "unit_testing": {
                "stored_procedure_testing": {
                    "framework": "tSQLt",
                    "test_patterns": [
                        "arrange_act_assert",
                        "mock_dependencies",
                        "test_edge_cases",
                        "validate_return_values"
                    ],
                    "example_test": '''

CREATE PROCEDURE test_calculate_order_total
AS
BEGIN
-- Arrange
INSERT INTO #test_orders (order_id, quantity, unit_price)
VALUES (1, 5, 10.00);

    -- Act
    DECLARE @result DECIMAL(10,2);
    EXEC @result = calculate_order_total @order_id = 1;

    -- Assert
    EXEC tSQLt.AssertEquals @Expected = 50.00, @Actual = @result;

END;
'''
},
"function_testing": {
"pure_function_testing": True,
"deterministic_results": True,
"boundary_testing": True
}
},
"integration_testing": {
"database_integration": {
"test_containers": "docker_compose",
"schema_setup": "automated_migrations",
"test_data_seeding": "scripted",
"cleanup_strategy": "transaction_rollback"
},
"cross_database_testing": {
"multi_database_transactions": True,
"data_consistency_validation": True,
"referential_integrity_testing": True
}
},
"performance_testing": {
"load_testing": {
"concurrent_connections": "simulate_production_load",
"query_performance": "response_time_validation",
"throughput_testing": "transactions_per_second"
},
"stress_testing": {
"resource_exhaustion": True,
"connection_limit_testing": True,
"memory_pressure_testing": True
}
}
}

# Migration and Schema Management

class DatabaseMigrationManager:
"""Advanced database migration and schema management"""

    @staticmethod
    def get_migration_patterns() -> Dict[str, Any]:
        """Enterprise migration patterns and strategies"""

        return {
            "safe_migration_patterns": {
                "additive_changes": {
                    "new_columns": {
                        "pattern": "add_nullable_column_first",
                        "steps": [
                            "add_column_nullable",
                            "populate_default_values",
                            "update_application_code",
                            "make_column_not_null_if_needed"
                        ]
                    },
                    "new_tables": {
                        "pattern": "create_table_populate_data",
                        "steps": [
                            "create_table_structure",
                            "create_indexes",
                            "populate_initial_data",
                            "update_application_code"
                        ]
                    }
                },
                "destructive_changes": {
                    "column_removal": {
                        "pattern": "deprecate_before_remove",
                        "steps": [
                            "mark_column_deprecated",
                            "remove_from_application_code",
                            "verify_no_usage",
                            "drop_column_in_separate_migration"
                        ]
                    },
                    "table_removal": {
                        "pattern": "archive_before_drop",
                        "steps": [
                            "create_archive_table",
                            "copy_data_to_archive",
                            "verify_data_integrity",
                            "drop_original_table"
                        ]
                    }
                }
            },
            "zero_downtime_migrations": {
                "online_schema_changes": {
                    "large_table_modifications": "ghost_migration_tool",
                    "index_creation": "concurrent_index_creation",
                    "column_type_changes": "shadow_table_approach"
                },
                "data_migration": {
                    "batch_processing": True,
                    "incremental_migration": True,
                    "rollback_capability": True
                }
            },
            "migration_validation": {
                "pre_migration_checks": [
                    "backup_verification",
                    "disk_space_check",
                    "dependency_analysis",
                    "performance_impact_assessment"
                ],
                "post_migration_validation": [
                    "data_integrity_check",
                    "performance_regression_test",
                    "application_functionality_test",
                    "rollback_procedure_test"
                ]
            }
        }

# Database Documentation Standards

class DatabaseDocumentationStandards:
"""Comprehensive database documentation framework"""

    @staticmethod
    def get_documentation_requirements() -> Dict[str, Any]:
        """Enterprise database documentation requirements"""

        return {
            "schema_documentation": {
                "table_documentation": {
                    "required_elements": [
                        "table_purpose",
                        "business_context",
                        "data_source",
                        "update_frequency",
                        "retention_policy",
                        "relationships"
                    ],
                    "example": '''

/\*
Table: customer_orders
Purpose: Stores all customer order information for e-commerce platform
Business Context: Core transactional data for order processing and fulfillment
Data Source: Order management system, customer portal
Update Frequency: Real-time via OLTP operations
Retention Policy: 7 years for compliance, then archived
Relationships:

- References customers(customer_id)
- Referenced by order_items(order_id)
- Referenced by order_audit(order_id)
  \*/
  '''
  },
  "column_documentation": {
  "required_elements": [
  "column_purpose",
  "data_format",
  "validation_rules",
  "example_values",
  "sensitivity_level"
  ],
  "example": '''
  -- order_date: Date when the order was placed
  -- Format: YYYY-MM-DD
  -- Validation: Must be >= account creation date, <= current date
  -- Example: 2023-12-15
  -- Sensitivity: Internal (business operations)
  '''
  }
  },
  "data_dictionary": {
  "automated_generation": True,
  "business_glossary_integration": True,
  "data_lineage_documentation": True,
  "impact_analysis": True
  },
  "operational_documentation": {
  "backup_procedures": "step_by_step_guides",
  "recovery_procedures": "disaster_recovery_playbooks",
  "maintenance_procedures": "routine_maintenance_schedules",
  "troubleshooting_guides": "common_issues_and_solutions"
  }
  }

# Enterprise Database Compliance Framework

class DatabaseComplianceManager:
"""Comprehensive database compliance management"""

    @staticmethod
    def get_compliance_frameworks() -> Dict[str, Any]:
        """Enterprise compliance frameworks for databases"""

        return {
            "gdpr_compliance": {
                "right_to_erasure": {
                    "implementation": "soft_delete_with_purge",
                    "purge_schedule": "automated_quarterly",
                    "verification": "audit_trail_maintained"
                },
                "data_portability": {
                    "export_format": "structured_json_xml",
                    "automated_export": True,
                    "data_validation": True
                },
                "consent_management": {
                    "consent_tracking": "granular_permissions",
                    "consent_withdrawal": "immediate_effect",
                    "consent_audit": "complete_history"
                }
            },
            "sox_compliance": {
                "change_management": {
                    "segregation_of_duties": True,
                    "approval_workflows": "multi_stage_approval",
                    "change_documentation": "comprehensive"
                },
                "audit_trails": {
                    "data_changes": "complete_audit_log",
                    "schema_changes": "version_controlled",
                    "access_patterns": "user_activity_monitoring"
                },
                "financial_controls": {
                    "data_integrity": "checksum_validation",
                    "backup_verification": "restore_testing",
                    "access_reviews": "quarterly_certification"
                }
            },
            "hipaa_compliance": {
                "phi_protection": {
                    "encryption_required": "column_level_encryption",
                    "access_controls": "minimum_necessary_access",
                    "audit_logging": "comprehensive_access_logs"
                },
                "business_associate_agreements": {
                    "cloud_providers": "baa_required",
                    "third_party_tools": "compliance_verification",
                    "data_processing": "limited_authorization"
                }
            }
        }

# Database Performance Monitoring

class DatabasePerformanceMonitoring:
"""Advanced database performance monitoring patterns"""

    @staticmethod
    def get_monitoring_strategies() -> Dict[str, Any]:
        """Comprehensive performance monitoring strategies"""

        return {
            "key_performance_indicators": {
                "throughput_metrics": [
                    "transactions_per_second",
                    "queries_per_second",
                    "batch_operations_per_minute",
                    "concurrent_connections"
                ],
                "latency_metrics": [
                    "query_execution_time",
                    "connection_establishment_time",
                    "lock_wait_time",
                    "io_wait_time"
                ],
                "resource_utilization": [
                    "cpu_utilization_percentage",
                    "memory_usage_percentage",
                    "disk_io_operations",
                    "network_bandwidth_usage"
                ],
                "error_metrics": [
                    "connection_failures",
                    "query_failures",
                    "deadlock_occurrences",
                    "timeout_events"
                ]
            },
            "alerting_thresholds": {
                "critical_alerts": {
                    "cpu_utilization": "> 90% for 5 minutes",
                    "memory_usage": "> 95% for 2 minutes",
                    "connection_failures": "> 10% failure rate",
                    "query_timeout": "> 30 seconds average"
                },
                "warning_alerts": {
                    "cpu_utilization": "> 75% for 15 minutes",
                    "memory_usage": "> 80% for 10 minutes",
                    "slow_queries": "> 5 seconds average",
                    "lock_contention": "> 1 second wait time"
                }
            },
            "performance_baselines": {
                "baseline_establishment": {
                    "measurement_period": "30_days",
                    "seasonal_adjustments": True,
                    "workload_categorization": True
                },
                "anomaly_detection": {
                    "statistical_methods": ["z_score", "isolation_forest"],
                    "machine_learning": "autoencoder_models",
                    "threshold_adaptation": "dynamic_thresholds"
                }
            }
        }

# Conclusion and Implementation Guidance

## Implementation Roadmap

### Phase 1: Foundation Setup (Weeks 1-4)

1. **Database Architecture Assessment**

   - Inventory existing databases and systems
   - Assess current security posture
   - Identify compliance requirements
   - Define polyglot persistence strategy

2. **Core Infrastructure Setup**
   - Implement centralized authentication
   - Setup monitoring infrastructure
   - Establish backup and recovery procedures
   - Configure network security

### Phase 2: Security Implementation (Weeks 5-8)

1. **Access Control Implementation**

   - Deploy RBAC/ABAC systems
   - Configure row-level security
   - Implement data masking
   - Setup audit logging

2. **Encryption Deployment**
   - Enable encryption at rest
   - Configure encryption in transit
   - Implement key management
   - Deploy column-level encryption

### Phase 3: Performance Optimization (Weeks 9-12)

1. **Query Optimization**

   - Deploy query performance monitoring
   - Implement automated index management
   - Configure caching strategies
   - Setup performance baselines

2. **Scalability Implementation**
   - Configure read replicas
   - Implement sharding strategies
   - Deploy load balancing
   - Setup auto-scaling

### Phase 4: DevOps Integration (Weeks 13-16)

1. **CI/CD Pipeline Setup**

   - Configure schema versioning
   - Implement database testing
   - Setup deployment automation
   - Configure rollback procedures

2. **Monitoring and Observability**
   - Deploy comprehensive monitoring
   - Configure alerting systems
   - Setup performance dashboards
   - Implement anomaly detection

### Phase 5: Compliance and Governance (Weeks 17-20)

1. **Compliance Implementation**

   - Configure GDPR compliance features
   - Implement SOX controls
   - Setup HIPAA safeguards
   - Deploy data governance tools

2. **Documentation and Training**
   - Create comprehensive documentation
   - Develop training materials
   - Conduct team training sessions
   - Establish ongoing support processes

## Best Practices Summary

### Security Best Practices

- Implement zero-trust security model
- Use multi-factor authentication
- Apply principle of least privilege
- Enable comprehensive audit logging
- Encrypt sensitive data at rest and in transit

### Performance Best Practices

- Monitor key performance indicators continuously
- Implement intelligent caching strategies
- Use appropriate indexing strategies
- Configure proper connection pooling
- Plan for scalability from the beginning

### Operational Best Practices

- Automate routine maintenance tasks
- Implement comprehensive backup strategies
- Test disaster recovery procedures regularly
- Use infrastructure as code approaches
- Maintain detailed documentation

### Development Best Practices

- Follow consistent naming conventions
- Use parameterized queries to prevent SQL injection
- Implement proper error handling
- Write comprehensive tests
- Use version control for all database changes

This enterprise database management framework provides a comprehensive foundation for building secure, scalable, and maintainable database systems that meet enterprise requirements while following industry best practices and compliance standards.

### Architecture Guidelines

- **Normalization**: Follow 3NF principles while considering performance trade-offs
- **Data Types**: Use appropriate and consistent data types across schema
- **Indexing Strategy**: Create indexes based on query patterns and performance requirements
- **Scalability Design**: Plan for growth in data volume and concurrent users

### Security and Compliance Standards

- **Query Security**: Always use parameterized queries to prevent SQL injection
- **Access Control**: Implement principle of least privilege with role-based access
- **Data Protection**: Encrypt sensitive data at rest and in transit
- **Audit Trail**: Maintain comprehensive logging for compliance requirements

### AI Assistant Guidelines

- Apply database-agnostic best practices unless specific database features are required
- Recommend appropriate database technology based on project requirements
- Include security considerations in all database-related code generation
- Provide cross-database compatibility guidance when possible
- Generate maintainable and well-documented database code

## Database Overview

- **Scope**: Multi-Database Development Standards
- **Version**: Universal guidelines for modern database systems
- **Type**: Cross-platform coding standards and best practices
- **License**: Open guidelines for database development
- **Use Cases**: Schema design, SQL development, migrations, performance optimization

⸻

📂 Database Architecture

✅ Rule: Enforce normalized database design

- Follow 3NF (Third Normal Form) principles
- Use appropriate data types for columns
- Implement proper indexing strategies
- Design for scalability and performance

✅ Rule: Naming conventions

- Tables: `snake_case` with plural nouns (e.g., `user_accounts`, `order_items`)
- Columns: `snake_case` (e.g., `first_name`, `created_at`)
- Primary keys: `id` or `table_name_id`
- Foreign keys: `referenced_table_id` (e.g., `user_id`, `product_id`)

✅ Rule: Security practices

- Use parameterized queries/prepared statements
- Implement proper access controls
- Encrypt sensitive data at rest
- Use database connection pooling

✅ Rule: Performance optimization

- Create appropriate indexes
- Optimize query patterns
- Use database-specific features efficiently
- Monitor query performance

⸻

📜 SQL Standards

✅ Rule: SQL formatting

- Use uppercase for SQL keywords
- Use lowercase for table and column names
- Indent subqueries and complex statements
- Use meaningful aliases

✅ Rule: Query structure

- SELECT specific columns instead of `SELECT *`
- Use JOINs instead of subqueries when appropriate
- Implement proper WHERE clause ordering
- Use LIMIT for pagination

⸻

🖋 SQL Coding Standards

✅ Query Formatting

- Use consistent indentation and line breaks
- Align columns in SELECT statements
- Use meaningful table aliases
- Comment complex queries

✅ Example:

```sql
-- Good: Well-formatted query with comments
SELECT
    u.id,
    u.username,
    u.email,
    p.title AS profile_title,
    COUNT(o.id) AS total_orders
FROM users u
    INNER JOIN user_profiles p ON u.id = p.user_id
    LEFT JOIN orders o ON u.id = o.user_id
WHERE
    u.status = 'active'
    AND u.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY
    u.id,
    u.username,
    u.email,
    p.title
HAVING COUNT(o.id) > 0
ORDER BY
    u.created_at DESC,
    u.username ASC
LIMIT 50;
```

⸻

✅ Table Design

- Use appropriate data types
- Implement proper constraints
- Create meaningful indexes
- Design for referential integrity

✅ Example:

```sql
-- Good: Well-designed table with proper constraints
CREATE TABLE user_accounts (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    status ENUM('active', 'inactive', 'suspended') NOT NULL DEFAULT 'active',
    email_verified_at TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY unique_username (username),
    UNIQUE KEY unique_email (email),
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Foreign key table
CREATE TABLE user_profiles (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(200),
    bio TEXT,
    avatar_url VARCHAR(500),
    website_url VARCHAR(500),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY unique_user_profile (user_id),
    FOREIGN KEY (user_id) REFERENCES user_accounts(id) ON DELETE CASCADE,
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```

⸻

✅ Migration Scripts

- Use reversible migrations
- Include rollback procedures
- Test migrations on sample data
- Document migration purpose and effects

✅ Example:

```sql
-- Migration: Add user preferences table
-- Purpose: Store user-specific application preferences
-- Date: 2025-08-06
-- Author: Development Team

-- Forward migration
CREATE TABLE user_preferences (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id BIGINT UNSIGNED NOT NULL,
    preference_key VARCHAR(100) NOT NULL,
    preference_value JSON NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY unique_user_preference (user_id, preference_key),
    FOREIGN KEY (user_id) REFERENCES user_accounts(id) ON DELETE CASCADE,
    INDEX idx_preference_key (preference_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add some default preferences
INSERT INTO user_preferences (user_id, preference_key, preference_value)
SELECT
    id,
    'theme',
    JSON_OBJECT('name', 'default', 'dark_mode', false)
FROM user_accounts
WHERE status = 'active';

-- Rollback migration (if needed)
-- DROP TABLE user_preferences;
```

⸻

✅ Performance Optimization

- Create selective indexes
- Use query execution plans
- Optimize JOIN operations
- Implement proper pagination

❌ Bad:

```sql
-- Poor performance: No indexes, SELECT *, unnecessary subquery
SELECT * FROM users
WHERE id IN (
    SELECT user_id FROM orders
    WHERE created_at > '2025-01-01'
);
```

✅ Good:

```sql
-- Better performance: Specific columns, proper JOIN, indexed columns
SELECT
    u.id,
    u.username,
    u.email,
    COUNT(o.id) AS order_count
FROM users u
    INNER JOIN orders o ON u.id = o.user_id
WHERE
    o.created_at > '2025-01-01'
    AND u.status = 'active'
GROUP BY
    u.id,
    u.username,
    u.email
ORDER BY order_count DESC;

-- Ensure proper indexes exist:
-- CREATE INDEX idx_orders_user_created ON orders(user_id, created_at);
-- CREATE INDEX idx_users_status ON users(status);
```

⸻

✅ Data Integrity

- Use appropriate constraints
- Implement proper validation
- Use transactions for related operations
- Handle constraint violations gracefully

✅ Example:

```sql
-- Transaction for related operations
START TRANSACTION;

-- Insert user account
INSERT INTO user_accounts (username, email, password_hash, first_name, last_name)
VALUES ('johndoe', 'john@example.com', '$2y$10$hash...', 'John', 'Doe');

SET @user_id = LAST_INSERT_ID();

-- Insert user profile
INSERT INTO user_profiles (user_id, title, bio)
VALUES (@user_id, 'Software Developer', 'Passionate about clean code');

-- Insert default preferences
INSERT INTO user_preferences (user_id, preference_key, preference_value)
VALUES
    (@user_id, 'theme', JSON_OBJECT('name', 'default', 'dark_mode', false)),
    (@user_id, 'notifications', JSON_OBJECT('email', true, 'push', false));

COMMIT;

-- Handle errors (in application code):
-- If any operation fails, ROLLBACK the transaction
```

⸻

✅ Security Practices

- Never use dynamic SQL with user input
- Use parameterized queries/prepared statements
- Implement proper access controls
- Encrypt sensitive data

✅ Example (PHP with PDO):

```php
// Good: Parameterized query
$stmt = $pdo->prepare("
    SELECT id, username, email
    FROM user_accounts
    WHERE username = ? AND status = ?
");
$stmt->execute([$username, 'active']);
$user = $stmt->fetch();

// Good: Named parameters
$stmt = $pdo->prepare("
    UPDATE user_accounts
    SET
        email = :email,
        updated_at = NOW()
    WHERE id = :user_id AND status = 'active'
");
$stmt->execute([
    'email' => $new_email,
    'user_id' => $user_id
]);
```

⸻

✅ Stored Procedures and Functions

- Use for complex business logic
- Implement proper error handling
- Document parameters and return values
- Use consistent naming conventions

✅ Example:

```sql
-- Stored procedure for user registration
DELIMITER //

CREATE PROCEDURE RegisterUser(
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(255),
    IN p_password_hash VARCHAR(255),
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    OUT p_user_id BIGINT,
    OUT p_result_code INT,
    OUT p_result_message VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_result_code = -1;
        SET p_result_message = 'Database error occurred';
    END;

    -- Validate input parameters
    IF p_username IS NULL OR p_username = '' THEN
        SET p_result_code = 1;
        SET p_result_message = 'Username is required';
    ELSEIF p_email IS NULL OR p_email = '' THEN
        SET p_result_code = 2;
        SET p_result_message = 'Email is required';
    ELSE
        START TRANSACTION;

        -- Check if username already exists
        IF EXISTS(SELECT 1 FROM user_accounts WHERE username = p_username) THEN
            SET p_result_code = 3;
            SET p_result_message = 'Username already exists';
        ELSEIF EXISTS(SELECT 1 FROM user_accounts WHERE email = p_email) THEN
            SET p_result_code = 4;
            SET p_result_message = 'Email already exists';
        ELSE
            -- Insert new user
            INSERT INTO user_accounts (username, email, password_hash, first_name, last_name)
            VALUES (p_username, p_email, p_password_hash, p_first_name, p_last_name);

            SET p_user_id = LAST_INSERT_ID();
            SET p_result_code = 0;
            SET p_result_message = 'User registered successfully';

            COMMIT;
        END IF;
    END IF;
END //

DELIMITER ;
```

⸻

🧪 Database Testing

✅ Test Data Management

- Use realistic test data
- Implement data seeding scripts
- Create test data cleanup procedures
- Test with various data volumes

✅ Migration Testing

- Test forward and rollback migrations
- Verify data integrity after migrations
- Test on database copies, not production
- Document migration testing procedures

⸻

🚦 Database AI Enforcement Summary

✅ Enforce proper naming conventions (snake_case)
✅ Require parameterized queries over dynamic SQL
✅ Block SELECT \* in production queries
✅ Enforce proper indexing strategies
✅ Require transaction usage for related operations
✅ Enforce data type appropriateness
✅ Block direct user input in SQL strings
✅ Require proper constraint definitions
✅ Enforce migration rollback procedures
✅ Auto-fix violations where possible
