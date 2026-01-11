#!/bin/bash
# Comprehensive SVN workflow management script

set -euo pipefail

# Configuration
SVN_BASE_URL="https://svn.example.com/project"
TRUNK_URL="$SVN_BASE_URL/trunk"
BRANCHES_URL="$SVN_BASE_URL/branches"
TAGS_URL="$SVN_BASE_URL/tags"

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# Create feature branch
create_feature_branch() {
    local branch_name="$1"
    local description="${2:-Feature branch for $branch_name}"
    
    log "Creating feature branch: $branch_name"
    
    # Validate branch name
    if [[ ! "$branch_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
        echo "Error: Invalid branch name. Use only alphanumeric characters, underscores, and hyphens."
        exit 1
    fi
    
    # Check if branch already exists
    if svn list "$BRANCHES_URL" | grep -q "^$branch_name/"; then
        echo "Error: Branch '$branch_name' already exists."
        exit 1
    fi
    
    # Create branch from trunk
    svn copy "$TRUNK_URL" "$BRANCHES_URL/$branch_name" \
        -m "Create feature branch: $branch_name - $description"
    
    log "Feature branch '$branch_name' created successfully"
    echo "Checkout command: svn checkout $BRANCHES_URL/$branch_name"
}

# Merge feature branch back to trunk
merge_feature_branch() {
    local branch_name="$1"
    local working_copy="${2:-.}"
    
    log "Merging feature branch '$branch_name' to trunk"
    
    # Ensure we're in a working copy
    if [ ! -d "$working_copy/.svn" ]; then
        echo "Error: Not in an SVN working copy. Please specify the correct path."
        exit 1
    fi
    
    # Switch to trunk if not already there
    local current_url=$(svn info "$working_copy" | grep "^URL:" | cut -d' ' -f2)
    if [[ "$current_url" != "$TRUNK_URL" ]]; then
        log "Switching to trunk..."
        svn switch "$TRUNK_URL" "$working_copy"
    fi
    
    # Update trunk to latest
    log "Updating trunk to latest revision..."
    svn update "$working_copy"
    
    # Perform merge
    log "Merging branch '$branch_name'..."
    svn merge "$BRANCHES_URL/$branch_name" "$working_copy"
    
    # Check for conflicts
    if svn status "$working_copy" | grep -q "^C"; then
        echo "Merge conflicts detected. Please resolve conflicts and run:"
        echo "  svn resolve --accept working $working_copy"
        echo "  svn commit -m 'Merge feature branch: $branch_name'"
        exit 1
    fi
    
    # Commit merge
    svn commit "$working_copy" -m "Merge feature branch: $branch_name"
    
    log "Feature branch '$branch_name' merged successfully"
}

# Create release tag
create_release_tag() {
    local version="$1"
    local source="${2:-trunk}"
    local description="${3:-Release $version}"
    
    log "Creating release tag: $version"
    
    # Validate version format
    if [[ ! "$version" =~ ^v?[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Error: Invalid version format. Use semantic versioning (e.g., v1.2.3)"
        exit 1
    fi
    
    # Ensure version starts with 'v'
    if [[ ! "$version" =~ ^v ]]; then
        version="v$version"
    fi
    
    # Determine source URL
    local source_url
    if [[ "$source" == "trunk" ]]; then
        source_url="$TRUNK_URL"
    else
        source_url="$BRANCHES_URL/$source"
    fi
    
    # Check if tag already exists
    if svn list "$TAGS_URL" | grep -q "^$version/"; then
        echo "Error: Tag '$version' already exists."
        exit 1
    fi
    
    # Create tag
    svn copy "$source_url" "$TAGS_URL/$version" \
        -m "Create release tag: $version - $description"
    
    log "Release tag '$version' created successfully from $source"
}

# Repository maintenance
repository_maintenance() {
    local working_copy="${1:-.}"
    
    log "Performing repository maintenance"
    
    # Update working copy
    log "Updating working copy..."
    svn update "$working_copy"
    
    # Check for uncommitted changes
    local status_output=$(svn status "$working_copy")
    if [[ -n "$status_output" ]]; then
        echo "Uncommitted changes detected:"
        echo "$status_output"
        echo ""
        echo "Please commit or revert changes before maintenance."
        return 1
    fi
    
    # Clean up unversioned files
    log "Cleaning unversioned files..."
    svn status "$working_copy" | grep "^?" | awk '{print $2}' | xargs -r rm -rf
    
    # Check for missing files
    local missing_files=$(svn status "$working_copy" | grep "^!")
    if [[ -n "$missing_files" ]]; then
        echo "Missing files detected:"
        echo "$missing_files"
        echo "Consider running: svn update or svn revert"
    fi
    
    log "Repository maintenance completed"
}

# Branch analysis and cleanup
analyze_branches() {
    log "Analyzing repository branches"
    
    echo "Active branches:"
    svn list "$BRANCHES_URL" | while read branch; do
        if [[ -n "$branch" ]]; then
            branch_name="${branch%/}"
            last_changed=$(svn info "$BRANCHES_URL/$branch_name" | grep "Last Changed Date:" | cut -d' ' -f4-)
            last_author=$(svn info "$BRANCHES_URL/$branch_name" | grep "Last Changed Author:" | cut -d' ' -f4-)
            echo "  $branch_name - Last modified: $last_changed by $last_author"
        fi
    done
    
    echo ""
    echo "Available tags:"
    svn list "$TAGS_URL" | head -10
    
    # Find old branches (older than 6 months)
    echo ""
    echo "Branches older than 6 months:"
    svn list "$BRANCHES_URL" | while read branch; do
        if [[ -n "$branch" ]]; then
            branch_name="${branch%/}"
            last_changed_timestamp=$(svn info "$BRANCHES_URL/$branch_name" | grep "Last Changed Date:" | cut -d' ' -f4- | head -1)
            last_changed_epoch=$(date -d "$last_changed_timestamp" +%s 2>/dev/null || echo "0")
            six_months_ago=$(date -d "6 months ago" +%s)
            
            if [[ "$last_changed_epoch" -lt "$six_months_ago" && "$last_changed_epoch" -gt "0" ]]; then
                echo "  $branch_name - $last_changed_timestamp"
            fi
        fi
    done
}

# Main function dispatcher
main() {
    case "${1:-help}" in
        "create-branch")
            if [[ -z "${2:-}" ]]; then
                echo "Usage: $0 create-branch <branch-name> [description]"
                exit 1
            fi
            create_feature_branch "$2" "${3:-}"
            ;;
        "merge-branch")
            if [[ -z "${2:-}" ]]; then
                echo "Usage: $0 merge-branch <branch-name> [working-copy-path]"
                exit 1
            fi
            merge_feature_branch "$2" "${3:-}"
            ;;
        "create-tag")
            if [[ -z "${2:-}" ]]; then
                echo "Usage: $0 create-tag <version> [source-branch] [description]"
                exit 1
            fi
            create_release_tag "$2" "${3:-trunk}" "${4:-}"
            ;;
        "maintenance")
            repository_maintenance "${2:-}"
            ;;
        "analyze")
            analyze_branches
            ;;
        "help"|*)
            echo "SVN Workflow Management Script"
            echo "Usage: $0 {create-branch|merge-branch|create-tag|maintenance|analyze}"
            echo ""
            echo "Commands:"
            echo "  create-branch <name> [desc]  - Create feature branch"
            echo "  merge-branch <name> [path]   - Merge feature branch to trunk"
            echo "  create-tag <version> [src]   - Create release tag"
            echo "  maintenance [path]           - Perform repository maintenance"
            echo "  analyze                      - Analyze branches and tags"
            ;;
    esac
}

main "$@"