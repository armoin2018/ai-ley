# Enterprise Datadog Management Commands

# Agent Management
docker-compose exec datadog-agent agent status
docker-compose exec datadog-agent agent check <check_name>
docker-compose exec datadog-agent agent secret

# APM Tracing
curl -X GET "https://api.${DD_SITE}/api/v1/apm/services"
  -H "DD-API-KEY: ${DD_API_KEY}"
  -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"

# Custom Metrics Submission
curl -X POST "https://api.${DD_SITE}/api/v1/series"
  -H "Content-Type: application/json"
  -H "DD-API-KEY: ${DD_API_KEY}"
  -d '{
    "series": [{
      "metric": "business.revenue.hourly",
      "points": [['$(date +%s)', 1500.0]],
      "tags": ["env:production", "service:payment"]
    }]
  }'

# Monitor Management
curl -X POST "https://api.${DD_SITE}/api/v1/monitor"
  -H "Content-Type: application/json"
  -H "DD-API-KEY: ${DD_API_KEY}"
  -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"
  -d @monitor_config.json

# Dashboard Operations
curl -X GET "https://api.${DD_SITE}/api/v1/dashboard"
  -H "DD-API-KEY: ${DD_API_KEY}"
  -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"

# Synthetics Tests
curl -X POST "https://api.${DD_SITE}/api/v1/synthetics/tests"
  -H "Content-Type: application/json"
  -H "DD-API-KEY: ${DD_API_KEY}"
  -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"
  -d '{
    "name": "API Health Check",
    "type": "api",
    "config": {
      "request": {
        "method": "GET",
        "url": "https://api.production.com/health"
      },
      "assertions": [{
        "type": "statusCode",
        "operator": "is",
        "target": 200
      }]
    },
    "locations": ["aws:us-east-1"],
    "options": {"tick_every": 300}
  }'

# Log Management
curl -X POST "https://http-intake.logs.${DD_SITE}/v1/input/${DD_API_KEY}"
  -H "Content-Type: application/json"
  -d '{
    "message": "Application started successfully",
    "level": "info",
    "service": "web-service",
    "timestamp": "'$(date -u +%Y-%m-%dT%H:%M:%S.000Z)'"
  }'

# Health & Status Checks
curl -f http://localhost:5555/live    # Agent liveness
curl -f http://localhost:5555/ready   # Agent readiness
datadog-agent health                   # Agent health check
datadog-agent version                  # Version information