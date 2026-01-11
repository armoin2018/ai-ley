# Full backup with mysqldump
mysqldump -h localhost -u backup_user -p \
  --single-transaction \
  --routines \
  --triggers \
  --all-databases > full_backup.sql

# Database-specific backup
mysqldump -h localhost -u backup_user -p \
  --single-transaction \
  --routines \
  --triggers \
  myapp > myapp_backup.sql

# Compressed backup
mysqldump -h localhost -u backup_user -p \
  --single-transaction \
  myapp | gzip > myapp_backup.sql.gz

# Binary log backup for point-in-time recovery
mysqlbinlog --start-datetime="2024-01-01 00:00:00" \
  --stop-datetime="2024-01-01 23:59:59" \
  /var/log/mysql/mysql-bin.000001 > binlog_backup.sql

# Physical backup with MySQL Enterprise Backup (commercial)
mysqlbackup --backup-dir=/backup/full \
  --with-timestamp \
  backup-and-apply-log