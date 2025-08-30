
# npm Package Manager Instructions

## Tool Overview
- **Tool Name**: npm (Node Package Manager)
- **Version**: 9.0+ (Node.js 18+), npm 10.0+ (Node.js 20+)
- **Category**: Package Management
- **Purpose**: Manage JavaScript/Node.js dependencies, scripts, and package publishing
- **Prerequisites**: Node.js 16.0+ (includes npm), internet connection for registry access

## Installation & Setup
### Node.js and npm Installation
```bash
# macOS (using Homebrew)
brew install node

# Windows (using Chocolatey)
choco install nodejs

# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Using Node Version Manager (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts
nvm use --lts

# Verify installation
node --version
npm --version
```

### Project Integration
```bash
# Initialize new project
npm init                    # Interactive setup
npm init -y                 # Use defaults
npm init @scope/template    # Use template

# Create project structure
mkdir my-project
cd my-project
npm init -y
```

## Configuration

### package.json Configuration
```json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "description": "A sample Node.js project",
  "main": "src/index.js",
  "type": "module",
  "engines": {
    "node": ">=18.0.0",
    "npm": ">=9.0.0"
  },
  "scripts": {
    "start": "node src/index.js",
    "dev": "nodemon src/index.js",
    "build": "tsc",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src --ext .js,.ts,.tsx",
    "lint:fix": "eslint src --ext .js,.ts,.tsx --fix",
    "format": "prettier --write src/**/*.{js,ts,tsx,json,md}",
    "clean": "rm -rf dist node_modules",
    "prepare": "husky install",
    "prepublishOnly": "npm run build && npm run test"
  },
  "keywords": ["node", "javascript", "api"],
  "author": "Your Name <your.email@example.com>",
  "license": "MIT",
  "dependencies": {
    "express": "^4.18.2",
    "dotenv": "^16.3.1"
  },
  "devDependencies": {
    "@types/node": "^20.5.0",
    "typescript": "^5.1.6",
    "nodemon": "^3.0.1",
    "jest": "^29.6.2",
    "eslint": "^8.47.0",
    "prettier": "^3.0.2",
    "husky": "^8.0.3"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/username/my-awesome-project.git"
  },
  "bugs": {
    "url": "https://github.com/username/my-awesome-project/issues"
  },
  "homepage": "https://github.com/username/my-awesome-project#readme"
}
```

### .npmrc Configuration
```ini
# Global configuration (~/.npmrc)
registry=https://registry.npmjs.org/
save-exact=true
package-lock=true
audit-level=moderate
fund=false
progress=true

# Organization scoped registry
@myorg:registry=https://npm.myorg.com/

# Authentication token (use npm login instead)
# //registry.npmjs.org/:_authToken=npm_token_here

# Project-specific configuration (project/.npmrc)
engine-strict=true
save-prefix=^
legacy-peer-deps=false
```

### Environment Variables
```bash
# npm configuration via environment variables
export NPM_CONFIG_REGISTRY=https://registry.npmjs.org/
export NPM_CONFIG_CACHE=/path/to/cache
export NPM_CONFIG_PREFIX=/usr/local
export NPM_TOKEN=your_auth_token

# Node.js environment
export NODE_ENV=development
export NODE_OPTIONS="--max-old-space-size=4096"
```

## Core Features

### Package Installation
- **Purpose**: Install and manage project dependencies
- **Usage**: Add libraries and tools to your project
- **Example**:
```bash
# Install production dependencies
npm install express
npm install express@4.18.2          # Specific version
npm install express@^4.18.0         # Compatible version
npm install express@latest          # Latest version

# Install development dependencies
npm install --save-dev jest
npm install -D typescript eslint    # Short form

# Install globally
npm install -g nodemon
npm install --global @vue/cli

# Install from different sources
npm install lodash                   # npm registry
npm install github:lodash/lodash    # GitHub
npm install git+https://github.com/user/repo.git  # Git URL
npm install https://registry.com/package.tgz      # Tarball URL
npm install file:../local-package   # Local file system

# Install all dependencies
npm install                          # Install from package.json
npm ci                              # Clean install (CI/CD)
```

### Package Management
- **Purpose**: Manage installed packages and dependencies
- **Usage**: Update, remove, and audit packages
- **Example**:
```bash
# List installed packages
npm list                    # Current project
npm list --depth=0          # Top-level only
npm list -g                 # Global packages
npm list express            # Specific package

# Update packages
npm update                  # Update all packages
npm update express          # Update specific package
npm update -g               # Update global packages

# Remove packages
npm uninstall express       # Remove dependency
npm uninstall -D jest       # Remove dev dependency
npm uninstall -g nodemon    # Remove global package

# View package information
npm view express            # Package details
npm view express version    # Specific field
npm view express versions   # All available versions
npm outdated               # Show outdated packages
```

### Script Execution
- **Purpose**: Run predefined scripts and commands
- **Usage**: Execute build, test, and development tasks
- **Example**:
```bash
# Run npm scripts
npm start                   # Runs "start" script
npm test                    # Runs "test" script
npm run build               # Runs "build" script
npm run lint                # Runs custom script

# Run with arguments
npm test -- --watch         # Pass arguments to script
npm run build -- --production

# List available scripts
npm run                     # Show all scripts

# Run multiple scripts
npm run lint && npm run test && npm run build

# Pre and post hooks (automatic)
npm run build               # Runs prebuild, build, postbuild
```

## Common Commands
```bash
# Package installation
npm install [package]              # Install package
npm install -g [package]           # Install globally
npm install --save-dev [package]   # Install as dev dependency
npm ci                             # Clean install for CI/CD

# Package management
npm update                         # Update all packages
npm uninstall [package]            # Remove package
npm outdated                       # Check for outdated packages
npm audit                          # Security audit
npm audit fix                      # Fix security vulnerabilities

# Information and search
npm list                           # List installed packages
npm view [package]                 # View package information
npm search [keyword]               # Search for packages
npm info [package]                 # Detailed package info

# Publishing and registry
npm login                          # Login to npm registry
npm publish                        # Publish package
npm unpublish [package]@[version]  # Unpublish version
npm deprecate [package]@[version]  # Deprecate version

# Configuration
npm config list                    # Show configuration
npm config set [key] [value]       # Set configuration
npm config get [key]               # Get configuration value
npm config delete [key]            # Delete configuration

# Cache management
npm cache verify                   # Verify cache integrity
npm cache clean --force            # Clear cache
npm cache ls                       # List cached packages

# Workspace management (npm 7+)
npm init -w packages/package-a     # Create workspace package
npm run test --workspace=package-a # Run script in workspace
npm install lodash --workspace=package-a  # Install in workspace
```

## Advanced Features

### Workspaces (Monorepo)
```json
{
  "name": "my-monorepo",
  "workspaces": [
    "packages/*",
    "apps/*"
  ],
  "devDependencies": {
    "lerna": "^7.1.4"
  }
}
```

```bash
# Workspace commands
npm init -w packages/core          # Create new workspace
npm install --workspace=core       # Install deps in workspace
npm run test --workspaces          # Run in all workspaces
npm run build --workspace=core --workspace=utils  # Multiple workspaces

# Install dependencies
npm install lodash -w core         # Install in specific workspace
npm install jest -D -ws            # Install in all workspaces
```

### Package Scripts with Advanced Patterns
```json
{
  "scripts": {
    "start": "node src/index.js",
    "dev": "nodemon --inspect src/index.js",
    "build": "npm run clean && npm run compile",
    "build:prod": "NODE_ENV=production npm run build",
    "clean": "rm -rf dist",
    "compile": "tsc",
    "test": "jest",
    "test:unit": "jest --testPathPattern=unit",
    "test:integration": "jest --testPathPattern=integration",
    "test:e2e": "cypress run",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "lint": "eslint src --ext .js,.ts",
    "lint:fix": "eslint src --ext .js,.ts --fix",
    "format": "prettier --write src/**/*.{js,ts,json}",
    "format:check": "prettier --check src/**/*.{js,ts,json}",
    "type-check": "tsc --noEmit",
    "validate": "npm run lint && npm run type-check && npm run test",
    "prepare": "husky install",
    "prepublishOnly": "npm run validate && npm run build",
    "postinstall": "husky install",
    "version": "npm run build && git add dist/",
    "postversion": "git push && git push --tags"
  }
}
```

### Security and Auditing
```bash
# Security audit
npm audit                          # Check for vulnerabilities
npm audit --audit-level moderate   # Set severity threshold
npm audit fix                      # Automatically fix issues
npm audit fix --force             # Force fixes (potentially breaking)

# Manual security review
npm audit --json                   # JSON output for parsing
npm audit --production            # Audit only production deps

# Using npm audit signatures (npm 8.12+)
npm audit signatures              # Verify package signatures
npm install --audit-signatures    # Install with signature verification

# Third-party security tools
npx audit-ci                      # CI-friendly audit
npx better-npm-audit              # Enhanced audit reporting
```

### Publishing Packages
```bash
# Prepare for publishing
npm login
npm whoami                         # Verify login

# Publishing workflow
npm version patch                  # Bump version (patch/minor/major)
npm publish                        # Publish to registry
npm publish --access public       # Public scoped package
npm publish --tag beta             # Publish with tag

# Managing published packages
npm deprecate package@1.0.0 "Use version 2.0.0+"
npm unpublish package@1.0.0        # Unpublish (within 24 hours)
npm owner add username package     # Add package maintainer
npm owner remove username package  # Remove maintainer

# Package distribution tags
npm dist-tag add package@1.0.0 stable
npm dist-tag rm package stable
npm dist-tag ls package
```

## Common Patterns

### Development Workflow
```bash
# Start new project
npm init -y
npm install express dotenv
npm install -D nodemon jest eslint prettier

# Development cycle
npm run dev                        # Start development server
npm run lint                       # Check code quality
npm run test                       # Run tests
npm run build                      # Build for production

# Before committing
npm run validate                   # Run all checks
npm audit                          # Security check
```

### Dependency Management Best Practices
```json
{
  "dependencies": {
    "express": "^4.18.2",          // Patch updates allowed
    "lodash": "~4.17.21"           // Minor updates only
  },
  "devDependencies": {
    "typescript": "^5.1.6",        // Latest compatible
    "jest": "29.6.2"              // Exact version (no prefix)
  },
  "peerDependencies": {
    "react": ">=16.8.0"           // Minimum version requirement
  },
  "optionalDependencies": {
    "fsevents": "^2.3.2"          // Optional platform-specific
  }
}
```

### Version Management
```bash
# Semantic versioning
npm version patch      # 1.0.0 → 1.0.1 (bug fixes)
npm version minor      # 1.0.0 → 1.1.0 (new features)
npm version major      # 1.0.0 → 2.0.0 (breaking changes)

# Pre-release versions
npm version prerelease            # 1.0.0 → 1.0.1-0
npm version prerelease --preid=alpha  # 1.0.0 → 1.0.1-alpha.0
npm version prerelease --preid=beta   # 1.0.0 → 1.0.1-beta.0

# Custom version
npm version 1.2.3-custom.1
```

## Performance Optimization

### Installation Speed
```bash
# Use npm ci for faster, reproducible builds
npm ci                             # Clean install from package-lock.json

# Parallel installation
npm install --prefer-offline       # Use cache when possible
npm install --no-audit            # Skip audit for speed
npm install --no-fund             # Skip funding messages

# Alternative fast package managers
npx pnpm install                   # pnpm (faster alternative)
npx yarn install                   # Yarn (alternative manager)
```

### Cache Management
```bash
# Cache operations
npm cache verify                   # Verify cache integrity
npm cache clean --force            # Clear all cached data
npm cache ls                       # List cached packages

# Cache configuration
npm config set cache /path/to/cache
npm config get cache

# Offline installation
npm install --prefer-offline       # Use cache when available
npm install --offline             # Only use cache (fail if not cached)
```

### Bundle Analysis
```bash
# Analyze bundle size
npx webpack-bundle-analyzer dist/
npx source-map-explorer dist/bundle.js
npm install -g cost-of-modules && cost-of-modules

# Reduce bundle size
npm install --production           # Only production dependencies
npm prune                         # Remove unused packages
```

## Common Issues & Solutions

### Dependency Conflicts
**Problem**: Conflicting dependency versions
**Solution**: Use npm overrides or peer dependencies
```json
{
  "overrides": {
    "lodash": "^4.17.21",
    "some-package": {
      "lodash": "^4.17.21"
    }
  }
}
```

### Permission Errors
**Problem**: Permission denied when installing global packages
**Solution**: Configure npm to use different directory or use nvm
```bash
# Change global prefix
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH

# Or use Node Version Manager (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node
```

### Package-lock.json Conflicts
**Problem**: Merge conflicts in package-lock.json
**Solution**: Delete and regenerate
```bash
rm package-lock.json
npm install
# Or use npm ci to install from existing lock file
```

### Network Issues
**Problem**: Network connectivity problems
**Solution**: Configure proxy or use different registry
```bash
# Configure proxy
npm config set proxy http://proxy-server:port
npm config set https-proxy http://proxy-server:port

# Use different registry
npm config set registry https://registry.npmjs.org/
npm install --registry https://registry.npmjs.org/
```

## Integration with Development Tools

### CI/CD Integration
```yaml
# GitHub Actions example
name: Node.js CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [16.x, 18.x, 20.x]

    steps:
    - uses: actions/checkout@v4
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v4
      with:
        node-version: ${{ matrix.node-version }}
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Run tests
      run: npm run test

    - name: Run security audit
      run: npm audit --audit-level moderate
```

### Docker Integration
```dockerfile
# Dockerfile with npm
FROM node:18-alpine

WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production && npm cache clean --force

# Copy application code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

USER nextjs

EXPOSE 3000

CMD ["npm", "start"]
```

### IDE Integration
```json
// VS Code settings.json
{
  "npm.enableScriptExplorer": true,
  "npm.scriptExplorerAction": "run",
  "npm.exclude": "**/node_modules/**",
  "typescript.preferences.includePackageJsonAutoImports": "on"
}
```

## Useful Resources
- **Official Documentation**: https://docs.npmjs.com/
- **npm CLI Reference**: https://docs.npmjs.com/cli/
- **Package.json Guide**: https://docs.npmjs.com/cli/configuring-npm/package-json
- **npm Registry**: https://www.npmjs.com/
- **Semantic Versioning**: https://semver.org/
- **Node.js Best Practices**: https://github.com/goldbergyoni/nodebestpractices

## Tool-Specific Guidelines

### Package.json Best Practices
- Use exact versions for critical dependencies
- Keep dependencies up to date but test thoroughly
- Use peerDependencies for libraries that expect the host to provide dependencies
- Include engines field to specify Node.js/npm versions
- Add keywords for better discoverability

### Script Organization
- Use meaningful script names that describe their purpose
- Organize scripts logically (build, test, lint, etc.)
- Use pre/post hooks sparingly and document their purpose
- Consider using npm-run-all for running multiple scripts

### Security Guidelines
- Regularly run npm audit and fix vulnerabilities
- Use .npmignore to exclude sensitive files from published packages
- Enable two-factor authentication for npm account
- Use npm tokens for CI/CD instead of passwords

## Version Compatibility
- **Node.js**: 16.0+ (npm 8.x), 18.0+ (npm 9.x), 20.0+ (npm 10.x)
- **npm**: 8.0+ (legacy), 9.0+ (current), 10.0+ (latest)
- **Package managers**: Compatible with yarn, pnpm for most operations
- **Platform Support**: Windows, macOS, Linux

## Troubleshooting

### Debug Mode
```bash
# Enable verbose logging
npm install --loglevel verbose
npm --verbose install

# Debug npm operations
npm config set loglevel verbose
npm config set progress true

# Check npm configuration
npm config list
npm config list -l              # Show all settings
npm doctor                      # Diagnose npm setup
```

### Common Error Messages
- **Error**: `EACCES: permission denied`
  **Cause**: Insufficient permissions for global install
  **Solution**: Use nvm or change npm prefix

- **Error**: `Cannot resolve dependency`
  **Cause**: Conflicting dependency versions
  **Solution**: Use npm overrides or update dependencies

- **Error**: `Network timeout`
  **Cause**: Network connectivity issues
  **Solution**: Configure registry timeout or use different registry
1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions

```

```
