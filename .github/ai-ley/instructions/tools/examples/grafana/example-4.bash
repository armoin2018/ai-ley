# Enterprise Grafana Management Commands

# Docker Deployment
docker-compose up -d --build
docker-compose logs -f grafana
docker-compose exec grafana grafana-cli admin reset-admin-password admin

# Enterprise License Management
curl -X POST
  http://admin:admin@localhost:3000/api/admin/settings
  -H 'Content-Type: application/json'
  -d '{"enterprise": {"licenseText": "LICENSE_KEY_HERE"}}'

# Backup Operations
docker-compose exec postgres pg_dump -U grafana grafana > grafana_backup.sql
docker-compose cp grafana:/var/lib/grafana ./grafana_data_backup

# SSL Certificate Management
openssl req -x509 -nodes -days 365 -newkey rsa:2048
  -keyout server.key -out server.crt
  -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=grafana.company.com"

# Health Monitoring
curl -f http://localhost:3000/api/health
curl -f http://localhost:3000/metrics

# User Management
curl -X POST
  http://admin:admin@localhost:3000/api/admin/users
  -H 'Content-Type: application/json'
  -d '{"name":"John Doe","email":"john@company.com","login":"john","password":"password","role":"Editor"}'

# Dashboard Management
curl -X POST
  http://admin:admin@localhost:3000/api/dashboards/db
  -H 'Content-Type: application/json'
  -d @dashboard.json

# Alert Management
curl -X GET
  http://admin:admin@localhost:3000/api/alerts
  -H 'Content-Type: application/json'

# Performance Monitoring
docker stats grafana-enterprise
docker-compose exec prometheus promtool query instant 'grafana_http_request_duration_seconds'