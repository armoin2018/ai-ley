#!/bin/bash
# Advanced APT repository management

# Modern repository configuration using signed-by
configure_nodejs_repo() {
    # Download and verify GPG key
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | \
        gpg --dearmor -o /usr/share/keyrings/nodesource-keyring.gpg
    
    # Add repository with specific keyring
    echo "deb [signed-by=/usr/share/keyrings/nodesource-keyring.gpg] https://deb.nodesource.com/node_18.x $(lsb_release -cs) main" | \
        tee /etc/apt/sources.list.d/nodesource.list
    
    # Set repository preferences
    cat > /etc/apt/preferences.d/nodesource << EOF
Package: nodejs npm
Pin: origin deb.nodesource.com
Pin-Priority: 1001
EOF
}

# Configure Docker repository
configure_docker_repo() {
    # Install dependencies
    apt-get update
    apt-get install -y ca-certificates curl gnupg lsb-release
    
    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
        gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    
    # Set up stable repository
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Update package cache
    apt-get update
}

# Configure PostgreSQL repository
configure_postgresql_repo() {
    # Import signing key
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
        gpg --dearmor -o /usr/share/keyrings/postgresql-keyring.gpg
    
    # Add repository
    echo "deb [signed-by=/usr/share/keyrings/postgresql-keyring.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | \
        tee /etc/apt/sources.list.d/pgdg.list
    
    # Update and install
    apt-get update
    apt-get install -y postgresql-14 postgresql-client-14
}

# Package pinning for version control
setup_package_pinning() {
    # Pin specific package versions
    cat > /etc/apt/preferences.d/package-pins << EOF
# Pin Python 3.10
Package: python3.10*
Pin: version 3.10.*
Pin-Priority: 1001

# Pin Node.js major version
Package: nodejs
Pin: version 18.*
Pin-Priority: 1001

# Prevent automatic kernel updates
Package: linux-image* linux-headers*
Pin: version *
Pin-Priority: -10
EOF
}