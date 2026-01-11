#!/bin/bash
# PostgreSQL backup automation
BACKUP_DIR="/backups/postgres"
DB_NAME="production"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

pg_dump -h localhost -U postgres -d $DB_NAME \
  --verbose --clean --create --format=custom \
  --file="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.dump"

# Retention policy - keep 30 days
find $BACKUP_DIR -name "*.dump" -mtime +30 -delete