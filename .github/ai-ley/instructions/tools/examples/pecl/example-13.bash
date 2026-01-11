# Extension Health Monitoring
#!/bin/bash
# extension-health-check.sh

HEALTH_LOG="/var/log/php-extensions-health.log"
ALERT_EMAIL="admin@example.com"

check_extension_health() {
    local extension="$1"
    local health_status="HEALTHY"
    local issues=()
    
    # Check if extension is loaded
    if ! php -m | grep -q "^$extension$"; then
        health_status="CRITICAL"
        issues+=("Extension not loaded")
    fi
    
    # Check extension version
    local current_version=$(php --re "$extension" 2>/dev/null | grep "Extension" | head -1)
    if [[ -z "$current_version" ]]; then
        health_status="WARNING"
        issues+=("Cannot determine version")
    fi
    
    # Check for error logs
    local error_count=$(grep -c "$extension" /var/log/php_errors.log 2>/dev/null || echo 0)
    if [[ $error_count -gt 10 ]]; then
        health_status="WARNING"
        issues+=("High error count: $error_count")
    fi
    
    # Log health status
    echo "$(date): $extension - $health_status - ${issues[*]}" >> "$HEALTH_LOG"
    
    # Send alerts for critical issues
    if [[ "$health_status" == "CRITICAL" ]]; then
        echo "CRITICAL: $extension extension issues: ${issues[*]}" | \
        mail -s "PHP Extension Alert: $extension" "$ALERT_EMAIL"
    fi
    
    return 0
}

# Monitor all PECL extensions
for extension in $(pecl list | tail -n +4 | awk '{print $1}'); do
    check_extension_health "$extension"
done

# System resource monitoring
echo "$(date): PHP Extension Memory Usage:" >> "$HEALTH_LOG"
php -r "echo 'Memory: ' . memory_get_usage(true) . ' bytes\n';" >> "$HEALTH_LOG"