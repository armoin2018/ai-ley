# Full database backup
mysqldump -u root -p --all-databases --single-transaction --routines --triggers > full_backup.sql

# Incremental backup with binary logs
mysqlbinlog mysql-bin.000001 > incremental_backup.sql

# Point-in-time recovery
mysql -u root -p < full_backup.sql
mysql -u root -p < incremental_backup.sql