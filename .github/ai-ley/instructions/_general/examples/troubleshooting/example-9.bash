# System-level database troubleshooting
# Check disk I/O
iostat -x 1 5

# Monitor database processes
top -p $(pgrep mysql)

# Check disk space
df -h /var/lib/mysql

# Analyze MySQL error log
tail -f /var/log/mysql/error.log | grep -E "ERROR|WARNING"