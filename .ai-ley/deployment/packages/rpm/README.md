# RPM Package Deployment Template

## Overview

This template provides comprehensive RPM package creation and deployment for Red Hat-based Linux distributions (RHEL, CentOS, Fedora, Amazon Linux) with automated build pipelines and repository management.

## Features

- **Multi-Architecture Support**: x86_64, aarch64, i386 package building
- **Repository Management**: YUM/DNF repository creation and maintenance
- **Digital Signing**: GPG signing for package authenticity
- **Dependency Management**: Automatic dependency resolution and conflicts
- **Configuration Management**: Pre/post install scripts and configuration files
- **Build Automation**: Automated build pipelines with CI/CD integration
- **Testing Framework**: Automated package testing and validation
- **Version Management**: Semantic versioning and release management

## Structure

```
rpm/
├── SPECS/
│   └── myapp.spec              # RPM specification file
├── SOURCES/
│   ├── myapp-1.0.0.tar.gz     # Source tarball
│   ├── myapp.service          # Systemd service file
│   ├── myapp.conf             # Configuration file
│   └── patches/               # Patch files
├── RPMS/                      # Built RPM packages
├── SRPMS/                     # Source RPM packages
├── BUILD/                     # Build directory
├── BUILDROOT/                 # Build root directory
├── scripts/
│   ├── build-rpm.sh          # RPM build script
│   ├── sign-rpm.sh           # Package signing script
│   ├── create-repo.sh        # Repository creation script
│   ├── deploy-rpm.sh         # Deployment script
│   └── test-rpm.sh           # Testing script
├── templates/
│   ├── spec.template         # Spec file template
│   ├── service.template      # Systemd service template
│   └── config.template       # Configuration template
├── repository/
│   ├── repodata/             # Repository metadata
│   ├── RPM-GPG-KEY-myapp     # GPG public key
│   └── myapp.repo            # Repository configuration
└── tests/
    ├── install-test.sh       # Installation testing
    ├── upgrade-test.sh       # Upgrade testing
    └── removal-test.sh       # Removal testing
```

## Quick Start

### 1. Setup Build Environment

```bash
# Install RPM build tools (RHEL/CentOS)
sudo yum groupinstall "Development Tools"
sudo yum install rpm-build rpm-devel rpmlint rpmdevtools

# Create RPM build environment
rpmdev-setuptree

# Copy template files
cp -r rpm/* ~/rpmbuild/
```

### 2. Configure Package

```bash
# Edit spec file
vim SPECS/myapp.spec

# Update version and metadata
# Configure dependencies and requirements
# Set build and install instructions
```

### 3. Build Package

```bash
# Build RPM package
./scripts/build-rpm.sh

# Sign package (optional)
./scripts/sign-rpm.sh

# Test package
./scripts/test-rpm.sh
```

### 4. Deploy Package

```bash
# Create repository
./scripts/create-repo.sh

# Deploy to repository server
./scripts/deploy-rpm.sh production

# Install package
sudo yum install myapp
```

## Best Practices

- **Spec File Quality**: Follow RPM packaging guidelines and standards
- **Dependency Management**: Specify accurate dependencies and conflicts
- **File Permissions**: Set appropriate file ownership and permissions
- **Documentation**: Include comprehensive package documentation
- **Testing**: Test installation, upgrade, and removal scenarios
- **Signing**: Sign packages for security and authenticity
- **Versioning**: Use semantic versioning for releases

## Integration with AI Agents

### Model Recommendations

- **Spec File Development**: GPT-4 (High/Technical)
- **Build Automation**: Claude-3-Sonnet (Moderate/Technical)
- **Testing Scripts**: GPT-3.5-Turbo (Moderate/Technical)
- **Documentation**: Claude-3-Sonnet (Moderate/Creative)

### Personas to Use

- `linux-package-maintainer.md` - RPM packaging expertise
- `devops-engineer.md` - Build automation and CI/CD
- `system-administrator.md` - System integration and deployment
- `security-engineer.md` - Package signing and security
