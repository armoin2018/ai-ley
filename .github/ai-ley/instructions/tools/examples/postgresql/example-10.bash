#!/bin/bash
# automated_maintenance.sh

DB_NAME="myapp"
DB_USER="postgres"
LOG_FILE="/var/log/postgresql/maintenance.log"

echo "$(date): Starting automated maintenance" >> $LOG_FILE

# Function to log messages
log_message() {
    echo "$(date): $1" >> $LOG_FILE
}

# Check for tables needing vacuum
TABLES_NEED_VACUUM=$(psql -U $DB_USER -d $DB_NAME -t -c "
    SELECT tablename
    FROM pg_stat_user_tables
    WHERE n_dead_tup > 1000
      AND (n_dead_tup * 100.0 / GREATEST(n_live_tup + n_dead_tup, 1)) > 10
")

for table in $TABLES_NEED_VACUUM; do
    log_message "Vacuuming table: $table"
    psql -U $DB_USER -d $DB_NAME -c "VACUUM ANALYZE $table;" >> $LOG_FILE 2>&1
done

# Update statistics for all tables
log_message "Updating database statistics"
psql -U $DB_USER -d $DB_NAME -c "ANALYZE;" >> $LOG_FILE 2>&1

# Cleanup old WAL files if using archive mode
if [ -d "/var/lib/postgresql/wal_archive" ]; then
    log_message "Cleaning old WAL files"
    find /var/lib/postgresql/wal_archive -name "*.backup" -mtime +7 -delete
fi

log_message "Maintenance completed"