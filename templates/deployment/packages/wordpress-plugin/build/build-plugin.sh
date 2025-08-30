#!/bin/bash

# WordPress Plugin Build Script
# Builds WordPress plugin for distribution to WordPress.org and premium marketplaces

set -e

# Configuration
PLUGIN_NAME="${PLUGIN_NAME:-plugin-name}"
PLUGIN_VERSION="${PLUGIN_VERSION:-1.0.0}"
BUILD_DIR="${BUILD_DIR:-build}"
DIST_DIR="${DIST_DIR:-dist}"
SOURCE_DIR="${SOURCE_DIR:-${PLUGIN_NAME}}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Verify WordPress environment
verify_environment() {
    log "Verifying WordPress development environment..."
    
    # Check for WordPress CLI
    if ! command -v wp &> /dev/null; then
        error "WordPress CLI (wp) is not installed or not in PATH"
    fi
    
    # Check for Node.js and npm
    if ! command -v node &> /dev/null; then
        error "Node.js is not installed"
    fi
    
    if ! command -v npm &> /dev/null; then
        error "npm is not installed"
    fi
    
    # Check for Composer
    if ! command -v composer &> /dev/null; then
        error "Composer is not installed"
    fi
    
    # Check for PHP
    if ! command -v php &> /dev/null; then
        error "PHP is not installed"
    fi
    
    # Verify PHP version (WordPress requirement)
    PHP_VERSION=$(php -r "echo PHP_VERSION;")
    if [[ "$(printf '%s\n' "7.4" "$PHP_VERSION" | sort -V | head -n1)" != "7.4" ]]; then
        error "PHP 7.4 or higher is required. Current version: $PHP_VERSION"
    fi
    
    success "Environment verification complete"
}

# Install dependencies
install_dependencies() {
    log "Installing project dependencies..."
    
    # Install Composer dependencies
    if [[ -f "composer.json" ]]; then
        log "Installing Composer dependencies..."
        composer install --no-dev --optimize-autoloader
    fi
    
    # Install npm dependencies
    if [[ -f "package.json" ]]; then
        log "Installing npm dependencies..."
        npm ci --production
    fi
    
    success "Dependencies installed"
}

# Validate plugin structure
validate_plugin() {
    log "Validating plugin structure..."
    
    # Check main plugin file
    if [[ ! -f "${SOURCE_DIR}/${PLUGIN_NAME}.php" ]]; then
        error "Main plugin file not found: ${SOURCE_DIR}/${PLUGIN_NAME}.php"
    fi
    
    # Check readme.txt
    if [[ ! -f "${SOURCE_DIR}/readme.txt" ]]; then
        error "WordPress.org readme.txt not found"
    fi
    
    # Validate plugin headers
    if ! grep -q "Plugin Name:" "${SOURCE_DIR}/${PLUGIN_NAME}.php"; then
        error "Plugin Name header missing in main plugin file"
    fi
    
    if ! grep -q "Version:" "${SOURCE_DIR}/${PLUGIN_NAME}.php"; then
        error "Version header missing in main plugin file"
    fi
    
    # Check for required directories
    for dir in "includes" "admin" "public"; do
        if [[ ! -d "${SOURCE_DIR}/${dir}" ]]; then
            warning "Directory ${dir} not found - this may be intentional"
        fi
    done
    
    success "Plugin structure validation complete"
}

# Run security checks
security_check() {
    log "Running security checks..."
    
    # Check for WordPress security best practices
    SECURITY_ISSUES=0
    
    # Check for direct file access protection
    if ! grep -r "defined( 'ABSPATH' )" "${SOURCE_DIR}" --include="*.php" > /dev/null; then
        warning "Some PHP files may not have direct access protection"
        ((SECURITY_ISSUES++))
    fi
    
    # Check for SQL injection protection
    if grep -r "\$wpdb->query" "${SOURCE_DIR}" --include="*.php" | grep -v "prepare" > /dev/null; then
        warning "Potential SQL injection vulnerabilities found"
        ((SECURITY_ISSUES++))
    fi
    
    # Check for XSS protection
    if grep -r "echo \$_" "${SOURCE_DIR}" --include="*.php" > /dev/null; then
        warning "Potential XSS vulnerabilities found"
        ((SECURITY_ISSUES++))
    fi
    
    if [[ $SECURITY_ISSUES -eq 0 ]]; then
        success "Security check complete - no issues found"
    else
        warning "Security check complete - ${SECURITY_ISSUES} potential issues found"
    fi
}

# Run PHP CodeSniffer
run_phpcs() {
    log "Running PHP CodeSniffer..."
    
    if command -v phpcs &> /dev/null; then
        # Use WordPress coding standards
        phpcs --standard=WordPress "${SOURCE_DIR}" --extensions=php --ignore=*/node_modules/*,*/vendor/* || warning "PHPCS found coding standard violations"
    else
        warning "PHP CodeSniffer not found - skipping code style check"
    fi
}

# Run tests
run_tests() {
    log "Running tests..."
    
    # Run PHPUnit tests if available
    if [[ -f "phpunit.xml" ]] && command -v phpunit &> /dev/null; then
        log "Running PHPUnit tests..."
        phpunit || error "Unit tests failed"
    else
        warning "PHPUnit not configured - skipping unit tests"
    fi
    
    # Run WordPress plugin tests if available
    if [[ -f "tests/bin/install-wp-tests.sh" ]]; then
        log "Running WordPress integration tests..."
        cd tests
        bash bin/install-wp-tests.sh wordpress_test root password localhost latest
        phpunit || error "WordPress integration tests failed"
        cd ..
    else
        warning "WordPress integration tests not configured"
    fi
    
    success "Tests completed"
}

# Build plugin assets
build_assets() {
    log "Building plugin assets..."
    
    # Build CSS and JavaScript
    if [[ -f "Gruntfile.js" ]] && command -v grunt &> /dev/null; then
        log "Running Grunt build..."
        grunt build
    elif [[ -f "gulpfile.js" ]] && command -v gulp &> /dev/null; then
        log "Running Gulp build..."
        gulp build
    elif [[ -f "webpack.config.js" ]] && command -v webpack &> /dev/null; then
        log "Running Webpack build..."
        webpack --mode=production
    else
        warning "No build system configured - skipping asset build"
    fi
    
    success "Asset build complete"
}

# Generate translation files
generate_translations() {
    log "Generating translation files..."
    
    if command -v wp &> /dev/null; then
        # Generate POT file
        wp i18n make-pot "${SOURCE_DIR}" "${SOURCE_DIR}/languages/${PLUGIN_NAME}.pot" --domain="${PLUGIN_NAME}"
        success "Translation files generated"
    else
        warning "WordPress CLI not available - skipping translation generation"
    fi
}

# Create build directory
prepare_build() {
    log "Preparing build directory..."
    
    # Clean and create build directory
    rm -rf "${BUILD_DIR}"
    mkdir -p "${BUILD_DIR}/${PLUGIN_NAME}"
    
    # Copy plugin files
    cp -r "${SOURCE_DIR}"/* "${BUILD_DIR}/${PLUGIN_NAME}/"
    
    # Remove development files
    find "${BUILD_DIR}" -name "*.dev.*" -delete
    find "${BUILD_DIR}" -name "*.scss" -delete
    find "${BUILD_DIR}" -name "*.sass" -delete
    find "${BUILD_DIR}" -name "*.less" -delete
    find "${BUILD_DIR}" -name "*.ts" -delete
    find "${BUILD_DIR}" -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
    find "${BUILD_DIR}" -name ".git" -type d -exec rm -rf {} + 2>/dev/null || true
    find "${BUILD_DIR}" -name ".DS_Store" -delete 2>/dev/null || true
    
    # Remove development directories
    rm -rf "${BUILD_DIR}/${PLUGIN_NAME}/src" 2>/dev/null || true
    rm -rf "${BUILD_DIR}/${PLUGIN_NAME}/tests" 2>/dev/null || true
    rm -rf "${BUILD_DIR}/${PLUGIN_NAME}/.github" 2>/dev/null || true
    
    success "Build directory prepared"
}

# Create distribution packages
create_packages() {
    log "Creating distribution packages..."
    
    mkdir -p "${DIST_DIR}"
    
    # Create ZIP for WordPress.org and premium distribution
    cd "${BUILD_DIR}"
    zip -r "../${DIST_DIR}/${PLUGIN_NAME}-${PLUGIN_VERSION}.zip" "${PLUGIN_NAME}"
    cd ..
    
    # Create separate package for premium marketplaces (with license file)
    if [[ -f "LICENSE.premium" ]]; then
        cp "LICENSE.premium" "${BUILD_DIR}/${PLUGIN_NAME}/LICENSE"
        cd "${BUILD_DIR}"
        zip -r "../${DIST_DIR}/${PLUGIN_NAME}-premium-${PLUGIN_VERSION}.zip" "${PLUGIN_NAME}"
        cd ..
    fi
    
    success "Distribution packages created"
}

# Update version numbers
update_version() {
    if [[ -n "$1" ]]; then
        local new_version="$1"
        log "Updating version to ${new_version}..."
        
        # Update main plugin file
        sed -i.bak "s/Version: .*/Version: ${new_version}/" "${SOURCE_DIR}/${PLUGIN_NAME}.php"
        sed -i.bak "s/define( '.*_VERSION', '.*' );/define( '$(echo ${PLUGIN_NAME} | tr '[:lower:]' '[:upper:]' | tr '-' '_')_VERSION', '${new_version}' );/" "${SOURCE_DIR}/${PLUGIN_NAME}.php"
        
        # Update readme.txt
        sed -i.bak "s/Stable tag: .*/Stable tag: ${new_version}/" "${SOURCE_DIR}/readme.txt"
        
        # Update package.json if exists
        if [[ -f "package.json" ]]; then
            npm version "${new_version}" --no-git-tag-version
        fi
        
        # Clean up backup files
        find . -name "*.bak" -delete
        
        PLUGIN_VERSION="$new_version"
        success "Version updated to ${new_version}"
    fi
}

# Generate checksums
generate_checksums() {
    log "Generating checksums..."
    
    cd "${DIST_DIR}"
    for file in *.zip; do
        if [[ -f "$file" ]]; then
            md5sum "$file" > "${file}.md5"
            sha256sum "$file" > "${file}.sha256"
        fi
    done
    cd ..
    
    success "Checksums generated"
}

# Main build process
main() {
    log "Starting WordPress plugin build process..."
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --version)
                update_version "$2"
                shift 2
                ;;
            --skip-tests)
                SKIP_TESTS=true
                shift
                ;;
            --release)
                RELEASE_BUILD=true
                shift
                ;;
            --help)
                cat << EOF
WordPress Plugin Build Script

Usage: $0 [OPTIONS]

Options:
    --version VERSION    Update plugin version
    --skip-tests        Skip running tests
    --release           Create release build
    --help              Show this help message

Environment Variables:
    PLUGIN_NAME         Plugin directory name (default: plugin-name)
    PLUGIN_VERSION      Plugin version (default: 1.0.0)
    BUILD_DIR           Build directory (default: build)
    DIST_DIR            Distribution directory (default: dist)
    SOURCE_DIR          Source directory (default: \$PLUGIN_NAME)

EOF
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                ;;
        esac
    done
    
    # Run build steps
    verify_environment
    install_dependencies
    validate_plugin
    security_check
    run_phpcs
    
    if [[ "$SKIP_TESTS" != "true" ]]; then
        run_tests
    fi
    
    build_assets
    generate_translations
    prepare_build
    create_packages
    generate_checksums
    
    success "WordPress plugin build complete!"
    
    # Display build information
    echo
    log "Build Information:"
    echo "  Plugin Name: ${PLUGIN_NAME}"
    echo "  Version: ${PLUGIN_VERSION}"
    echo "  Build Directory: ${BUILD_DIR}"
    echo "  Distribution Packages:"
    ls -la "${DIST_DIR}"/*.zip 2>/dev/null || echo "    No packages created"
    
    if [[ "$RELEASE_BUILD" == "true" ]]; then
        log "Release build completed. Packages are ready for distribution."
    fi
}

# Execute main function
main "$@"
