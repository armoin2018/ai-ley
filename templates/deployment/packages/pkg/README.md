# macOS PKG Package Deployment Template

## Overview

This template provides comprehensive macOS PKG package creation and deployment with code signing, notarization, and distribution through various channels including Mac App Store and direct distribution.

## Features

- **Code Signing**: Apple Developer certificate integration
- **Notarization**: Apple notarization service support
- **Distribution Methods**: App Store, direct download, enterprise distribution
- **Installer Scripts**: Pre/post install scripts and validation
- **Bundle Management**: Application bundle creation and management
- **Universal Binaries**: Support for Intel and Apple Silicon architectures
- **Automated Testing**: Installation and functionality testing
- **CI/CD Integration**: GitHub Actions and Xcode Cloud support

## Structure

```
pkg/
├── payload/                   # Package payload directory
│   └── Applications/
│       └── MyApp.app/        # Application bundle
├── scripts/
│   ├── preinstall           # Pre-installation script
│   ├── postinstall          # Post-installation script
│   ├── preupgrade           # Pre-upgrade script
│   └── postupgrade          # Post-upgrade script
├── Resources/
│   ├── background.png       # Installer background
│   ├── license.txt          # License agreement
│   ├── readme.txt           # Installation instructions
│   └── welcome.txt          # Welcome message
├── distribution.xml         # Distribution definition
├── component.plist         # Component property list
├── build/
│   ├── build-pkg.sh        # Package build script
│   ├── sign-pkg.sh         # Code signing script
│   ├── notarize-pkg.sh     # Notarization script
│   └── test-pkg.sh         # Testing script
├── templates/
│   ├── Info.plist.template # Bundle info template
│   ├── entitlements.plist  # App entitlements
│   └── distribution.template # Distribution template
└── certificates/
    ├── developer-id.p12    # Developer ID certificate
    └── provisioning.mobileprovision # Provisioning profile
```

## Quick Start

### 1. Setup Development Environment

```bash
# Install Xcode Command Line Tools
xcode-select --install

# Install required tools
brew install create-dmg
brew install packagesbuild

# Setup Apple Developer certificates
# Import Developer ID Application certificate
# Import Developer ID Installer certificate
```

### 2. Configure Package

```bash
# Update package metadata
vim distribution.xml
vim component.plist

# Configure application bundle
vim payload/Applications/MyApp.app/Contents/Info.plist
```

### 3. Build Package

```bash
# Build PKG package
./build/build-pkg.sh

# Sign package
./build/sign-pkg.sh

# Notarize package (for distribution)
./build/notarize-pkg.sh
```

### 4. Test and Distribute

```bash
# Test package installation
./build/test-pkg.sh

# Create DMG for distribution
./build/create-dmg.sh

# Upload to App Store (if applicable)
./build/upload-appstore.sh
```

## Best Practices

- **Code Signing**: Always sign packages for security and trust
- **Notarization**: Required for distribution outside Mac App Store
- **Bundle Structure**: Follow Apple's bundle structure guidelines
- **Installer UX**: Provide clear installation instructions and progress
- **Testing**: Test on multiple macOS versions and architectures
- **Documentation**: Include comprehensive user documentation
- **Version Management**: Implement proper version numbering

## Integration with AI Agents

### Model Recommendations

- **Package Development**: GPT-4 (High/Technical)
- **Bundle Configuration**: Claude-3-Sonnet (Moderate/Technical)
- **Installer Scripts**: GPT-3.5-Turbo (Moderate/Technical)
- **Documentation**: Claude-3-Sonnet (Moderate/Creative)

### Personas to Use

- `macos-developer.md` - macOS development and packaging
- `ios-developer.md` - Apple ecosystem development
- `devops-engineer.md` - Build automation and CI/CD
- `ux-designer.md` - Installer user experience
