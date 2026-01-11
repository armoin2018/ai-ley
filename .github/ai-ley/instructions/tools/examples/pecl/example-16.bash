# Troubleshooting PECL Extension Installation
troubleshoot_installation() {
    local extension="$1"
    
    echo "Troubleshooting $extension installation..."
    
    # Check system dependencies
    echo "Checking system dependencies..."
    case "$extension" in
        "mongodb")
            if ! pkg-config --exists libssl; then
                echo "Missing libssl-dev - install with: apt-get install libssl-dev"
            fi
            ;;
        "imagick")
            if ! pkg-config --exists MagickWand; then
                echo "Missing ImageMagick dev - install with: apt-get install libmagickwand-dev"
            fi
            ;;
        "memcached")
            if ! pkg-config --exists libmemcached; then
                echo "Missing libmemcached - install with: apt-get install libmemcached-dev"
            fi
            ;;
    esac
    
    # Check PHP development packages
    if ! command -v phpize >/dev/null; then
        echo "Missing php-dev package - install with: apt-get install php-dev"
    fi
    
    # Check compiler tools
    if ! command -v gcc >/dev/null; then
        echo "Missing build tools - install with: apt-get install build-essential"
    fi
    
    # Verify extension directory permissions
    local ext_dir=$(php-config --extension-dir)
    if [[ ! -w "$ext_dir" ]]; then
        echo "Extension directory not writable: $ext_dir"
        echo "Fix with: sudo chown -R $(whoami) $ext_dir"
    fi
    
    # Check for conflicting installations
    if find /usr -name "${extension}.so" 2>/dev/null | wc -l | grep -q "^[2-9]"; then
        echo "Multiple $extension.so files found - potential conflict"
        find /usr -name "${extension}.so" 2>/dev/null
    fi
}

# Fix common PECL issues
fix_pecl_issues() {
    echo "Attempting to fix common PECL issues..."
    
    # Update package lists
    apt-get update
    
    # Install common dependencies
    apt-get install -y \
        build-essential \
        php-dev \
        pkg-config \
        autoconf \
        libtool
    
    # Clear PECL cache
    pecl clear-cache
    
    # Update channels
    pecl channel-update pecl.php.net
    
    # Fix permissions
    local ext_dir=$(php-config --extension-dir)
    chmod 755 "$ext_dir"
    
    echo "Common issues fixed. Try installation again."
}