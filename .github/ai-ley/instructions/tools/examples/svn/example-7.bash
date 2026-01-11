#!/bin/bash
# SVN large file and binary asset management

# Configure SVN for binary files
setup_binary_handling() {
    echo "Configuring SVN for binary file handling"
    
    # Set global ignores for common binary types
    svn config --global global-ignores "*.exe *.dll *.so *.dylib *.jar *.war *.ear"
    
    # Configure auto-props for binary files
    cat >> ~/.subversion/config << 'EOF'
[auto-props]
*.png = svn:mime-type=image/png
*.jpg = svn:mime-type=image/jpeg
*.jpeg = svn:mime-type=image/jpeg
*.gif = svn:mime-type=image/gif
*.ico = svn:mime-type=image/x-icon
*.pdf = svn:mime-type=application/pdf
*.doc = svn:mime-type=application/msword
*.xls = svn:mime-type=application/vnd.ms-excel
*.zip = svn:mime-type=application/zip
*.tar.gz = svn:mime-type=application/x-gzip
*.exe = svn:mime-type=application/octet-stream
*.dll = svn:mime-type=application/octet-stream
*.so = svn:mime-type=application/octet-stream
EOF
    
    echo "Binary file handling configured"
}

# Add large files with proper handling
add_large_files() {
    local directory="$1"
    
    echo "Adding large files from $directory"
    
    # Find and add large files
    find "$directory" -type f -size +10M | while read file; do
        echo "Adding large file: $file"
        
        # Set binary MIME type
        svn add "$file"
        svn propset svn:mime-type "application/octet-stream" "$file"
        
        # Optionally set keywords to false for binary files
        svn propset svn:keywords "" "$file"
    done
    
    echo "Large files added successfully"
}

# Repository size analysis
analyze_repository_size() {
    echo "Analyzing repository size and large files"
    
    # Get repository size information
    svn info | grep "Repository Size"
    
    # Find largest files in current working copy
    echo "Largest files in working copy:"
    find . -type f -exec ls -la {} \; | sort -k5 -nr | head -20
    
    # Find files with most revisions (potential size issues)
    echo "Files with most revisions:"
    svn log --verbose | grep "^   [AM]" | awk '{print $2}' | sort | uniq -c | sort -nr | head -10
}