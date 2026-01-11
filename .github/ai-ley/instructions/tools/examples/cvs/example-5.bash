#!/bin/bash
# Legacy CVS project maintenance workflow

# Daily maintenance routine
daily_maintenance() {
    echo "Starting daily CVS maintenance for legacy projects"
    
    # Update working copies
    for project in legacy-app old-system vintage-tool; do
        if [ -d "$HOME/cvs-work/$project" ]; then
            echo "Updating $project..."
            cd "$HOME/cvs-work/$project"
            cvs update -d
            
            # Check for any issues
            cvs status | grep -E "(Status: File had conflicts|Status: Unknown)" || true
        fi
    done
    
    # Generate status report
    cat > "$HOME/cvs-daily-report.txt" << EOF
CVS Daily Maintenance Report
Date: $(date)

Projects Updated:
- legacy-app
- old-system  
- vintage-tool

Status: $([ $? -eq 0 ] && echo "Success" || echo "Issues found")
EOF
    
    echo "Daily maintenance completed"
}

# Emergency bug fix workflow
emergency_bugfix() {
    local project="$1"
    local bug_description="$2"
    local tag_name="bugfix-$(date +%Y%m%d)-$$"
    
    echo "Creating emergency bugfix for $project: $bug_description"
    
    # Create working directory
    cd "$HOME/cvs-work"
    
    # Checkout if not exists
    if [ ! -d "$project" ]; then
        cvs checkout "$project"
    fi
    
    cd "$project"
    
    # Update to latest
    cvs update -d
    
    # Create branch for bugfix
    cvs tag -b "$tag_name"
    cvs update -r "$tag_name"
    
    echo "Bugfix branch '$tag_name' created"
    echo "Make your changes and commit with: cvs commit -m 'Emergency bugfix: $bug_description'"
    echo "To merge back: cvs update -A && cvs update -j $tag_name"
}

# Archive old releases
archive_release() {
    local project="$1"
    local release_tag="$2"
    local archive_dir="/archive/cvs-releases"
    
    echo "Archiving release $release_tag of $project"
    
    mkdir -p "$archive_dir/$project"
    
    # Export specific release
    cd "$archive_dir/$project"
    cvs -d "$CVSROOT" export -r "$release_tag" "$project"
    
    # Create archive
    tar -czf "${project}_${release_tag}_$(date +%Y%m%d).tar.gz" "$project"
    rm -rf "$project"
    
    echo "Release archived: $archive_dir/$project/${project}_${release_tag}_$(date +%Y%m%d).tar.gz"
}