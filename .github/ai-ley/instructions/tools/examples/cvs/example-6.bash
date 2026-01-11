#!/bin/bash
# CVS to Git migration script

# Migration configuration
CVS_MODULE="$1"
GIT_REPO_NAME="${2:-$CVS_MODULE}"
MIGRATION_DIR="/tmp/cvs-migration"

migrate_cvs_to_git() {
    echo "Migrating CVS module '$CVS_MODULE' to Git repository '$GIT_REPO_NAME'"
    
    # Create migration workspace
    mkdir -p "$MIGRATION_DIR"
    cd "$MIGRATION_DIR"
    
    # Install cvs2git if not available
    if ! command -v cvs2git &> /dev/null; then
        echo "Installing cvs2git..."
        # Ubuntu/Debian
        sudo apt-get install cvs2git || \
        # CentOS/RHEL
        sudo yum install cvs2git || \
        # Manual installation
        (
            wget http://cvs2svn.tigris.org/files/documents/1462/49237/cvs2svn-2.5.0.tar.gz
            tar -xzf cvs2svn-2.5.0.tar.gz
            cd cvs2svn-2.5.0
            python setup.py install --user
        )
    fi
    
    # Create cvs2git options file
    cat > cvs2git-options.py << 'EOF'
import os

from cvs2svn_lib import config
from cvs2svn_lib import changeset_database
from cvs2svn_lib.common import CVSTextDecoder
from cvs2svn_lib.log import logger
from cvs2svn_lib.project import Project
from cvs2svn_lib.git_revision_collector import GitRevisionCollector
from cvs2svn_lib.git_output_option import GitRevisionMarkWriter
from cvs2svn_lib.git_output_option import GitOutputOption
from cvs2svn_lib.revision_manager import NullRevisionCollector

# CVS repository path
cvs_repo_path = os.environ.get('CVS_ROOT', '/cvsroot')
module_name = os.environ.get('CVS_MODULE', 'project')

# Git output configuration
git_repo_path = os.path.join('/tmp/cvs-migration', module_name + '.git')

# Basic configuration
ctx.revision_collector = GitRevisionCollector()
ctx.output_option = GitOutputOption(
    git_repo_path,
    GitRevisionMarkWriter(),
    # Add author mapping if needed
    author_transforms={
        'olduser': ('New User', 'newuser@example.com'),
    }
)

# Project configuration
run_options.add_project(
    Project(
        r'%s/%s' % (cvs_repo_path, module_name),
        project_cvs_repos_path=cvs_repo_path,
    ),
)

# File encoding (adjust as needed)
ctx.cvs_author_decoder = CVSTextDecoder(
    'utf-8',
    eol_fix='\n',
)
ctx.cvs_log_decoder = CVSTextDecoder(
    'utf-8',
    eol_fix='\n',
)

# Exclude files (adjust as needed)
ctx.file_key_generator = FileKeyGenerator()
ctx.revision_excluder = RevisionExcluder()
EOF
    
    # Run migration
    echo "Running cvs2git migration..."
    export CVS_ROOT="$CVSROOT"
    export CVS_MODULE="$CVS_MODULE"
    
    cvs2git --options=cvs2git-options.py
    
    # Clone the resulting Git repository
    git clone "$MIGRATION_DIR/$CVS_MODULE.git" "$GIT_REPO_NAME"
    cd "$GIT_REPO_NAME"
    
    # Clean up and optimize Git repository
    git gc --aggressive
    git repack -ad
    
    # Create summary
    cat > MIGRATION_NOTES.md << EOF
# CVS to Git Migration Notes

## Source Information
- CVS Module: $CVS_MODULE
- CVS Root: $CVSROOT
- Migration Date: $(date)

## Migration Statistics
- Total Commits: $(git rev-list --all --count)
- Total Files: $(git ls-tree -r --name-only HEAD | wc -l)
- Repository Size: $(du -sh .git | cut -f1)

## Post-Migration Tasks
- [ ] Verify all important files are present
- [ ] Check commit history and authorship
- [ ] Set up new Git remote repository
- [ ] Update build scripts and documentation
- [ ] Train team on Git workflows

## Notes
- This migration preserves CVS history as Git commits
- Binary files may need verification
- Some CVS-specific features (keywords) may need updating
EOF
    
    echo "Migration completed: $PWD"
    echo "Review MIGRATION_NOTES.md for next steps"
}

# Verify migration integrity
verify_migration() {
    local cvs_module="$1"
    local git_repo="$2"
    
    echo "Verifying migration integrity"
    
    # Export latest CVS version
    mkdir -p /tmp/verify-cvs
    cd /tmp/verify-cvs
    cvs -d "$CVSROOT" export -r HEAD "$cvs_module"
    
    # Compare with Git HEAD
    cd "$git_repo"
    
    # Simple file count comparison
    local cvs_files=$(find "/tmp/verify-cvs/$cvs_module" -type f | wc -l)
    local git_files=$(git ls-tree -r --name-only HEAD | wc -l)
    
    echo "File count - CVS: $cvs_files, Git: $git_files"
    
    if [ "$cvs_files" -eq "$git_files" ]; then
        echo "✓ File counts match"
    else
        echo "⚠ File counts differ - manual verification recommended"
    fi
    
    # List any missing files
    comm -23 <(find "/tmp/verify-cvs/$cvs_module" -type f | sort) <(git ls-tree -r --name-only HEAD | sort)
    
    echo "Verification completed"
}

# Main migration function
main() {
    if [ -z "$1" ]; then
        echo "Usage: $0 <cvs-module> [git-repo-name]"
        echo "Example: $0 legacy-project legacy-project-git"
        exit 1
    fi
    
    migrate_cvs_to_git
    verify_migration "$CVS_MODULE" "$GIT_REPO_NAME"
}

main "$@"