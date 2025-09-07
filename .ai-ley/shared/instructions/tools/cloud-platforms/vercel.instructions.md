---
agentMode: general
applyTo:
  - '**/vercel.json'
  - '**/.vercelignore'
  - '**/api/**'
  - '**/middleware.ts'
  - '**/middleware.js'
  - '**/vercel/**'
author: AI-LEY
category: Cloud Platforms
description: Comprehensive guide for using Vercel for Next.js applications, serverless
  functions, edge computing, and modern web deployment
extensions:
  - .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-09-03T00:04:47.935595'
last_updated: '2025-08-14'
summaryScore: 3.0
tags:
  - vercel
  - nextjs
  - deployment
  - serverless
  - edge-functions
  - frontend
  - jamstack
title: Vercel Modern Web Deployment Platform Instructions
version: '1.0'
---

# Vercel Enterprise Web Deployment Platform Instructions

## Tool Overview

- **Tool Name**: Vercel Enterprise Edition
- **Version**: Platform service with CLI 32.0+ and Enterprise Extensions
- **Category**: Cloud Platforms - Enterprise Web Deployment & Edge Computing
- **Purpose**: Deploy, scale, and manage enterprise web applications with advanced serverless functions, edge computing, team collaboration, and enterprise-grade security
- **Prerequisites**: Git repository, modern web framework, Node.js 18+, Vercel CLI, enterprise account
- **Enterprise Features**: Advanced analytics, team management, custom domains, security headers, DDoS protection, SLA guarantees

## Enterprise Vercel Architecture

### Level 3 Enterprise Implementation

This enterprise Vercel platform provides comprehensive team management, advanced deployment strategies, enterprise security, performance optimization, and cost management for large-scale web application deployments.

## Core Configuration Classes

`````python
import asyncio
import logging
import json
from typing import Dict, List, Any, Optional
from dataclasses import dataclass
from enum import Enum
import time

class VercelRegion(Enum):
    """Vercel Edge Network regions for global deployment"""
    US_EAST_1 = "iad1"  # Washington DC
    US_WEST_1 = "sfo1"  # San Francisco
    EUROPE_WEST_1 = "fra1"  # Frankfurt
    ASIA_SOUTHEAST_1 = "sin1"  # Singapore
    ASIA_NORTHEAST_1 = "hnd1"  # Tokyo
    SOUTH_AMERICA_1 = "gru1"  # São Paulo
    OCEANIA_1 = "syd1"  # Sydney

@dataclass
class EnterpriseVercelConfig:
    """Enterprise configuration for Vercel platform management"""

    # Organization settings
    organization_id: str
    team_name: str
    enterprise_plan: str = "Enterprise"

    # Deployment configuration
    primary_regions: List[VercelRegion] = None
    deployment_environments: List[str] = None
    custom_domains: List[str] = None

    # Security settings
    enable_password_protection: bool = True
    enable_ip_allowlist: bool = True
    enable_security_headers: bool = True
    enable_ddos_protection: bool = True

    # Performance settings
    enable_edge_caching: bool = True
    enable_image_optimization: bool = True
    enable_compression: bool = True

    # Monitoring settings
    enable_analytics: bool = True
    enable_real_user_monitoring: bool = True
    enable_vitals_tracking: bool = True

    def __post_init__(self):
        if self.primary_regions is None:
            self.primary_regions = [VercelRegion.US_EAST_1, VercelRegion.EUROPE_WEST_1, VercelRegion.ASIA_SOUTHEAST_1]

        if self.deployment_environments is None:
            self.deployment_environments = ["production", "preview", "development"]

        if self.custom_domains is None:
            self.custom_domains = []

class VercelEnterpriseManager:
    """
    Comprehensive enterprise management for Vercel deployments
    Handles team management, deployments, security, performance, and monitoring
    """

    def __init__(self, config: EnterpriseVercelConfig):
        self.config = config
        self.logger = self._setup_logging()
        self.deployment_history = []
        self.team_configuration = {}

    def _setup_logging(self):
        logger = logging.getLogger("VercelEnterpriseManager")
        handler = logging.StreamHandler()
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        logger.setLevel(logging.INFO)
        return logger

    async def deploy_enterprise_platform(self) -> Dict[str, Any]:
        """Deploy comprehensive enterprise Vercel platform"""
        try:
            self.logger.info("Deploying Vercel Enterprise Platform...")

            deployment_results = []
            total_start_time = time.time()

            # Deploy team management
            team_result = await self._deploy_team_management()
            deployment_results.append(("Team Management", team_result))

            # Deploy project infrastructure
            project_result = await self._deploy_project_infrastructure()
            deployment_results.append(("Project Infrastructure", project_result))

            # Deploy security configuration
            security_result = await self._deploy_security_configuration()
            deployment_results.append(("Security Configuration", security_result))

            # Deploy performance optimization
            performance_result = await self._deploy_performance_optimization()
            deployment_results.append(("Performance Optimization", performance_result))

            # Deploy monitoring and analytics
            monitoring_result = await self._deploy_monitoring_analytics()
            deployment_results.append(("Monitoring & Analytics", monitoring_result))

            total_deployment_time = time.time() - total_start_time

            # Calculate success metrics
            successful_components = sum(1 for _, result in deployment_results if result["status"] == "success")
            total_components = len(deployment_results)

            return {
                "status": "success" if successful_components == total_components else "partial_success",
                "enterprise_capabilities": {
                    "team_management": team_result["status"] == "success",
                    "project_infrastructure": project_result["status"] == "success",
                    "security_configuration": security_result["status"] == "success",
                    "performance_optimization": performance_result["status"] == "success",
                    "monitoring_analytics": monitoring_result["status"] == "success"
                },
                "deployment_summary": {
                    "successful_components": successful_components,
                    "total_components": total_components,
                    "success_rate": f"{(successful_components/total_components)*100:.1f}%",
                    "deployment_time_minutes": round(total_deployment_time / 60, 2)
                },
                "platform_metrics": {
                    "teams_configured": team_result.get("teams_created", 0),
                    "projects_deployed": project_result.get("projects_configured", 0),
                    "security_policies": security_result.get("policies_applied", 0),
                    "performance_optimizations": performance_result.get("optimizations_applied", 0),
                    "monitoring_dashboards": monitoring_result.get("dashboards_created", 0)
                },
                "component_details": deployment_results,
                "description": "Enterprise Vercel platform deployed with team management, security, performance optimization, and comprehensive monitoring"
            }

        except Exception as e:
            self.logger.error(f"Enterprise platform deployment failed: {e}")
            return {"status": "failed", "error": str(e)}

    async def _deploy_team_management(self) -> Dict[str, Any]:
        """Deploy enterprise team management and collaboration features"""
        try:
            team_config = {
                "organization_setup": {},
                "team_roles": [],
                "access_controls": [],
                "collaboration_features": []
            }

            # Organization setup
            organization_setup = {
                "organization_id": self.config.organization_id,
                "team_name": self.config.team_name,
                "plan": self.config.enterprise_plan,
                "settings": {
                    "enforce_saml_sso": True,
                    "require_two_factor_auth": True,
                    "session_timeout": "8h",
                    "ip_allowlist": self.config.enable_ip_allowlist
                }
            }
            team_config["organization_setup"] = organization_setup

            # Team roles and permissions
            team_roles = [
                {
                    "role": "Owner",
                    "permissions": [
                        "manage_team",
                        "manage_billing",
                        "manage_domains",
                        "deploy_production",
                        "manage_security",
                        "view_analytics"
                    ],
                    "members": ["owner@company.com"]
                },
                {
                    "role": "Admin",
                    "permissions": [
                        "manage_projects",
                        "deploy_production",
                        "manage_domains",
                        "view_analytics",
                        "manage_team_members"
                    ],
                    "members": ["admin@company.com", "devops@company.com"]
                },
                {
                    "role": "Developer",
                    "permissions": [
                        "deploy_preview",
                        "manage_functions",
                        "view_deployments",
                        "access_logs"
                    ],
                    "members": ["dev1@company.com", "dev2@company.com"]
                },
                {
                    "role": "Viewer",
                    "permissions": [
                        "view_deployments",
                        "view_analytics"
                    ],
                    "members": ["stakeholder@company.com", "qa@company.com"]
                }
            ]
            team_config["team_roles"] = team_roles

            # Access controls
            access_controls = [
                {
                    "name": "Production Deployment Gate",
                    "type": "deployment_protection",
                    "rules": [
                        "require_pull_request_reviews",
                        "require_status_checks",
                        "require_admin_approval"
                    ],
                    "environments": ["production"]
                },
                {
                    "name": "Domain Management",
                    "type": "resource_access",
                    "rules": [
                        "owner_only_custom_domains",
                        "admin_can_manage_subdomains"
                    ]
                },
                {
                    "name": "Sensitive Data Access",
                    "type": "data_access",
                    "rules": [
                        "environment_variables_admin_only",
                        "logs_based_on_role",
                        "analytics_based_on_role"
                    ]
                }
            ]
            team_config["access_controls"] = access_controls

            # Collaboration features
            collaboration_features = [
                {
                    "feature": "Deployment Comments",
                    "enabled": True,
                    "configuration": {
                        "allow_external_comments": False,
                        "require_approval_for_comments": True,
                        "notification_channels": ["slack", "email"]
                    }
                },
                {
                    "feature": "Shared Preview URLs",
                    "enabled": True,
                    "configuration": {
                        "password_protection": self.config.enable_password_protection,
                        "expiration_time": "7d",
                        "view_restrictions": "team_only"
                    }
                },
                {
                    "feature": "Integration Workflows",
                    "enabled": True,
                    "integrations": [
                        {
                            "name": "GitHub",
                            "auto_deploy_branches": ["main", "develop"],
                            "require_checks": True,
                            "deployment_environments": {
                                "main": "production",
                                "develop": "preview"
                            }
                        },
                        {
                            "name": "Slack",
                            "notifications": [
                                "deployment_started",
                                "deployment_success",
                                "deployment_failed"
                            ],
                            "channels": ["#deployments", "#alerts"]
                        }
                    ]
                }
            ]
            team_config["collaboration_features"] = collaboration_features

            return {
                "status": "success",
                "teams_created": len(team_roles),
                "access_controls": len(access_controls),
                "collaboration_features": len(collaboration_features),
                "configuration": team_config,
                "description": "Enterprise team management deployed"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy team management: {e}")
            return {"status": "failed", "error": str(e)}

    async def _deploy_project_infrastructure(self) -> Dict[str, Any]:
        """Deploy enterprise project infrastructure and deployment pipeline"""
        try:
            project_config = {
                "project_templates": [],
                "deployment_strategies": [],
                "environment_management": [],
                "domain_management": []
            }

            # Enterprise project templates
            project_templates = [
                {
                    "name": "Next.js Enterprise Template",
                    "framework": "nextjs",
                    "version": "14.0+",
                    "features": [
                        "TypeScript",
                        "Enterprise authentication",
                        "Advanced caching",
                        "Security headers",
                        "Performance monitoring"
                    ],
                    "configuration": {
                        "build_command": "npm run build",
                        "output_directory": ".next",
                        "install_command": "npm ci",
                        "dev_command": "npm run dev"
                    },
                    "environment_variables": [
                        "NEXTAUTH_SECRET",
                        "DATABASE_URL",
                        "API_BASE_URL",
                        "REDIS_URL"
                    ]
                },
                {
                    "name": "React Enterprise SPA",
                    "framework": "vite",
                    "version": "5.0+",
                    "features": [
                        "React 18+",
                        "TypeScript",
                        "Enterprise routing",
                        "State management",
                        "Component library"
                    ],
                    "configuration": {
                        "build_command": "npm run build",
                        "output_directory": "dist",
                        "install_command": "npm ci"
                    }
                },
                {
                    "name": "Nuxt.js Enterprise Template",
                    "framework": "nuxtjs",
                    "version": "3.0+",
                    "features": [
                        "Vue 3",
                        "TypeScript",
                        "SSR/SSG",
                        "Enterprise modules",
                        "Advanced caching"
                    ]
                }
            ]
            project_config["project_templates"] = project_templates

            # Advanced deployment strategies
            deployment_strategies = [
                {
                    "name": "Blue-Green Deployment",
                    "description": "Zero-downtime deployment with instant rollback",
                    "configuration": {
                        "environments": ["blue", "green"],
                        "traffic_switching": "instant",
                        "health_checks": True,
                        "rollback_policy": "automatic_on_failure"
                    }
                },
                {
                    "name": "Canary Deployment",
                    "description": "Gradual traffic shifting for safe deployments",
                    "configuration": {
                        "initial_traffic": "5%",
                        "increment_steps": ["10%", "25%", "50%", "100%"],
                        "promotion_interval": "10m",
                        "success_criteria": {
                            "error_rate": "<1%",
                            "response_time": "<500ms"
                        }
                    }
                },
                {
                    "name": "Feature Flag Deployment",
                    "description": "Feature-based deployment with runtime toggles",
                    "configuration": {
                        "feature_flag_provider": "vercel",
                        "rollout_strategies": ["user_percentage", "user_cohorts"],
                        "monitoring_integration": True
                    }
                }
            ]
            project_config["deployment_strategies"] = deployment_strategies

            # Environment management
            environment_management = [
                {
                    "environment": "production",
                    "configuration": {
                        "domains": self.config.custom_domains,
                        "regions": [region.value for region in self.config.primary_regions],
                        "protection": {
                            "password": False,
                            "ip_allowlist": self.config.enable_ip_allowlist
                        },
                        "performance": {
                            "edge_caching": True,
                            "image_optimization": True,
                            "compression": True
                        }
                    }
                },
                {
                    "environment": "preview",
                    "configuration": {
                        "domains": ["preview.company.com"],
                        "regions": [VercelRegion.US_EAST_1.value],
                        "protection": {
                            "password": self.config.enable_password_protection,
                            "ip_allowlist": True
                        },
                        "performance": {
                            "edge_caching": False,
                            "image_optimization": True
                        }
                    }
                },
                {
                    "environment": "development",
                    "configuration": {
                        "domains": ["dev.company.com"],
                        "regions": [VercelRegion.US_EAST_1.value],
                        "protection": {
                            "password": True,
                            "ip_allowlist": True
                        }
                    }
                }
            ]
            project_config["environment_management"] = environment_management

            return {
                "status": "success",
                "projects_configured": len(project_templates),
                "deployment_strategies": len(deployment_strategies),
                "environments_managed": len(environment_management),
                "configuration": project_config,
                "description": "Enterprise project infrastructure deployed"
            }

    async def _deploy_security_configuration(self) -> Dict[str, Any]:
        """Deploy comprehensive security configuration for enterprise Vercel"""
        try:
            security_config = {
                "security_headers": [],
                "ssl_configuration": {},
                "ddos_protection": {},
                "access_controls": []
            }

            # Security headers configuration
            security_headers = [
                {
                    "header": "Strict-Transport-Security",
                    "value": "max-age=31536000; includeSubDomains; preload",
                    "description": "Force HTTPS connections"
                },
                {
                    "header": "Content-Security-Policy",
                    "value": "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline';",
                    "description": "Prevent XSS attacks"
                },
                {
                    "header": "X-Frame-Options",
                    "value": "DENY",
                    "description": "Prevent clickjacking"
                },
                {
                    "header": "X-Content-Type-Options",
                    "value": "nosniff",
                    "description": "Prevent MIME type sniffing"
                },
                {
                    "header": "Referrer-Policy",
                    "value": "strict-origin-when-cross-origin",
                    "description": "Control referrer information"
                },
                {
                    "header": "Permissions-Policy",
                    "value": "geolocation=(), microphone=(), camera=()",
                    "description": "Control browser features"
                }
            ]
            security_config["security_headers"] = security_headers

            # SSL/TLS configuration
            ssl_configuration = {
                "certificate_type": "enterprise",
                "min_tls_version": "1.2",
                "cipher_suites": [
                    "ECDHE-RSA-AES256-GCM-SHA384",
                    "ECDHE-RSA-AES128-GCM-SHA256"
                ],
                "hsts_enabled": True,
                "certificate_transparency": True,
                "automatic_renewal": True
            }
            security_config["ssl_configuration"] = ssl_configuration

            # DDoS protection
            ddos_protection = {
                "enabled": self.config.enable_ddos_protection,
                "rate_limiting": {
                    "requests_per_minute": 1000,
                    "burst_capacity": 2000,
                    "block_duration": "15m"
                },
                "geo_blocking": {
                    "enabled": False,
                    "blocked_countries": []
                },
                "bot_protection": {
                    "enabled": True,
                    "challenge_mode": "automatic",
                    "whitelist_known_bots": True
                }
            }
            security_config["ddos_protection"] = ddos_protection

            # Advanced access controls
            access_controls = [
                {
                    "name": "IP Allowlist",
                    "enabled": self.config.enable_ip_allowlist,
                    "type": "network_access",
                    "configuration": {
                        "allowed_ips": [
                            "192.168.1.0/24",  # Office network
                            "10.0.0.0/8"        # VPN network
                        ],
                        "default_action": "block",
                        "bypass_conditions": ["webhook", "api_key"]
                    }
                },
                {
                    "name": "Password Protection",
                    "enabled": self.config.enable_password_protection,
                    "type": "authentication",
                    "configuration": {
                        "password_strength": "enterprise",
                        "session_duration": "24h",
                        "remember_device": True,
                        "environments": ["preview", "development"]
                    }
                },
                {
                    "name": "OAuth Integration",
                    "enabled": True,
                    "type": "authentication",
                    "providers": [
                        {
                            "name": "GitHub",
                            "organization_restriction": True,
                            "team_restrictions": ["developers", "admins"]
                        },
                        {
                            "name": "Google Workspace",
                            "domain_restriction": "company.com",
                            "group_restrictions": ["engineering", "product"]
                        }
                    ]
                }
            ]
            security_config["access_controls"] = access_controls

            return {
                "status": "success",
                "policies_applied": len(security_headers) + len(access_controls),
                "security_features": {
                    "headers_configured": len(security_headers),
                    "ssl_enabled": True,
                    "ddos_protection": ddos_protection["enabled"],
                    "access_controls": len(access_controls)
                },
                "configuration": security_config,
                "description": "Enterprise security configuration deployed"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy security configuration: {e}")
            return {"status": "failed", "error": str(e)}

    async def _deploy_performance_optimization(self) -> Dict[str, Any]:
        """Deploy performance optimization features for enterprise applications"""
        try:
            performance_config = {
                "edge_configuration": {},
                "caching_strategies": [],
                "image_optimization": {},
                "function_optimization": []
            }

            # Edge network configuration
            edge_configuration = {
                "primary_regions": [region.value for region in self.config.primary_regions],
                "edge_functions": {
                    "enabled": True,
                    "regions": "all",
                    "runtime": "edge-runtime",
                    "memory_limit": "128mb"
                },
                "middleware": {
                    "authentication_check": True,
                    "rate_limiting": True,
                    "geo_routing": True,
                    "a_b_testing": True
                },
                "regional_failover": {
                    "enabled": True,
                    "failover_regions": [
                        VercelRegion.US_WEST_1.value,
                        VercelRegion.EUROPE_WEST_1.value
                    ],
                    "health_check_interval": "30s"
                }
            }
            performance_config["edge_configuration"] = edge_configuration

            # Advanced caching strategies
            caching_strategies = [
                {
                    "name": "Static Asset Caching",
                    "type": "static",
                    "configuration": {
                        "max_age": "31536000",  # 1 year
                        "file_types": [".js", ".css", ".png", ".jpg", ".svg"],
                        "compression": "gzip, brotli",
                        "versioning": "hash_based"
                    }
                },
                {
                    "name": "API Response Caching",
                    "type": "dynamic",
                    "configuration": {
                        "max_age": "300",  # 5 minutes
                        "cache_control": "public, max-age=300",
                        "vary_headers": ["Accept", "Accept-Encoding"],
                        "purge_triggers": ["webhook", "manual"]
                    }
                },
                {
                    "name": "Page Caching",
                    "type": "hybrid",
                    "configuration": {
                        "static_generation": "on_demand",
                        "revalidation": "60s",
                        "fallback_behavior": "stale_while_revalidate",
                        "cache_tags": ["page", "content", "user"]
                    }
                },
                {
                    "name": "Database Query Caching",
                    "type": "application",
                    "configuration": {
                        "redis_integration": True,
                        "cache_key_strategy": "query_hash",
                        "ttl": "900",  # 15 minutes
                        "invalidation": "tag_based"
                    }
                }
            ]
            performance_config["caching_strategies"] = caching_strategies

            # Image optimization
            image_optimization = {
                "enabled": self.config.enable_image_optimization,
                "formats": {
                    "webp": True,
                    "avif": True,
                    "auto_format": True
                },
                "quality_settings": {
                    "default": 85,
                    "high_quality": 95,
                    "low_bandwidth": 60
                },
                "responsive_images": {
                    "breakpoints": [640, 768, 1024, 1280, 1536],
                    "lazy_loading": True,
                    "placeholder": "blur"
                },
                "cdn_optimization": {
                    "global_distribution": True,
                    "cache_duration": "31536000",
                    "compression": "automatic"
                }
            }
            performance_config["image_optimization"] = image_optimization

            # Function optimization
            function_optimization = [
                {
                    "name": "Cold Start Optimization",
                    "techniques": [
                        "connection_pooling",
                        "dependency_bundling",
                        "warm_up_triggers"
                    ],
                    "configuration": {
                        "max_execution_time": "10s",
                        "memory_allocation": "1024mb",
                        "concurrent_executions": 100
                    }
                },
                {
                    "name": "Database Connection Optimization",
                    "techniques": [
                        "connection_reuse",
                        "connection_pooling",
                        "query_optimization"
                    ],
                    "configuration": {
                        "pool_size": 20,
                        "idle_timeout": "5m",
                        "query_timeout": "30s"
                    }
                },
                {
                    "name": "Memory Management",
                    "techniques": [
                        "garbage_collection_tuning",
                        "memory_profiling",
                        "resource_cleanup"
                    ]
                }
            ]
            performance_config["function_optimization"] = function_optimization

            return {
                "status": "success",
                "optimizations_applied": len(caching_strategies) + len(function_optimization),
                "performance_features": {
                    "edge_regions": len(self.config.primary_regions),
                    "caching_strategies": len(caching_strategies),
                    "image_optimization": image_optimization["enabled"],
                    "function_optimizations": len(function_optimization)
                },
                "configuration": performance_config,
                "description": "Enterprise performance optimization deployed"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy performance optimization: {e}")
            return {"status": "failed", "error": str(e)}

    async def _deploy_monitoring_analytics(self) -> Dict[str, Any]:
        """Deploy comprehensive monitoring and analytics for enterprise applications"""
        try:
            monitoring_config = {
                "real_user_monitoring": {},
                "performance_analytics": {},
                "error_tracking": {},
                "business_analytics": []
            }

            # Real User Monitoring (RUM)
            real_user_monitoring = {
                "enabled": self.config.enable_real_user_monitoring,
                "data_collection": {
                    "core_web_vitals": True,
                    "custom_metrics": True,
                    "user_interactions": True,
                    "network_information": True
                },
                "sampling_rate": {
                    "production": 100,
                    "preview": 50,
                    "development": 10
                },
                "privacy_settings": {
                    "anonymize_ips": True,
                    "respect_dnt": True,
                    "gdpr_compliant": True
                }
            }
            monitoring_config["real_user_monitoring"] = real_user_monitoring

            # Performance analytics
            performance_analytics = {
                "core_web_vitals": {
                    "largest_contentful_paint": {
                        "target": "2.5s",
                        "alert_threshold": "4.0s"
                    },
                    "first_input_delay": {
                        "target": "100ms",
                        "alert_threshold": "300ms"
                    },
                    "cumulative_layout_shift": {
                        "target": "0.1",
                        "alert_threshold": "0.25"
                    }
                },
                "custom_metrics": [
                    {
                        "name": "Time to Interactive",
                        "target": "3.0s",
                        "description": "Time until page is fully interactive"
                    },
                    {
                        "name": "API Response Time",
                        "target": "500ms",
                        "description": "Average API response time"
                    },
                    {
                        "name": "Bundle Size",
                        "target": "250kb",
                        "description": "JavaScript bundle size"
                    }
                ],
                "performance_budgets": {
                    "javascript": "250kb",
                    "css": "100kb",
                    "images": "1mb",
                    "fonts": "100kb"
                }
            }
            monitoring_config["performance_analytics"] = performance_analytics

            # Error tracking and alerting
            error_tracking = {
                "error_collection": {
                    "javascript_errors": True,
                    "network_errors": True,
                    "console_errors": True,
                    "unhandled_promises": True
                },
                "error_grouping": {
                    "by_error_type": True,
                    "by_stack_trace": True,
                    "by_user_agent": True,
                    "by_url": True
                },
                "alerting": {
                    "error_rate_threshold": "1%",
                    "new_error_alert": True,
                    "error_spike_detection": True,
                    "notification_channels": ["email", "slack", "pagerduty"]
                },
                "error_resolution": {
                    "source_map_support": True,
                    "stack_trace_enhancement": True,
                    "deployment_correlation": True
                }
            }
            monitoring_config["error_tracking"] = error_tracking

            # Business analytics
            business_analytics = [
                {
                    "category": "User Engagement",
                    "metrics": [
                        {
                            "name": "Page Views",
                            "tracking": "automatic",
                            "segmentation": ["device", "geo", "referrer"]
                        },
                        {
                            "name": "Session Duration",
                            "tracking": "automatic",
                            "goals": ["5min_session", "return_visitor"]
                        },
                        {
                            "name": "Bounce Rate",
                            "tracking": "automatic",
                            "target": "<40%"
                        }
                    ]
                },
                {
                    "category": "Conversion Tracking",
                    "metrics": [
                        {
                            "name": "Sign-up Conversion",
                            "tracking": "event_based",
                            "funnel_analysis": True
                        },
                        {
                            "name": "Purchase Conversion",
                            "tracking": "event_based",
                            "revenue_tracking": True
                        }
                    ]
                },
                {
                    "category": "Feature Adoption",
                    "metrics": [
                        {
                            "name": "Feature Usage",
                            "tracking": "custom_events",
                            "cohort_analysis": True
                        },
                        {
                            "name": "A/B Test Performance",
                            "tracking": "experiment_based",
                            "statistical_significance": True
                        }
                    ]
                }
            ]
            monitoring_config["business_analytics"] = business_analytics

            # Create monitoring dashboards
            dashboards = [
                {
                    "name": "Performance Dashboard",
                    "widgets": [
                        "core_web_vitals",
                        "page_load_times",
                        "api_response_times",
                        "error_rates"
                    ]
                },
                {
                    "name": "Business Dashboard",
                    "widgets": [
                        "user_engagement",
                        "conversion_funnels",
                        "revenue_metrics",
                        "feature_adoption"
                    ]
                },
                {
                    "name": "Technical Dashboard",
                    "widgets": [
                        "deployment_frequency",
                        "error_tracking",
                        "performance_budgets",
                        "infrastructure_health"
                    ]
                }
            ]

            return {
                "status": "success",
                "dashboards_created": len(dashboards),
                "monitoring_features": {
                    "real_user_monitoring": real_user_monitoring["enabled"],
                    "performance_tracking": True,
                    "error_tracking": True,
                    "business_analytics": len(business_analytics)
                },
                "configuration": monitoring_config,
                "dashboards": dashboards,
                "description": "Enterprise monitoring and analytics deployed"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy monitoring and analytics: {e}")
            return {"status": "failed", "error": str(e)}

    async def get_deployment_status(self) -> Dict[str, Any]:
        """Get comprehensive status of all enterprise deployments"""
        try:
            status_report = {
                "platform_health": "healthy",
                "active_deployments": len(self.deployment_history),
                "team_metrics": {},
                "performance_metrics": {},
                "security_status": {},
                "recent_activity": []
            }

            # Team metrics
            team_metrics = {
                "total_team_members": 15,
                "active_projects": 8,
                "monthly_deployments": 127,
                "success_rate": "99.2%"
            }
            status_report["team_metrics"] = team_metrics

            # Performance metrics
            performance_metrics = {
                "average_build_time": "2m 34s",
                "p95_response_time": "487ms",
                "core_web_vitals_score": "94/100",
                "uptime": "99.98%"
            }
            status_report["performance_metrics"] = performance_metrics

            # Security status
            security_status = {
                "security_policies": "all_applied",
                "ssl_certificates": "valid",
                "vulnerability_scan": "passed",
                "last_security_audit": "2024-01-15"
            }
            status_report["security_status"] = security_status

            return status_report

        except Exception as e:
            self.logger.error(f"Failed to get deployment status: {e}")
            return {"status": "error", "error": str(e)}

    async def optimize_costs(self) -> Dict[str, Any]:
        """Analyze and optimize Vercel costs for enterprise usage"""
        try:
            optimization_results = {
                "current_usage": {},
                "optimization_recommendations": [],
                "potential_savings": {}
            }

            # Current usage analysis
            current_usage = {
                "bandwidth_gb": 2847,
                "function_invocations": 1250000,
                "build_minutes": 890,
                "team_seats": 15,
                "estimated_monthly_cost": "$2,450"
            }
            optimization_results["current_usage"] = current_usage

            # Optimization recommendations
            recommendations = [
                {
                    "category": "Bandwidth Optimization",
                    "recommendation": "Implement advanced image optimization and compression",
                    "potential_saving": "$180/month",
                    "implementation": [
                        "Enable WebP/AVIF format conversion",
                        "Implement lazy loading for images",
                        "Use responsive image breakpoints",
                        "Configure proper cache headers"
                    ]
                },
                {
                    "category": "Function Optimization",
                    "recommendation": "Optimize serverless function execution",
                    "potential_saving": "$220/month",
                    "implementation": [
                        "Reduce cold start times",
                        "Implement connection pooling",
                        "Optimize memory allocation",
                        "Cache frequent computations"
                    ]
                },
                {
                    "category": "Build Optimization",
                    "recommendation": "Optimize build processes and caching",
                    "potential_saving": "$95/month",
                    "implementation": [
                        "Implement incremental builds",
                        "Use build output caching",
                        "Optimize dependency resolution",
                        "Parallelize build steps"
                    ]
                }
            ]
            optimization_results["optimization_recommendations"] = recommendations

            # Calculate potential savings
            total_potential_savings = sum(
                int(rec["potential_saving"].replace("$", "").replace("/month", ""))
                for rec in recommendations
            )

            potential_savings = {
                "monthly_savings": f"${total_potential_savings}",
                "annual_savings": f"${total_potential_savings * 12}",
                "savings_percentage": f"{(total_potential_savings / 2450) * 100:.1f}%"
            }
            optimization_results["potential_savings"] = potential_savings

            return {
                "status": "success",
                "optimization_results": optimization_results,
                "description": "Cost optimization analysis completed"
            }

        except Exception as e:
            self.logger.error(f"Failed to analyze cost optimization: {e}")
            return {"status": "failed", "error": str(e)}

````python
from dataclasses import dataclass, field
from typing import Dict, List, Any, Optional, Union
from enum import Enum
import logging
import asyncio
import json
from datetime import datetime, timedelta

class VercelRegion(Enum):
    """Supported Vercel edge regions for enterprise deployment"""
    ALL = "all"  # Global edge network
    US_EAST_1 = "iad1"  # Washington D.C.
    US_WEST_1 = "sfo1"  # San Francisco
    EUROPE_WEST_1 = "fra1"  # Frankfurt
    ASIA_NORTHEAST_1 = "nrt1"  # Tokyo
    ASIA_SOUTHEAST_1 = "sin1"  # Singapore
    OCEANIA = "syd1"  # Sydney

class VercelFramework(Enum):
    """Supported frameworks for Vercel deployment"""
    NEXTJS = "nextjs"
    REACT = "create-react-app"
    VUE = "vue"
    NUXT = "nuxtjs"
    ANGULAR = "angular"
    SVELTE = "svelte"
    GATSBY = "gatsby"
    VITE = "vite"
    STATIC = "static"

class DeploymentEnvironment(Enum):
    """Deployment environment types"""
    PRODUCTION = "production"
    PREVIEW = "preview"
    DEVELOPMENT = "development"

@dataclass
class EnterpriseVercelConfig:
    """Enterprise Vercel configuration for team-based deployments"""

    # Team and Organization Configuration
    team_id: str
    organization_name: str
    primary_domain: str
    environment: DeploymentEnvironment

    # Framework Configuration
    framework: VercelFramework
    framework_version: str = "latest"

    # Deployment Configuration
    regions: List[VercelRegion] = field(default_factory=lambda: [
        VercelRegion.ALL  # Global edge by default
    ])

    # Team Management
    team_settings: Dict[str, Any] = field(default_factory=lambda: {
        "enable_sso": True,
        "require_2fa": True,
        "enable_audit_log": True,
        "session_timeout": 8,  # hours
        "allowed_domains": ["@company.com"],
        "enable_git_integration": True,
        "enable_preview_comments": True
    })

    # Security Configuration
    security_settings: Dict[str, Any] = field(default_factory=lambda: {
        "enable_password_protection": True,
        "enable_ip_blocking": True,
        "enable_ddos_protection": True,
        "enable_bot_protection": True,
        "security_headers": {
            "content-security-policy": True,
            "x-frame-options": "DENY",
            "x-content-type-options": "nosniff",
            "referrer-policy": "strict-origin-when-cross-origin",
            "permissions-policy": "geolocation=(), camera=(), microphone=()"
        },
        "enable_waf": True,
        "enable_rate_limiting": True
    })

    # Performance Configuration
    performance_settings: Dict[str, Any] = field(default_factory=lambda: {
        "enable_edge_caching": True,
        "enable_compression": True,
        "enable_image_optimization": True,
        "enable_analytics": True,
        "enable_web_vitals": True,
        "enable_speed_insights": True,
        "cache_control": "public, max-age=31536000, immutable"
    })

    # Environment Variables and Secrets
    environment_variables: Dict[str, Dict[str, str]] = field(default_factory=lambda: {
        "production": {},
        "preview": {},
        "development": {}
    })

    # Custom Domains and SSL
    domains_config: Dict[str, Any] = field(default_factory=lambda: {
        "custom_domains": [],
        "wildcard_domain": False,
        "ssl_certificates": "automatic",
        "redirect_rules": [],
        "headers": []
    })

    # Budget and Resource Limits
    resource_limits: Dict[str, Any] = field(default_factory=lambda: {
        "max_deployments_per_day": 100,
        "max_serverless_functions": 50,
        "max_edge_functions": 20,
        "bandwidth_limit_gb": 1000,
        "build_minutes_limit": 6000,
        "concurrent_builds": 10
    })

    # Monitoring and Alerting
    monitoring_config: Dict[str, Any] = field(default_factory=lambda: {
        "enable_real_time_logs": True,
        "enable_error_tracking": True,
        "enable_performance_monitoring": True,
        "log_retention_days": 30,
        "alert_channels": ["email", "slack", "webhook"]
    })

    # Integration Settings
    integrations: Dict[str, Any] = field(default_factory=lambda: {
        "github": {
            "enabled": True,
            "auto_deploy_branches": ["main", "production"],
            "preview_branches": ["develop", "staging", "feature/*"]
        },
        "gitlab": {"enabled": False},
        "bitbucket": {"enabled": False},
        "analytics": {
            "google_analytics": {"enabled": False, "id": ""},
            "mixpanel": {"enabled": False, "token": ""},
            "amplitude": {"enabled": False, "key": ""}
        },
        "monitoring": {
            "sentry": {"enabled": True, "dsn": ""},
            "datadog": {"enabled": False, "api_key": ""},
            "new_relic": {"enabled": False, "license_key": ""}
        }
    })

    # Custom Labels/Tags
    custom_tags: Dict[str, str] = field(default_factory=lambda: {
        "managed_by": "ai-ley-enterprise",
        "deployment_type": "enterprise",
        "cost_center": "engineering",
        "compliance": "required"
    })

    def get_project_name(self, service: str) -> str:
        """Generate consistent project names"""
        return f"{self.organization_name}-{service}-{self.environment.value}"

    def get_domain_name(self, subdomain: str = None) -> str:
        """Get full domain name"""
        if subdomain:
            return f"{subdomain}.{self.primary_domain}"
        return self.primary_domain

class EnterpriseVercelPlatform:
    """Enterprise Vercel platform for comprehensive web application deployment"""

    def __init__(self, config: EnterpriseVercelConfig):
        self.config = config
        self.logger = self._setup_logging()

        # Vercel API client configuration
        self.api_token = None
        self.team_id = config.team_id
        self.base_url = "https://api.vercel.com"

        # Deployment state tracking
        self.deployed_projects = {}
        self.active_deployments = {}

    def _setup_logging(self) -> logging.Logger:
        """Set up comprehensive logging for Vercel operations"""
        logger = logging.getLogger(f"vercel_enterprise_{self.config.team_id}")
        handler = logging.StreamHandler()
        formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        logger.setLevel(logging.INFO)
        return logger

    async def initialize_enterprise_platform(self) -> Dict[str, Any]:
        """Initialize the enterprise Vercel platform"""
        try:
            self.logger.info("Initializing Enterprise Vercel Platform")

            # Initialize API client
            await self._initialize_api_client()

            # Setup team configuration
            team_result = await self._setup_team_configuration()

            # Configure security settings
            security_result = await self._setup_security_configuration()

            # Setup monitoring and analytics
            monitoring_result = await self._setup_monitoring_configuration()

            # Configure integrations
            integration_result = await self._setup_integrations()

            return {
                "status": "success",
                "platform": "Vercel Enterprise",
                "team_id": self.config.team_id,
                "organization": self.config.organization_name,
                "framework": self.config.framework.value,
                "regions": [region.value for region in self.config.regions],
                "team_setup": team_result["status"],
                "security_setup": security_result["status"],
                "monitoring_setup": monitoring_result["status"],
                "integration_setup": integration_result["status"],
                "description": "Enterprise Vercel platform ready for deployment"
            }

        except Exception as e:
            self.logger.error(f"Failed to initialize Vercel platform: {e}")
            return {
                "status": "failed",
                "error": str(e),
                "platform": "Vercel Enterprise"
            }

    async def _initialize_api_client(self) -> None:
        """Initialize Vercel API client"""
        try:
            # In real implementation, this would initialize the actual Vercel API client
            # import vercel
            # self.client = vercel.Client(token=self.api_token, team_id=self.team_id)

            self.logger.info("Vercel API client initialized successfully")

        except Exception as e:
            self.logger.error(f"Failed to initialize API client: {e}")
            raise

    async def _setup_team_configuration(self) -> Dict[str, Any]:
        """Setup enterprise team configuration"""
        try:
            team_config = {
                "team_id": self.config.team_id,
                "name": self.config.organization_name,
                "settings": self.config.team_settings,
                "members": [],
                "projects": [],
                "billing": {}
            }

            # Team member roles and permissions
            member_roles = [
                {
                    "role": "OWNER",
                    "permissions": [
                        "team:read", "team:edit", "team:delete",
                        "project:read", "project:create", "project:edit", "project:delete",
                        "deployment:read", "deployment:create", "deployment:delete",
                        "domain:read", "domain:create", "domain:edit", "domain:delete",
                        "billing:read", "billing:edit",
                        "member:read", "member:invite", "member:edit", "member:remove"
                    ],
                    "description": "Full access to team resources and management"
                },
                {
                    "role": "ADMIN",
                    "permissions": [
                        "team:read", "team:edit",
                        "project:read", "project:create", "project:edit",
                        "deployment:read", "deployment:create", "deployment:delete",
                        "domain:read", "domain:create", "domain:edit",
                        "member:read", "member:invite", "member:edit"
                    ],
                    "description": "Administrative access without billing and deletion rights"
                },
                {
                    "role": "DEVELOPER",
                    "permissions": [
                        "team:read",
                        "project:read", "project:create", "project:edit",
                        "deployment:read", "deployment:create",
                        "domain:read"
                    ],
                    "description": "Development access for deployments and projects"
                },
                {
                    "role": "VIEWER",
                    "permissions": [
                        "team:read",
                        "project:read",
                        "deployment:read",
                        "domain:read"
                    ],
                    "description": "Read-only access for monitoring and analysis"
                }
            ]
            team_config["member_roles"] = member_roles

            # Team settings configuration
            if self.config.team_settings["enable_sso"]:
                sso_config = {
                    "enabled": True,
                    "provider": "saml",
                    "domains": self.config.team_settings["allowed_domains"],
                    "enforce_sso": True,
                    "session_timeout": self.config.team_settings["session_timeout"]
                }
                team_config["sso"] = sso_config

            if self.config.team_settings["require_2fa"]:
                team_config["require_2fa"] = True

            if self.config.team_settings["enable_audit_log"]:
                audit_config = {
                    "enabled": True,
                    "retention_days": 90,
                    "events": [
                        "member.added", "member.removed", "member.role_changed",
                        "project.created", "project.deleted", "project.transferred",
                        "deployment.created", "deployment.deleted",
                        "domain.added", "domain.removed", "domain.verified",
                        "team.settings_changed", "billing.plan_changed"
                    ]
                }
                team_config["audit_log"] = audit_config

            return {
                "status": "success",
                "team_config": team_config,
                "member_roles": len(member_roles),
                "description": "Enterprise team configuration ready"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup team configuration: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def _setup_security_configuration(self) -> Dict[str, Any]:
        """Setup comprehensive security configuration"""
        try:
            security_config = {
                "password_protection": self.config.security_settings.get("enable_password_protection", False),
                "ip_blocking": self.config.security_settings.get("enable_ip_blocking", False),
                "ddos_protection": self.config.security_settings.get("enable_ddos_protection", True),
                "bot_protection": self.config.security_settings.get("enable_bot_protection", True),
                "waf": self.config.security_settings.get("enable_waf", True),
                "rate_limiting": self.config.security_settings.get("enable_rate_limiting", True),
                "security_headers": self.config.security_settings.get("security_headers", {}),
                "policies": []
            }

            # Security headers configuration
            headers_config = []
            for header, value in self.config.security_settings["security_headers"].items():
                if isinstance(value, bool) and value:
                    # Default security header values
                    header_values = {
                        "content-security-policy": "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';",
                        "x-frame-options": "DENY",
                        "x-content-type-options": "nosniff",
                        "referrer-policy": "strict-origin-when-cross-origin",
                        "permissions-policy": "geolocation=(), camera=(), microphone=()"
                    }
                    headers_config.append({
                        "key": header.title(),
                        "value": header_values.get(header, str(value))
                    })
                elif isinstance(value, str):
                    headers_config.append({
                        "key": header.title(),
                        "value": value
                    })
            security_config["headers_config"] = headers_config

            # WAF rules configuration
            if security_config["waf"]:
                waf_rules = [
                    {
                        "name": "Block SQL Injection",
                        "enabled": True,
                        "rule": "contains(lower(http.request.uri.query), 'union select')",
                        "action": "block"
                    },
                    {
                        "name": "Block XSS Attempts",
                        "enabled": True,
                        "rule": "contains(lower(http.request.uri.query), '<script')",
                        "action": "block"
                    },
                    {
                        "name": "Rate Limit API Endpoints",
                        "enabled": True,
                        "rule": "starts_with(http.request.uri.path, '/api/')",
                        "action": "rate_limit",
                        "rate_limit": {
                            "requests": 100,
                            "window": "1m"
                        }
                    },
                    {
                        "name": "Geographic Restrictions",
                        "enabled": False,
                        "rule": "ip.geoip.country in {'CN' 'RU' 'KP'}",
                        "action": "block"
                    }
                ]
                security_config["waf_rules"] = waf_rules

            # Rate limiting configuration
            if security_config["rate_limiting"]:
                rate_limit_config = [
                    {
                        "path": "/api/*",
                        "requests": 1000,
                        "window": "1h",
                        "skip": ["127.0.0.1", "::1"]
                    },
                    {
                        "path": "/auth/*",
                        "requests": 10,
                        "window": "1m",
                        "action": "block"
                    },
                    {
                        "path": "/*",
                        "requests": 10000,
                        "window": "1h",
                        "action": "throttle"
                    }
                ]
                security_config["rate_limits"] = rate_limit_config

            # Security monitoring and alerting
            security_monitoring = {
                "enable_security_alerts": True,
                "alert_conditions": [
                    {
                        "name": "Suspicious Traffic Pattern",
                        "condition": "request_count > 1000 AND unique_ips < 10",
                        "severity": "high",
                        "notification": ["email", "slack"]
                    },
                    {
                        "name": "WAF Rule Violations",
                        "condition": "waf_blocks > 100",
                        "severity": "medium",
                        "notification": ["email"]
                    },
                    {
                        "name": "Authentication Failures",
                        "condition": "auth_failures > 50",
                        "severity": "high",
                        "notification": ["email", "slack", "webhook"]
                    }
                ],
                "incident_response": {
                    "auto_block_threshold": 1000,  # requests per minute
                    "escalation_timeout": 15,  # minutes
                    "enable_auto_mitigation": True
                }
            }
            security_config["monitoring"] = security_monitoring

            return {
                "status": "success",
                "security_config": security_config,
                "headers_configured": len(headers_config),
                "waf_rules": len(security_config.get("waf_rules", [])),
                "rate_limits": len(security_config.get("rate_limits", [])),
                "description": "Enterprise security configuration ready"
            }

    async def _setup_monitoring_configuration(self) -> Dict[str, Any]:
        """Setup comprehensive monitoring and analytics"""
        try:
            monitoring_config = {
                "analytics": self.config.performance_settings.get("enable_analytics", True),
                "web_vitals": self.config.performance_settings.get("enable_web_vitals", True),
                "speed_insights": self.config.performance_settings.get("enable_speed_insights", True),
                "real_time_logs": self.config.monitoring_config.get("enable_real_time_logs", True),
                "error_tracking": self.config.monitoring_config.get("enable_error_tracking", True),
                "performance_monitoring": self.config.monitoring_config.get("enable_performance_monitoring", True),
                "log_retention": self.config.monitoring_config.get("log_retention_days", 30),
                "dashboards": [],
                "alerts": []
            }

            # Analytics configuration
            if monitoring_config["analytics"]:
                analytics_config = {
                    "enabled": True,
                    "data_retention_days": 90,
                    "metrics": [
                        "page_views", "unique_visitors", "session_duration",
                        "bounce_rate", "conversion_rate", "geographic_distribution",
                        "device_breakdown", "browser_breakdown", "referrer_sources"
                    ],
                    "custom_events": [
                        "user_signup", "purchase_completed", "feature_used",
                        "error_occurred", "api_call_made"
                    ],
                    "funnels": [
                        {
                            "name": "User Onboarding",
                            "steps": ["landing_page", "signup_form", "email_verification", "profile_completion"]
                        },
                        {
                            "name": "Purchase Flow",
                            "steps": ["product_view", "add_to_cart", "checkout", "payment", "confirmation"]
                        }
                    ]
                }
                monitoring_config["analytics_config"] = analytics_config

            # Web Vitals monitoring
            if monitoring_config["web_vitals"]:
                web_vitals_config = {
                    "enabled": True,
                    "metrics": [
                        "largest_contentful_paint", "first_input_delay", "cumulative_layout_shift",
                        "first_contentful_paint", "time_to_first_byte", "interaction_to_next_paint"
                    ],
                    "thresholds": {
                        "lcp": {"good": 2500, "needs_improvement": 4000},
                        "fid": {"good": 100, "needs_improvement": 300},
                        "cls": {"good": 0.1, "needs_improvement": 0.25},
                        "fcp": {"good": 1800, "needs_improvement": 3000},
                        "ttfb": {"good": 600, "needs_improvement": 1500},
                        "inp": {"good": 200, "needs_improvement": 500}
                    },
                    "sampling_rate": 1.0,  # 100% sampling for enterprise
                    "real_user_monitoring": True
                }
                monitoring_config["web_vitals_config"] = web_vitals_config

            # Performance monitoring setup
            if monitoring_config["performance_monitoring"]:
                performance_config = {
                    "enabled": True,
                    "monitoring_areas": [
                        "serverless_functions", "edge_functions", "static_assets",
                        "api_endpoints", "database_queries", "third_party_services"
                    ],
                    "metrics": [
                        "response_time", "throughput", "error_rate", "memory_usage",
                        "cold_starts", "execution_duration", "concurrent_executions"
                    ],
                    "alerting_thresholds": {
                        "response_time": {"warning": 1000, "critical": 5000},  # milliseconds
                        "error_rate": {"warning": 1, "critical": 5},  # percentage
                        "memory_usage": {"warning": 80, "critical": 95},  # percentage
                        "cold_start_rate": {"warning": 10, "critical": 25}  # percentage
                    }
                }
                monitoring_config["performance_config"] = performance_config

            # Real-time logging configuration
            if monitoring_config["real_time_logs"]:
                logging_config = {
                    "enabled": True,
                    "log_levels": ["error", "warn", "info", "debug"],
                    "sources": [
                        "serverless_functions", "edge_functions", "build_logs",
                        "access_logs", "security_logs", "performance_logs"
                    ],
                    "filters": [
                        {
                            "name": "error_logs",
                            "query": "level:error",
                            "retention_days": 90
                        },
                        {
                            "name": "security_events",
                            "query": "type:security OR type:authentication",
                            "retention_days": 365
                        },
                        {
                            "name": "performance_logs",
                            "query": "type:performance AND duration:>1000",
                            "retention_days": 30
                        }
                    ],
                    "export_destinations": [
                        {
                            "type": "s3",
                            "bucket": f"{self.config.organization_name}-vercel-logs",
                            "prefix": "logs/",
                            "compression": "gzip"
                        },
                        {
                            "type": "elasticsearch",
                            "endpoint": "https://elasticsearch.company.com",
                            "index_pattern": "vercel-logs-*"
                        }
                    ]
                }
                monitoring_config["logging_config"] = logging_config

            # Custom dashboards
            dashboards = [
                {
                    "name": "Executive Overview",
                    "description": "High-level metrics for executive reporting",
                    "widgets": [
                        {
                            "type": "metric",
                            "title": "Total Page Views",
                            "query": "sum(page_views)",
                            "time_range": "7d"
                        },
                        {
                            "type": "chart",
                            "title": "Traffic Trend",
                            "query": "page_views over time",
                            "chart_type": "line",
                            "time_range": "30d"
                        },
                        {
                            "type": "table",
                            "title": "Top Performing Pages",
                            "query": "page_views by page_path",
                            "limit": 10
                        },
                        {
                            "type": "gauge",
                            "title": "Core Web Vitals Score",
                            "query": "avg(web_vitals_score)",
                            "target": 90
                        }
                    ]
                },
                {
                    "name": "Technical Performance",
                    "description": "Detailed technical metrics for development teams",
                    "widgets": [
                        {
                            "type": "chart",
                            "title": "Response Time Distribution",
                            "query": "response_time percentiles",
                            "chart_type": "histogram"
                        },
                        {
                            "type": "chart",
                            "title": "Error Rate Trend",
                            "query": "error_rate over time",
                            "chart_type": "line"
                        },
                        {
                            "type": "table",
                            "title": "Slowest API Endpoints",
                            "query": "avg(response_time) by endpoint",
                            "order": "desc"
                        },
                        {
                            "type": "metric",
                            "title": "Cold Start Rate",
                            "query": "cold_starts / total_invocations * 100"
                        }
                    ]
                },
                {
                    "name": "Security Monitoring",
                    "description": "Security events and threat monitoring",
                    "widgets": [
                        {
                            "type": "chart",
                            "title": "WAF Blocks Over Time",
                            "query": "waf_blocks over time",
                            "chart_type": "area"
                        },
                        {
                            "type": "table",
                            "title": "Top Blocked IPs",
                            "query": "count(*) by client_ip where blocked=true",
                            "limit": 20
                        },
                        {
                            "type": "metric",
                            "title": "Authentication Failures",
                            "query": "sum(auth_failures)",
                            "time_range": "24h"
                        },
                        {
                            "type": "map",
                            "title": "Geographic Threat Distribution",
                            "query": "threat_score by country"
                        }
                    ]
                }
            ]
            monitoring_config["dashboards"] = dashboards

            # Alert configurations
            alerts = [
                {
                    "name": "High Error Rate",
                    "condition": "error_rate > 5%",
                    "window": "5m",
                    "severity": "critical",
                    "channels": ["email", "slack"],
                    "recipients": ["dev-team@company.com", "#alerts-critical"]
                },
                {
                    "name": "Slow Response Time",
                    "condition": "avg(response_time) > 2000ms",
                    "window": "10m",
                    "severity": "warning",
                    "channels": ["email"],
                    "recipients": ["dev-team@company.com"]
                },
                {
                    "name": "High Memory Usage",
                    "condition": "memory_usage > 90%",
                    "window": "5m",
                    "severity": "warning",
                    "channels": ["email", "slack"],
                    "recipients": ["dev-team@company.com", "#alerts-infra"]
                },
                {
                    "name": "Deployment Failure",
                    "condition": "deployment_status = 'FAILED'",
                    "window": "1m",
                    "severity": "critical",
                    "channels": ["email", "slack", "pagerduty"],
                    "recipients": ["dev-team@company.com", "#alerts-critical"]
                },
                {
                    "name": "Security Incident",
                    "condition": "waf_blocks > 1000",
                    "window": "1m",
                    "severity": "high",
                    "channels": ["email", "slack", "webhook"],
                    "recipients": ["security@company.com", "#security-alerts"]
                },
                {
                    "name": "Poor Web Vitals",
                    "condition": "lcp > 4000ms OR cls > 0.25",
                    "window": "15m",
                    "severity": "warning",
                    "channels": ["email"],
                    "recipients": ["frontend-team@company.com"]
                }
            ]
            monitoring_config["alerts"] = alerts

            return {
                "status": "success",
                "monitoring_config": monitoring_config,
                "dashboards_created": len(dashboards),
                "alerts_configured": len(alerts),
                "description": "Enterprise monitoring and analytics configured"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup monitoring configuration: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def _setup_integrations(self) -> Dict[str, Any]:
        """Setup third-party integrations"""
        try:
            integration_results = []

            # GitHub integration
            if self.config.integrations["github"]["enabled"]:
                github_integration = {
                    "service": "GitHub",
                    "enabled": True,
                    "configuration": {
                        "auto_deploy_branches": self.config.integrations["github"]["auto_deploy_branches"],
                        "preview_branches": self.config.integrations["github"]["preview_branches"],
                        "deployment_protection_rules": True,
                        "required_status_checks": ["build", "test", "lint"],
                        "auto_merge_preview": False,
                        "comment_on_pr": True,
                        "deployment_comments": True
                    }
                }
                integration_results.append(github_integration)

            # Analytics integrations
            analytics_integrations = []
            for service, config in self.config.integrations["analytics"].items():
                if config["enabled"]:
                    analytics_integration = {
                        "service": service,
                        "enabled": True,
                        "configuration": config
                    }
                    analytics_integrations.append(analytics_integration)

            # Monitoring integrations
            monitoring_integrations = []
            for service, config in self.config.integrations["monitoring"].items():
                if config["enabled"]:
                    monitoring_integration = {
                        "service": service,
                        "enabled": True,
                        "configuration": config
                    }
                    monitoring_integrations.append(monitoring_integration)

            return {
                "status": "success",
                "git_integrations": len([r for r in integration_results if r["service"] in ["GitHub", "GitLab", "Bitbucket"]]),
                "analytics_integrations": len(analytics_integrations),
                "monitoring_integrations": len(monitoring_integrations),
                "total_integrations": len(integration_results) + len(analytics_integrations) + len(monitoring_integrations),
                "description": "Enterprise integrations configured"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup integrations: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def deploy_enterprise_project(self, project_config: Dict[str, Any]) -> Dict[str, Any]:
        """Deploy enterprise project with advanced configuration"""
        try:
            self.logger.info(f"Deploying enterprise project: {project_config.get('name', 'Unknown')}")

            # Project deployment configuration
            deployment_config = {
                "name": project_config["name"],
                "framework": self.config.framework.value,
                "root_directory": project_config.get("root_directory", ""),
                "build_command": project_config.get("build_command", ""),
                "install_command": project_config.get("install_command", ""),
                "output_directory": project_config.get("output_directory", ""),
                "environment": self.config.environment.value,
                "regions": [region.value for region in self.config.regions]
            }

            # Environment variables setup
            env_vars = {}
            if self.config.environment.value in self.config.environment_variables:
                env_vars = self.config.environment_variables[self.config.environment.value]

            # Custom domains configuration
            domains_config = []
            for domain in self.config.domains_config.get("custom_domains", []):
                domain_config = {
                    "name": domain,
                    "redirect": False,
                    "certificate": self.config.domains_config.get("ssl_certificates", "automatic")
                }
                domains_config.append(domain_config)

            # Serverless functions configuration
            functions_config = project_config.get("functions", {})
            if functions_config:
                for func_name, func_config in functions_config.items():
                    func_config.update({
                        "memory": func_config.get("memory", 1024),
                        "maxDuration": func_config.get("maxDuration", 30),
                        "regions": [region.value for region in self.config.regions]
                    })

            # Edge functions configuration
            edge_functions_config = project_config.get("edge_functions", {})

            # Performance optimization
            performance_config = {
                "compression": self.config.performance_settings.get("enable_compression", True),
                "image_optimization": self.config.performance_settings.get("enable_image_optimization", True),
                "edge_caching": self.config.performance_settings.get("enable_edge_caching", True),
                "cache_control": self.config.performance_settings.get("cache_control", "public, max-age=31536000, immutable")
            }

            # Security headers
            headers_config = []
            for header_config in self.config.security_settings.get("security_headers", {}).items():
                if header_config[1]:
                    headers_config.append({
                        "key": header_config[0],
                        "value": str(header_config[1])
                    })

            deployment_result = {
                "project_id": f"prj_{project_config['name']}_{self.config.team_id}",
                "deployment_id": f"dpl_{datetime.now().strftime('%Y%m%d_%H%M%S')}",
                "name": deployment_config["name"],
                "url": f"https://{project_config['name']}.vercel.app",
                "custom_domains": [domain["name"] for domain in domains_config],
                "environment": deployment_config["environment"],
                "framework": deployment_config["framework"],
                "regions": deployment_config["regions"],
                "functions_count": len(functions_config),
                "edge_functions_count": len(edge_functions_config),
                "environment_variables": len(env_vars),
                "security_headers": len(headers_config),
                "status": "deployed",
                "created_at": datetime.now().isoformat(),
                "build_duration": "45s",  # Mock build time
                "deployment_size": "2.4 MB"
            }

            # Store deployment state
            self.deployed_projects[project_config["name"]] = deployment_result

            return {
                "status": "success",
                "deployment": deployment_result,
                "description": f"Enterprise project {project_config['name']} deployed successfully"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy project: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }
- Building applications requiring edge computing and global performance
- Need built-in monitoring, analytics, and performance optimization
- Want zero-configuration deployment with intelligent build detection
- Building e-commerce, SaaS, or content-heavy applications with SSR/SSG

### ❌ **Avoid Vercel When**

- Building traditional server-side applications requiring persistent connections
- Need complex database operations requiring long-running processes
- Working with legacy applications not suited for serverless architecture
- Building applications requiring WebSocket connections or real-time features
- Need extensive backend services beyond API routes and functions
- Working with applications requiring custom server configuration
- Building desktop applications or mobile backends requiring specialized hosting

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | Vercel Recommendation                     | Configuration Priority         |
| ---------------------- | ----------------------------------------- | ------------------------------ |
| Next.js Application    | ✅ **Essential** - Perfect integration    | High - Framework optimization  |
| React SPA              | ✅ **Essential** - Excellent performance  | High - Static optimization     |
| E-commerce Site        | ✅ **Essential** - Commerce features      | High - Performance + Analytics |
| Documentation Site     | ✅ **Recommended** - Fast SSG             | Medium - SEO optimization      |
| Portfolio Website      | ✅ **Recommended** - Easy management      | Medium - Custom domain         |
| Enterprise Application | 🔄 **Consider** - May need Pro/Enterprise | High - Team collaboration      |

### Complexity Assessment

| Factor            | Low Complexity       | Medium Complexity      | High Complexity                 |
| ----------------- | -------------------- | ---------------------- | ------------------------------- |
| **Setup Time**    | 10 minutes (Next.js) | 1 hour (custom config) | 4 hours (enterprise setup)      |
| **Features Used** | Static hosting + CDN | API routes + analytics | Full platform features          |
| **Framework**     | Standard Next.js     | Custom framework       | Multi-framework monorepo        |
| **Backend Needs** | Static/SSG           | API routes             | Complex serverless architecture |

## Installation & Setup

### Vercel CLI Installation

```bash
# npm installation (recommended)
npm install -g vercel

# yarn installation
yarn global add vercel

# pnpm installation
pnpm add -g vercel

# Verify installation
vercel --version
vc --version  # Short alias

# Login to Vercel
vercel login
vercel auth
`````

### Project Integration

```bash
# Deploy existing project
cd your-project
vercel

# Initialize new project with framework
npx create-next-app@latest my-app
cd my-app
vercel

# Link existing project to Vercel
vercel link

# Set up development environment
vercel dev
vercel dev --listen 4000  # Custom port

# Deploy specific environment
vercel --prod              # Production deployment
vercel --target production # Alias for production
```

### Framework-Specific Setup

```bash
# Next.js setup (recommended)
npx create-next-app@latest my-next-app --typescript --tailwind --eslint
cd my-next-app
vercel

# React setup
npx create-react-app my-react-app
cd my-react-app
vercel

# Vue.js setup
npm create vue@latest my-vue-app
cd my-vue-app
vercel

# Vite setup
npm create vite@latest my-vite-app
cd my-vite-app
vercel
```

## Configuration

### vercel.json Configuration

```json
{
  "version": 2,
  "name": "my-awesome-app",
  "build": {
    "env": {
      "NODE_VERSION": "18.x",
      "NPM_VERSION": "8.x"
    }
  },
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm ci",
  "devCommand": "npm run dev",
  "framework": "nextjs",
  "functions": {
    "pages/api/**/*.js": {
      "runtime": "nodejs18.x",
      "maxDuration": 10
    },
    "api/**/*.ts": {
      "runtime": "nodejs18.x",
      "maxDuration": 30
    }
  },
  "headers": [
    {
      "source": "/api/(.*)",
      "headers": [
        {
          "key": "Access-Control-Allow-Origin",
          "value": "*"
        },
        {
          "key": "Access-Control-Allow-Methods",
          "value": "GET, POST, PUT, DELETE, OPTIONS"
        },
        {
          "key": "Access-Control-Allow-Headers",
          "value": "Content-Type, Authorization"
        }
      ]
    },
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        }
      ]
    }
  ],
  "redirects": [
    {
      "source": "/old-page",
      "destination": "/new-page",
      "permanent": true
    },
    {
      "source": "/blog/:slug*",
      "destination": "/posts/:slug*",
      "permanent": false
    }
  ],
  "rewrites": [
    {
      "source": "/api/proxy/:path*",
      "destination": "https://external-api.com/:path*"
    }
  ],
  "trailingSlash": false,
  "cleanUrls": true,
  "regions": ["iad1", "sfo1"],
  "env": {
    "API_URL": "@api_url",
    "DATABASE_URL": "@database_url"
  },
  "crons": [
    {
      "path": "/api/cron/cleanup",
      "schedule": "0 2 * * *"
    }
  ]
}
```

### Advanced Next.js Configuration

```json
{
  "version": 2,
  "name": "nextjs-app",
  "build": {
    "env": {
      "NEXT_TELEMETRY_DISABLED": "1",
      "NODE_ENV": "production"
    }
  },
  "functions": {
    "pages/api/**/*.js": {
      "runtime": "nodejs18.x",
      "maxDuration": 30,
      "memory": 1024
    }
  },
  "headers": [
    {
      "source": "/_next/static/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    },
    {
      "source": "/api/(.*)",
      "headers": [
        {
          "key": "Access-Control-Allow-Credentials",
          "value": "true"
        },
        {
          "key": "Access-Control-Allow-Origin",
          "value": "https://yourdomain.com"
        }
      ]
    }
  ],
  "redirects": [
    {
      "source": "/home",
      "destination": "/",
      "permanent": true
    }
  ],
  "images": {
    "domains": ["example.com", "images.unsplash.com"],
    "formats": ["image/webp", "image/avif"]
  }
}
```

### Environment Variables Configuration

```bash
# .env.local (Next.js)
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
NEXTAUTH_SECRET=your-secret-key
NEXTAUTH_URL=http://localhost:3000

# APIs
API_BASE_URL=https://api.yourservice.com
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLISHABLE_KEY=pk_test_...

# Analytics
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
NEXT_PUBLIC_ANALYTICS_ID=your-analytics-id

# Feature flags
NEXT_PUBLIC_FEATURE_NEW_UI=true
NEXT_PUBLIC_DEBUG_MODE=false

# Vercel-specific
VERCEL_URL=your-deployment-url.vercel.app
VERCEL_ENV=development
```

### Middleware Configuration

```typescript
// middleware.ts - Edge middleware
import { NextRequest, NextResponse } from 'next/server';
import { geolocation } from '@vercel/edge';

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Geolocation-based redirects
  const { country } = geolocation(request);

  if (pathname === '/' && country === 'CA') {
    return NextResponse.redirect(new URL('/ca', request.url));
  }

  // Authentication check
  if (pathname.startsWith('/dashboard')) {
    const token = request.cookies.get('auth-token');

    if (!token) {
      return NextResponse.redirect(new URL('/login', request.url));
    }
  }

  // Security headers
  const response = NextResponse.next();
  response.headers.set('X-Content-Type-Options', 'nosniff');
  response.headers.set('X-Frame-Options', 'DENY');
  response.headers.set('X-XSS-Protection', '1; mode=block');

  return response;
}

export const config = {
  matcher: ['/((?!api|_next/static|_next/image|favicon.ico).*)'],
};
```

## Core Features

### Serverless Functions (API Routes)

- **Purpose**: Create backend API endpoints without server management
- **Usage**: Handle form submissions, database operations, third-party integrations
- **Example**:

```typescript
// pages/api/users/[id].ts - Next.js API route
import type { NextApiRequest, NextApiResponse } from 'next';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

type Data = {
  user?: any;
  error?: string;
};

export default async function handler(req: NextApiRequest, res: NextApiResponse<Data>) {
  const { id } = req.query;

  try {
    switch (req.method) {
      case 'GET':
        const user = await prisma.user.findUnique({
          where: { id: String(id) },
        });

        if (!user) {
          return res.status(404).json({ error: 'User not found' });
        }

        res.status(200).json({ user });
        break;

      case 'PUT':
        const updatedUser = await prisma.user.update({
          where: { id: String(id) },
          data: req.body,
        });

        res.status(200).json({ user: updatedUser });
        break;

      case 'DELETE':
        await prisma.user.delete({
          where: { id: String(id) },
        });

        res.status(204).end();
        break;

      default:
        res.setHeader('Allow', ['GET', 'PUT', 'DELETE']);
        res.status(405).json({ error: 'Method not allowed' });
    }
  } catch (error) {
    console.error('API Error:', error);
    res.status(500).json({ error: 'Internal server error' });
  } finally {
    await prisma.$disconnect();
  }
}

// pages/api/auth/login.ts - Authentication endpoint
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { email, password } = req.body;

  try {
    // Validate input
    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password required' });
    }

    // Find user
    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user || !(await bcrypt.compare(password, user.password))) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    // Generate JWT
    const token = jwt.sign({ userId: user.id, email: user.email }, process.env.JWT_SECRET!, {
      expiresIn: '24h',
    });

    res.status(200).json({
      token,
      user: { id: user.id, email: user.email, name: user.name },
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

### Edge Functions

- **Purpose**: Run code at the edge for ultra-low latency and global performance
- **Usage**: A/B testing, personalization, authentication, redirects
- **Example**:

```typescript
// middleware.ts - Edge function for A/B testing
import { NextRequest, NextResponse } from 'next/server';

export function middleware(request: NextRequest) {
  // A/B testing logic
  const bucket = request.cookies.get('bucket')?.value;
  const pathname = request.nextUrl.pathname;

  if (pathname === '/' && !bucket) {
    // Assign user to A/B test bucket
    const testBucket = Math.random() < 0.5 ? 'A' : 'B';
    const response = NextResponse.next();

    response.cookies.set('bucket', testBucket, {
      maxAge: 60 * 60 * 24 * 30, // 30 days
      httpOnly: true,
    });

    // Redirect to variant if needed
    if (testBucket === 'B') {
      return NextResponse.redirect(new URL('/variant-b', request.url));
    }

    return response;
  }

  return NextResponse.next();
}

// pages/api/edge/analytics.ts - Edge API function
import { NextRequest } from 'next/server';

export const config = {
  runtime: 'edge',
};

export default async function handler(req: NextRequest) {
  const { searchParams } = new URL(req.url);
  const event = searchParams.get('event');
  const userId = searchParams.get('userId');

  // Log analytics event
  await fetch('https://analytics-api.com/events', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${process.env.ANALYTICS_API_KEY}`,
    },
    body: JSON.stringify({
      event,
      userId,
      timestamp: new Date().toISOString(),
      userAgent: req.headers.get('user-agent'),
      country: req.geo?.country,
    }),
  });

  return new Response(JSON.stringify({ success: true }), {
    headers: { 'Content-Type': 'application/json' },
  });
}
```

### Incremental Static Regeneration (ISR)

- **Purpose**: Combine static generation with dynamic updates for optimal performance
- **Usage**: E-commerce product pages, blog posts, frequently updated content
- **Example**:

```typescript
// pages/products/[id].tsx - ISR product page
import { GetStaticProps, GetStaticPaths } from 'next';

interface Product {
  id: string;
  name: string;
  price: number;
  description: string;
  updatedAt: string;
}

interface ProductPageProps {
  product: Product;
}

export default function ProductPage({ product }: ProductPageProps) {
  return (
    <div>
      <h1>{product.name}</h1>
      <p>Price: ${product.price}</p>
      <p>{product.description}</p>
      <small>Last updated: {product.updatedAt}</small>
    </div>
  );
}

export const getStaticPaths: GetStaticPaths = async () => {
  // Pre-generate top 100 product pages
  const popularProducts = await fetch('https://api.store.com/products/popular').then((res) =>
    res.json(),
  );

  const paths = popularProducts.map((product: Product) => ({
    params: { id: product.id },
  }));

  return {
    paths,
    fallback: 'blocking', // Generate other pages on-demand
  };
};

export const getStaticProps: GetStaticProps = async ({ params }) => {
  const product = await fetch(`https://api.store.com/products/${params?.id}`).then((res) =>
    res.json(),
  );

  if (!product) {
    return { notFound: true };
  }

  return {
    props: { product },
    revalidate: 3600, // Revalidate every hour
  };
};
```

### Image Optimization

- **Purpose**: Automatic image optimization and delivery via CDN
- **Usage**: Optimize images for performance and user experience
- **Example**:

```typescript
// components/OptimizedImage.tsx
import Image from 'next/image';

interface OptimizedImageProps {
  src: string;
  alt: string;
  width: number;
  height: number;
  priority?: boolean;
}

export default function OptimizedImage({
  src,
  alt,
  width,
  height,
  priority = false,
}: OptimizedImageProps) {
  return (
    <Image
      src={src}
      alt={alt}
      width={width}
      height={height}
      priority={priority}
      placeholder="blur"
      blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAAIAAoDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAv/xAAhEAACAQMDBQAAAAAAAAAAAAABAgMABAUGIWGRkqGx0f/EABUBAQEAAAAAAAAAAAAAAAAAAAMF/8QAGhEAAgIDAAAAAAAAAAAAAAAAAAECEgMRkf/aAAwDAQACEQMRAD8AltJagyeH0AthI5xdrLcNM91BF5pX2HaH9bcfaSXWGaRmknyJckliyjqTzSlT54b6bk+h0R//2Q=="
      quality={85}
      formats={['image/webp', 'image/avif']}
      sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
      className="rounded-lg shadow-md"
    />
  );
}

// next.config.js - Image configuration
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    domains: ['images.unsplash.com', 'cdn.shopify.com', 'your-cdn.com'],
    formats: ['image/webp', 'image/avif'],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920, 2048, 3840],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
    minimumCacheTTL: 60 * 60 * 24 * 365, // 1 year
  },
};

module.exports = nextConfig;
```

## Common Commands

```bash
# Essential daily commands
vercel                              # Deploy current directory
vercel --prod                       # Deploy to production
vercel dev                          # Start local development server
vercel ls                           # List deployments

# Project management
vercel projects ls                  # List all projects
vercel projects add my-project      # Create new project
vercel projects rm my-project       # Remove project
vercel link                         # Link local project to Vercel

# Environment management
vercel env ls                       # List environment variables
vercel env add                      # Add environment variable
vercel env rm VAR_NAME             # Remove environment variable
vercel env pull .env.local         # Download environment variables

# Domain management
vercel domains ls                   # List domains
vercel domains add example.com      # Add custom domain
vercel domains rm example.com       # Remove domain
vercel domains verify example.com   # Verify domain ownership

# Team and collaboration
vercel teams ls                     # List teams
vercel teams switch team-name       # Switch to team
vercel teams invite user@email.com  # Invite team member

# Analytics and monitoring
vercel logs                         # View function logs
vercel inspect deployment-url       # Inspect deployment details
vercel analytics                    # View analytics data

# Deployment management
vercel alias set deployment-url custom-alias  # Set deployment alias
vercel rollback deployment-url                # Rollback deployment
vercel promote deployment-url                 # Promote preview to production
```

## Workflow Integration

### Development Workflow

1. **Local Development**: Use `vercel dev` for local testing with serverless functions
2. **Feature Development**: Automatic preview deployments for every Git push
3. **Testing**: Integration testing with preview URLs and environment variables
4. **Production**: Deploy to production with `vercel --prod` or Git integration
5. **Monitoring**: Use analytics, logs, and performance monitoring

### CI/CD Integration with GitHub Actions

```yaml
# .github/workflows/vercel.yml
name: Vercel Production Deployment
env:
  VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
  VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  Deploy-Preview:
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request'
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci

      - name: Run tests
        run: npm test

      - name: Install Vercel CLI
        run: npm install --global vercel@canary

      - name: Pull Vercel Environment Information
        run: vercel pull --yes --environment=preview --token=${{ secrets.VERCEL_TOKEN }}

      - name: Build Project Artifacts
        run: vercel build --token=${{ secrets.VERCEL_TOKEN }}

      - name: Deploy Project Artifacts to Vercel
        run: vercel deploy --prebuilt --token=${{ secrets.VERCEL_TOKEN }}

  Deploy-Production:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci

      - name: Run tests
        run: npm test

      - name: Install Vercel CLI
        run: npm install --global vercel@canary

      - name: Pull Vercel Environment Information
        run: vercel pull --yes --environment=production --token=${{ secrets.VERCEL_TOKEN }}

      - name: Build Project Artifacts
        run: vercel build --prod --token=${{ secrets.VERCEL_TOKEN }}

      - name: Deploy Project Artifacts to Vercel
        run: vercel deploy --prebuilt --prod --token=${{ secrets.VERCEL_TOKEN }}
```

### Package.json Scripts Integration

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "vercel:dev": "vercel dev",
    "vercel:build": "vercel build",
    "vercel:deploy": "vercel --prod",
    "vercel:logs": "vercel logs",
    "type-check": "tsc --noEmit",
    "analyze": "ANALYZE=true npm run build"
  },
  "devDependencies": {
    "vercel": "^32.0.0",
    "@types/node": "^20.0.0",
    "typescript": "^5.0.0"
  }
}
```

## Best Practices

### ✅ **Deployment Best Practices**

- **Use Git integration** - Connect repositories for automatic deployments
- **Configure build settings** - Optimize build commands and output directories
- **Set up custom domains** - Use custom domains with automatic SSL
- **Implement proper caching** - Use ISR and edge caching for optimal performance
- **Monitor Core Web Vitals** - Track performance metrics and optimize accordingly
- **Use preview deployments** - Test changes with unique preview URLs

### ✅ **Performance Optimization**

- **Enable automatic optimizations** - Use built-in image and font optimization
- **Implement ISR** - Use Incremental Static Regeneration for dynamic content
- **Optimize bundle size** - Analyze and reduce JavaScript bundle sizes
- **Use edge functions** - Move logic to the edge for faster response times
- **Configure caching headers** - Set appropriate cache policies for static assets
- **Implement code splitting** - Use dynamic imports and lazy loading

### ✅ **Security Best Practices**

- **Use environment variables** - Store secrets in Vercel environment variables
- **Implement security headers** - Configure security headers in vercel.json
- **Validate API inputs** - Always validate and sanitize API route inputs
- **Use HTTPS everywhere** - Vercel provides automatic HTTPS for all deployments
- **Implement rate limiting** - Use middleware or third-party services for rate limiting
- **Monitor function logs** - Regularly check logs for errors and security issues

### ❌ **Common Pitfalls to Avoid**

- **Don't commit secrets** - Use environment variables for sensitive data
- **Avoid large bundle sizes** - Monitor and optimize JavaScript bundle sizes
- **Don't ignore Core Web Vitals** - Performance directly impacts user experience
- **Avoid blocking builds** - Keep build times fast with efficient processes
- **Don't hardcode URLs** - Use environment-specific URLs and configuration
- **Avoid complex server logic** - Keep serverless functions focused and efficient

## Advanced Vercel Usage

### Edge Config for Dynamic Content

```typescript
// lib/edge-config.ts
import { get } from '@vercel/edge-config';

export async function getFeatureFlag(key: string): Promise<boolean> {
  try {
    const value = await get(key);
    return value === true;
  } catch (error) {
    console.error('Edge Config error:', error);
    return false;
  }
}

export async function getConfigValue<T>(key: string, defaultValue: T): Promise<T> {
  try {
    const value = await get(key);
    return value !== undefined ? value : defaultValue;
  } catch (error) {
    console.error('Edge Config error:', error);
    return defaultValue;
  }
}

// middleware.ts - Using Edge Config
import { NextRequest, NextResponse } from 'next/server';
import { getFeatureFlag } from './lib/edge-config';

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Feature flag check
  if (pathname === '/new-feature') {
    const isEnabled = await getFeatureFlag('new_feature_enabled');

    if (!isEnabled) {
      return NextResponse.redirect(new URL('/coming-soon', request.url));
    }
  }

  return NextResponse.next();
}
```

### Vercel KV for Caching

```typescript
// lib/kv.ts
import { kv } from '@vercel/kv';

export async function getCachedData<T>(
  key: string,
  fetcher: () => Promise<T>,
  ttl: number = 3600,
): Promise<T> {
  try {
    // Try to get from cache first
    const cached = await kv.get<T>(key);
    if (cached) {
      return cached;
    }

    // Fetch fresh data
    const data = await fetcher();

    // Cache the result
    await kv.setex(key, ttl, JSON.stringify(data));

    return data;
  } catch (error) {
    console.error('KV cache error:', error);
    // Fallback to fetching without cache
    return await fetcher();
  }
}

// pages/api/products/popular.ts
import { getCachedData } from '../../../lib/kv';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  try {
    const popularProducts = await getCachedData(
      'popular-products',
      async () => {
        const response = await fetch('https://api.store.com/products/popular');
        return response.json();
      },
      1800, // Cache for 30 minutes
    );

    res.status(200).json(popularProducts);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch popular products' });
  }
}
```

### Advanced Analytics Integration

```typescript
// lib/analytics.ts
import { Analytics } from '@vercel/analytics/react';
import { track } from '@vercel/analytics';

export function trackEvent(name: string, properties?: Record<string, any>) {
  track(name, properties);
}

export function trackPageView(page: string) {
  track('page_view', { page });
}

export function trackPurchase(value: number, currency: string = 'USD') {
  track('purchase', { value, currency });
}

// pages/_app.tsx
import { Analytics } from '@vercel/analytics/react';
import { SpeedInsights } from '@vercel/speed-insights/next';

export default function App({ Component, pageProps }: AppProps) {
  return (
    <>
      <Component {...pageProps} />
      <Analytics />
      <SpeedInsights />
    </>
  );
}

// components/ProductCard.tsx
import { trackEvent } from '../lib/analytics';

export default function ProductCard({ product }: { product: Product }) {
  const handleAddToCart = () => {
    trackEvent('add_to_cart', {
      product_id: product.id,
      product_name: product.name,
      price: product.price,
    });

    // Add to cart logic
  };

  return (
    <div className="product-card">
      <h3>{product.name}</h3>
      <p>${product.price}</p>
      <button onClick={handleAddToCart}>Add to Cart</button>
    </div>
  );
}
```

## Integration with Other Tools

### Database Integration (Prisma + PlanetScale)

```typescript
// lib/prisma.ts
import { PrismaClient } from '@prisma/client';

declare global {
  var prisma: PrismaClient | undefined;
}

export const prisma = globalThis.prisma || new PrismaClient();

if (process.env.NODE_ENV !== 'production') {
  globalThis.prisma = prisma;
}

// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider     = "mysql"
  url          = env("DATABASE_URL")
  relationMode = "prisma"
}

model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String?
  posts     Post[]
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
}

model Post {
  id        String   @id @default(cuid())
  title     String
  content   String?  @db.Text
  published Boolean  @default(false)
  author    User     @relation(fields: [authorId], references: [id])
  authorId  String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@index([authorId])
}
```

### Authentication Integration (NextAuth.js)

```typescript
// pages/api/auth/[...nextauth].ts
import NextAuth from 'next-auth';
import GoogleProvider from 'next-auth/providers/google';
import { PrismaAdapter } from '@next-auth/prisma-adapter';
import { prisma } from '../../../lib/prisma';

export default NextAuth({
  adapter: PrismaAdapter(prisma),
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    }),
  ],
  session: {
    strategy: 'jwt',
  },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id;
      }
      return token;
    },
    async session({ session, token }) {
      if (token) {
        session.user.id = token.id as string;
      }
      return session;
    },
  },
  pages: {
    signIn: '/auth/signin',
    error: '/auth/error',
  },
});

// middleware.ts - Auth protection
import { withAuth } from 'next-auth/middleware';

export default withAuth(
  function middleware(req) {
    // Additional middleware logic
  },
  {
    callbacks: {
      authorized: ({ token, req }) => {
        // Check if user is authorized for the route
        if (req.nextUrl.pathname.startsWith('/admin')) {
          return token?.role === 'admin';
        }
        return !!token;
      },
    },
  },
);

export const config = {
  matcher: ['/dashboard/:path*', '/admin/:path*'],
};
```

### Payment Integration (Stripe)

```typescript
// lib/stripe.ts
import Stripe from 'stripe';

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: '2023-10-16',
});

// pages/api/checkout/session.ts
import { stripe } from '../../../lib/stripe';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { items, customer_email } = req.body;

    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: items.map((item: any) => ({
        price_data: {
          currency: 'usd',
          product_data: {
            name: item.name,
          },
          unit_amount: item.price * 100,
        },
        quantity: item.quantity,
      })),
      mode: 'payment',
      success_url: `${req.headers.origin}/success?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${req.headers.origin}/cancel`,
      customer_email,
    });

    res.status(200).json({ sessionId: session.id });
  } catch (error) {
    console.error('Stripe error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}
```

## Troubleshooting

### Common Issues

#### Build Failures

**Problem**: Build process fails during deployment
**Symptoms**: Build errors in Vercel deployment logs
**Solution**:

```bash
# Debug build locally
vercel build
vercel dev

# Check build settings in vercel.json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "installCommand": "npm ci"
}

# Check Node.js version
{
  "build": {
    "env": {
      "NODE_VERSION": "18.x"
    }
  }
}

# Clear build cache
vercel --force  # Force rebuild without cache
```

#### Function Timeout Errors

**Problem**: Serverless functions timing out
**Symptoms**: Function exceeds execution time limit
**Solution**:

```json
// vercel.json - Increase function timeout
{
  "functions": {
    "pages/api/**/*.js": {
      "maxDuration": 30
    }
  }
}
```

```typescript
// Optimize function performance
export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  // Set timeout early
  res.setHeader('Cache-Control', 's-maxage=60');

  try {
    // Use Promise.race for timeout control
    const result = await Promise.race([
      expensiveOperation(),
      new Promise((_, reject) => setTimeout(() => reject(new Error('Timeout')), 25000)),
    ]);

    res.status(200).json(result);
  } catch (error) {
    res.status(500).json({ error: 'Operation failed' });
  }
}
```

#### Memory Limit Exceeded

**Problem**: Functions exceeding memory limits
**Symptoms**: Out of memory errors in function logs
**Solution**:

```json
// vercel.json - Increase memory limit
{
  "functions": {
    "pages/api/heavy-task.js": {
      "memory": 1024
    }
  }
}
```

### Debug Mode

```bash
# Verbose deployment
vercel --debug

# Local development with debug
DEBUG=* vercel dev

# Function debugging
vercel logs --follow

# Build debugging
vercel build --debug
```

### Performance Optimization

```json
// next.config.js - Performance optimization
/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    esmExternals: true,
    serverComponentsExternalPackages: ['@prisma/client'],
  },
  compiler: {
    removeConsole: process.env.NODE_ENV === 'production',
  },
  swcMinify: true,
  images: {
    formats: ['image/webp', 'image/avif'],
  },
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.resolve.fallback = {
        ...config.resolve.fallback,
        fs: false,
      };
    }
    return config;
  },
};

module.exports = nextConfig;
```

## Security Considerations

### Security Best Practices

- **Implement security headers** - Configure security headers in vercel.json and middleware
- **Use environment variables** - Store sensitive data in Vercel environment variables
- **Validate API inputs** - Always validate and sanitize inputs in API routes
- **Implement authentication** - Use NextAuth.js or similar for user authentication
- **Use HTTPS only** - Vercel provides automatic HTTPS for all deployments
- **Monitor function logs** - Regularly review logs for security issues

### Secure API Implementation

```typescript
// lib/auth.ts
import jwt from 'jsonwebtoken';

export function verifyToken(token: string) {
  try {
    return jwt.verify(token, process.env.JWT_SECRET!);
  } catch (error) {
    throw new Error('Invalid token');
  }
}

export function withAuth(handler: NextApiHandler): NextApiHandler {
  return async (req, res) => {
    try {
      const token = req.headers.authorization?.replace('Bearer ', '');

      if (!token) {
        return res.status(401).json({ error: 'No token provided' });
      }

      const user = verifyToken(token);
      (req as any).user = user;

      return handler(req, res);
    } catch (error) {
      return res.status(401).json({ error: 'Invalid token' });
    }
  };
}

// pages/api/protected/data.ts
import { withAuth } from '../../../lib/auth';

export default withAuth(async (req, res) => {
  // Protected route logic
  const user = (req as any).user;

  // Validate user permissions
  if (!user.permissions.includes('read:data')) {
    return res.status(403).json({ error: 'Insufficient permissions' });
  }

  res.status(200).json({ message: 'Protected data', user });
});
```

## AI Assistant Guidelines

When helping with Vercel:

1. **Always suggest Next.js integration** when appropriate for optimal performance
2. **Provide complete deployment configurations** with vercel.json and environment setup
3. **Include serverless function examples** with proper error handling and security
4. **Suggest ISR and edge functions** for optimal performance and user experience
5. **Provide debugging strategies** for common build and deployment issues
6. **Include monitoring and analytics** setup for production applications
7. **Reference security best practices** for API routes and authentication
8. **Suggest framework-specific optimizations** based on the technology stack

### Code Generation Rules

- Generate vercel.json files with appropriate configurations for the project type
- Include proper error handling and validation in serverless functions
- Provide middleware examples for authentication and edge computing
- Follow Next.js best practices for SSR, SSG, and ISR
- Include proper TypeScript types and interfaces
- Generate environment variable configurations for different environments
- Provide monitoring and analytics integration examples
- Include CI/CD pipeline configurations for automated deployments

### CLI Configuration

```bash
# Global configuration
[tool] config set [option] [value]

# Project-specific configuration
[tool] config --local [option] [value]
```

## Core Features

### [Feature 1]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 2]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 3]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

## Common Commands

```bash
# Essential daily commands
[tool] [basic-command]              # Description
[tool] [frequent-command] [options] # Description
[tool] [status-command]             # Check status
[tool] [help-command]               # Get help

# Advanced operations
[tool] [advanced-command] [options] # Description
[tool] [config-command]             # Configuration management
[tool] [debug-command]              # Debugging and troubleshooting
```

## Workflow Integration

### Development Workflow

1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions
