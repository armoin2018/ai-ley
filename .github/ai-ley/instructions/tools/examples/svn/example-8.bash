# Repository operations
svn checkout URL [PATH]              # Check out working copy
svn update [PATH]                    # Update working copy
svn commit [PATH] -m "message"       # Commit changes
svn status [PATH]                    # Show working copy status
svn log [PATH]                       # Show commit history
svn info [PATH]                      # Show repository information

# File operations
svn add FILE                         # Add file to version control
svn delete FILE                      # Remove file from version control
svn move OLD NEW                     # Rename/move file
svn copy SOURCE DEST                 # Copy file or directory
svn revert [PATH]                    # Revert changes

# Branch and merge operations
svn copy trunk branches/feature      # Create branch
svn switch URL [PATH]                # Switch working copy to different branch
svn merge SOURCE [PATH]              # Merge changes
svn merge -r REV1:REV2 URL [PATH]   # Merge specific revisions

# Property operations
svn propset PROPNAME PROPVAL [PATH]  # Set property
svn propget PROPNAME [PATH]          # Get property value
svn proplist [PATH]                  # List properties
svn propdel PROPNAME [PATH]          # Delete property