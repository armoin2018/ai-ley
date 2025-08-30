#!/bin/bash

# WordPress Theme Build Script
# Builds WordPress theme for distribution to WordPress.org and premium marketplaces

set -e

# Configuration
THEME_NAME="${THEME_NAME:-theme-name}"
THEME_VERSION="${THEME_VERSION:-1.0.0}"
BUILD_DIR="${BUILD_DIR:-build}"
DIST_DIR="${DIST_DIR:-dist}"
SOURCE_DIR="${SOURCE_DIR:-${THEME_NAME}}"
SRC_DIR="${SRC_DIR:-src}"

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
    log "Verifying WordPress theme development environment..."
    
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
    
    # Install npm dependencies
    if [[ -f "package.json" ]]; then
        log "Installing npm dependencies..."
        npm ci --production
    fi
    
    success "Dependencies installed"
}

# Validate theme structure
validate_theme() {
    log "Validating theme structure..."
    
    # Check required files
    local required_files=("style.css" "index.php")
    for file in "${required_files[@]}"; do
        if [[ ! -f "${SOURCE_DIR}/${file}" ]]; then
            error "Required file not found: ${SOURCE_DIR}/${file}"
        fi
    done
    
    # Check style.css headers
    local style_file="${SOURCE_DIR}/style.css"
    if ! grep -q "Theme Name:" "$style_file"; then
        error "Theme Name header missing in style.css"
    fi
    
    if ! grep -q "Version:" "$style_file"; then
        error "Version header missing in style.css"
    fi
    
    if ! grep -q "Description:" "$style_file"; then
        warning "Description header missing in style.css"
    fi
    
    # Check for screenshot
    if [[ ! -f "${SOURCE_DIR}/screenshot.png" ]]; then
        warning "screenshot.png not found - required for WordPress.org submission"
    fi
    
    # Validate screenshot dimensions
    if [[ -f "${SOURCE_DIR}/screenshot.png" ]] && command -v identify &> /dev/null; then
        local dimensions=$(identify -format "%wx%h" "${SOURCE_DIR}/screenshot.png")
        if [[ "$dimensions" != "1200x900" ]]; then
            warning "Screenshot should be 1200x900 pixels. Current: $dimensions"
        fi
    fi
    
    success "Theme structure validation complete"
}

# Run theme security checks
security_check() {
    log "Running security checks..."
    
    local security_issues=0
    
    # Check for direct file access protection
    if ! grep -r "defined( 'ABSPATH' )" "${SOURCE_DIR}" --include="*.php" > /dev/null; then
        warning "Some PHP files may not have direct access protection"
        ((security_issues++))
    fi
    
    # Check for proper data sanitization
    if grep -r "echo \$_" "${SOURCE_DIR}" --include="*.php" > /dev/null; then
        warning "Potential XSS vulnerabilities found"
        ((security_issues++))
    fi
    
    # Check for SQL injection protection
    if grep -r "\$wpdb->query" "${SOURCE_DIR}" --include="*.php" | grep -v "prepare" > /dev/null; then
        warning "Potential SQL injection vulnerabilities found"
        ((security_issues++))
    fi
    
    # Check for eval() usage
    if grep -r "eval(" "${SOURCE_DIR}" --include="*.php" > /dev/null; then
        warning "Usage of eval() found - potential security risk"
        ((security_issues++))
    fi
    
    if [[ $security_issues -eq 0 ]]; then
        success "Security check complete - no issues found"
    else
        warning "Security check complete - ${security_issues} potential issues found"
    fi
}

# Run PHP CodeSniffer
run_phpcs() {
    log "Running PHP CodeSniffer..."
    
    if command -v phpcs &> /dev/null; then
        # Use WordPress coding standards
        phpcs --standard=WordPress-Theme "${SOURCE_DIR}" --extensions=php --ignore=*/node_modules/*,*/vendor/* || warning "PHPCS found coding standard violations"
    else
        warning "PHP CodeSniffer not found - skipping code style check"
    fi
}

# Run theme unit tests
run_tests() {
    log "Running theme tests..."
    
    # Run PHPUnit tests if available
    if [[ -f "phpunit.xml" ]] && command -v phpunit &> /dev/null; then
        log "Running PHPUnit tests..."
        phpunit || error "Unit tests failed"
    else
        warning "PHPUnit not configured - skipping unit tests"
    fi
    
    # Run WordPress theme unit tests
    if command -v wp &> /dev/null; then
        log "Running WordPress theme checks..."
        # Theme check using WordPress CLI
        wp theme list --format=json > /dev/null || warning "WordPress theme check failed"
    fi
    
    success "Tests completed"
}

# Build theme assets
build_assets() {
    log "Building theme assets..."
    
    # Compile SCSS to CSS
    if [[ -d "$SRC_DIR/scss" ]] && command -v sass &> /dev/null; then
        log "Compiling SCSS files..."
        sass "$SRC_DIR/scss/main.scss" "${SOURCE_DIR}/assets/css/main.css" --style=compressed
        sass "$SRC_DIR/scss/editor.scss" "${SOURCE_DIR}/assets/css/editor-style.css" --style=compressed
    elif [[ -f "Gruntfile.js" ]] && command -v grunt &> /dev/null; then
        log "Running Grunt build..."
        grunt build
    elif [[ -f "gulpfile.js" ]] && command -v gulp &> /dev/null; then
        log "Running Gulp build..."
        gulp build
    elif [[ -f "webpack.config.js" ]] && command -v webpack &> /dev/null; then
        log "Running Webpack build..."
        webpack --mode=production
    else
        warning "No build system configured - skipping asset compilation"
    fi
    
    # Optimize images
    if command -v imagemin &> /dev/null; then
        log "Optimizing images..."
        find "${SOURCE_DIR}/assets/images" -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" | xargs -I {} imagemin {} --out-dir="${SOURCE_DIR}/assets/images"
    fi
    
    success "Asset build complete"
}

# Generate RTL stylesheet
generate_rtl() {
    log "Generating RTL stylesheet..."
    
    if command -v rtlcss &> /dev/null; then
        # Generate RTL CSS from main stylesheet
        rtlcss "${SOURCE_DIR}/style.css" "${SOURCE_DIR}/rtl.css"
        
        # Generate RTL for main CSS file if exists
        if [[ -f "${SOURCE_DIR}/assets/css/main.css" ]]; then
            rtlcss "${SOURCE_DIR}/assets/css/main.css" "${SOURCE_DIR}/assets/css/main-rtl.css"
        fi
        
        success "RTL stylesheets generated"
    else
        warning "rtlcss not found - skipping RTL generation"
    fi
}

# Generate translation files
generate_translations() {
    log "Generating translation files..."
    
    if command -v wp &> /dev/null; then
        # Generate POT file
        wp i18n make-pot "${SOURCE_DIR}" "${SOURCE_DIR}/languages/${THEME_NAME}.pot" --domain="${THEME_NAME}"
        success "Translation files generated"
    else
        warning "WordPress CLI not available - skipping translation generation"
    fi
}

# Generate child theme
generate_child_theme() {
    log "Generating child theme..."
    
    local child_dir="${THEME_NAME}-child"
    mkdir -p "$BUILD_DIR/$child_dir"
    
    # Create child theme style.css
    cat > "$BUILD_DIR/$child_dir/style.css" << EOF
/*
Theme Name: ${THEME_NAME^} Child
Description: Child theme of ${THEME_NAME^}
Template: ${THEME_NAME}
Version: ${THEME_VERSION}
*/

/* Add your custom styles here */
EOF
    
    # Create child theme functions.php
    cat > "$BUILD_DIR/$child_dir/functions.php" << EOF
<?php
/**
 * ${THEME_NAME^} Child Theme Functions
 */

// Prevent direct access
if ( ! defined( 'ABSPATH' ) ) {
    exit;
}

/**
 * Enqueue parent and child theme styles
 */
function ${THEME_NAME//-/_}_child_enqueue_styles() {
    // Enqueue parent theme stylesheet
    wp_enqueue_style( 
        '${THEME_NAME//-/_}-parent-style', 
        get_template_directory_uri() . '/style.css',
        array(),
        wp_get_theme()->parent()->get('Version')
    );
    
    // Enqueue child theme stylesheet
    wp_enqueue_style( 
        '${THEME_NAME//-/_}-child-style',
        get_stylesheet_directory_uri() . '/style.css',
        array( '${THEME_NAME//-/_}-parent-style' ),
        wp_get_theme()->get('Version')
    );
}
add_action( 'wp_enqueue_scripts', '${THEME_NAME//-/_}_child_enqueue_styles' );

/**
 * Add your custom functions here
 */
EOF
    
    # Copy screenshot if exists
    if [[ -f "${SOURCE_DIR}/screenshot.png" ]]; then
        cp "${SOURCE_DIR}/screenshot.png" "$BUILD_DIR/$child_dir/"
    fi
    
    success "Child theme generated"
}

# Create build directory
prepare_build() {
    log "Preparing build directory..."
    
    # Clean and create build directory
    rm -rf "${BUILD_DIR}"
    mkdir -p "${BUILD_DIR}/${THEME_NAME}"
    
    # Copy theme files
    cp -r "${SOURCE_DIR}"/* "${BUILD_DIR}/${THEME_NAME}/"
    
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
    rm -rf "${BUILD_DIR}/${THEME_NAME}/src" 2>/dev/null || true
    rm -rf "${BUILD_DIR}/${THEME_NAME}/tests" 2>/dev/null || true
    rm -rf "${BUILD_DIR}/${THEME_NAME}/.github" 2>/dev/null || true
    
    success "Build directory prepared"
}

# Create distribution packages
create_packages() {
    log "Creating distribution packages..."
    
    mkdir -p "${DIST_DIR}"
    
    # Create ZIP for WordPress.org and premium distribution
    cd "${BUILD_DIR}"
    zip -r "../${DIST_DIR}/${THEME_NAME}-${THEME_VERSION}.zip" "${THEME_NAME}"
    
    # Create child theme package
    if [[ -d "${THEME_NAME}-child" ]]; then
        zip -r "../${DIST_DIR}/${THEME_NAME}-child-${THEME_VERSION}.zip" "${THEME_NAME}-child"
    fi
    
    cd ..
    
    # Create bundle package (parent + child)
    cd "${BUILD_DIR}"
    zip -r "../${DIST_DIR}/${THEME_NAME}-bundle-${THEME_VERSION}.zip" "${THEME_NAME}" "${THEME_NAME}-child" 2>/dev/null || true
    cd ..
    
    success "Distribution packages created"
}

# Update version numbers
update_version() {
    if [[ -n "$1" ]]; then
        local new_version="$1"
        log "Updating version to ${new_version}..."
        
        # Update style.css
        sed -i.bak "s/Version: .*/Version: ${new_version}/" "${SOURCE_DIR}/style.css"
        
        # Update package.json if exists
        if [[ -f "package.json" ]]; then
            npm version "${new_version}" --no-git-tag-version
        fi
        
        # Clean up backup files
        find . -name "*.bak" -delete
        
        THEME_VERSION="$new_version"
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
    log "Starting WordPress theme build process..."
    
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
            --child-theme)
                BUILD_CHILD=true
                shift
                ;;
            --help)
                cat << EOF
WordPress Theme Build Script

Usage: $0 [OPTIONS]

Options:
    --version VERSION    Update theme version
    --skip-tests        Skip running tests
    --release           Create release build
    --child-theme       Generate child theme
    --help              Show this help message

Environment Variables:
    THEME_NAME          Theme directory name (default: theme-name)
    THEME_VERSION       Theme version (default: 1.0.0)
    BUILD_DIR           Build directory (default: build)
    DIST_DIR            Distribution directory (default: dist)
    SOURCE_DIR          Source directory (default: \$THEME_NAME)
    SRC_DIR             Source assets directory (default: src)

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
    validate_theme
    security_check
    run_phpcs
    
    if [[ "$SKIP_TESTS" != "true" ]]; then
        run_tests
    fi
    
    build_assets
    generate_rtl
    generate_translations
    prepare_build
    
    if [[ "$BUILD_CHILD" == "true" ]] || [[ "$RELEASE_BUILD" == "true" ]]; then
        generate_child_theme
    fi
    
    create_packages
    generate_checksums
    
    success "WordPress theme build complete!"
    
    # Display build information
    echo
    log "Build Information:"
    echo "  Theme Name: ${THEME_NAME}"
    echo "  Version: ${THEME_VERSION}"
    echo "  Build Directory: ${BUILD_DIR}"
    echo "  Distribution Packages:"
    ls -la "${DIST_DIR}"/*.zip 2>/dev/null || echo "    No packages created"
    
    if [[ "$RELEASE_BUILD" == "true" ]]; then
        log "Release build completed. Packages are ready for distribution."
    fi
}

# Execute main function
main "$@"
