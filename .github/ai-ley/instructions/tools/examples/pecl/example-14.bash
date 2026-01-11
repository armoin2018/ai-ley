# Security Audit for PECL Extensions
#!/bin/bash
security_audit_extension() {
    local extension="$1"
    local security_issues=()
    
    echo "Security audit for $extension extension..."
    
    # Check for known vulnerabilities
    local cve_check=$(curl -s "https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=$extension" | grep -c "CVE-")
    if [[ $cve_check -gt 0 ]]; then
        security_issues+=("Potential CVE entries found: $cve_check")
    fi
    
    # Check file permissions
    local ext_file="/usr/lib/php/20210902/${extension}.so"
    if [[ -f "$ext_file" ]]; then
        local permissions=$(stat -c "%a" "$ext_file")
        if [[ "$permissions" != "644" ]]; then
            security_issues+=("Incorrect file permissions: $permissions")
        fi
    fi
    
    # Check configuration security
    local config_file="/etc/php/8.1/mods-available/${extension}.ini"
    if [[ -f "$config_file" ]]; then
        # Check for insecure configurations
        if grep -q "allow_url_include\s*=\s*On" "$config_file"; then
            security_issues+=("Insecure configuration: allow_url_include enabled")
        fi
    fi
    
    # Report findings
    if [[ ${#security_issues[@]} -eq 0 ]]; then
        echo "✓ No security issues found for $extension"
    else
        echo "⚠ Security issues found for $extension:"
        printf '  - %s\n' "${security_issues[@]}"
    fi
}

# Audit all extensions
for extension in $(pecl list | tail -n +4 | awk '{print $1}'); do
    security_audit_extension "$extension"
done