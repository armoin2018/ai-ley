---
name: 'Database Development Instructions'
description: 'Comprehensive database coding and style guide with AI linting hints for database development, covering SQL best practices, schema design, performance optimization, and security standards across multiple database systems.'
keywords: [api, agent, async, development, architecture, authentication, authorization, database, cli, database.instructions]
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
