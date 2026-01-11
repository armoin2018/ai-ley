#!/bin/bash
# mysql_backup.sh

DB_NAME="myapp"
DB_USER="backup_user"
DB_PASS="secure_password"
BACKUP_DIR="/backup/mysql"
DATE=$(date +%Y%m%d_%H%M%S)
LOG_FILE="/var/log/mysql_backup.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" | tee -a $LOG_FILE
}

# Create backup directory
mkdir -p $BACKUP_DIR

# Full backup with compression
log_message "Starting backup for database: $DB_NAME"
mysqldump --user=$DB_USER --password=$DB_PASS \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --hex-blob \
    --set-gtid-purged=OFF \
    --databases $DB_NAME | gzip > $BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz

if [ $? -eq 0 ]; then
    log_message "Backup completed successfully: ${DB_NAME}_${DATE}.sql.gz"

    # Remove backups older than 7 days
    find $BACKUP_DIR -name "${DB_NAME}_*.sql.gz" -mtime +7 -delete
    log_message "Cleaned up old backups"

    # Verify backup integrity
    gunzip -t $BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz
    if [ $? -eq 0 ]; then
        log_message "Backup integrity verified"
    else
        log_message "ERROR: Backup integrity check failed"
    fi
else
    log_message "ERROR: Backup failed"
    exit 1
fi

# Binary log backup for point-in-time recovery
BINLOG_DIR="/var/lib/mysql"
BINLOG_BACKUP_DIR="$BACKUP_DIR/binlogs"
mkdir -p $BINLOG_BACKUP_DIR

# Copy binary logs (except current one)
mysql --user=$DB_USER --password=$DB_PASS -e "FLUSH LOGS;"
for binlog in $(mysql --user=$DB_USER --password=$DB_PASS -e "SHOW BINARY LOGS;" | awk 'NR>1 {print $1}' | head -n -1); do
    if [ ! -f "$BINLOG_BACKUP_DIR/$binlog" ]; then
        cp "$BINLOG_DIR/$binlog" "$BINLOG_BACKUP_DIR/"
        log_message "Copied binary log: $binlog"
    fi
done

log_message "Backup process completed"