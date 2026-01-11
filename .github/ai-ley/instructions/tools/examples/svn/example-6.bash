#!/bin/bash
# Enterprise SVN release management workflow

# Configuration
PROJECT_NAME="enterprise-app"
SVN_BASE="https://svn.company.com/$PROJECT_NAME"
VERSION_FILE="VERSION"

# Create release branch
create_release_branch() {
    local version="$1"
    local branch_name="release-$version"
    
    echo "Creating release branch for version $version"
    
    # Create release branch from trunk
    svn copy "$SVN_BASE/trunk" "$SVN_BASE/branches/$branch_name" \
        -m "Create release branch for version $version"
    
    # Checkout release branch
    svn checkout "$SVN_BASE/branches/$branch_name" "./$branch_name"
    cd "$branch_name"
    
    # Update version file
    echo "$version" > "$VERSION_FILE"
    svn commit -m "Update version to $version for release"
    
    echo "Release branch $branch_name created and ready for stabilization"
}

# Finalize release
finalize_release() {
    local version="$1"
    local branch_name="release-$version"
    
    echo "Finalizing release $version"
    
    # Create release tag
    svn copy "$SVN_BASE/branches/$branch_name" "$SVN_BASE/tags/v$version" \
        -m "Release version $version"
    
    # Merge release branch back to trunk
    cd trunk
    svn update
    svn merge "$SVN_BASE/branches/$branch_name"
    svn commit -m "Merge release $version back to trunk"
    
    echo "Release $version finalized and tagged"
}

# Hotfix workflow
create_hotfix() {
    local base_version="$1"
    local hotfix_version="$2"
    local hotfix_branch="hotfix-$hotfix_version"
    
    echo "Creating hotfix $hotfix_version from release $base_version"
    
    # Create hotfix branch from release tag
    svn copy "$SVN_BASE/tags/v$base_version" "$SVN_BASE/branches/$hotfix_branch" \
        -m "Create hotfix branch $hotfix_version from release $base_version"
    
    # Checkout hotfix branch
    svn checkout "$SVN_BASE/branches/$hotfix_branch" "./$hotfix_branch"
    cd "$hotfix_branch"
    
    echo "Hotfix branch $hotfix_branch ready for fixes"
}