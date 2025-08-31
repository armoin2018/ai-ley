#!/bin/bash

# WordPress.org Plugin Deployment Script
# Deploys plugin to WordPress.org SVN repository

set -e

# Configuration
PLUGIN_NAME="${PLUGIN_NAME:-plugin-name}"
PLUGIN_VERSION="${1:-}"
SVN_URL="${SVN_URL:-https://plugins.svn.wordpress.org/${PLUGIN_NAME}}"
SVN_USERNAME="${SVN_USERNAME:-}"
BUILD_DIR="${BUILD_DIR:-build}"
TEMP_DIR="/tmp/wp-plugin-deploy-$$"

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

# Cleanup function
cleanup() {
    if [[ -d "$TEMP_DIR" ]]; then
        log "Cleaning up temporary directory..."
        rm -rf "$TEMP_DIR"
    fi
}

trap cleanup EXIT

# Validate inputs
validate_inputs() {
    log "Validating deployment inputs..."
    
    if [[ -z "$PLUGIN_VERSION" ]]; then
        error "Plugin version is required. Usage: $0 <version>"
    fi
    
    if [[ -z "$SVN_USERNAME" ]]; then
        error "SVN_USERNAME environment variable is required"
    fi
    
    if [[ ! -d "$BUILD_DIR" ]]; then
        error "Build directory not found. Run build script first."
    fi
    
    if [[ ! -d "$BUILD_DIR/$PLUGIN_NAME" ]]; then
        error "Plugin build directory not found: $BUILD_DIR/$PLUGIN_NAME"
    fi
    
    # Check for svn command
    if ! command -v svn &> /dev/null; then
        error "Subversion (svn) is not installed"
    fi
    
    success "Input validation complete"
}

# Verify plugin version
verify_version() {
    log "Verifying plugin version..."
    
    local main_file="$BUILD_DIR/$PLUGIN_NAME/$PLUGIN_NAME.php"
    local readme_file="$BUILD_DIR/$PLUGIN_NAME/readme.txt"
    
    # Check version in main plugin file
    if ! grep -q "Version: $PLUGIN_VERSION" "$main_file"; then
        error "Version mismatch in main plugin file. Expected: $PLUGIN_VERSION"
    fi
    
    # Check version in readme.txt
    if ! grep -q "Stable tag: $PLUGIN_VERSION" "$readme_file"; then
        error "Version mismatch in readme.txt. Expected: $PLUGIN_VERSION"
    fi
    
    success "Version verification complete"
}

# Checkout SVN repository
checkout_svn() {
    log "Checking out SVN repository..."
    
    mkdir -p "$TEMP_DIR"
    cd "$TEMP_DIR"
    
    # Checkout the plugin repository
    svn co "$SVN_URL" svn-repo || error "Failed to checkout SVN repository"
    
    cd svn-repo
    
    # Verify repository structure
    if [[ ! -d "trunk" ]]; then
        error "Invalid WordPress.org plugin repository structure"
    fi
    
    success "SVN repository checked out"
}

# Update trunk
update_trunk() {
    log "Updating trunk with new version..."
    
    cd "$TEMP_DIR/svn-repo"
    
    # Remove old files from trunk
    rm -rf trunk/*
    
    # Copy new files to trunk
    cp -r "$OLDPWD/$BUILD_DIR/$PLUGIN_NAME"/* trunk/
    
    # Add any new files
    svn add trunk --force
    
    # Remove any deleted files
    svn status trunk | grep '^!' | awk '{print $2}' | xargs -r svn remove
    
    success "Trunk updated"
}

# Create tag
create_tag() {
    log "Creating tag for version $PLUGIN_VERSION..."
    
    cd "$TEMP_DIR/svn-repo"
    
    # Check if tag already exists
    if [[ -d "tags/$PLUGIN_VERSION" ]]; then
        warning "Tag $PLUGIN_VERSION already exists. Updating existing tag."
        rm -rf "tags/$PLUGIN_VERSION"
        svn remove "tags/$PLUGIN_VERSION" 2>/dev/null || true
    fi
    
    # Create tag directory
    mkdir -p "tags/$PLUGIN_VERSION"
    
    # Copy trunk to tag
    cp -r trunk/* "tags/$PLUGIN_VERSION/"
    
    # Add tag to SVN
    svn add "tags/$PLUGIN_VERSION"
    
    success "Tag $PLUGIN_VERSION created"
}

# Update assets
update_assets() {
    log "Updating plugin assets..."
    
    cd "$TEMP_DIR/svn-repo"
    
    local assets_dir="$OLDPWD/$BUILD_DIR/$PLUGIN_NAME/assets"
    
    if [[ -d "$assets_dir" ]]; then
        # Create assets directory if it doesn't exist
        if [[ ! -d "assets" ]]; then
            mkdir assets
            svn add assets
        fi
        
        # Copy asset files
        for asset in banner-1544x500.png banner-772x250.png icon-128x128.png icon-256x256.png screenshot-*.png; do
            if [[ -f "$assets_dir/$asset" ]]; then
                cp "$assets_dir/$asset" assets/
                svn add "assets/$asset" 2>/dev/null || true
            fi
        done
        
        success "Assets updated"
    else
        warning "No assets directory found - skipping asset update"
    fi
}

# Validate changes
validate_changes() {
    log "Validating SVN changes..."
    
    cd "$TEMP_DIR/svn-repo"
    
    # Show status
    echo
    log "SVN Status:"
    svn status
    
    # Check for common issues
    local status_output=$(svn status)
    
    # Check for missing files
    if echo "$status_output" | grep -q '^!'; then
        warning "Some files are missing (marked with !)"
    fi
    
    # Check for unversioned files
    if echo "$status_output" | grep -q '^?'; then
        warning "Some files are unversioned (marked with ?)"
        echo "Unversioned files:"
        echo "$status_output" | grep '^?' | awk '{print $2}'
    fi
    
    success "Change validation complete"
}

# Commit changes
commit_changes() {
    log "Committing changes to WordPress.org..."
    
    cd "$TEMP_DIR/svn-repo"
    
    local commit_message="Deploying version $PLUGIN_VERSION"
    
    # Ask for confirmation
    echo
    warning "You are about to commit the following changes to WordPress.org:"
    svn status
    echo
    read -p "Are you sure you want to proceed? (y/N): " -r
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log "Deployment cancelled by user"
        exit 0
    fi
    
    # Commit changes
    svn commit -m "$commit_message" --username "$SVN_USERNAME" || error "Failed to commit changes"
    
    success "Changes committed successfully"
}

# Verify deployment
verify_deployment() {
    log "Verifying deployment..."
    
    # Check if the tag exists in the repository
    svn info "$SVN_URL/tags/$PLUGIN_VERSION" >/dev/null 2>&1 || error "Tag $PLUGIN_VERSION not found in repository"
    
    # Check if trunk was updated
    local trunk_info=$(svn info "$SVN_URL/trunk" 2>/dev/null)
    if [[ -z "$trunk_info" ]]; then
        error "Trunk not found or not accessible"
    fi
    
    success "Deployment verification complete"
}

# Generate deployment report
generate_report() {
    log "Generating deployment report..."
    
    local report_file="deployment-report-$PLUGIN_VERSION.txt"
    
    cat > "$report_file" << EOF
WordPress.org Plugin Deployment Report
=====================================

Plugin: $PLUGIN_NAME
Version: $PLUGIN_VERSION
Deployment Date: $(date)
SVN URL: $SVN_URL
Username: $SVN_USERNAME

Deployment Status: SUCCESS

Files Deployed:
$(cd "$TEMP_DIR/svn-repo" && find trunk -type f | sort)

SVN Revision:
$(svn info "$SVN_URL/trunk" | grep "Last Changed Rev" || echo "Unable to retrieve revision")

Notes:
- Plugin successfully deployed to WordPress.org
- Tag $PLUGIN_VERSION created
- Trunk updated with latest version
- Assets updated (if available)

Next Steps:
1. Monitor WordPress.org for any deployment issues
2. Update plugin documentation if needed
3. Announce new version release
4. Monitor user feedback and support requests

EOF

    success "Deployment report saved to $report_file"
}

# Main deployment process
main() {
    log "Starting WordPress.org plugin deployment..."
    
    # Show deployment information
    echo
    log "Deployment Information:"
    echo "  Plugin: $PLUGIN_NAME"
    echo "  Version: $PLUGIN_VERSION"
    echo "  SVN URL: $SVN_URL"
    echo "  Username: $SVN_USERNAME"
    echo
    
    validate_inputs
    verify_version
    checkout_svn
    update_trunk
    create_tag
    update_assets
    validate_changes
    commit_changes
    verify_deployment
    generate_report
    
    success "WordPress.org plugin deployment complete!"
    
    # Display next steps
    echo
    log "Next Steps:"
    echo "1. Check WordPress.org plugin page for updates"
    echo "2. Monitor plugin directory for approval (if first submission)"
    echo "3. Update plugin changelog and documentation"
    echo "4. Announce release to users"
    echo
    log "Plugin URL: https://wordpress.org/plugins/$PLUGIN_NAME/"
}

# Help function
show_help() {
    cat << EOF
WordPress.org Plugin Deployment Script

Usage: $0 <version> [options]

Arguments:
    version             Plugin version to deploy (required)

Environment Variables:
    PLUGIN_NAME         Plugin name (default: plugin-name)
    SVN_USERNAME        WordPress.org SVN username (required)
    SVN_URL             SVN repository URL (default: auto-generated)
    BUILD_DIR           Build directory (default: build)

Examples:
    $0 1.0.0                    # Deploy version 1.0.0
    PLUGIN_NAME=my-plugin $0 1.0.0  # Deploy my-plugin version 1.0.0

Prerequisites:
    - Subversion (svn) must be installed
    - WordPress.org account with plugin access
    - Plugin must be built first (run build-plugin.sh)

EOF
}

# Check for help argument
if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Execute main function
main "$@"
