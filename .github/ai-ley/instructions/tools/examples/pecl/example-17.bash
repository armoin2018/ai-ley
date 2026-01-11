# Advanced Error Diagnosis
diagnose_extension_errors() {
    local extension="$1"
    local error_log="/var/log/php_errors.log"
    
    echo "Diagnosing errors for $extension..."
    
    # Check PHP error logs
    if [[ -f "$error_log" ]]; then
        echo "Recent errors related to $extension:"
        tail -100 "$error_log" | grep -i "$extension" | tail -10
    fi
    
    # Check system logs
    journalctl -u php8.1-fpm --since "1 hour ago" | grep -i "$extension" || true
    
    # Test extension loading
    php -d extension="$extension.so" -m 2>&1 | grep -E "(error|warning|notice)" || echo "No loading errors"
    
    # Check dependencies
    local ext_file="/usr/lib/php/20210902/${extension}.so"
    if [[ -f "$ext_file" ]]; then
        echo "Checking shared library dependencies:"
        ldd "$ext_file" | grep "not found" || echo "All dependencies satisfied"
    fi
    
    # Memory and resource checks
    echo "Memory usage test:"
    php -d extension="$extension.so" -r "
        echo 'Memory before: ' . memory_get_usage() . \"\n\";
        if (extension_loaded('$extension')) {
            echo 'Extension loaded successfully\n';
        } else {
            echo 'Extension failed to load\n';
        }
        echo 'Memory after: ' . memory_get_usage() . \"\n\";
    "
}

# Automated Recovery
recover_extension() {
    local extension="$1"
    
    echo "Attempting recovery for $extension..."
    
    # Disable extension
    phpdismod "$extension" 2>/dev/null || true
    
    # Remove corrupted files
    rm -f "/usr/lib/php/20210902/${extension}.so"
    rm -f "/etc/php/8.1/mods-available/${extension}.ini"
    
    # Reinstall
    printf "\n" | pecl install "$extension"
    
    # Re-enable
    phpenmod "$extension"
    
    # Restart services
    systemctl restart php8.1-fpm
    
    # Verify recovery
    if php -m | grep -q "^$extension$"; then
        echo "Recovery successful for $extension"
    else
        echo "Recovery failed for $extension"
        return 1
    fi
}