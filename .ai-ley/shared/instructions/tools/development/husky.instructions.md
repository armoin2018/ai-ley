---
title: 'Husky Git Hooks Management Tool Instructions'
description: 'Comprehensive guide for using Husky to manage Git hooks, automate code quality checks, and enforce development workflow standards'
category: 'Development Tools'

tags:
  [
    'husky',
    'git-hooks',
    'code-quality',
    'pre-commit',
    'development-workflow',
    'automation',
    'lint-staged',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/.husky/**'
  - '**/package.json'
  - '**/.huskyrc*'
  - '**/husky.config.*'
  - '**/.gitignore'
---

# Husky Git Hooks Management Tool Instructions

## Tool Overview

- **Tool Name**: Husky
- **Version**: 9.0+ (Latest stable with improved performance)
- **Category**: Development Tools - Git Hooks Management
- **Purpose**: Simplifies Git hooks management to enforce code quality and development workflow standards
- **Prerequisites**: Git 2.13+, Node.js 18+, npm/yarn/pnpm package manager

## When to Use Husky

### ✅ **Use Husky When**

- Working in team environments requiring consistent code quality standards
- Need to automate code formatting, linting, and testing before commits
- Want to prevent bad commits from entering the repository
- Building projects requiring pre-commit, pre-push, or other Git hook automation
- Integrating with tools like ESLint, Prettier, Jest, TypeScript compilation
- Setting up continuous integration workflows with local validation
- Managing multiple developers with different development environment setups
- Need to enforce conventional commit messages or changelog generation
- Want to run security scans or dependency audits on code changes

### ❌ **Avoid Husky When**

- Working on solo projects where automation overhead isn't justified
- Git repository doesn't support hooks or has restrictions on hook execution
- Team strongly prefers manual code review processes without automation
- Performance is critical and hook execution time is unacceptable
- Working with legacy systems where Git hook setup is complex or impossible
- Repository has existing hook management that conflicts with Husky

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | Husky Recommendation                                 | Configuration Priority            |
| ---------------------- | ---------------------------------------------------- | --------------------------------- |
| Team Development       | ✅ **Essential** - Enforces standards across team    | High - Pre-commit + pre-push      |
| Open Source Project    | ✅ **Strongly Recommended** - Maintains code quality | High - Full workflow automation   |
| Enterprise Application | ✅ **Essential** - Security and compliance           | High - Security + quality checks  |
| Personal Project       | 🔄 **Consider** - Useful for good habits             | Medium - Basic pre-commit         |
| Legacy Codebase        | 🔄 **Consider** - Gradual adoption                   | Low - Start with formatting only  |
| CI/CD Pipeline         | ✅ **Recommended** - Local validation before remote  | Medium - Mirror CI checks locally |

### Complexity Assessment

| Factor                | Low Complexity           | Medium Complexity           | High Complexity                |
| --------------------- | ------------------------ | --------------------------- | ------------------------------ |
| **Setup Time**        | 10 minutes (basic hooks) | 30 minutes (multiple tools) | 2+ hours (custom scripts)      |
| **Team Size**         | 1-3 developers           | 4-10 developers             | 10+ developers                 |
| **Tools Integration** | ESLint + Prettier        | + Jest + TypeScript         | + Security + Custom validation |
| **Hook Types**        | Pre-commit only          | Pre-commit + pre-push       | Multiple Git hooks             |

## Installation & Setup

### Package Manager Installation

```bash
# npm installation (recommended for most projects)
npm install husky --save-dev

# yarn installation
yarn add husky --dev

# pnpm installation
pnpm add husky --save-dev

# Initialize Husky in existing project
npx husky init

# Alternative initialization for specific package managers
yarn dlx husky init
pnpm dlx husky init
```

### Project Integration

```bash
# Initialize Husky (creates .husky directory and installs Git hooks)
npx husky init

# Add your first hook (pre-commit example)
echo "npm test" > .husky/pre-commit

# Make hook executable (Unix/Linux/macOS)
chmod +x .husky/pre-commit

# Verify installation
ls -la .husky/
cat .husky/pre-commit
```

### Package.json Scripts Integration

```json
{
  "scripts": {
    "prepare": "husky",
    "lint": "eslint src/**/*.{js,ts,jsx,tsx}",
    "lint:fix": "eslint src/**/*.{js,ts,jsx,tsx} --fix",
    "format": "prettier --write src/**/*.{js,ts,jsx,tsx,css,md}",
    "format:check": "prettier --check src/**/*.{js,ts,jsx,tsx,css,md}",
    "test": "jest",
    "test:coverage": "jest --coverage",
    "type-check": "tsc --noEmit"
  },
  "devDependencies": {
    "husky": "^9.0.0",
    "lint-staged": "^15.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0",
    "jest": "^29.0.0"
  }
}
```

## Configuration

### Basic Hook Configuration

```bash
# .husky/pre-commit - Basic pre-commit hook
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run lint
npm run format:check
npm run test
```

### Advanced Pre-commit Hook

```bash
# .husky/pre-commit - Advanced with error handling
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🔍 Running pre-commit checks..."

# Run linting
echo "📝 Checking code style..."
npm run lint || {
  echo "❌ Linting failed. Please fix the issues above."
  exit 1
}

# Run Prettier formatting check
echo "🎨 Checking code formatting..."
npm run format:check || {
  echo "❌ Code formatting issues found. Run 'npm run format' to fix."
  exit 1
}

# Type checking for TypeScript projects
if [ -f "tsconfig.json" ]; then
  echo "📘 Type checking..."
  npm run type-check || {
    echo "❌ TypeScript type checking failed."
    exit 1
  }
fi

# Run tests
echo "🧪 Running tests..."
npm run test || {
  echo "❌ Tests failed. Please fix failing tests."
  exit 1
}

echo "✅ All pre-commit checks passed!"
```

### Pre-push Hook Configuration

```bash
# .husky/pre-push - Comprehensive pre-push validation
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🚀 Running pre-push checks..."

# Ensure all commits are properly formatted
echo "📋 Checking commit messages..."
npm run commitlint || {
  echo "❌ Commit message format is invalid."
  exit 1
}

# Run full test suite with coverage
echo "🧪 Running full test suite..."
npm run test:coverage || {
  echo "❌ Tests failed or coverage threshold not met."
  exit 1
}

# Security audit
echo "🔒 Running security audit..."
npm audit --audit-level moderate || {
  echo "⚠️  Security vulnerabilities found. Please review."
  # Don't exit on audit failures in development, but warn
}

# Build check
echo "🏗️ Checking build..."
npm run build || {
  echo "❌ Build failed."
  exit 1
}

echo "✅ All pre-push checks passed! Safe to push."
```

### Lint-staged Integration

```bash
# Install lint-staged for performance
npm install lint-staged --save-dev
```

```json
// package.json - lint-staged configuration
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
    "*.{css,scss,less}": ["prettier --write"],
    "*.{json,md,yaml,yml}": ["prettier --write"],
    "*.{js,jsx,ts,tsx}": ["jest --bail --findRelatedTests --passWithNoTests"]
  }
}
```

```bash
# .husky/pre-commit - Using lint-staged
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
```

### Commit Message Hook

```bash
# .husky/commit-msg - Enforce conventional commits
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx commitlint --edit "$1"
```

```javascript
// commitlint.config.js
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', // New feature
        'fix', // Bug fix
        'docs', // Documentation changes
        'style', // Code style changes (formatting, etc.)
        'refactor', // Code refactoring
        'test', // Adding or updating tests
        'chore', // Build process or auxiliary tool changes
        'perf', // Performance improvements
        'ci', // CI/CD changes
        'revert', // Reverting changes
      ],
    ],
    'subject-case': [2, 'never', ['start-case', 'pascal-case', 'upper-case']],
    'subject-max-length': [2, 'always', 100],
    'body-max-line-length': [2, 'always', 150],
  },
};
```

## Core Features

### Git Hook Automation

- **Purpose**: Automatically executes scripts at specific Git lifecycle events
- **Usage**: Enforces code quality standards before commits, pushes, or merges
- **Example**:

```bash
# Create pre-commit hook
echo "npm run lint && npm run test" > .husky/pre-commit
chmod +x .husky/pre-commit

# Create pre-push hook
echo "npm run build && npm run test:e2e" > .husky/pre-push
chmod +x .husky/pre-push
```

### Lint-staged Integration

- **Purpose**: Runs linting and formatting only on staged files for performance
- **Usage**: Speeds up pre-commit checks by processing only changed files
- **Example**:

```bash
# Install lint-staged
npm install lint-staged --save-dev

# Configure in package.json
{
  "lint-staged": {
    "*.{js,ts}": ["eslint --fix", "prettier --write"]
  }
}

# Update pre-commit hook
echo "npx lint-staged" > .husky/pre-commit
```

### Cross-platform Compatibility

- **Purpose**: Ensures hooks work across Windows, macOS, and Linux environments
- **Usage**: Provides consistent behavior regardless of development environment
- **Example**:

```bash
# .husky/pre-commit - Cross-platform script
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Works on all platforms
npm run lint
npm run test
```

### Hook Bypassing and Debugging

- **Purpose**: Allows temporary bypassing of hooks for emergency commits or debugging
- **Usage**: Provides escape mechanisms while maintaining normal workflow enforcement
- **Example**:

```bash
# Bypass hooks for emergency commit
git commit --no-verify -m "hotfix: critical security patch"

# Skip specific hook types
HUSKY_SKIP_HOOKS=1 git commit -m "skip all hooks"

# Debug hook execution
HUSKY_DEBUG=1 git commit -m "debug hook execution"
```

## Common Commands

```bash
# Essential daily commands
npx husky init                        # Initialize Husky in project
npx husky add .husky/pre-commit "npm test"  # Add pre-commit hook
npx husky --help                      # Get command help

# Hook management
chmod +x .husky/pre-commit           # Make hook executable
rm .husky/pre-commit                 # Remove hook
ls -la .husky/                       # List all hooks

# Testing and debugging
git commit -m "test" --dry-run       # Test commit without executing
git commit --no-verify -m "bypass"  # Bypass hooks for one commit
HUSKY_DEBUG=1 git commit -m "debug"  # Debug hook execution

# Advanced operations
npx husky uninstall                  # Uninstall Husky hooks
git config core.hooksPath .husky    # Verify hooks path
git config --unset core.hooksPath   # Reset hooks path
```

## Workflow Integration

### Development Workflow

1. **Setup**: Install Husky and configure initial hooks for code quality
2. **Development**: Automatic validation runs on every commit and push
3. **Team Onboarding**: New developers automatically get hooks via npm install
4. **Quality Assurance**: Consistent standards enforced across all contributors
5. **CI/CD**: Local validation mirrors remote pipeline checks

### Team Setup Workflow

```bash
# Team lead setup
npm install husky lint-staged --save-dev
npx husky init

# Create comprehensive pre-commit hook
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🔍 Running pre-commit validation..."

# Lint staged files
npx lint-staged

# Type check
if [ -f "tsconfig.json" ]; then
  npm run type-check
fi

echo "✅ Pre-commit validation passed!"
EOF

chmod +x .husky/pre-commit

# Create pre-push hook
cat > .husky/pre-push << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🚀 Running pre-push validation..."

# Full test suite
npm run test

# Build verification
npm run build

echo "✅ Pre-push validation passed!"
EOF

chmod +x .husky/pre-push

# Commit configuration
git add .
git commit -m "feat: add Husky Git hooks for code quality"
```

### New Developer Onboarding

```bash
# New developer workflow
git clone <repository>
cd <project>
npm install  # Automatically sets up Husky hooks

# Verify hooks are installed
ls -la .husky/
git config core.hooksPath  # Should show .husky

# Make first commit (hooks will run automatically)
echo "# Test" >> README.md
git add README.md
git commit -m "docs: test commit with hooks"
```

### CI/CD Integration

```yaml
# .github/workflows/validate.yml
name: Code Quality
on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci

      # Run the same checks as local hooks
      - name: Lint code
        run: npm run lint

      - name: Check formatting
        run: npm run format:check

      - name: Type check
        run: npm run type-check

      - name: Run tests
        run: npm run test:coverage

      - name: Build project
        run: npm run build
```

## Best Practices

### ✅ **Configuration Best Practices**

- **Keep hooks fast** - Use lint-staged to process only changed files
- **Make hooks informative** - Add clear echo statements showing progress
- **Handle errors gracefully** - Provide helpful error messages and exit codes
- **Use consistent formatting** - Follow team conventions for hook scripts
- **Document hook behavior** - Include README sections explaining what hooks do
- **Test hooks thoroughly** - Verify hook behavior across different scenarios

### ✅ **Performance Optimization**

- **Use lint-staged** for file-specific operations to reduce execution time
- **Cache dependencies** in CI/CD to speed up hook validation
- **Parallelize independent checks** where possible using concurrent execution
- **Skip heavy operations** in development hooks, save for pre-push or CI
- **Use incremental builds** and testing for faster feedback loops
- **Monitor hook execution time** and optimize slow operations

### ✅ **Team Collaboration**

- **Establish clear bypass policies** for emergency commits with --no-verify
- **Document hook requirements** in project README and contributing guidelines
- **Provide debugging instructions** for when hooks fail unexpectedly
- **Use conventional commit messages** with commitlint for consistency
- **Share hook configurations** via version control for team alignment
- **Handle cross-platform differences** in hook scripts and dependencies

### ❌ **Common Pitfalls to Avoid**

- **Don't make hooks too strict** - Balance quality with development velocity
- **Avoid platform-specific scripts** - Ensure hooks work on Windows, macOS, Linux
- **Don't skip hook testing** - Test hooks with various commit scenarios
- **Avoid blocking emergency commits** - Always provide bypass mechanisms
- **Don't ignore hook failures** - Address root causes rather than bypassing
- **Avoid over-engineering** - Start simple and add complexity as needed

## Advanced Hook Configurations

### Multi-stage Validation Hook

```bash
# .husky/pre-commit - Multi-stage with early exit
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "${YELLOW}🔍 Starting pre-commit validation...${NC}"

# Stage 1: Fast checks first
echo "${YELLOW}📝 Stage 1: Code style and formatting...${NC}"
npx lint-staged || {
  echo "${RED}❌ Code style checks failed${NC}"
  exit 1
}

# Stage 2: Type checking
if [ -f "tsconfig.json" ]; then
  echo "${YELLOW}📘 Stage 2: Type checking...${NC}"
  npm run type-check || {
    echo "${RED}❌ TypeScript type checking failed${NC}"
    exit 1
  }
fi

# Stage 3: Unit tests for changed files
echo "${YELLOW}🧪 Stage 3: Running related tests...${NC}"
npm run test:related || {
  echo "${RED}❌ Related tests failed${NC}"
  exit 1
}

# Stage 4: Security checks
echo "${YELLOW}🔒 Stage 4: Security scanning...${NC}"
npm audit --audit-level high || {
  echo "${YELLOW}⚠️  High-severity security issues found${NC}"
  echo "${YELLOW}Continue with caution or run 'npm audit fix'${NC}"
}

echo "${GREEN}✅ All pre-commit checks passed!${NC}"
```

### Conditional Hook Execution

```bash
# .husky/pre-commit - Conditional based on changed files
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Get list of changed files
CHANGED_FILES=$(git diff --cached --name-only)

# Check if any JS/TS files were changed
if echo "$CHANGED_FILES" | grep -qE '\.(js|jsx|ts|tsx)$'; then
  echo "📝 JavaScript/TypeScript files changed, running linting..."
  npm run lint
fi

# Check if any CSS files were changed
if echo "$CHANGED_FILES" | grep -qE '\.(css|scss|less)$'; then
  echo "🎨 Stylesheet files changed, running style linting..."
  npm run lint:css
fi

# Check if package.json or package-lock.json changed
if echo "$CHANGED_FILES" | grep -q "package"; then
  echo "📦 Package files changed, running security audit..."
  npm audit --audit-level moderate
fi

# Check if documentation files changed
if echo "$CHANGED_FILES" | grep -qE '\.(md|mdx)$'; then
  echo "📚 Documentation changed, running markdown linting..."
  npm run lint:markdown
fi

# Always run tests for safety
echo "🧪 Running tests..."
npm run test
```

### Environment-aware Hook

```bash
# .husky/pre-commit - Environment-aware execution
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check if we're in CI environment
if [ "$CI" = "true" ]; then
  echo "🤖 Running in CI environment, skipping local-only checks..."
  npm run test
  exit 0
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt "18" ]; then
  echo "⚠️  Node.js 18+ required for full validation"
  echo "📝 Running basic checks only..."
  npm run lint:basic
  exit 0
fi

# Full validation for appropriate environment
echo "🔍 Running full pre-commit validation..."
npx lint-staged
npm run type-check
npm run test
```

## Integration with Development Tools

### ESLint and Prettier Integration

```json
// package.json - Complete lint-staged configuration
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write", "git add"],
    "*.{css,scss,less}": ["stylelint --fix", "prettier --write", "git add"],
    "*.{json,md,yaml,yml}": ["prettier --write", "git add"]
  }
}
```

### Jest Testing Integration

```bash
# .husky/pre-commit - Jest with coverage thresholds
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🧪 Running tests with coverage..."

# Run tests for changed files with coverage
npm run test -- --coverage --changedSince=HEAD^ || {
  echo "❌ Tests failed or coverage below threshold"
  exit 1
}

# Check if coverage reports were generated
if [ -d "coverage" ]; then
  echo "📊 Coverage report generated in coverage/"
fi
```

### TypeScript Integration

```bash
# .husky/pre-commit - TypeScript with incremental checking
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Type check with incremental compilation
echo "📘 Incremental TypeScript checking..."
npx tsc --noEmit --incremental || {
  echo "❌ TypeScript compilation errors found"
  exit 1
}

# Check for TypeScript-specific linting
echo "📝 TypeScript-specific linting..."
npx eslint --ext .ts,.tsx src/ || {
  echo "❌ TypeScript linting failed"
  exit 1
}
```

### Docker Integration

```bash
# .husky/pre-commit - Docker environment validation
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check if Docker is available and project uses Docker
if command -v docker >/dev/null 2>&1 && [ -f "Dockerfile" ]; then
  echo "🐳 Validating Docker configuration..."

  # Lint Dockerfile
  docker run --rm -i hadolint/hadolint < Dockerfile || {
    echo "⚠️  Dockerfile linting issues found"
  }

  # Test Docker build (quick check)
  docker build --target development . -t temp-build-test || {
    echo "❌ Docker build failed"
    exit 1
  }

  # Cleanup
  docker rmi temp-build-test >/dev/null 2>&1
fi
```

## Troubleshooting

### Common Issues

#### Hooks Not Executing

**Problem**: Git hooks are not running when expected
**Symptoms**: Commits succeed without running validation scripts
**Solution**:

```bash
# Check if Husky is properly installed
ls -la .husky/
cat .husky/pre-commit

# Verify Git hooks path
git config core.hooksPath

# Reinstall Husky if needed
rm -rf .husky
npx husky init
echo "npm test" > .husky/pre-commit
chmod +x .husky/pre-commit

# Check hook permissions (Unix/Linux/macOS)
chmod +x .husky/*
```

#### Permission Denied Errors

**Problem**: Hooks fail with permission denied errors
**Symptoms**: "Permission denied" error when Git tries to execute hooks
**Solution**:

```bash
# Make hooks executable (Unix/Linux/macOS)
chmod +x .husky/pre-commit
chmod +x .husky/pre-push

# For Windows (using Git Bash)
git update-index --chmod=+x .husky/pre-commit

# Verify permissions
ls -la .husky/
```

#### Hook Script Failures

**Problem**: Hook scripts fail with cryptic error messages
**Symptoms**: Hooks exit with non-zero status but unclear error information
**Solution**:

```bash
# Add debugging to hook script
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

set -e  # Exit on any error
set -x  # Print commands as they execute

echo "Starting pre-commit hook..."
npm run lint
echo "Lint completed successfully"

# Test hook manually
./.husky/pre-commit

# Check specific command failures
npm run lint  # Run individual commands to isolate issues
```

#### Performance Issues

**Problem**: Hooks take too long to execute, slowing down development
**Symptoms**: Long delays during commits, developer frustration
**Solution**:

```bash
# Use lint-staged for file-specific operations
npm install lint-staged --save-dev

# Optimize hook to run only necessary checks
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Time the hook execution
start_time=$(date +%s)

# Use lint-staged instead of full project linting
npx lint-staged

# Skip heavy operations in pre-commit, move to pre-push
# npm run test  # Move to pre-push hook

end_time=$(date +%s)
echo "Hook execution time: $((end_time - start_time)) seconds"
```

### Debug Mode

```bash
# Enable Husky debugging
HUSKY_DEBUG=1 git commit -m "debug commit"

# Check hook configuration
cat .husky/pre-commit
ls -la .husky/

# Test hook execution manually
./.husky/pre-commit

# Verify Git hooks path
git config --list | grep hooks
```

### Performance Optimization

```bash
# Measure hook performance
time ./.husky/pre-commit

# Use lint-staged for incremental checking
npx lint-staged --debug

# Profile specific commands
time npm run lint
time npm run test

# Optimize package.json scripts
{
  "scripts": {
    "lint:fast": "eslint --cache src/",
    "test:fast": "jest --onlyChanged"
  }
}
```

## Security Considerations

### Security Best Practices

- **Validate hook scripts** for malicious code before committing to repository
- **Use trusted sources** for hook script templates and avoid copying unknown scripts
- **Limit hook permissions** to only necessary operations and file access
- **Audit dependencies** used in hook scripts regularly for vulnerabilities
- **Avoid sensitive data** in hook scripts or environment variables
- **Use secure communication** when hooks interact with external services

### Sensitive Data Handling

```bash
# .husky/pre-commit - Secure environment handling
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check for sensitive data in commits
echo "🔒 Scanning for sensitive data..."

# Check for common secrets patterns
if git diff --cached | grep -E "(password|secret|key|token)" >/dev/null; then
  echo "⚠️  Potential sensitive data detected in commit"
  echo "Please review your changes before committing"
fi

# Use environment variables securely
if [ -n "$SECURITY_SCAN_ENABLED" ]; then
  npm run security:scan
fi
```

### Network Security

```bash
# .husky/pre-commit - Network-aware security
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Only run network-dependent checks when online
if ping -c 1 google.com >/dev/null 2>&1; then
  echo "🌐 Network available, running online security checks..."
  npm audit --audit-level moderate
else
  echo "🔌 No network connection, skipping online security checks"
fi
```

## AI Assistant Guidelines

When helping with Husky:

1. **Always suggest Husky 9.0+** for new projects with improved performance and simplicity
2. **Provide complete workflow examples** that integrate with common development tools
3. **Include lint-staged setup** for performance optimization in team environments
4. **Suggest cross-platform compatible** hook scripts that work on Windows, macOS, and Linux
5. **Provide debugging strategies** for common hook execution and permission issues
6. **Include emergency bypass procedures** for critical commits using --no-verify
7. **Reference team collaboration patterns** for establishing consistent development standards
8. **Provide performance optimization** techniques for large projects and teams

### Code Generation Rules

- Generate executable shell scripts with proper shebang and Husky initialization
- Include error handling and informative output messages in hook scripts
- Provide both basic and advanced hook configurations based on project complexity
- Include lint-staged configuration for performance optimization
- Follow cross-platform compatibility best practices in script generation
- Add debugging and troubleshooting guidance for common setup issues
- Include integration patterns with popular tools (ESLint, Prettier, Jest, TypeScript)
- Follow security best practices for hook script content and execution

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
