---
name: 'ESLint JavaScript Code Quality and Linting Tool Instructions'
description: 'Comprehensive guide for using ESLint to maintain code quality, consistency,'
keywords: [**performance, **avoid, (eslint, agent, **common, **usage, **use, 9.0+), advanced, **configuration]
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

See [example-1](./examples/eslint/example-1.bash)

### Project Integration

See [example-2](./examples/eslint/example-2.bash)

### TypeScript Integration

See [example-3](./examples/eslint/example-3.bash)

## Configuration

### Flat Configuration (ESLint 9.0+)

See [example-4](./examples/eslint/example-4.javascript)

### Legacy Configuration

See [example-5](./examples/eslint/example-5.json)

### Environment Variables

See [example-6](./examples/eslint/example-6.bash)

### Package.json Integration

See [example-7](./examples/eslint/example-7.json)

## Core Features

### Static Code Analysis

- **Purpose**: Identifies potential bugs, syntax errors, and code quality issues
- **Usage**: Analyzes code without executing it to catch issues early
- **Example**:

See [example-8](./examples/eslint/example-8.bash)

### Automatic Code Fixing

- **Purpose**: Automatically fixes fixable linting issues (formatting, simple logic)
- **Usage**: Saves development time by handling routine fixes
- **Example**:

See [example-9](./examples/eslint/example-9.bash)

### Custom Rule Configuration

- **Purpose**: Enforces project-specific coding standards and best practices
- **Usage**: Tailors linting rules to match team preferences and requirements
- **Example**:

See [example-10](./examples/eslint/example-10.javascript)

### Plugin Ecosystem Integration

- **Purpose**: Extends ESLint functionality for specific frameworks and libraries
- **Usage**: Adds specialized rules for React, Vue, Angular, accessibility, etc.
- **Example**:

See [example-11](./examples/eslint/example-11.bash)

## Common Commands

See [example-12](./examples/eslint/example-12.bash)

## Workflow Integration

### Development Workflow

1. **Setup**: Install ESLint and configure rules for project needs
2. **Development**: Run ESLint in watch mode or on file save
3. **Pre-commit**: Use lint-staged to check only modified files
4. **Code Review**: Integrate with PR checks to enforce standards
5. **CI/CD**: Run linting in continuous integration pipeline

### VS Code Integration

See [example-13](./examples/eslint/example-13.json)

### Git Hooks Integration

See [example-14](./examples/eslint/example-14.bash)

See [example-15](./examples/eslint/example-15.json)

### CI/CD Integration

See [example-16](./examples/eslint/example-16.yaml)

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

See [example-17](./examples/eslint/example-17.javascript)

### Vue.js Applications

See [example-18](./examples/eslint/example-18.javascript)

### Node.js Backend

See [example-19](./examples/eslint/example-19.javascript)

## Integration with Other Tools

### Prettier Integration

See [example-20](./examples/eslint/example-20.bash)

See [example-21](./examples/eslint/example-21.javascript)

### TypeScript Integration

See [example-22](./examples/eslint/example-22.javascript)

### Jest Testing Integration

See [example-23](./examples/eslint/example-23.javascript)

## Troubleshooting

### Common Issues

#### Configuration Not Found

**Problem**: ESLint cannot locate configuration file
**Symptoms**: "No ESLint configuration found" error
**Solution**:

See [example-24](./examples/eslint/example-24.bash)

#### Parser Errors with TypeScript

**Problem**: ESLint fails to parse TypeScript files
**Symptoms**: Parsing errors or "Unexpected token" messages
**Solution**:

See [example-25](./examples/eslint/example-25.bash)

#### Performance Issues

**Problem**: ESLint runs slowly on large codebases
**Symptoms**: Long execution times, high memory usage
**Solution**:

See [example-26](./examples/eslint/example-26.bash)

#### Plugin Conflicts

**Problem**: Rules from different plugins conflict with each other
**Symptoms**: Contradictory linting messages or auto-fix loops
**Solution**:

See [example-27](./examples/eslint/example-27.javascript)

### Debug Mode

See [example-28](./examples/eslint/example-28.bash)

### Performance Optimization

See [example-29](./examples/eslint/example-29.bash)

## Security Considerations

### Security Best Practices

- **Enable security plugins** like eslint-plugin-security for vulnerability detection
- **Audit dependencies** regularly for ESLint plugins and parsers
- **Use .eslintignore** to exclude sensitive files from linting
- **Configure no-eval rule** to prevent code injection vulnerabilities
- **Enable import/no-dynamic-require** to prevent dynamic imports of untrusted code

### Sensitive Data Handling

See [example-30](./examples/eslint/example-30.javascript)

### CI/CD Security

See [example-31](./examples/eslint/example-31.yaml)

## Advanced Configuration

### Custom Rules Development

See [example-32](./examples/eslint/example-32.javascript)

### Monorepo Configuration

See [example-33](./examples/eslint/example-33.javascript)

### Performance Tuning

See [example-34](./examples/eslint/example-34.javascript)

## AI Assistant Guidelines

When helping with ESLint:

1. **Always suggest ESLint 9.0+ flat config** for new projects
2. **Provide framework-specific configurations** (React, Vue, Node.js)
3. **Include TypeScript integration** when TypeScript is detected

*Content optimized for conciseness. See source history or external references for full details.*

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
