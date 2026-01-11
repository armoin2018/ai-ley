---
name: 'Enterprise Netlify JAMstack Platform Instructions'
description: 'Enterprise-grade Netlify platform for JAMstack deployment, serverless functions, edge computing, team collaboration, and advanced performance optimization with comprehensive monitoring and security features'
keywords: [api, cloud, enterprise, frontend, async, example, architecture, database, cli, framework]
---


# Enterprise Netlify JAMstack Platform Instructions

## Tool Overview

- **Tool Name**: Netlify Enterprise Platform
- **Version**: Latest Enterprise Platform with CLI 17.0+ (Edge Functions, Team Management, Advanced Analytics)
- **Category**: Cloud Platforms - Enterprise JAMstack Deployment
- **Purpose**: Enterprise-grade deployment platform for JAMstack applications with advanced team collaboration, performance optimization, security features, and comprehensive monitoring
- **Prerequisites**: Enterprise Netlify account, Git repository, modern web application (React, Vue, Angular, Gatsby, Next.js), Node.js 18+ for CLI, team management access

## Enterprise Platform Architecture

`See [example-1](./examples/netlify/example-1.python)python
async def deploy_ecommerce_jamstack():
    """Example: Deploy enterprise e-commerce JAMstack site on Netlify"""

    # Initialize enterprise configuration
    config = EnterpriseNetlifyConfig(
        team_id="ecommerce-team",
        organization_name="ShopCorp",
        tier=NetlifyTier.BUSINESS,
        environment=NetlifyEnvironment.PRODUCTION,
        site_type=NetlifySiteType.JAMSTACK,
        framework=NetlifyFramework.GATSBY,
        regions=[NetlifyRegion.GLOBAL],
        domains_config={
            "custom_domains": ["shop.shopcorp.com", "www.shop.shopcorp.com"],
            "ssl_certificates": "automatic",
            "ssl_settings": {
                "force_https": True,
                "hsts_enabled": True,
                "hsts_max_age": 31536000
            },
            "domain_redirects": {
                "shopcorp.shop": "shop.shopcorp.com"
            }
        },
        security_settings={
            "headers": {
                "content_security_policy": "default-src 'self'; script-src 'self' 'unsafe-inline' https://js.stripe.com https://checkout.stripe.com; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:",
                "x_frame_options": "DENY",
                "x_content_type_options": "nosniff"
            },
            "threat_protection": {
                "ddos_protection": True,
                "rate_limiting": {
                    "enabled": True,
                    "requests_per_minute": 500,
                    "burst_limit": 1000
                },
                "bot_detection": True
            }
        },
        functions_config={
            "serverless_functions": {
                "runtime": "nodejs18.x",
                "timeout": 26,
                "memory_size": 1024,
                "environment_variables": {
                    "STRIPE_SECRET_KEY": "${STRIPE_SECRET_KEY}",
                    "DATABASE_URL": "${DATABASE_URL}",
                    "JWT_SECRET": "${JWT_SECRET}"
                }
            },
            "edge_functions": {
                "enabled": True,
                "runtime": "deno",
                "regions": ["global"],
                "cache_ttl": 300  # 5 minutes for dynamic content
            }
        },
        integrations={
            "git": {
                "provider": "github",
                "auto_deploy_branches": ["main"],
                "deploy_preview_branches": ["develop", "feature/*"]
            },
            "analytics": {
                "netlify_analytics": {"enabled": True},
                "google_analytics": {"enabled": True, "tracking_id": "GA-XXXXXXXXX"}
            },
            "cms_integration": {
                "contentful": {
                    "enabled": True,
                    "space_id": "contentful-space-id",
                    "access_token": "${CONTENTFUL_ACCESS_TOKEN}"
                }
            }
        }
    )

    # Initialize enterprise platform
    platform = EnterpriseNetlifyPlatform(config)

    # Setup the platform
    setup_result = await platform.setup_enterprise_platform()
    print(f"Platform setup: {setup_result['status']}")

    # Deploy the e-commerce site
    ecommerce_site = {
        "name": "ecommerce-storefront",
        "repo": "github:shopcorp/ecommerce-site",
        "build_settings": {
            "build_command": "gatsby build",
            "publish_directory": "public",
            "environment_variables": {
                "GATSBY_STRIPE_PUBLISHABLE_KEY": "${GATSBY_STRIPE_PUBLISHABLE_KEY}",
                "GATSBY_CONTENTFUL_SPACE_ID": "${GATSBY_CONTENTFUL_SPACE_ID}",
                "GATSBY_CONTENTFUL_ACCESS_TOKEN": "${GATSBY_CONTENTFUL_ACCESS_TOKEN}"
            }
        },
        "functions": {
            "checkout": {
                "handler": "netlify/functions/checkout.js",
                "runtime": "nodejs18.x",
                "timeout": 26,
                "memory": 512
            },
            "inventory": {
                "handler": "netlify/functions/inventory.js",
                "runtime": "nodejs18.x",
                "timeout": 10,
                "memory": 256
            },
            "user-auth": {
                "handler": "netlify/functions/user-auth.js",
                "runtime": "nodejs18.x",
                "timeout": 15,
                "memory": 256
            }
        },
        "edge_functions": {
            "personalization": {
                "handler": "netlify/edge-functions/personalize.ts",
                "path": "/api/personalize/*"
            },
            "geolocation-pricing": {
                "handler": "netlify/edge-functions/geo-pricing.ts",
                "path": "/api/pricing/*"
            }
        },
        "redirects": [
            {"from": "/products/old-category/*", "to": "/products/new-category/:splat", "status": 301},
            {"from": "/checkout", "to": "/cart", "status": 302, "conditions": {"Role": "guest"}}
        ]
    }

    deployment_result = await platform.deploy_enterprise_site(ecommerce_site)
    print(f"E-commerce deployment: {deployment_result['status']}")

    # Setup progressive deployment
    deployment_manager = EnterpriseNetlifyDeploymentManager(config)
    await deployment_manager.setup_deployment_strategies()

    progressive_config = {
        "strategy": "progressive_deployment",
        "phases": [
            {"percentage": 10, "duration": "1h", "success_criteria": "error_rate < 1%"},
            {"percentage": 50, "duration": "4h", "success_criteria": "error_rate < 2%"},
            {"percentage": 100, "duration": "∞", "success_criteria": "error_rate < 5%"}
        ]
    }

    progressive_deployment = await deployment_manager.execute_deployment(
        "ecommerce-storefront",
        progressive_config
    )

    # Setup monitoring and cost management
    cost_manager = EnterpriseNetlifyCostManager(config)
    cost_monitoring = await cost_manager.setup_cost_monitoring()
    cost_analysis = await cost_manager.analyze_usage_and_costs()

    return {
        "platform_setup": setup_result,
        "deployment": deployment_result,
        "progressive_deployment": progressive_deployment,
        "cost_analysis": cost_analysis
    }

### Example 2: Multi-Site Marketing Platform

See [example-2](./examples/netlify/example-2.python)python
async def deploy_saas_application():
    """Example: Deploy SaaS application with microservices architecture"""

    config = EnterpriseNetlifyConfig(
        team_id="saas-platform",
        organization_name="SaaSTech",
        tier=NetlifyTier.ENTERPRISE,
        environment=NetlifyEnvironment.PRODUCTION,
        site_type=NetlifySiteType.SPA,
        framework=NetlifyFramework.REACT,
        team_management={
            "sso_enabled": True,
            "sso_provider": "auth0",
            "role_based_access": True,
            "roles": [
                {
                    "name": "admin",
                    "permissions": ["full_access", "billing_management", "team_management"]
                },
                {
                    "name": "developer",
                    "permissions": ["site_deploy", "function_management", "analytics_view"]
                },
                {
                    "name": "designer",
                    "permissions": ["preview_access", "content_edit"]
                }
            ],
            "two_factor_required": True
        },
        functions_config={
            "serverless_functions": {
                "runtime": "nodejs18.x",
                "timeout": 26,
                "memory_size": 1024,
                "environment_variables": {
                    "DATABASE_URL": "${DATABASE_URL}",
                    "REDIS_URL": "${REDIS_URL}",
                    "JWT_SECRET": "${JWT_SECRET}",
                    "STRIPE_SECRET_KEY": "${STRIPE_SECRET_KEY}"
                }
            }
        }
    )

    platform = EnterpriseNetlifyPlatform(config)
    setup_result = await platform.setup_enterprise_platform()

    # Deploy main SaaS application
    saas_app = {
        "name": "saas-frontend",
        "repo": "github:saastech/frontend",
        "build_settings": {
            "build_command": "react-scripts build",
            "publish_directory": "build",
            "environment_variables": {
                "REACT_APP_API_URL": "${REACT_APP_API_URL}",
                "REACT_APP_AUTH0_DOMAIN": "${REACT_APP_AUTH0_DOMAIN}",
                "REACT_APP_AUTH0_CLIENT_ID": "${REACT_APP_AUTH0_CLIENT_ID}"
            }
        },
        "functions": {
            "api-gateway": {
                "handler": "netlify/functions/api-gateway.js",
                "runtime": "nodejs18.x",
                "timeout": 26,
                "memory": 1024
            },
            "user-management": {
                "handler": "netlify/functions/users.js",
                "runtime": "nodejs18.x",
                "timeout": 15,
                "memory": 512
            },
            "billing": {
                "handler": "netlify/functions/billing.js",
                "runtime": "nodejs18.x",
                "timeout": 20,
                "memory": 512
            },
            "analytics": {
                "handler": "netlify/functions/analytics.js",
                "runtime": "nodejs18.x",
                "timeout": 10,
                "memory": 256
            }
        },
        "edge_functions": {
            "auth-middleware": {
                "handler": "netlify/edge-functions/auth.ts",
                "path": "/api/*"
            },
            "rate-limiter": {
                "handler": "netlify/edge-functions/rate-limit.ts",
                "path": "/api/*"
            }
        }
    }

    deployment_result = await platform.deploy_enterprise_site(saas_app)

    # Setup atomic deployment for production releases
    deployment_manager = EnterpriseNetlifyDeploymentManager(config)
    await deployment_manager.setup_deployment_strategies()

    atomic_config = {
        "strategy": "atomic_deployment",
        "pre_deployment_checks": [
            "build_success", "test_pass", "security_scan", "performance_test"
        ],
        "deployment_verification": {
            "health_check_url": "/api/health",
            "expected_status": 200

*Content optimized for conciseness. See source history or external references for full details.*

---
version: 2.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 5.0

---
version: 2.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 5.0
