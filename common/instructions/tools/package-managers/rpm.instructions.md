`
---
applyTo: "rpm, package-management, redhat, centos, fedora, suse, **/rpm, spec-files"
---

# RPM Package Management Instructions

## Overview
- **Domain**: Red Hat Package Manager (RPM) and Low-Level Package Operations
- **Purpose**: Create, install, query, and manage RPM packages for Linux distributions
- **Applicable To**: RHEL, CentOS, Fedora, SUSE, OpenSUSE, and other RPM-based distributions
- **Integration Level**: System administration, package development, and automated deployments

## Core Principles

### Fundamental Concepts
1. **Binary Package Distribution**: RPM provides compiled software packages with metadata
2. **Package Database**: Centralized database tracking all installed packages and their files
3. **Dependency Management**: Packages declare dependencies that must be satisfied
4. **Cryptographic Verification**: Packages are signed for authenticity and integrity

### Key Benefits
- Precise package version and dependency tracking
- File conflict detection and resolution
- Package verification and integrity checking
- Rollback capabilities for package operations
- Comprehensive query and inspection capabilities

### Common Misconceptions
- **Myth**: RPM is only for Red Hat systems
  **Reality**: RPM is used by many Linux distributions including SUSE and derivatives
- **Myth**: RPM automatically resolves dependencies
  **Reality**: RPM validates dependencies but doesn't automatically install them (use YUM/DNF for that)

## Implementation Framework

### Getting Started
#### Prerequisites
- RPM-based Linux distribution
- Administrative privileges for package installation
- Basic understanding of Linux file systems and permissions

#### Initial Setup
```bash
# Check RPM version and configuration
rpm --version
rpm --showrc | grep -E "(topdir|buildroot)"

# Query RPM database
rpm -qa | head -10              # List installed packages
rpm -qi bash                    # Package information
rpm -ql bash | head -10         # Package file list

# Verify package signatures
rpm --checksig package.rpm

# Import GPG keys
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-*
```

### Core Methodologies
#### Custom Package Creation
- **Purpose**: Build custom RPM packages for internal applications and configurations
- **When to Use**: Deploying custom software, system configurations, or internal tools
- **Implementation Steps**:
  1. Set up RPM build environment with rpmbuild
  2. Create SPEC file defining package metadata and build instructions
  3. Prepare source code and patches in appropriate directories
  4. Build binary and source RPMs with proper versioning
- **Success Metrics**: Installable packages that properly integrate with system package management

#### Package Verification and Security
- **Purpose**: Ensure package integrity and detect system modifications
- **When to Use**: Security audits, system troubleshooting, and compliance verification
- **Implementation Steps**:
  1. Verify package signatures against trusted GPG keys
  2. Check package file integrity using checksums
  3. Detect modified system files and configuration changes
  4. Implement regular package verification workflows
- **Success Metrics**: Verified system integrity with detected anomalies properly addressed

### Process Integration
#### RPM Build Environment Setup
```bash
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
```

#### CI/CD Integration for RPM Building
```yaml
# GitHub Actions workflow for RPM building
name: Build RPM Package

on:
  push:
    tags:
      - 'v*'
  pull_request:
    branches: [main]

jobs:
  build-rpm:
    runs-on: ubuntu-latest
    container:
      image: centos:7
    
    steps:
      - name: Install dependencies
        run: |
          yum update -y
          yum install -y rpm-build rpm-devel rpmlint rpmdevtools git
          
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: Setup build environment
        run: |
          rpmdev-setuptree
          
      - name: Create source tarball
        run: |
          VERSION=${GITHUB_REF#refs/tags/v}
          tar czf ~/rpmbuild/SOURCES/myapp-${VERSION}.tar.gz \
            --transform "s,^,myapp-${VERSION}/," \
            --exclude='.git*' \
            --exclude='*.spec' \
            .
            
      - name: Build RPM
        run: |
          rpmbuild -ba packaging/myapp.spec
          
      - name: Test RPM installation
        run: |
          yum localinstall -y ~/rpmbuild/RPMS/*/myapp-*.rpm
          
      - name: Run package tests
        run: |
          rpm -qi myapp
          rpm -ql myapp
          
      - name: Upload artifacts
        uses: actions/upload-artifact@v3
        with:
          name: rpm-packages
          path: |
            ~/rpmbuild/RPMS/
            ~/rpmbuild/SRPMS/
```

## Best Practices

### Comprehensive SPEC File Template
```spec
# myapp.spec - Example RPM specification file

Name:           myapp
Version:        1.0.0
Release:        1%{?dist}
Summary:        My Application - A sample application

License:        MIT
URL:            https://github.com/example/myapp
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc
BuildRequires:  make
BuildRequires:  pkgconfig
BuildRequires:  systemd-rpm-macros

Requires:       systemd
Requires:       logrotate
Requires(pre):  shadow-utils
Requires(post): systemd
Requires(preun): systemd
Requires(postun): systemd

%description
My Application is a sample application that demonstrates
proper RPM packaging techniques including systemd integration,
user management, and configuration file handling.

%prep
%setup -q

%build
# Configure build environment
make %{?_smp_mflags} \
    PREFIX=%{_prefix} \
    BINDIR=%{_bindir} \
    SYSCONFDIR=%{_sysconfdir} \
    LOCALSTATEDIR=%{_localstatedir}

%install
# Remove any existing build root
rm -rf $RPM_BUILD_ROOT

# Install application files
make install \
    DESTDIR=$RPM_BUILD_ROOT \
    PREFIX=%{_prefix} \
    BINDIR=%{_bindir} \
    SYSCONFDIR=%{_sysconfdir} \
    LOCALSTATEDIR=%{_localstatedir}

# Install systemd service file
install -D -m 644 packaging/myapp.service \
    $RPM_BUILD_ROOT%{_unitdir}/myapp.service

# Install configuration file
install -D -m 644 packaging/myapp.conf \
    $RPM_BUILD_ROOT%{_sysconfdir}/myapp/myapp.conf

# Install logrotate configuration
install -D -m 644 packaging/myapp.logrotate \
    $RPM_BUILD_ROOT%{_sysconfdir}/logrotate.d/myapp

# Create directories
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/myapp
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/lib/myapp
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/run/myapp

%pre
# Create user account
getent group myapp >/dev/null || groupadd -r myapp
getent passwd myapp >/dev/null || \
    useradd -r -g myapp -d %{_localstatedir}/lib/myapp \
    -s /sbin/nologin -c "My Application User" myapp
exit 0

%post
# Enable and start systemd service
%systemd_post myapp.service

# Set proper permissions
chown -R myapp:myapp %{_localstatedir}/log/myapp
chown -R myapp:myapp %{_localstatedir}/lib/myapp
chown -R myapp:myapp %{_localstatedir}/run/myapp

%preun
# Stop systemd service before uninstall
%systemd_preun myapp.service

%postun
# Cleanup after uninstall
%systemd_postun_with_restart myapp.service

# Remove user account on complete removal
if [ $1 -eq 0 ]; then
    userdel myapp >/dev/null 2>&1 || :
    groupdel myapp >/dev/null 2>&1 || :
fi

%files
%doc README.md CHANGELOG.md
%license LICENSE

# Binaries
%{_bindir}/myapp

# Configuration files
%config(noreplace) %{_sysconfdir}/myapp/myapp.conf
%config %{_sysconfdir}/logrotate.d/myapp

# Systemd service
%{_unitdir}/myapp.service

# Directories with proper ownership
%dir %attr(755, myapp, myapp) %{_localstatedir}/log/myapp
%dir %attr(755, myapp, myapp) %{_localstatedir}/lib/myapp
%dir %attr(755, myapp, myapp) %{_localstatedir}/run/myapp

%changelog
* Fri Aug 16 2025 Your Name <your.email@example.com> - 1.0.0-1
- Initial package release
- Added systemd integration
- Implemented proper user management
- Added logrotate configuration
```

### Advanced RPM Operations and Queries
```bash
#!/bin/bash
# Advanced RPM management and analysis script

# Package verification and integrity checking
verify_system_packages() {
    echo "Performing comprehensive package verification"
    
    # Verify all installed packages
    echo "Verifying all packages (this may take a while)..."
    rpm -Va > /tmp/rpm-verify.log 2>&1
    
    # Analyze verification results
    if [ -s /tmp/rpm-verify.log ]; then
        echo "Package verification issues found:"
        cat /tmp/rpm-verify.log
        
        # Categorize issues
        echo -e "\nConfiguration files modified:"
        grep '^..5' /tmp/rpm-verify.log || echo "None"
        
        echo -e "\nMissing files:"
        grep '^missing' /tmp/rpm-verify.log || echo "None"
        
        echo -e "\nSize changes:"
        grep '^S' /tmp/rpm-verify.log || echo "None"
    else
        echo "All packages verified successfully"
    fi
}

# Package dependency analysis
analyze_dependencies() {
    local package="$1"
    
    echo "Analyzing dependencies for: $package"
    
    # Show package dependencies
    echo "Package requires:"
    rpm -qR "$package" | sort
    
    echo -e "\nWhat provides this package's dependencies:"
    rpm -qR "$package" | while read dep; do
        echo "Dependency: $dep"
        rpm -q --whatprovides "$dep" 2>/dev/null || echo "  Not found"
    done
    
    echo -e "\nPackages that depend on $package:"
    rpm -q --whatrequires "$package" 2>/dev/null || echo "None"
    
    # Show package conflicts
    echo -e "\nPackage conflicts:"
    rpm -q --conflicts "$package" 2>/dev/null || echo "None"
}

# Package file ownership analysis
analyze_file_ownership() {
    local file_path="$1"
    
    echo "Analyzing file ownership for: $file_path"
    
    # Check if file exists
    if [ ! -e "$file_path" ]; then
        echo "File does not exist: $file_path"
        return 1
    fi
    
    # Find owning package
    owning_package=$(rpm -qf "$file_path" 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        echo "File owned by package: $owning_package"
        
        # Show package information
        echo -e "\nPackage details:"
        rpm -qi "$owning_package"
        
        # Show file details within package
        echo -e "\nFile details in package:"
        rpm -ql "$owning_package" | grep "$(basename "$file_path")"
    else
        echo "File not owned by any RPM package"
        
        # Check if it's a configuration file
        echo "File system information:"
        ls -la "$file_path"
        file "$file_path"
    fi
}

# Package comparison and differences
compare_packages() {
    local package1="$1"
    local package2="$2"
    
    echo "Comparing packages: $package1 vs $package2"
    
    # Get file lists
    rpm -ql "$package1" | sort > /tmp/pkg1_files.list
    rpm -ql "$package2" | sort > /tmp/pkg2_files.list
    
    # Compare file lists
    echo "Files only in $package1:"
    comm -23 /tmp/pkg1_files.list /tmp/pkg2_files.list
    
    echo -e "\nFiles only in $package2:"
    comm -13 /tmp/pkg1_files.list /tmp/pkg2_files.list
    
    echo -e "\nCommon files:"
    comm -12 /tmp/pkg1_files.list /tmp/pkg2_files.list
    
    # Compare dependencies
    echo -e "\nDependency comparison:"
    echo "Dependencies only in $package1:"
    comm -23 <(rpm -qR "$package1" | sort) <(rpm -qR "$package2" | sort)
    
    echo -e "\nDependencies only in $package2:"
    comm -13 <(rpm -qR "$package1" | sort) <(rpm -qR "$package2" | sort)
    
    # Cleanup
    rm -f /tmp/pkg1_files.list /tmp/pkg2_files.list
}

# Security and vulnerability analysis
security_analysis() {
    echo "Performing security analysis"
    
    # Check for packages with security updates
    echo "Checking for security updates..."
    yum --security check-update 2>/dev/null || echo "No security updates or yum not available"
    
    # Verify package signatures
    echo -e "\nVerifying package signatures for critical packages..."
    critical_packages=("kernel" "glibc" "openssl" "openssh" "sudo")
    
    for pkg in "${critical_packages[@]}"; do
        if rpm -q "$pkg" >/dev/null 2>&1; then
            echo "Verifying $pkg signature..."
            rpm -qi "$pkg" | grep "Signature"
        fi
    done
    
    # Check for packages without signatures
    echo -e "\nPackages without signatures:"
    rpm -qa --qf "%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}: %{SIGPGP:pgpsig}\n" | \
        grep "none" | head -10
}

# Package history and rollback preparation
package_history() {
    echo "Package installation history"
    
    # Show recent package operations
    echo "Recent RPM transactions:"
    rpm -qa --last | head -20
    
    # Show package installation dates
    echo -e "\nPackage installation timeline:"
    rpm -qa --qf "%{NAME}-%{VERSION}-%{RELEASE}: %{INSTALLTIME:date}\n" | \
        sort -k2 | tail -20
    
    # Identify recently modified packages
    echo -e "\nPackages modified in last 7 days:"
    find /var/lib/rpm -name "*.rpm" -mtime -7 2>/dev/null || \
        echo "No recent package database modifications found"
}

# Main function dispatcher
main() {
    case "${1:-help}" in
        "verify")
            verify_system_packages
            ;;
        "deps")
            if [ -z "${2:-}" ]; then
                echo "Usage: $0 deps <package-name>"
                exit 1
            fi
            analyze_dependencies "$2"
            ;;
        "file")
            if [ -z "${2:-}" ]; then
                echo "Usage: $0 file <file-path>"
                exit 1
            fi
            analyze_file_ownership "$2"
            ;;
        "compare")
            if [ -z "${2:-}" ] || [ -z "${3:-}" ]; then
                echo "Usage: $0 compare <package1> <package2>"
                exit 1
            fi
            compare_packages "$2" "$3"
            ;;
        "security")
            security_analysis
            ;;
        "history")
            package_history
            ;;
        "help"|*)
            echo "Usage: $0 {verify|deps|file|compare|security|history}"
            echo ""
            echo "Commands:"
            echo "  verify          - Verify all installed packages"
            echo "  deps <pkg>      - Analyze package dependencies"
            echo "  file <path>     - Analyze file ownership"
            echo "  compare <p1> <p2> - Compare two packages"
            echo "  security        - Perform security analysis"
            echo "  history         - Show package history"
            ;;
    esac
}

main "$@"
```

## Common Patterns and Examples

### Pattern 1: Custom Application Packaging
**Scenario**: Package a custom application with all dependencies and proper system integration
**Implementation**:
```bash
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
```
**Expected Outcomes**: Properly packaged application with system integration and dependency management

### Pattern 2: System Configuration Package
**Scenario**: Create RPM packages for system configurations and settings
**Implementation**:
```spec
# system-config.spec - System configuration package

Name:           company-system-config
Version:        1.0
Release:        1%{?dist}
Summary:        Company standard system configuration

License:        Proprietary
Group:          System Environment/Base
BuildArch:      noarch
Source0:        %{name}-%{version}.tar.gz

Requires:       bash
Requires:       systemd
Requires:       firewalld
Requires:       rsyslog

%description
Standard system configuration package for company servers.
Includes security settings, monitoring configuration, and
standardized system defaults.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT

# Create directory structure
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/company
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/systemd/system
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/rsyslog.d
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/firewalld/services
mkdir -p $RPM_BUILD_ROOT%{_bindir}

# Install configuration files
install -m 644 configs/company.conf $RPM_BUILD_ROOT%{_sysconfdir}/company/
install -m 644 configs/rsyslog-company.conf $RPM_BUILD_ROOT%{_sysconfdir}/rsyslog.d/
install -m 644 configs/company-app.xml $RPM_BUILD_ROOT%{_sysconfdir}/firewalld/services/

# Install scripts
install -m 755 scripts/company-setup.sh $RPM_BUILD_ROOT%{_bindir}/
install -m 755 scripts/company-monitor.sh $RPM_BUILD_ROOT%{_bindir}/

%post
# Configure firewall
firewall-cmd --permanent --add-service=company-app >/dev/null 2>&1 || :
firewall-cmd --reload >/dev/null 2>&1 || :

# Configure rsyslog
systemctl restart rsyslog >/dev/null 2>&1 || :

# Run initial setup
%{_bindir}/company-setup.sh

%preun
if [ $1 -eq 0 ]; then
    # Remove firewall service
    firewall-cmd --permanent --remove-service=company-app >/dev/null 2>&1 || :
    firewall-cmd --reload >/dev/null 2>&1 || :
fi

%files
%config(noreplace) %{_sysconfdir}/company/company.conf
%config %{_sysconfdir}/rsyslog.d/rsyslog-company.conf
%{_sysconfdir}/firewalld/services/company-app.xml
%{_bindir}/company-setup.sh
%{_bindir}/company-monitor.sh

%changelog
* Fri Aug 16 2025 System Admin <admin@company.com> - 1.0-1
- Initial system configuration package
- Added firewall rules for company applications
- Configured centralized logging
- Added monitoring scripts
```
**Expected Outcomes**: Standardized system configuration deployable across multiple servers

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Installing Packages with `--force`
- **Description**: Using `--force` to bypass dependency or conflict checks
- **Why It's Problematic**: Can break system dependencies and cause instability
- **Better Approach**: Resolve dependencies properly or use higher-level tools like YUM/DNF

#### Anti-Pattern 2: Modifying System Files Without Package Management
- **Description**: Directly editing files managed by RPM packages
- **Why It's Problematic**: Changes are lost during package updates and can cause verification failures
- **Better Approach**: Use configuration packages or proper configuration management tools

## Tools and Resources

### RPM Development and Analysis Tools
```bash
# RPM development tools
rpmbuild -ba package.spec           # Build binary and source RPM
rpmbuild -bb package.spec           # Build binary RPM only
rpmbuild -bs package.spec           # Build source RPM only
rpmdev-setuptree                    # Setup build directory structure
rpmdev-newspec                      # Create new SPEC file template
spectool -g -R package.spec         # Download sources
rpmlint package.spec                # Check SPEC file quality
rpmlint package.rpm                 # Check RPM package quality

# Package analysis
rpm -qip package.rpm                # Query package information
rpm -qlp package.rpm                # List package files
rpm -qRp package.rpm                # List package dependencies
rpm -q --scripts package-name       # Show package scripts
rpm -q --changelog package-name     # Show package changelog
rpm --verify package-name           # Verify package files
```

### Security and Verification Tools
```bash
# GPG signature verification
rpm --checksig package.rpm          # Check package signature
rpm --import key.asc                # Import GPG key
rpm -q --qf "%{SIGPGP:pgpsig}\n" package  # Show signature info

# Package integrity
rpm -Va                             # Verify all packages
rpm -V package-name                 # Verify specific package
rpm -Vf /path/to/file              # Verify file's package
rpm --verify --nodeps package-name # Verify without dependency check

# Database operations
rpm --rebuilddb                     # Rebuild RPM database
rpm --initdb                       # Initialize RPM database
rpmdb_verify /var/lib/rpm/Packages # Verify database integrity
```

### Learning Resources
- **RPM Guide**: https://rpm-guide.readthedocs.io/
- **Red Hat RPM Guide**: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/rpm_packaging_guide/
- **Fedora Packaging Guidelines**: https://docs.fedoraproject.org/en-US/packaging-guidelines/
- **SPEC File Reference**: https://rpm-software-management.github.io/rpm/manual/spec.html

## Quality and Compliance

### Quality Standards
- Comprehensive SPEC file documentation with proper metadata
- Package verification and integrity checking
- Proper dependency declaration and conflict resolution
- Standardized file permissions and ownership
- Complete changelog maintenance

### Security Standards
- GPG signature verification for all packages
- Minimal package installation with necessary files only
- Proper user and group management in package scripts
- Secure file permissions and ownership
- Regular package verification and integrity checks

### Performance Standards
- Optimized package size and installation time
- Efficient dependency resolution
- Minimal system resource usage during installation
- Clean package removal without leftover files

## AI Assistant Guidelines

When helping with RPM Package Management:

1. **Security Priority**: Always emphasize package signature verification and trusted sources
2. **SPEC File Quality**: Generate comprehensive SPEC files with proper metadata and scripts
3. **Dependency Management**: Properly declare all dependencies and conflicts
4. **System Integration**: Include proper systemd, user management, and configuration handling
5. **Build Environment**: Set up proper RPM build environments with necessary tools
6. **Testing Strategy**: Include package installation and functionality testing
7. **Version Control**: Implement proper versioning and changelog management
8. **Documentation**: Provide comprehensive package documentation and usage instructions

### Decision Making Framework
When helping teams choose RPM packaging approaches:

1. **Requirements Analysis**: Understand application dependencies and system integration needs
2. **Distribution Strategy**: Plan for package distribution and repository management
3. **Security Assessment**: Implement appropriate package signing and verification
4. **Build Pipeline**: Design automated build and testing workflows
5. **Maintenance Planning**: Plan for package updates and lifecycle management

### Code Generation Rules
- Generate complete SPEC files with proper sections and metadata
- Include comprehensive pre/post installation scripts for system integration
- Use proper RPM macros and build environment configuration
- Implement package verification and integrity checking
- Generate build automation scripts and CI/CD integration
- Include proper error handling and rollback capabilities
- Provide package testing and validation procedures
- Include security verification and signature checking

### Quality Enforcement
- ✅ Enforce package signature verification for all installations
- ✅ Require comprehensive SPEC file documentation and metadata
- ✅ Block usage of `--force` and similar dangerous options
- ✅ Enforce proper dependency declaration and conflict resolution
- ✅ Require package verification after installation
- ✅ Enforce proper file permissions and ownership in packages
- ✅ Promote automated build and testing workflows
- ✅ Require changelog maintenance for all package updates