# Automated Installation Script
#!/bin/bash
set -euo pipefail

REQUIRED_EXTENSIONS=(
    "redis"
    "mongodb" 
    "apcu"
    "memcached"
    "imagick"
    "grpc"
    "protobuf"
)

LOG_FILE="/var/log/pecl-installation.log"
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

install_extension() {
    local extension="$1"
    local config_file="/etc/php/${PHP_VERSION}/mods-available/${extension}.ini"
    
    echo "$(date): Installing $extension" >> "$LOG_FILE"
    
    # Check if already installed
    if php -m | grep -q "^$extension$"; then
        echo "$(date): $extension already installed" >> "$LOG_FILE"
        return 0
    fi
    
    # Install system dependencies based on extension
    case "$extension" in
        "mongodb")
            apt-get install -y libssl-dev libsasl2-dev
            ;;
        "imagick")
            apt-get install -y libmagickwand-dev
            ;;
        "memcached")
            apt-get install -y libmemcached-dev zlib1g-dev
            ;;
        "grpc")
            apt-get install -y zlib1g-dev
            ;;
    esac
    
    # Install extension
    if printf "\n" | pecl install "$extension"; then
        echo "$(date): Successfully installed $extension" >> "$LOG_FILE"
        
        # Create configuration file
        echo "extension=$extension.so" > "$config_file"
        
        # Enable extension
        phpenmod "$extension"
        
        # Verify installation
        if php -m | grep -q "^$extension$"; then
            echo "$(date): $extension verified and enabled" >> "$LOG_FILE"
        else
            echo "$(date): ERROR: $extension installation failed verification" >> "$LOG_FILE"
            return 1
        fi
    else
        echo "$(date): ERROR: Failed to install $extension" >> "$LOG_FILE"
        return 1
    fi
}

# Install all required extensions
for extension in "${REQUIRED_EXTENSIONS[@]}"; do
    install_extension "$extension"
done

# Restart services
systemctl restart php${PHP_VERSION}-fpm
systemctl restart nginx

echo "$(date): Extension installation completed" >> "$LOG_FILE"