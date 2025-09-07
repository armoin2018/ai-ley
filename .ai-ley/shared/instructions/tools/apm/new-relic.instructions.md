# 🚀 Enterprise New Relic - Full-Stack Observability Platform

## **🏢 Level 3 Enterprise Implementation**

### **Overview**

Enterprise New Relic Platform provides comprehensive full-stack observability with AI-powered insights, distributed tracing, infrastructure monitoring, and business intelligence analytics for mission-critical applications.

**Core Capabilities:**

- 🔍 **Full-Stack Observability** - Complete visibility across applications, infrastructure, and user experience
- 🤖 **AI-Powered Insights** - Intelligent anomaly detection and root cause analysis
- 📊 **Business Intelligence** - Revenue correlation and customer experience analytics
- ⚡ **Real-Time Analytics** - Sub-second data processing and alerting
- 🎯 **Service Level Management** - SLI/SLO monitoring and error budget tracking
- 🛡️ **Security Monitoring** - Vulnerability detection and compliance tracking
- ☁️ **Cloud-Native Integration** - Kubernetes, serverless, and microservices support
- 📈 **Custom Dashboards** - Executive reporting and team-specific visualizations

### **🏗️ Enterprise Architecture**

```python
import asyncio
import aiohttp
import structlog
import json
import yaml
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Union
from dataclasses import dataclass, field
from enum import Enum
import urllib.parse
import base64
import hashlib

class NewRelicRegion(Enum):
    """New Relic data center regions"""
    US = "api.newrelic.com"
    EU = "api.eu.newrelic.com"

class AlertSeverity(Enum):
    """Alert severity levels"""
    CRITICAL = "critical"
    WARNING = "warning"
    INFO = "info"

class ServiceTier(Enum):
    """Service tier classifications"""
    PLATINUM = "platinum"
    GOLD = "gold"
    SILVER = "silver"
    BRONZE = "bronze"

@dataclass
class EnterpriseNewRelicConfig:
    """Enterprise New Relic configuration with security and compliance"""

    # Core API Configuration
    api_key: str
    account_id: str
    region: NewRelicRegion = NewRelicRegion.US
    license_key: str = ""
    insights_insert_key: str = ""

    # Enterprise Settings
    organization_name: str = "Enterprise Organization"
    environment: str = "production"
    cluster_name: str = "production-cluster"
    deployment_stage: str = "prod"

    # Security Configuration
    enable_security_monitoring: bool = True
    enable_vulnerability_scanning: bool = True
    enable_compliance_tracking: bool = True

    # Performance Configuration
    sampling_rate: float = 1.0
    retention_days: int = 90
    enable_distributed_tracing: bool = True

    # Business Intelligence
    enable_business_events: bool = True
    revenue_tracking: bool = True
    customer_analytics: bool = True

    # Integration Settings
    slack_webhook_url: str = ""
    pagerduty_service_key: str = ""
    jira_url: str = ""

    # Advanced Configuration
    custom_tags: Dict[str, str] = field(default_factory=dict)
    alert_policies: List[Dict] = field(default_factory=list)

    def __post_init__(self):
        """Initialize configuration with enterprise defaults"""
        if not self.custom_tags:
            self.custom_tags = {
                "environment": self.environment,
                "cluster": self.cluster_name,
                "deployment_stage": self.deployment_stage,
                "organization": self.organization_name.lower().replace(" ", "-"),
                "managed_by": "enterprise-platform-team"
            }

    @property
    def api_base_url(self) -> str:
        """Get API base URL for the configured region"""
        return f"https://{self.region.value}"

    @property
    def insights_base_url(self) -> str:
        """Get Insights API URL for the configured region"""
        region_prefix = "eu01." if self.region == NewRelicRegion.EU else ""
        return f"https://insights-collector.{region_prefix}newrelic.com/v1"

    def validate_configuration(self) -> List[str]:
        """Validate enterprise configuration"""
        errors = []

        if not self.api_key or len(self.api_key) < 10:
            errors.append("Valid API key is required")

        if not self.account_id or not self.account_id.isdigit():
            errors.append("Valid numeric account ID is required")

        if self.enable_business_events and not self.insights_insert_key:
            errors.append("Insights Insert Key required for business events")

        if self.sampling_rate < 0.01 or self.sampling_rate > 1.0:
            errors.append("Sampling rate must be between 0.01 and 1.0")

        return errors

class EnterpriseNewRelicEngine:
    """Production-ready New Relic management engine"""

    def __init__(self, config: EnterpriseNewRelicConfig):
        self.config = config
        self.logger = structlog.get_logger("enterprise.newrelic")
        self.session: Optional[aiohttp.ClientSession] = None
        self.applications = {}
        self.alert_policies = {}
        self.dashboards = {}

        # Validate configuration on initialization
        config_errors = self.config.validate_configuration()
        if config_errors:
            raise ValueError(f"Configuration errors: {'; '.join(config_errors)}")

    async def __aenter__(self):
        """Async context manager entry"""
        await self.initialize()
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        """Async context manager exit with cleanup"""
        await self.cleanup()

    async def initialize(self) -> None:
        """Initialize New Relic engine with enterprise features"""
        try:
            # Create HTTP session with enterprise configuration
            timeout = aiohttp.ClientTimeout(total=60, connect=30)
            connector = aiohttp.TCPConnector(limit=100, limit_per_host=30, keepalive_timeout=300)

            headers = {
                "Api-Key": self.config.api_key,
                "Content-Type": "application/json",
                "User-Agent": f"Enterprise-NewRelic-Platform/1.0 ({self.config.organization_name})"
            }

            self.session = aiohttp.ClientSession(
                timeout=timeout,
                connector=connector,
                headers=headers
            )

            self.logger.info(
                "Enterprise New Relic engine initialized",
                account_id=self.config.account_id,
                region=self.config.region.value,
                environment=self.config.environment
            )

            # Initialize core enterprise features
            await self._setup_enterprise_monitoring()

        except Exception as e:
            self.logger.error(f"Failed to initialize New Relic engine: {e}")
            raise

    async def cleanup(self) -> None:
        """Clean up resources"""
        if self.session:
            await self.session.close()
        self.logger.info("New Relic engine cleaned up successfully")

    async def _setup_enterprise_monitoring(self) -> None:
        """Setup comprehensive enterprise monitoring"""
        try:
            self.logger.info("Setting up enterprise monitoring features...")

            # Setup application monitoring
            await self._configure_application_monitoring()

            # Setup infrastructure monitoring
            await self._configure_infrastructure_monitoring()

            # Setup synthetic monitoring
            await self._configure_synthetic_monitoring()

            # Setup business intelligence
            if self.config.enable_business_events:
                await self._setup_business_intelligence()

            # Setup security monitoring
            if self.config.enable_security_monitoring:
                await self._setup_security_monitoring()

            self.logger.info("Enterprise monitoring setup completed")

        except Exception as e:
            self.logger.error(f"Failed to setup enterprise monitoring: {e}")
            raise

    async def _configure_application_monitoring(self) -> None:
        """Configure comprehensive application performance monitoring"""
        try:
            # Setup distributed tracing
            tracing_config = {
                "enabled": self.config.enable_distributed_tracing,
                "sampling_rate": self.config.sampling_rate,
                "span_events": {
                    "enabled": True,
                    "max_samples_per_minute": 2000
                },
                "cross_application_tracing": {
                    "enabled": True
                },
                "infinite_tracing": {
                    "enabled": True,
                    "trace_observer_url": f"https://trace-api.{self.config.region.value.replace('api.', '')}/trace/v1"
                }
            }

            # Configure error tracking
            error_config = {
                "enabled": True,
                "capture_events": True,
                "max_events_per_minute": 100,
                "ignore_errors": [
                    ".*SocketException.*",
                    ".*ConnectionResetException.*"
                ],
                "expected_errors": [
                    "ValidationException",
                    "AuthenticationException"
                ]
            }

            # Setup database monitoring
            database_config = {
                "enabled": True,
                "record_sql": "obfuscated",
                "explain_enabled": True,
                "explain_threshold": 500,
                "slow_sql": {
                    "enabled": True,
                    "threshold": 2.0
                }
            }

            # Configure browser monitoring
            browser_config = {
                "enabled": True,
                "rum_enabled": True,
                "privacy": {
                    "cookies_enabled": False,
                    "attributes_enabled": True
                },
                "ajax_events": {
                    "enabled": True,
                    "max_events_per_minute": 1000
                }
            }

            # Store configurations for agent deployment
            self.application_config = {
                "tracing": tracing_config,
                "errors": error_config,
                "database": database_config,
                "browser": browser_config
            }

            self.logger.info("Application monitoring configured")

        except Exception as e:
            self.logger.error(f"Failed to configure application monitoring: {e}")
            raise

    async def _configure_infrastructure_monitoring(self) -> None:
        """Configure comprehensive infrastructure monitoring"""
        try:
            # Host monitoring configuration
            host_config = {
                "enabled": True,
                "metrics": {
                    "system_metrics": True,
                    "process_metrics": True,
                    "network_metrics": True,
                    "storage_metrics": True
                },
                "events": {
                    "enabled": True,
                    "filters": [
                        {"attribute": "hostname", "value": f"*{self.config.environment}*"},
                        {"attribute": "environment", "value": self.config.environment}
                    ]
                },
                "custom_attributes": self.config.custom_tags
            }

            # Kubernetes monitoring
            kubernetes_config = {
                "enabled": True,
                "cluster_name": self.config.cluster_name,
                "namespace_filtering": {
                    "enabled": True,
                    "namespaces": ["production", "staging", "monitoring"]
                },
                "metrics": {
                    "pods": True,
                    "nodes": True,
                    "services": True,
                    "deployments": True,
                    "persistent_volumes": True
                },
                "events": {
                    "enabled": True,
                    "include_system_events": True
                }
            }

            # Container monitoring
            container_config = {
                "enabled": True,
                "docker_monitoring": True,
                "container_metrics": {
                    "cpu_metrics": True,
                    "memory_metrics": True,
                    "network_metrics": True,
                    "blkio_metrics": True
                },
                "process_monitoring": {
                    "enabled": True,
                    "cmdline_capture": True
                }
            }

            # Cloud integration configuration
            cloud_config = {
                "aws": {
                    "enabled": True,
                    "services": ["ec2", "rds", "elb", "lambda", "s3", "cloudfront"],
                    "tags": self.config.custom_tags
                },
                "azure": {
                    "enabled": True,
                    "services": ["virtual_machines", "sql_database", "app_service"],
                    "tags": self.config.custom_tags
                },
                "gcp": {
                    "enabled": True,
                    "services": ["compute_engine", "cloud_sql", "app_engine"],
                    "labels": self.config.custom_tags
                }
            }

            self.infrastructure_config = {
                "host": host_config,
                "kubernetes": kubernetes_config,
                "containers": container_config,
                "cloud": cloud_config
            }

            self.logger.info("Infrastructure monitoring configured")

        except Exception as e:
            self.logger.error(f"Failed to configure infrastructure monitoring: {e}")
            raise

    async def _configure_synthetic_monitoring(self) -> None:
        """Configure comprehensive synthetic monitoring and testing"""
        try:
            # Browser monitoring tests
            browser_tests = []

            # Critical user journey test
            critical_journey = {
                "name": "Critical User Journey - Production",
                "type": "BROWSER",
                "frequency": 1,  # 1 minute
                "locations": ["AWS_US_EAST_1", "AWS_EU_WEST_1", "AWS_AP_SOUTHEAST_1"],
                "status": "ENABLED",
                "script": """
                // Critical business flow monitoring
                var assert = require('assert');

                // Navigate to main application
                $browser.get('https://app.company.com')
                    .then(function() {
                        return $browser.waitForAndFindElement($driver.By.css('.main-content'), 10000);
                    })
                    .then(function() {
                        // Test authentication flow
                        return $browser.findElement($driver.By.css('#login-button')).click();
                    })
                    .then(function() {
                        return $browser.waitForAndFindElement($driver.By.css('#username'), 5000);
                    })
                    .then(function(element) {
                        return element.sendKeys('test@company.com');
                    })
                    .then(function() {
                        return $browser.findElement($driver.By.css('#password')).sendKeys('testpass');
                    })
                    .then(function() {
                        return $browser.findElement($driver.By.css('#submit')).click();
                    })
                    .then(function() {
                        // Verify successful authentication
                        return $browser.waitForAndFindElement($driver.By.css('.dashboard'), 10000);
                    })
                    .then(function() {
                        // Test core functionality
                        return $browser.findElement($driver.By.css('.primary-action')).click();
                    })
                    .then(function() {
                        return $browser.waitForAndFindElement($driver.By.css('.success-message'), 5000);
                    })
                    .then(function() {
                        // Business event tracking
                        $insights.track('SyntheticBusinessEvent', {
                            'eventType': 'critical_journey_complete',
                            'success': true,
                            'duration': Date.now(),
                            'environment': '${self.config.environment}'
                        });
                    });
                """,
                "options": {
                    "validationString": "Dashboard",
                    "verifySSL": True,
                    "bypassHeadRequest": False,
                    "treatRedirectAsFailure": False
                },
                "tags": {
                    "environment": self.config.environment,
                    "test_type": "critical_journey",
                    "business_impact": "high"
                }
            }
            browser_tests.append(critical_journey)

            # API monitoring tests
            api_tests = []

            # Health check API test
            health_check = {
                "name": "API Health Check - Production",
                "type": "SIMPLE",
                "frequency": 1,  # 1 minute
                "locations": ["AWS_US_EAST_1", "AWS_EU_WEST_1"],
                "status": "ENABLED",
                "uri": "https://api.company.com/health",
                "options": {
                    "validationString": "healthy",
                    "verifySSL": True,
                    "followRedirects": True,
                    "headers": {
                        "User-Agent": "NewRelic-Synthetic-Monitor",
                        "Accept": "application/json"
                    }
                },
                "tags": {
                    "environment": self.config.environment,
                    "test_type": "health_check",
                    "business_impact": "critical"
                }
            }
            api_tests.append(health_check)

            # Business API endpoint test
            business_api = {
                "name": "Business API - Order Processing",
                "type": "SCRIPTED_API",
                "frequency": 5,  # 5 minutes
                "locations": ["AWS_US_EAST_1", "AWS_EU_WEST_1"],
                "status": "ENABLED",
                "script": """
                var assert = require('assert');

                // Test order creation API
                var options = {
                    url: 'https://api.company.com/v1/orders',
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + $secure.API_TOKEN
                    },
                    body: JSON.stringify({
                        customerId: 'test-customer-123',
                        items: [
                            { productId: 'prod-456', quantity: 1, price: 99.99 }
                        ],
                        totalAmount: 99.99
                    })
                };

                $http.post(options, function(err, response, body) {
                    assert.equal(response.statusCode, 201, 'Expected 201 status code');

                    var order = JSON.parse(body);
                    assert.ok(order.orderId, 'Order ID should be present');
                    assert.equal(order.status, 'created', 'Order should be created');

                    // Track business event
                    $insights.track('SyntheticAPIEvent', {
                        'eventType': 'order_api_test',
                        'success': true,
                        'responseTime': response.responseTime,
                        'orderId': order.orderId,
                        'environment': '${self.config.environment}'
                    });
                });
                """,
                "tags": {
                    "environment": self.config.environment,
                    "test_type": "business_api",
                    "business_impact": "high"
                }
            }
            api_tests.append(business_api)

            self.synthetic_config = {
                "browser_tests": browser_tests,
                "api_tests": api_tests,
                "alert_thresholds": {
                    "success_rate": 95,  # Minimum 95% success rate
                    "response_time": 3000,  # Maximum 3 seconds
                    "apdex_threshold": 0.5
                }
            }

            self.logger.info(f"Configured {len(browser_tests)} browser and {len(api_tests)} API synthetic tests")

        except Exception as e:
            self.logger.error(f"Failed to configure synthetic monitoring: {e}")
            raise

    async def _setup_business_intelligence(self) -> None:
        """Setup comprehensive business intelligence and analytics"""
        try:
            # Business event definitions
            business_events = {
                "revenue_events": [
                    {
                        "name": "purchase_completed",
                        "attributes": {
                            "customer_id": "string",
                            "order_value": "float",
                            "payment_method": "string",
                            "product_categories": "array",
                            "promotion_code": "string",
                            "customer_tier": "string"
                        }
                    },
                    {
                        "name": "subscription_created",
                        "attributes": {
                            "customer_id": "string",
                            "plan_type": "string",
                            "monthly_value": "float",
                            "annual_value": "float",
                            "trial_period": "integer"
                        }
                    }
                ],
                "user_engagement": [
                    {
                        "name": "feature_usage",
                        "attributes": {
                            "user_id": "string",
                            "feature_name": "string",
                            "usage_duration": "float",
                            "user_tier": "string",
                            "success": "boolean"
                        }
                    },
                    {
                        "name": "user_journey_step",
                        "attributes": {
                            "user_id": "string",
                            "journey_name": "string",
                            "step_name": "string",
                            "completion_time": "float",
                            "abandoned": "boolean"
                        }
                    }
                ],
                "performance_events": [
                    {
                        "name": "slow_transaction",
                        "attributes": {
                            "transaction_name": "string",
                            "duration": "float",
                            "database_time": "float",
                            "external_time": "float",
                            "user_impact": "string"
                        }
                    }
                ]
            }

            # Custom metrics definitions
            custom_metrics = {
                "business_kpis": [
                    {
                        "name": "revenue_per_minute",
                        "unit": "dollars",
                        "description": "Real-time revenue tracking per minute"
                    },
                    {
                        "name": "conversion_rate",
                        "unit": "percentage",
                        "description": "User conversion rate from visit to purchase"
                    },
                    {
                        "name": "customer_acquisition_cost",
                        "unit": "dollars",
                        "description": "Cost to acquire new customer"
                    },
                    {
                        "name": "customer_lifetime_value",
                        "unit": "dollars",
                        "description": "Predicted customer lifetime value"
                    }
                ],
                "operational_kpis": [
                    {
                        "name": "deployment_frequency",
                        "unit": "count",
                        "description": "Number of deployments per day"
                    },
                    {
                        "name": "mean_time_to_recovery",
                        "unit": "minutes",
                        "description": "Average time to resolve incidents"
                    },
                    {
                        "name": "error_budget_burn_rate",
                        "unit": "percentage",
                        "description": "Rate of error budget consumption"
                    }
                ]
            }

            self.business_intelligence_config = {
                "events": business_events,
                "metrics": custom_metrics,
                "dashboards": {
                    "executive_dashboard": {
                        "widgets": [
                            "revenue_trend",
                            "conversion_funnel",
                            "customer_satisfaction",
                            "system_health"
                        ]
                    },
                    "operational_dashboard": {
                        "widgets": [
                            "error_rates",
                            "response_times",
                            "throughput",
                            "infrastructure_health"
                        ]
                    }
                }
            }

            self.logger.info("Business intelligence configured")

        except Exception as e:
            self.logger.error(f"Failed to setup business intelligence: {e}")
            raise

    async def _setup_security_monitoring(self) -> None:
        """Setup comprehensive security monitoring and compliance"""
        try:
            # Security event monitoring
            security_events = {
                "authentication_events": [
                    "login_success",
                    "login_failure",
                    "password_reset",
                    "account_locked",
                    "suspicious_login_pattern"
                ],
                "authorization_events": [
                    "access_denied",
                    "privilege_escalation_attempt",
                    "unauthorized_resource_access",
                    "role_change"
                ],
                "application_security": [
                    "sql_injection_attempt",
                    "xss_attempt",
                    "csrf_violation",
                    "input_validation_failure",
                    "file_upload_violation"
                ],
                "infrastructure_security": [
                    "unusual_network_activity",
                    "port_scan_detected",
                    "malware_signature",
                    "configuration_drift"
                ]
            }

            # Vulnerability monitoring
            vulnerability_config = {
                "dependency_scanning": {
                    "enabled": True,
                    "scan_frequency": "daily",
                    "severity_threshold": "medium",
                    "auto_remediation": False
                },
                "container_scanning": {
                    "enabled": True,
                    "scan_on_push": True,
                    "base_image_scanning": True,
                    "policy_violations": ["high_severity", "malware"]
                },
                "code_analysis": {
                    "enabled": True,
                    "static_analysis": True,
                    "dynamic_analysis": True,
                    "owasp_top_10": True
                }
            }

            # Compliance monitoring
            compliance_config = {
                "frameworks": {
                    "sox": {
                        "enabled": True,
                        "controls": ["access_controls", "change_management", "data_retention"]
                    },
                    "pci_dss": {
                        "enabled": True,
                        "requirements": ["network_security", "data_protection", "access_management"]
                    },
                    "gdpr": {
                        "enabled": True,
                        "data_processing": ["consent_tracking", "data_minimization", "breach_notification"]
                    },
                    "hipaa": {
                        "enabled": False,
                        "safeguards": ["administrative", "physical", "technical"]
                    }
                },
                "audit_logging": {
                    "enabled": True,
                    "retention_days": 2555,  # 7 years
                    "immutable_storage": True,
                    "log_integrity": True
                }
            }

            self.security_config = {
                "events": security_events,
                "vulnerabilities": vulnerability_config,
                "compliance": compliance_config,
                "incident_response": {
                    "automated_containment": True,
                    "notification_channels": ["slack", "pagerduty", "email"],
                    "escalation_matrix": {
                        "critical": "immediate",
                        "high": "15_minutes",
                        "medium": "1_hour",
                        "low": "24_hours"
                    }
                }
            }

            self.logger.info("Security monitoring configured")

        except Exception as e:
            self.logger.error(f"Failed to setup security monitoring: {e}")
            raise

### **📊 Enterprise Dashboard & Analytics Engine**

class EnterpriseNewRelicDashboardManager:
    """Advanced dashboard management and business analytics"""

    def __init__(self, newrelic_engine: EnterpriseNewRelicEngine):
        self.engine = newrelic_engine
        self.logger = structlog.get_logger("enterprise.newrelic.dashboard")
        self.dashboards = {}

    async def create_enterprise_dashboards(self) -> Dict[str, Any]:
        """Create comprehensive enterprise dashboards"""
        try:
            dashboards = {}

            # Executive Business Intelligence Dashboard
            executive_dashboard = await self._create_executive_dashboard()
            dashboards['executive'] = executive_dashboard

            # Site Reliability Engineering Dashboard
            sre_dashboard = await self._create_sre_dashboard()
            dashboards['sre'] = sre_dashboard

            # Development Team Dashboard
            dev_dashboard = await self._create_development_dashboard()
            dashboards['development'] = dev_dashboard

            # Security Operations Dashboard
            security_dashboard = await self._create_security_dashboard()
            dashboards['security'] = security_dashboard

            # Business Intelligence Dashboard
            business_dashboard = await self._create_business_intelligence_dashboard()
            dashboards['business_intelligence'] = business_dashboard

            # Infrastructure Health Dashboard
            infrastructure_dashboard = await self._create_infrastructure_dashboard()
            dashboards['infrastructure'] = infrastructure_dashboard

            self.dashboards = dashboards
            self.logger.info(f"Created {len(dashboards)} enterprise dashboards")

            return dashboards

        except Exception as e:
            self.logger.error(f"Failed to create enterprise dashboards: {e}")
            raise

    async def _create_executive_dashboard(self) -> Dict[str, Any]:
        """Create executive business intelligence dashboard"""
        try:
            dashboard_config = {
                "name": "Executive Business Intelligence",
                "description": "High-level business metrics and KPIs for executive leadership",
                "permissions": "PRIVATE",
                "pages": [
                    {
                        "name": "Business Overview",
                        "description": "Key business metrics and trends",
                        "widgets": [
                            {
                                "title": "Revenue Trend (24h)",
                                "visualization": {
                                    "id": "viz.line"
                                },
                                "layout": {
                                    "column": 1,
                                    "row": 1,
                                    "width": 6,
                                    "height": 3
                                },
                                "rawConfiguration": {
                                    "facet": {
                                        "showOtherSeries": False
                                    },
                                    "legend": {
                                        "enabled": True
                                    },
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT sum(orderValue) as 'Revenue'
                                                FROM Transaction
                                                WHERE transactionType = 'purchase'
                                                TIMESERIES AUTO
                                                SINCE 24 hours ago
                                            """
                                        }
                                    ],
                                    "platformOptions": {
                                        "ignoreTimeRange": False
                                    },
                                    "yAxisLeft": {
                                        "zero": True
                                    }
                                }
                            },
                            {
                                "title": "Customer Satisfaction Score",
                                "visualization": {
                                    "id": "viz.billboard"
                                },
                                "layout": {
                                    "column": 7,
                                    "row": 1,
                                    "width": 3,
                                    "height": 3
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT average(satisfactionScore) as 'CSAT Score'
                                                FROM PageView
                                                WHERE satisfactionScore IS NOT NULL
                                                SINCE 7 days ago
                                            """
                                        }
                                    ],
                                    "thresholds": [
                                        {
                                            "alertSeverity": "CRITICAL",
                                            "value": 70
                                        },
                                        {
                                            "alertSeverity": "WARNING",
                                            "value": 80
                                        }
                                    ]
                                }
                            },
                            {
                                "title": "System Health Score",
                                "visualization": {
                                    "id": "viz.billboard"
                                },
                                "layout": {
                                    "column": 10,
                                    "row": 1,
                                    "width": 3,
                                    "height": 3
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT percentage(count(*), WHERE errorType IS NULL) as 'Health Score'
                                                FROM Transaction
                                                SINCE 1 hour ago
                                            """
                                        }
                                    ],
                                    "thresholds": [
                                        {
                                            "alertSeverity": "CRITICAL",
                                            "value": 95
                                        },
                                        {
                                            "alertSeverity": "WARNING",
                                            "value": 98
                                        }
                                    ]
                                }
                            },
                            {
                                "title": "Conversion Funnel Analysis",
                                "visualization": {
                                    "id": "viz.funnel"
                                },
                                "layout": {
                                    "column": 1,
                                    "row": 4,
                                    "width": 12,
                                    "height": 4
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT funnel(session,
                                                    WHERE pageUrl LIKE '%/landing%' as 'Landing Page',
                                                    WHERE pageUrl LIKE '%/product%' as 'Product View',
                                                    WHERE pageUrl LIKE '%/cart%' as 'Add to Cart',
                                                    WHERE pageUrl LIKE '%/checkout%' as 'Checkout',
                                                    WHERE pageUrl LIKE '%/success%' as 'Purchase Complete'
                                                ) FROM PageView SINCE 24 hours ago
                                            """
                                        }
                                    ]
                                }
                            },
                            {
                                "title": "Critical Alerts & Issues",
                                "visualization": {
                                    "id": "viz.table"
                                },
                                "layout": {
                                    "column": 1,
                                    "row": 8,
                                    "width": 12,
                                    "height": 4
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT timestamp, alertSeverity, alertName,
                                                       businessImpact, estimatedRevenueLoss
                                                FROM Alert
                                                WHERE alertSeverity IN ('CRITICAL', 'WARNING')
                                                ORDER BY timestamp DESC
                                                LIMIT 20 SINCE 24 hours ago
                                            """
                                        }
                                    ]
                                }
                            }
                        ]
                    }
                ],
                "variables": []
            }

            # Create dashboard via API
            dashboard_response = await self._create_dashboard(dashboard_config)

            return {
                'config': dashboard_config,
                'response': dashboard_response,
                'url': f"{self.engine.config.api_base_url}/dashboards/{dashboard_response.get('guid', 'unknown')}"
            }

        except Exception as e:
            self.logger.error(f"Failed to create executive dashboard: {e}")
            return {}

    async def _create_sre_dashboard(self) -> Dict[str, Any]:
        """Create Site Reliability Engineering dashboard"""
        try:
            dashboard_config = {
                "name": "Site Reliability Engineering",
                "description": "SRE metrics, SLOs, and operational health",
                "permissions": "PRIVATE",
                "pages": [
                    {
                        "name": "Service Level Objectives",
                        "description": "SLI/SLO monitoring and error budgets",
                        "widgets": [
                            {
                                "title": "Service Availability (SLO: 99.9%)",
                                "visualization": {
                                    "id": "viz.line"
                                },
                                "layout": {
                                    "column": 1,
                                    "row": 1,
                                    "width": 6,
                                    "height": 3
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT percentage(count(*), WHERE httpResponseCode != 5xx) as 'Availability'
                                                FROM Transaction
                                                WHERE transactionType = 'Web'
                                                TIMESERIES 5 minutes
                                                SINCE 24 hours ago
                                            """
                                        }
                                    ],
                                    "thresholds": [
                                        {
                                            "alertSeverity": "CRITICAL",
                                            "value": 99.9
                                        }
                                    ]
                                }
                            },
                            {
                                "title": "Error Budget Burn Rate",
                                "visualization": {
                                    "id": "viz.billboard"
                                },
                                "layout": {
                                    "column": 7,
                                    "row": 1,
                                    "width": 3,
                                    "height": 3
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT rate(count(*), 1 hour) as 'Error Budget Burn Rate'
                                                FROM TransactionError
                                                SINCE 1 hour ago
                                            """
                                        }
                                    ]
                                }
                            },
                            {
                                "title": "Mean Time to Recovery (MTTR)",
                                "visualization": {
                                    "id": "viz.billboard"
                                },
                                "layout": {
                                    "column": 10,
                                    "row": 1,
                                    "width": 3,
                                    "height": 3
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT average(recoveryTime) as 'MTTR (minutes)'
                                                FROM Alert
                                                WHERE state = 'closed'
                                                SINCE 7 days ago
                                            """
                                        }
                                    ]
                                }
                            },
                            {
                                "title": "Response Time Percentiles",
                                "visualization": {
                                    "id": "viz.line"
                                },
                                "layout": {
                                    "column": 1,
                                    "row": 4,
                                    "width": 12,
                                    "height": 4
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT percentile(duration, 50, 90, 95, 99)
                                                FROM Transaction
                                                WHERE transactionType = 'Web'
                                                TIMESERIES AUTO
                                                SINCE 24 hours ago
                                            """
                                        }
                                    ]
                                }
                            },
                            {
                                "title": "Infrastructure Resource Utilization",
                                "visualization": {
                                    "id": "viz.area"
                                },
                                "layout": {
                                    "column": 1,
                                    "row": 8,
                                    "width": 12,
                                    "height": 4
                                },
                                "rawConfiguration": {
                                    "nrqlQueries": [
                                        {
                                            "accountId": self.engine.config.account_id,
                                            "query": """
                                                SELECT average(cpuPercent) as 'CPU',
                                                       average(memoryUsedPercent) as 'Memory',
                                                       average(diskUsedPercent) as 'Disk'
                                                FROM SystemSample
                                                TIMESERIES AUTO
                                                SINCE 24 hours ago
                                            """
                                        }
                                    ]
                                }
                            }
                        ]
                    }
                ]
            }

            dashboard_response = await self._create_dashboard(dashboard_config)

            return {
                'config': dashboard_config,
                'response': dashboard_response,
                'url': f"{self.engine.config.api_base_url}/dashboards/{dashboard_response.get('guid', 'unknown')}"
            }

        except Exception as e:
            self.logger.error(f"Failed to create SRE dashboard: {e}")
            return {}

    async def _create_dashboard(self, dashboard_config: Dict[str, Any]) -> Dict[str, Any]:
        """Create dashboard via New Relic API"""
        try:
            mutation = """
            mutation dashboardCreate($dashboard: DashboardInput!) {
                dashboardCreate(dashboard: $dashboard) {
                    entityResult {
                        guid
                        name
                    }
                    errors {
                        description
                        type
                    }
                }
            }
            """

            payload = {
                "query": mutation,
                "variables": {
                    "dashboard": dashboard_config
                }
            }

            async with self.engine.session.post(
                f"{self.engine.config.api_base_url}/graphql",
                json=payload
            ) as response:
                if response.status == 200:
                    result = await response.json()
                    if 'errors' not in result:
                        dashboard_data = result['data']['dashboardCreate']['entityResult']
                        return {"success": True, "data": dashboard_data, "guid": dashboard_data['guid']}
                    else:
                        return {"success": False, "error": result['errors']}
                else:
                    error_text = await response.text()
                    return {"success": False, "error": error_text}

        except Exception as e:
            return {"success": False, "error": str(e)}

### **🔔 Enterprise Alert Management**

class EnterpriseNewRelicAlertManager:
    """Advanced alerting and incident management"""

    def __init__(self, newrelic_engine: EnterpriseNewRelicEngine):
        self.engine = newrelic_engine
        self.logger = structlog.get_logger("enterprise.newrelic.alerts")
        self.alert_policies = {}

    async def setup_enterprise_alerting(self) -> Dict[str, Any]:
        """Setup comprehensive enterprise alerting policies"""
        try:
            # Business Critical Services Policy
            business_critical_policy = await self._create_business_critical_policy()

            # Site Reliability Policy
            sre_policy = await self._create_sre_policy()

            # Security Monitoring Policy
            security_policy = await self._create_security_policy()

            # Infrastructure Health Policy
            infrastructure_policy = await self._create_infrastructure_policy()

            # Business Intelligence Policy
            business_intel_policy = await self._create_business_intelligence_policy()

            alert_policies = {
                'business_critical': business_critical_policy,
                'sre': sre_policy,
                'security': security_policy,
                'infrastructure': infrastructure_policy,
                'business_intelligence': business_intel_policy
            }

            self.alert_policies = alert_policies
            self.logger.info(f"Created {len(alert_policies)} enterprise alert policies")

            return alert_policies

        except Exception as e:
            self.logger.error(f"Failed to setup enterprise alerting: {e}")
            raise

    async def _create_business_critical_policy(self) -> Dict[str, Any]:
        """Create business critical services alerting policy"""
        try:
            policy_config = {
                "name": "Business Critical Services",
                "incidentPreference": "PER_POLICY",
                "conditions": [
                    {
                        "name": "Revenue Loss Alert",
                        "type": "NRQL",
                        "nrql": {
                            "query": "SELECT rate(sum(orderValue), 1 minute) FROM Transaction WHERE transactionType = 'purchase'",
                            "evaluationOffset": 3
                        },
                        "signal": {
                            "aggregationWindow": 60,
                            "aggregationMethod": "EVENT_FLOW",
                            "aggregationDelay": 120,
                            "fillOption": "NONE"
                        },
                        "terms": [
                            {
                                "threshold": 50,
                                "thresholdDuration": 300,
                                "thresholdOccurrences": "ALL",
                                "operator": "BELOW",
                                "priority": "CRITICAL"
                            }
                        ],
                        "violationTimeLimitSeconds": 3600
                    },
                    {
                        "name": "Critical Service Availability",
                        "type": "NRQL",
                        "nrql": {
                            "query": "SELECT percentage(count(*), WHERE httpResponseCode != 5xx) FROM Transaction WHERE tags.businessCritical = 'true'",
                            "evaluationOffset": 3
                        },
                        "signal": {
                            "aggregationWindow": 60,
                            "aggregationMethod": "EVENT_FLOW",
                            "aggregationDelay": 120,
                            "fillOption": "LAST_VALUE"
                        },
                        "terms": [
                            {
                                "threshold": 99.5,
                                "thresholdDuration": 300,
                                "thresholdOccurrences": "ALL",
                                "operator": "BELOW",
                                "priority": "CRITICAL"
                            }
                        ]
                    },
                    {
                        "name": "Payment Processing Failures",
                        "type": "NRQL",
                        "nrql": {
                            "query": "SELECT count(*) FROM TransactionError WHERE transactionName LIKE '%payment%'",
                            "evaluationOffset": 3
                        },
                        "signal": {
                            "aggregationWindow": 60,
                            "aggregationMethod": "EVENT_FLOW",
                            "aggregationDelay": 120,
                            "fillOption": "NONE"
                        },
                        "terms": [
                            {
                                "threshold": 5,
                                "thresholdDuration": 300,
                                "thresholdOccurrences": "ALL",
                                "operator": "ABOVE",
                                "priority": "CRITICAL"
                            }
                        ]
                    }
                ]
            }

            policy_response = await self._create_alert_policy(policy_config)

            return {
                'config': policy_config,
                'response': policy_response,
                'policy_id': policy_response.get('id', 'unknown')
            }

        except Exception as e:
            self.logger.error(f"Failed to create business critical policy: {e}")
            return {}

    async def _create_alert_policy(self, policy_config: Dict[str, Any]) -> Dict[str, Any]:
        """Create alert policy via New Relic API"""
        try:
            mutation = """
            mutation alertsPolicyCreate($accountId: Int!, $policy: AlertsPolicyInput!) {
                alertsPolicyCreate(accountId: $accountId, policy: $policy) {
                    id
                    name
                    incidentPreference
                }
            }
            """

            payload = {
                "query": mutation,
                "variables": {
                    "accountId": int(self.engine.config.account_id),
                    "policy": policy_config
                }
            }

            async with self.engine.session.post(
                f"{self.engine.config.api_base_url}/graphql",
                json=payload
            ) as response:
                if response.status == 200:
                    result = await response.json()
                    if 'errors' not in result:
                        return {"success": True, "data": result['data']['alertsPolicyCreate']}
                    else:
                        return {"success": False, "error": result['errors']}
                else:
                    error_text = await response.text()
                    return {"success": False, "error": error_text}

        except Exception as e:
            return {"success": False, "error": str(e)}

### **🚀 Quick Start Implementation Guide**

def main():
    """
    Enterprise New Relic Quick Start Guide

    This comprehensive guide demonstrates how to implement a production-ready
    New Relic environment with full-stack observability, AI insights, and
    business intelligence.
    """

    # Example implementation
    async def deploy_enterprise_newrelic():
        """Deploy complete enterprise New Relic platform"""

        # Initialize enterprise configuration
        config = EnterpriseNewRelicConfig(
            api_key="your-api-key",
            account_id="your-account-id",
            license_key="your-license-key",
            insights_insert_key="your-insights-key",
            region=NewRelicRegion.US,
            organization_name="Enterprise Corp",
            environment="production"
        )

        # Deploy and configure New Relic
        async with EnterpriseNewRelicEngine(config) as newrelic:
            # Setup enterprise dashboards
            dashboard_manager = EnterpriseNewRelicDashboardManager(newrelic)
            dashboards = await dashboard_manager.create_enterprise_dashboards()

            # Configure enterprise alerting
            alert_manager = EnterpriseNewRelicAlertManager(newrelic)
            alert_policies = await alert_manager.setup_enterprise_alerting()

            print("✅ Enterprise New Relic deployed successfully!")
            print(f"📊 Created {len(dashboards)} enterprise dashboards")
            print(f"🚨 Configured {len(alert_policies)} alert policies")

            return {
                'newrelic_engine': newrelic,
                'dashboards': dashboards,
                'alert_policies': alert_policies
            }

    print("🚀 Enterprise New Relic - Full-Stack Observability Platform")
    print("=" * 75)
    print()
    print("🎯 KEY CAPABILITIES:")
    print("   ✅ Full-Stack Observability")
    print("   ✅ AI-Powered Insights")
    print("   ✅ Business Intelligence")
    print("   ✅ Real-Time Analytics")
    print("   ✅ Service Level Management")
    print("   ✅ Security Monitoring")
    print("   ✅ Cloud-Native Integration")
    print("   ✅ Custom Dashboards")
    print()
    print("🚀 QUICK DEPLOYMENT:")
    print("   1. Configure API credentials")
    print("   2. Install New Relic agents")
    print("   3. Deploy monitoring configuration")
    print("   4. Create dashboards and alerts")
    print()
    print("📈 ENTERPRISE FEATURES:")
    print("   🎯 Business KPI Tracking")
    print("   🔍 Distributed Tracing")
    print("   📊 Executive Reporting")
    print("   ⚡ Real-Time Alerting")
    print("   🛡️ Security Analysis")
    print("   📱 Mobile Monitoring")
    print("   ☁️ Infrastructure Health")
    print("   📈 Revenue Intelligence")

### **🔧 Agent Configuration & Deployment**

class NewRelicAgentManager:
    """Production-ready agent deployment and configuration management"""

    def __init__(self, config: EnterpriseNewRelicConfig):
        self.config = config
        self.logger = structlog.get_logger("newrelic.agent.manager")

    def generate_application_configs(self) -> Dict[str, str]:
        """Generate application agent configurations for various technologies"""
        configs = {}

        # Java Agent Configuration
        configs['newrelic.yml'] = f"""
# New Relic Java Agent Configuration
# https://docs.newrelic.com/docs/agents/java-agent/configuration/java-agent-configuration-config-file/

common: &default_settings
  license_key: '{self.config.license_key}'
  app_name: Production Application

  # Distributed Tracing
  distributed_tracing:
    enabled: true

  # Application Logging
  application_logging:
    enabled: true
    forwarding:
      enabled: true
      max_samples_stored: 10000
    local_decorating:
      enabled: true
    metrics:
      enabled: true

  # Transaction Tracer
  transaction_tracer:
    enabled: true
    transaction_threshold: apdex_f
    record_sql: obfuscated
    explain_enabled: true
    explain_threshold: 500
    stack_trace_threshold: 500

  # Error Collector
  error_collector:
    enabled: true
    capture_events: true
    max_events_per_minute: 100
    ignore_errors:
      - "java.net.SocketException"
      - "java.net.SocketTimeoutException"
    expected_errors:
      - "com.company.ValidationException"
      - "com.company.AuthenticationException"

  # Browser Monitoring (Real User Monitoring)
  browser_monitoring:
    auto_instrument: true

  # Thread Profiler
  thread_profiler:
    enabled: true

  # Custom Instrumentation
  class_transformer:
    enabled: true

  # Labels for environment tagging
  labels:
    environment: {self.config.environment}
    cluster: {self.config.cluster_name}
    team: platform
    business_critical: true

# Environment-specific configurations
production:
  <<: *default_settings
  app_name: Production Web Application
  audit_mode: false
  log_level: info

  # High performance settings for production
  transaction_tracer:
    enabled: true
    transaction_threshold: 2.0

  # Enhanced security for production
  high_security: false
  strip_exception_messages:
    enabled: false

staging:
  <<: *default_settings
  app_name: Staging Web Application
  audit_mode: true
  log_level: debug

development:
  <<: *default_settings
  app_name: Development Web Application
  audit_mode: true
  log_level: debug
  developer_mode: true
"""

        # .NET Agent Configuration
        configs['newrelic.config'] = f"""<?xml version="1.0"?>
<configuration xmlns="urn:newrelic-config" agentEnabled="true">
  <service licenseKey="{self.config.license_key}" />

  <application>
    <name>Production .NET Application</name>
  </application>

  <appSettings>
    <add key="NewRelic.AppSettings.Environment" value="{self.config.environment}" />
    <add key="NewRelic.AppSettings.Cluster" value="{self.config.cluster_name}" />
    <add key="NewRelic.AppSettings.BusinessCritical" value="true" />
  </appSettings>

  <!-- Distributed Tracing -->
  <distributedTracing enabled="true">
    <excludeNewrelicHeader>false</excludeNewrelicHeader>
  </distributedTracing>

  <!-- Application Logging -->
  <applicationLogging enabled="true">
    <forwarding enabled="true" maxSamplesStored="10000" />
    <localDecorating enabled="true" />
    <metrics enabled="true" />
  </applicationLogging>

  <!-- Transaction Tracer -->
  <transactionTracer enabled="true"
                     transactionThreshold="apdex_f"
                     stackTraceThreshold="500"
                     recordSql="obfuscated"
                     explainEnabled="true"
                     explainThreshold="500" />

  <!-- Error Collector -->
  <errorCollector enabled="true"
                 captureEvents="true"
                 maxEventsPerMinute="100">
    <ignoreErrors>
      <exception>System.Net.Sockets.SocketException</exception>
      <exception>System.TimeoutException</exception>
    </ignoreErrors>
    <expectedErrors>
      <exception>Company.ValidationException</exception>
      <exception>Company.AuthenticationException</exception>
    </expectedErrors>
  </errorCollector>

  <!-- Browser Monitoring -->
  <browserMonitoring autoInstrument="true" />

  <!-- Thread Profiling -->
  <threadProfiling>
    <ignoreMethod>System.Threading.WaitHandle.WaitAny</ignoreMethod>
    <ignoreMethod>System.Threading.WaitHandle.WaitOne</ignoreMethod>
  </threadProfiling>

  <!-- Custom Instrumentation -->
  <instrumentation>
    <applications>
      <application name="Production .NET Application">
        <transactions>
          <transaction className="Company.Services.PaymentService" methodName="ProcessPayment" />
          <transaction className="Company.Controllers.OrderController" methodName="CreateOrder" />
        </transactions>
      </application>
    </applications>
  </instrumentation>

  <!-- Service Configuration -->
  <service enabled="true"
          licenseKey="{self.config.license_key}"
          ssl="true"
          sendDataOnExit="true"
          sendDataOnExitThreshold="60000"
          autoStart="true" />

  <!-- High Security Mode -->
  <highSecurity enabled="false" />

  <!-- Attributes -->
  <attributes enabled="true">
    <include>request.parameters.*</include>
    <exclude>request.parameters.password</exclude>
    <exclude>request.parameters.ssn</exclude>
  </attributes>

</configuration>"""

        # Node.js Agent Configuration
        configs['newrelic.js'] = f"""/**
 * New Relic Node.js Agent Configuration
 * https://docs.newrelic.com/docs/agents/nodejs-agent/installation-configuration/nodejs-agent-configuration/
 */
'use strict'

exports.config = {{
  app_name: ['Production Node.js Application'],
  license_key: '{self.config.license_key}',
  logging: {{
    level: 'info',
    filepath: require('path').join(process.cwd(), 'newrelic_agent.log')
  }},

  // Allow all data to be sent to New Relic in case of usage
  allow_all_headers: true,

  // Distributed Tracing
  distributed_tracing: {{
    enabled: true
  }},

  // Application Logging
  application_logging: {{
    enabled: true,
    forwarding: {{
      enabled: true,
      max_samples_stored: 10000
    }},
    local_decorating: {{
      enabled: true
    }},
    metrics: {{
      enabled: true
    }}
  }},

  // Transaction Tracer
  transaction_tracer: {{
    enabled: true,
    transaction_threshold: 'apdex_f',
    record_sql: 'obfuscated',
    explain_threshold: 500,
    top_n: 20
  }},

  // Error Collector
  error_collector: {{
    enabled: true,
    capture_events: true,
    max_event_samples_stored: 100,
    ignore_status_codes: [404, 401],
    expected_messages: {{
      'ValidationError': ['Validation failed'],
      'AuthenticationError': ['Authentication failed']
    }}
  }},

  // Browser Monitoring
  browser_monitoring: {{
    enable: true
  }},

  // Custom Attributes
  attributes: {{
    enabled: true,
    include_enabled: true,
    exclude: [
      'request.headers.cookie',
      'request.headers.authorization',
      'request.headers.x-*',
      'response.headers.set-cookie*'
    ]
  }},

  // Custom Labels
  labels: {{
    environment: '{self.config.environment}',
    cluster: '{self.config.cluster_name}',
    team: 'platform',
    business_critical: 'true'
  }},

  // High Security Mode
  high_security: false,

  // Custom Instrumentation
  api: {{
    custom_instrumentation_editor: {{
      enabled: true
    }}
  }},

  // Rules for ignoring or renaming transactions
  rules: {{
    name: [
      {{ pattern: '^WebTransaction/Restify/GET//health.*', name: 'WebTransaction/Health/Check' }},
      {{ pattern: '^WebTransaction/Restify/GET//api/v1/orders.*', name: 'WebTransaction/API/Orders' }}
    ],
    ignore: [
      '^WebTransaction/Restify/GET//ping',
      '^WebTransaction/Restify/GET//favicon.ico'
    ]
  }},

  // Slow SQL queries
  slow_sql: {{
    enabled: true,
    max_samples: 10
  }},

  // Feature flags for experimental features
  feature_flag: {{
    custom_instrumentation_editor: true,
    native_metrics: true
  }}
}}

// Custom business event tracking
const newrelic = require('newrelic')

// Business transaction tracking
function trackBusinessEvent(eventType, attributes) {{
  newrelic.recordCustomEvent(eventType, {{
    timestamp: Date.now(),
    environment: '{self.config.environment}',
    ...attributes
  }})
}}

// Revenue tracking helper
function trackRevenue(amount, customerId, orderId) {{
  trackBusinessEvent('Revenue', {{
    amount: amount,
    customerId: customerId,
    orderId: orderId,
    currency: 'USD'
  }})
}}

// Export business tracking functions
module.exports = {{
  trackBusinessEvent,
  trackRevenue
}}
"""

        # Python Agent Configuration
        configs['newrelic.ini'] = f"""[newrelic]
# New Relic Python Agent Configuration
# https://docs.newrelic.com/docs/agents/python-agent/configuration/python-agent-configuration/

license_key = {self.config.license_key}
app_name = Production Python Application

# Distributed Tracing
distributed_tracing.enabled = true

# Application Logging
application_logging.enabled = true
application_logging.forwarding.enabled = true
application_logging.forwarding.max_samples_stored = 10000
application_logging.local_decorating.enabled = true
application_logging.metrics.enabled = true

# Transaction Tracer
transaction_tracer.enabled = true
transaction_tracer.transaction_threshold = apdex_f
transaction_tracer.record_sql = obfuscated
transaction_tracer.explain_threshold = 0.5
transaction_tracer.stack_trace_threshold = 0.5
transaction_tracer.function_trace =
    company.services.payment:process_payment
    company.models.order:create_order
    company.utils.analytics:track_event

# Error Collector
error_collector.enabled = true
error_collector.capture_events = true
error_collector.max_event_samples_stored = 100
error_collector.ignore_errors =
    requests.exceptions.ConnectionError
    requests.exceptions.Timeout
error_collector.expected_errors =
    company.exceptions:ValidationError
    company.exceptions:AuthenticationError

# Browser Monitoring
browser_monitoring.auto_instrument = true

# Database Tracing
database_tracer.enabled = true
database_tracer.record_sql = obfuscated
database_tracer.explain_threshold = 0.5

# External Services
external_service.capture_params = true

# Custom Attributes
attributes.enabled = true
attributes.include =
    request.headers.user-agent
    request.headers.referer
attributes.exclude =
    request.headers.authorization
    request.headers.cookie

# Labels
labels =
    environment:{self.config.environment};
    cluster:{self.config.cluster_name};
    team:platform;
    business_critical:true

# High Security Mode
high_security = false

# Debug Settings
log_file = /var/log/newrelic/python-agent.log
log_level = info

# Custom Events
custom_insights_events.enabled = true
custom_insights_events.max_samples_stored = 30000

# Machine Learning Model Performance
ml_insights_events.enabled = true

# Code Level Metrics
code_level_metrics.enabled = true

[newrelic:production]
app_name = Production Python Application
monitor_mode = true
log_level = info

[newrelic:staging]
app_name = Staging Python Application
monitor_mode = true
log_level = debug

[newrelic:development]
app_name = Development Python Application
monitor_mode = false
log_level = debug
developer_mode = true
"""

        # Docker Configuration
        configs['Dockerfile.newrelic'] = f"""# Multi-stage Docker build with New Relic monitoring
FROM node:18-alpine as base

# Install New Relic infrastructure agent
RUN apk add --no-cache curl gnupg && \\
    curl -o /etc/apk/keys/548C16BF.rsa.pub https://download.newrelic.com/548C16BF.rsa.pub && \\
    echo "https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64" >> /etc/apk/repositories && \\
    apk update && \\
    apk add newrelic-infra

# Application stage
FROM base as app

WORKDIR /app

# Copy New Relic configuration
COPY newrelic.js /app/
COPY newrelic-infra.yml /etc/newrelic-infra.yml

# Install Node.js dependencies including New Relic
COPY package*.json ./
RUN npm install newrelic@latest && \\
    npm install

# Copy application code
COPY . .

# Set New Relic environment variables
ENV NEW_RELIC_LICENSE_KEY={self.config.license_key}
ENV NEW_RELIC_APP_NAME="Production Docker Application"
ENV NEW_RELIC_ENVIRONMENT={self.config.environment}
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_APPLICATION_LOGGING_ENABLED=true
ENV NEW_RELIC_APPLICATION_LOGGING_FORWARDING_ENABLED=true

# Infrastructure agent configuration
ENV NRIA_LICENSE_KEY={self.config.license_key}
ENV NRIA_DISPLAY_NAME="Production-Docker-Host"
ENV NRIA_VERBOSE=0
ENV NRIA_TAGS="environment:{self.config.environment},cluster:{self.config.cluster_name}"

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \\
  CMD curl -f http://localhost:3000/health || exit 1

# Start both application and infrastructure agent
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["node", "-r", "newrelic", "server.js"]
"""

        # Docker Compose with New Relic
        configs['docker-compose.newrelic.yml'] = f"""version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.newrelic
    container_name: production-app-newrelic
    environment:
      - NEW_RELIC_LICENSE_KEY={self.config.license_key}
      - NEW_RELIC_APP_NAME=Production Docker Application
      - NEW_RELIC_ENVIRONMENT={self.config.environment}
      - NEW_RELIC_LABELS=environment:{self.config.environment};cluster:{self.config.cluster_name};team:platform
      - NRIA_LICENSE_KEY={self.config.license_key}
      - NRIA_TAGS=environment:{self.config.environment},cluster:{self.config.cluster_name}
    ports:
      - "3000:3000"
    volumes:
      - /sys:/host/sys:ro
      - /proc:/host/proc:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
    networks:
      - production-network
    depends_on:
      - database
      - redis
    restart: unless-stopped
    labels:
      - "newrelic.monitor=true"
      - "newrelic.business_critical=true"

  database:
    image: postgres:13
    container_name: production-db
    environment:
      - POSTGRES_DB=production
      - POSTGRES_USER=${{DB_USER}}
      - POSTGRES_PASSWORD=${{DB_PASSWORD}}
    volumes:
      - postgres-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - production-network
    labels:
      - "newrelic.monitor=true"
      - "newrelic.service=database"

  redis:
    image: redis:6-alpine
    container_name: production-cache
    volumes:
      - redis-data:/data
    ports:
      - "6379:6379"
    networks:
      - production-network
    labels:
      - "newrelic.monitor=true"
      - "newrelic.service=cache"

  # New Relic Infrastructure Agent (standalone container)
  newrelic-infra:
    image: newrelic/infrastructure:latest
    container_name: newrelic-infrastructure
    environment:
      - NRIA_LICENSE_KEY={self.config.license_key}
      - NRIA_DISPLAY_NAME=Production-Docker-Infrastructure
      - NRIA_VERBOSE=0
      - NRIA_TAGS=environment:{self.config.environment},cluster:{self.config.cluster_name},role:monitoring
    volumes:
      - /sys:/host/sys:ro
      - /proc:/host/proc:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /:/host:ro
    network_mode: host
    pid: host
    privileged: true
    restart: unless-stopped

volumes:
  postgres-data:
  redis-data:

networks:
  production-network:
    driver: bridge
"""

        # Kubernetes Deployment
        configs['k8s-newrelic-deployment.yaml'] = f"""apiVersion: v1
kind: Namespace
metadata:
  name: newrelic
---
apiVersion: v1
kind: Secret
metadata:
  name: newrelic-license
  namespace: newrelic
type: Opaque
stringData:
  license: "{self.config.license_key}"
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: newrelic-infrastructure
  namespace: newrelic
  labels:
    app: newrelic-infrastructure
spec:
  selector:
    matchLabels:
      name: newrelic-infrastructure
  template:
    metadata:
      labels:
        name: newrelic-infrastructure
    spec:
      serviceAccountName: newrelic
      hostNetwork: true
      hostPID: true
      hostIPC: true
      tolerations:
        - operator: Exists
      containers:
      - name: newrelic-infrastructure
        image: newrelic/infrastructure-k8s:latest
        env:
        - name: NRIA_LICENSE_KEY
          valueFrom:
            secretKeyRef:
              name: newrelic-license
              key: license
        - name: NRIA_VERBOSE
          value: "0"
        - name: NRIA_DISPLAY_NAME
          valueFrom:
            fieldRef:
              fieldPath: spec.nodeName
        - name: NRIA_CUSTOM_ATTRIBUTES
          value: "environment:{self.config.environment},cluster:{self.config.cluster_name}"
        - name: NRIA_PASSTHROUGH_ENVIRONMENT
          value: "KUBERNETES_SERVICE_HOST,KUBERNETES_SERVICE_PORT,CLUSTER_NAME,CADVISOR_PORT,CADVISOR_INTERVAL,CADVISOR_PORT_RANGE,ETCD_TLS_SECRET_NAME,ETCD_TLS_SECRET_NAMESPACE,API_SERVER_SECURE_PORT,KUBE_STATE_METRICS_URL,KUBE_STATE_METRICS_POD_LABEL_SELECTOR,TIMEOUT,ETCD_TLS_SECRET_NAME,ETCD_TLS_SECRET_NAMESPACE,API_SERVER_SECURE_PORT,KUBE_STATE_METRICS_URL,SCHEDULER_ENDPOINT_URL,ETCD_ENDPOINT_URL,CONTROLLER_MANAGER_ENDPOINT_URL,API_SERVER_ENDPOINT_URL"
        resources:
          requests:
            memory: "150Mi"
            cpu: "100m"
          limits:
            memory: "300Mi"
            cpu: "200m"
        volumeMounts:
        - name: host-volume
          mountPath: /host
          readOnly: true
        - name: dev-volume
          mountPath: /host/dev
          readOnly: true
        - name: proc-volume
          mountPath: /host/proc
          readOnly: true
        - name: sys-volume
          mountPath: /host/sys
          readOnly: true
        securityContext:
          privileged: true
      volumes:
      - name: host-volume
        hostPath:
          path: /
      - name: dev-volume
        hostPath:
          path: /dev
      - name: proc-volume
        hostPath:
          path: /proc
      - name: sys-volume
        hostPath:
          path: /sys
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: newrelic
  namespace: newrelic
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: newrelic
rules:
- apiGroups: [""]
  resources: ["nodes", "pods", "services", "endpoints", "persistentvolumes", "persistentvolumeclaims", "configmaps", "secrets", "namespaces", "events"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments", "replicasets", "daemonsets", "statefulsets"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["batch"]
  resources: ["jobs", "cronjobs"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["extensions"]
  resources: ["deployments", "ingresses"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["networking.k8s.io"]
  resources: ["ingresses"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: newrelic
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: newrelic
subjects:
- kind: ServiceAccount
  name: newrelic
  namespace: newrelic
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: production-app
  namespace: default
  labels:
    app: production-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: production-app
  template:
    metadata:
      labels:
        app: production-app
      annotations:
        newrelic.monitor: "true"
        newrelic.business_critical: "true"
    spec:
      containers:
      - name: app
        image: production-app:latest
        env:
        - name: NEW_RELIC_LICENSE_KEY
          valueFrom:
            secretKeyRef:
              name: newrelic-license
              key: license
        - name: NEW_RELIC_APP_NAME
          value: "Production Kubernetes Application"
        - name: NEW_RELIC_ENVIRONMENT
          value: "{self.config.environment}"
        - name: NEW_RELIC_LABELS
          value: "environment:{self.config.environment};cluster:{self.config.cluster_name};pod:$(POD_NAME);namespace:$(POD_NAMESPACE)"
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: POD_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        ports:
        - containerPort: 3000
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 30
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 10
"""

        return configs

    def generate_infrastructure_monitoring_configs(self) -> Dict[str, str]:
        """Generate infrastructure monitoring configurations"""
        configs = {}

        # Infrastructure Agent Configuration
        configs['newrelic-infra.yml'] = f"""# New Relic Infrastructure Agent Configuration
# https://docs.newrelic.com/docs/infrastructure/install-infrastructure-agent/configuration/infrastructure-agent-configuration-settings/

license_key: {self.config.license_key}
display_name: Production Server Infrastructure
verbose: 0
log_file: /var/log/newrelic-infra/newrelic-infra.log
log_level: info

# Custom attributes for environment tagging
custom_attributes:
  environment: {self.config.environment}
  cluster: {self.config.cluster_name}
  team: platform
  business_critical: true
  cost_center: engineering

# Enable specific integrations
enable_process_metrics: true
enable_docker: true

# Proxy settings (if needed)
# proxy: http://proxy.company.com:8080
# proxy_username: proxy_user
# proxy_password: proxy_pass

# Passthrough environment variables
passthrough_environment:
  - AWS_REGION
  - KUBERNETES_SERVICE_HOST
  - DOCKER_HOST

# Plugin directory
plugin_dir: /var/db/newrelic-infra/newrelic-integrations/bin

# Metrics settings
metrics_system_sample_rate: 30  # seconds
metrics_storage_sample_rate: 30  # seconds
metrics_network_sample_rate: 30  # seconds
metrics_process_sample_rate: 30  # seconds

# Strip command line from process samples for security
strip_command_line: false

# Docker integration settings
docker_api_version: 1.40

# Kubernetes integration settings (if applicable)
kubernetes_integration:
  enabled: true
  cluster_name: {self.config.cluster_name}

# Windows-specific settings
# windows_temp_folders_sample_rate: 300
"""

        # Cloud Integration Configuration
        configs['cloud-integrations.yml'] = f"""# New Relic Cloud Integrations Configuration

# AWS Integration
aws:
  license_key: {self.config.license_key}

  # AWS services to monitor
  integrations:
    - name: aws-ec2
      enabled: true
      interval: 300s  # 5 minutes
      inventory_source: config/ec2
      metrics: true
      inventory: true
      extended_inventory: true
      tags:
        environment: {self.config.environment}
        team: infrastructure

    - name: aws-rds
      enabled: true
      interval: 300s
      inventory_source: config/rds
      metrics: true
      inventory: true
      tags:
        environment: {self.config.environment}
        team: database

    - name: aws-elb
      enabled: true
      interval: 300s
      inventory_source: config/elb
      metrics: true
      inventory: true
      tags:
        environment: {self.config.environment}
        team: networking

    - name: aws-lambda
      enabled: true
      interval: 300s
      inventory_source: config/lambda
      metrics: true
      inventory: true
      tags:
        environment: {self.config.environment}
        team: serverless

    - name: aws-s3
      enabled: true
      interval: 300s
      inventory_source: config/s3
      metrics: true
      inventory: true
      tags:
        environment: {self.config.environment}
        team: storage

# Azure Integration
azure:
  license_key: {self.config.license_key}

  integrations:
    - name: azure-vm
      enabled: true
      interval: 300s
      resource_groups:
        - production-resources
        - staging-resources
      tags:
        environment: {self.config.environment}
        team: infrastructure

    - name: azure-sql
      enabled: true
      interval: 300s
      resource_groups:
        - database-resources
      tags:
        environment: {self.config.environment}
        team: database

# Google Cloud Integration
gcp:
  license_key: {self.config.license_key}

  integrations:
    - name: gcp-compute
      enabled: true
      interval: 300s
      project_ids:
        - production-project-123
      tags:
        environment: {self.config.environment}
        team: infrastructure

    - name: gcp-sql
      enabled: true
      interval: 300s
      project_ids:
        - production-project-123
      tags:
        environment: {self.config.environment}
        team: database
"""

        # Logging Configuration
        configs['logging.yml'] = f"""# New Relic Logging Configuration

logs:
  - name: application-logs
    file: /var/log/application/*.log
    attributes:
      service: production-app
      environment: {self.config.environment}
      team: application
      log_type: application
    pattern: '%%{{timestamp}} %%{{level}} %%{{logger}} - %%{{message}}'

  - name: system-logs
    file: /var/log/syslog
    attributes:
      service: system
      environment: {self.config.environment}
      team: infrastructure
      log_type: system

  - name: nginx-access
    file: /var/log/nginx/access.log
    attributes:
      service: nginx
      environment: {self.config.environment}
      team: platform
      log_type: access
    pattern: '%%{{remote_addr}} - %%{{remote_user}} [%%{{time_local}}] "%%{{request}}" %%{{status}} %%{{body_bytes_sent}} "%%{{http_referer}}" "%%{{http_user_agent}}"'

  - name: nginx-error
    file: /var/log/nginx/error.log
    attributes:
      service: nginx
      environment: {self.config.environment}
      team: platform
      log_type: error

  - name: database-logs
    file: /var/log/postgresql/*.log
    attributes:
      service: postgresql
      environment: {self.config.environment}
      team: database
      log_type: database

  - name: application-error
    file: /var/log/application/error.log
    attributes:
      service: production-app
      environment: {self.config.environment}
      team: application
      log_type: error
      severity: error
      alert_priority: high

# Log forwarding configuration
forwarding:
  license_key: {self.config.license_key}
  endpoint: https://log-api.{self.config.region.value.replace('api.', '')}/log/v1
  compression: gzip
  max_buffer_size: 256000
  max_events_per_second: 2500

# Log parsing rules
parsing:
  built_in_rules:
    - apache_access
    - nginx_access
    - mysql_error
    - postgresql_log

  custom_rules:
    - name: application_json
      pattern: '^%%{{timestamp:timestamp}} %%{{level:loglevel}} %%{{logger:string}} - %%{{message:json}}'
      attributes:
        log_format: json

    - name: business_events
      pattern: 'BUSINESS_EVENT: %%{{event_type:string}} - %%{{event_data:json}}'
      attributes:
        log_type: business_event
        alert_priority: medium

# Log filtering and sampling
filtering:
  # Exclude noisy debug logs in production
  exclude:
    - attribute: level
      value: DEBUG
      when: environment == '{self.config.environment}' and '{self.config.environment}' == 'production'

    - attribute: message
      pattern: '.*health check.*'
      case_sensitive: false

  # Include only critical business events
  include:
    - attribute: log_type
      value: business_event

    - attribute: level
      value: ERROR

# Sampling for high-volume logs
sampling:
  - name: debug_sampling
    rate: 0.1  # Sample 10% of debug logs
    condition:
      attribute: level
      value: DEBUG

  - name: info_sampling
    rate: 0.5  # Sample 50% of info logs
    condition:
      attribute: level
      value: INFO
"""

        return configs

### **🚀 Production Deployment Scripts**

def generate_deployment_scripts() -> Dict[str, str]:
    """Generate production deployment and setup scripts"""
    scripts = {}

    # Main installation script
    scripts['install-newrelic.sh'] = """#!/bin/bash

# New Relic Enterprise Installation Script
# Usage: ./install-newrelic.sh

set -e

# Colors for output
RED='\\033[0;31m'
GREEN='\\033[0;32m'
YELLOW='\\033[1;33m'
BLUE='\\033[0;34m'
NC='\\033[0m' # No Color

# Configuration variables
NEW_RELIC_LICENSE_KEY="${NEW_RELIC_LICENSE_KEY:-}"
NEW_RELIC_ACCOUNT_ID="${NEW_RELIC_ACCOUNT_ID:-}"
NEW_RELIC_API_KEY="${NEW_RELIC_API_KEY:-}"
ENVIRONMENT="${ENVIRONMENT:-production}"
CLUSTER_NAME="${CLUSTER_NAME:-production-cluster}"

log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root"
        exit 1
    fi
}

# Validate required environment variables
validate_config() {
    local errors=0

    if [[ -z "$NEW_RELIC_LICENSE_KEY" ]]; then
        log_error "NEW_RELIC_LICENSE_KEY environment variable is required"
        ((errors++))
    fi

    if [[ -z "$NEW_RELIC_ACCOUNT_ID" ]]; then
        log_error "NEW_RELIC_ACCOUNT_ID environment variable is required"
        ((errors++))
    fi

    if [[ -z "$NEW_RELIC_API_KEY" ]]; then
        log_error "NEW_RELIC_API_KEY environment variable is required"
        ((errors++))
    fi

    if [[ $errors -gt 0 ]]; then
        log_error "Please set required environment variables and try again"
        exit 1
    fi
}

# Detect operating system
detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
    else
        log_error "Cannot detect operating system"
        exit 1
    fi

    log_info "Detected OS: $OS $VER"
}

# Install New Relic Infrastructure Agent
install_infrastructure_agent() {
    log_step "Installing New Relic Infrastructure Agent..."

    case $OS in
        "ubuntu"|"debian")
            curl -s https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo apt-key add -
            echo "deb https://download.newrelic.com/infrastructure_agent/linux/apt $VERSION_CODENAME main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list
            apt-get update
            apt-get install -y newrelic-infra
            ;;
        "centos"|"rhel"|"fedora")
            curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
            yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
            yum install -y newrelic-infra
            ;;
        "amzn")
            curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/amazonlinux/2/x86_64/newrelic-infra.repo
            yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
            yum install -y newrelic-infra
            ;;
        *)
            log_error "Unsupported operating system: $OS"
            exit 1
            ;;
    esac

    log_info "Infrastructure agent installed successfully"
}

# Configure Infrastructure Agent
configure_infrastructure_agent() {
    log_step "Configuring Infrastructure Agent..."

    # Create configuration file
    cat << EOF > /etc/newrelic-infra.yml
license_key: $NEW_RELIC_LICENSE_KEY
display_name: $(hostname)-$ENVIRONMENT
verbose: 0
log_file: /var/log/newrelic-infra/newrelic-infra.log
log_level: info

custom_attributes:
  environment: $ENVIRONMENT
  cluster: $CLUSTER_NAME
  team: platform
  business_critical: true
  installation_method: script
  installed_at: $(date -u +"%Y-%m-%dT%H:%M:%SZ")

enable_process_metrics: true
enable_docker: true

metrics_system_sample_rate: 30
metrics_storage_sample_rate: 30
metrics_network_sample_rate: 30
metrics_process_sample_rate: 30

strip_command_line: false
EOF

    # Set proper permissions
    chmod 644 /etc/newrelic-infra.yml

    log_info "Infrastructure agent configured"
}

# Install and configure log forwarding
setup_log_forwarding() {
    log_step "Setting up log forwarding..."

    # Install Fluent Bit
    case $OS in
        "ubuntu"|"debian")
            curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh
            ;;
        "centos"|"rhel"|"fedora"|"amzn")
            curl https://raw.githubusercontent.com/fluent/fluent-bit/master/install.sh | sh
            ;;
    esac

    # Create Fluent Bit configuration for New Relic
    mkdir -p /etc/fluent-bit
    cat << EOF > /etc/fluent-bit/fluent-bit.conf
[SERVICE]
    Flush         1
    Log_Level     info
    Daemon        off
    Parsers_File  parsers.conf
    HTTP_Server   On
    HTTP_Listen   0.0.0.0
    HTTP_Port     2020

[INPUT]
    Name              tail
    Path              /var/log/application/*.log
    Multiline         On
    Parser_Firstline  multiline
    Tag               app.*

[INPUT]
    Name   systemd
    Tag    systemd.*

[OUTPUT]
    Name  newrelic
    Match *
    licenseKey $NEW_RELIC_LICENSE_KEY
    endpoint https://log-api.newrelic.com/log/v1
    maxBufferSize 256000
    maxRecords 1024
EOF

    # Start and enable Fluent Bit
    systemctl enable fluent-bit
    systemctl start fluent-bit

    log_info "Log forwarding configured"
}

# Start and enable services
start_services() {
    log_step "Starting New Relic services..."

    # Start infrastructure agent
    systemctl enable newrelic-infra
    systemctl start newrelic-infra

    # Verify services are running
    if systemctl is-active --quiet newrelic-infra; then
        log_info "Infrastructure agent is running"
    else
        log_error "Failed to start infrastructure agent"
        systemctl status newrelic-infra
        exit 1
    fi

    if systemctl is-active --quiet fluent-bit; then
        log_info "Log forwarding is running"
    else
        log_warn "Log forwarding may not be running properly"
    fi
}

# Create monitoring user and directories
setup_monitoring_user() {
    log_step "Setting up monitoring user and directories..."

    # Create newrelic user if it doesn't exist
    if ! id "newrelic" &>/dev/null; then
        useradd -r -s /bin/false -d /var/lib/newrelic newrelic
        log_info "Created newrelic user"
    fi

    # Create directories
    mkdir -p /var/log/newrelic-infra
    mkdir -p /var/lib/newrelic
    mkdir -p /etc/newrelic

    # Set permissions
    chown -R newrelic:newrelic /var/log/newrelic-infra
    chown -R newrelic:newrelic /var/lib/newrelic
    chmod 755 /etc/newrelic

    log_info "Monitoring directories configured"
}

# Install application agents based on detected services
install_application_agents() {
    log_step "Detecting and installing application agents..."

    # Check for Java applications
    if command -v java &> /dev/null || [[ -d /opt/java ]] || [[ -d /usr/lib/jvm ]]; then
        log_info "Java detected - installing Java agent"
        mkdir -p /opt/newrelic/java
        curl -L "https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-java.zip" -o /tmp/newrelic-java.zip
        unzip -q /tmp/newrelic-java.zip -d /opt/newrelic/java
        chown -R newrelic:newrelic /opt/newrelic/java

        # Create basic configuration
        cat << EOF > /opt/newrelic/java/newrelic/newrelic.yml
common: &default_settings
  license_key: '$NEW_RELIC_LICENSE_KEY'
  app_name: 'Production Java Application'
  distributed_tracing:
    enabled: true
  application_logging:
    enabled: true
    forwarding:
      enabled: true
  labels:
    environment: $ENVIRONMENT
    cluster: $CLUSTER_NAME

production:
  <<: *default_settings
EOF
    fi

    # Check for Node.js applications
    if command -v node &> /dev/null || command -v npm &> /dev/null; then
        log_info "Node.js detected - configuration available for npm install newrelic"
        log_info "Add 'newrelic' to your package.json and require('newrelic') at the top of your main file"
    fi

    # Check for Python applications
    if command -v python &> /dev/null || command -v python3 &> /dev/null; then
        log_info "Python detected - configuration available for pip install newrelic"
        log_info "Add newrelic-admin run-program to your application startup"
    fi

    # Check for .NET applications
    if command -v dotnet &> /dev/null; then
        log_info ".NET detected - install New Relic .NET agent from https://docs.newrelic.com/docs/agents/net-agent/"
    fi
}

# Verify installation
verify_installation() {
    log_step "Verifying installation..."

    local errors=0

    # Check infrastructure agent
    if systemctl is-active --quiet newrelic-infra; then
        log_info "✓ Infrastructure agent is running"
    else
        log_error "✗ Infrastructure agent is not running"
        ((errors++))
    fi

    # Check if data is being sent
    sleep 30  # Wait for initial data collection

    log_info "Checking connectivity to New Relic..."
    if curl -s --max-time 10 "https://api.newrelic.com/v2/applications.json" -H "Api-Key:$NEW_RELIC_API_KEY" > /dev/null; then
        log_info "✓ Successfully connected to New Relic API"
    else
        log_warn "⚠ Could not verify API connectivity - check your API key"
    fi

    if [[ $errors -eq 0 ]]; then
        log_info "✅ Installation completed successfully!"
    else
        log_error "❌ Installation completed with $errors errors"
        exit 1
    fi
}

# Display post-installation information
show_post_install_info() {
    log_step "Installation Complete!"

    cat << EOF

🎉 New Relic Enterprise Installation Complete!

📊 Account Information:
   Account ID: $NEW_RELIC_ACCOUNT_ID
   Environment: $ENVIRONMENT
   Cluster: $CLUSTER_NAME

🖥️  Infrastructure Monitoring:
   • Agent Status: systemctl status newrelic-infra
   • Configuration: /etc/newrelic-infra.yml
   • Logs: /var/log/newrelic-infra/newrelic-infra.log

📝 Log Forwarding:
   • Fluent Bit Status: systemctl status fluent-bit
   • Configuration: /etc/fluent-bit/fluent-bit.conf

🔗 Useful Links:
   • New Relic One: https://one.newrelic.com
   • Infrastructure: https://one.newrelic.com/launcher/nr1-core.explorer
   • Logs: https://one.newrelic.com/launcher/logger.log-launcher
   • Documentation: https://docs.newrelic.com

📋 Next Steps:
   1. Verify data is appearing in New Relic One
   2. Install application agents for your services
   3. Configure custom dashboards and alerts
   4. Set up Slack/PagerDuty notifications

For support: https://support.newrelic.com

EOF
}

# Main execution
main() {
    log_info "Starting New Relic Enterprise Installation..."

    check_root
    validate_config
    detect_os
    setup_monitoring_user
    install_infrastructure_agent
    configure_infrastructure_agent
    setup_log_forwarding
    install_application_agents
    start_services
    verify_installation
    show_post_install_info

    log_info "🚀 New Relic Enterprise setup completed successfully!"
}

# Run main function
main "$@"
"""

    return scripts

if __name__ == "__main__":
    main()

if __name__ == "__main__":
    main()
```
