# Full restore from mysqldump
mysql -h localhost -u root -p < full_backup.sql

# Database-specific restore
mysql -h localhost -u root -p myapp < myapp_backup.sql

# Point-in-time recovery
# 1. Restore from full backup
mysql -h localhost -u root -p < full_backup.sql

# 2. Apply binary logs up to specific point
mysql -h localhost -u root -p < binlog_backup.sql

# Selective table restore
mysqldump -h localhost -u backup_user -p \
  --single-transaction \
  myapp users | mysql -h localhost -u root -p myapp