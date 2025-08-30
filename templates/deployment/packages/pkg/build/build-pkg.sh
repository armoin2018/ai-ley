#!/bin/bash

# macOS PKG Build Script
# Usage: ./build-pkg.sh [version] [identifier]

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PKG_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_ROOT="$(dirname "$PKG_DIR")"

# Default values
APP_NAME="MyApp"
VERSION="${1:-1.0.0}"
BUNDLE_IDENTIFIER="${2:-com.myorg.myapp}"
DEVELOPER_ID="Developer ID Installer: Your Name (XXXXXXXXXX)"

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

log "Starting macOS PKG build process"
log "App Name: $APP_NAME"
log "Version: $VERSION"
log "Bundle Identifier: $BUNDLE_IDENTIFIER"

# Check prerequisites
if ! command -v pkgbuild >/dev/null 2>&1; then
    error "pkgbuild not found. Please install Xcode Command Line Tools."
fi

if ! command -v productbuild >/dev/null 2>&1; then
    error "productbuild not found. Please install Xcode Command Line Tools."
fi

# Create build directory
BUILD_DIR="$PKG_DIR/build/output"
TEMP_DIR="$PKG_DIR/build/temp"
mkdir -p "$BUILD_DIR" "$TEMP_DIR"

# Clean previous builds
rm -rf "$BUILD_DIR"/*.pkg "$TEMP_DIR"/*

log "Preparing application bundle..."

# Create application bundle structure
APP_BUNDLE="$PKG_DIR/payload/Applications/$APP_NAME.app"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"
mkdir -p "$APP_BUNDLE/Contents/Frameworks"

# Create Info.plist
log "Creating Info.plist..."
cat > "$APP_BUNDLE/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>$BUNDLE_IDENTIFIER</string>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundleDisplayName</key>
    <string>$APP_NAME</string>
    <key>CFBundleVersion</key>
    <string>$VERSION</string>
    <key>CFBundleShortVersionString</key>
    <string>$VERSION</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.15</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSSupportsAutomaticGraphicsSwitching</key>
    <true/>
    <key>LSApplicationCategoryType</key>
    <string>public.app-category.productivity</string>
</dict>
</plist>
EOF

# Create executable (dummy for demonstration)
log "Creating application executable..."
cat > "$APP_BUNDLE/Contents/MacOS/$APP_NAME" << 'EOF'
#!/bin/bash
echo "MyApp v$VERSION is running!"
echo "Bundle ID: $BUNDLE_IDENTIFIER"
exec /usr/bin/osascript -e 'display dialog "MyApp is running!" buttons {"OK"} default button "OK"'
EOF
chmod +x "$APP_BUNDLE/Contents/MacOS/$APP_NAME"

# Copy resources
log "Copying application resources..."
if [[ -d "$PKG_DIR/Resources" ]]; then
    cp -r "$PKG_DIR/Resources/"* "$APP_BUNDLE/Contents/Resources/" 2>/dev/null || true
fi

# Create component package
log "Building component package..."
COMPONENT_PKG="$TEMP_DIR/$APP_NAME-component.pkg"

pkgbuild \
    --root "$PKG_DIR/payload" \
    --identifier "$BUNDLE_IDENTIFIER.pkg" \
    --version "$VERSION" \
    --install-location "/" \
    --scripts "$PKG_DIR/scripts" \
    "$COMPONENT_PKG"

if [[ ! -f "$COMPONENT_PKG" ]]; then
    error "Failed to create component package"
fi

success "Component package created: $COMPONENT_PKG"

# Create distribution XML
log "Creating distribution definition..."
DISTRIBUTION_XML="$TEMP_DIR/distribution.xml"

cat > "$DISTRIBUTION_XML" << EOF
<?xml version="1.0" encoding="utf-8"?>
<installer-gui-script minSpecVersion="1">
    <title>$APP_NAME Installer</title>
    <organization>$BUNDLE_IDENTIFIER</organization>
    <domains enable_localSystem="true"/>
    <options customize="never" require-scripts="false" rootVolumeOnly="true"/>
    
    <!-- Background and appearance -->
    <background file="background.png" mime-type="image/png" alignment="topleft" scaling="tofit"/>
    
    <!-- License and readme -->
    <license file="license.txt"/>
    <readme file="readme.txt"/>
    <welcome file="welcome.txt"/>
    
    <!-- Choice definitions -->
    <choices-outline>
        <line choice="default">
            <line choice="$BUNDLE_IDENTIFIER.pkg"/>
        </line>
    </choices-outline>
    
    <choice id="default"/>
    <choice id="$BUNDLE_IDENTIFIER.pkg" visible="false">
        <pkg-ref id="$BUNDLE_IDENTIFIER.pkg"/>
    </choice>
    
    <pkg-ref id="$BUNDLE_IDENTIFIER.pkg">
        <bundle-version>
            <bundle id="$BUNDLE_IDENTIFIER"/>
        </bundle-version>
    </pkg-ref>
    
    <!-- Installation requirements -->
    <installation-check script="pm_install_check();"/>
    <script>
    <![CDATA[
        function pm_install_check() {
            if(!(system.compareVersions(system.version.ProductVersion, '10.15') >= 0)) {
                my.result.title = 'System Requirements Not Met';
                my.result.message = 'This application requires macOS 10.15 or later.';
                my.result.type = 'Fatal';
                return false;
            }
            return true;
        }
    ]]>
    </script>
</installer-gui-script>
EOF

# Build final installer package
log "Building final installer package..."
FINAL_PKG="$BUILD_DIR/$APP_NAME-$VERSION.pkg"

productbuild \
    --distribution "$DISTRIBUTION_XML" \
    --package-path "$TEMP_DIR" \
    --resources "$PKG_DIR/Resources" \
    "$FINAL_PKG"

if [[ ! -f "$FINAL_PKG" ]]; then
    error "Failed to create final package"
fi

success "Final package created: $FINAL_PKG"

# Display package information
log "Package information:"
pkgutil --check-signature "$FINAL_PKG"
pkgutil --payload-files "$FINAL_PKG" | head -20

# Calculate package size
PACKAGE_SIZE=$(du -h "$FINAL_PKG" | cut -f1)
log "Package size: $PACKAGE_SIZE"

# Verify package structure
log "Verifying package structure..."
pkgutil --expand "$FINAL_PKG" "$TEMP_DIR/expanded"
ls -la "$TEMP_DIR/expanded"

success "PKG build completed successfully!"
log "Package location: $FINAL_PKG"
log "Next steps:"
log "1. Test the package: ./test-pkg.sh"
log "2. Sign the package: ./sign-pkg.sh (for distribution)"
log "3. Notarize the package: ./notarize-pkg.sh (for distribution)"
log "4. Create DMG: ./create-dmg.sh (optional)"

# Cleanup temporary files
rm -rf "$TEMP_DIR"
