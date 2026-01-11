#!/bin/bash
# Development environment setup script

set -euo pipefail

# Configuration
PACKAGES=(
    "git"
    "curl"
    "wget"
    "vim"
    "code"
    "docker.io"
    "docker-compose"
    "nodejs"
    "npm"
    "python3"
    "python3-pip"
    "build-essential"
)

# Update system
update_system() {
    echo "Updating package cache..."
    apt-get update
    
    echo "Upgrading existing packages..."
    apt-get upgrade -y
}

# Add repositories
add_repositories() {
    echo "Adding Microsoft VS Code repository..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    
    echo "Adding Node.js repository..."
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    
    apt-get update
}

# Install packages
install_packages() {
    echo "Installing development packages..."
    for package in "${PACKAGES[@]}"; do
        if ! dpkg -l | grep -q "^ii  $package "; then
            echo "Installing $package..."
            apt-get install -y "$package"
        else
            echo "$package is already installed"
        fi
    done
}

# Configure environment
configure_environment() {
    echo "Configuring development environment..."
    
    # Add user to docker group
    usermod -aG docker "$SUDO_USER"
    
    # Install global npm packages
    sudo -u "$SUDO_USER" npm install -g \
        typescript \
        @vue/cli \
        @angular/cli \
        create-react-app \
        nodemon
    
    # Install Python packages
    pip3 install \
        virtualenv \
        pipenv \
        jupyter \
        requests \
        pandas \
        numpy
}

# Cleanup
cleanup() {
    echo "Cleaning up..."
    apt-get autoremove -y
    apt-get autoclean
}

# Main execution
main() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root (use sudo)"
        exit 1
    fi
    
    update_system
    add_repositories
    install_packages
    configure_environment
    cleanup
    
    echo "Development environment setup completed successfully!"
    echo "Please log out and log back in for group changes to take effect."
}

main "$@"