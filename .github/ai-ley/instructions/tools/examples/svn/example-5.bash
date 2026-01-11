#!/bin/bash
# Git-SVN bridge for hybrid development environments

# Initialize git-svn repository
setup_git_svn() {
    local svn_url="$1"
    local local_dir="$2"
    
    echo "Setting up Git-SVN bridge for $svn_url"
    
    # Clone SVN repository with Git
    git svn clone "$svn_url" "$local_dir" \
        --trunk=trunk \
        --branches=branches \
        --tags=tags \
        --prefix=origin/
    
    cd "$local_dir"
    
    # Configure Git settings for SVN integration
    git config svn.authorsfile ../authors.txt
    git config svn.rmdir true
    
    echo "Git-SVN repository setup completed"
}

# Sync with SVN repository
sync_with_svn() {
    echo "Syncing with SVN repository..."
    
    # Fetch latest changes from SVN
    git svn fetch
    
    # Rebase current branch onto SVN trunk
    git svn rebase
    
    echo "Sync completed"
}

# Push changes to SVN
push_to_svn() {
    local commit_message="$1"
    
    echo "Pushing changes to SVN..."
    
    # Ensure we're up to date
    git svn rebase
    
    # Push to SVN
    git svn dcommit
    
    echo "Changes pushed to SVN"
}

# Create authors file for Git-SVN
create_authors_file() {
    cat > authors.txt << 'EOF'
# SVN username = Git Author Name <email@domain.com>
johndoe = John Doe <john.doe@company.com>
janedoe = Jane Doe <jane.doe@company.com>
admin = System Admin <admin@company.com>
EOF
    
    echo "Authors file created: authors.txt"
    echo "Please update with your actual SVN usernames and Git author information"
}