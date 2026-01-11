#!/bin/bash
# Advanced YUM package group management

# List available package groups
list_package_groups() {
    echo "Available package groups:"
    yum grouplist
    
    echo -e "\nInstalled groups:"
    yum grouplist installed
    
    echo -e "\nAvailable groups:"
    yum grouplist available
}

# Install development environment
install_development_environment() {
    echo "Installing development tools..."
    
    # Install development group
    yum groupinstall -y "Development Tools"
    
    # Install additional development packages
    yum install -y \
        cmake \
        autoconf \
        automake \
        libtool \
        pkgconfig \
        openssl-devel \
        libcurl-devel \
        sqlite-devel \
        readline-devel \
        zlib-devel \
        bzip2-devel \
        xz-devel \
        ncurses-devel
    
    # Install modern language runtimes
    yum install -y \
        python3 \
        python3-devel \
        python3-pip \
        nodejs \
        npm \
        java-11-openjdk-devel
    
    echo "Development environment installation completed"
}

# Install web server environment
install_web_server_environment() {
    echo "Installing web server environment..."
    
    # Install web server group
    yum groupinstall -y "Web Server"
    
    # Install additional web server packages
    yum install -y \
        nginx \
        httpd \
        php \
        php-mysql \
        php-gd \
        php-xml \
        php-mbstring \
        mariadb-server \
        mariadb \
        mod_ssl \
        certbot \
        python2-certbot-apache
    
    # Configure services
    systemctl enable nginx
    systemctl enable httpd
    systemctl enable mariadb
    
    echo "Web server environment installation completed"
}

# Install monitoring tools
install_monitoring_tools() {
    echo "Installing monitoring and system administration tools..."
    
    yum install -y \
        htop \
        iotop \
        nmon \
        sysstat \
        dstat \
        tcpdump \
        wireshark-cli \
        nmap \
        telnet \
        traceroute \
        mtr \
        siege \
        ab \
        iftop \
        nethogs \
        glances \
        collectd
    
    echo "Monitoring tools installation completed"
}

# Custom package installation with error handling
install_packages_with_retry() {
    local packages=("$@")
    local max_retries=3
    local retry_delay=5
    
    for package in "${packages[@]}"; do
        local attempt=1
        
        while [[ $attempt -le $max_retries ]]; do
            echo "Installing $package (attempt $attempt/$max_retries)"
            
            if yum install -y "$package"; then
                echo "$package installed successfully"
                break
            else
                if [[ $attempt -eq $max_retries ]]; then
                    echo "Failed to install $package after $max_retries attempts"
                    return 1
                fi
                
                echo "Installation failed, retrying in $retry_delay seconds..."
                sleep $retry_delay
                ((attempt++))
            fi
        done
    done
}

# Main execution
main() {
    echo "YUM Advanced Package Management"
    echo "=============================="
    
    case "${1:-}" in
        "groups")
            list_package_groups
            ;;
        "dev")
            install_development_environment
            ;;
        "web")
            install_web_server_environment
            ;;
        "monitoring")
            install_monitoring_tools
            ;;
        "install")
            shift
            install_packages_with_retry "$@"
            ;;
        *)
            echo "Usage: $0 {groups|dev|web|monitoring|install package1 package2 ...}"
            echo ""
            echo "Commands:"
            echo "  groups     - List available package groups"
            echo "  dev        - Install development environment"
            echo "  web        - Install web server environment"
            echo "  monitoring - Install monitoring tools"
            echo "  install    - Install specific packages with retry logic"
            ;;
    esac
}

main "$@"