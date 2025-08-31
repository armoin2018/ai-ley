# Git Version Control Instructions

## Tool Overview
- **Tool Name**: Git
- **Version**: 2.30+
- **Type**: Distributed Version Control System
- **Language**: Command Line Interface
- **Use Cases**: Source code management, collaboration, version tracking, branching strategies

## Installation & Setup
```bash
# macOS (using Homebrew)
brew install git

# Ubuntu/Debian
sudo apt update && sudo apt install git

# Windows (using Chocolatey)
choco install git

# Verify installation
git --version

# Global configuration
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"  # VS Code as editor
```

## Project Structure
```
.git/                   # Git repository data
├── hooks/              # Git hooks
├── objects/            # Git objects
├── refs/               # References
└── config              # Local configuration

# Git configuration files
.gitignore              # Files to ignore
.gitattributes          # Path-specific settings
.gitmessage             # Commit message template
```

## Core Concepts
### Repository Initialization
- **Purpose**: Create new Git repository or clone existing one
- **Usage**: Start version control for a project
- **Example**:
```bash
# Initialize new repository
git init
git init --bare  # Bare repository for server

# Clone existing repository
git clone https://github.com/user/repo.git
git clone git@github.com:user/repo.git  # SSH
git clone --depth 1 https://github.com/user/repo.git  # Shallow clone

# Clone specific branch
git clone -b feature-branch https://github.com/user/repo.git

# Clone to specific directory
git clone https://github.com/user/repo.git my-project
```

### Basic Operations
- **Purpose**: Track changes and manage repository state
- **Usage**: Daily Git workflow operations
- **Example**:
```bash
# Check repository status
git status
git status --short  # Abbreviated output

# Add files to staging area
git add file.txt              # Add specific file
git add .                     # Add all files in current directory
git add *.js                  # Add all JavaScript files
git add -A                    # Add all changes (including deletions)
git add -p                    # Interactive staging

# Commit changes
git commit -m "Add new feature"
git commit -am "Update existing feature"  # Add and commit
git commit --amend -m "Updated commit message"  # Amend last commit

# View commit history
git log
git log --oneline            # Compact view
git log --graph              # Show branch graph
git log --author="John"      # Filter by author
git log --since="2 weeks ago"  # Filter by date
git log file.txt             # History of specific file

# Show differences
git diff                     # Working directory vs staging
git diff --staged            # Staging vs last commit
git diff HEAD~1              # Compare with previous commit
git diff branch1..branch2    # Compare branches
```

### Branching and Merging
- **Purpose**: Manage parallel development and feature integration
- **Usage**: Implement Git Flow or other branching strategies
- **Example**:
```bash
# List branches
git branch                   # Local branches
git branch -r                # Remote branches
git branch -a                # All branches

# Create and switch branches
git branch feature-login     # Create branch
git checkout feature-login   # Switch to branch
git checkout -b feature-user # Create and switch
git switch feature-login     # Modern way to switch
git switch -c feature-new    # Create and switch (new syntax)

# Merge branches
git checkout main
git merge feature-login      # Merge feature into main
git merge --no-ff feature-login  # Create merge commit
git merge --squash feature-login # Squash merge

# Rebase branches
git rebase main              # Rebase current branch onto main
git rebase -i HEAD~3         # Interactive rebase last 3 commits
git rebase --abort           # Abort ongoing rebase
git rebase --continue        # Continue after resolving conflicts

# Delete branches
git branch -d feature-login  # Delete merged branch
git branch -D feature-login  # Force delete branch
git push origin --delete feature-login  # Delete remote branch
```

### Remote Operations
- **Purpose**: Synchronize with remote repositories
- **Usage**: Collaborate with team members
- **Example**:
```bash
# Manage remotes
git remote -v                # List remotes
git remote add origin https://github.com/user/repo.git
git remote remove origin     # Remove remote
git remote rename origin upstream  # Rename remote

# Fetch and pull
git fetch origin             # Download objects from remote
git fetch --all              # Fetch from all remotes
git pull origin main         # Fetch and merge
git pull --rebase origin main  # Fetch and rebase

# Push changes
git push origin main         # Push to remote branch
git push -u origin feature   # Push and set upstream
git push --force-with-lease  # Safer force push
git push --tags              # Push tags

# Track remote branches
git checkout -b local-branch origin/remote-branch
git branch --set-upstream-to=origin/main main
```

## Development Workflow
1. **Setup**: Initialize repository and configure remotes
2. **Development**: Create feature branches and make commits
3. **Collaboration**: Push/pull changes and merge branches
4. **Release**: Tag versions and maintain release branches

## Best Practices
### Commit Messages
- Use imperative mood ("Add feature" not "Added feature")
- Keep first line under 50 characters
- Provide detailed description when needed
- Reference issue numbers when applicable

### Branching Strategy
- Use descriptive branch names (feature/user-authentication)
- Keep feature branches short-lived
- Regularly sync with main branch
- Use pull requests for code review

### Repository Management
- Keep commits atomic and focused
- Use .gitignore to exclude unnecessary files
- Tag important releases
- Maintain clean commit history

## Common Patterns
### Git Flow Workflow
```bash
# Start new feature
git checkout develop
git checkout -b feature/new-feature

# Work on feature
git add .
git commit -m "Implement new feature"

# Finish feature
git checkout develop
git merge --no-ff feature/new-feature
git branch -d feature/new-feature

# Create release
git checkout -b release/1.0.0 develop
# Make release preparations
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Version 1.0.0"
git checkout develop
git merge --no-ff release/1.0.0
```

### Hotfix Workflow
```bash
# Create hotfix from main
git checkout main
git checkout -b hotfix/critical-bug

# Fix the bug
git add .
git commit -m "Fix critical security issue"

# Merge to main and develop
git checkout main
git merge --no-ff hotfix/critical-bug
git tag -a v1.0.1 -m "Hotfix 1.0.1"

git checkout develop
git merge --no-ff hotfix/critical-bug
git branch -d hotfix/critical-bug
```

### Cherry-pick Pattern
```bash
# Apply specific commit to current branch
git cherry-pick abc123
git cherry-pick --no-commit abc123  # Don't auto-commit
git cherry-pick -x abc123           # Add cherry-pick note

# Cherry-pick range of commits
git cherry-pick abc123..def456
```

## Configuration
### Global Git Configuration
```bash
# User information
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Editor and merge tool
git config --global core.editor "code --wait"
git config --global merge.tool vimdiff

# Aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.up 'pull --rebase'
git config --global alias.lg 'log --oneline --graph --decorate'

# Default behaviors
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.default simple
```

### .gitignore Examples
```gitignore
# Dependencies
node_modules/
vendor/

# Build outputs
dist/
build/
*.min.js
*.min.css

# Environment files
.env
.env.local
.env.production

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary files
tmp/
temp/
*.tmp
```

### Git Hooks Example
```bash
#!/bin/sh
# .git/hooks/pre-commit
# Run tests before commit

echo "Running tests..."
npm test

if [ $? -ne 0 ]; then
    echo "Tests failed. Commit aborted."
    exit 1
fi

echo "All tests passed. Proceeding with commit."
exit 0
```

## Essential Commands
```bash
# Repository setup
git init                     # Initialize repository
git clone <url>              # Clone repository

# Basic operations
git status                   # Check status
git add <file>               # Stage changes
git commit -m "message"      # Commit changes
git push                     # Push to remote
git pull                     # Pull from remote

# Branching
git branch                   # List branches
git checkout <branch>        # Switch branch
git merge <branch>           # Merge branch

# History and information
git log                      # View commit history
git show <commit>            # Show commit details
git diff                     # Show differences

# Undoing changes
git reset --hard HEAD        # Reset to last commit
git revert <commit>          # Revert specific commit
git checkout -- <file>      # Discard changes to file
```

## Common Issues & Solutions
### Merge Conflicts
**Problem**: Conflicts when merging branches
**Solution**: Resolve conflicts manually and commit
```bash
# After conflict occurs
git status                   # See conflicted files
# Edit files to resolve conflicts
git add <resolved-files>
git commit                   # Complete merge
```

### Accidental Commits
**Problem**: Committed wrong changes
**Solution**: Use reset or revert
```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Revert commit (safe for shared history)
git revert HEAD
```

### Lost Commits
**Problem**: Accidentally lost commits
**Solution**: Use reflog to recover
```bash
git reflog                   # Show reference log
git reset --hard HEAD@{2}   # Reset to specific reflog entry
```

## Performance Optimization
### Large Repositories
```bash
# Shallow clone for large repos
git clone --depth 1 <url>

# Partial clone (Git 2.19+)
git clone --filter=blob:none <url>

# Clean up repository
git gc --aggressive          # Garbage collection
git prune                    # Remove unreachable objects
```

### Submodules for Large Projects
```bash
# Add submodule
git submodule add https://github.com/user/repo.git path/to/submodule

# Clone with submodules
git clone --recursive <url>

# Update submodules
git submodule update --init --recursive
```

## Security Considerations
- Use SSH keys for authentication when possible
- Sign commits with GPG for verification
- Review .gitignore to prevent sensitive data commits
- Use branch protection rules in hosting platforms

## Useful Resources
- **Official Documentation**: https://git-scm.com/doc
- **Pro Git Book**: https://git-scm.com/book
- **Git Cheat Sheet**: https://education.github.com/git-cheat-sheet-education.pdf
- **Interactive Tutorial**: https://learngitbranching.js.org/

## Tool-Specific Guidelines
### Commit Guidelines
- Make atomic commits (one logical change per commit)
- Write descriptive commit messages
- Use present tense ("Add feature" not "Added feature")
- Reference issues in commit messages (#123)

### Branch Naming
- Use descriptive names (feature/user-auth, bugfix/login-error)
- Use consistent prefixes (feature/, bugfix/, hotfix/)
- Keep names lowercase with hyphens
- Avoid special characters

## Integration Points
### CI/CD Integration
- **Purpose**: Automated testing and deployment
- **Setup**: Configure webhooks and build triggers
- **Usage**: Trigger builds on push/merge events

### Code Review Process
- **Purpose**: Maintain code quality through peer review
- **Setup**: Use pull/merge requests
- **Usage**: Review changes before merging to main branch

## Version Compatibility
- **Git**: 2.20+ (2.30+ recommended)
- **Platform Support**: Windows, macOS, Linux
- **GUI Tools**: GitKraken, SourceTree, GitHub Desktop

## Troubleshooting
### Debug Mode
```bash
# Verbose output
git --verbose <command>

# Debug information
GIT_TRACE=1 git <command>
GIT_TRACE_PACKET=1 git <command>

# Configuration debugging
git config --list --show-origin
```

### Common Error Messages
- **Error**: `fatal: not a git repository`
  **Cause**: Not in a Git repository
  **Solution**: Run `git init` or navigate to repository root

- **Error**: `Your branch is ahead of 'origin/main' by N commits`
  **Cause**: Local commits not pushed to remote
  **Solution**: Run `git push` to sync with remote

- **Error**: `Please commit your changes or stash them before you merge`
  **Cause**: Uncommitted changes preventing merge
  **Solution**: Commit changes or use `git stash`