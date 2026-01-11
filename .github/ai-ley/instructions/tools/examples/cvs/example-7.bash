# Basic operations
cvs checkout module                    # Check out module
cvs update [file]                     # Update working copy
cvs commit [file] -m "message"        # Commit changes
cvs add file                          # Add new file
cvs remove file                       # Remove file
cvs status [file]                     # Show file status
cvs log [file]                        # Show change history

# Tagging and branching
cvs tag tagname [file]                # Create tag
cvs tag -b branchname [file]          # Create branch
cvs update -r tagname                 # Switch to tag/branch
cvs update -A                         # Switch to trunk (head)

# Advanced operations
cvs diff [file]                       # Show differences
cvs annotate file                     # Show line-by-line history
cvs export -r tag module              # Export without CVS directories
cvs import module vendor release      # Import new module

# Administrative commands
cvs admin -l file                     # Lock file
cvs admin -u file                     # Unlock file
cvs history                           # Show access history