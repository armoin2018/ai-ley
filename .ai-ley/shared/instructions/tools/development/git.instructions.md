---
title: 'Git Version Control System Instructions'
description: 'Comprehensive guide for using Git for version control, collaboration, and code management in software development projects'
category: 'Development Tools'

tags:
  [
    'git',
    'version-control',
    'collaboration',
    'branching',
    'merging',
    'github',
    'gitlab',
    'workflow',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/.git/**'
  - '**/.gitignore'
  - '**/.gitattributes'
  - '**/.gitmodules'
  - '**/git.config'
  - '**/gitconfig'
---

# Git Version Control System Instructions

## Tool Overview

- **Tool Name**: Git
- **Version**: 2.40+ (Latest stable with improved performance and security)
- **Category**: Development Tools - Version Control
- **Purpose**: Distributed version control system for tracking changes, collaboration, and code management
- **Prerequisites**: Command line interface, basic terminal knowledge

## When to Use Git

### ✅ **Use Git When**

- Working on any software development project requiring version tracking
- Collaborating with team members on shared codebases
- Need to maintain history of code changes and ability to revert
- Managing multiple features or experiments simultaneously through branching
- Working with remote repositories and distributed development workflows
- Integrating with CI/CD pipelines and deployment automation
- Need backup and synchronization across multiple development environments
- Contributing to open source projects or maintaining public repositories
- Requiring code review processes and merge request workflows

### ❌ **Consider Alternatives When**

- Working with very large binary files (consider Git LFS or alternative VCS)
- Need centralized workflow with strict access controls (consider Perforce for enterprise)
- Working primarily with non-code assets requiring different versioning approaches
- Team is completely new to version control and needs simpler alternatives initially
- Network connectivity is severely limited and distributed model isn't suitable

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | Git Recommendation                            | Configuration Priority            |
| ---------------------- | --------------------------------------------- | --------------------------------- |
| Software Development   | ✅ **Essential** - Industry standard          | High - Full workflow setup        |
| Open Source Project    | ✅ **Essential** - Required for collaboration | High - Advanced branching + hooks |
| Enterprise Application | ✅ **Essential** - Enterprise features needed | High - Security + compliance      |
| Personal Scripts       | ✅ **Recommended** - Good practice            | Medium - Basic versioning         |
| Documentation Project  | ✅ **Recommended** - Track content changes    | Medium - Simple workflow          |
| Learning/Tutorial Code | ✅ **Recommended** - Version practice         | Low - Basic commands              |

### Complexity Assessment

| Factor                 | Low Complexity     | Medium Complexity      | High Complexity             |
| ---------------------- | ------------------ | ---------------------- | --------------------------- |
| **Setup Time**         | 15 minutes (basic) | 1 hour (team workflow) | 4+ hours (enterprise)       |
| **Team Size**          | 1-2 developers     | 3-10 developers        | 10+ developers              |
| **Branching Strategy** | Single branch      | Feature branches       | GitFlow/advanced strategies |
| **Integration**        | Local only         | GitHub/GitLab          | Enterprise + CI/CD + hooks  |

## Installation & Setup

### Package Manager Installation

```bash
# macOS installation via Homebrew (recommended)
brew install git

# Ubuntu/Debian installation
sudo apt update
sudo apt install git

# CentOS/RHEL/Fedora installation
sudo yum install git
# or for newer versions
sudo dnf install git

# Windows installation via Chocolatey
choco install git

# Windows installation via Scoop
scoop install git

# Verify installation
git --version
which git
```

### Project Integration

```bash
# Initialize new Git repository
git init

# Initialize with specific branch name
git init -b main

# Clone existing repository
git clone https://github.com/username/repository.git
git clone git@github.com:username/repository.git

# Clone specific branch
git clone -b branch-name https://github.com/username/repository.git

# Clone with specific directory name
git clone https://github.com/username/repository.git my-project

# Shallow clone for large repositories
git clone --depth 1 https://github.com/username/repository.git
```

### Global Configuration

```bash
# Set user identity (required for commits)
git config --global user.name "Your Full Name"
git config --global user.email "your.email@example.com"

# Set default branch name
git config --global init.defaultBranch main

# Set default editor
git config --global core.editor "code --wait"  # VS Code
git config --global core.editor "vim"          # Vim
git config --global core.editor "nano"         # Nano

# Configure line endings (important for cross-platform)
git config --global core.autocrlf true    # Windows
git config --global core.autocrlf input   # macOS/Linux

# Set default merge strategy
git config --global pull.rebase false     # Create merge commits
git config --global pull.rebase true      # Rebase on pull
git config --global pull.ff only          # Fast-forward only

# Configure push behavior
git config --global push.default simple
git config --global push.autoSetupRemote true
```

## Configuration

### Local Repository Configuration

```bash
# .gitconfig for repository-specific settings
git config user.name "Project Specific Name"
git config user.email "project@company.com"

# Set upstream tracking
git config branch.main.remote origin
git config branch.main.merge refs/heads/main

# Configure merge tool
git config merge.tool vimdiff
git config merge.tool code     # VS Code as merge tool
```

### .gitignore Configuration

```gitignore
# .gitignore - Comprehensive example

# Operating System Files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE and Editor Files
.vscode/
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
.idea/
*.swp
*.swo
*~

# Dependency directories
node_modules/
vendor/
packages/
.pnp/
.pnp.js

# Build outputs
dist/
build/
out/
target/
bin/
obj/

# Environment and Configuration
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
config.local.json
secrets.yml

# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pids
*.pid
*.seed
*.pid.lock

# Runtime data
.npm
.eslintcache
.stylelintcache

# Coverage directory used by tools like istanbul
coverage/
*.lcov

# Temporary files
tmp/
temp/
.cache/

# Language-specific
*.pyc
__pycache__/
*.gem
*.rbc
/.config
/coverage/
/InstalledFiles
/pkg/
/spec/reports/
/spec/examples.txt
/test/tmp/
/test/version_tmp/
/tmp/

# Framework-specific
.next/
.nuxt/
.vuepress/dist
.serverless/
```

### .gitattributes Configuration

```gitattributes
# .gitattributes - Line ending and merge strategies

# Auto detect text files and perform LF normalization
* text=auto

# Source code
*.js text eol=lf
*.jsx text eol=lf
*.ts text eol=lf
*.tsx text eol=lf
*.css text eol=lf
*.scss text eol=lf
*.json text eol=lf
*.md text eol=lf
*.yml text eol=lf
*.yaml text eol=lf

# Scripts
*.sh text eol=lf
*.bash text eol=lf

# Windows scripts
*.bat text eol=crlf
*.cmd text eol=crlf
*.ps1 text eol=crlf

# Binary files
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.pdf binary
*.zip binary
*.tar.gz binary

# Archives
*.7z binary
*.gz binary
*.rar binary
*.tar binary
*.zip binary

# Fonts
*.woff binary
*.woff2 binary
*.eot binary
*.ttf binary
*.otf binary

# Documentation
*.pdf diff=astextplain

# Custom merge strategies
*.generated merge=ours
package-lock.json merge=ours
yarn.lock merge=ours
```

## Core Features

### Repository Management

- **Purpose**: Initialize, clone, and manage Git repositories
- **Usage**: Essential for starting new projects or contributing to existing ones
- **Example**:

```bash
# Create new repository
mkdir my-project
cd my-project
git init
echo "# My Project" > README.md
git add README.md
git commit -m "Initial commit"

# Add remote repository
git remote add origin https://github.com/username/my-project.git
git push -u origin main
```

### Staging and Committing

- **Purpose**: Track changes and create snapshots of project state
- **Usage**: Fundamental workflow for recording development progress
- **Example**:

```bash
# Stage specific files
git add file1.js file2.css

# Stage all changes
git add .
git add -A

# Interactive staging
git add -i
git add -p  # Patch mode for selective staging

# Commit with message
git commit -m "Add user authentication feature"

# Commit with detailed message
git commit -m "Add user authentication

- Implement login/logout functionality
- Add password hashing with bcrypt
- Create user session management
- Add input validation and error handling"

# Amend last commit
git commit --amend -m "Updated commit message"
git commit --amend --no-edit  # Just add staged changes
```

### Branching and Merging

- **Purpose**: Manage parallel development lines and integrate changes
- **Usage**: Essential for feature development and collaboration
- **Example**:

```bash
# Create and switch to new branch
git checkout -b feature/user-authentication
git switch -c feature/user-authentication  # Modern syntax

# List branches
git branch
git branch -a  # Include remote branches
git branch -r  # Remote branches only

# Switch branches
git checkout main
git switch main  # Modern syntax

# Merge branches
git checkout main
git merge feature/user-authentication

# Merge with no fast-forward (always create merge commit)
git merge --no-ff feature/user-authentication

# Delete branch after merge
git branch -d feature/user-authentication
git push origin --delete feature/user-authentication
```

### Remote Repository Operations

- **Purpose**: Synchronize changes with remote repositories and collaborate
- **Usage**: Essential for team collaboration and backup
- **Example**:

```bash
# Add remote repository
git remote add origin https://github.com/username/repository.git

# List remotes
git remote -v

# Fetch changes without merging
git fetch origin
git fetch --all

# Pull changes (fetch + merge)
git pull origin main
git pull --rebase origin main  # Rebase instead of merge

# Push changes
git push origin main
git push -u origin feature-branch  # Set upstream and push

# Force push (use carefully)
git push --force-with-lease origin main
```

## Common Commands

```bash
# Essential daily commands
git status                        # Check repository status
git add .                         # Stage all changes
git commit -m "message"           # Commit with message
git pull                          # Pull latest changes
git push                          # Push local changes
git log --oneline                 # View commit history

# Branch management
git branch                        # List local branches
git checkout -b branch-name       # Create and switch to branch
git merge branch-name             # Merge branch into current
git branch -d branch-name         # Delete merged branch

# Remote operations
git remote -v                     # List remote repositories
git fetch origin                  # Fetch from remote
git push origin branch-name       # Push branch to remote

# History and information
git log                           # Detailed commit history
git log --graph --oneline         # Visual branch history
git show commit-hash              # Show specific commit details
git diff                          # Show unstaged changes
git diff --staged                 # Show staged changes

# Advanced operations
git stash                         # Temporarily save changes
git stash pop                     # Apply stashed changes
git reset HEAD~1                  # Undo last commit (keep changes)
git reset --hard HEAD~1           # Undo last commit (discard changes)
git revert commit-hash            # Create commit that undoes changes

# Troubleshooting commands
git reflog                        # View reference logs
git fsck                          # Check repository integrity
git gc                            # Garbage collection and optimization
git clean -fd                     # Remove untracked files and directories
```

## Workflow Integration

### Feature Branch Workflow

1. **Setup**: Create feature branch from main development branch
2. **Development**: Make changes, commit regularly with descriptive messages
3. **Testing**: Test changes locally before pushing to remote
4. **Review**: Create pull/merge request for code review
5. **Integration**: Merge approved changes back to main branch

### Team Development Workflow

```bash
# Daily development workflow
git checkout main
git pull origin main                    # Get latest changes
git checkout -b feature/new-feature     # Create feature branch
# ... make changes ...
git add .
git commit -m "Implement new feature"
git push -u origin feature/new-feature  # Push feature branch
# ... create pull request ...
# ... after review and approval ...
git checkout main
git pull origin main                    # Update main
git branch -d feature/new-feature      # Clean up local branch
```

### GitFlow Workflow

```bash
# Initialize GitFlow
git flow init

# Start new feature
git flow feature start new-feature

# Finish feature
git flow feature finish new-feature

# Start release
git flow release start 1.0.0

# Finish release
git flow release finish 1.0.0

# Start hotfix
git flow hotfix start critical-fix

# Finish hotfix
git flow hotfix finish critical-fix
```

### CI/CD Integration

```yaml
# .github/workflows/ci.yml - GitHub Actions example
name: CI/CD Pipeline
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0 # Full history for better Git operations

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci
      - run: npm test
      - run: npm run build

      - name: Create Release
        if: github.ref == 'refs/heads/main'
        run: |
          git config user.name "CI Bot"
          git config user.email "ci@example.com"
          npm version patch
          git push --follow-tags
```

## Best Practices

### ✅ **Configuration Best Practices**

- **Set up global configuration** - Configure user name, email, and core settings globally
- **Use meaningful .gitignore** - Exclude build artifacts, dependencies, and sensitive files
- **Configure line endings** - Set core.autocrlf appropriately for cross-platform development
- **Set up SSH keys** - Use SSH for secure, passwordless authentication with remotes
- **Configure default branch** - Use 'main' as default branch name for new repositories
- **Set up aliases** - Create shortcuts for frequently used commands

### ✅ **Commit Best Practices**

- **Write clear commit messages** - Use imperative mood and explain what and why
- **Make atomic commits** - Each commit should represent a single logical change
- **Commit frequently** - Regular commits create better history and easier debugging
- **Follow conventional commits** - Use consistent format for automated tooling integration
- **Review before committing** - Use git diff and git status to verify changes
- **Test before committing** - Ensure code compiles and tests pass

### ✅ **Branching and Merging**

- **Use feature branches** - Develop features in isolation from main development line
- **Keep branches focused** - One feature or fix per branch for easier review
- **Update branches regularly** - Rebase or merge from main to stay current
- **Delete merged branches** - Clean up old branches to maintain repository hygiene
- **Use pull requests** - Mandatory code review process for quality assurance
- **Protect main branch** - Prevent direct pushes to main in team environments

### ❌ **Common Pitfalls to Avoid**

- **Don't commit secrets** - Use environment variables and .gitignore for sensitive data
- **Avoid large binary files** - Use Git LFS for large assets or find alternatives
- **Don't force push shared branches** - Can corrupt collaborator's work and history
- **Avoid committing generated files** - Build artifacts should be in .gitignore
- **Don't use git add .** blindly - Review what you're staging before committing
- **Avoid unclear commit messages** - "fix", "update", "changes" provide no useful information

## Advanced Git Usage

### Interactive Rebase

```bash
# Interactive rebase for cleaning up commit history
git rebase -i HEAD~3

# Rebase onto another branch
git rebase main feature-branch

# Abort rebase if things go wrong
git rebase --abort

# Continue rebase after resolving conflicts
git rebase --continue

# Example interactive rebase commands:
# pick = use commit
# reword = use commit, but edit the commit message
# edit = use commit, but stop for amending
# squash = use commit, but meld into previous commit
# fixup = like squash, but discard commit message
# drop = remove commit
```

### Advanced Merge Strategies

```bash
# Squash merge (combines all commits into one)
git merge --squash feature-branch
git commit -m "Add complete feature implementation"

# Merge with custom strategy
git merge -X ours feature-branch      # Prefer current branch
git merge -X theirs feature-branch    # Prefer merging branch

# Three-way merge with custom base
git merge-base main feature-branch
git merge --no-commit feature-branch
```

### Stash Management

```bash
# Save current work temporarily
git stash
git stash push -m "Work in progress on authentication"

# Save including untracked files
git stash -u

# List all stashes
git stash list

# Apply specific stash
git stash apply stash@{2}

# Apply and remove stash
git stash pop

# Show stash contents
git stash show stash@{0}
git stash show -p stash@{0}  # Show full diff

# Drop specific stash
git stash drop stash@{1}

# Clear all stashes
git stash clear
```

### Submodules and Subtrees

```bash
# Add submodule
git submodule add https://github.com/user/library.git lib/library

# Initialize submodules after cloning
git submodule init
git submodule update

# Update submodules
git submodule update --remote

# Clone repository with submodules
git clone --recursive https://github.com/user/project.git

# Add subtree (alternative to submodules)
git subtree add --prefix=lib/library https://github.com/user/library.git main --squash

# Update subtree
git subtree pull --prefix=lib/library https://github.com/user/library.git main --squash
```

## Integration with Other Tools

### GitHub Integration

```bash
# GitHub CLI integration
gh repo create my-project --public
gh repo clone username/repository
gh pr create --title "Add new feature" --body "Description"
gh pr list
gh pr checkout 123

# Configure GitHub as remote
git remote add origin git@github.com:username/repository.git
git push -u origin main
```

### IDE Integration

```bash
# VS Code integration
code .  # Open current directory in VS Code

# Configure VS Code as Git editor
git config --global core.editor "code --wait"

# Git integration features in VS Code:
# - Source Control panel
# - Built-in diff viewer
# - GitLens extension for enhanced Git capabilities
# - Git blame annotations
# - Branch switching from status bar
```

### Continuous Integration

```bash
# Jenkins pipeline integration
pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/username/repository.git'
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
    }
}
```

## Troubleshooting

### Common Issues

#### Merge Conflicts

**Problem**: Conflicting changes in the same file sections during merge
**Symptoms**: Git reports merge conflicts and stops the merge process
**Solution**:

```bash
# Check conflict status
git status

# Open conflicted files and resolve manually
# Look for conflict markers: <<<<<<<, =======, >>>>>>>
# Edit file to keep desired changes

# After resolving conflicts
git add resolved-file.js
git commit -m "Resolve merge conflicts"

# Abort merge if needed
git merge --abort

# Use merge tool for visual resolution
git mergetool
```

#### Detached HEAD State

**Problem**: HEAD is not pointing to a branch, commits may be lost
**Symptoms**: Git warns "You are in 'detached HEAD' state"
**Solution**:

```bash
# Create branch from current state
git checkout -b new-branch-name

# Or return to a branch
git checkout main

# If you made commits in detached state
git branch temp-branch commit-hash
git checkout main
git merge temp-branch
```

#### Undoing Changes

**Problem**: Need to undo commits, staging, or file changes
**Symptoms**: Mistakes in commits or unwanted changes
**Solution**:

```bash
# Undo last commit but keep changes
git reset HEAD~1

# Undo last commit and discard changes
git reset --hard HEAD~1

# Undo staging
git reset HEAD file.js

# Discard local changes
git checkout -- file.js
git restore file.js  # Modern syntax

# Revert commit (creates new commit)
git revert commit-hash
```

#### Remote Synchronization Issues

**Problem**: Local and remote repositories are out of sync
**Symptoms**: Push rejected or pull conflicts
**Solution**:

```bash
# Update local repository
git fetch origin

# Check what will be merged
git log HEAD..origin/main

# Pull with rebase to maintain clean history
git pull --rebase origin main

# Force push with safety (only if certain)
git push --force-with-lease origin main

# Reset to match remote exactly
git reset --hard origin/main
```

### Debug Mode

```bash
# Enable Git tracing
GIT_TRACE=1 git command
GIT_TRACE_PACKET=1 git push  # Network operations
GIT_TRACE_PERFORMANCE=1 git command  # Performance analysis

# Verbose output
git --verbose command
git push --verbose
git pull --verbose

# Check repository integrity
git fsck --full
git count-objects -v
```

### Performance Optimization

```bash
# Optimize repository
git gc                # Garbage collection
git gc --aggressive   # More thorough optimization

# Prune remote tracking branches
git remote prune origin

# Shallow clone for large repositories
git clone --depth 1 url

# Partial clone (Git 2.19+)
git clone --filter=blob:none url

# Check repository size
git count-objects -vH
```

## Security Considerations

### Security Best Practices

- **Use SSH keys** - More secure than HTTPS passwords for authentication
- **Enable two-factor authentication** - Additional security layer for Git hosting services
- **Protect sensitive data** - Never commit passwords, API keys, or credentials
- **Sign commits** - Use GPG signing to verify commit authenticity
- **Review permissions** - Regularly audit repository access and collaborator permissions
- **Use branch protection** - Require reviews and status checks before merging

### Sensitive Data Handling

```bash
# Remove sensitive data from history
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch secrets.txt' \
  --prune-empty --tag-name-filter cat -- --all

# Modern alternative using git-filter-repo
git filter-repo --path secrets.txt --invert-paths

# Prevent future accidents
echo "secrets.txt" >> .gitignore
git add .gitignore
git commit -m "Add secrets.txt to gitignore"
```

### GPG Commit Signing

```bash
# Generate GPG key
gpg --full-generate-key

# List GPG keys
gpg --list-secret-keys --keyid-format LONG

# Configure Git to use GPG key
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true

# Sign specific commit
git commit -S -m "Signed commit message"

# Verify signatures
git log --show-signature
```

## AI Assistant Guidelines

When helping with Git:

1. **Always suggest current Git 2.40+** with modern command syntax (switch/restore over checkout)
2. **Provide complete workflow examples** that integrate with team development practices
3. **Include safety measures** like --force-with-lease instead of --force for pushes
4. **Suggest branch protection** and pull request workflows for team environments
5. **Provide troubleshooting steps** for common issues like merge conflicts and sync problems
6. **Include security considerations** for sensitive data and authentication
7. **Reference hosting platform integration** (GitHub, GitLab, Bitbucket) when relevant
8. **Suggest automation opportunities** with hooks, CI/CD, and workflow improvements

### Code Generation Rules

- Generate .gitignore files appropriate for the technology stack and environment
- Include comprehensive .gitattributes for line ending and merge strategy management
- Provide workflow scripts that follow Git best practices and conventions
- Include error handling and safety checks in automation scripts
- Follow conventional commit message formats for automated tooling integration
- Generate branch protection and security configurations for team repositories
- Provide cross-platform compatible commands and configurations
- Include performance optimization settings for large repositories and teams
