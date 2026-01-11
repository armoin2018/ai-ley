# Production deployment
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d
docker compose --profile production up -d

# Scaling services
docker compose up -d --scale web=3            # Scale web service to 3 instances

# Health checks and monitoring
docker compose ps --format table              # Formatted service status
watch docker compose ps                       # Monitor services

# Backup and restore
docker compose exec db pg_dump -U user myapp > backup.sql
docker compose exec -T db psql -U user myapp < backup.sql