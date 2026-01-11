# .dockerignore - Optimize build context
# Version control
.git
.gitignore
.gitattributes

# Dependencies
node_modules
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Build artifacts
.next
dist
build
out

# Development files
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE and editor files
.vscode
.idea
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db

# Documentation
README.md
docs/
*.md

# Testing
coverage/
.nyc_output
.jest-cache

# Logs
logs
*.log

# Docker files (avoid recursive copying)
Dockerfile*
docker-compose*.yml
.dockerignore

# CI/CD
.github/
.gitlab-ci.yml
.travis.yml

# Temporary files
tmp/
temp/
*.tmp
*.temp

# Large files that shouldn't be in containers
*.zip
*.tar.gz
*.sql
*.dump