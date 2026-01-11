# Multi-version Extension Management
#!/bin/bash
# extension-manager.sh - Manage multiple extension versions

EXTENSION_DIR="/opt/php-extensions"
BACKUP_DIR="/opt/php-extensions/backups"

create_extension_backup() {
    local extension="$1"
    local backup_name="${extension}-$(date +%Y%m%d-%H%M%S)"
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup configuration
    cp "/etc/php/8.1/mods-available/${extension}.ini" \
       "$BACKUP_DIR/${backup_name}.ini" 2>/dev/null || true
    
    # Backup extension binary
    find /usr/lib/php -name "${extension}.so" -exec \
        cp {} "$BACKUP_DIR/${backup_name}.so" \; 2>/dev/null || true
    
    echo "Backup created: $backup_name"
}

install_extension_version() {
    local extension="$1"
    local version="$2"
    
    # Create backup before installation
    create_extension_backup "$extension"
    
    # Disable current extension
    phpdismod "$extension" 2>/dev/null || true
    
    # Install specific version
    printf "\n" | pecl install "${extension}-${version}"
    
    # Re-enable extension
    phpenmod "$extension"
    
    # Verify installation
    if php -m | grep -q "^$extension$"; then
        echo "Successfully installed ${extension} version ${version}"
    else
        echo "Failed to install ${extension} version ${version}"
        return 1
    fi
}

rollback_extension() {
    local extension="$1"
    local backup_file="$2"
    
    if [[ -f "$BACKUP_DIR/${backup_file}.so" ]]; then
        # Restore extension binary
        cp "$BACKUP_DIR/${backup_file}.so" \
           "/usr/lib/php/20210902/${extension}.so"
        
        # Restore configuration
        cp "$BACKUP_DIR/${backup_file}.ini" \
           "/etc/php/8.1/mods-available/${extension}.ini"
        
        # Restart services
        systemctl restart php8.1-fpm
        echo "Rollback completed for $extension"
    else
        echo "Backup file not found: $backup_file"
        return 1
    fi
}

# Usage examples
# install_extension_version "redis" "5.3.7"
# rollback_extension "redis" "redis-20231201-143000"