#!/bin/bash

# RPM Build Script
# Usage: ./build-rpm.sh [version] [release]

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RPM_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_ROOT="$HOME/rpmbuild"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[WARN] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS] $1${NC}"
}

# Parse arguments
VERSION="${1:-1.0.0}"
RELEASE="${2:-1}"

log "Starting RPM build process"
log "Version: $VERSION"
log "Release: $RELEASE"

# Check prerequisites
command -v rpmbuild >/dev/null 2>&1 || error "rpmbuild not found. Please install rpm-build package."
command -v rpmdev-setuptree >/dev/null 2>&1 || error "rpmdev-setuptree not found. Please install rpmdevtools package."

# Setup build environment
if [[ ! -d "$BUILD_ROOT" ]]; then
    log "Setting up RPM build environment..."
    rpmdev-setuptree
fi

# Copy spec file and update version
log "Preparing spec file..."
SPEC_FILE="$BUILD_ROOT/SPECS/myapp.spec"
cp "$RPM_DIR/SPECS/myapp.spec" "$SPEC_FILE"

# Update version and release in spec file
sed -i "s/^Version:.*/Version:        $VERSION/" "$SPEC_FILE"
sed -i "s/^Release:.*/Release:        $RELEASE%{?dist}/" "$SPEC_FILE"

# Copy source files
log "Copying source files..."
cp -r "$RPM_DIR/SOURCES/"* "$BUILD_ROOT/SOURCES/"

# Create source tarball if it doesn't exist
SOURCE_TARBALL="$BUILD_ROOT/SOURCES/myapp-$VERSION.tar.gz"
if [[ ! -f "$SOURCE_TARBALL" ]]; then
    log "Creating source tarball..."
    
    # This would typically package your application source code
    # For demonstration, we'll create a minimal source structure
    TEMP_DIR=$(mktemp -d)
    APP_DIR="$TEMP_DIR/myapp-$VERSION"
    
    mkdir -p "$APP_DIR"
    cat > "$APP_DIR/Makefile" << 'EOF'
PREFIX ?= /usr
SYSCONFDIR ?= /etc
LOCALSTATEDIR ?= /var

all:
	@echo "Building myapp..."
	# Add your build commands here

install:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)$(PREFIX)/lib/myapp
	install -d $(DESTDIR)$(PREFIX)/share/man/man1
	install -d $(DESTDIR)$(PREFIX)/share/man/man5
	
	# Install binaries (create dummy files for demo)
	echo '#!/bin/bash' > $(DESTDIR)$(PREFIX)/bin/myapp
	echo 'echo "MyApp v$(VERSION)"' >> $(DESTDIR)$(PREFIX)/bin/myapp
	chmod +x $(DESTDIR)$(PREFIX)/bin/myapp
	
	echo '#!/bin/bash' > $(DESTDIR)$(PREFIX)/bin/myapp-cli
	echo 'echo "MyApp CLI v$(VERSION)"' >> $(DESTDIR)$(PREFIX)/bin/myapp-cli
	chmod +x $(DESTDIR)$(PREFIX)/bin/myapp-cli
	
	echo '#!/bin/bash' > $(DESTDIR)$(PREFIX)/bin/myapp-setup
	echo 'echo "MyApp Setup v$(VERSION)"' >> $(DESTDIR)$(PREFIX)/bin/myapp-setup
	chmod +x $(DESTDIR)$(PREFIX)/bin/myapp-setup
	
	# Install libraries
	echo "myapp library files" > $(DESTDIR)$(PREFIX)/lib/myapp/libmyapp.so
	
	# Install man pages
	echo ".TH MYAPP 1" > $(DESTDIR)$(PREFIX)/share/man/man1/myapp.1
	echo ".TH MYAPP.CONF 5" > $(DESTDIR)$(PREFIX)/share/man/man5/myapp.conf.5

clean:
	@echo "Cleaning build artifacts..."

.PHONY: all install clean
EOF

    # Create documentation files
    echo "# MyApp" > "$APP_DIR/README.md"
    echo "A sample application for RPM packaging demonstration." >> "$APP_DIR/README.md"
    
    echo "# Changelog" > "$APP_DIR/CHANGELOG.md"
    echo "## Version $VERSION" >> "$APP_DIR/CHANGELOG.md"
    echo "- Initial release" >> "$APP_DIR/CHANGELOG.md"
    
    echo "MIT License" > "$APP_DIR/LICENSE"
    
    # Create tarball
    cd "$TEMP_DIR"
    tar -czf "$SOURCE_TARBALL" "myapp-$VERSION"
    
    # Cleanup
    rm -rf "$TEMP_DIR"
    
    success "Source tarball created: $SOURCE_TARBALL"
fi

# Lint spec file
log "Linting spec file..."
if command -v rpmlint >/dev/null 2>&1; then
    rpmlint "$SPEC_FILE" || warn "rpmlint found issues in spec file"
else
    warn "rpmlint not available, skipping spec file validation"
fi

# Build source RPM
log "Building source RPM..."
rpmbuild -bs "$SPEC_FILE" --define "_topdir $BUILD_ROOT"

# Build binary RPM
log "Building binary RPM..."
rpmbuild -bb "$SPEC_FILE" --define "_topdir $BUILD_ROOT"

# Find built packages
BUILT_RPMS=$(find "$BUILD_ROOT/RPMS" -name "*.rpm" -newer "$SPEC_FILE" 2>/dev/null || true)
BUILT_SRPMS=$(find "$BUILD_ROOT/SRPMS" -name "*.rpm" -newer "$SPEC_FILE" 2>/dev/null || true)

if [[ -n "$BUILT_RPMS" ]]; then
    success "Binary RPMs built successfully:"
    echo "$BUILT_RPMS" | while read -r rpm; do
        echo "  - $rpm"
        
        # Display package information
        log "Package information for $(basename "$rpm"):"
        rpm -qip "$rpm" | head -20
        echo
    done
fi

if [[ -n "$BUILT_SRPMS" ]]; then
    success "Source RPMs built successfully:"
    echo "$BUILT_SRPMS" | while read -r srpm; do
        echo "  - $srpm"
    done
fi

# Copy packages to local directory
log "Copying packages to local directory..."
mkdir -p "$RPM_DIR/RPMS" "$RPM_DIR/SRPMS"

if [[ -n "$BUILT_RPMS" ]]; then
    echo "$BUILT_RPMS" | while read -r rpm; do
        cp "$rpm" "$RPM_DIR/RPMS/"
    done
fi

if [[ -n "$BUILT_SRPMS" ]]; then
    echo "$BUILT_SRPMS" | while read -r srpm; do
        cp "$srpm" "$RPM_DIR/SRPMS/"
    done
fi

# Display build summary
log "Build completed successfully!"
log "Built packages:"
ls -la "$RPM_DIR/RPMS/"*.rpm 2>/dev/null || true
ls -la "$RPM_DIR/SRPMS/"*.rpm 2>/dev/null || true

# Run basic package validation
log "Running package validation..."
for rpm in "$RPM_DIR/RPMS/"*.rpm; do
    if [[ -f "$rpm" ]]; then
        log "Validating $rpm..."
        rpm -K "$rpm" || warn "Package signature validation failed"
        rpm -qp --requires "$rpm" | head -10
        echo
    fi
done

success "RPM build process completed!"
log "Next steps:"
log "1. Test the package: ./test-rpm.sh"
log "2. Sign the package: ./sign-rpm.sh (optional)"
log "3. Deploy to repository: ./deploy-rpm.sh"
