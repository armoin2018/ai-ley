# Prometheus metrics exporter for PECL extensions
cat > /usr/local/bin/pecl-prometheus-exporter << 'EOF'
#!/bin/bash
# PECL Extension Prometheus Metrics Exporter

METRICS_FILE="/tmp/pecl-metrics.prom"

generate_metrics() {
    cat > "$METRICS_FILE" << 'METRICS_HEADER'
# HELP pecl_extensions_total Total number of PECL extensions installed
# TYPE pecl_extensions_total gauge

# HELP pecl_extensions_loaded Number of PECL extensions currently loaded
# TYPE pecl_extensions_loaded gauge

# HELP pecl_extension_info Information about individual PECL extensions
# TYPE pecl_extension_info gauge
METRICS_HEADER

    local total_extensions=$(pecl list | tail -n +4 | wc -l)
    echo "pecl_extensions_total $total_extensions" >> "$METRICS_FILE"
    
    local loaded_count=0
    for extension in $(pecl list | tail -n +4 | awk '{print $1}'); do
        local version=$(pecl list | grep "^$extension" | awk '{print $2}')
        local loaded=0
        
        if php -m | grep -q "^$extension$"; then
            loaded=1
            ((loaded_count++))
        fi
        
        echo "pecl_extension_info{name=\"$extension\",version=\"$version\",loaded=\"$loaded\"} 1" >> "$METRICS_FILE"
    done
    
    echo "pecl_extensions_loaded $loaded_count" >> "$METRICS_FILE"
}

# Generate metrics
generate_metrics

# Serve metrics (simple HTTP server)
if [[ "${1:-}" == "serve" ]]; then
    while true; do
        generate_metrics
        nc -l -p 9090 -c "printf 'HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\n'; cat $METRICS_FILE" || sleep 5
    done
else
    cat "$METRICS_FILE"
fi
EOF

chmod +x /usr/local/bin/pecl-prometheus-exporter