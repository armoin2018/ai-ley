# Comprehensive System Health Check
#!/bin/bash
# pecl-system-health.sh

HEALTH_REPORT="/tmp/pecl-health-$(date +%Y%m%d-%H%M).json"

generate_health_report() {
    local report_data="{
        \"timestamp\": \"$(date -Iseconds)\",
        \"php_version\": \"$(php -v | head -1)\",
        \"pecl_version\": \"$(pecl version)\",
        \"extensions\": [],
        \"system_info\": {},
        \"performance_metrics\": {}
    }"
    
    # Extension information
    local extensions_json="["
    local first=true
    
    for extension in $(pecl list | tail -n +4 | awk '{print $1}'); do
        if [[ "$first" = true ]]; then
            first=false
        else
            extensions_json+=","
        fi
        
        local version=$(pecl list | grep "^$extension" | awk '{print $2}')
        local loaded=$(php -m | grep -q "^$extension$" && echo "true" || echo "false")
        local config_file="/etc/php/8.1/mods-available/${extension}.ini"
        local has_config=$(test -f "$config_file" && echo "true" || echo "false")
        
        extensions_json+="{
            \"name\": \"$extension\",
            \"version\": \"$version\",
            \"loaded\": $loaded,
            \"has_config\": $has_config
        }"
    done
    extensions_json+="]"
    
    # System information
    local memory_usage=$(free -m | grep '^Mem:' | awk '{print $3}')
    local disk_usage=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
    local load_average=$(uptime | awk -F'load average:' '{print $2}' | cut -d',' -f1 | xargs)
    
    # Create final report
    cat > "$HEALTH_REPORT" << EOF
{
    "timestamp": "$(date -Iseconds)",
    "php_version": "$(php -v | head -1 | cut -d' ' -f2)",
    "pecl_version": "$(pecl version)",
    "extensions": $extensions_json,
    "system_info": {
        "memory_usage_mb": $memory_usage,
        "disk_usage_percent": $disk_usage,
        "load_average": $load_average,
        "uptime": "$(uptime -p)"
    },
    "performance_metrics": {
        "extension_count": $(echo "$extensions_json" | jq length),
        "loaded_extensions": $(echo "$extensions_json" | jq '[.[] | select(.loaded == true)] | length'),
        "php_memory_limit": "$(php -r 'echo ini_get("memory_limit");')"
    }
}
EOF
    
    echo "Health report generated: $HEALTH_REPORT"
}

generate_health_report