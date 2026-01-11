---
name: 'Prettier Code Formatter Instructions'
description: 'Comprehensive guide for using Prettier to automatically format code for'
keywords: [**performance, assessment, **avoid, agent, **common, **usage, applications, **use, advanced, **configuration]
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

See [example-1](./examples/prettier/example-1.bash)

### VS Code Integration

See [example-2](./examples/prettier/example-2.bash)

### Project Integration

See [example-3](./examples/prettier/example-3.bash)

## Configuration

### Basic Configuration

See [example-4](./examples/prettier/example-4.json)

### Framework-Specific Configuration

See [example-5](./examples/prettier/example-5.javascript)

### TypeScript Configuration

See [example-6](./examples/prettier/example-6.json)

### Environment Variables

See [example-7](./examples/prettier/example-7.bash)

### Package.json Integration

See [example-8](./examples/prettier/example-8.json)

## Core Features

### Automatic Code Formatting

- **Purpose**: Ensures consistent code style without manual intervention
- **Usage**: Formats code on save, pre-commit, or via CLI commands
- **Example**:

See [example-9](./examples/prettier/example-9.bash)

### Multi-Language Support

- **Purpose**: Consistent formatting across JavaScript, TypeScript, CSS, HTML, JSON, Markdown
- **Usage**: Single tool for all supported file types in modern web projects
- **Example**:

See [example-10](./examples/prettier/example-10.bash)

### Plugin Ecosystem

- **Purpose**: Extends Prettier to support additional languages and custom formatting
- **Usage**: Adds support for languages like PHP, Java, Python, and custom sorting
- **Example**:

See [example-11](./examples/prettier/example-11.bash)

### Editor Integration

- **Purpose**: Real-time formatting in development environment
- **Usage**: Format on save, format on paste, or manual formatting commands
- **Example**:

See [example-12](./examples/prettier/example-12.json)

## Common Commands

See [example-13](./examples/prettier/example-13.bash)

## Workflow Integration

### Development Workflow

1. **Setup**: Install Prettier and configure basic rules for project
2. **Development**: Enable format on save in IDE for real-time formatting
3. **Pre-commit**: Use lint-staged to format only changed files
4. **Code Review**: Ensure consistent formatting across all contributions
5. **CI/CD**: Run Prettier check to prevent unformatted code from merging

### VS Code Integration

See [example-14](./examples/prettier/example-14.json)

### Git Hooks Integration

See [example-15](./examples/prettier/example-15.bash)

See [example-16](./examples/prettier/example-16.json)

### CI/CD Integration

See [example-17](./examples/prettier/example-17.yaml)

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

See [example-18](./examples/prettier/example-18.json)

### Vue.js Applications

See [example-19](./examples/prettier/example-19.json)

### TypeScript Projects

See [example-20](./examples/prettier/example-20.json)

### Tailwind CSS Integration

See [example-21](./examples/prettier/example-21.bash)

See [example-22](./examples/prettier/example-22.json)

## Integration with Other Tools

### ESLint Integration

See [example-23](./examples/prettier/example-23.bash)

See [example-24](./examples/prettier/example-24.javascript)

### TypeScript Integration

See [example-25](./examples/prettier/example-25.json)

### Webpack/Vite Integration

See [example-26](./examples/prettier/example-26.javascript)

### Monorepo Integration

See [example-27](./examples/prettier/example-27.json)

## Troubleshooting

### Common Issues

#### Configuration Not Found

**Problem**: Prettier uses default settings instead of project configuration
**Symptoms**: Formatting doesn't match expected project style
**Solution**:

See [example-28](./examples/prettier/example-28.bash)

#### ESLint Conflicts

**Problem**: ESLint and Prettier rules conflict causing formatting issues
**Symptoms**: Code gets formatted differently by ESLint and Prettier
**Solution**:

See [example-29](./examples/prettier/example-29.bash)

#### Performance Issues

**Problem**: Prettier runs slowly on large codebases
**Symptoms**: Long formatting times, IDE lag during save
**Solution**:

See [example-30](./examples/prettier/example-30.bash)

#### Plugin Conflicts

**Problem**: Multiple Prettier plugins conflict with each other
**Symptoms**: Unexpected formatting or plugin errors
**Solution**:

See [example-31](./examples/prettier/example-31.json)

### Debug Mode

See [example-32](./examples/prettier/example-32.bash)

### Performance Optimization

See [example-33](./examples/prettier/example-33.bash)

## Security Considerations

### Security Best Practices

- **Avoid formatting sensitive files** by adding them to .prettierignore
- **Review plugin sources** before installation - only use trusted plugins
- **Keep Prettier updated** to latest version for security patches
- **Use .prettierignore** to exclude configuration files with secrets
- **Audit plugin dependencies** regularly for vulnerabilities

### CI/CD Security

See [example-34](./examples/prettier/example-34.yaml)

### File Exclusion

See [example-35](./examples/prettier/example-35.bash)

## Advanced Configuration

### Custom Plugin Development

See [example-36](./examples/prettier/example-36.javascript)

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
