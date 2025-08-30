---
title: 'ESLint JavaScript Code Quality and Linting Tool Instructions'
description: 'Comprehensive guide for using ESLint to maintain code quality, consistency, and best practices in JavaScript/TypeScript projects'
category: 'Development Tools'
author: 'AI Assistant'
tags:
  [
    'eslint',
    'linting',
    'code-quality',
    'javascript',
    'typescript',
    'static-analysis',
    'development-tools',
  ]
version: '1.0'
last_updated: '2025-01-09'
applyTo:
  - '**/*.js'
  - '**/*.jsx'
  - '**/*.ts'
  - '**/*.tsx'
  - '**/*.vue'
  - '**/*.svelte'
  - '**/eslint.config.js'
  - '**/.eslintrc.*'
  - '**/package.json'
---

# ESLint JavaScript Code Quality and Linting Tool Instructions

## Tool Overview

- **Tool Name**: ESLint
- **Version**: 9.0+ (Latest stable with flat config support)
- **Category**: Development Tools - Code Quality & Linting
- **Purpose**: Static analysis tool for identifying and fixing problems in JavaScript/TypeScript code
- **Prerequisites**: Node.js 18.18.0+, npm/yarn/pnpm package manager

## When to Use ESLint

### ✅ **Use ESLint When**

- Building JavaScript/TypeScript applications of any size
- Working in team environments requiring code consistency
- Need to catch potential bugs before runtime
- Want to enforce coding standards and best practices
- Integrating with modern development workflows (CI/CD, pre-commit hooks)
- Using frameworks like React, Vue, Angular, or Svelte
- Converting JavaScript to TypeScript gradually
- Setting up automated code review processes

### ❌ **Avoid ESLint When**

- Working on non-JavaScript projects exclusively
- Performance is extremely critical and linting overhead is unacceptable
- Project has legacy codebase that cannot be easily migrated
- Team strongly prefers alternative linting solutions (JSHint, JSLint)

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type       | ESLint Recommendation                                                          | Alternative                  |
| ------------------ | ------------------------------------------------------------------------------ | ---------------------------- |
| React Application  | ✅ **Strongly Recommended** - Use @typescript-eslint/recommended + react hooks | TSC + Prettier only          |
| Vue.js Application | ✅ **Strongly Recommended** - Use vue/vue3-recommended preset                  | Vue DevTools + manual review |
| Node.js Backend    | ✅ **Recommended** - Use node/recommended preset                               | JSHint + manual standards    |
| TypeScript Project | ✅ **Essential** - Use @typescript-eslint/recommended                          | TSC strict mode only         |
| Legacy JavaScript  | 🔄 **Consider** - Gradual adoption with eslint:recommended                     | Manual code review           |

### Integration Complexity Assessment

| Factor            | Low Complexity               | Medium Complexity        | High Complexity             |
| ----------------- | ---------------------------- | ------------------------ | --------------------------- |
| **Setup Time**    | 15 minutes (standard config) | 1-2 hours (custom rules) | 4+ hours (enterprise setup) |
| **Team Size**     | 1-3 developers               | 4-10 developers          | 10+ developers              |
| **Codebase Size** | <10k lines                   | 10k-100k lines           | 100k+ lines                 |
| **Custom Rules**  | Standard presets             | Some custom rules        | Extensive customization     |

## Installation & Setup

### Package Manager Installation

```bash
# npm installation (recommended for most projects)
npm install eslint --save-dev

# yarn installation
yarn add eslint --dev

# pnpm installation
pnpm add eslint --save-dev

# Global installation (for CLI usage across projects)
npm install -g eslint
```

### Project Integration

```bash
# Initialize ESLint in existing project (interactive setup)
npx eslint --init

# Quick setup with recommended configuration
npm init @eslint/config

# Manual configuration creation
touch eslint.config.js  # Flat config (ESLint 9.0+)
# or
touch .eslintrc.json    # Legacy config format
```

### TypeScript Integration

```bash
# Install TypeScript ESLint parser and plugin
npm install --save-dev @typescript-eslint/parser @typescript-eslint/eslint-plugin

# For React TypeScript projects
npm install --save-dev eslint-plugin-react eslint-plugin-react-hooks @typescript-eslint/recommended
```

## Configuration

### Flat Configuration (ESLint 9.0+)

```javascript
// eslint.config.js (recommended for new projects)
import js from '@eslint/js';
import typescript from '@typescript-eslint/eslint-plugin';
import typescriptParser from '@typescript-eslint/parser';
import react from 'eslint-plugin-react';
import reactHooks from 'eslint-plugin-react-hooks';

export default [
  js.configs.recommended,
  {
    files: ['**/*.{js,jsx,ts,tsx}'],
    languageOptions: {
      ecmaVersion: 2024,
      sourceType: 'module',
      parser: typescriptParser,
      parserOptions: {
        ecmaFeatures: { jsx: true },
        project: './tsconfig.json',
      },
      globals: {
        console: 'readonly',
        process: 'readonly',
      },
    },
    plugins: {
      '@typescript-eslint': typescript,
      react: react,
      'react-hooks': reactHooks,
    },
    rules: {
      // TypeScript specific rules
      '@typescript-eslint/no-unused-vars': 'error',
      '@typescript-eslint/explicit-function-return-type': 'warn',
      '@typescript-eslint/no-explicit-any': 'warn',

      // React specific rules
      'react/prop-types': 'off', // Not needed with TypeScript
      'react-hooks/rules-of-hooks': 'error',
      'react-hooks/exhaustive-deps': 'warn',

      // General code quality rules
      'no-console': 'warn',
      'no-debugger': 'error',
      'prefer-const': 'error',
      'no-var': 'error',
    },
    settings: {
      react: {
        version: 'detect',
      },
    },
  },
  {
    files: ['**/*.test.{js,jsx,ts,tsx}'],
    rules: {
      'no-console': 'off', // Allow console in tests
    },
  },
];
```

### Legacy Configuration

```json
// .eslintrc.json (for ESLint 8.x compatibility)
{
  "env": {
    "browser": true,
    "es2022": true,
    "node": true
  },
  "extends": [
    "eslint:recommended",
    "@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true
    },
    "project": "./tsconfig.json"
  },
  "plugins": ["@typescript-eslint", "react", "react-hooks"],
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "react/prop-types": "off",
    "react-hooks/rules-of-hooks": "error",
    "react-hooks/exhaustive-deps": "warn",
    "no-console": "warn",
    "prefer-const": "error"
  },
  "settings": {
    "react": {
      "version": "detect"
    }
  },
  "overrides": [
    {
      "files": ["**/*.test.{js,jsx,ts,tsx}"],
      "rules": {
        "no-console": "off"
      }
    }
  ]
}
```

### Environment Variables

```bash
# Environment-specific settings
ESLINT_USE_FLAT_CONFIG=true  # Enable flat config in ESLint 8.x
ESLINT_CONFIG_PATH=./custom-eslint.config.js
NODE_OPTIONS="--max-old-space-size=4096"  # For large codebases
```

### Package.json Integration

```json
{
  "scripts": {
    "lint": "eslint src/**/*.{js,jsx,ts,tsx}",
    "lint:fix": "eslint src/**/*.{js,jsx,ts,tsx} --fix",
    "lint:check": "eslint src/**/*.{js,jsx,ts,tsx} --max-warnings 0",
    "lint:staged": "lint-staged"
  },
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "git add"]
  }
}
```

## Core Features

### Static Code Analysis

- **Purpose**: Identifies potential bugs, syntax errors, and code quality issues
- **Usage**: Analyzes code without executing it to catch issues early
- **Example**:

```bash
eslint src/components/Button.tsx
eslint "src/**/*.{js,ts,jsx,tsx}" --ext .js,.jsx,.ts,.tsx
```

### Automatic Code Fixing

- **Purpose**: Automatically fixes fixable linting issues (formatting, simple logic)
- **Usage**: Saves development time by handling routine fixes
- **Example**:

```bash
eslint src/utils/helpers.js --fix
eslint "src/**/*.{js,ts}" --fix --ext .js,.ts
```

### Custom Rule Configuration

- **Purpose**: Enforces project-specific coding standards and best practices
- **Usage**: Tailors linting rules to match team preferences and requirements
- **Example**:

```javascript
// Custom rules in eslint.config.js
{
  rules: {
    "max-len": ["error", { "code": 120, "ignoreUrls": true }],
    "no-magic-numbers": ["warn", { "ignore": [0, 1, -1] }],
    "prefer-arrow-callback": "error"
  }
}
```

### Plugin Ecosystem Integration

- **Purpose**: Extends ESLint functionality for specific frameworks and libraries
- **Usage**: Adds specialized rules for React, Vue, Angular, accessibility, etc.
- **Example**:

```bash
# Install and configure accessibility plugin
npm install eslint-plugin-jsx-a11y --save-dev
```

## Common Commands

```bash
# Essential daily commands
eslint src/                           # Lint all files in src directory
eslint src/ --fix                     # Lint and auto-fix issues
eslint src/ --max-warnings 0          # Fail on any warnings
eslint --help                         # Get command help

# Advanced operations
eslint src/ --format json             # Output results in JSON format
eslint src/ --config custom.config.js # Use custom config file
eslint src/ --debug                   # Enable debug output
eslint src/ --cache                   # Use caching for better performance
eslint src/ --fix-dry-run             # Preview fixes without applying

# Specific file type targeting
eslint "**/*.{js,jsx}"               # Only JavaScript files
eslint "**/*.{ts,tsx}"               # Only TypeScript files
eslint "src/**/*.test.js"            # Only test files
```

## Workflow Integration

### Development Workflow

1. **Setup**: Install ESLint and configure rules for project needs
2. **Development**: Run ESLint in watch mode or on file save
3. **Pre-commit**: Use lint-staged to check only modified files
4. **Code Review**: Integrate with PR checks to enforce standards
5. **CI/CD**: Run linting in continuous integration pipeline

### VS Code Integration

```json
// .vscode/settings.json
{
  "eslint.enable": true,
  "eslint.format.enable": true,
  "eslint.lintTask.enable": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "eslint.workingDirectories": ["src"],
  "eslint.validate": ["javascript", "javascriptreact", "typescript", "typescriptreact"]
}
```

### Git Hooks Integration

```bash
# Install husky for git hooks
npm install husky lint-staged --save-dev

# Setup pre-commit hook
npx husky install
npx husky add .husky/pre-commit "npx lint-staged"
```

```json
// lint-staged configuration in package.json
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"]
  }
}
```

### CI/CD Integration

```yaml
# GitHub Actions workflow
name: Code Quality
on: [push, pull_request]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint:check
      - run: npm run type-check # TypeScript type checking
```

## Best Practices

### ✅ **Configuration Best Practices**

- **Use flat config** for ESLint 9.0+ projects (better performance and clearer syntax)
- **Extend recommended presets** before adding custom rules
- **Configure TypeScript parser** for TypeScript projects with proper project references
- **Use overrides** for different file types (tests, config files, etc.)
- **Enable editor integration** with ESLint VS Code extension
- **Set up incremental adoption** for large legacy codebases

### ✅ **Usage Patterns**

- **Run on save** in development environment for immediate feedback
- **Use --fix flag** for automatic corrections of formatting issues
- **Implement pre-commit hooks** to prevent bad code from being committed
- **Configure CI/CD checks** with zero tolerance for errors (--max-warnings 0)
- **Use ESLint cache** for large projects to improve performance
- **Combine with Prettier** for comprehensive code formatting

### ✅ **Performance Optimization**

- **Enable caching** with --cache flag for repeated runs
- **Use specific file patterns** instead of broad directory scanning
- **Configure .eslintignore** for build outputs and dependencies
- **Run incrementally** on changed files only using lint-staged
- **Optimize parser options** by limiting project scope for TypeScript
- **Use worker threads** for large codebases with ESLINT_USE_FLAT_CONFIG

### ❌ **Common Pitfalls to Avoid**

- **Don't over-configure** - Start with recommended presets
- **Avoid conflicting rules** between ESLint and Prettier
- **Don't ignore .eslintcache** in version control
- **Don't run on node_modules** or build directories
- **Avoid too strict rules** that slow down development
- **Don't mix flat and legacy config** in same project

## Framework-Specific Configurations

### React Applications

```javascript
// eslint.config.js for React
import react from 'eslint-plugin-react';
import reactHooks from 'eslint-plugin-react-hooks';
import reactRefresh from 'eslint-plugin-react-refresh';

export default [
  {
    files: ['**/*.{js,jsx,ts,tsx}'],
    plugins: {
      react,
      'react-hooks': reactHooks,
      'react-refresh': reactRefresh,
    },
    rules: {
      'react/react-in-jsx-scope': 'off', // Not needed in React 17+
      'react/prop-types': 'off',
      'react-hooks/rules-of-hooks': 'error',
      'react-hooks/exhaustive-deps': 'warn',
      'react-refresh/only-export-components': 'warn',
    },
    settings: {
      react: { version: 'detect' },
    },
  },
];
```

### Vue.js Applications

```javascript
// eslint.config.js for Vue.js
import vue from 'eslint-plugin-vue';

export default [
  ...vue.configs['flat/recommended'],
  {
    files: ['**/*.vue'],
    languageOptions: {
      parserOptions: {
        parser: '@typescript-eslint/parser',
      },
    },
    rules: {
      'vue/multi-word-component-names': 'warn',
      'vue/component-definition-name-casing': ['error', 'PascalCase'],
    },
  },
];
```

### Node.js Backend

```javascript
// eslint.config.js for Node.js
import nodePlugin from 'eslint-plugin-node';

export default [
  {
    files: ['**/*.js'],
    plugins: {
      node: nodePlugin,
    },
    rules: {
      'node/no-missing-import': 'error',
      'node/no-unpublished-require': 'error',
      'node/prefer-global/process': 'error',
    },
    languageOptions: {
      globals: {
        global: 'readonly',
        process: 'readonly',
        Buffer: 'readonly',
      },
    },
  },
];
```

## Integration with Other Tools

### Prettier Integration

```bash
# Install Prettier compatibility
npm install eslint-config-prettier --save-dev
```

```javascript
// eslint.config.js with Prettier
import prettier from 'eslint-config-prettier';

export default [
  // ... other configs
  prettier, // Must be last to override conflicting rules
  {
    rules: {
      // Custom rules that don't conflict with Prettier
      'no-console': 'warn',
    },
  },
];
```

### TypeScript Integration

```javascript
// Advanced TypeScript configuration
import typescript from '@typescript-eslint/eslint-plugin';
import typescriptParser from '@typescript-eslint/parser';

export default [
  {
    files: ['**/*.{ts,tsx}'],
    languageOptions: {
      parser: typescriptParser,
      parserOptions: {
        project: './tsconfig.json',
        tsconfigRootDir: import.meta.dirname,
      },
    },
    plugins: {
      '@typescript-eslint': typescript,
    },
    rules: {
      '@typescript-eslint/strict-boolean-expressions': 'error',
      '@typescript-eslint/prefer-nullish-coalescing': 'error',
      '@typescript-eslint/prefer-optional-chain': 'error',
    },
  },
];
```

### Jest Testing Integration

```javascript
// Test file specific configuration
export default [
  {
    files: ['**/*.test.{js,jsx,ts,tsx}', '**/__tests__/**'],
    plugins: {
      jest: jestPlugin,
    },
    rules: {
      'jest/expect-expect': 'error',
      'jest/no-disabled-tests': 'warn',
      'jest/prefer-to-be': 'error',
    },
  },
];
```

## Troubleshooting

### Common Issues

#### Configuration Not Found

**Problem**: ESLint cannot locate configuration file
**Symptoms**: "No ESLint configuration found" error
**Solution**:

```bash
# Check for config file existence
ls -la eslint.config.js .eslintrc.*

# Initialize configuration if missing
npx eslint --init

# Specify config explicitly
eslint --config ./path/to/config.js src/
```

#### Parser Errors with TypeScript

**Problem**: ESLint fails to parse TypeScript files
**Symptoms**: Parsing errors or "Unexpected token" messages
**Solution**:

```bash
# Install TypeScript parser
npm install @typescript-eslint/parser --save-dev

# Verify tsconfig.json exists and is valid
npx tsc --noEmit --skipLibCheck

# Update parser configuration
# Set parser: "@typescript-eslint/parser" in config
```

#### Performance Issues

**Problem**: ESLint runs slowly on large codebases
**Symptoms**: Long execution times, high memory usage
**Solution**:

```bash
# Enable caching
eslint --cache src/

# Use specific file patterns
eslint "src/**/*.{js,ts}" --ext .js,.ts

# Optimize TypeScript project references
# Use project: ["./tsconfig.json"] instead of project: true
```

#### Plugin Conflicts

**Problem**: Rules from different plugins conflict with each other
**Symptoms**: Contradictory linting messages or auto-fix loops
**Solution**:

```javascript
// Use eslint-config-prettier to disable conflicting rules
import prettier from 'eslint-config-prettier';

export default [
  // ... other configs
  prettier, // Must be last
];
```

### Debug Mode

```bash
# Enable verbose output
eslint --debug src/components/

# Print configuration for specific file
eslint --print-config src/components/Button.tsx

# Test specific rule
eslint --rule '{"no-console": "error"}' src/utils/

# Check what files will be linted
eslint --print-config-path src/
```

### Performance Optimization

```bash
# Use caching for repeated runs
eslint --cache --cache-location .eslintcache src/

# Profile performance
time eslint src/

# Use worker threads (experimental)
ESLINT_USE_FLAT_CONFIG=true eslint src/
```

## Security Considerations

### Security Best Practices

- **Enable security plugins** like eslint-plugin-security for vulnerability detection
- **Audit dependencies** regularly for ESLint plugins and parsers
- **Use .eslintignore** to exclude sensitive files from linting
- **Configure no-eval rule** to prevent code injection vulnerabilities
- **Enable import/no-dynamic-require** to prevent dynamic imports of untrusted code

### Sensitive Data Handling

```javascript
// Security-focused rules
{
  rules: {
    "no-eval": "error",
    "no-implied-eval": "error",
    "no-new-func": "error",
    "security/detect-object-injection": "error",
    "security/detect-non-literal-regexp": "error"
  }
}
```

### CI/CD Security

```yaml
# Secure GitHub Actions workflow
- name: ESLint Security Check
  run: |
    npm audit --audit-level moderate
    npm run lint:security
  env:
    NODE_OPTIONS: --max-old-space-size=4096
```

## Advanced Configuration

### Custom Rules Development

```javascript
// Custom rule example
export default [
  {
    plugins: {
      custom: {
        rules: {
          'no-hardcoded-urls': {
            create(context) {
              return {
                Literal(node) {
                  if (typeof node.value === 'string' && node.value.match(/^https?:\/\//)) {
                    context.report({
                      node,
                      message: 'Hardcoded URLs should be moved to configuration',
                    });
                  }
                },
              };
            },
          },
        },
      },
    },
    rules: {
      'custom/no-hardcoded-urls': 'warn',
    },
  },
];
```

### Monorepo Configuration

```javascript
// eslint.config.js for monorepo
export default [
  {
    files: ['packages/frontend/**/*.{js,jsx,ts,tsx}'],
    // Frontend-specific configuration
  },
  {
    files: ['packages/backend/**/*.{js,ts}'],
    // Backend-specific configuration
  },
  {
    files: ['packages/shared/**/*.{js,ts}'],
    // Shared code configuration
  },
];
```

### Performance Tuning

```javascript
// Optimized configuration for large projects
export default [
  {
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.json', './packages/*/tsconfig.json'],
        tsconfigRootDir: import.meta.dirname,
        EXPERIMENTAL_useSourceOfProjectReferenceRedirect: true,
      },
    },
  },
];
```

## AI Assistant Guidelines

When helping with ESLint:

1. **Always suggest ESLint 9.0+ flat config** for new projects
2. **Provide framework-specific configurations** (React, Vue, Node.js)
3. **Include TypeScript integration** when TypeScript is detected
4. **Suggest performance optimizations** for large codebases
5. **Recommend security plugins** for production applications
6. **Include CI/CD integration** examples
7. **Provide troubleshooting steps** for common configuration issues
8. **Reference official ESLint documentation** for complex scenarios

### Code Generation Rules

- Generate flat config format (eslint.config.js) by default
- Include proper TypeScript parser configuration when needed
- Add framework-specific plugins and rules based on project detection
- Include performance optimizations (caching, specific file patterns)
- Provide both local development and CI/CD configurations
- Include security-focused rules for production applications
- Add proper error handling and fallback configurations
- Follow ESLint shareable config conventions for team configurations
