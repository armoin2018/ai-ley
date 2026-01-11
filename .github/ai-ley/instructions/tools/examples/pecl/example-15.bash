# Generate Extension Compliance Report
#!/bin/bash
generate_compliance_report() {
    local report_file="/tmp/pecl-compliance-$(date +%Y%m%d).html"
    
    cat > "$report_file" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>PECL Extensions Compliance Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .critical { background-color: #ffebee; }
        .warning { background-color: #fff3e0; }
        .healthy { background-color: #e8f5e8; }
    </style>
</head>
<body>
    <h1>PECL Extensions Compliance Report</h1>
    <p>Generated: $(date)</p>
    <table>
        <tr>
            <th>Extension</th>
            <th>Version</th>
            <th>Status</th>
            <th>Last Updated</th>
            <th>Security Rating</th>
        </tr>
EOF

    # Add extension data
    for extension in $(pecl list | tail -n +4 | awk '{print $1}'); do
        local version=$(pecl list | grep "^$extension" | awk '{print $2}')
        local status="healthy"
        local last_updated=$(stat -c %y "/usr/lib/php/20210902/${extension}.so" 2>/dev/null | cut -d' ' -f1)
        local security_rating="PASS"
        
        # Determine status class
        if ! php -m | grep -q "^$extension$"; then
            status="critical"
            security_rating="FAIL"
        fi
        
        cat >> "$report_file" << EOF
        <tr class="$status">
            <td>$extension</td>
            <td>$version</td>
            <td>$(echo $status | tr '[:lower:]' '[:upper:]')</td>
            <td>$last_updated</td>
            <td>$security_rating</td>
        </tr>
EOF
    done
    
    cat >> "$report_file" << 'EOF'
    </table>
</body>
</html>
EOF

    echo "Compliance report generated: $report_file"
}

generate_compliance_report