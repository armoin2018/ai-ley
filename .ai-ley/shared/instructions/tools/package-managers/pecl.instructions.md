# PECL PHP Extension Community Library Instructions

## Overview

PECL (PHP Extension Community Library) is a repository of PHP extensions written in C that provide additional functionality to the PHP language. PECL allows developers to install, configure, and manage C-based PHP extensions that extend core PHP capabilities with high-performance modules for databases, networking, cryptography, and specialized functionality.

## Core Principles

### Extension Management
- **C Extension Integration**: Seamless integration of C-based extensions with PHP
- **Performance Optimization**: High-performance modules for CPU-intensive operations
- **System Integration**: Native system library integration and functionality
- **Version Compatibility**: Extension compatibility across PHP versions

### Package Repository
- **Community Contributions**: Open-source extension repository maintained by the PHP community
- **Quality Standards**: Code review and testing standards for extension submissions
- **Documentation**: Comprehensive documentation and examples for each extension
- **Dependency Management**: Automatic handling of system dependencies and libraries

### Development Workflow
- **Extension Building**: Tools for compiling and building extensions from source
- **Configuration Management**: System-specific configuration and optimization
- **Testing Framework**: Comprehensive testing tools for extension validation
- **Distribution Packaging**: Packaging and distribution mechanisms for extensions

## Implementation Framework

### PECL Installation and Setup

```bash
# Install PECL (usually included with PHP development packages)
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install php-pear php-dev build-essential

# CentOS/RHEL
sudo yum install php-pear php-devel gcc gcc-c++ make

# macOS with Homebrew
brew install php
xcode-select --install  # For development tools

# Verify PECL installation
pecl version
pecl list-all | head -20  # Show available extensions

# Update PECL channel and package list
pecl channel-update pecl.php.net
pecl update-channels
```

### Essential PECL Operations

```bash
# Extension Installation
pecl install extension_name              # Install latest stable version
pecl install extension_name-1.2.3       # Install specific version
pecl install channel://pecl.php.net/extension_name-1.2.3  # Full channel specification

# Popular Extensions Installation
pecl install redis                      # Redis client extension
pecl install mongodb                    # MongoDB driver
pecl install apcu                       # User cache extension
pecl install memcached                  # Memcached client
pecl install imagick                    # ImageMagick image processing
pecl install xdebug                     # Debugging and profiling
pecl install grpc                       # gRPC framework support
pecl install protobuf                   # Protocol Buffers support

# Extension Management
pecl list                               # List installed extensions
pecl list-all                          # List all available extensions
pecl info extension_name                # Show extension information
pecl upgrade extension_name             # Upgrade extension to latest version
pecl uninstall extension_name           # Remove extension
```

### Configuration and Integration

```bash
# PHP Configuration Integration
# Check PHP configuration files
php --ini
php -m | grep extension_name            # Check if extension is loaded

# Enable extension in php.ini
echo "extension=redis.so" >> /etc/php/8.1/cli/php.ini
echo "extension=mongodb.so" >> /etc/php/8.1/fpm/php.ini

# Extension-specific configuration
cat >> /etc/php/8.1/mods-available/redis.conf << 'EOF'
; Redis extension configuration
extension=redis.so

; Redis session handler
session.save_handler = redis
session.save_path = "tcp://localhost:6379"

; Redis cache configuration
redis.arrays.names = ''
redis.arrays.hosts = ''
redis.arrays.previous = ''
redis.arrays.functions = ''
redis.arrays.index = ''
redis.arrays.autorehash = 0
EOF

# System service integration
systemctl restart php8.1-fpm
systemctl restart apache2  # or nginx
```

### Enterprise Extension Management

```bash
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
```

## Best Practices

### Extension Development Environment

```bash
# Development Environment Setup
sudo apt-get install -y \
    php-dev \
    build-essential \
    autoconf \
    libtool \
    pkg-config \
    git

# Create development workspace
mkdir -p /opt/php-extensions
cd /opt/php-extensions

# Clone PECL extension development template
git clone https://github.com/php/pecl-template.git my-extension
cd my-extension

# Extension Building Process
phpize                                  # Prepare build environment
./configure                            # Configure build options
make                                   # Compile extension
make test                              # Run extension tests
sudo make install                      # Install extension

# Development Testing
cat > test_extension.php << 'EOF'
<?php
if (extension_loaded('my_extension')) {
    echo "Extension loaded successfully\n";
    
    // Test extension functionality
    $result = my_extension_function();
    var_dump($result);
} else {
    echo "Extension not loaded\n";
}
EOF

php test_extension.php
```

### Performance Optimization

```bash
# Extension Performance Configuration
# Redis Performance Tuning
cat > /etc/php/8.1/mods-available/redis-optimized.conf << 'EOF'
extension=redis.so

; Performance optimizations
redis.arrays.autorehash = 1
redis.arrays.retries = 3
redis.arrays.lazyconnect = 1

; Connection pooling
redis.pconnect.pooling_enabled = 1
redis.pconnect.connection_limit = 100

; Serialization optimization
redis.serializer = igbinary  ; or php, json
redis.compression = lz4      ; or lzf, zstd
EOF

# APCu Configuration for Optimal Performance
cat > /etc/php/8.1/mods-available/apcu-optimized.conf << 'EOF'
extension=apcu.so

; Memory allocation (adjust based on server memory)
apc.shm_size = 256M
apc.shm_segments = 1

; Cache optimization
apc.ttl = 7200
apc.user_ttl = 7200
apc.gc_ttl = 3600

; Performance tuning
apc.mmap_file_mask = /tmp/apc.XXXXXX
apc.slam_defense = 1
apc.enable_cli = 1

; Monitoring
apc.stat = 0  ; Disable for production (improves performance)
apc.preload_path = /var/www/app/preload.php
EOF

# MongoDB Performance Configuration
cat > /etc/php/8.1/mods-available/mongodb-optimized.conf << 'EOF'
extension=mongodb.so

; Connection optimization
mongodb.debug = 0
mongodb.max_execution_time = 30

; Logging configuration (disable in production)
mongodb.command_logging = 0
mongodb.query_logging = 0
EOF
```

### Security Configuration

```bash
# Security-Hardened Extension Configuration
# Xdebug Security (Development only)
cat > /etc/php/8.1/mods-available/xdebug-secure.conf << 'EOF'
zend_extension=xdebug.so

; Enable only in development
xdebug.mode = debug,develop
xdebug.start_with_request = trigger

; Secure remote debugging
xdebug.client_host = 127.0.0.1
xdebug.client_port = 9003
xdebug.discover_client_host = 0

; Security restrictions
xdebug.max_nesting_level = 256
xdebug.max_stack_frames = 100

; File access restrictions
xdebug.file_link_format = ""
xdebug.var_display_max_children = 128
xdebug.var_display_max_data = 512
xdebug.var_display_max_depth = 3
EOF

# Secure Redis Configuration
cat > /etc/php/8.1/mods-available/redis-secure.conf << 'EOF'
extension=redis.so

; Connection security
redis.arrays.auth = "your-secure-password"
redis.session.save_path = "tcp://127.0.0.1:6379?auth=password"

; SSL/TLS support
redis.arrays.consistent = 1
redis.arrays.retries = 3
redis.arrays.connect_timeout = 5
redis.arrays.read_timeout = 5

; Security monitoring
redis.arrays.lazyconnect = 0  ; Force immediate connection validation
EOF
```

## Common Patterns

### Extension Version Management

```bash
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
```

### Continuous Integration Integration

```yaml
# .github/workflows/pecl-extensions.yml
name: PECL Extensions CI
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test-extensions:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        php-version: ['8.0', '8.1', '8.2']
        extensions: ['redis', 'mongodb', 'apcu']
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup PHP
      uses: shivammathur/setup-php@v2
      with:
        php-version: ${{ matrix.php-version }}
        extensions: ${{ matrix.extensions }}
        tools: pecl
        coverage: xdebug
    
    - name: Verify Extension Installation
      run: |
        php -m | grep ${{ matrix.extensions }}
        php -c tests/php.ini tests/extension_test.php
    
    - name: Run Extension Tests
      run: |
        php tests/test_${{ matrix.extensions }}.php
    
    - name: Performance Benchmark
      run: |
        php tests/benchmark_${{ matrix.extensions }}.php
```

### Docker Integration

```dockerfile
# Dockerfile for PECL Extensions
FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libsasl2-dev \
    libmemcached-dev \
    libmagickwand-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PECL extensions
RUN pecl install \
    redis-5.3.7 \
    mongodb-1.15.3 \
    apcu-5.1.22 \
    memcached-3.2.0 \
    imagick-3.7.0 \
    && docker-php-ext-enable \
        redis \
        mongodb \
        apcu \
        memcached \
        imagick

# Copy optimized configuration
COPY config/php/extensions/ /usr/local/etc/php/conf.d/

# Verify extensions
RUN php -m | grep -E "(redis|mongodb|apcu|memcached|imagick)"

# Multi-stage build for production
FROM php:8.1-fpm-alpine AS production

# Copy extensions from builder stage
COPY --from=0 /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=0 /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

# Verify production setup
RUN php -m && php -v
```

## Tools and Resources

### Essential PECL Tools

```bash
# Core PECL Commands
pecl help                               # Show all available commands
pecl list-all                          # List all available packages
pecl search keyword                     # Search for packages
pecl remote-list                        # List packages from remote server
pecl download package                   # Download package without installing

# Package Information
pecl info package                       # Show package information
pecl list-files package                 # List files in installed package
pecl deps package                       # Show package dependencies
pecl list-upgrades                      # Show available upgrades

# Configuration Management
pecl config-get setting                 # Get configuration setting
pecl config-set setting value           # Set configuration setting
pecl config-show                        # Show all configuration settings

# Channel Management
pecl channel-discover channel.url       # Add new package channel
pecl channel-info channel               # Show channel information
pecl channel-delete channel             # Remove channel
pecl update-channels                    # Update all channels
```

### Development and Debugging Tools

```bash
# Extension Development Tools
phpize --help                          # Show phpize options
php-config --extension-dir             # Show extension directory
php-config --include-dir               # Show include directory

# Debugging Extension Loading
php -d extension=debug_extension.so -m  # Load extension with debug
strace -e trace=file php -m 2>&1 | grep extension  # Trace file operations
ldd /usr/lib/php/20210902/extension.so  # Check shared library dependencies

# Performance Analysis
php -d extension=xdebug.so script.php   # Profile with Xdebug
valgrind --tool=memcheck php script.php # Memory analysis
perf record php script.php              # Performance profiling

# Extension Testing Framework
#!/bin/bash
test_extension() {
    local extension="$1"
    local test_file="tests/${extension}_test.php"
    
    echo "Testing $extension extension..."
    
    # Check if extension is loaded
    if ! php -m | grep -q "^$extension$"; then
        echo "FAIL: Extension $extension not loaded"
        return 1
    fi
    
    # Run specific tests
    if [[ -f "$test_file" ]]; then
        php "$test_file"
        local exit_code=$?
        if [[ $exit_code -eq 0 ]]; then
            echo "PASS: $extension tests completed successfully"
        else
            echo "FAIL: $extension tests failed with exit code $exit_code"
            return 1
        fi
    else
        echo "WARN: No test file found for $extension"
    fi
    
    return 0
}

# Test all installed extensions
for ext in $(pecl list | tail -n +4 | awk '{print $1}'); do
    test_extension "$ext"
done
```

### Monitoring and Health Checks

```bash
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
```

## Quality and Compliance

### Security Best Practices

```bash
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
```

### Compliance and Documentation

```bash
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
```

## Troubleshooting

### Common Installation Issues

```bash
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
```

### Error Diagnosis and Resolution

```bash
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
```

## Metrics and Monitoring

### Performance Monitoring

```php
<?php
// Extension Performance Monitoring
class ExtensionPerformanceMonitor {
    private $metrics = [];
    private $logFile = '/var/log/php-extension-performance.log';
    
    public function measureExtensionPerformance($extension, $operations = 1000) {
        if (!extension_loaded($extension)) {
            throw new Exception("Extension $extension not loaded");
        }
        
        $startTime = microtime(true);
        $startMemory = memory_get_usage(true);
        
        // Extension-specific performance tests
        switch ($extension) {
            case 'redis':
                $this->testRedisPerformance($operations);
                break;
            case 'mongodb':
                $this->testMongoDBPerformance($operations);
                break;
            case 'apcu':
                $this->testAPCuPerformance($operations);
                break;
            default:
                $this->testGenericPerformance($extension, $operations);
        }
        
        $endTime = microtime(true);
        $endMemory = memory_get_usage(true);
        
        $metrics = [
            'extension' => $extension,
            'operations' => $operations,
            'execution_time' => $endTime - $startTime,
            'memory_used' => $endMemory - $startMemory,
            'ops_per_second' => $operations / ($endTime - $startTime),
            'timestamp' => date('Y-m-d H:i:s')
        ];
        
        $this->logMetrics($metrics);
        return $metrics;
    }
    
    private function testRedisPerformance($operations) {
        $redis = new Redis();
        $redis->connect('127.0.0.1', 6379);
        
        for ($i = 0; $i < $operations; $i++) {
            $redis->set("test_key_$i", "test_value_$i");
            $redis->get("test_key_$i");
        }
        
        // Cleanup
        for ($i = 0; $i < $operations; $i++) {
            $redis->del("test_key_$i");
        }
        
        $redis->close();
    }
    
    private function testAPCuPerformance($operations) {
        for ($i = 0; $i < $operations; $i++) {
            apcu_store("test_key_$i", "test_value_$i");
            apcu_fetch("test_key_$i");
        }
        
        // Cleanup
        for ($i = 0; $i < $operations; $i++) {
            apcu_delete("test_key_$i");
        }
    }
    
    private function logMetrics($metrics) {
        $logEntry = json_encode($metrics) . "\n";
        file_put_contents($this->logFile, $logEntry, FILE_APPEND | LOCK_EX);
    }
}

// Usage
$monitor = new ExtensionPerformanceMonitor();

try {
    $redisMetrics = $monitor->measureExtensionPerformance('redis', 1000);
    echo "Redis Performance: " . $redisMetrics['ops_per_second'] . " ops/sec\n";
    
    $apcuMetrics = $monitor->measureExtensionPerformance('apcu', 5000);
    echo "APCu Performance: " . $apcuMetrics['ops_per_second'] . " ops/sec\n";
    
} catch (Exception $e) {
    echo "Performance test failed: " . $e->getMessage() . "\n";
}
?>
```

### System Health Monitoring

```bash
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
```

## Integration Patterns

### Configuration Management Integration

```yaml
# Ansible playbook for PECL extension management
---
- name: PECL Extensions Management
  hosts: php_servers
  become: yes
  
  vars:
    required_extensions:
      - name: redis
        version: "5.3.7"
        config:
          - "extension=redis.so"
          - "redis.arrays.autorehash = 1"
      - name: mongodb
        version: "1.15.3"
        config:
          - "extension=mongodb.so"
      - name: apcu
        version: "5.1.22"
        config:
          - "extension=apcu.so"
          - "apc.shm_size = 256M"
  
  tasks:
    - name: Install system dependencies
      apt:
        name:
          - php-pear
          - php-dev
          - build-essential
          - libssl-dev
          - libmemcached-dev
        state: present
        update_cache: yes
    
    - name: Install PECL extensions
      shell: printf "\n" | pecl install {{ item.name }}-{{ item.version }}
      args:
        creates: "/usr/lib/php/*/{{ item.name }}.so"
      loop: "{{ required_extensions }}"
      register: pecl_install
      
    - name: Create extension configuration files
      template:
        src: extension.ini.j2
        dest: "/etc/php/8.1/mods-available/{{ item.name }}.ini"
        mode: '0644'
      loop: "{{ required_extensions }}"
      notify: restart php-fpm
      
    - name: Enable extensions
      command: phpenmod {{ item.name }}
      loop: "{{ required_extensions }}"
      notify: restart php-fpm
      
    - name: Verify extension installation
      command: php -m
      register: php_modules
      
    - name: Check extension loading
      assert:
        that: item.name in php_modules.stdout
        fail_msg: "Extension {{ item.name }} not loaded"
      loop: "{{ required_extensions }}"
  
  handlers:
    - name: restart php-fpm
      systemd:
        name: php8.1-fpm
        state: restarted
```

### Monitoring Integration

```bash
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
```

## Advanced Topics

### Custom Extension Development

```c
// example_extension.c - Basic PECL extension template
#include "php.h"
#include "php_example.h"

// Extension function declarations
PHP_FUNCTION(example_hello);
PHP_FUNCTION(example_add);

// Function entry table
const zend_function_entry example_functions[] = {
    PHP_FE(example_hello, NULL)
    PHP_FE(example_add, NULL)
    PHP_FE_END
};

// Module entry
zend_module_entry example_module_entry = {
    STANDARD_MODULE_HEADER,
    "example",
    example_functions,
    NULL,                   // PHP_MINIT
    NULL,                   // PHP_MSHUTDOWN
    NULL,                   // PHP_RINIT
    NULL,                   // PHP_RSHUTDOWN
    NULL,                   // PHP_MINFO
    "1.0.0",
    STANDARD_MODULE_PROPERTIES
};

ZEND_GET_MODULE(example)

// Function implementations
PHP_FUNCTION(example_hello) {
    char *name = "World";
    size_t name_len = strlen(name);
    
    if (zend_parse_parameters(ZEND_NUM_ARGS(), "|s", &name, &name_len) == FAILURE) {
        return;
    }
    
    php_printf("Hello %s!\n", name);
}

PHP_FUNCTION(example_add) {
    zend_long a, b;
    
    if (zend_parse_parameters(ZEND_NUM_ARGS(), "ll", &a, &b) == FAILURE) {
        return;
    }
    
    RETURN_LONG(a + b);
}
```

```bash
# Build and test custom extension
cd /opt/php-extensions/example
phpize
./configure
make
make test
sudo make install

# Create configuration
echo "extension=example.so" > /etc/php/8.1/mods-available/example.ini
phpenmod example

# Test the extension
php -r "echo example_hello('PECL'); echo example_add(2, 3);"
```

### Enterprise Extension Deployment

```bash
# Enterprise deployment pipeline
#!/bin/bash
# deploy-pecl-extensions.sh - Enterprise deployment script

set -euo pipefail

ENVIRONMENT="${1:-production}"
CONFIG_DIR="/opt/php-config/$ENVIRONMENT"
BACKUP_DIR="/opt/backups/php-extensions"
DEPLOYMENT_LOG="/var/log/pecl-deployment.log"

deploy_to_environment() {
    local env="$1"
    
    echo "$(date): Starting PECL deployment to $env" >> "$DEPLOYMENT_LOG"
    
    # Create backup
    create_deployment_backup "$env"
    
    # Load environment-specific configuration
    source "$CONFIG_DIR/extensions.conf"
    
    # Deploy extensions
    for extension_spec in "${EXTENSIONS[@]}"; do
        IFS=':' read -r extension version <<< "$extension_spec"
        deploy_extension "$extension" "$version"
    done
    
    # Validate deployment
    validate_deployment
    
    # Update load balancer (if applicable)
    update_load_balancer "$env"
    
    echo "$(date): PECL deployment to $env completed" >> "$DEPLOYMENT_LOG"
}

create_deployment_backup() {
    local env="$1"
    local backup_path="$BACKUP_DIR/$env-$(date +%Y%m%d-%H%M%S)"
    
    mkdir -p "$backup_path"
    
    # Backup extensions
    cp -r /usr/lib/php/*/  "$backup_path/extensions/" 2>/dev/null || true
    
    # Backup configurations
    cp -r /etc/php/*/mods-available/ "$backup_path/configs/" 2>/dev/null || true
    
    echo "Backup created: $backup_path"
}

deploy_extension() {
    local extension="$1"
    local version="$2"
    
    echo "Deploying $extension version $version..."
    
    # Rolling deployment for zero downtime
    for server in $(get_server_list); do
        echo "Deploying to $server..."
        
        # Deploy to server
        ssh "$server" "
            # Stop traffic to this server
            curl -X POST http://localhost/maintenance-mode/enable
            
            # Install extension
            printf '\n' | pecl install $extension-$version
            
            # Configure extension
            phpenmod $extension
            
            # Restart services
            systemctl restart php8.1-fpm
            
            # Health check
            if php -m | grep -q '^$extension$'; then
                # Re-enable traffic
                curl -X POST http://localhost/maintenance-mode/disable
                echo 'Deployment successful on $server'
            else
                echo 'Deployment failed on $server'
                exit 1
            fi
        "
        
        # Wait between servers
        sleep 30
    done
}

validate_deployment() {
    echo "Validating deployment..."
    
    local validation_failed=false
    
    # Test each required extension
    for extension_spec in "${EXTENSIONS[@]}"; do
        IFS=':' read -r extension version <<< "$extension_spec"
        
        if ! php -m | grep -q "^$extension$"; then
            echo "VALIDATION FAILED: $extension not loaded"
            validation_failed=true
        fi
        
        # Version check
        local installed_version=$(php --re "$extension" | grep "Version" | head -1 | awk '{print $3}')
        if [[ "$installed_version" != "$version" ]]; then
            echo "VALIDATION WARNING: $extension version mismatch (expected: $version, got: $installed_version)"
        fi
    done
    
    if [[ "$validation_failed" == "true" ]]; then
        echo "Deployment validation failed!"
        exit 1
    else
        echo "Deployment validation passed!"
    fi
}

# Execute deployment
deploy_to_environment "$ENVIRONMENT"
```

## AI Assistant Guidelines

### When to Use PECL

**Recommended Scenarios:**
- Installing high-performance PHP extensions written in C
- Adding specialized functionality not available in core PHP
- Integrating with system libraries and external services
- Performance-critical applications requiring native extensions
- Enterprise environments needing specific database or cache drivers
- Legacy applications requiring older extension versions

**Avoid When:**
- Pure PHP alternatives exist and meet performance requirements
- Extension maintenance and security updates are inconsistent
- System lacks proper development tools and dependencies
- Using shared hosting without server control
- Extension compatibility with PHP version is uncertain

### Code Generation Rules

1. **Always check dependencies** before extension installation
2. **Include error handling** for all PECL operations
3. **Create backups** before major extension changes
4. **Verify installation** after each extension deployment
5. **Use version pinning** for production environments
6. **Include cleanup procedures** for failed installations
7. **Implement health checks** for extension monitoring
8. **Document configuration** for each installed extension

### Quality Enforcement

- Validate system dependencies before attempting installation
- Use version-specific installations for reproducible deployments
- Implement proper error handling and rollback procedures
- Include comprehensive testing for extension functionality
- Monitor extension performance and resource usage
- Maintain security updates and vulnerability assessments
- Document all extension configurations and customizations
- Implement automated health checks and monitoring

### Integration Patterns

- Combine with configuration management tools (Ansible, Puppet)
- Integrate with containerization for consistent deployments
- Use with CI/CD pipelines for automated testing and deployment
- Implement with monitoring systems for extension health tracking
- Combine with backup solutions for system recovery capabilities
- Use with load balancers for zero-downtime deployments
