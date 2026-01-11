# Comprehensive log analysis workflow

# 1. Identify relevant log sources
LOG_SOURCES=(
  "/var/log/application/app.log"
  "/var/log/nginx/access.log" 
  "/var/log/nginx/error.log"
  "/var/log/mysql/error.log"
  "/var/log/syslog"
)

# 2. Define time window of interest
START_TIME="2024-01-15 14:00:00"
END_TIME="2024-01-15 15:00:00"

# 3. Extract logs for time window
for log_file in "${LOG_SOURCES[@]}"; do
  echo "=== Analyzing $log_file ==="
  
  # Extract time-windowed logs
  awk -v start="$START_TIME" -v end="$END_TIME" '
    $0 >= start && $0 <= end {print}
  ' "$log_file" > "filtered_$(basename $log_file)"
  
  # Count error patterns
  grep -i error "filtered_$(basename $log_file)" | \
    cut -d' ' -f5- | sort | uniq -c | sort -nr
  
  # Check for common issues
  echo "--- Connection Issues ---"
  grep -i "connection\|timeout\|refused" "filtered_$(basename $log_file)"
  
  echo "--- Memory Issues ---"
  grep -i "memory\|oom\|out of memory" "filtered_$(basename $log_file)"
  
  echo "--- Performance Issues ---"
  grep -i "slow\|performance\|timeout" "filtered_$(basename $log_file)"
done

# 4. Cross-reference logs for correlation
echo "=== Cross-referencing logs ==="
# Find common timestamps across error logs
grep -h "ERROR\|FATAL" filtered_*.log | \
  cut -d' ' -f1-2 | sort | uniq -c | sort -nr | head -10