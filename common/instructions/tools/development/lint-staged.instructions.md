---
title: 'Lint-staged Pre-commit File Processing Instructions'
description: 'Comprehensive guide for using lint-staged to run linters and formatters on Git staged files for optimal development workflow performance'
category: 'Development Tools'

tags:
  [
    'lint-staged',
    'pre-commit',
    'linting',
    'formatting',
    'git-hooks',
    'husky',
    'performance',
    'code-quality',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/package.json'
  - '**/.lintstagedrc*'
  - '**/lint-staged.config.*'
  - '**/.husky/**'
  - '**/.*ignore'
---

# Lint-staged Pre-commit File Processing Instructions

## Tool Overview

- **Tool Name**: lint-staged
- **Version**: 15.0+ (Latest stable with improved performance and ESM support)
- **Category**: Development Tools - Code Quality Automation
- **Purpose**: Runs linters and formatters only on Git staged files to optimize pre-commit hook performance
- **Prerequisites**: Git, Node.js 18+, npm/yarn/pnpm, Git hooks system (Husky recommended)

## When to Use Lint-staged

### ✅ **Use Lint-staged When**

- Working with projects that have linting and formatting tools (ESLint, Prettier, etc.)
- Need to optimize pre-commit hook performance by processing only changed files
- Want to ensure code quality without slowing down development workflow
- Working in team environments requiring consistent code formatting standards
- Integrating multiple code quality tools that should run on specific file types
- Using pre-commit hooks and want to avoid processing entire codebase repeatedly
- Need conditional tool execution based on file types and patterns
- Want to prevent linting issues from being committed to repository

### ❌ **Avoid Lint-staged When**

- Project has no linting or formatting tools configured
- Working with very small codebases where full project linting is fast enough
- Need to run tools that require full project context (some type checkers)
- Working with monorepos where file relationships make selective processing problematic
- Using tools that don't support file-specific execution
- Team prefers post-commit or CI-only quality checks

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | Lint-staged Recommendation                       | Configuration Priority           |
| ---------------------- | ------------------------------------------------ | -------------------------------- |
| Large Codebase         | ✅ **Essential** - Major performance benefit     | High - Full tool integration     |
| Team Development       | ✅ **Essential** - Consistent quality gates      | High - Comprehensive linting     |
| Open Source Project    | ✅ **Recommended** - Contributor experience      | Medium - Standard patterns       |
| Monorepo               | 🔄 **Consider** - Complex file dependencies      | Medium - Selective configuration |
| Small Personal Project | 🔄 **Consider** - May be overkill                | Low - Basic formatting only      |
| Legacy Codebase        | ✅ **Recommended** - Gradual quality improvement | Medium - Incremental adoption    |

### Performance Impact Assessment

| Factor                  | Low Impact           | Medium Impact                 | High Impact                   |
| ----------------------- | -------------------- | ----------------------------- | ----------------------------- |
| **Codebase Size**       | <1k files            | 1k-10k files                  | 10k+ files                    |
| **Tool Count**          | 1-2 tools (Prettier) | 3-4 tools (ESLint + Prettier) | 5+ tools (Full quality stack) |
| **File Types**          | Single language      | 2-3 languages                 | Multiple languages            |
| **Hook Execution Time** | <5 seconds savings   | 5-30 seconds savings          | 30+ seconds savings           |

## Installation & Setup

### Package Manager Installation

```bash
# npm installation (recommended for most projects)
npm install lint-staged --save-dev

# yarn installation
yarn add lint-staged --dev

# pnpm installation
pnpm add lint-staged --save-dev

# Global installation (for CLI usage)
npm install -g lint-staged

# Verify installation
npx lint-staged --version
```

### Project Integration with Husky

```bash
# Install Husky and lint-staged together
npm install husky lint-staged --save-dev

# Initialize Husky
npx husky init

# Create pre-commit hook with lint-staged
echo "npx lint-staged" > .husky/pre-commit
chmod +x .husky/pre-commit

# Test the setup
git add .
git commit -m "test: verify lint-staged setup"
```

### Manual Hook Integration

```bash
# Create .git/hooks/pre-commit manually
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/sh
npx lint-staged
EOF

chmod +x .git/hooks/pre-commit

# Alternative: using git config
git config core.hooksPath .githooks
mkdir .githooks
echo "npx lint-staged" > .githooks/pre-commit
chmod +x .githooks/pre-commit
```

## Configuration

### Package.json Configuration

```json
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
    "*.{css,scss,less}": ["stylelint --fix", "prettier --write"],
    "*.{json,md,yaml,yml}": ["prettier --write"],
    "*.{png,jpg,jpeg,gif,svg}": ["imagemin-lint-staged"]
  },
  "scripts": {
    "lint-staged": "lint-staged",
    "precommit": "lint-staged"
  },
  "devDependencies": {
    "lint-staged": "^15.0.0",
    "husky": "^9.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0"
  }
}
```

### Dedicated Configuration File (.lintstagedrc.json)

```json
{
  "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write", "git add"],
  "*.{css,scss,less,styl}": ["stylelint --fix", "prettier --write", "git add"],
  "*.{json,md,mdx,yaml,yml}": ["prettier --write", "git add"],
  "*.{js,jsx,ts,tsx}": ["jest --bail --findRelatedTests --passWithNoTests"],
  "package.json": ["npm audit fix", "sort-package-json", "git add"]
}
```

### JavaScript Configuration (lint-staged.config.js)

```javascript
module.exports = {
  // JavaScript/TypeScript files
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix',
    'prettier --write',
    // Run tests for related files
    'jest --bail --findRelatedTests --passWithNoTests',
  ],

  // Stylesheet files
  '*.{css,scss,less,styl}': ['stylelint --fix', 'prettier --write'],

  // Documentation and config files
  '*.{json,md,mdx,yaml,yml}': ['prettier --write'],

  // Python files (if using Python tools)
  '*.py': ['black', 'isort', 'flake8'],

  // Conditional processing based on file patterns
  '*.{png,jpg,jpeg,gif,svg}': (filenames) => {
    // Only run image optimization on files larger than 10KB
    return filenames
      .filter((filename) => {
        const stats = require('fs').statSync(filename);
        return stats.size > 10240; // 10KB
      })
      .map((filename) => `imagemin ${filename} --out-dir=optimized/`);
  },

  // Environment-specific configuration
  '*.{js,ts}':
    process.env.NODE_ENV === 'production'
      ? ['eslint --fix', 'prettier --write', 'npm run test:unit']
      : ['eslint --fix', 'prettier --write'],
};
```

### Advanced Configuration with Functions

```javascript
// lint-staged.config.js - Advanced configuration
const path = require('path');

module.exports = {
  // Dynamic command generation
  '*.{js,jsx,ts,tsx}': (filenames) => {
    const commands = [];

    // ESLint with specific config based on file location
    commands.push(
      filenames
        .map((filename) => {
          const isTestFile = filename.includes('.test.') || filename.includes('.spec.');
          const config = isTestFile ? '.eslintrc.test.js' : '.eslintrc.js';
          return `eslint --config ${config} --fix ${filename}`;
        })
        .join(' && '),
    );

    // Prettier formatting
    commands.push(`prettier --write ${filenames.join(' ')}`);

    // Type checking for TypeScript files
    const tsFiles = filenames.filter((file) => file.endsWith('.ts') || file.endsWith('.tsx'));
    if (tsFiles.length > 0) {
      commands.push('npx tsc --noEmit');
    }

    // Run related tests
    commands.push(`jest --bail --findRelatedTests ${filenames.join(' ')} --passWithNoTests`);

    return commands;
  },

  // CSS/SCSS with conditional Sass compilation
  '*.{css,scss}': (filenames) => {
    const commands = ['stylelint --fix', 'prettier --write'];

    const scssFiles = filenames.filter((file) => file.endsWith('.scss'));
    if (scssFiles.length > 0) {
      commands.push('npm run build:css');
    }

    return commands.concat(filenames.map((f) => `git add ${f}`));
  },

  // Package.json validation and sorting
  'package.json': ['npm audit fix --force', 'sort-package-json', 'prettier --write', 'git add'],

  // Documentation with link checking
  '*.md': ['markdownlint --fix', 'prettier --write', 'markdown-link-check'],
};
```

## Core Features

### Selective File Processing

- **Purpose**: Processes only Git staged files instead of entire project
- **Usage**: Automatically detects staged files and applies tools selectively
- **Example**:

```bash
# Only runs on staged files
git add src/component.js src/styles.css
npx lint-staged  # Only processes these 2 files

# Compared to full project processing
eslint src/         # Processes all files in src/
prettier --write src/**/*  # Processes all files
```

### Pattern-based Tool Execution

- **Purpose**: Runs different tools based on file patterns and extensions
- **Usage**: Configures specific tools for specific file types
- **Example**:

```json
{
  "*.js": ["eslint --fix"],
  "*.css": ["stylelint --fix"],
  "*.md": ["markdownlint --fix"],
  "*.{png,jpg}": ["imagemin-lint-staged"]
}
```

### Command Chaining and Conditional Execution

- **Purpose**: Executes multiple commands in sequence with failure handling
- **Usage**: Chains linting, formatting, and testing in optimal order
- **Example**:

```javascript
// Commands run in sequence, stop on first failure
'*.js': [
  'eslint --fix',        // Fix linting issues first
  'prettier --write',    // Format code
  'git add',             // Stage the fixed files
  'jest --findRelatedTests'  // Run related tests
]
```

### Dynamic Command Generation

- **Purpose**: Generates commands dynamically based on file content or conditions
- **Usage**: Advanced scenarios requiring conditional processing logic
- **Example**:

```javascript
'*.js': (filenames) => {
  const testFiles = filenames.filter(f => f.includes('.test.'));
  const sourceFiles = filenames.filter(f => !f.includes('.test.'));

  const commands = [];
  if (sourceFiles.length > 0) {
    commands.push(`eslint --fix ${sourceFiles.join(' ')}`);
  }
  if (testFiles.length > 0) {
    commands.push(`jest --bail ${testFiles.join(' ')}`);
  }

  return commands;
}
```

## Common Commands

```bash
# Essential daily commands
npx lint-staged                      # Run on staged files
npx lint-staged --debug              # Debug mode with verbose output
npx lint-staged --verbose            # Verbose output
npx lint-staged --dry-run            # Preview what would run

# Configuration and testing
npx lint-staged --config=.lintstagedrc.json  # Use specific config
npx lint-staged --allow-empty         # Allow execution with no staged files
npx lint-staged --no-stash            # Don't stash unstaged changes

# Advanced operations
npx lint-staged --shell               # Use shell for command execution
npx lint-staged --quiet               # Minimal output
npx lint-staged --concurrent false    # Disable concurrent execution

# Integration commands
git add file.js && npx lint-staged    # Manual staging and processing
husky add .husky/pre-commit "npx lint-staged"  # Husky integration
```

## Workflow Integration

### Development Workflow

1. **Setup**: Install lint-staged and configure file patterns with appropriate tools
2. **Development**: Make changes to files as usual during development
3. **Staging**: Use `git add` to stage files for commit
4. **Validation**: lint-staged automatically runs on commit, processing only staged files
5. **Commit**: If all checks pass, commit succeeds; otherwise, fix issues and retry

### Team Development Workflow

```bash
# Team setup workflow
npm install lint-staged husky eslint prettier --save-dev

# Configure lint-staged in package.json
cat > package.json << 'EOF'
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": [
      "eslint --fix",
      "prettier --write"
    ],
    "*.{css,scss}": [
      "stylelint --fix",
      "prettier --write"
    ]
  }
}
EOF

# Set up pre-commit hook
npx husky init
echo "npx lint-staged" > .husky/pre-commit
chmod +x .husky/pre-commit

# Commit the configuration
git add .
git commit -m "feat: add lint-staged for code quality automation"
```

### CI/CD Integration

```yaml
# .github/workflows/quality.yml
name: Code Quality
on: [push, pull_request]

jobs:
  lint-staged-validation:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0  # Full history for proper diff

      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci

      # Simulate lint-staged behavior in CI
      - name: Get changed files
        id: changed-files
        run: |
          if [ "${{ github.event_name }}" = "pull_request" ]; then
            echo "files=$(git diff --name-only ${{ github.event.pull_request.base.sha }} ${{ github.sha }} | tr '
' ' ')" >> $GITHUB_OUTPUT
          else
            echo "files=$(git diff --name-only HEAD~1 HEAD | tr '
' ' ')" >> $GITHUB_OUTPUT
          fi

      - name: Run lint-staged on changed files
        if: steps.changed-files.outputs.files != ''
        run: |
          # Set up staged files simulation
          echo "${{ steps.changed-files.outputs.files }}" | xargs git add
          npx lint-staged
```

### Monorepo Integration

```javascript
// lint-staged.config.js for monorepo
const path = require('path');

module.exports = {
  // Frontend package
  'packages/frontend/**/*.{js,jsx,ts,tsx}': [
    'eslint --config packages/frontend/.eslintrc.js --fix',
    'prettier --config packages/frontend/.prettierrc --write',
    'jest --config packages/frontend/jest.config.js --findRelatedTests',
  ],

  // Backend package
  'packages/backend/**/*.{js,ts}': [
    'eslint --config packages/backend/.eslintrc.js --fix',
    'prettier --config packages/backend/.prettierrc --write',
    'jest --config packages/backend/jest.config.js --findRelatedTests',
  ],

  // Shared utilities
  'packages/shared/**/*.{js,ts}': [
    'eslint --config packages/shared/.eslintrc.js --fix',
    'prettier --write',
    'npm run test:shared',
  ],

  // Root level configuration files
  'package.json': ['sort-package-json', 'prettier --write'],
  'packages/*/package.json': ['sort-package-json', 'prettier --write'],

  // Documentation
  '*.md': ['markdownlint --fix', 'prettier --write'],
  'docs/**/*.md': ['markdownlint --config docs/.markdownlint.json --fix'],
};
```

## Best Practices

### ✅ **Configuration Best Practices**

- **Use specific file patterns** - Target exact file types to avoid unnecessary processing
- **Order commands logically** - Run linting before formatting, formatting before testing
- **Include git add carefully** - Only add files that tools have modified
- **Configure tool-specific settings** - Use project-specific configurations for each tool
- **Handle failures gracefully** - Ensure commands fail fast and provide clear error messages
- **Use concurrent execution** - Enable parallel processing for independent operations

### ✅ **Performance Optimization**

- **Minimize tool overlap** - Avoid running multiple tools that perform similar functions
- **Use incremental tools** - Prefer tools that support file-specific operation modes
- **Leverage caching** - Configure tools to use caching when available
- **Optimize test selection** - Use --findRelatedTests to run only relevant tests
- **Group similar operations** - Batch similar file types together for efficiency
- **Profile execution time** - Monitor and optimize slow-running commands

### ✅ **Team Collaboration**

- **Document configuration** - Include clear README instructions for setup
- **Standardize tool versions** - Lock tool versions in package.json for consistency
- **Provide bypass mechanisms** - Allow emergency commits with --no-verify when needed
- **Share configuration files** - Commit lint-staged config to ensure team alignment
- **Test hook setup** - Verify hooks work properly across different development environments
- **Handle editor integration** - Ensure lint-staged works with various IDEs and editors

### ❌ **Common Pitfalls to Avoid**

- **Don't run full project tests** - Use targeted testing to maintain performance benefits
- **Avoid git add in production** - Be careful with automatic staging in CI environments
- **Don't ignore tool exit codes** - Ensure lint-staged properly handles tool failures
- **Avoid conflicting tool configurations** - Ensure ESLint and Prettier configurations are compatible
- **Don't skip error handling** - Provide meaningful error messages for debugging
- **Avoid overly complex patterns** - Keep file patterns simple and maintainable

## Advanced Lint-staged Usage

### Conditional Processing Based on Environment

```javascript
// lint-staged.config.js - Environment-aware configuration
const isProduction = process.env.NODE_ENV === 'production';
const isCi = process.env.CI === 'true';

module.exports = {
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix',
    'prettier --write',
    // Only run tests in non-CI environments
    ...(isCi ? [] : ['jest --bail --findRelatedTests --passWithNoTests']),
    // Only run type checking in production builds
    ...(isProduction ? ['tsc --noEmit'] : []),
  ],

  '*.{css,scss}': [
    'stylelint --fix',
    'prettier --write',
    // Only optimize CSS in production
    ...(isProduction ? ['postcss --use autoprefixer --replace'] : []),
  ],

  // Only run expensive operations in CI
  '*.{png,jpg,jpeg}': isCi
    ? ['imagemin-cli --plugin=imagemin-mozjpeg --plugin=imagemin-pngquant']
    : [],
};
```

### Custom Tool Integration

```javascript
// lint-staged.config.js - Custom tools and scripts
module.exports = {
  // Custom script for API documentation
  'src/api/**/*.js': [
    'eslint --fix',
    'prettier --write',
    'node scripts/generate-api-docs.js',
    'git add docs/api/',
  ],

  // Custom validation for configuration files
  '*.{json,yaml,yml}': (filenames) => {
    const commands = ['prettier --write'];

    filenames.forEach((filename) => {
      if (filename.endsWith('.json')) {
        commands.push(`node scripts/validate-json.js ${filename}`);
      }
      if (filename.includes('docker-compose')) {
        commands.push(`docker-compose -f ${filename} config`);
      }
    });

    return commands;
  },

  // Database migration validation
  'migrations/**/*.sql': ['node scripts/validate-migration.js', 'sql-formatter --fix'],

  // License header enforcement
  'src/**/*.{js,ts}': ['node scripts/add-license-header.js', 'eslint --fix', 'prettier --write'],
};
```

### Multi-stage Processing

```javascript
// lint-staged.config.js - Multi-stage processing pipeline
const { ESLint } = require('eslint');

module.exports = {
  // Stage 1: Fast checks (syntax, basic linting)
  '*.{js,jsx,ts,tsx}': async (filenames) => {
    const eslint = new ESLint({ fix: true });

    // Quick syntax check first
    const results = await eslint.lintFiles(filenames);
    const hasErrors = results.some((result) => result.errorCount > 0);

    if (hasErrors) {
      // If there are errors, only run basic fixes
      return ['eslint --fix --quiet', 'prettier --write'];
    } else {
      // If no errors, run full pipeline
      return [
        'eslint --fix',
        'prettier --write',
        'jest --bail --findRelatedTests --passWithNoTests',
        'npm run type-check',
      ];
    }
  },

  // Stage 2: Asset optimization (runs after main checks)
  '*.{png,jpg,jpeg,gif,svg}': ['imagemin-lint-staged', 'node scripts/update-asset-manifest.js'],
};
```

## Integration with Other Tools

### Husky Integration

```bash
# Complete Husky + lint-staged setup
npm install husky lint-staged --save-dev

# Initialize Husky
npx husky init

# Create pre-commit hook
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Run lint-staged
npx lint-staged

# Additional checks
npm run type-check
EOF

chmod +x .husky/pre-commit

# Create pre-push hook for comprehensive checks
cat > .husky/pre-push << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Run full test suite before push
npm run test:coverage
npm run build
EOF

chmod +x .husky/pre-push
```

### ESLint and Prettier Integration

```json
// package.json - Coordinated tool configuration
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix --max-warnings=0", "prettier --write", "git add"]
  },
  "eslintConfig": {
    "extends": ["eslint:recommended", "@typescript-eslint/recommended", "prettier"],
    "plugins": ["prettier"],
    "rules": {
      "prettier/prettier": "error"
    }
  },
  "prettier": {
    "semi": true,
    "singleQuote": true,
    "trailingComma": "es5",
    "tabWidth": 2
  }
}
```

### Jest Testing Integration

```javascript
// lint-staged.config.js - Advanced Jest integration
module.exports = {
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix',
    'prettier --write',
    // Smart test execution
    (filenames) => {
      const testFiles = filenames.filter((f) => f.includes('.test.') || f.includes('.spec.'));
      const sourceFiles = filenames.filter((f) => !f.includes('.test.') && !f.includes('.spec.'));

      const commands = [];

      // Run test files directly
      if (testFiles.length > 0) {
        commands.push(`jest ${testFiles.join(' ')} --passWithNoTests`);
      }

      // Find and run tests related to source files
      if (sourceFiles.length > 0) {
        commands.push(`jest --findRelatedTests ${sourceFiles.join(' ')} --passWithNoTests`);
      }

      return commands;
    },
  ],
};
```

### Stylelint Integration

```json
{
  "lint-staged": {
    "*.{css,scss,less}": ["stylelint --fix", "prettier --write"]
  },
  "stylelint": {
    "extends": ["stylelint-config-standard", "stylelint-config-prettier"],
    "rules": {
      "property-no-unknown": true,
      "selector-class-pattern": "^[a-z][a-zA-Z0-9]*$"
    }
  }
}
```

## Troubleshooting

### Common Issues

#### Commands Not Running on Staged Files

**Problem**: lint-staged appears to run but doesn't process any files
**Symptoms**: No output or "No staged files found" message
**Solution**:

```bash
# Check if files are actually staged
git status --porcelain

# Stage files manually
git add file.js

# Check lint-staged configuration
npx lint-staged --debug

# Verify file patterns match staged files
npx lint-staged --dry-run --verbose
```

#### Tool Exit Code Issues

**Problem**: lint-staged fails with non-zero exit codes from tools
**Symptoms**: Pre-commit hook fails even when tools appear to run successfully
**Solution**:

```javascript
// Handle tools that return non-zero exit codes
module.exports = {
  '*.js': [
    'eslint --fix --max-warnings=0', // Fail on warnings
    'prettier --write --check', // Check formatting after write
  ],

  // Alternative: ignore exit codes for specific tools
  '*.css': 'stylelint --fix || true', // Continue even if stylelint fails
};
```

#### Performance Issues with Large Files

**Problem**: lint-staged takes too long on large codebases or files
**Symptoms**: Pre-commit hooks timeout or take several minutes
**Solution**:

```javascript
// Optimize for performance
module.exports = {
  '*.{js,ts}': [
    'eslint --fix --cache', // Use ESLint cache
    'prettier --write --cache', // Use Prettier cache
  ],

  // Skip large files
  '*.js': (filenames) => {
    const fs = require('fs');
    const smallFiles = filenames.filter((f) => {
      const stats = fs.statSync(f);
      return stats.size < 100000; // Skip files > 100KB
    });
    return `eslint --fix ${smallFiles.join(' ')}`;
  },
};
```

#### Git Add Issues

**Problem**: Modified files not being properly staged after tool modifications
**Symptoms**: Changes made by tools not included in commit
**Solution**:

```json
{
  "lint-staged": {
    "*.js": [
      "eslint --fix",
      "prettier --write",
      "git add" // Ensure modified files are staged
    ]
  }
}
```

### Debug Mode

```bash
# Enable comprehensive debugging
npx lint-staged --debug --verbose

# Check what commands would run
npx lint-staged --dry-run

# Test with specific files
git add specific-file.js
npx lint-staged --debug

# Verify configuration loading
npx lint-staged --help
npx lint-staged --print-config
```

### Performance Optimization

```javascript
// Optimized configuration for large projects
module.exports = {
  // Use concurrency for independent operations
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix --cache --cache-location .eslintcache',
    'prettier --write --cache',
  ],

  // Separate CPU-intensive operations
  '*.{css,scss}': 'stylelint --fix --cache',

  // Group similar operations
  '*.{json,md,yaml}': 'prettier --write',

  // Use shell commands for complex operations
  'package*.json': 'sort-package-json && npm audit fix --force || true',

  // Conditional expensive operations
  '*.{png,jpg,jpeg}': (filenames) => {
    if (process.env.OPTIMIZE_IMAGES === 'true') {
      return `imagemin ${filenames.join(' ')} --out-dir=optimized/`;
    }
    return [];
  },
};
```

## Security Considerations

### Security Best Practices

- **Validate tool commands** - Ensure all tools and scripts used are trusted and validated
- **Limit file access** - Configure tools to only access necessary files and directories
- **Avoid shell injection** - Use array syntax instead of string concatenation for commands
- **Control tool execution** - Restrict which tools can be executed and their parameters
- **Audit dependencies** - Regularly audit lint-staged and tool dependencies for vulnerabilities
- **Secure configuration** - Protect configuration files from unauthorized modification

### Safe Command Execution

```javascript
// Secure command configuration
module.exports = {
  // Use array syntax to prevent shell injection
  '*.js': ['eslint --fix', 'prettier --write'],

  // Avoid dynamic command generation with user input
  // BAD: `eslint ${userInput}`
  // GOOD: predefined commands only

  // Validate file paths
  '*.js': (filenames) => {
    const safePaths = filenames.filter((f) => !f.includes('..') && f.startsWith('src/'));
    return [`eslint --fix ${safePaths.join(' ')}`];
  },
};
```

### Sensitive Data Protection

```javascript
// Prevent processing of sensitive files
module.exports = {
  // Exclude sensitive file patterns
  '*.{js,ts}': ['eslint --fix', 'prettier --write'],

  // Explicitly exclude sensitive patterns
  '!.env*': [],
  '!**/secrets/**': [],
  '!**/node_modules/**': [],

  // Validate against sensitive patterns
  '*': (filenames) => {
    const sensitivePatterns = ['.env', 'secret', 'password', 'key'];
    const hasSensitiveFiles = filenames.some((f) =>
      sensitivePatterns.some((pattern) => f.includes(pattern)),
    );

    if (hasSensitiveFiles) {
      throw new Error('Sensitive files detected in staging area');
    }

    return [];
  },
};
```

## AI Assistant Guidelines

When helping with lint-staged:

1. **Always suggest lint-staged 15.0+** for optimal performance and modern feature support
2. **Provide complete Husky integration** examples for seamless Git hook setup
3. **Include performance optimization** techniques for large codebases and teams
4. **Suggest tool-specific configurations** that work well together (ESLint + Prettier)
5. **Provide debugging strategies** for common setup and execution issues
6. **Include monorepo considerations** for complex project structures
7. **Reference security best practices** for safe command execution and file handling
8. **Suggest CI/CD integration patterns** that complement local lint-staged workflows

### Code Generation Rules

- Generate lint-staged configurations that use array syntax for security
- Include appropriate file patterns that match common project structures
- Provide error handling and fallback strategies for tool failures
- Include performance optimizations like caching and selective processing
- Follow conventional patterns for tool ordering (lint → format → test)
- Generate cross-platform compatible configurations and commands
- Include debugging and troubleshooting guidance for generated configurations
- Provide integration examples with popular development tools and workflows

## Installation & Setup

### Package Manager Installation

```bash
# npm/yarn installation
npm install -g [tool-name]
# or
yarn global add [tool-name]

# pip installation
pip install [tool-name]

# homebrew installation (macOS)
brew install [tool-name]

# Other platform-specific commands
[other installation methods]
```

### Project Integration

```bash
# Initialize in project
[tool] init

# Add to existing project
[project setup commands]
```

## Configuration

### Configuration File

```[config-format]
# [config-file-name] (e.g., .toolrc, tool.config.js, tool.yaml)
[configuration-example]
```

### Environment Variables

```bash
# Environment-specific settings
[TOOL_ENV_VAR]=[value]
[TOOL_CONFIG_PATH]=[path]
```

### CLI Configuration

```bash
# Global configuration
[tool] config set [option] [value]

# Project-specific configuration
[tool] config --local [option] [value]
```

## Core Features

### [Feature 1]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 2]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 3]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

## Common Commands

```bash
# Essential daily commands
[tool] [basic-command]              # Description
[tool] [frequent-command] [options] # Description
[tool] [status-command]             # Check status
[tool] [help-command]               # Get help

# Advanced operations
[tool] [advanced-command] [options] # Description
[tool] [config-command]             # Configuration management
[tool] [debug-command]              # Debugging and troubleshooting
```

## Workflow Integration

### Development Workflow

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
