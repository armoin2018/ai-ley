#!/bin/bash
# Custom application packaging workflow

# Build application RPM
build_application_rpm() {
    local app_name="$1"
    local version="$2"
    local build_dir="$3"
    
    echo "Building RPM for $app_name version $version"
    
    # Prepare build environment
    cd "$build_dir"
    rpmdev-setuptree
    
    # Create source tarball
    tar czf ~/rpmbuild/SOURCES/${app_name}-${version}.tar.gz \
        --transform "s,^${app_name}/,${app_name}-${version}/," \
        "$app_name"
    
    # Copy SPEC file
    cp "${app_name}/packaging/${app_name}.spec" ~/rpmbuild/SPECS/
    
    # Install build dependencies
    yum-builddep -y ~/rpmbuild/SPECS/${app_name}.spec
    
    # Build RPM
    rpmbuild -ba ~/rpmbuild/SPECS/${app_name}.spec
    
    # Verify built package
    rpm -qilp ~/rpmbuild/RPMS/*/${app_name}-${version}-*.rpm
    
    echo "RPM build completed: ~/rpmbuild/RPMS/"
}

# Test package installation
test_package_installation() {
    local rpm_file="$1"
    
    echo "Testing package installation: $rpm_file"
    
    # Check package contents
    echo "Package contents:"
    rpm -qilp "$rpm_file"
    
    # Test installation
    echo "Installing package..."
    rpm -ivh "$rpm_file"
    
    # Verify installation
    package_name=$(rpm -qp --qf "%{NAME}" "$rpm_file")
    
    echo "Verifying installation..."
    rpm -qi "$package_name"
    rpm -V "$package_name"
    
    # Test application functionality
    echo "Testing application..."
    if command -v "$package_name" >/dev/null 2>&1; then
        "$package_name" --version
    fi
    
    echo "Package test completed successfully"
}

# Usage example
build_application_rpm "myapp" "1.0.0" "/path/to/source"