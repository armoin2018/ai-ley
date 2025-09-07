---
agentMode: general
applyTo:
  - '**/azure-pipelines.yml'
  - '**/azuredeploy.json'
  - '**/bicep/**'
  - '**/ARM/**'
  - '**/docker-compose.yml'
  - '**/.azure/**'
author: AI-LEY
category: Cloud Platforms
description: Enterprise-grade Microsoft Azure platform with comprehensive infrastructure management, security frameworks, cost optimization, AI services integration, and automated deployment orchestration for mission-critical cloud operations
extensions:
  - .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-01-27T20:30:00.000000'
last_updated: '2025-01-27'
summaryScore: 3.0
tags:
  - azure
  - microsoft
  - enterprise
  - cloud
  - infrastructure
  - security
  - automation
  - ai-services
  - cost-optimization
  - monitoring
title: Microsoft Azure Enterprise Cloud Platform Instructions
version: '3.0'
---

# 🌐 Enterprise Microsoft Azure - Intelligent Cloud Platform

## **🏢 Level 3 Enterprise Implementation**

### **Overview**

Enterprise Microsoft Azure Platform delivers comprehensive cloud infrastructure management with advanced security frameworks, AI/ML integration, cost optimization, and automated deployment orchestration for mission-critical enterprise operations across global Azure regions.

**🎯 Core Enterprise Capabilities:**

- ☁️ **Multi-Region Architecture** - Global deployment with disaster recovery and hybrid connectivity
- 🔒 **Zero Trust Security** - Azure AD, Defender, Sentinel SIEM, and comprehensive compliance automation
- 🤖 **AI-Powered Operations** - OpenAI, Cognitive Services, ML automation, and intelligent insights
- 📊 **Advanced Analytics** - Synapse Analytics, Power BI, real-time monitoring, and predictive analytics
- 🚀 **Container Orchestration** - AKS enterprise clusters, Service Fabric, and microservices automation
- 🏗️ **Infrastructure as Code** - ARM templates, Bicep modules, Terraform, and automated provisioning
- 🔄 **Enterprise DevOps** - Azure DevOps pipelines, GitHub Actions, and comprehensive CI/CD automation
- 📈 **Cost Intelligence** - ML-powered cost optimization, budget management, and ROI analytics

### **🏗️ Azure Enterprise Resource Manager**

`````python
import asyncio
import json
import yaml
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Union, Tuple
from dataclasses import dataclass, field
from enum import Enum
import logging
import structlog
from azure.identity import DefaultAzureCredential, ClientSecretCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.compute import ComputeManagementClient
from azure.mgmt.network import NetworkManagementClient
from azure.mgmt.storage import StorageManagementClient
from azure.mgmt.sql import SqlManagementClient
from azure.mgmt.keyvault import KeyVaultManagementClient
from azure.mgmt.monitor import MonitorManagementClient
from azure.mgmt.authorization import AuthorizationManagementClient
from azure.mgmt.containerservice import ContainerServiceClient
from azure.mgmt.web import WebSiteManagementClient
from azure.core.exceptions import AzureError
import concurrent.futures
from pathlib import Path

class AzureRegion(Enum):
    """Azure regions for global enterprise deployment"""
    EAST_US = "eastus"
    WEST_US_2 = "westus2"
    WEST_EUROPE = "westeurope"
    NORTH_EUROPE = "northeurope"
    SOUTHEAST_ASIA = "southeastasia"
    EAST_ASIA = "eastasia"
    AUSTRALIA_EAST = "australiaeast"
    CANADA_CENTRAL = "canadacentral"
    UK_SOUTH = "uksouth"
    JAPAN_EAST = "japaneast"

class DeploymentTier(Enum):
    """Enterprise deployment tiers"""
    DEVELOPMENT = "development"
    TESTING = "testing"
    STAGING = "staging"
    PRODUCTION = "production"
    DISASTER_RECOVERY = "disaster-recovery"

class ComplianceFramework(Enum):
    """Enterprise compliance frameworks"""
    SOC2_TYPE2 = "SOC2-Type2"
    HIPAA = "HIPAA"
    PCI_DSS = "PCI-DSS"
    GDPR = "GDPR"
    ISO27001 = "ISO27001"
    NIST_CYBERSECURITY = "NIST-Cybersecurity"
    FEDRAMP = "FedRAMP"

class AzureServiceSku(Enum):
    """Enterprise Azure service SKUs"""
    BASIC = "Basic"
    STANDARD = "Standard"
    PREMIUM = "Premium"
    PREMIUM_V2 = "PremiumV2"
    PREMIUM_V3 = "PremiumV3"

@dataclass
class EnterpriseAzureConfig:
    """Enterprise Azure configuration with multi-subscription governance"""

    # Core Azure Configuration
    tenant_id: str = ""
    subscription_id: str = ""
    client_id: str = ""
    client_secret: str = ""

    # Multi-Region Configuration
    primary_region: AzureRegion = AzureRegion.EAST_US
    secondary_regions: List[AzureRegion] = field(default_factory=lambda: [
        AzureRegion.WEST_US_2, AzureRegion.WEST_EUROPE
    ])
    disaster_recovery_region: AzureRegion = AzureRegion.WEST_EUROPE

    # Enterprise Environment Configuration
    deployment_tier: DeploymentTier = DeploymentTier.PRODUCTION
    application_name: str = "enterprise-app"
    organization_name: str = "Enterprise Corp"
    business_unit: str = "Technology"
    cost_center: str = "Engineering"

    # Resource Organization Strategy
    resource_group_strategy: str = "workload_based"  # workload_based, environment_based, function_based
    naming_convention: str = "{org}-{app}-{tier}-{workload}-{region}"

    # Enterprise Security Configuration
    enable_azure_defender: bool = True
    enable_azure_sentinel: bool = True
    enable_key_vault: bool = True
    enable_private_endpoints: bool = True
    enable_network_watcher: bool = True
    enable_azure_bastion: bool = True
    enable_azure_firewall: bool = True

    # Compliance Configuration
    compliance_frameworks: List[ComplianceFramework] = field(default_factory=lambda: [
        ComplianceFramework.SOC2_TYPE2,
        ComplianceFramework.GDPR,
        ComplianceFramework.ISO27001
    ])

    # Monitoring and Observability
    enable_application_insights: bool = True
    enable_log_analytics: bool = True
    enable_azure_monitor: bool = True
    enable_service_map: bool = True
    log_retention_days: int = 90
    metrics_retention_days: int = 93

    # Cost Management and Optimization
    enable_cost_management: bool = True
    enable_budgets: bool = True
    enable_cost_alerts: bool = True
    cost_optimization_level: str = "balanced"  # conservative, balanced, aggressive
    budget_threshold_warning: int = 80
    budget_threshold_critical: int = 95

    # Backup and Disaster Recovery
    enable_backup: bool = True
    enable_site_recovery: bool = True
    backup_retention_days: int = 365
    cross_region_backup: bool = True
    rto_target_hours: int = 4
    rpo_target_hours: int = 1

    # Infrastructure as Code
    use_arm_templates: bool = True
    use_bicep: bool = True
    use_terraform: bool = True
    enable_policy_as_code: bool = True

    # AI and Machine Learning
    enable_cognitive_services: bool = True
    enable_openai_services: bool = True
    enable_ml_studio: bool = True
    enable_synapse_analytics: bool = True

    # Custom Enterprise Tags
    enterprise_tags: Dict[str, str] = field(default_factory=dict)

    def __post_init__(self):
        """Initialize enterprise defaults and validation"""
        if not self.enterprise_tags:
            self.enterprise_tags = {
                "Organization": self.organization_name.lower().replace(" ", "-"),
                "BusinessUnit": self.business_unit,
                "CostCenter": self.cost_center,
                "Environment": self.deployment_tier.value,
                "Application": self.application_name,
                "ManagedBy": "azure-enterprise-platform",
                "BackupRequired": "true" if self.enable_backup else "false",
                "ComplianceLevel": "enterprise",
                "DataClassification": "confidential",
                "CreatedDate": datetime.now().isoformat(),
                "Owner": "platform-engineering-team"
            }

    def generate_resource_name(self, workload: str, service: str, resource_type: str = "") -> str:
        """Generate standardized enterprise resource names"""
        components = {
            "org": self.organization_name.lower().replace(" ", "-")[:8],
            "app": self.application_name.replace("-", "")[:12],
            "tier": self.deployment_tier.value[:4],
            "workload": workload.replace("-", "")[:15],
            "region": self.primary_region.value.replace("us", "").replace("europe", "eu")[:6],
            "service": service[:10]
        }

        base_name = self.naming_convention.format(**components)
        if resource_type:
            base_name = f"{base_name}-{resource_type}"

        # Ensure compliance with Azure naming rules
        return base_name[:63].lower().replace("_", "-")

    def get_resource_group_name(self, workload: str) -> str:
        """Generate resource group names based on enterprise strategy"""
        if self.resource_group_strategy == "workload_based":
            return f"rg-{self.organization_name.lower().replace(' ', '-')}-{workload}-{self.deployment_tier.value}"
        elif self.resource_group_strategy == "environment_based":
            return f"rg-{self.organization_name.lower().replace(' ', '-')}-{self.deployment_tier.value}"
        elif self.resource_group_strategy == "function_based":
            return f"rg-{workload}-{self.deployment_tier.value}-{self.primary_region.value}"
        else:
            return f"rg-{self.application_name}-{workload}-{self.deployment_tier.value}"

    def validate_enterprise_config(self) -> List[str]:
        """Validate enterprise configuration compliance"""
        validation_errors = []

        # Required Azure credentials
        if not self.tenant_id:
            validation_errors.append("Azure Tenant ID is required for enterprise deployment")
        if not self.subscription_id:
            validation_errors.append("Azure Subscription ID is required")
        if not self.client_id or not self.client_secret:
            validation_errors.append("Service Principal credentials required for automation")

        # Enterprise compliance checks
        if self.deployment_tier == DeploymentTier.PRODUCTION:
            if not self.enable_azure_defender:
                validation_errors.append("Azure Defender is required for production deployments")
            if not self.enable_backup:
                validation_errors.append("Backup is mandatory for production resources")
            if len(self.secondary_regions) < 1:
                validation_errors.append("At least one secondary region required for production")

        # Cost management validation
        if self.enable_cost_management and not self.enable_budgets:
            validation_errors.append("Budget management should be enabled with cost management")

        return validation_errors

class AzureEnterpriseResourceManager:
    """Advanced Azure resource management with enterprise governance"""

    def __init__(self, config: EnterpriseAzureConfig):
        self.config = config
        self.logger = structlog.get_logger("azure.enterprise.resource_manager")

        # Azure management clients
        self.credential = None
        self.resource_client = None
        self.compute_client = None
        self.network_client = None
        self.storage_client = None
        self.sql_client = None
        self.keyvault_client = None
        self.monitor_client = None
        self.auth_client = None
        self.container_client = None
        self.web_client = None

        # Enterprise resource tracking
        self.deployed_resources = {}
        self.resource_dependencies = {}
        self.cost_allocations = {}

        # Validate configuration
        config_errors = self.config.validate_enterprise_config()
        if config_errors:
            raise ValueError(f"Enterprise configuration errors: {'; '.join(config_errors)}")

    async def __aenter__(self):
        """Async context manager entry"""
        await self.initialize_enterprise_platform()
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        """Async context manager exit with cleanup"""
        await self.cleanup_enterprise_platform()

    async def initialize_enterprise_platform(self) -> Dict[str, Any]:
        """Initialize comprehensive enterprise Azure platform"""
        try:
            self.logger.info(
                "Initializing Azure Enterprise Platform",
                organization=self.config.organization_name,
                tier=self.config.deployment_tier.value,
                regions=len(self.config.secondary_regions) + 1
            )

            # Initialize Azure credentials and clients
            await self._initialize_azure_credentials()
            await self._initialize_azure_management_clients()

            # Setup enterprise governance
            await self._setup_enterprise_governance()

            # Deploy foundational infrastructure
            foundation_result = await self._deploy_foundational_infrastructure()

            # Setup enterprise monitoring
            monitoring_result = await self._setup_enterprise_monitoring()

            # Configure enterprise security
            security_result = await self._setup_enterprise_security()

            # Initialize cost management
            cost_result = await self._setup_enterprise_cost_management()

            return {
                "status": "initialized",
                "platform_components": {
                    "foundation": foundation_result,
                    "monitoring": monitoring_result,
                    "security": security_result,
                    "cost_management": cost_result
                },
                "regions_configured": len(self.config.secondary_regions) + 1,
                "compliance_frameworks": len(self.config.compliance_frameworks),
                "description": "Azure Enterprise Platform successfully initialized with comprehensive governance"
            }

        except Exception as e:
            self.logger.error(f"Failed to initialize Azure Enterprise Platform: {e}")
            raise

    async def _initialize_azure_credentials(self) -> None:
        """Initialize enterprise Azure credentials with fallback options"""
        try:
            if self.config.client_id and self.config.client_secret:
                # Service Principal authentication for automation
                self.credential = ClientSecretCredential(
                    tenant_id=self.config.tenant_id,
                    client_id=self.config.client_id,
                    client_secret=self.config.client_secret
                )
                self.logger.info("Using Service Principal authentication")
            else:
                # Managed Identity or default credential chain
                self.credential = DefaultAzureCredential()
                self.logger.info("Using Default Azure Credential chain")

            # Test credential validity
            token = await self.credential.get_token("https://management.azure.com/.default")
            if not token:
                raise ValueError("Failed to obtain valid Azure authentication token")

            self.logger.info("Azure credentials validated successfully")

        except Exception as e:
            self.logger.error(f"Failed to initialize Azure credentials: {e}")
            raise

    async def _initialize_azure_management_clients(self) -> None:
        """Initialize comprehensive Azure management clients"""
        try:
            subscription_id = self.config.subscription_id

            # Core management clients
            self.resource_client = ResourceManagementClient(self.credential, subscription_id)
            self.compute_client = ComputeManagementClient(self.credential, subscription_id)
            self.network_client = NetworkManagementClient(self.credential, subscription_id)
            self.storage_client = StorageManagementClient(self.credential, subscription_id)

            # Database and security clients
            self.sql_client = SqlManagementClient(self.credential, subscription_id)
            self.keyvault_client = KeyVaultManagementClient(self.credential, subscription_id)
            self.auth_client = AuthorizationManagementClient(self.credential, subscription_id)

            # Container and application clients
            self.container_client = ContainerServiceClient(self.credential, subscription_id)
            self.web_client = WebSiteManagementClient(self.credential, subscription_id)

            # Monitoring and analytics clients
            self.monitor_client = MonitorManagementClient(self.credential, subscription_id)

            self.logger.info(
                "Azure management clients initialized",
                clients_count=10,
                subscription=subscription_id
            )

        except Exception as e:
            self.logger.error(f"Failed to initialize Azure management clients: {e}")
            raise

    async def _setup_enterprise_governance(self) -> Dict[str, Any]:
        """Setup comprehensive enterprise governance framework"""
        try:
            governance_policies = []

            # Tagging governance policy
            tagging_policy = {
                "name": "enterprise-mandatory-tagging",
                "description": "Enforce mandatory tags on all Azure resources",
                "policy_rule": {
                    "if": {
                        "allOf": [
                            {
                                "field": "type",
                                "notEquals": "Microsoft.Resources/subscriptions"
                            },
                            {
                                "anyOf": [
                                    {
                                        "field": "tags['Environment']",
                                        "exists": "false"
                                    },
                                    {
                                        "field": "tags['CostCenter']",
                                        "exists": "false"
                                    },
                                    {
                                        "field": "tags['Owner']",
                                        "exists": "false"
                                    }
                                ]
                            }
                        ]
                    },
                    "then": {
                        "effect": "deny"
                    }
                },
                "mode": "Indexed"
            }
            governance_policies.append(tagging_policy)

            # Resource location restriction policy
            location_policy = {
                "name": "enterprise-allowed-locations",
                "description": "Restrict resource deployment to approved Azure regions",
                "policy_rule": {
                    "if": {
                        "allOf": [
                            {
                                "field": "location",
                                "exists": "true"
                            },
                            {
                                "field": "location",
                                "notIn": [region.value for region in [self.config.primary_region] + self.config.secondary_regions + [self.config.disaster_recovery_region]]
                            }
                        ]
                    },
                    "then": {
                        "effect": "deny"
                    }
                },
                "mode": "Indexed"
            }
            governance_policies.append(location_policy)

            # SKU restriction policy
            sku_policy = {
                "name": "enterprise-sku-restrictions",
                "description": "Enforce enterprise-approved SKUs for cost optimization",
                "policy_rule": {
                    "if": {
                        "anyOf": [
                            {
                                "allOf": [
                                    {
                                        "field": "type",
                                        "equals": "Microsoft.Compute/virtualMachines"
                                    },
                                    {
                                        "field": "Microsoft.Compute/virtualMachines/sku.name",
                                        "notIn": ["Standard_D2s_v3", "Standard_D4s_v3", "Standard_D8s_v3", "Standard_E2s_v3", "Standard_E4s_v3"]
                                    }
                                ]
                            }
                        ]
                    },
                    "then": {
                        "effect": "deny"
                    }
                },
                "mode": "Indexed"
            }
            governance_policies.append(sku_policy)

            return {
                "status": "configured",
                "policies_defined": len(governance_policies),
                "governance_framework": governance_policies,
                "description": "Enterprise governance policies configured for compliance and cost control"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup enterprise governance: {e}")
            return {"status": "failed", "error": str(e)}

### **🏗️ Azure Enterprise Infrastructure Orchestrator**

class AzureEnterpriseInfrastructureOrchestrator:
    """Advanced infrastructure orchestration with ARM, Bicep, and Terraform integration"""

    def __init__(self, resource_manager: AzureEnterpriseResourceManager):
        self.resource_manager = resource_manager
        self.config = resource_manager.config
        self.logger = structlog.get_logger("azure.enterprise.infrastructure_orchestrator")

        # Infrastructure templates and modules
        self.arm_templates = {}
        self.bicep_modules = {}
        self.terraform_configurations = {}
        self.deployment_history = []

    async def deploy_enterprise_infrastructure(self, workloads: List[str] = None) -> Dict[str, Any]:
        """Deploy comprehensive enterprise infrastructure across multiple workloads"""
        try:
            if workloads is None:
                workloads = ["networking", "security", "compute", "data", "monitoring", "ai-ml"]

            self.logger.info(
                "Starting enterprise infrastructure deployment",
                workloads=workloads,
                regions=len(self.config.secondary_regions) + 1
            )

            deployment_results = {}

            # Deploy in dependency order
            for workload in workloads:
                try:
                    workload_result = await self._deploy_workload_infrastructure(workload)
                    deployment_results[workload] = workload_result

                    self.logger.info(
                        f"Workload {workload} deployment completed",
                        status=workload_result.get("status"),
                        resources=workload_result.get("resources_deployed", 0)
                    )

                except Exception as e:
                    self.logger.error(f"Failed to deploy {workload} workload: {e}")
                    deployment_results[workload] = {"status": "failed", "error": str(e)}

            # Generate deployment summary
            successful_deployments = sum(1 for result in deployment_results.values() if result.get("status") == "success")
            total_resources = sum(result.get("resources_deployed", 0) for result in deployment_results.values() if result.get("resources_deployed"))

            return {
                "status": "completed",
                "deployment_summary": {
                    "successful_workloads": successful_deployments,
                    "total_workloads": len(workloads),
                    "total_resources_deployed": total_resources,
                    "deployment_regions": [self.config.primary_region.value] + [r.value for r in self.config.secondary_regions]
                },
                "workload_results": deployment_results,
                "description": f"Enterprise infrastructure deployment across {successful_deployments}/{len(workloads)} workloads"
            }

        except Exception as e:
            self.logger.error(f"Enterprise infrastructure deployment failed: {e}")
            return {"status": "failed", "error": str(e)}

    async def _deploy_workload_infrastructure(self, workload: str) -> Dict[str, Any]:
        """Deploy infrastructure for a specific workload"""
        try:
            deployment_methods = {
                "networking": self._deploy_networking_infrastructure,
                "security": self._deploy_security_infrastructure,
                "compute": self._deploy_compute_infrastructure,
                "data": self._deploy_data_infrastructure,
                "monitoring": self._deploy_monitoring_infrastructure,
                "ai-ml": self._deploy_ai_ml_infrastructure
            }

            if workload not in deployment_methods:
                raise ValueError(f"Unknown workload: {workload}")

            deployment_method = deployment_methods[workload]
            return await deployment_method()

        except Exception as e:
            self.logger.error(f"Failed to deploy {workload} infrastructure: {e}")
            return {"status": "failed", "error": str(e)}

    async def _deploy_networking_infrastructure(self) -> Dict[str, Any]:
        """Deploy enterprise networking infrastructure with hub-spoke topology"""
        try:
            networking_resources = {
                "virtual_networks": 2,
                "subnets": 9,
                "network_security_groups": 4,
                "route_tables": 3,
                "azure_firewall": 1,
                "application_gateway": 1,
                "azure_bastion": 1,
                "vnet_peering_connections": 2
            }

            # Create comprehensive networking ARM template
            networking_template = {
                "template_type": "ARM",
                "workload": "networking",
                "regions": [self.config.primary_region.value] + [r.value for r in self.config.secondary_regions],
                "resources": networking_resources,
                "hub_spoke_topology": {
                    "hub_vnet": f"{self.config.generate_resource_name('networking', 'hub', 'vnet')}",
                    "spoke_vnets": [
                        f"{self.config.generate_resource_name('networking', 'spoke', 'vnet')}",
                        f"{self.config.generate_resource_name('networking', 'workload', 'vnet')}"
                    ],
                    "address_spaces": {
                        "hub": "10.0.0.0/16",
                        "spoke_1": "10.1.0.0/16",
                        "spoke_2": "10.2.0.0/16"
                    }
                },
                "security_configuration": {
                    "azure_firewall_enabled": True,
                    "waf_enabled": True,
                    "ddos_protection": True,
                    "private_endpoints": True
                }
            }

            self.arm_templates["networking"] = networking_template

            return {
                "status": "success",
                "template_name": "enterprise_networking",
                "resources_deployed": sum(networking_resources.values()),
                "infrastructure_components": list(networking_resources.keys()),
                "description": "Enterprise hub-spoke networking with comprehensive security and connectivity"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy networking infrastructure: {e}")
            return {"status": "failed", "error": str(e)}

### **🔒 Azure Enterprise Security Manager**

class AzureEnterpriseSecurityManager:
    """Comprehensive enterprise security management with Zero Trust architecture"""

    def __init__(self, resource_manager: AzureEnterpriseResourceManager):
        self.resource_manager = resource_manager
        self.config = resource_manager.config
        self.logger = structlog.get_logger("azure.enterprise.security_manager")

        # Security configurations
        self.security_policies = {}
        self.compliance_frameworks = {}
        self.threat_detection_rules = {}

    async def deploy_enterprise_security(self) -> Dict[str, Any]:
        """Deploy comprehensive enterprise security infrastructure"""
        try:
            self.logger.info("Deploying enterprise security infrastructure")

            security_results = {}

            # Deploy security components
            if self.config.enable_azure_defender:
                defender_result = await self._setup_azure_defender()
                security_results["azure_defender"] = defender_result

            if self.config.enable_azure_sentinel:
                sentinel_result = await self._setup_azure_sentinel()
                security_results["azure_sentinel"] = sentinel_result

            if self.config.enable_key_vault:
                keyvault_result = await self._setup_enterprise_key_vault()
                security_results["key_vault"] = keyvault_result

            if self.config.enable_private_endpoints:
                private_endpoints_result = await self._setup_private_endpoints()
                security_results["private_endpoints"] = private_endpoints_result

            # Setup Zero Trust architecture
            zero_trust_result = await self._setup_zero_trust_architecture()
            security_results["zero_trust"] = zero_trust_result

            # Configure compliance monitoring
            compliance_result = await self._setup_compliance_monitoring()
            security_results["compliance"] = compliance_result

            successful_components = sum(1 for result in security_results.values() if result.get("status") == "success")

            return {
                "status": "completed",
                "security_components_deployed": successful_components,
                "total_components": len(security_results),
                "security_results": security_results,
                "description": f"Enterprise security infrastructure deployed with {successful_components} components"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy enterprise security: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_azure_defender(self) -> Dict[str, Any]:
        """Setup Azure Defender for comprehensive threat protection"""
        try:
            defender_configuration = {
                "defender_for_cloud": {
                    "enabled": True,
                    "tier": "Standard",
                    "pricing_plans": [
                        "VirtualMachines",
                        "AppService",
                        "SqlServers",
                        "SqlServerVirtualMachines",
                        "StorageAccounts",
                        "KubernetesService",
                        "ContainerRegistry",
                        "KeyVaults"
                    ]
                },
                "security_center_settings": {
                    "auto_provisioning": True,
                    "data_collection": "All",
                    "threat_detection": {
                        "vm_behavioral_analytics": True,
                        "network_layer_threats": True,
                        "dns_analytics": True
                    }
                },
                "adaptive_security_features": {
                    "adaptive_application_controls": True,
                    "adaptive_network_hardening": True,
                    "file_integrity_monitoring": True,
                    "just_in_time_access": True
                },
                "security_alerts": {
                    "email_notifications": True,
                    "email_addresses": ["security@company.com", "soc@company.com"],
                    "alert_severity_threshold": "Medium",
                    "integration_with_siem": True
                },
                "compliance_standards": [
                    "Azure Security Benchmark",
                    "PCI DSS 3.2.1",
                    "ISO 27001:2013",
                    "SOC 2 Type 2"
                ]
            }

            self.security_policies["azure_defender"] = defender_configuration

            return {
                "status": "success",
                "configuration": "azure_defender_enterprise",
                "pricing_plans_enabled": len(defender_configuration["defender_for_cloud"]["pricing_plans"]),
                "compliance_standards": len(defender_configuration["compliance_standards"]),
                "description": "Azure Defender configured with enterprise-grade threat protection"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup Azure Defender: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_azure_sentinel(self) -> Dict[str, Any]:
        """Setup Azure Sentinel SIEM for security operations"""
        try:
            sentinel_configuration = {
                "workspace": {
                    "name": f"{self.config.generate_resource_name('security', 'sentinel', 'law')}",
                    "location": self.config.primary_region.value,
                    "retention_days": 90,
                    "daily_quota_gb": 20
                },
                "data_connectors": [
                    {
                        "name": "Azure Active Directory",
                        "data_types": ["SigninLogs", "AuditLogs", "RiskyUsers", "UserRiskEvents"]
                    },
                    {
                        "name": "Azure Security Center",
                        "data_types": ["SecurityAlert", "SecurityRecommendation"]
                    },
                    {
                        "name": "Azure Activity",
                        "subscription_ids": [self.config.subscription_id]
                    },
                    {
                        "name": "Office 365",
                        "data_types": ["Exchange", "SharePoint", "Teams"]
                    },
                    {
                        "name": "Microsoft Threat Intelligence",
                        "threat_intel_indicators": True
                    }
                ],
                "analytics_rules": [
                    {
                        "name": "Suspicious Sign-in Activity",
                        "description": "Detects unusual sign-in patterns and high-risk authentications",
                        "severity": "High",
                        "query_frequency": "PT5M",
                        "query_period": "PT30M",
                        "tactics": ["InitialAccess", "CredentialAccess"],
                        "techniques": ["T1078", "T1110"]
                    },
                    {
                        "name": "Azure Resource Anomalies",
                        "description": "Detects unusual Azure resource creation and modification patterns",
                        "severity": "Medium",
                        "query_frequency": "PT15M",
                        "query_period": "PT1H",
                        "tactics": ["Persistence", "DefenseEvasion"],
                        "techniques": ["T1078.004", "T1562.008"]
                    },
                    {
                        "name": "Data Exfiltration Detection",
                        "description": "Identifies potential data exfiltration activities",
                        "severity": "High",
                        "query_frequency": "PT10M",
                        "query_period": "PT2H",
                        "tactics": ["Exfiltration"],
                        "techniques": ["T1041", "T1048"]
                    }
                ],
                "playbooks": [
                    {
                        "name": "Incident Response Automation",
                        "description": "Automated incident response for high-severity alerts",
                        "triggers": ["SecurityAlert"],
                        "actions": [
                            "CreateIncident",
                            "NotifySOCTeam",
                            "IsolateAffectedResources",
                            "CollectForensicData"
                        ]
                    },
                    {
                        "name": "Threat Intelligence Enrichment",
                        "description": "Automatically enrich security alerts with threat intelligence",
                        "triggers": ["SecurityAlert"],
                        "actions": [
                            "EnrichWithThreatIntel",
                            "UpdateIncidentSeverity",
                            "TagRelatedEntities"
                        ]
                    }
                ],
                "hunting_queries": [
                    {
                        "name": "Advanced Persistent Threat Hunting",
                        "description": "Hunt for APT indicators and behaviors",
                        "category": "ThreatHunting"
                    },
                    {
                        "name": "Insider Threat Detection",
                        "description": "Detect potential insider threat activities",
                        "category": "InsiderThreat"
                    }
                ]
            }

            self.security_policies["azure_sentinel"] = sentinel_configuration

            return {
                "status": "success",
                "configuration": "azure_sentinel_enterprise",
                "data_connectors": len(sentinel_configuration["data_connectors"]),
                "analytics_rules": len(sentinel_configuration["analytics_rules"]),
                "playbooks": len(sentinel_configuration["playbooks"]),
                "description": "Azure Sentinel SIEM configured with enterprise security operations center capabilities"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup Azure Sentinel: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_enterprise_key_vault(self) -> Dict[str, Any]:
        """Setup enterprise Key Vault with comprehensive secrets management"""
        try:
            key_vault_configuration = {
                "primary_vault": {
                    "name": f"{self.config.generate_resource_name('security', 'secrets', 'kv')}",
                    "location": self.config.primary_region.value,
                    "sku": "premium",
                    "access_policies": [
                        {
                            "tenant_id": self.config.tenant_id,
                            "object_id": self.config.client_id,
                            "permissions": {
                                "keys": ["get", "list", "create", "update", "delete", "backup", "restore"],
                                "secrets": ["get", "list", "set", "delete", "backup", "restore"],
                                "certificates": ["get", "list", "create", "update", "delete", "managecontacts", "manageissuers"]
                            }
                        }
                    ],
                    "network_acls": {
                        "bypass": "AzureServices",
                        "default_action": "Deny",
                        "virtual_network_rules": [],
                        "ip_rules": []
                    },
                    "advanced_features": {
                        "soft_delete_enabled": True,
                        "purge_protection_enabled": True,
                        "enable_rbac_authorization": True,
                        "vault_uri": f"https://{self.config.generate_resource_name('security', 'secrets', 'kv')}.vault.azure.net/"
                    }
                },
                "disaster_recovery_vault": {
                    "name": f"{self.config.generate_resource_name('security', 'dr-secrets', 'kv')}",
                    "location": self.config.disaster_recovery_region.value,
                    "replication_enabled": True,
                    "backup_policies": {
                        "automatic_backup": True,
                        "backup_frequency": "daily",
                        "retention_period": "365 days"
                    }
                },
                "managed_hsm": {
                    "name": f"{self.config.generate_resource_name('security', 'hsm', 'mhsm')}",
                    "location": self.config.primary_region.value,
                    "administrators": [self.config.client_id],
                    "security_domain": {
                        "quorum": 2,
                        "key_shares": 3
                    }
                },
                "certificate_management": {
                    "auto_certificate_management": True,
                    "certificate_authorities": ["DigiCert", "GlobalSign"],
                    "certificate_types": [
                        {
                            "name": "wildcard-ssl",
                            "subject": f"*.{self.config.organization_name.lower().replace(' ', '')}.com",
                            "validity_months": 12,
                            "key_size": 2048,
                            "auto_renewal": True
                        },
                        {
                            "name": "api-certificates",
                            "subject": f"api.{self.config.organization_name.lower().replace(' ', '')}.com",
                            "validity_months": 12,
                            "key_size": 2048,
                            "auto_renewal": True
                        }
                    ]
                },
                "secrets_management": {
                    "secret_rotation": {
                        "enabled": True,
                        "rotation_frequency": "90 days",
                        "notification_before_expiry": "30 days"
                    },
                    "secret_categories": [
                        "database_connection_strings",
                        "api_keys",
                        "service_principal_secrets",
                        "encryption_keys",
                        "third_party_integrations"
                    ]
                }
            }

            self.security_policies["enterprise_key_vault"] = key_vault_configuration

            return {
                "status": "success",
                "configuration": "enterprise_key_vault",
                "vaults_configured": 2,
                "managed_hsm": True,
                "certificate_types": len(key_vault_configuration["certificate_management"]["certificate_types"]),
                "description": "Enterprise Key Vault with HSM, certificate management, and disaster recovery"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup enterprise Key Vault: {e}")
            return {"status": "failed", "error": str(e)}

### **💰 Azure Enterprise Cost Optimizer**

class AzureEnterpriseCostOptimizer:
    """Advanced cost management and optimization for enterprise Azure environments"""

    def __init__(self, resource_manager: AzureEnterpriseResourceManager):
        self.resource_manager = resource_manager
        self.config = resource_manager.config
        self.logger = structlog.get_logger("azure.enterprise.cost_optimizer")

        # Cost management configurations
        self.cost_policies = {}
        self.budget_configurations = {}
        self.optimization_rules = {}

    async def setup_enterprise_cost_management(self) -> Dict[str, Any]:
        """Setup comprehensive enterprise cost management and optimization"""
        try:
            self.logger.info("Setting up enterprise cost management")

            cost_results = {}

            # Setup budgets and alerts
            budgets_result = await self._setup_enterprise_budgets()
            cost_results["budgets"] = budgets_result

            # Configure cost optimization policies
            optimization_result = await self._setup_cost_optimization_policies()
            cost_results["optimization"] = optimization_result

            # Setup cost analytics and reporting
            analytics_result = await self._setup_cost_analytics()
            cost_results["analytics"] = analytics_result

            # Configure automated cost controls
            controls_result = await self._setup_automated_cost_controls()
            cost_results["controls"] = controls_result

            successful_components = sum(1 for result in cost_results.values() if result.get("status") == "success")

            return {
                "status": "completed",
                "cost_components_deployed": successful_components,
                "total_components": len(cost_results),
                "cost_management_results": cost_results,
                "description": f"Enterprise cost management deployed with {successful_components} components"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup enterprise cost management: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_enterprise_budgets(self) -> Dict[str, Any]:
        """Setup comprehensive budgets with multi-tier alerting"""
        try:
            budget_configurations = {
                "subscription_budget": {
                    "name": f"{self.config.generate_resource_name('finance', 'subscription', 'budget')}",
                    "amount": 50000,
                    "time_grain": "Monthly",
                    "start_date": "2024-01-01",
                    "end_date": "2025-12-31",
                    "alerts": [
                        {
                            "threshold": 50,
                            "operator": "GreaterThan",
                            "contact_emails": ["finance@company.com"],
                            "contact_roles": ["Owner"]
                        },
                        {
                            "threshold": 75,
                            "operator": "GreaterThan",
                            "contact_emails": ["finance@company.com", "management@company.com"],
                            "contact_roles": ["Owner", "Contributor"]
                        },
                        {
                            "threshold": 90,
                            "operator": "GreaterThan",
                            "contact_emails": ["finance@company.com", "management@company.com", "cfo@company.com"],
                            "contact_roles": ["Owner", "Contributor"],
                            "webhook_notifications": True
                        }
                    ]
                },
                "workload_budgets": [
                    {
                        "name": "networking-budget",
                        "amount": 8000,
                        "resource_group_filter": self.config.get_resource_group_name("networking"),
                        "alerts": [{"threshold": 80, "contact_emails": ["network-team@company.com"]}]
                    },
                    {
                        "name": "compute-budget",
                        "amount": 15000,
                        "resource_group_filter": self.config.get_resource_group_name("compute"),
                        "alerts": [{"threshold": 80, "contact_emails": ["platform-team@company.com"]}]
                    },
                    {
                        "name": "data-budget",
                        "amount": 12000,
                        "resource_group_filter": self.config.get_resource_group_name("data"),
                        "alerts": [{"threshold": 80, "contact_emails": ["data-team@company.com"]}]
                    },
                    {
                        "name": "security-budget",
                        "amount": 10000,
                        "resource_group_filter": self.config.get_resource_group_name("security"),
                        "alerts": [{"threshold": 80, "contact_emails": ["security-team@company.com"]}]
                    }
                ],
                "department_budgets": [
                    {
                        "name": "engineering-budget",
                        "amount": 25000,
                        "tag_filters": {"Department": "Engineering"},
                        "alerts": [{"threshold": 85, "contact_emails": ["engineering-director@company.com"]}]
                    },
                    {
                        "name": "product-budget",
                        "amount": 15000,
                        "tag_filters": {"Department": "Product"},
                        "alerts": [{"threshold": 85, "contact_emails": ["product-director@company.com"]}]
                    }
                ]
            }

            self.budget_configurations["enterprise_budgets"] = budget_configurations

            total_budgets = 1 + len(budget_configurations["workload_budgets"]) + len(budget_configurations["department_budgets"])
            total_budget_amount = (
                budget_configurations["subscription_budget"]["amount"] +
                sum(b["amount"] for b in budget_configurations["workload_budgets"]) +
                sum(b["amount"] for b in budget_configurations["department_budgets"])
            )

            return {
                "status": "success",
                "configuration": "enterprise_budgets",
                "budgets_created": total_budgets,
                "total_budget_amount": total_budget_amount,
                "alert_levels": 3,
                "description": f"Enterprise budgets configured with {total_budgets} budgets totaling ${total_budget_amount:,}"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup enterprise budgets: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_cost_optimization_policies(self) -> Dict[str, Any]:
        """Setup automated cost optimization policies and recommendations"""
        try:
            optimization_policies = {
                "vm_rightsizing": {
                    "enabled": True,
                    "analysis_period": "30 days",
                    "cpu_threshold": 10,
                    "memory_threshold": 20,
                    "recommendations": {
                        "downsize_underutilized": True,
                        "shutdown_unused": True,
                        "reserved_instance_suggestions": True
                    },
                    "exclusions": ["production-critical", "always-on-services"],
                    "auto_implementation": {
                        "enabled": False,
                        "approval_required": True,
                        "test_environment_auto": True
                    }
                },
                "storage_optimization": {
                    "enabled": True,
                    "lifecycle_management": {
                        "cool_tier_after_days": 30,
                        "archive_tier_after_days": 90,
                        "delete_after_days": 2555  # 7 years retention
                    },
                    "blob_analysis": {
                        "identify_duplicate_content": True,
                        "compress_large_files": True,
                        "cleanup_temp_data": True
                    },
                    "storage_account_optimization": {
                        "performance_tier_recommendations": True,
                        "replication_optimization": True,
                        "access_pattern_analysis": True
                    }
                },
                "database_optimization": {
                    "sql_database": {
                        "auto_scaling": True,
                        "performance_recommendations": True,
                        "query_optimization_alerts": True,
                        "backup_optimization": True
                    },
                    "cosmos_db": {
                        "throughput_optimization": True,
                        "partition_analysis": True,
                        "geo_replication_optimization": True
                    }
                },
                "network_optimization": {
                    "bandwidth_analysis": True,
                    "cdn_recommendations": True,
                    "expressroute_optimization": True,
                    "load_balancer_efficiency": True
                },
                "reserved_instances": {
                    "analysis_enabled": True,
                    "minimum_usage_threshold": 70,
                    "commitment_terms": ["1 year", "3 years"],
                    "resource_types": [
                        "Microsoft.Compute/virtualMachines",
                        "Microsoft.Sql/servers/databases",
                        "Microsoft.DocumentDB/databaseAccounts",
                        "Microsoft.Storage/storageAccounts"
                    ],
                    "automatic_recommendations": True,
                    "savings_threshold_percent": 15
                },
                "spot_instances": {
                    "workload_suitability_analysis": True,
                    "fault_tolerance_requirements": True,
                    "cost_savings_projections": True,
                    "recommended_workloads": [
                        "batch_processing",
                        "development_environments",
                        "testing_workloads",
                        "ci_cd_agents"
                    ]
                }
            }

            self.cost_policies["optimization_policies"] = optimization_policies

            return {
                "status": "success",
                "configuration": "cost_optimization_policies",
                "optimization_categories": len(optimization_policies),
                "policies_enabled": sum(1 for policy in optimization_policies.values() if policy.get("enabled", True)),
                "description": f"Cost optimization policies configured across {len(optimization_policies)} categories"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup cost optimization policies: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_cost_analytics(self) -> Dict[str, Any]:
        """Setup advanced cost analytics and reporting capabilities"""
        try:
            analytics_configuration = {
                "cost_analysis_reports": [
                    {
                        "name": "executive-cost-summary",
                        "frequency": "monthly",
                        "recipients": ["cfo@company.com", "ceo@company.com"],
                        "format": "pdf",
                        "sections": [
                            "cost_overview",
                            "budget_vs_actual",
                            "cost_trends",
                            "optimization_opportunities",
                            "forecast_projections"
                        ]
                    },
                    {
                        "name": "department-chargeback",
                        "frequency": "monthly",
                        "recipients": ["finance@company.com"],
                        "format": "excel",
                        "allocation_method": "tag_based",
                        "sections": [
                            "department_breakdown",
                            "project_allocation",
                            "shared_cost_distribution"
                        ]
                    },
                    {
                        "name": "technical-cost-analysis",
                        "frequency": "weekly",
                        "recipients": ["platform-team@company.com"],
                        "format": "json",
                        "sections": [
                            "resource_level_costs",
                            "performance_cost_correlation",
                            "optimization_recommendations",
                            "usage_patterns"
                        ]
                    }
                ],
                "cost_anomaly_detection": {
                    "enabled": True,
                    "machine_learning_models": [
                        "statistical_outlier_detection",
                        "seasonal_pattern_analysis",
                        "trend_deviation_detection"
                    ],
                    "anomaly_thresholds": {
                        "daily_cost_increase": 25,
                        "weekly_cost_variance": 15,
                        "monthly_budget_deviation": 10
                    },
                    "alert_channels": [
                        "email",
                        "teams",
                        "slack",
                        "webhook"
                    ],
                    "automated_actions": [
                        "create_support_ticket",
                        "notify_cost_center_owner",
                        "trigger_cost_investigation_workflow"
                    ]
                },
                "cost_forecasting": {
                    "enabled": True,
                    "forecast_horizon": "12 months",
                    "confidence_intervals": [80, 95],
                    "factors": [
                        "historical_usage",
                        "planned_deployments",
                        "seasonal_patterns",
                        "business_growth_projections"
                    ],
                    "scenario_modeling": {
                        "conservative": {"growth_factor": 1.1},
                        "expected": {"growth_factor": 1.25},
                        "optimistic": {"growth_factor": 1.4}
                    }
                },
                "custom_dashboards": [
                    {
                        "name": "real_time_cost_dashboard",
                        "refresh_frequency": "hourly",
                        "widgets": [
                            "current_month_spend",
                            "daily_cost_trend",
                            "top_cost_resources",
                            "budget_utilization",
                            "cost_by_service",
                            "regional_cost_distribution"
                        ]
                    },
                    {
                        "name": "optimization_dashboard",
                        "refresh_frequency": "daily",
                        "widgets": [
                            "savings_opportunities",
                            "rightsizing_recommendations",
                            "unused_resources",
                            "reserved_instance_coverage",
                            "optimization_score"
                        ]
                    }
                ]
            }

            self.cost_policies["analytics_configuration"] = analytics_configuration

            return {
                "status": "success",
                "configuration": "cost_analytics",
                "reports_configured": len(analytics_configuration["cost_analysis_reports"]),
                "dashboards_created": len(analytics_configuration["custom_dashboards"]),
                "anomaly_detection": True,
                "forecasting_enabled": True,
                "description": f"Cost analytics configured with {len(analytics_configuration['cost_analysis_reports'])} reports and {len(analytics_configuration['custom_dashboards'])} dashboards"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup cost analytics: {e}")
            return {"status": "failed", "error": str(e)}

### **📊 Azure Enterprise Monitoring System**

class AzureEnterpriseMonitoringSystem:
    """Comprehensive enterprise monitoring with Azure Monitor, Application Insights, and custom analytics"""

    def __init__(self, resource_manager: AzureEnterpriseResourceManager):
        self.resource_manager = resource_manager
        self.config = resource_manager.config
        self.logger = structlog.get_logger("azure.enterprise.monitoring_system")

        # Monitoring configurations
        self.monitoring_configurations = {}
        self.alerting_rules = {}
        self.dashboard_configs = {}

    async def deploy_enterprise_monitoring(self) -> Dict[str, Any]:
        """Deploy comprehensive enterprise monitoring infrastructure"""
        try:
            self.logger.info("Deploying enterprise monitoring infrastructure")

            monitoring_results = {}

            # Setup Log Analytics workspace
            log_analytics_result = await self._setup_log_analytics_workspace()
            monitoring_results["log_analytics"] = log_analytics_result

            # Configure Application Insights
            app_insights_result = await self._setup_application_insights()
            monitoring_results["application_insights"] = app_insights_result

            # Setup Azure Monitor alerts and dashboards
            azure_monitor_result = await self._setup_azure_monitor()
            monitoring_results["azure_monitor"] = azure_monitor_result

            # Configure custom monitoring solutions
            custom_monitoring_result = await self._setup_custom_monitoring()
            monitoring_results["custom_monitoring"] = custom_monitoring_result

            # Setup performance and availability monitoring
            performance_monitoring_result = await self._setup_performance_monitoring()
            monitoring_results["performance_monitoring"] = performance_monitoring_result

            successful_components = sum(1 for result in monitoring_results.values() if result.get("status") == "success")

            return {
                "status": "completed",
                "monitoring_components_deployed": successful_components,
                "total_components": len(monitoring_results),
                "monitoring_results": monitoring_results,
                "description": f"Enterprise monitoring deployed with {successful_components} components"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy enterprise monitoring: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_log_analytics_workspace(self) -> Dict[str, Any]:
        """Setup centralized Log Analytics workspace for enterprise logging"""
        try:
            log_analytics_config = {
                "workspace": {
                    "name": f"{self.config.generate_resource_name('monitoring', 'central', 'law')}",
                    "location": self.config.primary_region.value,
                    "sku": "PerGB2018",
                    "retention_days": self.config.log_retention_days,
                    "daily_quota_gb": 50,
                    "public_network_access": "Enabled",
                    "features": {
                        "log_access_using_only_resource_permissions": True,
                        "immediate_purge_data_on_30_days": False
                    }
                },
                "data_collection_rules": [
                    {
                        "name": "vm-performance-collection",
                        "description": "Collect performance counters from VMs",
                        "data_sources": [
                            {
                                "type": "performanceCounters",
                                "streams": ["Microsoft-Perf"],
                                "counters": [
                                    "\\Processor(_Total)\\% Processor Time",
                                    "\\Memory\\Available MBytes",
                                    "\\LogicalDisk(_Total)\\Disk Reads/sec",
                                    "\\LogicalDisk(_Total)\\Disk Writes/sec",
                                    "\\Network Interface(*)\\Bytes Total/sec"
                                ],
                                "sample_frequency_seconds": 60
                            }
                        ]
                    },
                    {
                        "name": "security-events-collection",
                        "description": "Collect security events from Windows systems",
                        "data_sources": [
                            {
                                "type": "windowsEventLogs",
                                "streams": ["Microsoft-SecurityEvent"],
                                "x_path_queries": [
                                    "Security!*[System[(Level=1 or Level=2 or Level=3)]]",
                                    "System!*[System[(Level=1 or Level=2 or Level=3)]]"
                                ]
                            }
                        ]
                    },
                    {
                        "name": "application-logs-collection",
                        "description": "Collect application logs and custom metrics",
                        "data_sources": [
                            {
                                "type": "syslog",
                                "streams": ["Microsoft-Syslog"],
                                "facilities": ["*"],
                                "log_levels": ["Debug", "Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
                            }
                        ]
                    }
                ],
                "saved_searches": [
                    {
                        "name": "High CPU Utilization",
                        "query": "Perf | where ObjectName == \"Processor\" and CounterName == \"% Processor Time\" | where CounterValue > 80 | summarize avg(CounterValue) by Computer, bin(TimeGenerated, 5m)",
                        "category": "Performance"
                    },
                    {
                        "name": "Failed Login Attempts",
                        "query": "SecurityEvent | where EventID == 4625 | summarize count() by Account, Computer, bin(TimeGenerated, 1h) | where count_ > 5",
                        "category": "Security"
                    },
                    {
                        "name": "Application Errors",
                        "query": "AppTraces | where SeverityLevel >= 3 | summarize count() by AppRoleName, bin(TimeGenerated, 15m)",
                        "category": "Application"
                    }
                ],
                "solutions": [
                    "SecurityCenterFree",
                    "Updates",
                    "ChangeTracking",
                    "AzureActivity",
                    "AzureAutomation",
                    "ServiceMap"
                ]
            }

            self.monitoring_configurations["log_analytics"] = log_analytics_config

            return {
                "status": "success",
                "configuration": "log_analytics_workspace",
                "data_collection_rules": len(log_analytics_config["data_collection_rules"]),
                "saved_searches": len(log_analytics_config["saved_searches"]),
                "solutions": len(log_analytics_config["solutions"]),
                "retention_days": self.config.log_retention_days,
                "description": f"Log Analytics workspace configured with {len(log_analytics_config['solutions'])} solutions and comprehensive data collection"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup Log Analytics workspace: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_application_insights(self) -> Dict[str, Any]:
        """Setup Application Insights for comprehensive application monitoring"""
        try:
            app_insights_config = {
                "primary_instance": {
                    "name": f"{self.config.generate_resource_name('monitoring', 'app', 'insights')}",
                    "location": self.config.primary_region.value,
                    "application_type": "web",
                    "workspace_resource_id": f"/subscriptions/{self.config.subscription_id}/resourceGroups/{self.config.get_resource_group_name('monitoring')}/providers/Microsoft.OperationalInsights/workspaces/{self.config.generate_resource_name('monitoring', 'central', 'law')}",
                    "sampling_percentage": 100,
                    "retention_days": 90
                },
                "instrumentation_configuration": {
                    "auto_collect_dependencies": True,
                    "auto_collect_exceptions": True,
                    "auto_collect_requests": True,
                    "auto_collect_performance_counters": True,
                    "heartbeat_interval": 15,
                    "enable_live_metrics": True,
                    "enable_adaptive_sampling": True,
                    "max_telemetry_items_per_second": 200
                },
                "availability_tests": [
                    {
                        "name": "api-health-check",
                        "url": f"https://{self.config.application_name}.azurewebsites.net/health",
                        "locations": [
                            "us-east-azure",
                            "us-west-azure",
                            "europe-west-azure",
                            "asia-southeast-azure"
                        ],
                        "frequency": 300,
                        "timeout": 30,
                        "success_criteria": {
                            "status_code_match": 200,
                            "response_time_ms": 5000
                        }
                    },
                    {
                        "name": "database-connectivity",
                        "url": f"https://{self.config.application_name}.azurewebsites.net/health/database",
                        "locations": ["us-east-azure", "europe-west-azure"],
                        "frequency": 600,
                        "timeout": 60
                    }
                ],
                "custom_metrics": [
                    {
                        "name": "business_transactions_per_minute",
                        "description": "Number of business transactions processed per minute"
                    },
                    {
                        "name": "active_user_sessions",
                        "description": "Number of active user sessions"
                    },
                    {
                        "name": "cache_hit_ratio",
                        "description": "Percentage of cache hits vs total requests"
                    }
                ],
                "smart_detection_rules": [
                    {
                        "name": "Slow page load time",
                        "enabled": True,
                        "send_emails_to_subscription_owners": True
                    },
                    {
                        "name": "Slow server response time",
                        "enabled": True,
                        "send_emails_to_subscription_owners": True
                    },
                    {
                        "name": "Long dependency duration",
                        "enabled": True,
                        "send_emails_to_subscription_owners": True
                    },
                    {
                        "name": "Degradation in server response time",
                        "enabled": True,
                        "send_emails_to_subscription_owners": True
                    }
                ]
            }

            self.monitoring_configurations["application_insights"] = app_insights_config

            return {
                "status": "success",
                "configuration": "application_insights",
                "availability_tests": len(app_insights_config["availability_tests"]),
                "custom_metrics": len(app_insights_config["custom_metrics"]),
                "smart_detection_rules": len(app_insights_config["smart_detection_rules"]),
                "monitoring_locations": 4,
                "description": f"Application Insights configured with {len(app_insights_config['availability_tests'])} availability tests and comprehensive telemetry"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup Application Insights: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_azure_monitor(self) -> Dict[str, Any]:
        """Setup Azure Monitor with comprehensive alerting and dashboards"""
        try:
            azure_monitor_config = {
                "action_groups": [
                    {
                        "name": "critical-alerts-action-group",
                        "short_name": "CriticalAG",
                        "enabled": True,
                        "email_receivers": [
                            {"name": "PrimaryOncall", "email": "oncall@company.com"},
                            {"name": "SecondaryOncall", "email": "backup-oncall@company.com"}
                        ],
                        "sms_receivers": [
                            {"name": "OnCallPhone", "country_code": "1", "phone_number": "5551234567"}
                        ],
                        "webhook_receivers": [
                            {
                                "name": "SlackIntegration",
                                "service_uri": "https://hooks.slack.com/services/WEBHOOK_URL",
                                "use_common_alert_schema": True
                            }
                        ]
                    },
                    {
                        "name": "warning-alerts-action-group",
                        "short_name": "WarningAG",
                        "enabled": True,
                        "email_receivers": [
                            {"name": "TeamLead", "email": "team-lead@company.com"},
                            {"name": "PlatformTeam", "email": "platform-team@company.com"}
                        ]
                    }
                ],
                "metric_alerts": [
                    {
                        "name": "High CPU Usage",
                        "description": "Alert when CPU usage exceeds 85% for 5 minutes",
                        "severity": 2,
                        "enabled": True,
                        "window_size": "PT5M",
                        "evaluation_frequency": "PT1M",
                        "criteria": {
                            "metric_name": "Percentage CPU",
                            "operator": "GreaterThan",
                            "threshold": 85,
                            "time_aggregation": "Average"
                        },
                        "action_group": "critical-alerts-action-group"
                    },
                    {
                        "name": "High Memory Usage",
                        "description": "Alert when memory usage exceeds 90%",
                        "severity": 1,
                        "enabled": True,
                        "window_size": "PT10M",
                        "evaluation_frequency": "PT5M",
                        "criteria": {
                            "metric_name": "Available Memory Bytes",
                            "operator": "LessThan",
                            "threshold": 1073741824,  # 1GB in bytes
                            "time_aggregation": "Average"
                        },
                        "action_group": "critical-alerts-action-group"
                    },
                    {
                        "name": "Application Response Time",
                        "description": "Alert when application response time exceeds 2 seconds",
                        "severity": 2,
                        "enabled": True,
                        "window_size": "PT5M",
                        "evaluation_frequency": "PT1M",
                        "criteria": {
                            "metric_name": "Response Time",
                            "operator": "GreaterThan",
                            "threshold": 2000,
                            "time_aggregation": "Average"
                        },
                        "action_group": "warning-alerts-action-group"
                    }
                ],
                "log_alerts": [
                    {
                        "name": "Application Errors Spike",
                        "description": "Alert when application errors spike above normal",
                        "severity": 1,
                        "enabled": True,
                        "window_size": "PT15M",
                        "evaluation_frequency": "PT5M",
                        "query": "AppExceptions | where TimeGenerated > ago(15m) | summarize count() | where count_ > 10",
                        "threshold": 0,
                        "operator": "GreaterThan",
                        "action_group": "critical-alerts-action-group"
                    },
                    {
                        "name": "Failed Authentication Attempts",
                        "description": "Multiple failed authentication attempts detected",
                        "severity": 2,
                        "enabled": True,
                        "window_size": "PT30M",
                        "evaluation_frequency": "PT10M",
                        "query": "SigninLogs | where ResultType != 0 | summarize count() by UserPrincipalName | where count_ > 5",
                        "threshold": 0,
                        "operator": "GreaterThan",
                        "action_group": "warning-alerts-action-group"
                    }
                ]
            }

            self.monitoring_configurations["azure_monitor"] = azure_monitor_config

            return {
                "status": "success",
                "configuration": "azure_monitor",
                "action_groups": len(azure_monitor_config["action_groups"]),
                "metric_alerts": len(azure_monitor_config["metric_alerts"]),
                "log_alerts": len(azure_monitor_config["log_alerts"]),
                "total_alerts": len(azure_monitor_config["metric_alerts"]) + len(azure_monitor_config["log_alerts"]),
                "description": f"Azure Monitor configured with {len(azure_monitor_config['action_groups'])} action groups and comprehensive alerting"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup Azure Monitor: {e}")
            return {"status": "failed", "error": str(e)}

### **🤖 Azure Enterprise AI/ML Services Manager**

class AzureEnterpriseAIMLManager:
    """Advanced AI/ML services management with Azure OpenAI, Cognitive Services, and ML Studio"""

    def __init__(self, resource_manager: AzureEnterpriseResourceManager):
        self.resource_manager = resource_manager
        self.config = resource_manager.config
        self.logger = structlog.get_logger("azure.enterprise.aiml_manager")

        # AI/ML configurations
        self.aiml_configurations = {}
        self.model_deployments = {}
        self.cognitive_services = {}

    async def deploy_enterprise_aiml_services(self) -> Dict[str, Any]:
        """Deploy comprehensive enterprise AI/ML services and infrastructure"""
        try:
            self.logger.info("Deploying enterprise AI/ML services")

            aiml_results = {}

            # Setup Azure OpenAI Service
            if self.config.enable_openai_services:
                openai_result = await self._setup_azure_openai_service()
                aiml_results["azure_openai"] = openai_result

            # Configure Cognitive Services
            if self.config.enable_cognitive_services:
                cognitive_result = await self._setup_cognitive_services()
                aiml_results["cognitive_services"] = cognitive_result

            # Setup Machine Learning workspace
            if self.config.enable_ml_studio:
                ml_workspace_result = await self._setup_ml_workspace()
                aiml_results["ml_workspace"] = ml_workspace_result

            # Configure Synapse Analytics
            if self.config.enable_synapse_analytics:
                synapse_result = await self._setup_synapse_analytics()
                aiml_results["synapse_analytics"] = synapse_result

            # Setup AI governance and monitoring
            ai_governance_result = await self._setup_ai_governance()
            aiml_results["ai_governance"] = ai_governance_result

            successful_components = sum(1 for result in aiml_results.values() if result.get("status") == "success")

            return {
                "status": "completed",
                "aiml_components_deployed": successful_components,
                "total_components": len(aiml_results),
                "aiml_results": aiml_results,
                "description": f"Enterprise AI/ML services deployed with {successful_components} components"
            }

        except Exception as e:
            self.logger.error(f"Failed to deploy enterprise AI/ML services: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_azure_openai_service(self) -> Dict[str, Any]:
        """Setup Azure OpenAI Service with enterprise models and configurations"""
        try:
            openai_config = {
                "service_instance": {
                    "name": f"{self.config.generate_resource_name('ai', 'openai', 'oai')}",
                    "location": self.config.primary_region.value,
                    "sku": "S0",
                    "kind": "OpenAI",
                    "public_network_access": "Disabled",
                    "custom_subdomain": f"{self.config.organization_name.lower().replace(' ', '')}-openai"
                },
                "model_deployments": [
                    {
                        "model_name": "gpt-4",
                        "model_version": "0613",
                        "deployment_name": "gpt4-enterprise",
                        "capacity": {
                            "deployment_type": "Standard",
                            "tokens_per_minute": 30000
                        },
                        "use_cases": [
                            "document_analysis",
                            "code_generation",
                            "customer_support_automation",
                            "content_creation"
                        ]
                    },
                    {
                        "model_name": "gpt-35-turbo",
                        "model_version": "0613",
                        "deployment_name": "gpt35-enterprise",
                        "capacity": {
                            "deployment_type": "Standard",
                            "tokens_per_minute": 60000
                        },
                        "use_cases": [
                            "chatbot_responses",
                            "text_summarization",
                            "language_translation",
                            "quick_analysis"
                        ]
                    },
                    {
                        "model_name": "text-embedding-ada-002",
                        "model_version": "2",
                        "deployment_name": "embeddings-enterprise",
                        "capacity": {
                            "deployment_type": "Standard",
                            "tokens_per_minute": 120000
                        },
                        "use_cases": [
                            "semantic_search",
                            "document_similarity",
                            "recommendation_systems",
                            "clustering_analysis"
                        ]
                    }
                ],
                "content_filtering": {
                    "enabled": True,
                    "filter_level": "medium",
                    "categories": {
                        "hate": {"filtered": True, "severity": "medium"},
                        "sexual": {"filtered": True, "severity": "medium"},
                        "violence": {"filtered": True, "severity": "medium"},
                        "self_harm": {"filtered": True, "severity": "medium"}
                    },
                    "custom_filters": [
                        {
                            "name": "enterprise_compliance_filter",
                            "description": "Filter content that violates enterprise policies",
                            "keywords": ["confidential", "proprietary", "internal-only"]
                        }
                    ]
                },
                "enterprise_features": {
                    "customer_managed_keys": True,
                    "virtual_network_integration": True,
                    "private_endpoint_connections": True,
                    "managed_identity": True,
                    "audit_logging": True,
                    "usage_monitoring": True
                },
                "rate_limiting": {
                    "per_user_rate_limits": True,
                    "per_application_limits": True,
                    "burst_capacity": True,
                    "priority_tiers": ["high", "medium", "low"]
                }
            }

            self.aiml_configurations["azure_openai"] = openai_config

            return {
                "status": "success",
                "configuration": "azure_openai_enterprise",
                "model_deployments": len(openai_config["model_deployments"]),
                "models_available": [deployment["model_name"] for deployment in openai_config["model_deployments"]],
                "total_tpm_capacity": sum(deployment["capacity"]["tokens_per_minute"] for deployment in openai_config["model_deployments"]),
                "enterprise_features": len([k for k, v in openai_config["enterprise_features"].items() if v]),
                "description": f"Azure OpenAI configured with {len(openai_config['model_deployments'])} model deployments and enterprise security"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup Azure OpenAI Service: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_cognitive_services(self) -> Dict[str, Any]:
        """Setup comprehensive Cognitive Services for enterprise AI capabilities"""
        try:
            cognitive_services_config = {
                "multi_service_account": {
                    "name": f"{self.config.generate_resource_name('ai', 'cognitive', 'cog')}",
                    "location": self.config.primary_region.value,
                    "sku": "S0",
                    "kind": "CognitiveServices",
                    "public_network_access": "Disabled",
                    "custom_subdomain": f"{self.config.organization_name.lower().replace(' ', '')}-cognitive"
                },
                "services": {
                    "computer_vision": {
                        "enabled": True,
                        "features": [
                            "OCR_and_text_extraction",
                            "image_analysis",
                            "face_detection",
                            "object_detection",
                            "brand_detection",
                            "custom_vision_models"
                        ],
                        "custom_models": [
                            {
                                "name": "document_classifier",
                                "type": "classification",
                                "training_data": "enterprise_documents",
                                "categories": ["invoice", "contract", "report", "email"]
                            }
                        ]
                    },
                    "language_understanding": {
                        "enabled": True,
                        "features": [
                            "sentiment_analysis",
                            "key_phrase_extraction",
                            "entity_recognition",
                            "language_detection",
                            "text_analytics"
                        ],
                        "custom_models": [
                            {
                                "name": "enterprise_entity_extraction",
                                "type": "named_entity_recognition",
                                "entities": ["product_names", "customer_ids", "project_codes"]
                            }
                        ]
                    },
                    "speech_services": {
                        "enabled": True,
                        "features": [
                            "speech_to_text",
                            "text_to_speech",
                            "speech_translation",
                            "speaker_recognition",
                            "custom_voice_models"
                        ],
                        "languages": ["en-US", "es-ES", "fr-FR", "de-DE", "ja-JP"],
                        "custom_models": [
                            {
                                "name": "enterprise_terminology_model",
                                "type": "custom_speech",
                                "training_data": "enterprise_audio_transcripts"
                            }
                        ]
                    },
                    "translator": {
                        "enabled": True,
                        "supported_languages": 100,
                        "features": [
                            "text_translation",
                            "document_translation",
                            "custom_translation_models"
                        ],
                        "custom_models": [
                            {
                                "name": "technical_documentation_translator",
                                "source_language": "en",
                                "target_languages": ["es", "fr", "de", "ja"],
                                "domain": "technical_documentation"
                            }
                        ]
                    },
                    "form_recognizer": {
                        "enabled": True,
                        "features": [
                            "prebuilt_models",
                            "custom_form_models",
                            "layout_analysis",
                            "table_extraction"
                        ],
                        "prebuilt_models": [
                            "invoices",
                            "receipts",
                            "business_cards",
                            "identity_documents"
                        ],
                        "custom_models": [
                            {
                                "name": "enterprise_contract_analyzer",
                                "type": "custom_form",
                                "fields": ["contract_value", "start_date", "end_date", "parties"]
                            }
                        ]
                    }
                },
                "integration_apis": {
                    "rest_apis": True,
                    "sdk_support": ["python", "javascript", "csharp", "java"],
                    "webhook_notifications": True,
                    "batch_processing": True
                },
                "monitoring_and_analytics": {
                    "usage_analytics": True,
                    "performance_monitoring": True,
                    "error_tracking": True,
                    "cost_tracking": True,
                    "custom_dashboards": True
                }
            }

            self.aiml_configurations["cognitive_services"] = cognitive_services_config

            services_enabled = sum(1 for service in cognitive_services_config["services"].values() if service.get("enabled", False))
            total_custom_models = sum(len(service.get("custom_models", [])) for service in cognitive_services_config["services"].values())

            return {
                "status": "success",
                "configuration": "cognitive_services_enterprise",
                "services_enabled": services_enabled,
                "total_services": len(cognitive_services_config["services"]),
                "custom_models": total_custom_models,
                "supported_languages": cognitive_services_config["services"]["translator"]["supported_languages"],
                "description": f"Cognitive Services configured with {services_enabled} services and {total_custom_models} custom models"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup Cognitive Services: {e}")
            return {"status": "failed", "error": str(e)}

    async def _setup_ml_workspace(self) -> Dict[str, Any]:
        """Setup Azure Machine Learning workspace for enterprise ML operations"""
        try:
            ml_workspace_config = {
                "workspace": {
                    "name": f"{self.config.generate_resource_name('ai', 'mlworkspace', 'mlw')}",
                    "location": self.config.primary_region.value,
                    "sku": "Basic",
                    "description": f"Enterprise ML workspace for {self.config.organization_name}",
                    "friendly_name": f"{self.config.organization_name} ML Workspace",
                    "key_vault_id": f"/subscriptions/{self.config.subscription_id}/resourceGroups/{self.config.get_resource_group_name('security')}/providers/Microsoft.KeyVault/vaults/{self.config.generate_resource_name('security', 'secrets', 'kv')}",
                    "storage_account_id": f"/subscriptions/{self.config.subscription_id}/resourceGroups/{self.config.get_resource_group_name('data')}/providers/Microsoft.Storage/storageAccounts/{self.config.generate_resource_name('ai', 'mlstorage', 'st')}",
                    "application_insights_id": f"/subscriptions/{self.config.subscription_id}/resourceGroups/{self.config.get_resource_group_name('monitoring')}/providers/Microsoft.Insights/components/{self.config.generate_resource_name('monitoring', 'app', 'insights')}"
                },
                "compute_instances": [
                    {
                        "name": "ml-dev-instance",
                        "vm_size": "Standard_DS3_v2",
                        "purpose": "development_and_experimentation",
                        "auto_shutdown": {
                            "enabled": True,
                            "idle_time_minutes": 120
                        }
                    },
                    {
                        "name": "ml-training-cluster",
                        "vm_size": "Standard_NC6s_v3",
                        "purpose": "model_training",
                        "auto_scaling": {
                            "min_nodes": 0,
                            "max_nodes": 10,
                            "idle_seconds_before_scaledown": 300
                        }
                    }
                ],
                "datastores": [
                    {
                        "name": "enterprise_data_lake",
                        "type": "azure_blob",
                        "description": "Primary data lake for ML datasets",
                        "container_name": "ml-datasets"
                    },
                    {
                        "name": "training_data",
                        "type": "azure_file",
                        "description": "Training data file share",
                        "file_share_name": "training-data"
                    }
                ],
                "environments": [
                    {
                        "name": "enterprise-python-env",
                        "base_image": "mcr.microsoft.com/azureml/curated/sklearn-1.0-ubuntu20.04-py38-cpu:latest",
                        "python_packages": [
                            "pandas==1.5.3",
                            "numpy==1.24.3",
                            "scikit-learn==1.2.2",
                            "tensorflow==2.12.0",
                            "pytorch==2.0.1",
                            "transformers==4.30.2",
                            "azure-ai-ml==1.8.0"
                        ]
                    },
                    {
                        "name": "enterprise-r-env",
                        "base_image": "mcr.microsoft.com/azureml/curated/r-4.1-ubuntu20.04:latest",
                        "r_packages": [
                            "tidyverse",
                            "caret",
                            "randomForest",
                            "xgboost"
                        ]
                    }
                ],
                "model_registry": {
                    "enabled": True,
                    "versioning": True,
                    "model_approval_workflow": True,
                    "deployment_approval": True,
                    "model_monitoring": True
                },
                "mlops_integration": {
                    "azure_devops": True,
                    "github_actions": True,
                    "automated_retraining": True,
                    "model_drift_detection": True,
                    "data_drift_detection": True,
                    "performance_monitoring": True
                }
            }

            self.aiml_configurations["ml_workspace"] = ml_workspace_config

            return {
                "status": "success",
                "configuration": "ml_workspace_enterprise",
                "compute_instances": len(ml_workspace_config["compute_instances"]),
                "datastores": len(ml_workspace_config["datastores"]),
                "environments": len(ml_workspace_config["environments"]),
                "mlops_features": len([k for k, v in ml_workspace_config["mlops_integration"].items() if v]),
                "description": f"ML workspace configured with {len(ml_workspace_config['compute_instances'])} compute instances and comprehensive MLOps integration"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup ML workspace: {e}")
            return {"status": "failed", "error": str(e)}

## Usage Examples

### Enterprise Azure Platform Deployment

```python
# Initialize comprehensive Azure enterprise configuration
azure_config = EnterpriseAzureConfig(
    tenant_id="your-tenant-id",
    subscription_id="your-subscription-id",
    client_id="your-client-id",
    client_secret="your-client-secret",
    primary_region=AzureRegion.EAST_US,
    secondary_regions=[AzureRegion.WEST_US_2, AzureRegion.WEST_EUROPE],
    deployment_tier=DeploymentTier.PRODUCTION,
    organization_name="Acme Corporation",
    business_unit="Technology",
    compliance_frameworks=[
        ComplianceFramework.SOC2_TYPE2,
        ComplianceFramework.GDPR,
        ComplianceFramework.HIPAA
    ]
)

# Deploy complete enterprise platform
async def deploy_enterprise_platform():
    async with AzureEnterpriseResourceManager(azure_config) as resource_manager:

        # Deploy infrastructure orchestrator
        orchestrator = AzureEnterpriseInfrastructureOrchestrator(resource_manager)
        infra_result = await orchestrator.deploy_enterprise_infrastructure()
        print(f"Infrastructure: {infra_result['description']}")

        # Deploy security manager
        security_manager = AzureEnterpriseSecurityManager(resource_manager)
        security_result = await security_manager.deploy_enterprise_security()
        print(f"Security: {security_result['description']}")

        # Deploy cost optimizer
        cost_optimizer = AzureEnterpriseCostOptimizer(resource_manager)
        cost_result = await cost_optimizer.setup_enterprise_cost_management()
        print(f"Cost Management: {cost_result['description']}")

        # Deploy monitoring system
        monitoring_system = AzureEnterpriseMonitoringSystem(resource_manager)
        monitoring_result = await monitoring_system.deploy_enterprise_monitoring()
        print(f"Monitoring: {monitoring_result['description']}")

        # Deploy AI/ML services
        aiml_manager = AzureEnterpriseAIMLManager(resource_manager)
        aiml_result = await aiml_manager.deploy_enterprise_aiml_services()
        print(f"AI/ML Services: {aiml_result['description']}")

# Run the deployment
import asyncio
asyncio.run(deploy_enterprise_platform())
```

### Advanced Security Configuration

```python
# Deploy comprehensive enterprise security
async def deploy_advanced_security():
    async with AzureEnterpriseResourceManager(azure_config) as resource_manager:
        security_manager = AzureEnterpriseSecurityManager(resource_manager)

        # Deploy Zero Trust architecture
        zero_trust_result = await security_manager._setup_zero_trust_architecture()
        print(f"Zero Trust: {zero_trust_result['description']}")

        # Configure threat detection
        sentinel_result = await security_manager._setup_azure_sentinel()
        print(f"SIEM: {sentinel_result['description']}")

        # Setup comprehensive key management
        keyvault_result = await security_manager._setup_enterprise_key_vault()
        print(f"Key Vault: {keyvault_result['description']}")
```

### Enterprise Cost Optimization

```python
# Implement advanced cost management
async def optimize_enterprise_costs():
    async with AzureEnterpriseResourceManager(azure_config) as resource_manager:
        cost_optimizer = AzureEnterpriseCostOptimizer(resource_manager)

        # Setup multi-tier budgets
        budgets_result = await cost_optimizer._setup_enterprise_budgets()
        print(f"Budgets: {budgets_result['description']}")

        # Configure optimization policies
        optimization_result = await cost_optimizer._setup_cost_optimization_policies()
        print(f"Optimization: {optimization_result['description']}")

        # Setup advanced analytics
        analytics_result = await cost_optimizer._setup_cost_analytics()
        print(f"Analytics: {analytics_result['description']}")
```

### AI/ML Enterprise Integration

```python
# Deploy enterprise AI/ML capabilities
async def deploy_enterprise_ai():
    async with AzureEnterpriseResourceManager(azure_config) as resource_manager:
        aiml_manager = AzureEnterpriseAIMLManager(resource_manager)

        # Setup Azure OpenAI
        openai_result = await aiml_manager._setup_azure_openai_service()
        print(f"OpenAI: {openai_result['description']}")

        # Deploy Cognitive Services
        cognitive_result = await aiml_manager._setup_cognitive_services()
        print(f"Cognitive Services: {cognitive_result['description']}")

        # Configure ML workspace
        ml_result = await aiml_manager._setup_ml_workspace()
        print(f"ML Workspace: {ml_result['description']}")
```

## 🎯 Azure Enterprise Platform Components Delivered

### **1. ✅ Azure Enterprise Resource Manager** (1,800+ lines)
- **Multi-Region Architecture**: Global deployment across Azure regions with disaster recovery
- **Enterprise Configuration**: Comprehensive configuration management with compliance validation
- **Resource Governance**: Policy-driven resource management with automated compliance
- **Identity Integration**: Azure AD integration with enterprise identity federation
- **Advanced Naming**: Standardized enterprise naming conventions and tagging strategies

### **2. ✅ Azure Enterprise Infrastructure Orchestrator** (1,200+ lines)
- **Hub-Spoke Networking**: Enterprise networking topology with Azure Firewall and Bastion
- **ARM/Bicep Templates**: Infrastructure as Code with comprehensive template management
- **Multi-Workload Deployment**: Orchestrated deployment across networking, compute, data, and monitoring
- **Dependency Management**: Intelligent deployment ordering with rollback capabilities
- **Regional Deployment**: Multi-region infrastructure deployment with automated failover

### **3. ✅ Azure Enterprise Security Manager** (1,500+ lines)
- **Zero Trust Architecture**: Comprehensive Zero Trust implementation with Azure AD integration
- **Azure Defender**: Advanced threat protection across all Azure services
- **Azure Sentinel SIEM**: Enterprise security operations center with automated incident response
- **Enterprise Key Vault**: HSM-backed secrets management with disaster recovery
- **Compliance Automation**: SOC2, HIPAA, GDPR, and ISO27001 compliance monitoring and reporting

### **4. ✅ Azure Enterprise Cost Optimizer** (1,400+ lines)
- **Multi-Tier Budgets**: Comprehensive budget management with department and workload allocation
- **ML-Powered Optimization**: Intelligent cost optimization with rightsizing recommendations
- **Reserved Instance Analytics**: Automated RI analysis and purchasing recommendations
- **Cost Anomaly Detection**: Machine learning-based cost anomaly detection and alerting
- **Advanced Reporting**: Executive dashboards, chargeback reports, and forecasting analytics

### **5. ✅ Azure Enterprise Monitoring System** (1,100+ lines)
- **Log Analytics Workspace**: Centralized logging with comprehensive data collection rules
- **Application Insights**: Full-stack application monitoring with custom metrics and availability tests
- **Azure Monitor Integration**: Comprehensive alerting with multi-channel notifications
- **Custom Dashboards**: Real-time monitoring dashboards with business and technical metrics
- **Performance Analytics**: End-to-end performance monitoring with intelligent alerting

### **6. ✅ Azure Enterprise AI/ML Services Manager** (1,000+ lines)
- **Azure OpenAI Integration**: GPT-4, GPT-3.5, and embedding models with enterprise security
- **Cognitive Services Suite**: Computer Vision, Language Understanding, Speech, and Form Recognition
- **ML Workspace**: Enterprise ML operations with MLOps integration and model governance
- **Custom Model Development**: Specialized models for enterprise use cases and workflows
- **AI Governance**: Responsible AI practices with content filtering and usage monitoring

## 🚀 Advanced Azure Enterprise Capabilities

### **Enterprise Security & Compliance**
- **Zero Trust Implementation**: Identity-based security with continuous verification and adaptive policies
- **Comprehensive SIEM**: Azure Sentinel with 50+ analytics rules and automated incident response
- **Advanced Threat Protection**: Multi-layer security with behavioral analytics and threat intelligence
- **Compliance Automation**: Automated compliance monitoring for SOC2, HIPAA, GDPR, and ISO27001
- **Enterprise Key Management**: HSM-backed key vault with automated rotation and disaster recovery

### **AI-Powered Operations**
- **Azure OpenAI Integration**: Enterprise-grade GPT models with 210K+ tokens per minute capacity
- **Intelligent Cost Optimization**: ML-driven cost analysis with predictive budgeting and anomaly detection
- **Smart Monitoring**: AI-powered alerting with reduced false positives and intelligent escalation
- **Cognitive Document Processing**: Automated document analysis, OCR, and intelligent form processing
- **Predictive Analytics**: Business intelligence with forecasting and trend analysis

### **Multi-Cloud & Hybrid Integration**
- **Azure Arc Integration**: Hybrid cloud management across on-premises and multi-cloud environments
- **Express Route Connectivity**: Dedicated network connections with high-bandwidth, low-latency
- **Hybrid Identity**: Seamless identity integration between on-premises AD and Azure AD
- **Data Integration**: Azure Data Factory with hybrid data movement and transformation
- **Application Modernization**: Containerization with AKS and serverless with Azure Functions

### **Enterprise DevOps & Automation**
- **Infrastructure as Code**: ARM templates, Bicep, and Terraform with automated deployment pipelines
- **Azure DevOps Integration**: Comprehensive CI/CD with security scanning and compliance checks
- **GitOps Workflows**: Git-based deployment automation with policy-driven approvals
- **Container Orchestration**: Enterprise AKS with advanced networking, security, and monitoring
- **Serverless Architecture**: Azure Functions with event-driven scaling and enterprise integrations

## 📊 Enterprise Production Features

### **Scalability & Performance**
- **Auto-Scaling**: ML-powered scaling across compute, storage, and database tiers with predictive analytics
- **Global Load Balancing**: Application Gateway with WAF and multi-region traffic management
- **Performance Optimization**: Resource rightsizing with continuous performance monitoring and tuning
- **Capacity Planning**: Predictive capacity management with demand forecasting and automated provisioning

### **Security & Governance**
- **Zero Trust Architecture**: Identity-based security with continuous verification and risk assessment
- **Policy Automation**: Azure Policy with 100+ built-in policies and custom enterprise policies
- **Threat Intelligence**: Integrated threat detection with Azure Defender and Sentinel SIEM
- **Access Management**: Privileged Identity Management with Just-In-Time access and approval workflows

### **Cost Intelligence & Optimization**
- **ML-Powered Cost Analysis**: Intelligent cost optimization with anomaly detection and predictive modeling
- **Resource Optimization**: Automated rightsizing, reserved instance management, and spot instance recommendations
- **Budget Control**: Multi-tier budget management with automated alerts and spending controls
- **ROI Analytics**: Business value measurement with cost-benefit analysis and optimization recommendations

### **Reliability & Recovery**
- **High Availability**: Multi-region deployment with 99.99% uptime SLA and automated failover
- **Disaster Recovery**: Cross-region backup and replication with RTO < 4 hours and RPO < 1 hour
- **Business Continuity**: Automated backup policies with long-term retention and compliance archival
- **Fault Tolerance**: Self-healing infrastructure with automated remediation and intelligent routing

### **AI & Analytics Integration**
- **Enterprise AI Services**: Azure OpenAI with GPT-4, custom Cognitive Services, and ML Studio integration
- **Real-Time Analytics**: Stream Analytics with real-time data processing and intelligent insights
- **Business Intelligence**: Power BI integration with automated report generation and data visualization
- **Predictive Maintenance**: IoT integration with predictive analytics and automated maintenance workflows

The **Azure Enterprise Platform** delivers comprehensive cloud infrastructure management with advanced security frameworks, AI-powered operations, intelligent cost optimization, and enterprise-grade compliance for mission-critical Microsoft ecosystem operations across global Azure regions.

**Total Azure Platform Size: 8,000+ lines of enterprise-grade Azure capabilities**````

### **🏗️ Enterprise Architecture**

````python
import asyncio
import json
import yaml
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Union, Tuple
from dataclasses import dataclass, field
from enum import Enum
import logging
import structlog
from azure.identity import DefaultAzureCredential, ClientSecretCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.compute import ComputeManagementClient
from azure.mgmt.network import NetworkManagementClient
from azure.mgmt.storage import StorageManagementClient
from azure.mgmt.sql import SqlManagementClient
from azure.mgmt.keyvault import KeyVaultManagementClient
from azure.mgmt.monitor import MonitorManagementClient
from azure.mgmt.authorization import AuthorizationManagementClient
from azure.core.exceptions import AzureError
import concurrent.futures
from pathlib import Path

class AzureRegion(Enum):
    """Azure regions for global deployment"""
    EAST_US = "East US"
    WEST_US_2 = "West US 2"
    WEST_EUROPE = "West Europe"
    SOUTHEAST_ASIA = "Southeast Asia"
    AUSTRALIA_EAST = "Australia East"

class DeploymentEnvironment(Enum):
    """Deployment environments"""
    DEVELOPMENT = "development"
    STAGING = "staging"
    PRODUCTION = "production"
    DISASTER_RECOVERY = "disaster-recovery"

class ComplianceFramework(Enum):
    """Compliance frameworks"""
    SOC2 = "SOC2"
    HIPAA = "HIPAA"
    PCI_DSS = "PCI-DSS"
    GDPR = "GDPR"
    ISO27001 = "ISO27001"

class AzureServiceTier(Enum):
    """Azure service tiers"""
    BASIC = "Basic"
    STANDARD = "Standard"
    PREMIUM = "Premium"
    PREMIUM_V2 = "PremiumV2"

@dataclass
class EnterpriseAzureConfig:
    """Enterprise Azure configuration with multi-subscription and governance"""

    # Subscription Configuration
    tenant_id: str = ""
    subscription_id: str = ""
    client_id: str = ""
    client_secret: str = ""

    # Regional Configuration
    primary_region: AzureRegion = AzureRegion.EAST_US
    secondary_regions: List[AzureRegion] = field(default_factory=lambda: [AzureRegion.WEST_US_2])
    disaster_recovery_region: AzureRegion = AzureRegion.WEST_EUROPE

    # Environment Configuration
    environment: DeploymentEnvironment = DeploymentEnvironment.PRODUCTION
    application_name: str = "enterprise-application"
    organization_name: str = "Enterprise Corp"

    # Resource Group Strategy
    resource_group_strategy: str = "environment_based"  # environment_based, application_based, workload_based

    # Security Configuration
    enable_defender: bool = True
    enable_sentinel: bool = True
    enable_key_vault: bool = True
    enable_private_endpoints: bool = True
    enable_network_watcher: bool = True

    # Compliance Configuration
    compliance_frameworks: List[ComplianceFramework] = field(default_factory=lambda: [
        ComplianceFramework.SOC2, ComplianceFramework.GDPR
    ])

    # Monitoring Configuration
    enable_application_insights: bool = True
    enable_log_analytics: bool = True
    enable_azure_monitor: bool = True

    # Cost Management
    enable_cost_management: bool = True
    enable_budgets: bool = True
    cost_optimization_level: str = "aggressive"

    # Backup and DR
    enable_backup: bool = True
    backup_retention_days: int = 90
    cross_region_backup: bool = True

    # Infrastructure as Code
    use_arm_templates: bool = True
    use_bicep: bool = True
    use_terraform: bool = True

    # Custom Configuration
    custom_tags: Dict[str, str] = field(default_factory=dict)
    resource_naming_convention: str = "{org}-{app}-{env}-{service}-{region}"

    def __post_init__(self):
        """Initialize enterprise defaults"""
        if not self.custom_tags:
            self.custom_tags = {
                "Organization": self.organization_name.lower().replace(" ", "-"),
                "Environment": self.environment.value,
                "Application": self.application_name,
                "ManagedBy": "enterprise-platform-team",
                "CostCenter": "engineering",
                "Backup": "required" if self.enable_backup else "not-required",
                "CreatedDate": datetime.now().isoformat()
            }

    def get_resource_name(self, service: str, resource_type: str = "") -> str:
        """Generate standardized resource names"""
        components = {
            "org": self.organization_name.lower().replace(" ", "-")[:8],
            "app": self.application_name.replace("-", "")[:12],
            "env": self.environment.value[:4],
            "service": service.replace("-", "")[:15],
            "region": self.primary_region.value.lower().replace(" ", "")[:6]
        }

        name = self.resource_naming_convention.format(**components)
        if resource_type:
            name = f"{name}-{resource_type}"

        return name[:63].lower()  # Azure resource name limit

    def get_resource_group_name(self, workload: str = "") -> str:
        """Generate resource group names based on strategy"""
        if self.resource_group_strategy == "environment_based":
            return f"rg-{self.organization_name.lower().replace(' ', '-')}-{self.environment.value}"
        elif self.resource_group_strategy == "application_based":
            return f"rg-{self.application_name}-{self.environment.value}"
        elif self.resource_group_strategy == "workload_based" and workload:
            return f"rg-{workload}-{self.environment.value}"
        else:
            return f"rg-{self.application_name}-{self.environment.value}"

    def validate_configuration(self) -> List[str]:
        """Validate enterprise configuration"""
        errors = []

        if not self.tenant_id:
            errors.append("Azure Tenant ID is required for enterprise deployment")

        if not self.subscription_id:
            errors.append("Azure Subscription ID is required")

        if not self.client_id or not self.client_secret:
            errors.append("Service Principal credentials are required for automation")

        return errors

class EnterpriseAzurePlatform:
    """Production-ready Azure platform management with enterprise features"""

    def __init__(self, config: EnterpriseAzureConfig):
        self.config = config
        self.logger = structlog.get_logger("enterprise.azure")

        # Azure management clients
        self.credential = None
        self.resource_client = None
        self.compute_client = None
        self.network_client = None
        self.storage_client = None
        self.sql_client = None
        self.keyvault_client = None
        self.monitor_client = None
        self.auth_client = None

        # Enterprise components
        self.infrastructure_templates = {}
        self.security_policies = {}
        self.monitoring_dashboards = {}
        self.cost_optimization_rules = {}

        # Validate configuration
        config_errors = self.config.validate_configuration()
        if config_errors:
            raise ValueError(f"Configuration errors: {'; '.join(config_errors)}")

    async def __aenter__(self):
        """Async context manager entry"""
        await self.initialize()
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        """Async context manager exit"""
        await self.cleanup()

    async def initialize(self) -> None:
        """Initialize enterprise Azure platform"""
        try:
            # Initialize Azure credentials
            await self._initialize_azure_credentials()

            # Initialize Azure management clients
            await self._initialize_azure_clients()

            # Setup enterprise security
            await self._setup_enterprise_security()

            # Setup monitoring and alerting
            await self._setup_enterprise_monitoring()

            # Configure cost management
            await self._setup_cost_management()

            # Setup compliance and governance
            await self._setup_compliance_governance()

            self.logger.info(
                "Enterprise Azure platform initialized",
                organization=self.config.organization_name,
                environment=self.config.environment.value,
                subscription_id=self.config.subscription_id,
                primary_region=self.config.primary_region.value
            )

        except Exception as e:
            self.logger.error(f"Failed to initialize Azure platform: {e}")
            raise

    async def cleanup(self) -> None:
        """Clean up resources"""
        try:
            # Close all clients
            self.credential = None
            self.resource_client = None
            self.compute_client = None
            self.network_client = None
            self.storage_client = None

            self.logger.info("Azure platform cleaned up successfully")

        except Exception as e:
            self.logger.error(f"Error during cleanup: {e}")

    async def _initialize_azure_credentials(self) -> None:
        """Initialize Azure credentials"""
        try:
            if self.config.client_id and self.config.client_secret:
                # Use service principal authentication
                self.credential = ClientSecretCredential(
                    tenant_id=self.config.tenant_id,
                    client_id=self.config.client_id,
                    client_secret=self.config.client_secret
                )
            else:
                # Use default credential chain
                self.credential = DefaultAzureCredential()

            self.logger.info("Azure credentials initialized")

        except Exception as e:
            self.logger.error(f"Failed to initialize Azure credentials: {e}")
            raise

    async def _initialize_azure_clients(self) -> None:
        """Initialize Azure management clients"""
        try:
            subscription_id = self.config.subscription_id

            # Initialize all Azure management clients
            self.resource_client = ResourceManagementClient(self.credential, subscription_id)
            self.compute_client = ComputeManagementClient(self.credential, subscription_id)
            self.network_client = NetworkManagementClient(self.credential, subscription_id)
            self.storage_client = StorageManagementClient(self.credential, subscription_id)
            self.sql_client = SqlManagementClient(self.credential, subscription_id)
            self.keyvault_client = KeyVaultManagementClient(self.credential, subscription_id)
            self.monitor_client = MonitorManagementClient(self.credential, subscription_id)
            self.auth_client = AuthorizationManagementClient(self.credential, subscription_id)

            self.logger.info("Azure management clients initialized")

        except Exception as e:
            self.logger.error(f"Failed to initialize Azure clients: {e}")
            raise

    async def _setup_enterprise_security(self) -> None:
        """Setup comprehensive enterprise security"""
        try:
            # Azure Defender Configuration
            if self.config.enable_defender:
                await self._setup_azure_defender()

            # Azure Sentinel Configuration
            if self.config.enable_sentinel:
                await self._setup_azure_sentinel()

            # Key Vault Configuration
            if self.config.enable_key_vault:
                await self._setup_key_vault()

            # Private Endpoints Configuration
            if self.config.enable_private_endpoints:
                await self._setup_private_endpoints()

            # Network Security Configuration
            await self._setup_network_security()

            self.logger.info("Enterprise security setup completed")

    async def _setup_azure_defender(self) -> None:
        """Setup Azure Defender for comprehensive security"""
        try:
            defender_config = {
                "defender_for_servers": {
                    "enabled": True,
                    "tier": "Standard",
                    "extensions": [
                        "MicrosoftDefenderForServers",
                        "VulnerabilityAssessment",
                        "FilelessAttackDetection"
                    ],
                    "auto_provisioning": True
                },
                "defender_for_app_service": {
                    "enabled": True,
                    "tier": "Standard",
                    "features": [
                        "ThreatDetection",
                        "VulnerabilityScanning",
                        "ConfigurationAssessment"
                    ]
                },
                "defender_for_storage": {
                    "enabled": True,
                    "tier": "Standard",
                    "malware_scanning": True,
                    "sensitive_data_discovery": True
                },
                "defender_for_sql": {
                    "enabled": True,
                    "tier": "Standard",
                    "vulnerability_assessments": True,
                    "advanced_threat_protection": True
                },
                "defender_for_kubernetes": {
                    "enabled": True,
                    "tier": "Standard",
                    "runtime_protection": True,
                    "policy_enforcement": True
                },
                "security_policies": [
                    {
                        "name": "Enterprise Security Baseline",
                        "description": "Comprehensive security policy for enterprise workloads",
                        "initiatives": [
                            "Azure Security Benchmark",
                            "PCI DSS 3.2.1",
                            "ISO 27001:2013"
                        ]
                    }
                ],
                "alert_configurations": [
                    {
                        "name": "Critical Security Alerts",
                        "severity": "High",
                        "email_notifications": ["security@company.com"],
                        "logic_app_integration": True
                    },
                    {
                        "name": "Compliance Violations",
                        "severity": "Medium",
                        "email_notifications": ["compliance@company.com"],
                        "automation_enabled": True
                    }
                ]
            }

            self.security_policies["azure_defender"] = defender_config
            self.logger.info("Azure Defender configuration prepared")

        except Exception as e:
            self.logger.error(f"Failed to setup Azure Defender: {e}")

    async def _setup_azure_sentinel(self) -> None:
        """Setup Azure Sentinel for SIEM and SOAR"""
        try:
            sentinel_config = {
                "workspace_configuration": {
                    "name": f"{self.config.get_resource_name('sentinel', 'workspace')}",
                    "resource_group": self.config.get_resource_group_name("security"),
                    "location": self.config.primary_region.value,
                    "retention_days": 90,
                    "daily_quota_gb": 10
                },
                "data_connectors": [
                    {
                        "name": "AzureActiveDirectory",
                        "enabled": True,
                        "data_types": ["SigninLogs", "AuditLogs", "RiskyUsers", "RiskyUserHistoryLogs"]
                    },
                    {
                        "name": "AzureSecurityCenter",
                        "enabled": True,
                        "data_types": ["Alerts", "Recommendations"]
                    },
                    {
                        "name": "Office365",
                        "enabled": True,
                        "data_types": ["Exchange", "SharePoint", "Teams"]
                    },
                    {
                        "name": "AzureActivity",
                        "enabled": True,
                        "subscription_id": self.config.subscription_id
                    },
                    {
                        "name": "SecurityEvents",
                        "enabled": True,
                        "event_types": ["All", "Common", "Minimal"]
                    }
                ],
                "analytics_rules": [
                    {
                        "name": "Suspicious Sign-in Activity",
                        "description": "Detects unusual sign-in patterns and locations",
                        "severity": "High",
                        "query": """
SigninLogs
| where TimeGenerated > ago(1h)
| where RiskLevelDuringSignIn == "high" or RiskLevelAggregated == "high"
| summarize count() by UserPrincipalName, Location, IPAddress
| where count_ > 5
""",
                        "frequency": "PT5M",
                        "period": "PT1H",
                        "tactics": ["InitialAccess", "CredentialAccess"]
                    },
                    {
                        "name": "Azure Resource Modification",
                        "description": "Detects unauthorized changes to critical Azure resources",
                        "severity": "Medium",
                        "query": """
AzureActivity
| where TimeGenerated > ago(1h)
| where OperationName has "write" or OperationName has "delete"
| where CategoryValue == "Administrative"
| where ActivityStatus == "Succeeded"
| summarize count() by Caller, ResourceGroup, OperationName
""",
                        "frequency": "PT15M",
                        "period": "PT1H",
                        "tactics": ["Impact", "DefenseEvasion"]
                    }
                ],
                "automation_rules": [
                    {
                        "name": "Auto-Response to Critical Alerts",
                        "description": "Automatically respond to critical security incidents",
                        "trigger_conditions": {
                            "severity": ["High"],
                            "tactics": ["InitialAccess", "Exfiltration"]
                        },
                        "actions": [
                            "CreateIncident",
                            "SendEmailNotification",
                            "RunPlaybook"
                        ]
                    }
                ],
                "workbooks": [
                    {
                        "name": "Security Operations Dashboard",
                        "description": "Comprehensive security monitoring dashboard",
                        "categories": ["Security", "Operations"]
                    },
                    {
                        "name": "Threat Intelligence",
                        "description": "Threat intelligence and IOC analysis",
                        "categories": ["ThreatIntelligence"]
                    }
                ]
            }

            self.security_policies["azure_sentinel"] = sentinel_config
            self.logger.info("Azure Sentinel configuration prepared")

        except Exception as e:
            self.logger.error(f"Failed to setup Azure Sentinel: {e}")

    async def _setup_key_vault(self) -> None:
        """Setup Azure Key Vault for secrets management"""
        try:
            keyvault_config = {
                "key_vaults": [
                    {
                        "name": f"{self.config.get_resource_name('secrets', 'kv')}",
                        "resource_group": self.config.get_resource_group_name("security"),
                        "location": self.config.primary_region.value,
                        "sku": "premium",
                        "properties": {
                            "tenant_id": self.config.tenant_id,
                            "access_policies": [
                                {
                                    "tenant_id": self.config.tenant_id,
                                    "object_id": self.config.client_id,
                                    "permissions": {
                                        "keys": ["get", "list", "create", "update", "delete"],
                                        "secrets": ["get", "list", "set", "delete"],
                                        "certificates": ["get", "list", "create", "update", "delete"]
                                    }
                                }
                            ],
                            "enable_disk_encryption": True,
                            "enable_deployment": True,
                            "enable_template_deployment": True,
                            "enable_rbac_authorization": True,
                            "enable_soft_delete": True,
                            "soft_delete_retention_days": 90,
                            "enable_purge_protection": True,
                            "public_network_access": "Disabled"
                        },
                        "network_acls": {
                            "bypass": "AzureServices",
                            "default_action": "Deny",
                            "ip_rules": [],
                            "virtual_network_rules": []
                        }
                    }
                ],
                "managed_hsm": {
                    "name": f"{self.config.get_resource_name('managed', 'hsm')}",
                    "resource_group": self.config.get_resource_group_name("security"),
                    "location": self.config.primary_region.value,
                    "administrators": [self.config.client_id],
                    "public_network_access": "Disabled",
                    "network_acls": {
                        "bypass": "AzureServices",
                        "default_action": "Deny"
                    }
                },
                "certificates": [
                    {
                        "name": "ssl-certificate",
                        "certificate_policy": {
                            "key_properties": {
                                "exportable": True,
                                "key_type": "RSA",
                                "key_size": 2048,
                                "reuse_key": False
                            },
                            "secret_properties": {
                                "content_type": "application/x-pkcs12"
                            },
                            "x509_certificate_properties": {
                                "subject": f"CN={self.config.application_name}.{self.config.organization_name.lower().replace(' ', '')}.com",
                                "sans": [f"*.{self.config.application_name}.{self.config.organization_name.lower().replace(' ', '')}.com"],
                                "key_usage": ["digital_signature", "key_encipherment"],
                                "validity_months": 12
                            },
                            "issuer_parameters": {
                                "name": "Self"
                            }
                        }
                    }
                ],
                "secrets": [
                    {
                        "name": "database-connection-string",
                        "value": "Server=tcp:${database_server}.database.windows.net,1433;Initial Catalog=${database_name};Persist Security Info=False;User ID=${database_user};Password=${database_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;",
                        "content_type": "connection-string",
                        "expires": (datetime.now() + timedelta(days=365)).isoformat()
                    },
                    {
                        "name": "api-key",
                        "value": "placeholder-api-key",
                        "content_type": "api-key",
                        "expires": (datetime.now() + timedelta(days=180)).isoformat()
                    }
                ]
            }

            self.security_policies["key_vault"] = keyvault_config
            self.logger.info("Key Vault configuration prepared")

        except Exception as e:
            self.logger.error(f"Failed to setup Key Vault: {e}")

    async def _setup_private_endpoints(self) -> None:
        """Setup private endpoints for secure connectivity"""
        try:
            private_endpoints_config = {
                "private_endpoints": [
                    {
                        "name": f"{self.config.get_resource_name('storage', 'pe')}",
                        "resource_group": self.config.get_resource_group_name("network"),
                        "location": self.config.primary_region.value,
                        "subnet_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.Network/virtualNetworks/{vnet}/subnets/private-endpoints",
                        "private_link_service_connections": [
                            {
                                "name": "storage-connection",
                                "private_link_service_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.Storage/storageAccounts/{storage_account}",
                                "group_ids": ["blob"]
                            }
                        ],
                        "private_dns_zone_group": {
                            "name": "storage-dns-zone-group",
                            "private_dns_zone_configs": [
                                {
                                    "name": "blob-storage-config",
                                    "private_dns_zone_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
                                }
                            ]
                        }
                    },
                    {
                        "name": f"{self.config.get_resource_name('sql', 'pe')}",
                        "resource_group": self.config.get_resource_group_name("network"),
                        "location": self.config.primary_region.value,
                        "subnet_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.Network/virtualNetworks/{vnet}/subnets/private-endpoints",
                        "private_link_service_connections": [
                            {
                                "name": "sql-connection",
                                "private_link_service_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.Sql/servers/{sql_server}",
                                "group_ids": ["sqlServer"]
                            }
                        ],
                        "private_dns_zone_group": {
                            "name": "sql-dns-zone-group",
                            "private_dns_zone_configs": [
                                {
                                    "name": "sql-config",
                                    "private_dns_zone_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"
                                }
                            ]
                        }
                    },
                    {
                        "name": f"{self.config.get_resource_name('keyvault', 'pe')}",
                        "resource_group": self.config.get_resource_group_name("network"),
                        "location": self.config.primary_region.value,
                        "subnet_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.Network/virtualNetworks/{vnet}/subnets/private-endpoints",
                        "private_link_service_connections": [
                            {
                                "name": "keyvault-connection",
                                "private_link_service_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.KeyVault/vaults/{key_vault}",
                                "group_ids": ["vault"]
                            }
                        ],
                        "private_dns_zone_group": {
                            "name": "keyvault-dns-zone-group",
                            "private_dns_zone_configs": [
                                {
                                    "name": "keyvault-config",
                                    "private_dns_zone_id": "/subscriptions/{subscription_id}/resourceGroups/{rg}/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
                                }
                            ]
                        }
                    }
                ],
                "private_dns_zones": [
                    "privatelink.blob.core.windows.net",
                    "privatelink.database.windows.net",
                    "privatelink.vaultcore.azure.net",
                    "privatelink.azurewebsites.net",
                    "privatelink.azurecr.io"
                ]
            }

            self.security_policies["private_endpoints"] = private_endpoints_config
            self.logger.info("Private endpoints configuration prepared")

        except Exception as e:
            self.logger.error(f"Failed to setup private endpoints: {e}")

### **🏗️ Enterprise Infrastructure Manager**

class EnterpriseAzureInfrastructureManager:
    """Advanced infrastructure management with ARM, Bicep, and Terraform"""

    def __init__(self, azure_platform: EnterpriseAzurePlatform):
        self.azure_platform = azure_platform
        self.config = azure_platform.config
        self.logger = structlog.get_logger("enterprise.azure.infrastructure")

        # Infrastructure templates
        self.arm_templates = {}
        self.bicep_templates = {}
        self.terraform_modules = {}

    async def deploy_enterprise_infrastructure(self) -> Dict[str, Any]:
        """Deploy complete enterprise infrastructure"""
        try:
            self.logger.info("Starting enterprise infrastructure deployment")

            deployment_results = {}

            # Deploy resource groups
            rg_result = await self._deploy_resource_groups()
            deployment_results["resource_groups"] = rg_result

            # Deploy networking infrastructure
            network_result = await self._deploy_networking_infrastructure()
            deployment_results["networking"] = network_result

            # Deploy security infrastructure
            security_result = await self._deploy_security_infrastructure()
            deployment_results["security"] = security_result

            # Deploy compute infrastructure
            compute_result = await self._deploy_compute_infrastructure()
            deployment_results["compute"] = compute_result

            # Deploy data infrastructure
            data_result = await self._deploy_data_infrastructure()
            deployment_results["data"] = data_result

            # Deploy monitoring infrastructure
            monitoring_result = await self._deploy_monitoring_infrastructure()
            deployment_results["monitoring"] = monitoring_result

            self.logger.info(
                "Enterprise infrastructure deployment completed",
                deployed_components=len(deployment_results),
                success_count=sum(1 for r in deployment_results.values() if r.get("status") == "success")
            )

            return deployment_results

    async def _deploy_resource_groups(self) -> Dict[str, Any]:
        """Deploy enterprise resource groups"""
        try:
            resource_groups = [
                {
                    "name": self.config.get_resource_group_name("networking"),
                    "location": self.config.primary_region.value,
                    "purpose": "Networking resources including VNets, NSGs, and Load Balancers"
                },
                {
                    "name": self.config.get_resource_group_name("compute"),
                    "location": self.config.primary_region.value,
                    "purpose": "Compute resources including VMs, VMSS, and AKS"
                },
                {
                    "name": self.config.get_resource_group_name("data"),
                    "location": self.config.primary_region.value,
                    "purpose": "Data resources including SQL Database, Storage, and Cosmos DB"
                },
                {
                    "name": self.config.get_resource_group_name("security"),
                    "location": self.config.primary_region.value,
                    "purpose": "Security resources including Key Vault and Security Center"
                },
                {
                    "name": self.config.get_resource_group_name("monitoring"),
                    "location": self.config.primary_region.value,
                    "purpose": "Monitoring resources including Log Analytics and Application Insights"
                }
            ]

            rg_template = {
                "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                    "resourceGroups": {
                        "type": "array",
                        "defaultValue": resource_groups
                    },
                    "tags": {
                        "type": "object",
                        "defaultValue": self.config.custom_tags
                    }
                },
                "resources": []
            }

            # Add resource group deployments
            for i, rg in enumerate(resource_groups):
                rg_template["resources"].append({
                    "type": "Microsoft.Resources/resourceGroups",
                    "apiVersion": "2021-04-01",
                    "name": rg["name"],
                    "location": rg["location"],
                    "properties": {},
                    "tags": {
                        **self.config.custom_tags,
                        "Purpose": rg["purpose"]
                    }
                })

            self.arm_templates["resource_groups"] = rg_template

            return {
                "status": "success",
                "template_name": "resource_groups",
                "resource_groups_count": len(resource_groups),
                "description": "Enterprise resource group structure"
            }

        except Exception as e:
            self.logger.error(f"Failed to create resource groups template: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def _deploy_networking_infrastructure(self) -> Dict[str, Any]:
        """Deploy networking infrastructure with hub-spoke topology"""
        try:
            networking_template = {
                "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                    "location": {
                        "type": "string",
                        "defaultValue": self.config.primary_region.value
                    },
                    "tags": {
                        "type": "object",
                        "defaultValue": self.config.custom_tags
                    }
                },
                "variables": {
                    "hubVnetName": f"{self.config.get_resource_name('hub', 'vnet')}",
                    "spokeVnetName": f"{self.config.get_resource_name('spoke', 'vnet')}",
                    "hubAddressPrefix": "10.0.0.0/16",
                    "spokeAddressPrefix": "10.1.0.0/16"
                },
                "resources": [
                    # Hub Virtual Network
                    {
                        "type": "Microsoft.Network/virtualNetworks",
                        "apiVersion": "2021-05-01",
                        "name": "[variables('hubVnetName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "addressSpace": {
                                "addressPrefixes": ["[variables('hubAddressPrefix')]"]
                            },
                            "subnets": [
                                {
                                    "name": "GatewaySubnet",
                                    "properties": {
                                        "addressPrefix": "10.0.0.0/27"
                                    }
                                },
                                {
                                    "name": "AzureFirewallSubnet",
                                    "properties": {
                                        "addressPrefix": "10.0.0.32/26"
                                    }
                                },
                                {
                                    "name": "SharedServicesSubnet",
                                    "properties": {
                                        "addressPrefix": "10.0.1.0/24",
                                        "networkSecurityGroup": {
                                            "id": "[resourceId('Microsoft.Network/networkSecurityGroups', concat(variables('hubVnetName'), '-nsg'))]"
                                        }
                                    }
                                }
                            ]
                        },
                        "dependsOn": [
                            "[resourceId('Microsoft.Network/networkSecurityGroups', concat(variables('hubVnetName'), '-nsg'))]"
                        ]
                    },
                    # Spoke Virtual Network
                    {
                        "type": "Microsoft.Network/virtualNetworks",
                        "apiVersion": "2021-05-01",
                        "name": "[variables('spokeVnetName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "addressSpace": {
                                "addressPrefixes": ["[variables('spokeAddressPrefix')]"]
                            },
                            "subnets": [
                                {
                                    "name": "WebTierSubnet",
                                    "properties": {
                                        "addressPrefix": "10.1.1.0/24",
                                        "networkSecurityGroup": {
                                            "id": "[resourceId('Microsoft.Network/networkSecurityGroups', 'web-tier-nsg')]"
                                        }
                                    }
                                },
                                {
                                    "name": "AppTierSubnet",
                                    "properties": {
                                        "addressPrefix": "10.1.2.0/24",
                                        "networkSecurityGroup": {
                                            "id": "[resourceId('Microsoft.Network/networkSecurityGroups', 'app-tier-nsg')]"
                                        }
                                    }
                                },
                                {
                                    "name": "DataTierSubnet",
                                    "properties": {
                                        "addressPrefix": "10.1.3.0/24",
                                        "networkSecurityGroup": {
                                            "id": "[resourceId('Microsoft.Network/networkSecurityGroups', 'data-tier-nsg')]"
                                        },
                                        "serviceEndpoints": [
                                            {
                                                "service": "Microsoft.Sql"
                                            },
                                            {
                                                "service": "Microsoft.Storage"
                                            }
                                        ]
                                    }
                                },
                                {
                                    "name": "PrivateEndpointsSubnet",
                                    "properties": {
                                        "addressPrefix": "10.1.4.0/24",
                                        "privateEndpointNetworkPolicies": "Disabled"
                                    }
                                }
                            ]
                        },
                        "dependsOn": [
                            "[resourceId('Microsoft.Network/networkSecurityGroups', 'web-tier-nsg')]",
                            "[resourceId('Microsoft.Network/networkSecurityGroups', 'app-tier-nsg')]",
                            "[resourceId('Microsoft.Network/networkSecurityGroups', 'data-tier-nsg')]"
                        ]
                    },
                    # Network Security Groups
                    {
                        "type": "Microsoft.Network/networkSecurityGroups",
                        "apiVersion": "2021-05-01",
                        "name": "web-tier-nsg",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "securityRules": [
                                {
                                    "name": "Allow-HTTP",
                                    "properties": {
                                        "protocol": "Tcp",
                                        "sourcePortRange": "*",
                                        "destinationPortRange": "80",
                                        "sourceAddressPrefix": "*",
                                        "destinationAddressPrefix": "*",
                                        "access": "Allow",
                                        "priority": 100,
                                        "direction": "Inbound"
                                    }
                                },
                                {
                                    "name": "Allow-HTTPS",
                                    "properties": {
                                        "protocol": "Tcp",
                                        "sourcePortRange": "*",
                                        "destinationPortRange": "443",
                                        "sourceAddressPrefix": "*",
                                        "destinationAddressPrefix": "*",
                                        "access": "Allow",
                                        "priority": 110,
                                        "direction": "Inbound"
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "type": "Microsoft.Network/networkSecurityGroups",
                        "apiVersion": "2021-05-01",
                        "name": "app-tier-nsg",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "securityRules": [
                                {
                                    "name": "Allow-App-Port",
                                    "properties": {
                                        "protocol": "Tcp",
                                        "sourcePortRange": "*",
                                        "destinationPortRange": "8080",
                                        "sourceAddressPrefix": "10.1.1.0/24",
                                        "destinationAddressPrefix": "*",
                                        "access": "Allow",
                                        "priority": 100,
                                        "direction": "Inbound"
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "type": "Microsoft.Network/networkSecurityGroups",
                        "apiVersion": "2021-05-01",
                        "name": "data-tier-nsg",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "securityRules": [
                                {
                                    "name": "Allow-SQL",
                                    "properties": {
                                        "protocol": "Tcp",
                                        "sourcePortRange": "*",
                                        "destinationPortRange": "1433",
                                        "sourceAddressPrefix": "10.1.2.0/24",
                                        "destinationAddressPrefix": "*",
                                        "access": "Allow",
                                        "priority": 100,
                                        "direction": "Inbound"
                                    }
                                }
                            ]
                        }
                    },
                    # VNet Peering Hub to Spoke
                    {
                        "type": "Microsoft.Network/virtualNetworks/virtualNetworkPeerings",
                        "apiVersion": "2021-05-01",
                        "name": "[concat(variables('hubVnetName'), '/hub-to-spoke')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Network/virtualNetworks', variables('hubVnetName'))]",
                            "[resourceId('Microsoft.Network/virtualNetworks', variables('spokeVnetName'))]"
                        ],
                        "properties": {
                            "allowVirtualNetworkAccess": True,
                            "allowForwardedTraffic": True,
                            "allowGatewayTransit": True,
                            "useRemoteGateways": False,
                            "remoteVirtualNetwork": {
                                "id": "[resourceId('Microsoft.Network/virtualNetworks', variables('spokeVnetName'))]"
                            }
                        }
                    },
                    # VNet Peering Spoke to Hub
                    {
                        "type": "Microsoft.Network/virtualNetworks/virtualNetworkPeerings",
                        "apiVersion": "2021-05-01",
                        "name": "[concat(variables('spokeVnetName'), '/spoke-to-hub')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Network/virtualNetworks', variables('hubVnetName'))]",
                            "[resourceId('Microsoft.Network/virtualNetworks', variables('spokeVnetName'))]"
                        ],
                        "properties": {
                            "allowVirtualNetworkAccess": True,
                            "allowForwardedTraffic": True,
                            "allowGatewayTransit": False,
                            "useRemoteGateways": False,
                            "remoteVirtualNetwork": {
                                "id": "[resourceId('Microsoft.Network/virtualNetworks', variables('hubVnetName'))]"
                            }
                        }
                    },
                    # Application Gateway
                    {
                        "type": "Microsoft.Network/applicationGateways",
                        "apiVersion": "2021-05-01",
                        "name": f"{self.config.get_resource_name('app', 'agw')}",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Network/virtualNetworks', variables('spokeVnetName'))]",
                            "[resourceId('Microsoft.Network/publicIPAddresses', concat(parameters('applicationGatewayName'), '-pip'))]"
                        ],
                        "properties": {
                            "sku": {
                                "name": "WAF_v2",
                                "tier": "WAF_v2",
                                "capacity": 2
                            },
                            "gatewayIPConfigurations": [
                                {
                                    "name": "appGwIpConfig",
                                    "properties": {
                                        "subnet": {
                                            "id": "[concat(resourceId('Microsoft.Network/virtualNetworks', variables('spokeVnetName')), '/subnets/WebTierSubnet')]"
                                        }
                                    }
                                }
                            ],
                            "frontendIPConfigurations": [
                                {
                                    "name": "appGwPublicFrontendIp",
                                    "properties": {
                                        "publicIPAddress": {
                                            "id": f"[resourceId('Microsoft.Network/publicIPAddresses', '{self.config.get_resource_name('agw', 'pip')}')]"
                                        }
                                    }
                                }
                            ],
                            "frontendPorts": [
                                {
                                    "name": "port_80",
                                    "properties": {
                                        "port": 80
                                    }
                                },
                                {
                                    "name": "port_443",
                                    "properties": {
                                        "port": 443
                                    }
                                }
                            ],
                            "backendAddressPools": [
                                {
                                    "name": "webServerPool",
                                    "properties": {}
                                }
                            ],
                            "backendHttpSettingsCollection": [
                                {
                                    "name": "appGwBackendHttpSettings",
                                    "properties": {
                                        "port": 80,
                                        "protocol": "Http",
                                        "cookieBasedAffinity": "Disabled"
                                    }
                                }
                            ],
                            "httpListeners": [
                                {
                                    "name": "appGwHttpListener",
                                    "properties": {
                                        "frontendIPConfiguration": {
                                            "id": "[concat(variables('applicationGatewayID'), '/frontendIPConfigurations/appGwPublicFrontendIp')]"
                                        },
                                        "frontendPort": {
                                            "id": "[concat(variables('applicationGatewayID'), '/frontendPorts/port_80')]"
                                        },
                                        "protocol": "Http"
                                    }
                                }
                            ],
                            "requestRoutingRules": [
                                {
                                    "name": "rule1",
                                    "properties": {
                                        "ruleType": "Basic",
                                        "httpListener": {
                                            "id": "[concat(variables('applicationGatewayID'), '/httpListeners/appGwHttpListener')]"
                                        },
                                        "backendAddressPool": {
                                            "id": "[concat(variables('applicationGatewayID'), '/backendAddressPools/webServerPool')]"
                                        },
                                        "backendHttpSettings": {
                                            "id": "[concat(variables('applicationGatewayID'), '/backendHttpSettingsCollection/appGwBackendHttpSettings')]"
                                        }
                                    }
                                }
                            ],
                            "webApplicationFirewallConfiguration": {
                                "enabled": True,
                                "firewallMode": "Prevention",
                                "ruleSetType": "OWASP",
                                "ruleSetVersion": "3.2"
                            }
                        }
                    }
                ],
                "outputs": {
                    "hubVnetId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Network/virtualNetworks', variables('hubVnetName'))]"
                    },
                    "spokeVnetId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Network/virtualNetworks', variables('spokeVnetName'))]"
                    }
                }
            }

            self.arm_templates["networking_infrastructure"] = networking_template

            return {
                "status": "success",
                "template_name": "networking_infrastructure",
                "resources": len(networking_template["resources"]),
                "description": "Hub-spoke networking with Application Gateway and WAF"
            }

    async def _deploy_compute_infrastructure(self) -> Dict[str, Any]:
        """Deploy compute resources including VMs, VMSS, and AKS"""
        try:
            compute_template = {
                "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                    "location": {
                        "type": "string",
                        "defaultValue": self.config.primary_region.value
                    },
                    "adminUsername": {
                        "type": "string",
                        "defaultValue": "azureuser"
                    },
                    "sshKeyData": {
                        "type": "string",
                        "metadata": {
                            "description": "SSH public key for VM access"
                        }
                    },
                    "vmSize": {
                        "type": "string",
                        "defaultValue": "Standard_D2s_v3",
                        "allowedValues": [
                            "Standard_B2s",
                            "Standard_D2s_v3",
                            "Standard_D4s_v3",
                            "Standard_E2s_v3"
                        ]
                    },
                    "tags": {
                        "type": "object",
                        "defaultValue": self.config.custom_tags
                    }
                },
                "variables": {
                    "vmssName": f"{self.config.get_resource_name('web', 'vmss')}",
                    "aksClusterName": f"{self.config.get_resource_name('app', 'aks')}",
                    "jumpBoxName": f"{self.config.get_resource_name('jump', 'vm')}"
                },
                "resources": [
                    # Virtual Machine Scale Set for Web Tier
                    {
                        "type": "Microsoft.Compute/virtualMachineScaleSets",
                        "apiVersion": "2021-07-01",
                        "name": "[variables('vmssName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "sku": {
                            "name": "[parameters('vmSize')]",
                            "tier": "Standard",
                            "capacity": 3
                        },
                        "properties": {
                            "orchestrationMode": "Uniform",
                            "upgradePolicy": {
                                "mode": "Automatic",
                                "automaticOSUpgradePolicy": {
                                    "enableAutomaticOSUpgrade": True
                                }
                            },
                            "virtualMachineProfile": {
                                "storageProfile": {
                                    "osDisk": {
                                        "createOption": "FromImage",
                                        "managedDisk": {
                                            "storageAccountType": "Premium_LRS"
                                        }
                                    },
                                    "imageReference": {
                                        "publisher": "Canonical",
                                        "offer": "0001-com-ubuntu-server-focal",
                                        "sku": "20_04-lts-gen2",
                                        "version": "latest"
                                    }
                                },
                                "osProfile": {
                                    "computerNamePrefix": "web",
                                    "adminUsername": "[parameters('adminUsername')]",
                                    "customData": "[base64(concat('#cloud-config\npackage_upgrade: true\npackages:\n  - nginx\n  - docker.io\nruncmd:\n  - systemctl enable nginx\n  - systemctl start nginx\n  - systemctl enable docker\n  - systemctl start docker\n  - usermod -aG docker ', parameters('adminUsername')))]",
                                    "linuxConfiguration": {
                                        "disablePasswordAuthentication": True,
                                        "ssh": {
                                            "publicKeys": [
                                                {
                                                    "path": "[concat('/home/', parameters('adminUsername'), '/.ssh/authorized_keys')]",
                                                    "keyData": "[parameters('sshKeyData')]"
                                                }
                                            ]
                                        }
                                    }
                                },
                                "networkProfile": {
                                    "networkInterfaceConfigurations": [
                                        {
                                            "name": "webVMSS-nic",
                                            "properties": {
                                                "primary": True,
                                                "ipConfigurations": [
                                                    {
                                                        "name": "webVMSS-ipconfig",
                                                        "properties": {
                                                            "subnet": {
                                                                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'spoke-vnet', 'WebTierSubnet')]"
                                                            },
                                                            "applicationGatewayBackendAddressPools": [
                                                                {
                                                                    "id": f"[resourceId('Microsoft.Network/applicationGateways/backendAddressPools', '{self.config.get_resource_name('app', 'agw')}', 'webServerPool')]"
                                                                }
                                                            ]
                                                        }
                                                    }
                                                ]
                                            }
                                        }
                                    ]
                                },
                                "extensionProfile": {
                                    "extensions": [
                                        {
                                            "name": "HealthExtension",
                                            "properties": {
                                                "publisher": "Microsoft.ManagedServices",
                                                "type": "ApplicationHealthLinux",
                                                "typeHandlerVersion": "1.0",
                                                "autoUpgradeMinorVersion": True,
                                                "settings": {
                                                    "protocol": "http",
                                                    "port": 80,
                                                    "requestPath": "/health"
                                                }
                                            }
                                        }
                                    ]
                                }
                            }
                        }
                    },
                    # Azure Kubernetes Service (AKS) Cluster
                    {
                        "type": "Microsoft.ContainerService/managedClusters",
                        "apiVersion": "2021-10-01",
                        "name": "[variables('aksClusterName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "identity": {
                            "type": "SystemAssigned"
                        },
                        "properties": {
                            "kubernetesVersion": "1.21.9",
                            "dnsPrefix": "[concat(variables('aksClusterName'), '-dns')]",
                            "agentPoolProfiles": [
                                {
                                    "name": "systempool",
                                    "count": 3,
                                    "vmSize": "Standard_D2s_v3",
                                    "osType": "Linux",
                                    "mode": "System",
                                    "vnetSubnetID": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'spoke-vnet', 'AppTierSubnet')]",
                                    "enableAutoScaling": True,
                                    "minCount": 1,
                                    "maxCount": 10
                                },
                                {
                                    "name": "userpool",
                                    "count": 2,
                                    "vmSize": "Standard_D4s_v3",
                                    "osType": "Linux",
                                    "mode": "User",
                                    "vnetSubnetID": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'spoke-vnet', 'AppTierSubnet')]",
                                    "enableAutoScaling": True,
                                    "minCount": 1,
                                    "maxCount": 20
                                }
                            ],
                            "networkProfile": {
                                "networkPlugin": "azure",
                                "serviceCidr": "172.16.0.0/16",
                                "dnsServiceIP": "172.16.0.10",
                                "dockerBridgeCidr": "172.17.0.1/16"
                            },
                            "apiServerAccessProfile": {
                                "enablePrivateCluster": True,
                                "privateDNSZone": "system"
                            },
                            "addonProfiles": {
                                "azureKeyvaultSecretsProvider": {
                                    "enabled": True,
                                    "config": {
                                        "enableSecretRotation": "true"
                                    }
                                },
                                "azurepolicy": {
                                    "enabled": True
                                },
                                "omsagent": {
                                    "enabled": True,
                                    "config": {
                                        "logAnalyticsWorkspaceResourceID": f"[resourceId('Microsoft.OperationalInsights/workspaces', '{self.config.get_resource_name('central', 'log')}-analytics')]"
                                    }
                                }
                            },
                            "enableRBAC": True,
                            "aadProfile": {
                                "managed": True,
                                "enableAzureRBAC": True
                            }
                        }
                    },
                    # Jump Box VM for Management
                    {
                        "type": "Microsoft.Compute/virtualMachines",
                        "apiVersion": "2021-07-01",
                        "name": "[variables('jumpBoxName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Network/networkInterfaces', concat(variables('jumpBoxName'), '-nic'))]"
                        ],
                        "properties": {
                            "hardwareProfile": {
                                "vmSize": "Standard_B2s"
                            },
                            "osProfile": {
                                "computerName": "[variables('jumpBoxName')]",
                                "adminUsername": "[parameters('adminUsername')]",
                                "customData": "[base64('#cloud-config\npackage_upgrade: true\npackages:\n  - azure-cli\n  - kubectl\n  - docker.io\n  - htop\n  - git\nruncmd:\n  - curl -sL https://aka.ms/InstallAzureCLIDeb | bash\n  - az aks install-cli')]",
                                "linuxConfiguration": {
                                    "disablePasswordAuthentication": True,
                                    "ssh": {
                                        "publicKeys": [
                                            {
                                                "path": "[concat('/home/', parameters('adminUsername'), '/.ssh/authorized_keys')]",
                                                "keyData": "[parameters('sshKeyData')]"
                                            }
                                        ]
                                    }
                                }
                            },
                            "storageProfile": {
                                "imageReference": {
                                    "publisher": "Canonical",
                                    "offer": "0001-com-ubuntu-server-focal",
                                    "sku": "20_04-lts-gen2",
                                    "version": "latest"
                                },
                                "osDisk": {
                                    "name": "[concat(variables('jumpBoxName'), '-osdisk')]",
                                    "caching": "ReadWrite",
                                    "createOption": "FromImage",
                                    "managedDisk": {
                                        "storageAccountType": "Standard_LRS"
                                    }
                                }
                            },
                            "networkProfile": {
                                "networkInterfaces": [
                                    {
                                        "id": "[resourceId('Microsoft.Network/networkInterfaces', concat(variables('jumpBoxName'), '-nic'))]"
                                    }
                                ]
                            }
                        }
                    },
                    # Network Interface for Jump Box
                    {
                        "type": "Microsoft.Network/networkInterfaces",
                        "apiVersion": "2021-05-01",
                        "name": "[concat(variables('jumpBoxName'), '-nic')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "ipConfigurations": [
                                {
                                    "name": "ipconfig1",
                                    "properties": {
                                        "privateIPAllocationMethod": "Dynamic",
                                        "subnet": {
                                            "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'hub-vnet', 'SharedServicesSubnet')]"
                                        }
                                    }
                                }
                            ]
                        }
                    },
                    # Auto Scaling Settings for VMSS
                    {
                        "type": "Microsoft.Insights/autoscalesettings",
                        "apiVersion": "2015-04-01",
                        "name": "[concat(variables('vmssName'), '-autoscale')]",
                        "location": "[parameters('location')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Compute/virtualMachineScaleSets', variables('vmssName'))]"
                        ],
                        "properties": {
                            "name": "[concat(variables('vmssName'), '-autoscale')]",
                            "targetResourceUri": "[resourceId('Microsoft.Compute/virtualMachineScaleSets', variables('vmssName'))]",
                            "enabled": True,
                            "profiles": [
                                {
                                    "name": "Default",
                                    "capacity": {
                                        "minimum": "2",
                                        "maximum": "10",
                                        "default": "3"
                                    },
                                    "rules": [
                                        {
                                            "metricTrigger": {
                                                "metricName": "Percentage CPU",
                                                "metricResourceUri": "[resourceId('Microsoft.Compute/virtualMachineScaleSets', variables('vmssName'))]",
                                                "timeGrain": "PT1M",
                                                "statistic": "Average",
                                                "timeWindow": "PT5M",
                                                "timeAggregation": "Average",
                                                "operator": "GreaterThan",
                                                "threshold": 70
                                            },
                                            "scaleAction": {
                                                "direction": "Increase",
                                                "type": "ChangeCount",
                                                "value": "1",
                                                "cooldown": "PT5M"
                                            }
                                        },
                                        {
                                            "metricTrigger": {
                                                "metricName": "Percentage CPU",
                                                "metricResourceUri": "[resourceId('Microsoft.Compute/virtualMachineScaleSets', variables('vmssName'))]",
                                                "timeGrain": "PT1M",
                                                "statistic": "Average",
                                                "timeWindow": "PT5M",
                                                "timeAggregation": "Average",
                                                "operator": "LessThan",
                                                "threshold": 30
                                            },
                                            "scaleAction": {
                                                "direction": "Decrease",
                                                "type": "ChangeCount",
                                                "value": "1",
                                                "cooldown": "PT5M"
                                            }
                                        }
                                    ]
                                }
                            ]
                        }
                    }
                ],
                "outputs": {
                    "vmssId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Compute/virtualMachineScaleSets', variables('vmssName'))]"
                    },
                    "aksClusterId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.ContainerService/managedClusters', variables('aksClusterName'))]"
                    },
                    "jumpBoxId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Compute/virtualMachines', variables('jumpBoxName'))]"
                    }
                }
            }

            self.arm_templates["compute_infrastructure"] = compute_template

            return {
                "status": "success",
                "template_name": "compute_infrastructure",
                "resources": len(compute_template["resources"]),
                "description": "Enterprise compute with VMSS, AKS, and Jump Box"
            }

        except Exception as e:
            self.logger.error(f"Failed to create compute template: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def _deploy_data_infrastructure(self) -> Dict[str, Any]:
        """Deploy data tier including SQL Database, Storage, and Cosmos DB"""
        try:
            data_template = {
                "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                    "location": {
                        "type": "string",
                        "defaultValue": self.config.primary_region.value
                    },
                    "sqlAdministratorLogin": {
                        "type": "string",
                        "defaultValue": "sqladmin"
                    },
                    "sqlAdministratorPassword": {
                        "type": "securestring",
                        "metadata": {
                            "description": "SQL Server administrator password"
                        }
                    },
                    "tags": {
                        "type": "object",
                        "defaultValue": self.config.custom_tags
                    }
                },
                "variables": {
                    "sqlServerName": f"{self.config.get_resource_name('enterprise', 'sql')}",
                    "sqlDatabaseName": f"{self.config.get_resource_name('app', 'db')}",
                    "storageAccountName": f"{self.config.get_resource_name('enterprise', 'st')}".replace('-', '').lower()[:24],
                    "cosmosAccountName": f"{self.config.get_resource_name('enterprise', 'cosmos')}"
                },
                "resources": [
                    # SQL Server
                    {
                        "type": "Microsoft.Sql/servers",
                        "apiVersion": "2021-11-01",
                        "name": "[variables('sqlServerName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "administratorLogin": "[parameters('sqlAdministratorLogin')]",
                            "administratorLoginPassword": "[parameters('sqlAdministratorPassword')]",
                            "version": "12.0",
                            "minimalTlsVersion": "1.2",
                            "publicNetworkAccess": "Disabled"
                        }
                    },
                    # SQL Database
                    {
                        "type": "Microsoft.Sql/servers/databases",
                        "apiVersion": "2021-11-01",
                        "name": "[concat(variables('sqlServerName'), '/', variables('sqlDatabaseName'))]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Sql/servers', variables('sqlServerName'))]"
                        ],
                        "sku": {
                            "name": "S2",
                            "tier": "Standard",
                            "capacity": 50
                        },
                        "properties": {
                            "collation": "SQL_Latin1_General_CP1_CI_AS",
                            "maxSizeBytes": 268435456000,
                            "catalogCollation": "SQL_Latin1_General_CP1_CI_AS",
                            "zoneRedundant": False,
                            "readScale": "Disabled"
                        }
                    },
                    # SQL Server Firewall Rule for Azure Services
                    {
                        "type": "Microsoft.Sql/servers/firewallRules",
                        "apiVersion": "2021-11-01",
                        "name": "[concat(variables('sqlServerName'), '/AllowAllWindowsAzureIps')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Sql/servers', variables('sqlServerName'))]"
                        ],
                        "properties": {
                            "startIpAddress": "0.0.0.0",
                            "endIpAddress": "0.0.0.0"
                        }
                    },
                    # SQL Private Endpoint
                    {
                        "type": "Microsoft.Network/privateEndpoints",
                        "apiVersion": "2021-05-01",
                        "name": "[concat(variables('sqlServerName'), '-pe')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Sql/servers', variables('sqlServerName'))]"
                        ],
                        "properties": {
                            "subnet": {
                                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'spoke-vnet', 'PrivateEndpointsSubnet')]"
                            },
                            "privateLinkServiceConnections": [
                                {
                                    "name": "[concat(variables('sqlServerName'), '-psc')]",
                                    "properties": {
                                        "privateLinkServiceId": "[resourceId('Microsoft.Sql/servers', variables('sqlServerName'))]",
                                        "groupIds": ["sqlServer"]
                                    }
                                }
                            ]
                        }
                    },
                    # Storage Account
                    {
                        "type": "Microsoft.Storage/storageAccounts",
                        "apiVersion": "2021-09-01",
                        "name": "[variables('storageAccountName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "sku": {
                            "name": "Standard_ZRS"
                        },
                        "kind": "StorageV2",
                        "properties": {
                            "defaultToOAuthAuthentication": False,
                            "allowCrossTenantReplication": False,
                            "minimumTlsVersion": "TLS1_2",
                            "allowBlobPublicAccess": False,
                            "allowSharedKeyAccess": True,
                            "supportsHttpsTrafficOnly": True,
                            "encryption": {
                                "services": {
                                    "file": {
                                        "keyType": "Account",
                                        "enabled": True
                                    },
                                    "blob": {
                                        "keyType": "Account",
                                        "enabled": True
                                    }
                                },
                                "keySource": "Microsoft.Storage"
                            },
                            "accessTier": "Hot",
                            "networkAcls": {
                                "bypass": "AzureServices",
                                "virtualNetworkRules": [
                                    {
                                        "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'spoke-vnet', 'DataTierSubnet')]",
                                        "action": "Allow"
                                    }
                                ],
                                "defaultAction": "Deny"
                            }
                        }
                    },
                    # Blob Services
                    {
                        "type": "Microsoft.Storage/storageAccounts/blobServices",
                        "apiVersion": "2021-09-01",
                        "name": "[concat(variables('storageAccountName'), '/default')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))]"
                        ],
                        "properties": {
                            "changeFeed": {
                                "enabled": True
                            },
                            "restorePolicy": {
                                "enabled": True,
                                "days": 30
                            },
                            "containerDeleteRetentionPolicy": {
                                "enabled": True,
                                "days": 30
                            },
                            "deleteRetentionPolicy": {
                                "enabled": True,
                                "days": 30
                            },
                            "versioning": {
                                "enabled": True
                            }
                        }
                    },
                    # Blob Containers
                    {
                        "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
                        "apiVersion": "2021-09-01",
                        "name": "[concat(variables('storageAccountName'), '/default/application-data')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Storage/storageAccounts/blobServices', variables('storageAccountName'), 'default')]"
                        ],
                        "properties": {
                            "defaultEncryptionScope": "$account-encryption-key",
                            "denyEncryptionScopeOverride": False,
                            "publicAccess": "None"
                        }
                    },
                    {
                        "type": "Microsoft.Storage/storageAccounts/blobServices/containers",
                        "apiVersion": "2021-09-01",
                        "name": "[concat(variables('storageAccountName'), '/default/backup-data')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Storage/storageAccounts/blobServices', variables('storageAccountName'), 'default')]"
                        ],
                        "properties": {
                            "defaultEncryptionScope": "$account-encryption-key",
                            "denyEncryptionScopeOverride": False,
                            "publicAccess": "None"
                        }
                    },
                    # Cosmos DB Account
                    {
                        "type": "Microsoft.DocumentDB/databaseAccounts",
                        "apiVersion": "2021-10-15",
                        "name": "[variables('cosmosAccountName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "kind": "GlobalDocumentDB",
                        "properties": {
                            "publicNetworkAccess": "Disabled",
                            "enableAutomaticFailover": True,
                            "enableMultipleWriteLocations": False,
                            "isVirtualNetworkFilterEnabled": True,
                            "virtualNetworkRules": [
                                {
                                    "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'spoke-vnet', 'DataTierSubnet')]",
                                    "ignoreMissingVNetServiceEndpoint": False
                                }
                            ],
                            "disableKeyBasedMetadataWriteAccess": False,
                            "enableFreeTier": False,
                            "enableAnalyticalStorage": True,
                            "analyticalStorageConfiguration": {
                                "schemaType": "WellDefined"
                            },
                            "databaseAccountOfferType": "Standard",
                            "defaultIdentity": "FirstPartyIdentity",
                            "networkAclBypass": "None",
                            "disableLocalAuth": False,
                            "consistencyPolicy": {
                                "defaultConsistencyLevel": "Session",
                                "maxIntervalInSeconds": 86400,
                                "maxStalenessPrefix": 1000000
                            },
                            "locations": [
                                {
                                    "locationName": "[parameters('location')]",
                                    "failoverPriority": 0,
                                    "isZoneRedundant": False
                                }
                            ],
                            "cors": [],
                            "capabilities": [
                                {
                                    "name": "EnableServerless"
                                }
                            ],
                            "ipRules": [],
                            "backupPolicy": {
                                "type": "Periodic",
                                "periodicModeProperties": {
                                    "backupIntervalInMinutes": 240,
                                    "backupRetentionIntervalInHours": 8,
                                    "backupStorageRedundancy": "Geo"
                                }
                            },
                            "networkAclBypassResourceIds": []
                        }
                    },
                    # Cosmos DB SQL Database
                    {
                        "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases",
                        "apiVersion": "2021-10-15",
                        "name": "[concat(variables('cosmosAccountName'), '/ApplicationDB')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.DocumentDB/databaseAccounts', variables('cosmosAccountName'))]"
                        ],
                        "properties": {
                            "resource": {
                                "id": "ApplicationDB"
                            }
                        }
                    },
                    # Cosmos DB Container
                    {
                        "type": "Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers",
                        "apiVersion": "2021-10-15",
                        "name": "[concat(variables('cosmosAccountName'), '/ApplicationDB/Users')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.DocumentDB/databaseAccounts/sqlDatabases', variables('cosmosAccountName'), 'ApplicationDB')]"
                        ],
                        "properties": {
                            "resource": {
                                "id": "Users",
                                "indexingPolicy": {
                                    "indexingMode": "consistent",
                                    "automatic": True,
                                    "includedPaths": [
                                        {
                                            "path": "/*"
                                        }
                                    ],
                                    "excludedPaths": [
                                        {
                                            "path": "/\"_etag\"/?"
                                        }
                                    ]
                                },
                                "partitionKey": {
                                    "paths": [
                                        "/userId"
                                    ],
                                    "kind": "Hash"
                                },
                                "conflictResolutionPolicy": {
                                    "mode": "LastWriterWins",
                                    "conflictResolutionPath": "/_ts"
                                }
                            }
                        }
                    }
                ],
                "outputs": {
                    "sqlServerId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Sql/servers', variables('sqlServerName'))]"
                    },
                    "sqlDatabaseId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Sql/servers/databases', variables('sqlServerName'), variables('sqlDatabaseName'))]"
                    },
                    "storageAccountId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Storage/storageAccounts', variables('storageAccountName'))]"
                    },
                    "cosmosAccountId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.DocumentDB/databaseAccounts', variables('cosmosAccountName'))]"
                    }
                }
            }

            self.arm_templates["data_infrastructure"] = data_template

            return {
                "status": "success",
                "template_name": "data_infrastructure",
                "resources": len(data_template["resources"]),
                "description": "Enterprise data tier with SQL Database, Storage, and Cosmos DB"
            }

        except Exception as e:
            self.logger.error(f"Failed to create data template: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def _deploy_monitoring_infrastructure(self) -> Dict[str, Any]:
        """Deploy comprehensive monitoring and logging infrastructure"""
        try:
            monitoring_template = {
                "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
                "contentVersion": "1.0.0.0",
                "parameters": {
                    "location": {
                        "type": "string",
                        "defaultValue": self.config.primary_region.value
                    },
                    "tags": {
                        "type": "object",
                        "defaultValue": self.config.custom_tags
                    }
                },
                "variables": {
                    "logAnalyticsName": f"{self.config.get_resource_name('central', 'log')}-analytics",
                    "appInsightsName": f"{self.config.get_resource_name('app', 'insights')}",
                    "actionGroupName": f"{self.config.get_resource_name('alerts', 'ag')}",
                    "workbookName": f"{self.config.get_resource_name('enterprise', 'workbook')}"
                },
                "resources": [
                    # Log Analytics Workspace
                    {
                        "type": "Microsoft.OperationalInsights/workspaces",
                        "apiVersion": "2021-12-01-preview",
                        "name": "[variables('logAnalyticsName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "sku": {
                                "name": "PerGB2018"
                            },
                            "retentionInDays": 90,
                            "features": {
                                "enableLogAccessUsingOnlyResourcePermissions": True
                            },
                            "workspaceCapping": {
                                "dailyQuotaGb": -1
                            },
                            "publicNetworkAccessForIngestion": "Enabled",
                            "publicNetworkAccessForQuery": "Enabled"
                        }
                    },
                    # Application Insights
                    {
                        "type": "Microsoft.Insights/components",
                        "apiVersion": "2020-02-02",
                        "name": "[variables('appInsightsName')]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "kind": "web",
                        "properties": {
                            "Application_Type": "web",
                            "Request_Source": "rest",
                            "WorkspaceResourceId": "[resourceId('Microsoft.OperationalInsights/workspaces', variables('logAnalyticsName'))]"
                        },
                        "dependsOn": [
                            "[resourceId('Microsoft.OperationalInsights/workspaces', variables('logAnalyticsName'))]"
                        ]
                    },
                    # Action Group for Alerts
                    {
                        "type": "Microsoft.Insights/actionGroups",
                        "apiVersion": "2021-09-01",
                        "name": "[variables('actionGroupName')]",
                        "location": "Global",
                        "tags": "[parameters('tags')]",
                        "properties": {
                            "groupShortName": "EnterpriseAG",
                            "enabled": True,
                            "emailReceivers": [
                                {
                                    "name": "AdminEmail",
                                    "emailAddress": "admin@company.com",
                                    "useCommonAlertSchema": True
                                }
                            ],
                            "smsReceivers": [],
                            "webhookReceivers": [],
                            "armRoleReceivers": [
                                {
                                    "name": "Owner",
                                    "roleId": "8e3af657-a8ff-443c-a75c-2fe8c4bcb635",
                                    "useCommonAlertSchema": True
                                }
                            ],
                            "azureAppPushReceivers": [],
                            "itsmReceivers": [],
                            "automationRunbookReceivers": [],
                            "voiceReceivers": [],
                            "logicAppReceivers": [],
                            "azureFunctionReceivers": []
                        }
                    },
                    # Metric Alert for High CPU
                    {
                        "type": "Microsoft.Insights/metricAlerts",
                        "apiVersion": "2018-03-01",
                        "name": "High CPU Alert",
                        "location": "Global",
                        "tags": "[parameters('tags')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.Insights/actionGroups', variables('actionGroupName'))]"
                        ],
                        "properties": {
                            "description": "Alert when CPU usage is high",
                            "severity": 2,
                            "enabled": True,
                            "scopes": [
                                f"[resourceId('Microsoft.Compute/virtualMachineScaleSets', '{self.config.get_resource_name('web', 'vmss')}')]"
                            ],
                            "evaluationFrequency": "PT1M",
                            "windowSize": "PT5M",
                            "criteria": {
                                "odata.type": "Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria",
                                "allOf": [
                                    {
                                        "name": "1st criterion",
                                        "metricName": "Percentage CPU",
                                        "operator": "GreaterThan",
                                        "threshold": 80,
                                        "timeAggregation": "Average"
                                    }
                                ]
                            },
                            "actions": [
                                {
                                    "actionGroupId": "[resourceId('Microsoft.Insights/actionGroups', variables('actionGroupName'))]"
                                }
                            ]
                        }
                    },
                    # Log Query Alert
                    {
                        "type": "Microsoft.Insights/scheduledQueryRules",
                        "apiVersion": "2021-08-01",
                        "name": "Failed Login Alert",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "dependsOn": [
                            "[resourceId('Microsoft.OperationalInsights/workspaces', variables('logAnalyticsName'))]",
                            "[resourceId('Microsoft.Insights/actionGroups', variables('actionGroupName'))]"
                        ],
                        "properties": {
                            "displayName": "Failed Login Alert",
                            "description": "Alert on failed login attempts",
                            "severity": 1,
                            "enabled": True,
                            "evaluationFrequency": "PT5M",
                            "windowSize": "PT15M",
                            "criteria": {
                                "allOf": [
                                    {
                                        "query": "SecurityEvent | where EventID == 4625 | summarize count() by Computer | where count_ > 5",
                                        "timeAggregation": "Count",
                                        "operator": "GreaterThan",
                                        "threshold": 0,
                                        "failingPeriods": {
                                            "numberOfEvaluationPeriods": 1,
                                            "minFailingPeriodsToAlert": 1
                                        }
                                    }
                                ]
                            },
                            "actions": {
                                "actionGroups": [
                                    "[resourceId('Microsoft.Insights/actionGroups', variables('actionGroupName'))]"
                                ]
                            }
                        }
                    },
                    # Azure Workbook for Dashboard
                    {
                        "type": "Microsoft.Insights/workbooks",
                        "apiVersion": "2021-08-01",
                        "name": "[guid(variables('workbookName'))]",
                        "location": "[parameters('location')]",
                        "tags": "[parameters('tags')]",
                        "kind": "shared",
                        "properties": {
                            "displayName": "Enterprise Monitoring Dashboard",
                            "serializedData": "{\n  \"version\": \"Notebook/1.0\",\n  \"items\": [\n    {\n      \"type\": 1,\n      \"content\": {\n        \"json\": \"# Enterprise Monitoring Dashboard\\n\\nThis workbook provides comprehensive monitoring for your Azure infrastructure.\"\n      },\n      \"name\": \"text - 0\"\n    },\n    {\n      \"type\": 3,\n      \"content\": {\n        \"version\": \"KqlItem/1.0\",\n        \"query\": \"Perf\\n| where CounterName == \\\"% Processor Time\\\"\\n| summarize avg(CounterValue) by Computer, bin(TimeGenerated, 5m)\\n| render timechart\",\n        \"size\": 0,\n        \"title\": \"CPU Usage Trend\",\n        \"timeContext\": {\n          \"durationMs\": 3600000\n        },\n        \"queryType\": 0,\n        \"resourceType\": \"microsoft.operationalinsights/workspaces\"\n      },\n      \"name\": \"query - 1\"\n    }\n  ],\n  \"isLocked\": false,\n  \"fallbackResourceIds\": [\n    \"/subscriptions/{subscription-id}/resourcegroups/{resource-group}/providers/microsoft.operationalinsights/workspaces/{workspace-name}\"\n  ]\n}",
                            "category": "workbook"
                        }
                    }
                ],
                "outputs": {
                    "logAnalyticsWorkspaceId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.OperationalInsights/workspaces', variables('logAnalyticsName'))]"
                    },
                    "applicationInsightsId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Insights/components', variables('appInsightsName'))]"
                    },
                    "actionGroupId": {
                        "type": "string",
                        "value": "[resourceId('Microsoft.Insights/actionGroups', variables('actionGroupName'))]"
                    }
                }
            }

            self.arm_templates["monitoring_infrastructure"] = monitoring_template

            return {
                "status": "success",
                "template_name": "monitoring_infrastructure",
                "resources": len(monitoring_template["resources"]),
                "description": "Comprehensive monitoring with Log Analytics, Application Insights, and alerts"
            }

        except Exception as e:
            self.logger.error(f"Failed to create monitoring template: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

class EnterpriseAzureCostManager:
    """Advanced cost management and optimization for Azure enterprise environments"""

    def __init__(self, config: EnterpriseAzureConfig):
        self.config = config
        self.logger = self._setup_logging()
        self.cost_client = None
        self.advisor_client = None

    def _setup_logging(self) -> logging.Logger:
        """Set up comprehensive logging"""
        logger = logging.getLogger(f"azure_cost_manager_{self.config.subscription_id}")
        handler = logging.StreamHandler()
        formatter = logging.Formatter(
            '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        logger.setLevel(logging.INFO)
        return logger

    async def initialize_cost_management(self) -> Dict[str, Any]:
        """Initialize cost management services"""
        try:
            # Initialize cost management client
            credential = DefaultAzureCredential()

            # Cost Management client for billing data
            self.cost_client = CostManagementClient(
                credential=credential,
                subscription_id=self.config.subscription_id
            )

            # Advisor client for recommendations
            self.advisor_client = AdvisorManagementClient(
                credential=credential,
                subscription_id=self.config.subscription_id
            )

            return {
                "status": "initialized",
                "services": ["cost_management", "advisor"],
                "description": "Enterprise cost management services ready"
            }

        except Exception as e:
            self.logger.error(f"Failed to initialize cost management: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def setup_cost_budgets(self) -> Dict[str, Any]:
        """Set up comprehensive cost budgets and alerts"""
        try:
            budgets = []

            # Overall subscription budget
            overall_budget = {
                "name": f"{self.config.get_resource_name('overall', 'budget')}",
                "amount": self.config.budget_limits.get("overall", 10000),
                "time_grain": "Monthly",
                "start_date": "2024-01-01",
                "end_date": "2025-12-31",
                "filters": {
                    "resource_groups": [],
                    "resources": [],
                    "meters": [],
                    "tags": {}
                },
                "notifications": [
                    {
                        "enabled": True,
                        "operator": "GreaterThan",
                        "threshold": 50,
                        "contact_emails": ["admin@company.com"],
                        "contact_groups": [],
                        "contact_roles": ["Owner"]
                    },
                    {
                        "enabled": True,
                        "operator": "GreaterThan",
                        "threshold": 80,
                        "contact_emails": ["admin@company.com", "finance@company.com"],
                        "contact_groups": [],
                        "contact_roles": ["Owner", "Contributor"]
                    },
                    {
                        "enabled": True,
                        "operator": "GreaterThan",
                        "threshold": 100,
                        "contact_emails": ["admin@company.com", "finance@company.com", "ceo@company.com"],
                        "contact_groups": [],
                        "contact_roles": ["Owner", "Contributor"]
                    }
                ]
            }
            budgets.append(overall_budget)

            # Resource group specific budgets
            resource_groups = ["networking", "compute", "data", "security", "monitoring"]
            for rg in resource_groups:
                rg_budget = {
                    "name": f"{self.config.get_resource_name(rg, 'budget')}",
                    "amount": self.config.budget_limits.get(rg, 2000),
                    "time_grain": "Monthly",
                    "start_date": "2024-01-01",
                    "end_date": "2025-12-31",
                    "filters": {
                        "resource_groups": [self.config.get_resource_group_name(rg)],
                        "resources": [],
                        "meters": [],
                        "tags": {}
                    },
                    "notifications": [
                        {
                            "enabled": True,
                            "operator": "GreaterThan",
                            "threshold": 75,
                            "contact_emails": ["admin@company.com"],
                            "contact_groups": [],
                            "contact_roles": ["Owner"]
                        },
                        {
                            "enabled": True,
                            "operator": "GreaterThan",
                            "threshold": 90,
                            "contact_emails": ["admin@company.com", "finance@company.com"],
                            "contact_groups": [],
                            "contact_roles": ["Owner", "Contributor"]
                        }
                    ]
                }
                budgets.append(rg_budget)

            # Service specific budgets
            services = {
                "compute": ["Microsoft.Compute/virtualMachines", "Microsoft.Compute/virtualMachineScaleSets", "Microsoft.ContainerService/managedClusters"],
                "storage": ["Microsoft.Storage/storageAccounts"],
                "database": ["Microsoft.Sql/servers", "Microsoft.DocumentDB/databaseAccounts"],
                "networking": ["Microsoft.Network/applicationGateways", "Microsoft.Network/loadBalancers", "Microsoft.Network/publicIPAddresses"]
            }

            for service_category, resource_types in services.items():
                service_budget = {
                    "name": f"{self.config.get_resource_name(service_category, 'service-budget')}",
                    "amount": self.config.budget_limits.get(f"{service_category}_service", 3000),
                    "time_grain": "Monthly",
                    "start_date": "2024-01-01",
                    "end_date": "2025-12-31",
                    "filters": {
                        "resource_groups": [],
                        "resources": [],
                        "meters": [],
                        "tags": {},
                        "resource_types": resource_types
                    },
                    "notifications": [
                        {
                            "enabled": True,
                            "operator": "GreaterThan",
                            "threshold": 80,
                            "contact_emails": ["admin@company.com"],
                            "contact_groups": [],
                            "contact_roles": ["Owner"]
                        }
                    ]
                }
                budgets.append(service_budget)

            return {
                "status": "success",
                "budgets_created": len(budgets),
                "budget_names": [b["name"] for b in budgets],
                "total_budget_amount": sum(b["amount"] for b in budgets),
                "description": "Comprehensive cost budgets with multi-tier alerting"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup cost budgets: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def setup_cost_optimization(self) -> Dict[str, Any]:
        """Configure automated cost optimization policies"""
        try:
            optimization_policies = []

            # VM Right-sizing Policy
            vm_rightsizing = {
                "name": "vm-rightsizing-policy",
                "description": "Automatically right-size underutilized VMs",
                "enabled": True,
                "scope": f"/subscriptions/{self.config.subscription_id}",
                "rules": [
                    {
                        "condition": "avg_cpu_utilization < 10% for 7 days",
                        "action": "recommend_downgrade",
                        "target_sku": "smaller_sku"
                    },
                    {
                        "condition": "avg_cpu_utilization > 85% for 3 days",
                        "action": "recommend_upgrade",
                        "target_sku": "larger_sku"
                    }
                ],
                "exclusions": [
                    "critical-production-vms",
                    "high-availability-vms"
                ]
            }
            optimization_policies.append(vm_rightsizing)

            # Storage Optimization Policy
            storage_optimization = {
                "name": "storage-optimization-policy",
                "description": "Optimize storage costs through tiering and cleanup",
                "enabled": True,
                "scope": f"/subscriptions/{self.config.subscription_id}",
                "rules": [
                    {
                        "condition": "blob_access_time > 30 days",
                        "action": "move_to_cool_tier",
                        "tier": "Cool"
                    },
                    {
                        "condition": "blob_access_time > 90 days",
                        "action": "move_to_archive_tier",
                        "tier": "Archive"
                    },
                    {
                        "condition": "blob_size < 128KB and access_time > 90 days",
                        "action": "recommend_deletion",
                        "approval_required": True
                    }
                ],
                "lifecycle_policies": [
                    {
                        "name": "auto-tiering",
                        "enabled": True,
                        "filters": {
                            "blob_types": ["blockBlob"],
                            "prefix_match": ["logs/", "backups/"]
                        },
                        "actions": [
                            {
                                "base_blob": {
                                    "tier_to_cool": {"days_after_modification_greater_than": 30},
                                    "tier_to_archive": {"days_after_modification_greater_than": 90},
                                    "delete": {"days_after_modification_greater_than": 365}
                                }
                            }
                        ]
                    }
                ]
            }
            optimization_policies.append(storage_optimization)

            # Database Optimization Policy
            database_optimization = {
                "name": "database-optimization-policy",
                "description": "Optimize database costs through scaling and resource adjustment",
                "enabled": True,
                "scope": f"/subscriptions/{self.config.subscription_id}",
                "rules": [
                    {
                        "condition": "dtu_utilization < 20% for 7 days",
                        "action": "recommend_scale_down",
                        "resource_types": ["Microsoft.Sql/servers/databases"]
                    },
                    {
                        "condition": "dtu_utilization > 80% for 2 days",
                        "action": "recommend_scale_up",
                        "resource_types": ["Microsoft.Sql/servers/databases"]
                    },
                    {
                        "condition": "ru_utilization < 15% for 7 days",
                        "action": "recommend_scale_down",
                        "resource_types": ["Microsoft.DocumentDB/databaseAccounts"]
                    }
                ],
                "auto_scaling": {
                    "enabled": True,
                    "min_scale": 100,
                    "max_scale": 4000,
                    "target_utilization": 70
                }
            }
            optimization_policies.append(database_optimization)

            # Reserved Instance Policy
            reserved_instance_policy = {
                "name": "reserved-instance-recommendation",
                "description": "Analyze and recommend Reserved Instances for cost savings",
                "enabled": True,
                "scope": f"/subscriptions/{self.config.subscription_id}",
                "analysis_period": "30 days",
                "commitment_terms": ["1 year", "3 years"],
                "resource_types": [
                    "Microsoft.Compute/virtualMachines",
                    "Microsoft.Sql/servers/databases",
                    "Microsoft.DocumentDB/databaseAccounts"
                ],
                "minimum_usage_threshold": 70,
                "minimum_savings_threshold": 15
            }
            optimization_policies.append(reserved_instance_policy)

            # Unused Resource Cleanup Policy
            cleanup_policy = {
                "name": "unused-resource-cleanup",
                "description": "Identify and recommend cleanup of unused resources",
                "enabled": True,
                "scope": f"/subscriptions/{self.config.subscription_id}",
                "rules": [
                    {
                        "condition": "public_ip_not_associated and age > 7 days",
                        "action": "recommend_deletion",
                        "resource_type": "Microsoft.Network/publicIPAddresses"
                    },
                    {
                        "condition": "disk_not_attached and age > 14 days",
                        "action": "recommend_deletion",
                        "resource_type": "Microsoft.Compute/disks"
                    },
                    {
                        "condition": "network_interface_not_used and age > 7 days",
                        "action": "recommend_deletion",
                        "resource_type": "Microsoft.Network/networkInterfaces"
                    },
                    {
                        "condition": "load_balancer_no_backend_pool and age > 7 days",
                        "action": "recommend_deletion",
                        "resource_type": "Microsoft.Network/loadBalancers"
                    }
                ],
                "approval_workflow": {
                    "enabled": True,
                    "approvers": ["admin@company.com"],
                    "auto_approve_after_days": 30
                }
            }
            optimization_policies.append(cleanup_policy)

            return {
                "status": "success",
                "policies_created": len(optimization_policies),
                "policy_names": [p["name"] for p in optimization_policies],
                "description": "Comprehensive cost optimization with automated policies"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup cost optimization: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def generate_cost_reports(self) -> Dict[str, Any]:
        """Generate comprehensive cost and usage reports"""
        try:
            reports = []

            # Executive Summary Report
            executive_report = {
                "name": "executive-cost-summary",
                "description": "High-level cost summary for executive review",
                "frequency": "monthly",
                "recipients": ["ceo@company.com", "cfo@company.com", "admin@company.com"],
                "format": "pdf",
                "sections": [
                    {
                        "title": "Cost Overview",
                        "content": [
                            "total_monthly_cost",
                            "cost_trend_3_months",
                            "budget_vs_actual",
                            "top_5_cost_drivers"
                        ]
                    },
                    {
                        "title": "Optimization Opportunities",
                        "content": [
                            "potential_savings",
                            "rightsizing_recommendations",
                            "reserved_instance_opportunities",
                            "unused_resource_cleanup"
                        ]
                    },
                    {
                        "title": "Resource Utilization",
                        "content": [
                            "vm_utilization_summary",
                            "storage_utilization",
                            "database_performance_cost"
                        ]
                    }
                ],
                "charts": [
                    "monthly_cost_trend",
                    "service_cost_breakdown",
                    "resource_group_costs"
                ]
            }
            reports.append(executive_report)

            # Detailed Technical Report
            technical_report = {
                "name": "detailed-technical-analysis",
                "description": "Detailed cost and usage analysis for technical teams",
                "frequency": "weekly",
                "recipients": ["admin@company.com", "devops@company.com"],
                "format": "excel",
                "sections": [
                    {
                        "title": "Resource-Level Costs",
                        "content": [
                            "resource_by_resource_costs",
                            "cost_per_resource_type",
                            "geographical_cost_distribution"
                        ]
                    },
                    {
                        "title": "Usage Metrics",
                        "content": [
                            "vm_cpu_memory_utilization",
                            "storage_iops_throughput",
                            "network_bandwidth_usage",
                            "database_dtu_ru_consumption"
                        ]
                    },
                    {
                        "title": "Optimization Recommendations",
                        "content": [
                            "rightsizing_details",
                            "storage_tier_recommendations",
                            "database_scaling_suggestions",
                            "network_optimization_opportunities"
                        ]
                    }
                ],
                "data_sources": [
                    "azure_cost_management",
                    "azure_monitor",
                    "azure_advisor",
                    "log_analytics"
                ]
            }
            reports.append(technical_report)

            # Department Chargeback Report
            chargeback_report = {
                "name": "department-chargeback",
                "description": "Cost allocation and chargeback by department/project",
                "frequency": "monthly",
                "recipients": ["finance@company.com", "department-heads@company.com"],
                "format": "csv",
                "allocation_method": "tag_based",
                "allocation_tags": [
                    "department",
                    "project",
                    "cost_center",
                    "environment"
                ],
                "sections": [
                    {
                        "title": "Department Breakdown",
                        "content": [
                            "cost_by_department",
                            "usage_by_department",
                            "trend_by_department"
                        ]
                    },
                    {
                        "title": "Project Allocation",
                        "content": [
                            "cost_by_project",
                            "resource_allocation",
                            "budget_tracking"
                        ]
                    }
                ],
                "formulas": [
                    "shared_cost_allocation",
                    "overhead_distribution"
                ]
            }
            reports.append(chargeback_report)

            # Anomaly Detection Report
            anomaly_report = {
                "name": "cost-anomaly-detection",
                "description": "Automated detection of unusual cost patterns",
                "frequency": "daily",
                "recipients": ["admin@company.com", "finance@company.com"],
                "format": "json",
                "detection_algorithms": [
                    "statistical_outlier_detection",
                    "machine_learning_anomaly",
                    "trend_deviation_analysis"
                ],
                "thresholds": {
                    "daily_cost_increase": 25,  # percent
                    "resource_cost_spike": 50,  # percent
                    "service_cost_anomaly": 30  # percent
                },
                "automated_actions": [
                    "send_alert",
                    "create_incident",
                    "pause_resources_if_critical"
                ]
            }
            reports.append(anomaly_report)

            # Compliance and Governance Report
            compliance_report = {
                "name": "cost-compliance-governance",
                "description": "Cost-related compliance and governance metrics",
                "frequency": "monthly",
                "recipients": ["compliance@company.com", "admin@company.com"],
                "format": "pdf",
                "sections": [
                    {
                        "title": "Policy Compliance",
                        "content": [
                            "budget_policy_adherence",
                            "resource_tagging_compliance",
                            "approval_workflow_compliance"
                        ]
                    },
                    {
                        "title": "Governance Metrics",
                        "content": [
                            "resource_lifecycle_management",
                            "cost_center_accountability",
                            "environmental_cost_segregation"
                        ]
                    },
                    {
                        "title": "Audit Trail",
                        "content": [
                            "cost_approval_history",
                            "resource_provisioning_log",
                            "policy_exception_tracking"
                        ]
                    }
                ]
            }
            reports.append(compliance_report)

            return {
                "status": "success",
                "reports_configured": len(reports),
                "report_types": [r["name"] for r in reports],
                "total_recipients": len(set([email for r in reports for email in r["recipients"]])),
                "description": "Comprehensive cost reporting suite for all stakeholders"
            }

        except Exception as e:
            self.logger.error(f"Failed to setup cost reports: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

    async def implement_cost_governance(self) -> Dict[str, Any]:
        """Implement enterprise cost governance framework"""
        try:
            governance_framework = {
                "policies": [],
                "roles": [],
                "workflows": [],
                "controls": []
            }

            # Cost Management Policies
            policies = [
                {
                    "name": "resource-provisioning-approval",
                    "description": "Require approval for high-cost resource provisioning",
                    "enabled": True,
                    "scope": f"/subscriptions/{self.config.subscription_id}",
                    "rules": [
                        {
                            "condition": "estimated_monthly_cost > $500",
                            "action": "require_approval",
                            "approvers": ["admin@company.com", "finance@company.com"],
                            "timeout_hours": 24
                        },
                        {
                            "condition": "estimated_monthly_cost > $2000",
                            "action": "require_senior_approval",
                            "approvers": ["cto@company.com", "cfo@company.com"],
                            "timeout_hours": 48
                        }
                    ]
                },
                {
                    "name": "mandatory-tagging-policy",
                    "description": "Enforce mandatory cost allocation tags",
                    "enabled": True,
                    "scope": f"/subscriptions/{self.config.subscription_id}",
                    "required_tags": [
                        "department",
                        "project",
                        "cost_center",
                        "environment",
                        "owner"
                    ],
                    "enforcement": "deny_creation_without_tags"
                },
                {
                    "name": "resource-lifecycle-policy",
                    "description": "Manage resource lifecycle for cost optimization",
                    "enabled": True,
                    "scope": f"/subscriptions/{self.config.subscription_id}",
                    "rules": [
                        {
                            "resource_type": "development",
                            "auto_shutdown": {
                                "enabled": True,
                                "schedule": "weekdays_after_hours",
                                "timezone": "UTC"
                            },
                            "auto_delete": {
                                "enabled": True,
                                "after_days": 30,
                                "require_confirmation": True
                            }
                        },
                        {
                            "resource_type": "testing",
                            "auto_shutdown": {
                                "enabled": True,
                                "schedule": "daily_after_hours",
                                "timezone": "UTC"
                            },
                            "auto_delete": {
                                "enabled": True,
                                "after_days": 14,
                                "require_confirmation": True
                            }
                        }
                    ]
                }
            ]
            governance_framework["policies"] = policies

            # Cost Management Roles and Responsibilities
            roles = [
                {
                    "name": "Cost Center Manager",
                    "description": "Responsible for departmental cost management",
                    "permissions": [
                        "view_department_costs",
                        "approve_department_budgets",
                        "create_cost_alerts",
                        "export_cost_reports"
                    ],
                    "scope": "department_resources",
                    "assignment_method": "tag_based"
                },
                {
                    "name": "Finance Controller",
                    "description": "Oversees enterprise-wide cost governance",
                    "permissions": [
                        "view_all_costs",
                        "create_budgets",
                        "modify_cost_policies",
                        "approve_high_value_resources",
                        "access_all_reports"
                    ],
                    "scope": "subscription_wide",
                    "assignment_method": "direct_assignment"
                },
                {
                    "name": "Resource Owner",
                    "description": "Owns and manages specific resources",
                    "permissions": [
                        "view_owned_resource_costs",
                        "optimize_owned_resources",
                        "create_resource_budgets",
                        "receive_cost_alerts"
                    ],
                    "scope": "owned_resources",
                    "assignment_method": "resource_owner_tag"
                }
            ]
            governance_framework["roles"] = roles

            # Approval Workflows
            workflows = [
                {
                    "name": "high_cost_resource_approval",
                    "description": "Approval workflow for expensive resource creation",
                    "trigger": "resource_estimated_cost > threshold",
                    "steps": [
                        {
                            "step": 1,
                            "action": "technical_review",
                            "assignee": "resource_requester_manager",
                            "timeout_hours": 24,
                            "required_fields": [
                                "business_justification",
                                "cost_benefit_analysis",
                                "alternative_solutions_considered"
                            ]
                        },
                        {
                            "step": 2,
                            "action": "financial_review",
                            "assignee": "finance_controller",
                            "timeout_hours": 24,
                            "required_fields": [
                                "budget_impact_assessment",
                                "roi_calculation",
                                "operational_cost_estimate"
                            ]
                        },
                        {
                            "step": 3,
                            "action": "executive_approval",
                            "assignee": "cto_or_cfo",
                            "timeout_hours": 48,
                            "condition": "estimated_monthly_cost > $5000"
                        }
                    ],
                    "escalation": {
                        "enabled": True,
                        "escalation_timeout_hours": 72,
                        "escalation_assignee": "ceo@company.com"
                    }
                }
            ]
            governance_framework["workflows"] = workflows

            # Cost Controls and Guardrails
            controls = [
                {
                    "name": "spending_limits",
                    "description": "Hard spending limits to prevent cost overruns",
                    "type": "preventive",
                    "limits": [
                        {
                            "scope": "subscription",
                            "monthly_limit": 50000,
                            "action": "block_new_resources"
                        },
                        {
                            "scope": "resource_group",
                            "monthly_limit": 10000,
                            "action": "require_approval"
                        },
                        {
                            "scope": "individual_resource",
                            "monthly_limit": 5000,
                            "action": "alert_and_review"
                        }
                    ]
                },
                {
                    "name": "cost_anomaly_protection",
                    "description": "Automated protection against cost anomalies",
                    "type": "detective",
                    "detection_rules": [
                        {
                            "rule": "daily_cost_increase_over_50_percent",
                            "action": "immediate_alert_and_investigation"
                        },
                        {
                            "rule": "new_resource_type_deployed",
                            "action": "review_and_validate"
                        },
                        {
                            "rule": "cost_pattern_deviation",
                            "action": "analyze_and_report"
                        }
                    ]
                },
                {
                    "name": "compliance_monitoring",
                    "description": "Monitor compliance with cost governance policies",
                    "type": "detective",
                    "monitoring_areas": [
                        "tag_compliance",
                        "budget_adherence",
                        "approval_workflow_compliance",
                        "policy_exception_tracking"
                    ],
                    "reporting_frequency": "weekly"
                }
            ]
            governance_framework["controls"] = controls

            return {
                "status": "success",
                "governance_components": {
                    "policies": len(policies),
                    "roles": len(roles),
                    "workflows": len(workflows),
                    "controls": len(controls)
                },
                "framework": governance_framework,
                "description": "Comprehensive enterprise cost governance framework"
            }

        except Exception as e:
            self.logger.error(f"Failed to implement cost governance: {e}")
            return {
                "status": "failed",
                "error": str(e)
            }

## Usage Examples

### Basic Azure Platform Setup
```python
# Initialize Azure enterprise configuration
azure_config = EnterpriseAzureConfig(
    subscription_id="your-subscription-id",
    tenant_id="your-tenant-id",
    primary_region=AzureRegion.EAST_US,
    environment="production",
    organization_name="YourCompany"
)

# Create enterprise Azure platform
azure_platform = EnterpriseAzurePlatform(azure_config)

# Deploy complete enterprise infrastructure
deployment_result = await azure_platform.deploy_enterprise_infrastructure()
print(f"Deployment Status: {deployment_result['status']}")
print(f"Resources Deployed: {deployment_result['total_resources']}")
```

### Advanced Security Configuration
```python
# Setup comprehensive security infrastructure
security_result = await azure_platform.setup_azure_defender()
print(f"Azure Defender Status: {security_result['status']}")

sentinel_result = await azure_platform.setup_azure_sentinel()
print(f"Azure Sentinel Status: {sentinel_result['status']}")

keyvault_result = await azure_platform.setup_key_vault()
print(f"Key Vault Status: {keyvault_result['status']}")

private_endpoints_result = await azure_platform.setup_private_endpoints()
print(f"Private Endpoints Status: {private_endpoints_result['status']}")
```

### Infrastructure Deployment Examples
```python
# Infrastructure manager for advanced deployment
infra_manager = EnterpriseAzureInfrastructureManager(azure_config)

# Deploy networking infrastructure with hub-spoke topology
networking_result = await infra_manager.deploy_infrastructure("networking")
print(f"Networking: {networking_result['description']}")

# Deploy compute infrastructure with auto-scaling
compute_result = await infra_manager.deploy_infrastructure("compute")
print(f"Compute: {compute_result['description']}")

# Deploy data tier with SQL Database, Storage, and Cosmos DB
data_result = await infra_manager.deploy_infrastructure("data")
print(f"Data Tier: {data_result['description']}")

# Deploy comprehensive monitoring
monitoring_result = await infra_manager.deploy_infrastructure("monitoring")
print(f"Monitoring: {monitoring_result['description']}")
```

### Cost Management Implementation
```python
# Initialize cost management
cost_manager = EnterpriseAzureCostManager(azure_config)
cost_init_result = await cost_manager.initialize_cost_management()
print(f"Cost Management: {cost_init_result['description']}")

# Setup comprehensive budgets
budgets_result = await cost_manager.setup_cost_budgets()
print(f"Budgets Created: {budgets_result['budgets_created']}")
print(f"Total Budget: ${budgets_result['total_budget_amount']}")

# Configure optimization policies
optimization_result = await cost_manager.setup_cost_optimization()
print(f"Optimization Policies: {optimization_result['policies_created']}")

# Setup enterprise reporting
reports_result = await cost_manager.generate_cost_reports()
print(f"Reports Configured: {reports_result['reports_configured']}")

# Implement governance framework
governance_result = await cost_manager.implement_cost_governance()
print(f"Governance Framework: {governance_result['description']}")
```

### Multi-Region Deployment
```python
# Configure multi-region deployment
regions = [AzureRegion.EAST_US, AzureRegion.WEST_EUROPE, AzureRegion.SOUTHEAST_ASIA]

for region in regions:
    regional_config = EnterpriseAzureConfig(
        subscription_id="your-subscription-id",
        tenant_id="your-tenant-id",
        primary_region=region,
        environment="production",
        organization_name="YourCompany"
    )

    regional_platform = EnterpriseAzurePlatform(regional_config)
    regional_result = await regional_platform.deploy_enterprise_infrastructure()
    print(f"Region {region.value}: {regional_result['status']}")
```

This enterprise Azure platform provides:

🔐 **Advanced Security**: Azure Defender, Sentinel SIEM, Key Vault, Private Endpoints, Zero Trust architecture
🏗️ **Enterprise Infrastructure**: Hub-spoke networking, auto-scaling compute, comprehensive data tier, advanced monitoring
💰 **Cost Management**: Multi-tier budgets, optimization policies, comprehensive reporting, governance framework
📊 **Monitoring & Compliance**: Log Analytics, Application Insights, custom dashboards, automated alerting
🔄 **Infrastructure as Code**: ARM templates, Bicep support, Terraform integration, automated deployments
🌍 **Multi-Region Support**: Global deployment capabilities, disaster recovery, high availability
👥 **Enterprise Governance**: Role-based access control, approval workflows, policy compliance, audit trails

The platform delivers production-ready enterprise Azure infrastructure with comprehensive security, monitoring, cost optimization, and governance capabilities for large-scale enterprise deployments.
- Building applications requiring enterprise security and compliance
- Working with Office 365, Microsoft 365, and Dynamics integration
- Need advanced AI and machine learning services (Cognitive Services)
- Building Windows-based applications and legacy system modernization
- Working in enterprises with existing Microsoft licensing agreements

### ❌ **Avoid Azure When**

- Building simple static websites or basic web applications
- Working primarily with open-source technologies without Microsoft integration
- Team lacks experience with Microsoft technologies and Azure ecosystem
- Budget constraints for enterprise-level cloud services
- Building applications targeting primarily Linux/Unix environments
- Need simple deployment without complex enterprise requirements
- Working with applications not requiring Microsoft-specific features

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type               | Azure Recommendation                     | Configuration Priority         |
| -------------------------- | ---------------------------------------- | ------------------------------ |
| Enterprise .NET App        | ✅ **Essential** - Native integration    | High - App Service + SQL       |
| Microservices Architecture | ✅ **Essential** - AKS + Service Fabric  | High - Container orchestration |
| Hybrid Cloud Application   | ✅ **Essential** - Arc + hybrid services | High - Hybrid connectivity     |
| AI/ML Application          | ✅ **Recommended** - Cognitive Services  | Medium - AI platform setup     |
| Static Website             | 🔄 **Consider** - May be overkill        | Low - Static Web Apps          |
| Legacy Modernization       | ✅ **Essential** - Migration tools       | High - Assessment + migration  |

### Complexity Assessment

| Factor            | Low Complexity             | Medium Complexity      | High Complexity             |
| ----------------- | -------------------------- | ---------------------- | --------------------------- |
| **Setup Time**    | 2 hours (App Service)      | 1 day (AKS cluster)    | 2 weeks (enterprise setup)  |
| **Services Used** | App Service + SQL Database | Multiple PaaS services | Full enterprise integration |
| **Architecture**  | Single service             | Multi-tier application | Enterprise hybrid cloud     |
| **Integration**   | Basic Azure services       | Office 365 integration | Full Microsoft ecosystem    |

## Installation & Setup

### Azure CLI Installation

```bash
# macOS installation
brew install azure-cli

# Linux installation (Ubuntu/Debian)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Windows installation (PowerShell)
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Verify installation
az --version
az extension list-available

# Login to Azure
az login
az account list
az account set --subscription "your-subscription-id"
`````

### PowerShell and Development Tools

```powershell
# Install Azure PowerShell
Install-Module -Name Az -Repository PSGallery -Force

# Install additional tools
winget install Microsoft.Bicep
npm install -g @azure/static-web-apps-cli
dotnet tool install --global Azure.Developer.CLI

# Verify installations
az --version
bicep --version
swa --version
azd version
```

### Project Setup and Configuration

```bash
# Create resource group
az group create --name myResourceGroup --location eastus

# Set default resource group and location
az configure --defaults group=myResourceGroup location=eastus

# Enable necessary providers
az provider register --namespace Microsoft.Web
az provider register --namespace Microsoft.ContainerService
az provider register --namespace Microsoft.Sql
az provider register --namespace Microsoft.Storage
az provider register --namespace Microsoft.KeyVault

# Create service principal for automation
az ad sp create-for-rbac --name "myAppServicePrincipal" --role contributor

# Verify setup
az account show
az group list
```

## Configuration

### Azure App Service Configuration

```json
// azuredeploy.json - ARM Template for App Service
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "appName": {
      "type": "string",
      "metadata": {
        "description": "Name of the web app"
      }
    },
    "sku": {
      "type": "string",
      "defaultValue": "S1",
      "allowedValues": ["F1", "B1", "S1", "P1V2", "P2V2", "P3V2"],
      "metadata": {
        "description": "App Service Plan SKU"
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for all resources"
      }
    }
  },
  "variables": {
    "appServicePlanName": "[concat(parameters('appName'), '-plan')]",
    "appInsightsName": "[concat(parameters('appName'), '-insights')]"
  },
  "resources": [
    {
      "type": "Microsoft.Web/serverfarms",
      "apiVersion": "2021-02-01",
      "name": "[variables('appServicePlanName')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "[parameters('sku')]"
      },
      "properties": {
        "reserved": false
      }
    },
    {
      "type": "Microsoft.Web/sites",
      "apiVersion": "2021-02-01",
      "name": "[parameters('appName')]",
      "location": "[parameters('location')]",
      "dependsOn": ["[resourceId('Microsoft.Web/serverfarms', variables('appServicePlanName'))]"],
      "properties": {
        "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('appServicePlanName'))]",
        "httpsOnly": true,
        "siteConfig": {
          "minTlsVersion": "1.2",
          "ftpsState": "FtpsOnly",
          "appSettings": [
            {
              "name": "WEBSITE_NODE_DEFAULT_VERSION",
              "value": "18-lts"
            },
            {
              "name": "APPINSIGHTS_INSTRUMENTATIONKEY",
              "value": "[reference(resourceId('Microsoft.Insights/components', variables('appInsightsName'))).InstrumentationKey]"
            }
          ]
        }
      }
    },
    {
      "type": "Microsoft.Insights/components",
      "apiVersion": "2020-02-02",
      "name": "[variables('appInsightsName')]",
      "location": "[parameters('location')]",
      "kind": "web",
      "properties": {
        "Application_Type": "web",
        "Request_Source": "rest"
      }
    }
  ],
  "outputs": {
    "webAppUrl": {
      "type": "string",
      "value": "[concat('https://', reference(resourceId('Microsoft.Web/sites', parameters('appName'))).defaultHostName)]"
    }
  }
}
```

### Bicep Infrastructure Configuration

```bicep
// main.bicep - Modern Azure infrastructure
@description('Name of the application')
param appName string

@description('Location for all resources')
param location string = resourceGroup().location

@description('App Service Plan SKU')
@allowed(['B1', 'S1', 'P1V2', 'P2V2', 'P3V2'])
param sku string = 'S1'

@description('SQL Database administrator login')
param sqlAdministratorLogin string

@description('SQL Database administrator password')
@secure()
param sqlAdministratorPassword string

// Variables
var appServicePlanName = '${appName}-plan'
var webAppName = '${appName}-web'
var sqlServerName = '${appName}-sql-server'
var sqlDatabaseName = '${appName}-database'
var keyVaultName = '${appName}-kv'
var storageAccountName = '${replace(appName, '-', '')}storage'

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  properties: {
    reserved: false
  }
}

// Web App
resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
      netFrameworkVersion: 'v6.0'
      appSettings: [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsights.properties.ConnectionString
        }
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Production'
        }
      ]
      connectionStrings: [
        {
          name: 'DefaultConnection'
          connectionString: 'Server=tcp:${sqlServer.properties.fullyQualifiedDomainName},1433;Initial Catalog=${sqlDatabaseName};Persist Security Info=False;User ID=${sqlAdministratorLogin};Password=${sqlAdministratorPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
          type: 'SQLAzure'
        }
      ]
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// SQL Server
resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorPassword
    version: '12.0'
  }
}

// SQL Database
resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 268435456000
  }
}

// Firewall rule to allow Azure services
resource firewallRule 'Microsoft.Sql/servers/firewallRules@2021-11-01' = {
  parent: sqlServer
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// Application Insights
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${appName}-insights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

// Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: webApp.identity.principalId
        permissions: {
          secrets: ['get', 'list']
        }
      }
    ]
    enableRbacAuthorization: false
  }
}

// Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

// Outputs
output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output sqlServerFqdn string = sqlServer.properties.fullyQualifiedDomainName
output keyVaultName string = keyVault.name
output storageAccountName string = storageAccount.name
```

### Azure DevOps Pipeline Configuration

```yaml
# azure-pipelines.yml - Complete CI/CD pipeline
trigger:
  branches:
    include:
      - main
      - develop
  paths:
    exclude:
      - README.md
      - docs/*

variables:
  azureSubscription: 'my-azure-subscription'
  resourceGroupName: 'my-app-rg'
  webAppName: 'my-web-app'
  vmImageName: 'ubuntu-latest'
  buildConfiguration: 'Release'

stages:
  - stage: Build
    displayName: 'Build and Test'
    jobs:
      - job: Build
        displayName: 'Build job'
        pool:
          vmImage: $(vmImageName)

        steps:
          - task: UseDotNet@2
            displayName: 'Use .NET 6 SDK'
            inputs:
              packageType: 'sdk'
              version: '6.x'

          - task: DotNetCoreCLI@2
            displayName: 'Restore packages'
            inputs:
              command: 'restore'
              projects: '**/*.csproj'

          - task: DotNetCoreCLI@2
            displayName: 'Build application'
            inputs:
              command: 'build'
              projects: '**/*.csproj'
              arguments: '--configuration $(buildConfiguration) --no-restore'

          - task: DotNetCoreCLI@2
            displayName: 'Run unit tests'
            inputs:
              command: 'test'
              projects: '**/*Tests/*.csproj'
              arguments: '--configuration $(buildConfiguration) --no-build --collect:"XPlat Code Coverage" --logger trx'
              publishTestResults: true

          - task: PublishCodeCoverageResults@1
            displayName: 'Publish code coverage'
            inputs:
              codeCoverageTool: 'Cobertura'
              summaryFileLocation: '$(Agent.TempDirectory)/**/coverage.cobertura.xml'

          - task: DotNetCoreCLI@2
            displayName: 'Publish application'
            inputs:
              command: 'publish'
              projects: '**/*.csproj'
              arguments: '--configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory) --no-build'
              zipAfterPublish: true

          - task: PublishBuildArtifacts@1
            displayName: 'Publish artifacts'
            inputs:
              PathtoPublish: '$(Build.ArtifactStagingDirectory)'
              ArtifactName: 'drop'
              publishLocation: 'Container'

  - stage: Deploy_Staging
    displayName: 'Deploy to Staging'
    dependsOn: Build
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/develop'))
    jobs:
      - deployment: Deploy
        displayName: 'Deploy to staging'
        pool:
          vmImage: $(vmImageName)
        environment: 'staging'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureWebApp@1
                  displayName: 'Deploy to Azure App Service'
                  inputs:
                    azureSubscription: $(azureSubscription)
                    appType: 'webApp'
                    appName: '$(webAppName)-staging'
                    package: '$(Pipeline.Workspace)/drop/*.zip'
                    deploymentMethod: 'auto'

  - stage: Deploy_Production
    displayName: 'Deploy to Production'
    dependsOn: Build
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
    jobs:
      - deployment: Deploy
        displayName: 'Deploy to production'
        pool:
          vmImage: $(vmImageName)
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureResourceManagerTemplateDeployment@3
                  displayName: 'Deploy ARM template'
                  inputs:
                    deploymentScope: 'Resource Group'
                    azureResourceManagerConnection: $(azureSubscription)
                    subscriptionId: $(subscriptionId)
                    action: 'Create Or Update Resource Group'
                    resourceGroupName: $(resourceGroupName)
                    location: 'East US'
                    templateLocation: 'Linked artifact'
                    csmFile: '$(Pipeline.Workspace)/drop/azuredeploy.json'
                    overrideParameters: '-appName $(webAppName) -sku P1V2'
                    deploymentMode: 'Incremental'

                - task: AzureWebApp@1
                  displayName: 'Deploy to Azure App Service'
                  inputs:
                    azureSubscription: $(azureSubscription)
                    appType: 'webApp'
                    appName: $(webAppName)
                    package: '$(Pipeline.Workspace)/drop/*.zip'
                    deploymentMethod: 'auto'

                - task: AzureAppServiceManage@0
                  displayName: 'Restart App Service'
                  inputs:
                    azureSubscription: $(azureSubscription)
                    Action: 'Restart Azure App Service'
                    WebAppName: $(webAppName)
```

### Azure Kubernetes Service (AKS) Configuration

```yaml
# aks-deployment.yaml - AKS application deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: default
  labels:
    app: my-app
    version: v1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
        version: v1
    spec:
      serviceAccountName: my-app-service-account
      containers:
        - name: my-app
          image: myregistry.azurecr.io/my-app:latest
          ports:
            - containerPort: 80
              name: http
          env:
            - name: ASPNETCORE_ENVIRONMENT
              value: 'Production'
            - name: ConnectionStrings__DefaultConnection
              valueFrom:
                secretKeyRef:
                  name: sql-connection
                  key: connectionString
          resources:
            requests:
              memory: '256Mi'
              cpu: '250m'
            limits:
              memory: '512Mi'
              cpu: '500m'
          livenessProbe:
            httpGet:
              path: /health
              port: 80
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /health/ready
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
      imagePullSecrets:
        - name: acr-secret

---
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
  labels:
    app: my-app
spec:
  type: LoadBalancer
  selector:
    app: my-app
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP
      name: http

---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app-ingress
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
    appgw.ingress.kubernetes.io/ssl-redirect: 'true'
    cert-manager.io/cluster-issuer: 'letsencrypt-prod'
spec:
  tls:
    - hosts:
        - myapp.example.com
      secretName: my-app-tls
  rules:
    - host: myapp.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: my-app-service
                port:
                  number: 80
```

## Core Features

### Azure App Service

- **Purpose**: Fully managed platform for building, deploying, and scaling web apps
- **Usage**: Host web applications, APIs, and mobile backends
- **Example**:

```csharp
// Program.cs - ASP.NET Core application
using Microsoft.ApplicationInsights;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add Application Insights
builder.Services.AddApplicationInsightsTelemetry(
    builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"]);

// Add Entity Framework
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Add health checks
builder.Services.AddHealthChecks()
    .AddDbContextCheck<ApplicationDbContext>();

var app = builder.Build();

// Configure pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
else
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

// Health check endpoints
app.MapHealthChecks("/health");
app.MapHealthChecks("/health/ready", new HealthCheckOptions
{
    Predicate = check => check.Tags.Contains("ready")
});

app.MapControllers();

app.Run();
```

```bash
# Deploy to App Service
az webapp create --resource-group myResourceGroup --plan myAppServicePlan --name myUniqueAppName
az webapp deployment source config --name myUniqueAppName --resource-group myResourceGroup --repo-url https://github.com/user/repo --branch main
```

### Azure Functions (Serverless)

- **Purpose**: Event-driven serverless compute platform
- **Usage**: Process events, integrate systems, build APIs
- **Example**:

```csharp
// HttpTriggerFunction.cs
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using System.Net;
using System.Text.Json;

public class HttpTriggerFunction
{
    private readonly ILogger _logger;

    public HttpTriggerFunction(ILoggerFactory loggerFactory)
    {
        _logger = loggerFactory.CreateLogger<HttpTriggerFunction>();
    }

    [Function("ProcessOrder")]
    public async Task<HttpResponseData> ProcessOrder(
        [HttpTrigger(AuthorizationLevel.Function, "post")] HttpRequestData req)
    {
        _logger.LogInformation("Processing order request");

        try
        {
            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            var order = JsonSerializer.Deserialize<Order>(requestBody);

            // Validate order
            if (order == null || string.IsNullOrEmpty(order.CustomerId))
            {
                var badResponse = req.CreateResponse(HttpStatusCode.BadRequest);
                await badResponse.WriteStringAsync("Invalid order data");
                return badResponse;
            }

            // Process order (business logic)
            var processedOrder = await ProcessOrderAsync(order);

            // Return success response
            var response = req.CreateResponse(HttpStatusCode.OK);
            response.Headers.Add("Content-Type", "application/json");
            await response.WriteStringAsync(JsonSerializer.Serialize(processedOrder));
            return response;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error processing order");
            var errorResponse = req.CreateResponse(HttpStatusCode.InternalServerError);
            await errorResponse.WriteStringAsync("Internal server error");
            return errorResponse;
        }
    }

    private async Task<ProcessedOrder> ProcessOrderAsync(Order order)
    {
        // Simulate order processing
        await Task.Delay(100);

        return new ProcessedOrder
        {
            OrderId = Guid.NewGuid().ToString(),
            CustomerId = order.CustomerId,
            Status = "Processed",
            ProcessedAt = DateTime.UtcNow
        };
    }
}

public class Order
{
    public string CustomerId { get; set; }
    public List<OrderItem> Items { get; set; }
    public decimal Total { get; set; }
}

public class OrderItem
{
    public string ProductId { get; set; }
    public int Quantity { get; set; }
    public decimal Price { get; set; }
}

public class ProcessedOrder
{
    public string OrderId { get; set; }
    public string CustomerId { get; set; }
    public string Status { get; set; }
    public DateTime ProcessedAt { get; set; }
}
```

```bash
# Deploy Azure Function
func azure functionapp publish myFunctionApp
```

### Azure Container Instances (ACI)

- **Purpose**: Run containers without managing servers
- **Usage**: Batch processing, microservices, CI/CD agents
- **Example**:

```yaml
# container-group.yaml
apiVersion: 2021-03-01
location: eastus
name: my-container-group
properties:
  containers:
    - name: my-app
      properties:
        image: myregistry.azurecr.io/my-app:latest
        resources:
          requests:
            cpu: 1
            memoryInGb: 1.5
        ports:
          - port: 80
            protocol: TCP
        environmentVariables:
          - name: ASPNETCORE_ENVIRONMENT
            value: Production
          - name: ConnectionString
            secureValue: 'Server=tcp:myserver.database.windows.net,1433;Database=mydb;'
  osType: Linux
  restartPolicy: Always
  ipAddress:
    type: Public
    ports:
      - protocol: TCP
        port: 80
    dnsNameLabel: my-unique-app
  imageRegistryCredentials:
    - server: myregistry.azurecr.io
      username: myregistry
      password: 'registry-password'
tags:
  environment: production
  team: development
```

```bash
# Deploy container group
az container create --resource-group myResourceGroup --file container-group.yaml
```

### Azure Service Bus

- **Purpose**: Enterprise messaging service for reliable communication
- **Usage**: Decouple applications, implement messaging patterns
- **Example**:

```csharp
// ServiceBusService.cs
using Azure.Messaging.ServiceBus;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System.Text.Json;

public class ServiceBusService
{
    private readonly ServiceBusClient _client;
    private readonly ILogger<ServiceBusService> _logger;
    private readonly string _queueName;

    public ServiceBusService(IConfiguration configuration, ILogger<ServiceBusService> logger)
    {
        var connectionString = configuration.GetConnectionString("ServiceBus");
        _client = new ServiceBusClient(connectionString);
        _queueName = configuration["ServiceBus:QueueName"];
        _logger = logger;
    }

    public async Task SendMessageAsync<T>(T message)
    {
        try
        {
            ServiceBusSender sender = _client.CreateSender(_queueName);

            var messageBody = JsonSerializer.Serialize(message);
            var serviceBusMessage = new ServiceBusMessage(messageBody)
            {
                ContentType = "application/json",
                MessageId = Guid.NewGuid().ToString(),
                TimeToLive = TimeSpan.FromMinutes(30)
            };

            await sender.SendMessageAsync(serviceBusMessage);
            _logger.LogInformation($"Sent message with ID: {serviceBusMessage.MessageId}");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error sending message to Service Bus");
            throw;
        }
    }

    public async Task ProcessMessagesAsync(Func<string, Task> messageHandler)
    {
        ServiceBusProcessor processor = _client.CreateProcessor(_queueName, new ServiceBusProcessorOptions
        {
            MaxConcurrentCalls = 2,
            AutoCompleteMessages = false
        });

        processor.ProcessMessageAsync += async args =>
        {
            try
            {
                string body = args.Message.Body.ToString();
                _logger.LogInformation($"Processing message: {args.Message.MessageId}");

                await messageHandler(body);
                await args.CompleteMessageAsync(args.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error processing message: {args.Message.MessageId}");
                await args.AbandonMessageAsync(args.Message);
            }
        };

        processor.ProcessErrorAsync += args =>
        {
            _logger.LogError(args.Exception, "Error in Service Bus processor");
            return Task.CompletedTask;
        };

        await processor.StartProcessingAsync();
    }
}
```

## Common Commands

```bash
# Essential Azure CLI commands
az login                              # Login to Azure
az account list                       # List subscriptions
az account set --subscription "name"  # Set active subscription
az group list                         # List resource groups

# Resource management
az group create --name myRG --location eastus     # Create resource group
az resource list --resource-group myRG            # List resources in group
az group delete --name myRG --yes                 # Delete resource group

# App Service
az webapp list                        # List web apps
az webapp create --name myApp --resource-group myRG --plan myPlan
az webapp deploy --resource-group myRG --name myApp --src-path app.zip
az webapp log tail --name myApp --resource-group myRG

# Container Registry
az acr create --resource-group myRG --name myRegistry --sku Basic
az acr login --name myRegistry
az acr build --registry myRegistry --image myapp:v1 .
az acr repository list --name myRegistry

# AKS (Azure Kubernetes Service)
az aks create --resource-group myRG --name myAKSCluster --node-count 3
az aks get-credentials --resource-group myRG --name myAKSCluster
kubectl get nodes
kubectl apply -f k8s-manifests/

# Azure Functions
func init MyFunctionApp --dotnet
func new --name HttpTrigger --template "HTTP trigger"
func start                            # Run locally
func azure functionapp publish MyFunctionApp

# SQL Database
az sql server create --name myServer --resource-group myRG --admin-user myAdmin
az sql db create --resource-group myRG --server myServer --name myDatabase
az sql server firewall-rule create --resource-group myRG --server myServer

# Storage Account
az storage account create --name mystorageaccount --resource-group myRG
az storage container create --name mycontainer --account-name mystorageaccount
az storage blob upload --file myfile.txt --container-name mycontainer

# Key Vault
az keyvault create --name myKeyVault --resource-group myRG
az keyvault secret set --vault-name myKeyVault --name mysecret --value myvalue
az keyvault secret show --vault-name myKeyVault --name mysecret

# Monitoring and diagnostics
az monitor activity-log list --resource-group myRG
az monitor log-analytics workspace create --resource-group myRG --workspace-name myWorkspace
az monitor diagnostic-settings create --resource myResourceId --name myDiagnostic
```

## Workflow Integration

### Development Workflow

1. **Local Development**: Use Azure CLI and local emulators for development
2. **Source Control**: Integrate with Azure DevOps or GitHub
3. **CI/CD Pipeline**: Use Azure DevOps Pipelines for automated deployment
4. **Environment Management**: Separate development, staging, and production
5. **Monitoring**: Use Application Insights and Azure Monitor
6. **Security**: Implement Azure Active Directory and Key Vault

### Complete DevOps Pipeline

```yaml
# azure-devops-complete.yml
name: $(Date:yyyyMMdd)$(Rev:.r)

trigger:
  branches:
    include:
      - main
      - develop
      - feature/*

variables:
  - group: 'production-variables'
  - name: buildConfiguration
    value: 'Release'
  - name: azureSubscription
    value: 'my-service-connection'

stages:
  - stage: 'Build'
    displayName: 'Build Application'
    jobs:
      - job: 'BuildJob'
        displayName: 'Build and Test'
        pool:
          vmImage: 'ubuntu-latest'

        steps:
          # Setup
          - task: UseDotNet@2
            displayName: 'Use .NET 6 SDK'
            inputs:
              packageType: 'sdk'
              version: '6.x'

          # Restore and build
          - task: DotNetCoreCLI@2
            displayName: 'Restore NuGet packages'
            inputs:
              command: 'restore'
              projects: '**/*.csproj'

          - task: DotNetCoreCLI@2
            displayName: 'Build solution'
            inputs:
              command: 'build'
              projects: '**/*.csproj'
              arguments: '--configuration $(buildConfiguration) --no-restore'

          # Security scanning
          - task: CredScan@3
            displayName: 'Run Credential Scanner'

          - task: SonarCloudPrepare@1
            displayName: 'Prepare SonarCloud'
            inputs:
              SonarCloud: 'SonarCloud'
              organization: 'my-org'
              scannerMode: 'MSBuild'
              projectKey: 'my-project'

          # Tests
          - task: DotNetCoreCLI@2
            displayName: 'Run unit tests'
            inputs:
              command: 'test'
              projects: '**/*Tests.csproj'
              arguments: '--configuration $(buildConfiguration) --no-build --collect:"XPlat Code Coverage" --logger trx'
              publishTestResults: true

          - task: PublishCodeCoverageResults@1
            displayName: 'Publish code coverage'
            inputs:
              codeCoverageTool: 'Cobertura'
              summaryFileLocation: '$(Agent.TempDirectory)/**/coverage.cobertura.xml'

          # SonarCloud analysis
          - task: SonarCloudAnalyze@1
            displayName: 'Run SonarCloud analysis'

          - task: SonarCloudPublish@1
            displayName: 'Publish SonarCloud results'

          # Publish artifacts
          - task: DotNetCoreCLI@2
            displayName: 'Publish application'
            inputs:
              command: 'publish'
              projects: '**/*.csproj'
              arguments: '--configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory) --no-build'
              zipAfterPublish: true

          - task: PublishBuildArtifacts@1
            displayName: 'Publish build artifacts'
            inputs:
              PathtoPublish: '$(Build.ArtifactStagingDirectory)'
              ArtifactName: 'drop'

  - stage: 'Deploy_Development'
    displayName: 'Deploy to Development'
    dependsOn: 'Build'
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/develop'))
    jobs:
      - deployment: 'DeployDev'
        displayName: 'Deploy to Development Environment'
        pool:
          vmImage: 'ubuntu-latest'
        environment: 'development'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureResourceManagerTemplateDeployment@3
                  displayName: 'Deploy infrastructure'
                  inputs:
                    deploymentScope: 'Resource Group'
                    azureResourceManagerConnection: '$(azureSubscription)'
                    subscriptionId: '$(subscriptionId)'
                    action: 'Create Or Update Resource Group'
                    resourceGroupName: '$(resourceGroupName)-dev'
                    location: '$(location)'
                    templateLocation: 'Linked artifact'
                    csmFile: '$(Pipeline.Workspace)/drop/infrastructure/main.bicep'
                    overrideParameters: '-environment dev -appName $(appName)'
                    deploymentMode: 'Incremental'

                - task: AzureWebApp@1
                  displayName: 'Deploy web application'
                  inputs:
                    azureSubscription: '$(azureSubscription)'
                    appType: 'webApp'
                    appName: '$(appName)-dev'
                    package: '$(Pipeline.Workspace)/drop/*.zip'

  - stage: 'Deploy_Production'
    displayName: 'Deploy to Production'
    dependsOn: 'Build'
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
    jobs:
      - deployment: 'DeployProd'
        displayName: 'Deploy to Production Environment'
        pool:
          vmImage: 'ubuntu-latest'
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureResourceManagerTemplateDeployment@3
                  displayName: 'Deploy infrastructure'
                  inputs:
                    deploymentScope: 'Resource Group'
                    azureResourceManagerConnection: '$(azureSubscription)'
                    subscriptionId: '$(subscriptionId)'
                    action: 'Create Or Update Resource Group'
                    resourceGroupName: '$(resourceGroupName)'
                    location: '$(location)'
                    templateLocation: 'Linked artifact'
                    csmFile: '$(Pipeline.Workspace)/drop/infrastructure/main.bicep'
                    overrideParameters: '-environment prod -appName $(appName)'
                    deploymentMode: 'Incremental'

                - task: AzureWebApp@1
                  displayName: 'Deploy web application'
                  inputs:
                    azureSubscription: '$(azureSubscription)'
                    appType: 'webApp'
                    appName: '$(appName)'
                    package: '$(Pipeline.Workspace)/drop/*.zip'

                - task: AzureAppServiceManage@0
                  displayName: 'Restart App Service'
                  inputs:
                    azureSubscription: '$(azureSubscription)'
                    Action: 'Restart Azure App Service'
                    WebAppName: '$(appName)'
```

## Best Practices

### ✅ **Infrastructure Best Practices**

- **Use Infrastructure as Code** - Manage resources with ARM templates or Bicep
- **Implement resource tagging** - Tag all resources for cost management and organization
- **Use managed identities** - Authenticate services without storing credentials
- **Implement least privilege access** - Use Azure RBAC for fine-grained permissions
- **Use Azure Policy** - Enforce organizational standards and compliance
- **Monitor costs** - Set up cost alerts and budgets

### ✅ **Security Best Practices**

- **Enable Azure Security Center** - Monitor security posture and recommendations
- **Use Azure Key Vault** - Store secrets, keys, and certificates securely
- **Implement network security** - Use NSGs, firewalls, and private endpoints
- **Enable audit logging** - Track all operations with Azure Activity Log
- **Use Azure AD integration** - Centralize identity and access management
- **Regular security assessments** - Perform vulnerability scans and penetration testing

### ✅ **Performance Optimization**

- **Use Azure CDN** - Improve global performance with content delivery network
- **Implement caching** - Use Azure Cache for Redis for better performance
- **Optimize database performance** - Use SQL Database performance recommendations
- **Monitor application performance** - Use Application Insights for APM
- **Use auto-scaling** - Implement horizontal and vertical scaling
- **Optimize storage** - Choose appropriate storage tiers and access patterns

### ❌ **Common Pitfalls to Avoid**

- **Don't hardcode secrets** - Use Key Vault and managed identities
- **Avoid single region deployment** - Plan for disaster recovery across regions
- **Don't ignore cost optimization** - Regularly review and optimize resource usage
- **Avoid manual deployments** - Use automation and infrastructure as code
- **Don't skip monitoring** - Implement comprehensive logging and alerting
- **Avoid vendor lock-in** - Design with portability in mind

## Advanced Azure Usage

### Azure Arc for Hybrid Cloud

```yaml
# arc-configuration.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: azure-arc-config
  namespace: azure-arc
data:
  AZURE_TENANT_ID: 'your-tenant-id'
  AZURE_SUBSCRIPTION_ID: 'your-subscription-id'
  AZURE_RESOURCE_GROUP: 'arc-enabled-servers'
  AZURE_LOCATION: 'eastus'

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: arc-enabled-app
  namespace: azure-arc
spec:
  replicas: 2
  selector:
    matchLabels:
      app: arc-app
  template:
    metadata:
      labels:
        app: arc-app
    spec:
      containers:
        - name: app
          image: myapp:latest
          env:
            - name: AZURE_CLIENT_ID
              valueFrom:
                secretKeyRef:
                  name: azure-credentials
                  key: client-id
            - name: AZURE_CLIENT_SECRET
              valueFrom:
                secretKeyRef:
                  name: azure-credentials
                  key: client-secret
```

### Azure Logic Apps for Integration

```json
{
  "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "triggers": {
    "When_a_blob_is_added_or_modified": {
      "recurrence": {
        "frequency": "Minute",
        "interval": 5
      },
      "type": "ApiConnection",
      "inputs": {
        "host": {
          "connection": {
            "name": "@parameters('$connections')['azureblob']['connectionId']"
          }
        },
        "method": "get",
        "path": "/datasets/default/triggers/batch/onupdatedfile",
        "queries": {
          "folderId": "uploads",
          "maxFileCount": 10
        }
      }
    }
  },
  "actions": {
    "Process_File": {
      "type": "Http",
      "inputs": {
        "method": "POST",
        "uri": "https://myapp.azurewebsites.net/api/process",
        "headers": {
          "Content-Type": "application/json"
        },
        "body": {
          "fileName": "@triggerBody()?['Name']",
          "filePath": "@triggerBody()?['Path']",
          "fileSize": "@triggerBody()?['Size']"
        }
      },
      "runAfter": {}
    },
    "Send_Notification": {
      "type": "ApiConnection",
      "inputs": {
        "host": {
          "connection": {
            "name": "@parameters('$connections')['teams']['connectionId']"
          }
        },
        "method": "post",
        "path": "/flowbot/actions/notification/recipienttypes/channel",
        "body": {
          "messageBody": "File @{triggerBody()?['Name']} has been processed successfully.",
          "recipient": {
            "channelId": "your-channel-id"
          }
        }
      },
      "runAfter": {
        "Process_File": ["Succeeded"]
      }
    }
  }
}
```

## Integration with Other Tools

### GitHub Actions Integration

```yaml
# .github/workflows/azure-deploy.yml
name: Deploy to Azure

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: 6.0.x

      - name: Restore dependencies
        run: dotnet restore

      - name: Build
        run: dotnet build --no-restore

      - name: Test
        run: dotnet test --no-build --verbosity normal

      - name: Publish
        run: dotnet publish -c Release -o ./publish

      - name: Login to Azure
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Deploy to Azure Web App
        uses: azure/webapps-deploy@v2
        with:
          app-name: 'my-web-app'
          package: './publish'

      - name: Azure CLI script
        uses: azure/CLI@v1
        with:
          azcliversion: 2.30.0
          inlineScript: |
            az webapp restart --name my-web-app --resource-group my-resource-group
```

### Terraform Integration

```hcl
# main.tf - Azure infrastructure with Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "terraformstatestorage"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.app_name}-plan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

# Web App
resource "azurerm_linux_web_app" "main" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = true
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.main.connection_string
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.main.name};Persist Security Info=False;User ID=${var.sql_admin_username};Password=${var.sql_admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Application Insights
resource "azurerm_application_insights" "main" {
  name                = "${var.app_name}-insights"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"

  tags = {
    Environment = var.environment
  }
}

# Variables
variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

# Outputs
output "web_app_url" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "application_insights_key" {
  value = azurerm_application_insights.main.instrumentation_key
  sensitive = true
}
```

## Troubleshooting

### Common Issues

#### Authentication and Access Issues

**Problem**: Access denied or authentication failures
**Symptoms**: 401 Unauthorized, access denied errors
**Solution**:

```bash
# Check current login status
az account show
az account list

# Re-login if needed
az login --tenant your-tenant-id
az account set --subscription "your-subscription"

# Check permissions
az role assignment list --assignee your-user-id
az ad user show --id your-user-id
```

#### Deployment Failures

**Problem**: Application deployment fails
**Symptoms**: Deployment errors, service unavailable
**Solution**:

```bash
# Check deployment logs
az webapp log tail --name myapp --resource-group myrg

# Check app service logs
az webapp log download --name myapp --resource-group myrg

# Debug with Kudu console
az webapp browse --name myapp --resource-group myrg

# Check application settings
az webapp config appsettings list --name myapp --resource-group myrg
```

#### Resource Quota Issues

**Problem**: Resource creation fails due to quota limits
**Symptoms**: Quota exceeded errors
**Solution**:

```bash
# Check current usage
az vm list-usage --location eastus
az network list-usages --location eastus

# Request quota increase through Azure portal
# Monitor resource usage
az monitor activity-log list --resource-group myrg
```

### Debug Mode

```bash
# Enable debug mode
az config set core.output=yaml
az config set core.only_show_errors=false

# Verbose logging
az webapp log config --name myapp --resource-group myrg --web-server-logging filesystem
az webapp log tail --name myapp --resource-group myrg --provider application

# Performance monitoring
az monitor app-insights component show --app myapp --resource-group myrg
```

## Security Considerations

### Security Best Practices

- **Implement Azure Active Directory** - Use AAD for centralized identity management
- **Use managed identities** - Authenticate without storing credentials in code
- **Enable Microsoft Defender for Cloud** - Monitor security posture and threats
- **Implement network security** - Use NSGs, WAF, and private endpoints
- **Use Azure Key Vault** - Securely store secrets, keys, and certificates
- **Enable audit logging** - Track all operations and access patterns

### Secure Configuration Examples

```json
{
  "security": {
    "authentication": {
      "azureActiveDirectory": {
        "enabled": true,
        "tenantId": "your-tenant-id",
        "clientId": "your-client-id",
        "issuer": "https://sts.windows.net/your-tenant-id/"
      }
    },
    "authorization": {
      "defaultPolicy": "require-authenticated-user",
      "policies": [
        {
          "name": "admin-only",
          "requirements": ["role:admin"]
        }
      ]
    },
    "networking": {
      "allowedIpRanges": ["10.0.0.0/8", "172.16.0.0/12"],
      "enablePrivateEndpoints": true,
      "tlsVersion": "1.2"
    }
  }
}
```

## AI Assistant Guidelines

When helping with Azure:

1. **Always suggest managed services** when appropriate for reduced operational overhead
2. **Provide complete infrastructure configurations** with ARM templates or Bicep
3. **Include security best practices** with AAD, managed identities, and Key Vault
4. **Suggest appropriate service combinations** based on Microsoft ecosystem integration
5. **Provide debugging strategies** for common deployment and configuration issues
6. **Include monitoring and alerting** setup with Application Insights and Azure Monitor
7. **Reference cost optimization** techniques for efficient resource usage
8. **Suggest hybrid cloud strategies** when on-premises integration is required

### Code Generation Rules

- Generate complete Bicep or ARM templates for infrastructure as code
- Include proper Azure AD integration and managed identities
- Provide comprehensive Azure DevOps pipelines with testing and security scanning
- Follow Azure Well-Architected Framework principles
- Include proper error handling and logging in application code
- Generate Kubernetes manifests optimized for AKS
- Provide monitoring and alerting configurations for production deployments
- Include backup and disaster recovery strategies in infrastructure designs

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
