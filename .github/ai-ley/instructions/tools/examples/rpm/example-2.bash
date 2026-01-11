#!/bin/bash
# RPM build environment setup script

set -euo pipefail

# Install build dependencies
setup_build_environment() {
    echo "Setting up RPM build environment"
    
    # Install RPM development tools
    yum install -y \
        rpm-build \
        rpm-devel \
        rpmlint \
        rpmdevtools \
        mock \
        spectool \
        yum-utils
    
    # Create build directories
    rpmdev-setuptree
    
    # Verify setup
    echo "Build directory structure:"
    ls -la ~/rpmbuild/
}

# Configure build environment
configure_build_settings() {
    echo "Configuring RPM build settings"
    
    # Create ~/.rpmmacros for build customization
    cat > ~/.rpmmacros << 'EOF'
# RPM build macros
%_topdir %(echo $HOME)/rpmbuild
%_tmppath %{_topdir}/tmp
%_signature gpg
%_gpg_name Your Name <your.email@example.com>
%_gpgbin /usr/bin/gpg2

# Build options
%debug_package %{nil}
%_build_id_links none
%_enable_debug_packages 0

# Vendor and packager information
%vendor Your Company
%packager Your Name <your.email@example.com>
EOF
    
    echo "RPM macros configured: ~/.rpmmacros"
}

setup_build_environment
configure_build_settings