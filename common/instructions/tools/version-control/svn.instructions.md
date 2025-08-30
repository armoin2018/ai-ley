`
---
applyTo: "svn, subversion, version-control, **/.svn, **/svnignore"
---

# Subversion (SVN) Version Control Instructions

## Overview
- **Domain**: Centralized Version Control System for Legacy and Enterprise Environments
- **Purpose**: Manage source code versioning, branching, and collaboration in centralized repository systems
- **Applicable To**: Legacy systems, enterprise environments, projects requiring centralized control
- **Integration Level**: Development workflows, CI/CD pipelines, and team collaboration

## Core Principles

### Fundamental Concepts
1. **Centralized Repository Model**: Single source of truth with centralized server architecture
2. **Copy-Modify-Merge Workflow**: Traditional versioning approach with conflict resolution
3. **Directory-Based Versioning**: Entire directory trees are versioned, not just individual files
4. **Atomic Commits**: All changes in a commit succeed or fail together

### Key Benefits
- Simple centralized workflow with clear authority structure
- Excellent handling of binary files and large repositories
- Fine-grained access control and security permissions
- Mature tooling ecosystem with GUI and IDE integration
- Reliable branching and tagging for release management

### Common Misconceptions
- **Myth**: SVN is obsolete and should be replaced with Git everywhere
  **Reality**: SVN remains valuable for certain enterprise environments and legacy system maintenance
- **Myth**: SVN branching is difficult and expensive
  **Reality**: Modern SVN handles branching efficiently with copy-on-write semantics

## Implementation Framework

### Getting Started
#### Prerequisites
- SVN client software (command-line or GUI tools like TortoiseSVN)
- Access to SVN server repository
- Basic understanding of centralized version control concepts

#### Initial Setup
```bash
# Install SVN client (Ubuntu/Debian)
sudo apt-get install subversion

# Install SVN client (macOS with Homebrew)
brew install subversion

# Install SVN client (Windows)
# Download TortoiseSVN from https://tortoisesvn.net/

# Verify installation
svn --version

# Configure user settings
svn config --editor-cmd "code --wait"
svn config set global-ignores "*.log *.tmp .DS_Store"
```

### Core Methodologies
#### Repository Structure and Organization
- **Purpose**: Establish consistent repository layout for effective project management
- **When to Use**: Setting up new repositories or reorganizing existing projects
- **Implementation Steps**:
  1. Design standard repository structure (trunk/branches/tags)
  2. Set up access controls and user permissions
  3. Configure hook scripts for validation and automation
  4. Implement branching and merging strategies
- **Success Metrics**: Organized codebase with clear branching strategy and team adoption

#### Migration and Integration Strategy
- **Purpose**: Migrate from SVN to modern VCS or integrate SVN with existing workflows
- **When to Use**: Modernizing legacy systems or maintaining hybrid environments
- **Implementation Steps**:
  1. Analyze existing SVN history and structure
  2. Plan migration strategy preserving history
  3. Set up bridge tools for Git-SVN integration
  4. Train team on new workflows and tools
- **Success Metrics**: Successful migration with preserved history and minimal disruption

### Process Integration
#### Standard Repository Layout
```
project-repository/
├── trunk/                    # Main development line
│   ├── src/                 # Source code
│   ├── docs/                # Documentation
│   ├── tests/               # Test files
│   ├── build/               # Build scripts
│   └── config/              # Configuration files
├── branches/                # Feature and maintenance branches
│   ├── feature-auth/        # Feature branch example
│   ├── bugfix-login/        # Bug fix branch example
│   └── release-2.1/         # Release branch example
├── tags/                    # Release tags
│   ├── v1.0.0/             # Version 1.0.0 release
│   ├── v1.1.0/             # Version 1.1.0 release
│   └── v2.0.0/             # Version 2.0.0 release
└── vendor/                  # Third-party dependencies (optional)
    └── libs/
```

#### Jenkins CI/CD Integration
```groovy
// Jenkinsfile for SVN projects
pipeline {
    agent any
    
    environment {
        SVN_CREDENTIALS = credentials('svn-credentials')
        BUILD_VERSION = "${env.BUILD_NUMBER}"
    }
    
    options {
        skipDefaultCheckout true
    }
    
    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout from SVN
                    checkout([
                        $class: 'SubversionSCM',
                        locations: [[
                            credentialsId: 'svn-credentials',
                            depthOption: 'infinity',
                            ignoreExternalsOption: true,
                            local: '.',
                            remote: 'https://svn.example.com/project/trunk'
                        ]],
                        quietOperation: true,
                        workspaceUpdater: [$class: 'UpdateUpdater']
                    ])
                    
                    // Get SVN revision
                    env.SVN_REVISION = sh(
                        script: 'svn info --show-item revision',
                        returnStdout: true
                    ).trim()
                }
            }
        }
        
        stage('Build') {
            steps {
                sh '''
                    echo "Building revision ${SVN_REVISION}"
                    # Add build commands here
                    make clean
                    make all
                '''
            }
        }
        
        stage('Test') {
            steps {
                sh '''
                    # Run tests
                    make test
                    
                    # Generate test reports
                    ./run-tests.sh --output-format=junit
                '''
            }
            post {
                always {
                    junit 'test-results.xml'
                }
            }
        }
        
        stage('Deploy') {
            when {
                branch 'trunk'
            }
            steps {
                sh '''
                    # Deploy to staging
                    ./deploy.sh staging
                '''
            }
        }
        
        stage('Tag Release') {
            when {
                allOf {
                    branch 'trunk'
                    expression { return params.CREATE_TAG == true }
                }
            }
            steps {
                script {
                    def tagName = "v${BUILD_VERSION}"
                    sh """
                        svn copy https://svn.example.com/project/trunk \\
                                https://svn.example.com/project/tags/${tagName} \\
                                -m "Release ${tagName} - Build ${BUILD_NUMBER}"
                    """
                }
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'build/**', allowEmptyArchive: true
            cleanWs()
        }
    }
}
```

## Best Practices

### Advanced SVN Workflow Management
```bash
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
```

### Git-SVN Bridge Integration
```bash
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
```

## Common Patterns and Examples

### Pattern 1: Enterprise Release Management
**Scenario**: Manage software releases with proper branching and tagging strategy
**Implementation**:
```bash
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
```
**Expected Outcomes**: Organized release process with proper version control and change tracking

### Pattern 2: Large Binary Asset Management
**Scenario**: Manage large binary files and assets in SVN repository
**Implementation**:
```bash
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
```
**Expected Outcomes**: Efficient handling of large binary assets with proper configuration and monitoring

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Frequent Trunk Commits Without Branches
- **Description**: Committing incomplete features directly to trunk without using feature branches
- **Why It's Problematic**: Breaks trunk stability and makes rollbacks difficult
- **Better Approach**: Use feature branches for development and merge only completed, tested features

#### Anti-Pattern 2: Not Using Atomic Commits
- **Description**: Making multiple unrelated changes in a single commit
- **Why It's Problematic**: Makes code review difficult and complicates rollbacks
- **Better Approach**: Group related changes together and use descriptive commit messages

## Tools and Resources

### Essential SVN Commands and Operations
```bash
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
```

### GUI Tools and IDE Integration
```bash
# Popular SVN GUI tools
# TortoiseSVN (Windows) - https://tortoisesvn.net/
# SmartSVN (Cross-platform) - https://www.smartsvn.com/
# RabbitVCS (Linux) - http://rabbitvcs.org/
# Cornerstone (macOS) - https://cornerstone.assembla.com/

# IDE integrations
# IntelliJ IDEA - Built-in SVN support
# Visual Studio Code - SVN extension
# Eclipse - Subversive or Subclipse plugins
# NetBeans - Built-in SVN support
```

### Learning Resources
- **SVN Red Book**: https://svnbook.red-bean.com/
- **Apache Subversion**: https://subversion.apache.org/
- **TortoiseSVN Documentation**: https://tortoisesvn.net/docs/
- **Git-SVN Guide**: https://git-scm.com/docs/git-svn

## Quality and Compliance

### Quality Standards
- Consistent repository structure with trunk/branches/tags layout
- Descriptive commit messages with proper formatting
- Regular repository maintenance and cleanup procedures
- Proper handling of binary files and large assets
- Atomic commits with related changes grouped together

### Security Standards
- Access control configuration with proper user permissions
- Repository authentication and authorization
- Hook scripts for validation and security checks
- Regular backup and disaster recovery procedures
- Audit trails for repository access and changes

### Performance Standards
- Efficient repository organization to minimize checkout times
- Proper handling of large files and binary assets
- Regular repository maintenance and optimization
- Network-efficient operations with sparse checkouts when appropriate

## AI Assistant Guidelines

When helping with SVN (Subversion):

1. **Legacy Awareness**: Understand that SVN is often used in enterprise environments with specific constraints
2. **Migration Strategy**: Provide guidance for migrating to modern VCS while respecting organizational requirements
3. **Workflow Optimization**: Design workflows that work within SVN's centralized model limitations
4. **Integration Focus**: Support integration with existing enterprise tools and processes
5. **Binary Handling**: Emphasize proper configuration for binary files and large assets
6. **Branch Strategy**: Implement appropriate branching strategies for centralized development
7. **Tool Integration**: Leverage GUI tools and IDE integrations for better user experience
8. **Maintenance Planning**: Include regular repository maintenance and optimization procedures

### Decision Making Framework
When helping teams with SVN:

1. **Environment Assessment**: Understand why SVN is being used and organizational constraints
2. **Migration Planning**: Evaluate opportunities for modernizing version control systems
3. **Workflow Design**: Optimize workflows within SVN's centralized model
4. **Tool Integration**: Plan for GUI tools and IDE integration to improve developer experience
5. **Performance Optimization**: Design repository structure and processes for optimal performance

### Code Generation Rules
- Generate SVN-appropriate workflow scripts and automation
- Include proper error handling and validation for SVN operations
- Use SVN best practices for repository organization and branching
- Implement comprehensive logging and audit trails
- Generate migration scripts and Git-SVN bridge configurations when appropriate
- Include GUI tool configurations and IDE integration guidance
- Provide clear documentation for enterprise environments
- Include repository maintenance and optimization procedures

### Quality Enforcement
- ✅ Enforce proper repository structure with trunk/branches/tags layout
- ✅ Require descriptive commit messages with standardized format
- ✅ Block commits that violate repository organization standards
- ✅ Enforce atomic commits with related changes grouped together
- ✅ Require proper binary file handling and MIME type configuration
- ✅ Enforce access controls and security permissions
- ✅ Promote regular repository maintenance and cleanup procedures
- ✅ Require backup and disaster recovery procedures for repositories