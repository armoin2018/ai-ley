#!/bin/bash
# CVS workflow management for legacy projects

set -euo pipefail

# Configuration
PROJECT_MODULE="${CVS_MODULE:-legacy-project}"
WORK_DIR="${HOME}/cvs-work"

# Initialize working directory
init_workspace() {
    log "Initializing CVS workspace"
    
    mkdir -p "$WORK_DIR"
    cd "$WORK_DIR"
    
    # Checkout project module
    cvs checkout "$PROJECT_MODULE"
    cd "$PROJECT_MODULE"
    
    log "Workspace initialized: $WORK_DIR/$PROJECT_MODULE"
}

# Safe update procedure
safe_update() {
    log "Performing safe update of working directory"
    
    # Check for local modifications
    local modified_files=$(cvs status | grep "Status: Locally Modified" | wc -l)
    
    if [ $modified_files -gt 0 ]; then
        log "Warning: $modified_files locally modified files found"
        cvs status | grep "Status: Locally Modified"
        
        read -p "Continue with update? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log "Update cancelled by user"
            return 1
        fi
    fi
    
    # Perform update
    cvs update -d
    
    # Check for conflicts
    local conflicts=$(cvs status | grep "Status: File had conflicts" | wc -l)
    
    if [ $conflicts -gt 0 ]; then
        log "ERROR: $conflicts files have conflicts"
        cvs status | grep "Status: File had conflicts"
        log "Please resolve conflicts before continuing"
        return 1
    fi
    
    log "Update completed successfully"
}

# Commit with validation
safe_commit() {
    local commit_message="$1"
    
    log "Preparing commit: $commit_message"
    
    # Check for added files that need to be added to CVS
    local unknown_files=$(cvs status 2>/dev/null | grep "Status: Unknown" | wc -l)
    
    if [ $unknown_files -gt 0 ]; then
        log "Warning: $unknown_files unknown files found"
        cvs status 2>/dev/null | grep "Status: Unknown"
        
        read -p "Add these files to CVS? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cvs status 2>/dev/null | grep "Status: Unknown" | awk '{print $2}' | xargs cvs add
        fi
    fi
    
    # Check for removed files
    local removed_files=$(cvs status | grep "Status: Entry Invalid" | wc -l)
    
    if [ $removed_files -gt 0 ]; then
        log "Warning: $removed_files removed files found"
        cvs status | grep "Status: Entry Invalid"
        
        read -p "Remove these files from CVS? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cvs status | grep "Status: Entry Invalid" | awk '{print $2}' | xargs cvs remove
        fi
    fi
    
    # Update before commit
    log "Updating before commit..."
    if ! safe_update; then
        log "ERROR: Update failed, commit aborted"
        return 1
    fi
    
    # Perform commit
    cvs commit -m "$commit_message"
    
    log "Commit completed successfully"
}

# Tag management
create_tag() {
    local tag_name="$1"
    local tag_type="${2:-branch}"
    
    log "Creating $tag_type tag: $tag_name"
    
    # Validate tag name
    if [[ ! "$tag_name" =~ ^[a-zA-Z][a-zA-Z0-9_-]*$ ]]; then
        log "ERROR: Invalid tag name. Use alphanumeric characters, underscores, and hyphens only."
        return 1
    fi
    
    # Update to latest
    safe_update
    
    # Create tag
    if [ "$tag_type" = "branch" ]; then
        cvs tag -b "$tag_name"
        log "Branch tag '$tag_name' created"
    else
        cvs tag "$tag_name"
        log "Regular tag '$tag_name' created"
    fi
}

# Binary file handling
add_binary_file() {
    local file_path="$1"
    
    log "Adding binary file: $file_path"
    
    # Add with binary flag
    cvs add -kb "$file_path"
    
    log "Binary file added successfully"
}

# Conflict resolution helper
resolve_conflicts() {
    log "Checking for conflicts in working directory"
    
    # Find files with conflict markers
    local conflict_files=$(grep -r "^<<<<<<< " . --include="*.c" --include="*.h" --include="*.txt" --include="*.java" | cut -d: -f1 | sort -u)
    
    if [ -z "$conflict_files" ]; then
        log "No conflict markers found"
        return 0
    fi
    
    log "Files with conflict markers:"
    echo "$conflict_files"
    
    # Offer to open each file for manual resolution
    echo "$conflict_files" | while read file; do
        echo "Conflict in: $file"
        read -p "Open for editing? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            ${EDITOR:-vi} "$file"
        fi
    done
    
    log "Please verify all conflicts are resolved before committing"
}