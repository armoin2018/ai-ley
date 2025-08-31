
# pnpm Package Manager Instructions

## Tool Overview
- **Tool Name**: pnpm (performant npm)
- **Version**: 8.6+ (stable), 8.15+ (latest with improved performance)
- **Category**: Package Manager
- **Purpose**: Fast, disk space efficient package manager for Node.js projects
- **Prerequisites**: Node.js 16.14+ (18+ recommended), npm (for initial installation)

## Installation & Setup
### Installation Methods
```bash
# Install via npm (most common)
npm install -g pnpm

# Install via Homebrew (macOS)
brew install pnpm

# Install via Scoop (Windows)
scoop install nodejs pnpm

# Install via Chocolatey (Windows)
choco install pnpm

# Install via standalone script (Linux/macOS)
curl -fsSL https://get.pnpm.io/install.sh | sh -
wget -qO- https://get.pnpm.io/install.sh | sh -

# Install via Corepack (Node.js 16.13+)
corepack enable
corepack prepare pnpm@latest --activate

# Update pnpm
pnpm add -g pnpm
# or
pnpm install -g pnpm@latest

# Verify installation
pnpm --version
pnpm info
```

### Project Initialization
```bash
# Create new project
mkdir my-project && cd my-project
pnpm init

# Initialize with specific details
pnpm init --yes
pnpm init --scope=@company

# Convert from npm/yarn
cd existing-project
rm package-lock.json     # Remove npm lock
rm yarn.lock             # Remove yarn lock
pnpm install             # Generate pnpm-lock.yaml

# Create project from template
pnpm create react-app my-app
pnpm create next-app my-app
pnpm create vite my-app --template react-ts
pnpm create @vitejs/app my-vue-app --template vue-ts
```

## Configuration

### .npmrc Configuration
```ini
# .npmrc (project-level configuration)
# Registry configuration
registry=https://registry.npmjs.org/
@company:registry=https://npm.company.com/

# pnpm-specific settings
strict-peer-dependencies=true
auto-install-peers=true
prefer-workspace-packages=true
save-workspace-protocol=rolling
enable-pre-post-scripts=true

# Performance optimizations
store-dir=~/.pnpm-store
verify-store-integrity=true
package-import-method=hardlink
side-effects-cache=true
side-effects-cache-readonly=false

# Logging and output
loglevel=info
progress=true
reporter=default

# Security settings
audit-level=moderate
fund=false

# Resolution strategy
resolution-mode=highest
prefer-symlinked-executables=false

# Node.js and platform settings
node-version=18.17.0
use-node-version=18.17.0
```

### Global Configuration
```bash
# Set global configuration
pnpm config set registry https://registry.npmjs.org/
pnpm config set store-dir ~/.pnpm-store
pnpm config set strict-peer-dependencies true

# View current configuration
pnpm config list
pnpm config list --global
pnpm config get registry

# Location-specific configuration
pnpm config set --location=global registry https://npm.company.com/
pnpm config set --location=project auto-install-peers true

# Environment-specific settings
pnpm config set production-only true --location=global
```

### Workspace Configuration (pnpm-workspace.yaml)
```yaml
# pnpm-workspace.yaml
packages:
  # Include all packages in packages directory
  - 'packages/*'
  - 'apps/*'

  # Include packages with specific patterns
  - 'tools/*'
  - 'libs/**'

  # Exclude certain directories
  - '!**/test/**'
  - '!**/node_modules/**'
  - '!**/dist/**'

# Example complex workspace structure
packages:
  - 'frontend/packages/*'
  - 'backend/services/*'
  - 'shared/libs/*'
  - 'tools/*'
  - '!**/templates/**'
```

### Package.json Configuration
```json
{
  "name": "@company/my-app",
  "version": "1.0.0",
  "description": "Modern app with pnpm",
  "main": "index.js",
  "type": "module",
  "engines": {
    "node": ">=18.0.0",
    "pnpm": ">=8.6.0"
  },
  "packageManager": "pnpm@8.15.0",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "typecheck": "tsc --noEmit",
    "clean": "rimraf dist node_modules/.vite",
    "deps:update": "pnpm update --interactive",
    "deps:check": "pnpm audit && pnpm outdated"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.37",
    "@types/react-dom": "^18.2.15",
    "@vitejs/plugin-react": "^4.1.1",
    "eslint": "^8.53.0",
    "typescript": "^5.2.2",
    "vite": "^5.0.0",
    "vitest": "^1.0.0"
  },
  "pnpm": {
    "overrides": {
      "semver@<7.5.2": ">=7.5.2"
    },
    "peerDependencyRules": {
      "ignoreMissing": ["@babel/core"],
      "allowedVersions": {
        "react": "18"
      }
    },
    "updateConfig": {
      "ignoreDependencies": ["@types/node"]
    }
  }
}
```

## Core Features

### Package Installation
- **Purpose**: Install dependencies with optimized storage and performance
- **Usage**: Manage project dependencies efficiently using content-addressable storage
- **Example**:
```bash
# Install all dependencies
pnpm install
pnpm i                              # Short form

# Install production dependencies only
pnpm install --prod
pnpm install --production

# Install with specific options
pnpm install --frozen-lockfile      # Don't update lock file
pnpm install --prefer-offline       # Use cache when possible
pnpm install --ignore-scripts       # Skip pre/post scripts

# Add new dependencies
pnpm add react react-dom            # Add to dependencies
pnpm add -D typescript @types/node   # Add to devDependencies
pnpm add -O eslint                  # Add to optionalDependencies
pnpm add -P express                 # Add to dependencies (explicit)

# Add with version specifications
pnpm add react@18.2.0              # Exact version
pnpm add lodash@^4.17.0             # Compatible version
pnpm add typescript@latest          # Latest version
pnpm add @types/node@~18.0.0        # Tilde range

# Add from different sources
pnpm add github:user/repo           # GitHub repository
pnpm add git+https://github.com/user/repo.git  # Git URL
pnpm add file:../local-package      # Local package
pnpm add https://registry.com/package.tgz      # Tarball URL
```

### Package Management
- **Purpose**: Efficiently manage package lifecycle and updates
- **Usage**: Add, remove, update packages with minimal disk usage
- **Example**:
```bash
# Remove dependencies
pnpm remove react-router-dom        # Remove from dependencies
pnpm rm lodash                      # Short form
pnpm remove -D @types/jest          # Remove from devDependencies

# Update dependencies
pnpm update                         # Update all packages
pnpm up                            # Short form
pnpm update react react-dom        # Update specific packages
pnpm update --latest               # Update to latest versions
pnpm update --interactive          # Interactive update

# Check outdated packages
pnpm outdated                      # Show outdated packages
pnpm outdated --format=table       # Table format
pnpm outdated react                # Check specific package

# List installed packages
pnpm list                          # List project dependencies
pnpm ls                           # Short form
pnpm list --depth=0               # Top-level only
pnpm list --prod                  # Production dependencies only
pnpm list --global                # Global packages
```

### Workspace Management
- **Purpose**: Manage multiple packages in a monorepo efficiently
- **Usage**: Share dependencies across packages while maintaining isolation
- **Example**:
```bash
# Install dependencies for all workspace packages
pnpm install

# Install for specific workspace
pnpm install --filter=@company/frontend
pnpm install --filter=./packages/ui

# Add dependency to specific workspace
pnpm add react --filter=@company/frontend
pnpm add -D typescript --filter=./packages/shared

# Run scripts across workspaces
pnpm run build --filter=@company/frontend
pnpm run test --filter="./packages/*"
pnpm run lint --filter="...{packages/ui}"

# Recursive operations
pnpm run build --recursive          # Run in all workspaces
pnpm run test -r                    # Short form
pnpm run lint --parallel            # Run in parallel

# Workspace-specific operations
pnpm --filter=frontend run dev      # Run dev in frontend package
pnpm --filter="@company/*" run build # Run build in all @company packages
```

## Common Commands
```bash
# Package installation and management
pnpm install                        # Install dependencies
pnpm add <package>                  # Add dependency
pnpm remove <package>               # Remove dependency
pnpm update                         # Update dependencies
pnpm update --interactive           # Interactive update

# Package information
pnpm list                           # List installed packages
pnpm outdated                       # Show outdated packages
pnpm audit                          # Security audit
pnpm why <package>                  # Show dependency tree
pnpm licenses list                  # Show package licenses

# Script execution
pnpm run <script>                   # Run npm script
pnpm start                          # Run start script
pnpm test                           # Run test script
pnpm build                          # Run build script

# Workspace operations
pnpm -r run build                   # Run script recursively
pnpm --filter <package> <command>   # Run command in specific package
pnpm --filter="./packages/*" test   # Run in filtered packages

# Global operations
pnpm add -g <package>               # Install globally
pnpm list -g                        # List global packages
pnpm update -g                      # Update global packages

# Cache and store management
pnpm store status                   # Check store status
pnpm store prune                    # Remove orphaned packages
pnpm store path                     # Show store location

# Development and debugging
pnpm exec <command>                 # Execute command in project context
pnpm dlx <command>                  # Download and execute
pnpm create <template>              # Create project from template
```

## Advanced Features

### Store Management
```bash
# Store operations
pnpm store status                   # Show store statistics
pnpm store prune                    # Clean up unused packages
pnpm store path                     # Show store directory

# Store configuration
pnpm config set store-dir /custom/path/.pnpm-store
pnpm config set verify-store-integrity true
pnpm config set package-import-method hardlink

# Verify store integrity
pnpm install --verify-store-integrity
```

### Filtering and Selection
```bash
# Filter by package name
pnpm --filter="@company/frontend" run build
pnpm --filter="*ui*" run test

# Filter by path
pnpm --filter="./packages/frontend" install
pnpm --filter="./apps/*" run dev

# Filter by dependency relationship
pnpm --filter="...@company/shared" run build    # Dependents
pnpm --filter="@company/frontend..." run test   # Dependencies

# Filter with exclusions
pnpm --filter="./packages/*" --filter="!./packages/legacy" run lint

# Complex filtering
pnpm --filter="[origin/main]" run test          # Changed since main
pnpm --filter="{./packages/ui}..." run build    # Dependencies of ui
```

### Peer Dependencies
```bash
# Automatic peer dependency installation
pnpm config set auto-install-peers true
pnpm install

# Manual peer dependency management
pnpm install react@18 react-dom@18  # Install peers manually
pnpm why react                       # Check peer dependency usage

# Configuration for peer dependencies
{
  "pnpm": {
    "peerDependencyRules": {
      "ignoreMissing": ["@babel/core", "webpack"],
      "allowedVersions": {
        "react": "18",
        "typescript": "5"
      }
    }
  }
}
```

### Overrides and Resolutions
```json
{
  "pnpm": {
    "overrides": {
      "semver@<7.5.2": ">=7.5.2",
      "lodash@<4.17.21": ">=4.17.21",
      "minimist": "^1.2.6"
    },
    "neverBuiltDependencies": [
      "fsevents",
      "level"
    ],
    "onlyBuiltDependencies": [
      "core-js"
    ]
  }
}
```

## Workspace Patterns

### Monorepo Structure
```bash
# Typical monorepo structure
my-monorepo/
├── pnpm-workspace.yaml
├── package.json
├── packages/
│   ├── ui/
│   │   ├── package.json
│   │   └── src/
│   ├── utils/
│   │   ├── package.json
│   │   └── src/
│   └── shared/
│       ├── package.json
│       └── src/
├── apps/
│   ├── frontend/
│   │   ├── package.json
│   │   └── src/
│   └── backend/
│       ├── package.json
│       └── src/
└── tools/
    ├── eslint-config/
    └── build-tools/
```

### Cross-Package Dependencies
```json
{
  "name": "@company/frontend",
  "dependencies": {
    "@company/ui": "workspace:*",
    "@company/utils": "workspace:^1.0.0",
    "@company/shared": "workspace:~"
  }
}
```

### Shared Development Dependencies
```json
{
  "name": "monorepo-root",
  "devDependencies": {
    "typescript": "^5.2.0",
    "eslint": "^8.53.0",
    "@typescript-eslint/parser": "^6.0.0",
    "prettier": "^3.0.0"
  }
}
```

### Workspace Scripts
```json
{
  "scripts": {
    "build": "pnpm -r run build",
    "test": "pnpm -r run test",
    "lint": "pnpm -r run lint",
    "dev": "pnpm --parallel -r run dev",
    "clean": "pnpm -r run clean && rimraf node_modules",
    "typecheck": "pnpm -r run typecheck",
    "build:changed": "pnpm --filter=\"[origin/main]\" run build",
    "test:affected": "pnpm --filter=\"...{packages/ui}\" run test"
  }
}
```

## Performance Optimization

### Installation Speed
```bash
# Optimize installation performance
pnpm config set verify-store-integrity false  # Skip verification
pnpm config set side-effects-cache true       # Enable side effects cache
pnpm config set prefer-offline true           # Use cache when possible

# Parallel installation
pnpm install --no-optional                    # Skip optional deps
pnpm install --production                     # Skip dev deps
pnpm install --frozen-lockfile                # Don't update lockfile
```

### Store Optimization
```bash
# Store management for performance
pnpm store prune                              # Remove unused packages
pnpm config set package-import-method hardlink # Use hardlinks
pnpm config set store-dir /fast-ssd/.pnpm-store # Use fast storage
```

### CI/CD Optimization
```yaml
# GitHub Actions optimization
- name: Setup pnpm
  uses: pnpm/action-setup@v2
  with:
    version: 8.15.0

- name: Setup Node.js
  uses: actions/setup-node@v4
  with:
    node-version: '18'
    cache: 'pnpm'
    cache-dependency-path: 'pnpm-lock.yaml'

- name: Install dependencies
  run: pnpm install --frozen-lockfile --prefer-offline

- name: Cache pnpm store
  uses: actions/cache@v3
  with:
    path: ~/.pnpm-store
    key: ${{ runner.os }}-pnpm-store-${{ hashFiles('**/pnpm-lock.yaml') }}
    restore-keys: |
      ${{ runner.os }}-pnpm-store-
```

## Migration Strategies

### From npm
```bash
# Remove npm artifacts
rm package-lock.json
rm -rf node_modules

# Install with pnpm
pnpm install

# Update scripts if needed (usually no changes required)
# Commit pnpm-lock.yaml
```

### From Yarn
```bash
# Remove Yarn artifacts
rm yarn.lock
rm -rf node_modules

# Convert yarn workspaces to pnpm workspaces
# Update package.json workspaces to pnpm-workspace.yaml

# Install with pnpm
pnpm install

# Update scripts if using Yarn-specific commands
```

### Gradual Migration
```json
{
  "scripts": {
    "install:npm": "npm install",
    "install:pnpm": "pnpm install",
    "install": "pnpm install"
  }
}
```

## Common Patterns

### Development Setup
```bash
# Project setup
pnpm create react-app my-app --template typescript
cd my-app

# Add common development tools
pnpm add -D eslint prettier husky lint-staged
pnpm add -D @typescript-eslint/parser @typescript-eslint/eslint-plugin

# Setup git hooks
pnpm dlx husky-init
echo "pnpm lint-staged" > .husky/pre-commit
```

### Library Development
```json
{
  "name": "@company/my-library",
  "main": "dist/index.js",
  "module": "dist/index.esm.js",
  "types": "dist/index.d.ts",
  "files": ["dist"],
  "scripts": {
    "build": "rollup -c",
    "dev": "rollup -c -w",
    "test": "vitest",
    "typecheck": "tsc --noEmit",
    "prepublishOnly": "pnpm build && pnpm test"
  },
  "peerDependencies": {
    "react": ">=16.8.0",
    "react-dom": ">=16.8.0"
  },
  "devDependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  }
}
```

### Micro-frontend Architecture
```yaml
# pnpm-workspace.yaml
packages:
  - 'shell'
  - 'microfrontends/*'
  - 'shared/*'
```

```json
{
  "name": "@company/shell",
  "dependencies": {
    "@company/shared-ui": "workspace:*",
    "@company/shared-utils": "workspace:*",
    "single-spa": "^6.0.0"
  }
}
```

## Environment-Specific Configuration

### Development
```ini
# .npmrc (development)
prefer-workspace-packages=true
auto-install-peers=true
strict-peer-dependencies=false
enable-pre-post-scripts=true
```

### Production
```ini
# .npmrc (production)
production-only=true
ignore-scripts=true
prefer-offline=true
package-import-method=copy
```

### CI Environment
```bash
# CI-specific configuration
pnpm config set store-dir .pnpm-store
pnpm config set verify-store-integrity true
pnpm config set frozen-lockfile true
```

## Common Issues & Solutions

### Store Corruption
**Problem**: pnpm store becomes corrupted
**Solution**: Rebuild store and verify integrity
```bash
# Clear store and reinstall
pnpm store prune
rm -rf node_modules
pnpm install --verify-store-integrity

# Force store verification
pnpm config set verify-store-integrity true
```

### Peer Dependency Issues
**Problem**: Peer dependency warnings or conflicts
**Solution**: Configure peer dependency rules
```json
{
  "pnpm": {
    "peerDependencyRules": {
      "ignoreMissing": ["@babel/core"],
      "allowedVersions": {
        "react": "18"
      }
    }
  }
}
```

### Workspace Resolution Issues
**Problem**: Workspace packages not resolving correctly
**Solution**: Check workspace configuration and paths
```bash
# Verify workspace configuration
pnpm list --filter="./packages/*"

# Check workspace setup
pnpm why @company/shared

# Rebuild workspace links
rm -rf node_modules
pnpm install
```

### Performance Issues
**Problem**: Slow installation or high memory usage
**Solution**: Optimize configuration and use appropriate flags
```bash
# Optimize for performance
pnpm config set side-effects-cache true
pnpm config set package-import-method hardlink
pnpm install --prefer-offline --no-optional
```

## Integration with Development Tools

### VS Code Integration
```json
{
  "typescript.preferences.includePackageJsonAutoImports": "on",
  "typescript.suggest.autoImports": true,
  "npm.packageManager": "pnpm",
  "pnpm.enable": true
}
```

### ESLint Configuration
```javascript
module.exports = {
  root: true,
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.jsx', '.ts', '.tsx'],
      },
    },
  },
  rules: {
    'import/no-extraneous-dependencies': [
      'error',
      {
        packageDir: [__dirname, path.join(__dirname, '../')],
      },
    ],
  },
}
```

### TypeScript Configuration
```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@company/*": ["packages/*/src"],
      "@shared/*": ["shared/*/src"]
    }
  },
  "references": [
    { "path": "./packages/ui" },
    { "path": "./packages/utils" },
    { "path": "./apps/frontend" }
  ]
}
```

## Useful Resources
- **Official Documentation**: https://pnpm.io/
- **CLI Reference**: https://pnpm.io/cli/add
- **Workspace Guide**: https://pnpm.io/workspaces
- **Configuration**: https://pnpm.io/npmrc
- **Migration Guide**: https://pnpm.io/migration
- **Benchmarks**: https://pnpm.io/benchmarks

## Tool-Specific Guidelines

### Best Practices
- Always use pnpm-lock.yaml for reproducible builds
- Configure workspace packages for monorepo projects
- Use workspace: protocol for internal dependencies
- Enable auto-install-peers for better dependency management
- Regular store maintenance with `pnpm store prune`

### Performance Tips
- Use hardlinks for faster installations
- Enable side effects cache for repeated installs
- Use --prefer-offline for development
- Configure store on fast storage (SSD)
- Use --frozen-lockfile in CI environments

### Security Considerations
- Regular security audits with `pnpm audit`
- Use overrides for security patches
- Pin critical dependency versions
- Review peer dependency rules carefully
- Keep pnpm updated for latest security fixes

## Version Compatibility
- **Node.js**: 16.14+ (minimum), 18+ (recommended)
- **pnpm**: 8.6+ (stable), 8.15+ (latest)
- **npm scripts**: Full compatibility with npm scripts
- **Workspace**: Compatible with npm/yarn workspace patterns

## Troubleshooting

### Debug Mode
```bash
# Enable debug logging
pnpm --loglevel=debug install

# Verbose output
pnpm install --verbose

# Check configuration
pnpm config list
pnpm config list --global

# Store diagnostics
pnpm store status
pnpm store prune --dry-run
```

### Common Error Messages
- **Error**: `ERR_PNPM_PEER_DEP_ISSUES`
  **Cause**: Peer dependency conflicts
  **Solution**: Configure peerDependencyRules or install missing peers

- **Error**: `ERR_PNPM_TARBALL_EXTRACT`
  **Cause**: Corrupted download or store
  **Solution**: Clear cache and reinstall: `pnpm store prune && pnpm install`

- **Error**: `ERR_PNPM_NO_MATCHING_VERSION`
  **Cause**: Version constraint cannot be satisfied
  **Solution**: Check version ranges and update constraints
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
