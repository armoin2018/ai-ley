---
title: 'Prettier Code Formatter Instructions'
description: 'Comprehensive guide for using Prettier to automatically format code for consistent style across JavaScript, TypeScript, CSS, HTML, and more'
category: 'Development Tools'
author: 'AI Assistant'
tags:
  [
    'prettier',
    'code-formatter',
    'javascript',
    'typescript',
    'css',
    'html',
    'formatting',
    'development-tools',
  ]
version: '1.0'
last_updated: '2025-01-09'
applyTo:
  - '**/*.js'
  - '**/*.jsx'
  - '**/*.ts'
  - '**/*.tsx'
  - '**/*.css'
  - '**/*.scss'
  - '**/*.less'
  - '**/*.html'
  - '**/*.vue'
  - '**/*.svelte'
  - '**/*.json'
  - '**/*.md'
  - '**/.prettierrc.*'
  - '**/prettier.config.*'
  - '**/package.json'
---

# Prettier Code Formatter Instructions

## Tool Overview

- **Tool Name**: Prettier
- **Version**: 3.0+ (Latest stable with improved performance)
- **Category**: Development Tools - Code Formatting
- **Purpose**: Opinionated code formatter that enforces consistent style across multiple languages
- **Prerequisites**: Node.js 14+ for Prettier 3.0, npm/yarn/pnpm package manager

## When to Use Prettier

### ✅ **Use Prettier When**

- Working on any JavaScript/TypeScript project requiring consistent formatting
- Team collaboration needs standardized code style without manual enforcement
- Integration with modern development workflows (save on format, pre-commit hooks)
- Supporting multiple file types (JS, TS, CSS, HTML, Markdown, JSON, YAML)
- Need to eliminate formatting discussions and focus on code logic
- Migrating from manual formatting to automated solution
- Setting up new projects with modern development standards
- Working with popular frameworks (React, Vue, Angular, Next.js)

### ❌ **Avoid Prettier When**

- Working with languages not supported by Prettier
- Team strongly prefers custom formatting that conflicts with Prettier's opinionated style
- Legacy codebase with established formatting that cannot be changed
- Performance is extremely critical and formatting overhead is unacceptable
- Need highly customized formatting rules beyond Prettier's configuration options

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type              | Prettier Recommendation                        | Configuration Priority           |
| ------------------------- | ---------------------------------------------- | -------------------------------- |
| React/Next.js Application | ✅ **Essential** - JSX formatting crucial      | High - Configure JSX settings    |
| Vue.js Application        | ✅ **Strongly Recommended**                    | High - Vue SFC formatting        |
| TypeScript Project        | ✅ **Essential** - TS/JS consistency           | High - TypeScript-specific rules |
| Node.js Backend           | ✅ **Recommended**                             | Medium - Standard JS formatting  |
| Static Website            | ✅ **Recommended**                             | Medium - HTML/CSS formatting     |
| Legacy JavaScript         | 🔄 **Consider** - May require gradual adoption | Low - Basic configuration        |

### Integration Complexity Assessment

| Factor          | Low Complexity           | Medium Complexity       | High Complexity              |
| --------------- | ------------------------ | ----------------------- | ---------------------------- |
| **Setup Time**  | 5 minutes (basic config) | 30 minutes (team setup) | 2+ hours (enterprise config) |
| **Team Size**   | 1-3 developers           | 4-10 developers         | 10+ developers               |
| **File Types**  | JS/TS only               | JS/TS/CSS/HTML          | All supported formats        |
| **Integration** | Basic IDE setup          | ESLint + Git hooks      | CI/CD + custom plugins       |

## Installation & Setup

### Package Manager Installation

```bash
# npm installation (recommended for most projects)
npm install prettier --save-dev

# yarn installation
yarn add prettier --dev

# pnpm installation
pnpm add prettier --save-dev

# Global installation (for CLI usage across projects)
npm install -g prettier

# Install with ESLint integration
npm install prettier eslint-config-prettier eslint-plugin-prettier --save-dev
```

### VS Code Integration

```bash
# Install Prettier VS Code extension
code --install-extension esbenp.prettier-vscode
```

### Project Integration

```bash
# Create basic configuration
echo '{}' > .prettierrc.json

# Create ignore file
echo 'node_modules/
dist/
build/
coverage/' > .prettierignore

# Add npm scripts
npm pkg set scripts.format="prettier --write ."
npm pkg set scripts.format:check="prettier --check ."
```

## Configuration

### Basic Configuration

```json
// .prettierrc.json (recommended format)
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "quoteProps": "as-needed",
  "jsxSingleQuote": true,
  "bracketSpacing": true,
  "bracketSameLine": false,
  "arrowParens": "avoid",
  "proseWrap": "preserve",
  "htmlWhitespaceSensitivity": "css",
  "endOfLine": "lf",
  "embeddedLanguageFormatting": "auto"
}
```

### Framework-Specific Configuration

```javascript
// prettier.config.js (for complex configurations)
export default {
  // Base configuration
  semi: true,
  singleQuote: true,
  printWidth: 80,
  tabWidth: 2,
  trailingComma: 'es5',

  // React/JSX specific
  jsxSingleQuote: true,
  bracketSameLine: false,

  // Import sorting (with plugin)
  importOrder: ['^react$', '^next', '<THIRD_PARTY_MODULES>', '^@/(.*)$', '^[./]'],
  importOrderSeparation: true,

  // Override for specific file types
  overrides: [
    {
      files: '*.{css,scss,less}',
      options: {
        singleQuote: false,
        printWidth: 120,
      },
    },
    {
      files: '*.md',
      options: {
        proseWrap: 'always',
        printWidth: 100,
      },
    },
    {
      files: '*.json',
      options: {
        printWidth: 120,
        tabWidth: 2,
      },
    },
  ],

  // Plugin configurations
  plugins: ['@trivago/prettier-plugin-sort-imports'],
};
```

### TypeScript Configuration

```json
// .prettierrc.json for TypeScript projects
{
  "semi": true,
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "trailingComma": "all",
  "arrowParens": "avoid",
  "endOfLine": "lf",
  "overrides": [
    {
      "files": "*.{ts,tsx}",
      "options": {
        "parser": "typescript"
      }
    }
  ]
}
```

### Environment Variables

```bash
# Environment-specific settings
PRETTIER_CONFIG_PATH=./custom-prettier.config.js
PRETTIER_IGNORE_PATH=./custom.prettierignore

# CI/CD specific
PRETTIER_CHECK_MODE=true
PRETTIER_WRITE_MODE=false
```

### Package.json Integration

```json
{
  "scripts": {
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "format:staged": "prettier --write",
    "lint": "eslint . && prettier --check .",
    "lint:fix": "eslint . --fix && prettier --write ."
  },
  "prettier": {
    "semi": true,
    "singleQuote": true,
    "trailingComma": "es5"
  },
  "lint-staged": {
    "*.{js,jsx,ts,tsx,css,md,json}": ["prettier --write"]
  }
}
```

## Core Features

### Automatic Code Formatting

- **Purpose**: Ensures consistent code style without manual intervention
- **Usage**: Formats code on save, pre-commit, or via CLI commands
- **Example**:

```bash
prettier --write src/components/Button.tsx
prettier --write "src/**/*.{js,ts,jsx,tsx,css,md}"
```

### Multi-Language Support

- **Purpose**: Consistent formatting across JavaScript, TypeScript, CSS, HTML, JSON, Markdown
- **Usage**: Single tool for all supported file types in modern web projects
- **Example**:

```bash
# Format all supported files
prettier --write .

# Format specific file types
prettier --write "**/*.{js,jsx,ts,tsx}"
prettier --write "**/*.{css,scss,less}"
prettier --write "**/*.{html,vue,svelte}"
```

### Plugin Ecosystem

- **Purpose**: Extends Prettier to support additional languages and custom formatting
- **Usage**: Adds support for languages like PHP, Java, Python, and custom sorting
- **Example**:

```bash
# Install popular plugins
npm install @trivago/prettier-plugin-sort-imports --save-dev
npm install prettier-plugin-tailwindcss --save-dev
npm install prettier-plugin-organize-attributes --save-dev
```

### Editor Integration

- **Purpose**: Real-time formatting in development environment
- **Usage**: Format on save, format on paste, or manual formatting commands
- **Example**:

```json
// VS Code settings.json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

## Common Commands

```bash
# Essential daily commands
prettier --write .                    # Format all files in project
prettier --check .                    # Check if files are formatted
prettier --write src/                 # Format specific directory
prettier --help                       # Get command help

# File-specific operations
prettier --write "**/*.{js,tsx}"      # Format JavaScript/TypeScript files
prettier --write "**/*.css"           # Format CSS files only
prettier --write README.md            # Format single file

# Advanced operations
prettier --config custom.config.js --write .  # Use custom config
prettier --ignore-path .gitignore --write .   # Use gitignore as ignore file
prettier --debug-check src/component.tsx      # Debug formatting issues
prettier --list-different .           # List files that would be changed

# CI/CD specific commands
prettier --check . --write false      # Check without modifying files
prettier --write . --log-level error  # Only show errors
```

## Workflow Integration

### Development Workflow

1. **Setup**: Install Prettier and configure basic rules for project
2. **Development**: Enable format on save in IDE for real-time formatting
3. **Pre-commit**: Use lint-staged to format only changed files
4. **Code Review**: Ensure consistent formatting across all contributions
5. **CI/CD**: Run Prettier check to prevent unformatted code from merging

### VS Code Integration

```json
// .vscode/settings.json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.formatOnSaveMode": "modificationsIfAvailable",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.organizeImports": true
  },
  "prettier.requireConfig": true,
  "prettier.useEditorConfig": false,
  "[markdown]": {
    "editor.formatOnSave": true,
    "editor.wordWrap": "bounded",
    "editor.wordWrapColumn": 100
  }
}
```

### Git Hooks Integration

```bash
# Install husky and lint-staged
npm install husky lint-staged --save-dev

# Setup pre-commit hook
npx husky install
npx husky add .husky/pre-commit "npx lint-staged"
```

```json
// lint-staged configuration in package.json
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
    "*.{css,scss,less}": ["prettier --write"],
    "*.{json,md,yaml,yml}": ["prettier --write"]
  }
}
```

### CI/CD Integration

```yaml
# GitHub Actions workflow
name: Code Quality
on: [push, pull_request]
jobs:
  format-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      - run: npm ci
      - run: npm run format:check
        name: Check Prettier formatting
      - run: npm run lint
        name: Run ESLint
```

## Best Practices

### ✅ **Configuration Best Practices**

- **Use .prettierrc.json** for simple, shareable configuration
- **Enable format on save** in development environment for immediate feedback
- **Configure ESLint integration** with eslint-config-prettier to avoid conflicts
- **Set up pre-commit hooks** to ensure all committed code is formatted
- **Use overrides** for file-type specific formatting rules
- **Keep configuration minimal** - rely on Prettier's opinionated defaults

### ✅ **Usage Patterns**

- **Format entire codebase** when first adopting Prettier
- **Use --check in CI/CD** to prevent unformatted code from merging
- **Combine with ESLint** for comprehensive code quality (formatting + linting)
- **Format on save** for real-time development feedback
- **Use plugins sparingly** - only when necessary for specific needs
- **Document team formatting standards** in project README

### ✅ **Performance Optimization**

- **Use .prettierignore** to exclude large generated files or dependencies
- **Format only changed files** in pre-commit hooks using lint-staged
- **Cache Prettier results** in CI/CD for faster builds
- **Use specific file patterns** instead of formatting entire directories
- **Consider ignoring node_modules** and build output directories
- **Use Prettier caching** for large monorepos

### ❌ **Common Pitfalls to Avoid**

- **Don't fight Prettier's opinions** - embrace the opinionated defaults
- **Avoid excessive customization** that defeats the purpose of consistency
- **Don't ignore ESLint conflicts** - use eslint-config-prettier
- **Avoid formatting generated files** - add them to .prettierignore
- **Don't mix multiple formatters** - choose Prettier as single source of truth
- **Avoid manual formatting** once Prettier is configured

## Framework-Specific Configurations

### React/Next.js Applications

```json
// .prettierrc.json for React projects
{
  "semi": true,
  "singleQuote": true,
  "jsxSingleQuote": true,
  "trailingComma": "es5",
  "bracketSpacing": true,
  "bracketSameLine": false,
  "arrowParens": "avoid",
  "printWidth": 80,
  "tabWidth": 2,
  "plugins": ["@trivago/prettier-plugin-sort-imports"],
  "importOrder": ["^react$", "^next", "<THIRD_PARTY_MODULES>", "^@/(.*)$", "^[./]"],
  "importOrderSeparation": true
}
```

### Vue.js Applications

```json
// .prettierrc.json for Vue projects
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 100,
  "tabWidth": 2,
  "htmlWhitespaceSensitivity": "ignore",
  "vueIndentScriptAndStyle": true,
  "overrides": [
    {
      "files": "*.vue",
      "options": {
        "parser": "vue"
      }
    }
  ]
}
```

### TypeScript Projects

```json
// .prettierrc.json for TypeScript
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 100,
  "tabWidth": 2,
  "arrowParens": "avoid",
  "endOfLine": "lf",
  "overrides": [
    {
      "files": "*.{ts,tsx}",
      "options": {
        "parser": "typescript",
        "trailingComma": "all"
      }
    }
  ]
}
```

### Tailwind CSS Integration

```bash
# Install Tailwind CSS plugin
npm install prettier-plugin-tailwindcss --save-dev
```

```json
// .prettierrc.json with Tailwind
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "plugins": ["prettier-plugin-tailwindcss"],
  "tailwindConfig": "./tailwind.config.js",
  "tailwindFunctions": ["clsx", "cn", "cva"]
}
```

## Integration with Other Tools

### ESLint Integration

```bash
# Install ESLint compatibility packages
npm install eslint-config-prettier eslint-plugin-prettier --save-dev
```

```javascript
// eslint.config.js with Prettier integration
import prettier from 'eslint-config-prettier';

export default [
  // ... other ESLint configs
  prettier, // Must be last to override conflicting rules
  {
    rules: {
      // Custom rules that don't conflict with Prettier
      'prettier/prettier': 'error',
    },
  },
];
```

### TypeScript Integration

```json
// tsconfig.json - no direct integration needed
// Prettier works seamlessly with TypeScript
{
  "compilerOptions": {
    "strict": true,
    "jsx": "react-jsx"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### Webpack/Vite Integration

```javascript
// vite.config.js - format during build (optional)
import { defineConfig } from 'vite';
import prettier from 'prettier';

export default defineConfig({
  plugins: [
    // Custom plugin to format during build
    {
      name: 'prettier-format',
      buildStart() {
        // Format files during build if needed
      },
    },
  ],
});
```

### Monorepo Integration

```json
// Root .prettierrc.json for monorepo
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "overrides": [
    {
      "files": "packages/frontend/**/*.{js,jsx,ts,tsx}",
      "options": {
        "printWidth": 80,
        "jsxSingleQuote": true
      }
    },
    {
      "files": "packages/backend/**/*.{js,ts}",
      "options": {
        "printWidth": 120,
        "trailingComma": "all"
      }
    }
  ]
}
```

## Troubleshooting

### Common Issues

#### Configuration Not Found

**Problem**: Prettier uses default settings instead of project configuration
**Symptoms**: Formatting doesn't match expected project style
**Solution**:

```bash
# Check for config file existence
ls -la .prettierrc* prettier.config.*

# Create basic configuration
echo '{"semi": true, "singleQuote": true}' > .prettierrc.json

# Verify configuration is loaded
prettier --find-config-path src/component.js
```

#### ESLint Conflicts

**Problem**: ESLint and Prettier rules conflict causing formatting issues
**Symptoms**: Code gets formatted differently by ESLint and Prettier
**Solution**:

```bash
# Install compatibility package
npm install eslint-config-prettier --save-dev

# Add to ESLint configuration
# extends: ["other-configs", "prettier"] // prettier must be last
```

#### Performance Issues

**Problem**: Prettier runs slowly on large codebases
**Symptoms**: Long formatting times, IDE lag during save
**Solution**:

```bash
# Use .prettierignore to exclude large files
echo 'node_modules/
dist/
*.min.js
coverage/' > .prettierignore

# Format only specific files
prettier --write "src/**/*.{js,ts}" --ignore-path .gitignore

# Use lint-staged for incremental formatting
```

#### Plugin Conflicts

**Problem**: Multiple Prettier plugins conflict with each other
**Symptoms**: Unexpected formatting or plugin errors
**Solution**:

```json
// Order plugins carefully in configuration
{
  "plugins": [
    "@trivago/prettier-plugin-sort-imports",
    "prettier-plugin-tailwindcss" // Order matters
  ]
}
```

### Debug Mode

```bash
# Debug configuration loading
prettier --find-config-path src/component.js

# Debug why file is ignored
prettier --debug-check src/component.js

# Check what files will be formatted
prettier --list-different .

# Debug plugin loading
prettier --debug-print-doc src/component.js
```

### Performance Optimization

```bash
# Use cache for repeated runs (experimental)
prettier --write . --cache

# Limit file patterns for better performance
prettier --write "src/**/*.{js,ts,jsx,tsx}"

# Use ignore patterns effectively
prettier --write . --ignore-path .gitignore
```

## Security Considerations

### Security Best Practices

- **Avoid formatting sensitive files** by adding them to .prettierignore
- **Review plugin sources** before installation - only use trusted plugins
- **Keep Prettier updated** to latest version for security patches
- **Use .prettierignore** to exclude configuration files with secrets
- **Audit plugin dependencies** regularly for vulnerabilities

### CI/CD Security

```yaml
# Secure CI/CD configuration
- name: Install dependencies
  run: npm ci --only=production

- name: Security audit
  run: npm audit --audit-level moderate

- name: Format check
  run: npm run format:check
  env:
    NODE_OPTIONS: --max-old-space-size=4096
```

### File Exclusion

```bash
# .prettierignore for security
# Environment files
.env*
*.key
*.pem

# Configuration with secrets
docker-compose.yml
kubernetes-secrets.yaml

# Large generated files
bundle.js
*.min.js
coverage/
```

## Advanced Configuration

### Custom Plugin Development

```javascript
// prettier-plugin-custom.js
module.exports = {
  languages: [
    {
      name: 'custom-lang',
      parsers: ['custom-parser'],
      extensions: ['.custom'],
    },
  ],
  parsers: {
    'custom-parser': {
      parse: (text, parsers, options) => {
        // Custom parsing logic
        return ast;
      },
      astFormat: 'custom-ast',
    },
  },
  printers: {
    'custom-ast': {
      print: (path, options, print) => {
        // Custom printing logic
        return formattedCode;
      },
    },
  },
};
```

### Complex Override Patterns

```javascript
// prettier.config.js with complex overrides
export default {
  semi: true,
  singleQuote: true,
  overrides: [
    // React components
    {
      files: 'src/components/**/*.{jsx,tsx}',
      options: {
        printWidth: 80,
        jsxSingleQuote: true,
        bracketSameLine: false,
      },
    },
    // Utility files
    {
      files: 'src/utils/**/*.{js,ts}',
      options: {
        printWidth: 120,
        arrowParens: 'always',
      },
    },
    // Test files
    {
      files: '**/*.{test,spec}.{js,ts,jsx,tsx}',
      options: {
        printWidth: 100,
        trailingComma: 'all',
      },
    },
    // Configuration files
    {
      files: ['*.config.{js,ts}', '.*rc.{js,json}'],
      options: {
        printWidth: 120,
        tabWidth: 2,
      },
    },
  ],
};
```

### Monorepo Configuration

```javascript
// prettier.config.js for monorepo
export default {
  semi: true,
  singleQuote: true,
  overrides: [
    {
      files: 'apps/web/**/*.{js,jsx,ts,tsx}',
      options: {
        printWidth: 80,
        jsxSingleQuote: true,
        plugins: ['prettier-plugin-tailwindcss'],
      },
    },
    {
      files: 'apps/api/**/*.{js,ts}',
      options: {
        printWidth: 120,
        trailingComma: 'all',
      },
    },
    {
      files: 'packages/**/*.{js,ts}',
      options: {
        printWidth: 100,
        tabWidth: 2,
      },
    },
  ],
};
```

## AI Assistant Guidelines

When helping with Prettier:

1. **Always suggest format on save** for immediate development feedback
2. **Provide ESLint integration** setup to avoid conflicts
3. **Include pre-commit hook setup** for team consistency
4. **Suggest minimal configuration** - embrace Prettier's opinions
5. **Recommend popular plugins** only when specifically needed
6. **Include CI/CD integration** for automated format checking
7. **Provide troubleshooting steps** for common ESLint conflicts
8. **Reference latest Prettier documentation** for complex scenarios

### Code Generation Rules

- Generate minimal but effective configurations using .prettierrc.json
- Include ESLint compatibility setup (eslint-config-prettier)
- Add format-on-save VS Code settings when appropriate
- Provide both development and CI/CD script configurations
- Include .prettierignore files for common exclusions
- Suggest framework-specific plugins (Tailwind, sort-imports) based on project detection
- Include performance optimizations for large codebases
- Follow team consistency over personal preferences in configuration`
