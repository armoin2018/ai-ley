# System Health Monitoring Script
#!/bin/bash
ALERT_THRESHOLD=5

check_system_health() {
    local broken_count=$(dpkg --audit 2>/dev/null | grep "Package" | wc -l)
    
    if [ "$broken_count" -gt "$ALERT_THRESHOLD" ]; then
        echo "ALERT: $broken_count broken packages detected" | \
        mail -s "DPKG System Alert" admin@example.com
    fi
    
    # Log system state
    echo "$(date): $broken_count broken packages" >> /var/log/dpkg-health.log
}

# Schedule health checks
echo "0 */6 * * * /usr/local/bin/check_system_health" | crontab -