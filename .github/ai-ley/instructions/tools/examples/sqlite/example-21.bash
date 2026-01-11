#!/bin/bash
# sqlite_monitor.sh - SQLite Performance Monitoring Script

DATABASE_PATH="${1:-app.db}"
MONITOR_DURATION="${2:-60}"  # Monitor for 60 seconds by default
LOG_FILE="sqlite_performance.log"

if [ ! -f "$DATABASE_PATH" ]; then
    echo "Error: Database file '$DATABASE_PATH' not found"
    exit 1
fi

echo "Monitoring SQLite database: $DATABASE_PATH"
echo "Duration: ${MONITOR_DURATION} seconds"
echo "Log file: $LOG_FILE"
echo "Started at: $(date)"

# Function to get database size
get_db_size() {
    du -h "$DATABASE_PATH" | cut -f1
}

# Function to get SQLite process info
get_process_info() {
    ps aux | grep sqlite | grep -v grep | head -5
}

# Function to check for database locks
check_locks() {
    if command -v lsof >/dev/null 2>&1; then
        lsof "$DATABASE_PATH" 2>/dev/null | wc -l
    else
        echo "lsof not available"
    fi
}

# Function to run SQLite diagnostics
run_diagnostics() {
    sqlite3 "$DATABASE_PATH" <<EOF
.timeout 5000
SELECT 'Database Info:' as info;
PRAGMA database_list;

SELECT 'Page Info:' as info;
SELECT
    'Total Pages: ' || (SELECT * FROM pragma_page_count()) ||
    ', Page Size: ' || (SELECT * FROM pragma_page_size()) ||
    ', Free Pages: ' || (SELECT * FROM pragma_freelist_count()) ||
    ', Size: ' || ROUND((SELECT * FROM pragma_page_count()) * (SELECT * FROM pragma_page_size()) / 1024.0 / 1024.0, 2) || ' MB';

SELECT 'WAL Info:' as info;
PRAGMA wal_checkpoint(PASSIVE);

SELECT 'Schema Info:' as info;
SELECT type, name, COUNT(*) as count
FROM sqlite_master
WHERE type IN ('table', 'index', 'trigger', 'view')
GROUP BY type;

SELECT 'Table Sizes:' as info;
SELECT
    name as table_name,
    (SELECT COUNT(*) FROM sqlite_master WHERE type='index' AND tbl_name=m.name) as index_count
FROM sqlite_master m
WHERE type='table' AND name NOT LIKE 'sqlite_%'
ORDER BY name;
EOF
}

# Initialize log file
{
    echo "SQLite Performance Monitor Started: $(date)"
    echo "Database: $DATABASE_PATH"
    echo "Monitor Duration: ${MONITOR_DURATION}s"
    echo "============================================"
} > "$LOG_FILE"

# Run initial diagnostics
echo "Running initial diagnostics..."
{
    echo ""
    echo "=== INITIAL DIAGNOSTICS ==="
    run_diagnostics
    echo ""
} >> "$LOG_FILE"

# Monitor loop
START_TIME=$(date +%s)
COUNTER=0

while [ $(($(date +%s) - START_TIME)) -lt $MONITOR_DURATION ]; do
    CURRENT_TIME=$(date)
    DB_SIZE=$(get_db_size)
    LOCK_COUNT=$(check_locks)

    {
        echo "=== MONITORING CYCLE $COUNTER - $CURRENT_TIME ==="
        echo "Database Size: $DB_SIZE"
        echo "Active Connections: $LOCK_COUNT"
        echo ""
    } >> "$LOG_FILE"

    # Show progress
    echo "Monitoring... Cycle $COUNTER (Size: $DB_SIZE, Connections: $LOCK_COUNT)"

    COUNTER=$((COUNTER + 1))
    sleep 10
done

# Final diagnostics
echo "Running final diagnostics..."
{
    echo ""
    echo "=== FINAL DIAGNOSTICS ==="
    run_diagnostics
    echo ""
    echo "=== MONITORING COMPLETED: $(date) ==="
} >> "$LOG_FILE"

echo "Monitoring completed. Check $LOG_FILE for detailed results."

# Summary
echo ""
echo "=== MONITORING SUMMARY ==="
echo "Database: $DATABASE_PATH"
echo "Final Size: $(get_db_size)"
echo "Monitoring Cycles: $COUNTER"
echo "Log File: $LOG_FILE"
echo "Completed at: $(date)"