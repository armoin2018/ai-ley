
# Yarn Package Manager Instructions

## Tool Overview
- **Tool Name**: Yarn (Yet Another Resource Negotiator)
- **Version**: Yarn 1.22+ (Classic), Yarn 3.0+ (Berry), Yarn 4.0+ (Latest)
- **Category**: Package Management
- **Purpose**: Fast, reliable, and secure dependency management for JavaScript projects
- **Prerequisites**: Node.js 16.10+ (for Yarn 3+), Node.js 12+ (for Yarn 1.x)

## Installation & Setup
### Yarn Installation
```bash
# Install via npm (Yarn 1.x)
npm install -g yarn

# Install via Homebrew (macOS)
brew install yarn

# Install via Chocolatey (Windows)
choco install yarn

# Install via package manager (Ubuntu/Debian)
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

# Enable Corepack (Node.js 16.10+) - for Yarn 3+
corepack enable
corepack prepare yarn@stable --activate

# Verify installation
yarn --version
```

### Project Initialization
```bash
# Initialize new project
yarn init                          # Interactive setup
yarn init -y                       # Use defaults
yarn init -p                       # Private package

# Set Yarn version for project (Yarn 3+)
yarn set version stable            # Latest stable
yarn set version 3.6.3            # Specific version
yarn set version berry             # Latest berry version

# Create project structure
mkdir my-project
cd my-project
yarn init -y
```

## Configuration

### package.json Configuration
```json
{
  "name": "my-awesome-project",
  "version": "1.0.0",
  "description": "A sample Node.js project with Yarn",
  "main": "src/index.js",
  "type": "module",
  "packageManager": "yarn@4.0.1",
  "engines": {
    "node": ">=18.0.0",
    "yarn": ">=3.0.0"
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
    "typecheck": "tsc --noEmit",
    "clean": "rm -rf dist node_modules .yarn/cache",
    "prepare": "husky install",
    "postinstall": "husky install"
  },
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
  "workspaces": [
    "packages/*",
    "apps/*"
  ]
}
```

### .yarnrc.yml Configuration (Yarn 3+)
```yaml
# Yarn 3+ configuration
nodeLinker: node-modules            # or 'pnp' for Plug'n'Play

# Registry settings
npmRegistryServer: "https://registry.npmjs.org"
unsafeHttpWhitelist:
  - "localhost"

# Cache settings
enableGlobalCache: true
globalFolder: "./.yarn/global"

# Workspace settings
workspaceFolder: "./packages"

# Plugin settings
plugins:
  - path: .yarn/plugins/@yarnpkg/plugin-interactive-tools.cjs
    spec: "@yarnpkg/plugin-interactive-tools"
  - path: .yarn/plugins/@yarnpkg/plugin-workspace-tools.cjs
    spec: "@yarnpkg/plugin-workspace-tools"

# Network settings
httpTimeout: 60000
networkConcurrency: 10

# Security settings
enableStrictSsl: true
```

### .yarnrc Configuration (Yarn 1.x)
```ini
# Yarn 1.x configuration
registry "https://registry.npmjs.org"
save-prefix "^"
save-exact false
network-timeout 60000
network-concurrency 10

# Workspaces
workspaces-experimental true

# Cache
cache-folder ".yarn/cache"

# Offline mirror
yarn-offline-mirror "./offline-mirror"
yarn-offline-mirror-pruning true
```

### Environment Variables
```bash
# Yarn configuration via environment variables
export YARN_REGISTRY=https://registry.npmjs.org/
export YARN_CACHE_FOLDER=/path/to/cache
export YARN_GLOBAL_FOLDER=/path/to/global
export YARN_ENABLE_IMMUTABLE_INSTALLS=true

# Authentication
export YARN_NPM_AUTH_TOKEN=your_auth_token

# Network settings
export YARN_NETWORK_TIMEOUT=60000
export YARN_NETWORK_CONCURRENCY=10
```

## Core Features

### Package Installation
- **Purpose**: Install and manage project dependencies efficiently
- **Usage**: Add libraries and tools with advanced resolution algorithms
- **Example**:
```bash
# Install dependencies
yarn                               # Install from package.json/yarn.lock
yarn install                       # Same as above
yarn install --frozen-lockfile     # Install exact versions (CI/CD)
yarn install --production         # Install only production deps

# Add packages
yarn add lodash                    # Add production dependency
yarn add --dev jest                # Add development dependency
yarn add --peer react             # Add peer dependency
yarn add --optional fsevents      # Add optional dependency

# Version specifications
yarn add express@4.18.2           # Specific version
yarn add express@^4.18.0          # Compatible version range
yarn add express@latest           # Latest version
yarn add express@beta             # Beta version

# Install from different sources
yarn add lodash                    # npm registry
yarn add lodash@npm:^4.17.0       # Explicit npm protocol
yarn add github:lodash/lodash     # GitHub repository
yarn add https://github.com/user/repo.git  # Git URL
yarn add file:../local-package    # Local file system
yarn add link:../local-package    # Symlink to local package
```

### Package Management
- **Purpose**: Update, remove, and analyze installed packages
- **Usage**: Maintain project dependencies and resolve conflicts
- **Example**:
```bash
# List installed packages
yarn list                          # All packages
yarn list --depth=0               # Top-level only
yarn list --pattern="webpack*"    # Filter by pattern
yarn global list                  # Global packages

# Update packages
yarn upgrade                       # Update all packages
yarn upgrade lodash                # Update specific package
yarn upgrade-interactive          # Interactive update (with plugin)
yarn upgrade lodash@^4.17.21      # Update to specific version

# Remove packages
yarn remove lodash                 # Remove dependency
yarn remove --dev jest             # Remove dev dependency
yarn global remove nodemon        # Remove global package

# Package information
yarn info lodash                   # Package details
yarn info lodash version          # Specific field
yarn info lodash versions         # All available versions
yarn outdated                     # Show outdated packages
yarn audit                        # Security audit
yarn audit --summary              # Audit summary only
```

### Workspace Management
- **Purpose**: Manage monorepo with multiple packages
- **Usage**: Coordinate dependencies across related packages
- **Example**:
```bash
# Workspace operations
yarn workspaces info               # Show workspace dependency tree
yarn workspaces run build         # Run script in all workspaces
yarn workspaces run --parallel build  # Run in parallel

# Workspace-specific commands
yarn workspace package-a add lodash    # Add dependency to specific workspace
yarn workspace package-a run test     # Run script in specific workspace
yarn workspace package-a remove dep   # Remove dependency from workspace

# Add dependencies to workspaces
yarn add lodash -W                     # Add to root workspace
yarn add jest --dev -W                # Add dev dependency to root
```

## Common Commands
```bash
# Installation and setup
yarn                               # Install dependencies
yarn install                       # Install dependencies
yarn install --frozen-lockfile     # Install with locked versions
yarn add [package]                 # Add dependency
yarn add --dev [package]           # Add dev dependency
yarn remove [package]              # Remove dependency

# Package information
yarn list                          # List installed packages
yarn info [package]                # Show package information
yarn outdated                      # Show outdated packages
yarn audit                         # Security audit
yarn audit fix                     # Fix security issues (Yarn 1.x)

# Workspace management
yarn workspaces info               # Workspace information
yarn workspace [name] [command]    # Run command in workspace
yarn workspaces run [script]       # Run script in all workspaces

# Cache and cleaning
yarn cache list                    # List cached packages
yarn cache dir                     # Show cache directory
yarn cache clean                   # Clean cache
yarn cache clean [package]         # Clean specific package

# Script execution
yarn run [script]                  # Run package.json script
yarn [script]                      # Run script (shorthand)
yarn start                         # Run start script
yarn test                          # Run test script
yarn build                         # Run build script

# Version management
yarn version                       # Interactive version bump
yarn version --patch               # Bump patch version
yarn version --minor               # Bump minor version
yarn version --major               # Bump major version

# Global packages
yarn global add [package]          # Install globally
yarn global remove [package]       # Remove global package
yarn global list                   # List global packages
yarn global bin                    # Show global bin directory

# Configuration
yarn config list                   # Show configuration
yarn config get [key]              # Get configuration value
yarn config set [key] [value]      # Set configuration value
yarn config delete [key]           # Delete configuration value

# Publishing (Yarn 1.x)
yarn login                         # Login to registry
yarn publish                       # Publish package
yarn publish --tag beta            # Publish with tag
```

## Advanced Features

### Plug'n'Play (PnP) Mode (Yarn 3+)
```yaml
# .yarnrc.yml
nodeLinker: pnp                    # Enable Plug'n'Play

# Generate PnP files
compressionLevel: mixed
enableGlobalCache: false

# ESM support
pnpMode: strict
```

```javascript
// .pnp.cjs usage
const pnp = require('./.pnp.cjs');

// ESM support in package.json
{
  "type": "module",
  "imports": {
    "#lib/*": "./lib/*"
  }
}
```

### Zero-Installs (Yarn 3+)
```yaml
# .yarnrc.yml - Enable zero-installs
enableGlobalCache: false
compressionLevel: mixed

# .gitignore adjustments for zero-installs
# Keep .yarn/cache in git
# .yarn/cache should NOT be in .gitignore
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
```

### Constraints (Yarn 3+)
```javascript
// yarn.config.cjs - Workspace constraints
module.exports = {
  constraints: async ({Yarn}) => {
    // Ensure all workspaces use same TypeScript version
    for (const workspace of Yarn.workspaces()) {
      const dep = workspace.manifest.devDependencies.get('typescript');
      if (dep && dep.range !== '^5.1.6') {
        workspace.error(`TypeScript version should be ^5.1.6, got ${dep.range}`);
      }
    }

    // Ensure all workspaces have test script
    for (const workspace of Yarn.workspaces()) {
      if (!workspace.manifest.scripts.has('test')) {
        workspace.error('All workspaces must have a test script');
      }
    }
  }
};
```

### Interactive Tools Plugin
```bash
# Install interactive tools plugin (Yarn 3+)
yarn plugin import interactive-tools

# Use interactive commands
yarn upgrade-interactive           # Interactive package upgrades
yarn add --interactive            # Interactive package selection
```

## Common Patterns

### Development Workflow
```bash
# Start new project
yarn init -y
yarn add express dotenv
yarn add --dev nodemon jest eslint prettier typescript

# Development cycle
yarn dev                          # Start development server
yarn lint                         # Check code quality
yarn test                         # Run tests
yarn build                        # Build for production

# Before committing
yarn lint && yarn test && yarn build
yarn audit                        # Security check
```

### Monorepo Setup
```json
{
  "name": "my-monorepo",
  "private": true,
  "workspaces": [
    "packages/*",
    "apps/*",
    "tools/*"
  ],
  "scripts": {
    "build": "yarn workspaces run build",
    "test": "yarn workspaces run test",
    "lint": "yarn workspaces run lint",
    "clean": "yarn workspaces run clean && rm -rf node_modules"
  },
  "devDependencies": {
    "lerna": "^7.1.4",
    "typescript": "^5.1.6"
  }
}
```

```bash
# Monorepo workflow
yarn workspaces run build          # Build all packages
yarn workspace @myorg/core add lodash  # Add dep to specific package
yarn workspace @myorg/utils run test   # Test specific package

# Cross-workspace dependencies
cd packages/utils
yarn add @myorg/core@workspace:*   # Depend on sibling workspace
```

### Version Management
```bash
# Semantic versioning
yarn version --patch              # 1.0.0 → 1.0.1
yarn version --minor              # 1.0.0 → 1.1.0
yarn version --major              # 1.0.0 → 2.0.0

# Pre-release versions
yarn version --prerelease         # 1.0.0 → 1.0.1-0
yarn version --prerelease --preid=alpha  # 1.0.0 → 1.0.1-alpha.0

# Custom version
yarn version --new-version 1.2.3-custom.1

# Version management with workspaces
yarn workspaces version           # Version all workspaces
yarn workspace @myorg/core version --patch  # Version specific workspace
```

## Performance Optimization

### Installation Speed
```bash
# Faster installations
yarn install --frozen-lockfile    # Skip resolution, use lockfile
yarn install --offline           # Use cache only
yarn install --prefer-offline    # Prefer cache over network
yarn install --network-concurrency 1  # Reduce network load

# Parallel processing
yarn install --parallel          # Install deps in parallel (Yarn 1.x)
yarn workspaces run --parallel build  # Parallel workspace commands
```

### Cache Optimization
```bash
# Cache management
yarn cache list                   # List cached packages
yarn cache dir                    # Show cache directory
yarn cache clean                  # Clean all cache
yarn cache clean lodash           # Clean specific package

# Global cache (Yarn 3+)
yarn config set enableGlobalCache true
yarn config set globalFolder ~/.yarn/global
```

### Bundle Analysis
```bash
# Analyze dependencies
yarn list --depth=0               # Top-level dependencies only
yarn why lodash                   # Why is this package installed?
yarn audit --summary              # Security audit summary

# Package analysis tools
yarn dlx webpack-bundle-analyzer dist/
yarn dlx source-map-explorer dist/bundle.js
```

## Common Issues & Solutions

### Lock File Conflicts
**Problem**: Merge conflicts in yarn.lock
**Solution**: Use Yarn's merge resolution
```bash
# Delete lock file and reinstall
rm yarn.lock
yarn install

# Or use git merge tools
git checkout --theirs yarn.lock
yarn install
```

### Version Resolution Issues
**Problem**: Dependency version conflicts
**Solution**: Use resolutions field
```json
{
  "resolutions": {
    "lodash": "^4.17.21",
    "some-package/lodash": "^4.17.21",
    "**/lodash": "^4.17.21"
  }
}
```

### Workspace Dependency Issues
**Problem**: Workspace dependencies not resolving
**Solution**: Use workspace protocol
```json
{
  "dependencies": {
    "@myorg/core": "workspace:*",
    "@myorg/utils": "workspace:^1.0.0"
  }
}
```

### Network and Proxy Issues
**Problem**: Network connectivity problems
**Solution**: Configure network settings
```bash
# Configure proxy
yarn config set proxy http://proxy-server:port
yarn config set https-proxy http://proxy-server:port

# Configure registry
yarn config set registry https://registry.npmjs.org/

# Network timeout
yarn config set network-timeout 60000
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
        cache: 'yarn'

    - name: Install dependencies
      run: yarn install --frozen-lockfile

    - name: Run tests
      run: yarn test

    - name: Run security audit
      run: yarn audit

    - name: Build
      run: yarn build
```

### Docker Integration
```dockerfile
# Multi-stage Dockerfile with Yarn
FROM node:18-alpine AS deps
WORKDIR /app

# Copy package files
COPY package.json yarn.lock* ./

# Install dependencies
RUN yarn install --frozen-lockfile --production=false

# Build stage
FROM node:18-alpine AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN yarn build

# Production stage
FROM node:18-alpine AS runner
WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/dist ./dist
COPY --from=deps /app/node_modules ./node_modules
COPY package.json ./

USER nextjs

EXPOSE 3000

CMD ["yarn", "start"]
```

### IDE Integration
```json
// VS Code settings.json
{
  "yarn.enableScriptExplorer": true,
  "typescript.preferences.includePackageJsonAutoImports": "on",
  "search.exclude": {
    "**/node_modules": true,
    "**/.yarn": true,
    "**/.pnp.*": true
  }
}
```

## Useful Resources
- **Official Documentation**: https://yarnpkg.com/
- **Yarn 3+ (Berry) Docs**: https://yarnpkg.com/getting-started
- **Migration Guide**: https://yarnpkg.com/getting-started/migration
- **Plugin Directory**: https://yarnpkg.com/plugins
- **Workspaces Guide**: https://yarnpkg.com/features/workspaces
- **PnP Guide**: https://yarnpkg.com/features/pnp

## Tool-Specific Guidelines

### Package.json Best Practices
- Use `packageManager` field to specify Yarn version
- Configure workspaces for monorepo projects
- Use resolutions for dependency version conflicts
- Include engines field for Node.js/Yarn version requirements

### Lockfile Management
- Always commit yarn.lock to version control
- Use `--frozen-lockfile` in CI/CD environments
- Don't manually edit yarn.lock
- Use `yarn why` to understand dependency resolution

### Workspace Guidelines
- Use workspace protocol (`workspace:*`) for internal dependencies
- Organize workspaces logically (apps, packages, tools)
- Use consistent naming conventions for workspace packages
- Configure constraints to enforce workspace standards

## Version Compatibility
- **Yarn 1.x**: Node.js 8+, legacy but stable
- **Yarn 3.x (Berry)**: Node.js 16.10+, modern features
- **Yarn 4.x**: Node.js 18+, latest improvements
- **Package managers**: Can coexist with npm, use `packageManager` field
- **Platform Support**: Windows, macOS, Linux

## Troubleshooting

### Debug Mode
```bash
# Enable verbose logging
yarn install --verbose
yarn --verbose add lodash

# Debug specific operations
yarn config set --home enableTelemetry 0
yarn config set logLevel info

# Check Yarn doctor (Yarn 3+)
yarn dlx @yarnpkg/doctor
```

### Common Error Messages
- **Error**: `Resolution step failed`
  **Cause**: Dependency version conflicts
  **Solution**: Use resolutions in package.json

- **Error**: `Package not found`
  **Cause**: Registry or network issues
  **Solution**: Check registry configuration and network connectivity

- **Error**: `Workspace not found`
  **Cause**: Incorrect workspace configuration
  **Solution**: Verify workspace paths in package.json
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
