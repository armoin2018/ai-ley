---
title: 'EditorConfig Cross-Editor Consistency Instructions'
description: 'Comprehensive guide for using EditorConfig to maintain consistent coding styles across different editors and IDEs in team development environments'
category: 'Development Tools'

tags:
  [
    'editorconfig',
    'code-style',
    'editor-consistency',
    'team-development',
    'cross-platform',
    'ide-integration',
    'formatting',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/.editorconfig'
  - '**/editor.config'
  - '**/.*rc'
  - '**/package.json'
---

# EditorConfig Cross-Editor Consistency Instructions

## Tool Overview

- **Tool Name**: EditorConfig
- **Version**: 0.15.0+ (Latest specification with enhanced language support)
- **Category**: Development Tools - Editor Configuration
- **Purpose**: Maintains consistent coding styles across different editors and IDEs in team environments
- **Prerequisites**: Compatible editor or IDE with EditorConfig plugin support

## When to Use EditorConfig

### ✅ **Use EditorConfig When**

- Working in team environments with developers using different editors and IDEs
- Need to enforce consistent indentation, line endings, and character encoding across projects
- Want to standardize basic formatting rules without forcing specific editor choices
- Working on cross-platform projects requiring consistent file formatting
- Contributing to open source projects with established style guidelines
- Need basic style enforcement that works independently of language-specific tools
- Want to establish baseline formatting before adding advanced linting tools
- Working with multiple programming languages in a single project

### ❌ **Avoid EditorConfig When**

- Working solo with a single editor and consistent personal preferences
- Need advanced linting and formatting beyond basic style rules
- Project already has comprehensive formatting tools that handle all style requirements
- Working with editors that don't support EditorConfig and can't install plugins
- Need dynamic formatting rules that change based on code context
- Team prefers language-specific formatters like Prettier, Black, or rustfmt exclusively

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | EditorConfig Recommendation                   | Configuration Priority         |
| ---------------------- | --------------------------------------------- | ------------------------------ |
| Multi-Language Project | ✅ **Essential** - Cross-language consistency | High - Complete style coverage |
| Team Development       | ✅ **Essential** - Editor-agnostic standards  | High - Comprehensive rules     |
| Open Source Project    | ✅ **Essential** - Contributor consistency    | High - Clear guidelines        |
| Enterprise Application | ✅ **Recommended** - Professional standards   | Medium - Core style rules      |
| Personal Project       | 🔄 **Consider** - Good practice habits        | Low - Basic formatting         |
| Legacy Codebase        | ✅ **Recommended** - Gradual standardization  | Medium - Incremental adoption  |

### Team Diversity Assessment

| Factor                | Low Diversity      | Medium Diversity | High Diversity        |
| --------------------- | ------------------ | ---------------- | --------------------- |
| **Editor Variety**    | 1-2 editors        | 3-4 editors      | 5+ different editors  |
| **Platform Mix**      | Single OS          | 2 platforms      | Cross-platform team   |
| **Experience Levels** | Similar experience | Mixed experience | Wide range            |
| **Setup Complexity**  | 5 minutes          | 15 minutes       | 30+ minutes (plugins) |

## Installation & Setup

### EditorConfig File Creation

```bash
# Create .editorconfig in project root
touch .editorconfig

# Alternative: create in subdirectories for specific rules
mkdir -p src/frontend
touch src/frontend/.editorconfig

# Verify file placement
find . -name ".editorconfig" -type f
```

### Editor Plugin Installation

#### Visual Studio Code

```bash
# Install EditorConfig extension
code --install-extension EditorConfig.EditorConfig

# Verify installation
code --list-extensions | grep EditorConfig
```

#### JetBrains IDEs (IntelliJ, WebStorm, PyCharm)

```text
Built-in support (no plugin required)
File → Settings → Editor → Code Style → EditorConfig
Enable "Enable EditorConfig support"
```

#### Vim/Neovim

```bash
# Install via vim-plug
# Add to .vimrc or init.vim:
Plug 'editorconfig/editorconfig-vim'

# Install via Vundle
Plugin 'editorconfig/editorconfig-vim'

# Manual installation
git clone https://github.com/editorconfig/editorconfig-vim.git ~/.vim/bundle/editorconfig-vim
```

#### Sublime Text

```bash
# Install Package Control, then:
# Package Control: Install Package
# Search for "EditorConfig"
```

#### Atom

```bash
# Install EditorConfig package
apm install editorconfig
```

## Configuration

### Basic .editorconfig Configuration

```ini
# .editorconfig - Root configuration file

# Indicate this is the root EditorConfig file
root = true

# All files
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

# Override for specific file types
[*.{js,jsx,ts,tsx}]
indent_size = 2

[*.{py,pyi}]
indent_size = 4

[*.{java,kotlin,scala}]
indent_size = 4

[*.{go}]
indent_style = tab
indent_size = 4

[*.{yaml,yml}]
indent_size = 2

[*.{md,markdown}]
trim_trailing_whitespace = false

[*.{bat,cmd}]
end_of_line = crlf

[Makefile]
indent_style = tab
```

### Advanced Multi-Language Configuration

```ini
# .editorconfig - Comprehensive multi-language setup

root = true

# Default settings for all files
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

# Web Development
[*.{html,htm,xhtml}]
indent_size = 2

[*.{css,scss,sass,less,styl}]
indent_size = 2

[*.{js,jsx,mjs,cjs}]
indent_size = 2

[*.{ts,tsx}]
indent_size = 2

[*.{vue,svelte}]
indent_size = 2

# Backend Languages
[*.{py,pyi,pyw}]
indent_size = 4
max_line_length = 88

[*.{java,kt,kts}]
indent_size = 4

[*.{cs,vb}]
indent_size = 4

[*.{php,phtml}]
indent_size = 4

[*.{rb,rake,gemspec}]
indent_size = 2

[*.go]
indent_style = tab
indent_size = 4

[*.rs]
indent_size = 4

[*.{c,cpp,cc,cxx,h,hpp}]
indent_size = 4

# Data and Configuration
[*.{json,jsonc}]
indent_size = 2

[*.{yaml,yml}]
indent_size = 2

[*.{xml,xsd,xsl,xslt}]
indent_size = 2

[*.{toml,ini,cfg}]
indent_size = 4

# Documentation
[*.{md,markdown,mdown,mkd}]
trim_trailing_whitespace = false
indent_size = 2

[*.{rst,txt}]
indent_size = 4

# Database
[*.sql]
indent_size = 2

# Shell scripts
[*.{sh,bash,zsh,fish}]
indent_size = 2

[*.{ps1,psm1,psd1}]
indent_size = 4

# Windows specific
[*.{bat,cmd}]
end_of_line = crlf
indent_size = 4

# Build files
[{Makefile,makefile,GNUmakefile}]
indent_style = tab
indent_size = 4

[*.{gradle,groovy}]
indent_size = 4

[{CMakeLists.txt,*.cmake}]
indent_size = 2

# Docker
[{Dockerfile,*.dockerfile}]
indent_size = 2

# Version control
[.gitignore]
indent_size = 2

[.gitattributes]
indent_size = 2
```

### Project-Specific Configuration Examples

#### React/TypeScript Project

```ini
# .editorconfig for React/TypeScript project

root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

# JavaScript/TypeScript files
[*.{js,jsx,ts,tsx}]
indent_style = space
indent_size = 2

# JSON files
[*.{json,jsonc}]
indent_style = space
indent_size = 2

# CSS/SCSS files
[*.{css,scss,sass}]
indent_style = space
indent_size = 2

# HTML files
[*.{html,htm}]
indent_style = space
indent_size = 2

# Configuration files
[*.{yml,yaml}]
indent_style = space
indent_size = 2

# Markdown (preserve trailing spaces for line breaks)
[*.md]
trim_trailing_whitespace = false
indent_style = space
indent_size = 2

# Package files
[package.json]
indent_style = space
indent_size = 2
```

#### Python Project

```ini
# .editorconfig for Python project

root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

# Python files (PEP 8 compliance)
[*.{py,pyi,pyw}]
indent_style = space
indent_size = 4
max_line_length = 88

# Python configuration
[*.{cfg,ini}]
indent_style = space
indent_size = 4

# Requirements files
[requirements*.txt]
indent_style = space
indent_size = 2

# YAML files (Docker, CI/CD)
[*.{yml,yaml}]
indent_style = space
indent_size = 2

# TOML files (pyproject.toml)
[*.toml]
indent_style = space
indent_size = 4

# Dockerfile
[Dockerfile*]
indent_style = space
indent_size = 2

# Markdown
[*.md]
trim_trailing_whitespace = false
indent_style = space
indent_size = 2
```

## Core Features

### Character Encoding Standardization

- **Purpose**: Ensures consistent character encoding across all files in the project
- **Usage**: Prevents encoding-related issues in multi-developer environments
- **Example**:

```ini
[*]
charset = utf-8  # Forces UTF-8 encoding for all files

[*.{bat,cmd}]
charset = utf-8-bom  # Windows batch files with BOM
```

### Line Ending Normalization

- **Purpose**: Standardizes line endings across different operating systems
- **Usage**: Prevents Git conflicts and ensures consistent file format
- **Example**:

```ini
[*]
end_of_line = lf  # Unix-style line endings (recommended)

[*.{bat,cmd}]
end_of_line = crlf  # Windows scripts require CRLF

[*.ps1]
end_of_line = crlf  # PowerShell scripts
```

### Indentation Consistency

- **Purpose**: Enforces consistent indentation style and size across editors
- **Usage**: Eliminates mixed tabs/spaces and inconsistent indentation
- **Example**:

```ini
# Standard 2-space indentation
[*.{js,ts,css,html}]
indent_style = space
indent_size = 2

# 4-space indentation for backend languages
[*.{py,java,cs}]
indent_style = space
indent_size = 4

# Tab indentation for specific languages
[*.go]
indent_style = tab
indent_size = 4
```

### Whitespace Management

- **Purpose**: Controls trailing whitespace and final newlines
- **Usage**: Maintains clean file formatting and prevents unnecessary diffs
- **Example**:

```ini
[*]
trim_trailing_whitespace = true
insert_final_newline = true

# Exception for Markdown (preserves intentional trailing spaces)
[*.md]
trim_trailing_whitespace = false
```

## Common Commands

```bash
# Essential file operations
touch .editorconfig                   # Create EditorConfig file
cp .editorconfig backup/.editorconfig # Backup configuration
find . -name ".editorconfig"          # Find all EditorConfig files

# Validation and testing
editorconfig-checker .                # Check files against EditorConfig
editorconfig-tools check .            # Validate EditorConfig syntax
editorconfig-tools format .           # Auto-format files

# Integration commands
git add .editorconfig                 # Add to version control
git commit -m "Add EditorConfig"      # Commit configuration
echo ".editorconfig" >> .gitignore    # Exclude from tracking (not recommended)

# Editor integration verification
code .editorconfig                    # Edit in VS Code
vim .editorconfig                     # Edit in Vim
```

## Workflow Integration

### Development Workflow

1. **Setup**: Create `.editorconfig` file in project root with team-agreed standards
2. **Editor Configuration**: Install EditorConfig plugins in all team editors
3. **Development**: Automatic formatting applied as developers work
4. **Quality Assurance**: Consistent style maintained across all contributions
5. **CI/CD**: Optional validation checks to ensure compliance

### Team Onboarding Workflow

```bash
# New team member setup
git clone project-repository
cd project-repository

# Verify EditorConfig presence
ls -la .editorconfig

# Install editor plugin (VS Code example)
code --install-extension EditorConfig.EditorConfig

# Verify plugin is working
echo "Testing EditorConfig..." > test.js
# Open test.js in editor - should apply configured formatting

# Clean up test
rm test.js
```

### Git Hooks Integration

```bash
# .husky/pre-commit - Validate EditorConfig compliance
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check EditorConfig compliance
if command -v editorconfig-checker >/dev/null 2>&1; then
    echo "🔍 Checking EditorConfig compliance..."
    editorconfig-checker

    if [ $? -ne 0 ]; then
        echo "❌ EditorConfig violations found. Please fix formatting issues."
        exit 1
    fi
    echo "✅ EditorConfig compliance verified"
fi
```

### CI/CD Integration

```yaml
# .github/workflows/editorconfig.yml
name: EditorConfig Validation
on: [push, pull_request]

jobs:
  editorconfig:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install EditorConfig Checker
        run: |
          wget https://github.com/editorconfig-checker/editorconfig-checker/releases/latest/download/ec-linux-amd64.tar.gz
          tar -xzf ec-linux-amd64.tar.gz
          sudo mv bin/ec-linux-amd64 /usr/local/bin/editorconfig-checker

      - name: Check EditorConfig
        run: |
          editorconfig-checker

      - name: Report Results
        if: failure()
        run: |
          echo "EditorConfig violations detected. Please ensure your editor has EditorConfig support enabled."
          echo "See https://editorconfig.org/ for setup instructions."
```

## Best Practices

### ✅ **Configuration Best Practices**

- **Place root file strategically** - Put main `.editorconfig` at project root with `root = true`
- **Use specific patterns** - Target specific file types rather than overly broad patterns
- **Document team standards** - Include comments explaining non-obvious choices
- **Test across editors** - Verify configuration works with all team members' editors
- **Keep it simple** - Focus on essential formatting rules, avoid over-configuration
- **Version control inclusion** - Always commit `.editorconfig` to repository

### ✅ **Pattern Matching Best Practices**

- **Be specific with extensions** - Use `*.{js,jsx,ts,tsx}` instead of `*` when possible
- **Consider file naming conventions** - Account for common file naming patterns
- **Handle special cases** - Explicitly configure exceptions like Makefiles or batch files
- **Use hierarchical configs** - Place specific `.editorconfig` files in subdirectories when needed
- **Test pattern matching** - Verify patterns match intended files correctly
- **Document complex patterns** - Add comments for non-obvious pattern choices

### ✅ **Team Collaboration**

- **Establish before coding** - Set up EditorConfig early in project lifecycle
- **Communicate requirements** - Ensure all team members understand and install plugins
- **Provide setup documentation** - Include editor-specific setup instructions in README
- **Regular compliance checks** - Use automated tools to verify ongoing compliance
- **Handle legacy code gradually** - Apply standards incrementally to existing codebases
- **Consider language conventions** - Align with established conventions for each language

### ❌ **Common Pitfalls to Avoid**

- **Don't over-specify** - Avoid configuring every possible option when defaults work
- **Avoid conflicting tools** - Ensure EditorConfig doesn't conflict with Prettier or similar tools
- **Don't ignore editor differences** - Test configuration across different editors used by team
- **Avoid platform assumptions** - Consider cross-platform development requirements
- **Don't skip plugin installation** - Verify all team members have proper editor support
- **Avoid inconsistent hierarchies** - Maintain clear and logical configuration hierarchy

## Advanced EditorConfig Usage

### Hierarchical Configuration

```ini
# Root .editorconfig
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

# General defaults
[*.{js,ts,css,html}]
indent_style = space
indent_size = 2
```

```ini
# src/legacy/.editorconfig - Override for legacy code
[*]
# Inherit from parent, but don't enforce trailing whitespace removal
trim_trailing_whitespace = false

[*.js]
# Legacy JavaScript uses 4-space indentation
indent_size = 4
```

### Complex Pattern Matching

```ini
# Advanced pattern examples

# Multiple extensions with braces
[*.{js,jsx,ts,tsx,vue,svelte}]
indent_size = 2

# Glob patterns for specific directories
[src/**/*.{py,pyi}]
indent_size = 4

# Negation patterns (files to exclude)
[{package-lock.json,yarn.lock}]
# No formatting rules for lock files

# Specific filenames
[{Dockerfile,docker-compose.yml,docker-compose.yaml}]
indent_size = 2

# Complex directory patterns
[{test,tests,spec,specs}/**/*.{js,ts}]
# Test files might have different rules

# File path patterns
[scripts/*.{sh,bash}]
indent_size = 2
end_of_line = lf

# Configuration file patterns
[{.*rc,*.config.{js,ts,json}}]
indent_size = 2
```

### Language-Specific Advanced Rules

```ini
# Language-specific advanced configurations

# Python with PEP 8 compliance
[*.{py,pyi,pyw}]
indent_style = space
indent_size = 4
max_line_length = 88
trim_trailing_whitespace = true

# Go with standard formatting
[*.go]
indent_style = tab
indent_size = 4
max_line_length = 120

# Rust formatting
[*.rs]
indent_style = space
indent_size = 4
max_line_length = 100

# Java/Kotlin enterprise standards
[*.{java,kt,kts}]
indent_style = space
indent_size = 4
max_line_length = 120

# C/C++ with specific style
[*.{c,cpp,cc,cxx,h,hpp}]
indent_style = space
indent_size = 4
max_line_length = 100

# Ruby conventions
[*.{rb,rake,gemspec}]
indent_style = space
indent_size = 2
max_line_length = 120

# PHP standards
[*.{php,phtml}]
indent_style = space
indent_size = 4
max_line_length = 120
```

## Integration with Other Tools

### Prettier Integration

```json
// .prettierrc.json - Coordinated with EditorConfig
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "useTabs": false,
  "trailingComma": "es5",
  "endOfLine": "lf"
}
```

```ini
# .editorconfig - Compatible with Prettier
[*.{js,jsx,ts,tsx,json,css,scss,md}]
indent_style = space
indent_size = 2
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false  # Prettier handles this
```

### ESLint Integration

```json
// .eslintrc.json - Uses EditorConfig for base formatting
{
  "extends": ["eslint:recommended", "@typescript-eslint/recommended"],
  "rules": {
    "indent": ["error", 2], // Matches EditorConfig
    "linebreak-style": ["error", "unix"], // Matches end_of_line = lf
    "quotes": ["error", "single"],
    "semi": ["error", "always"]
  }
}
```

### VS Code Settings Integration

```json
// .vscode/settings.json - Respects EditorConfig
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "files.eol": "
",
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,
  "editor.detectIndentation": false,  // Use EditorConfig instead
  "editor.insertSpaces": true,
  "editor.tabSize": 2
}
```

### Git Configuration Integration

```ini
# .gitattributes - Coordinates with EditorConfig
* text=auto eol=lf

# Binary files
*.png binary
*.jpg binary
*.pdf binary

# Text files with specific handling
*.md text eol=lf
*.sh text eol=lf
*.bat text eol=crlf
*.ps1 text eol=crlf

# Generated files
package-lock.json linguist-generated=true
yarn.lock linguist-generated=true
```

## Troubleshooting

### Common Issues

#### EditorConfig Not Working

**Problem**: Editor not applying EditorConfig rules
**Symptoms**: Indentation and formatting not changing according to configuration
**Solution**:

```bash
# Check if .editorconfig file exists and is properly placed
ls -la .editorconfig

# Verify file content and syntax
cat .editorconfig

# Check editor plugin installation
# VS Code:
code --list-extensions | grep EditorConfig

# Restart editor after plugin installation
# Close and reopen all files to apply new rules
```

#### Conflicting Formatting Tools

**Problem**: EditorConfig conflicts with Prettier, ESLint, or other formatters
**Symptoms**: Inconsistent formatting or constant format changes
**Solution**:

```bash
# Check tool configurations for compatibility
cat .prettierrc.json
cat .editorconfig

# Align configurations
# Example: Make sure indent_size matches Prettier tabWidth
# Example: Ensure end_of_line matches Prettier endOfLine

# Use .editorconfig-ignore for problematic files
echo "generated/**" >> .editorconfig-ignore
```

#### Platform-Specific Issues

**Problem**: Different behavior on Windows, macOS, and Linux
**Symptoms**: Line ending conflicts or encoding issues
**Solution**:

```ini
# .editorconfig - Cross-platform compatibility
[*]
charset = utf-8
end_of_line = lf  # Use LF for most files

# Exception for Windows-specific files
[*.{bat,cmd,ps1}]
end_of_line = crlf

# Git configuration to handle line endings
# git config core.autocrlf input  # On macOS/Linux
# git config core.autocrlf true   # On Windows
```

#### Pattern Matching Issues

**Problem**: Rules not applying to expected files
**Symptoms**: Some files not following EditorConfig rules
**Solution**:

```bash
# Test pattern matching
# Create test files and check if rules apply

# Debug pattern syntax
# Use specific patterns instead of complex globs
[*.js]        # Instead of [**/*.js]
[src/*.py]    # Instead of [src/**/*.py]

# Check for typos in file extensions
[*.{js,jsx,ts,tsx}]  # Correct
[*.{js,jsx,ts,tsx]   # Missing closing brace - incorrect
```

### Debug Mode

```bash
# Validate EditorConfig file syntax
editorconfig-checker --version
editorconfig-checker .editorconfig

# Test specific files
editorconfig-checker src/component.js

# Verbose output
editorconfig-checker --verbose .

# Check what rules apply to specific files
editorconfig-tools query src/component.js
```

### Performance Optimization

```ini
# Optimize large projects
[*]
# Use minimal essential rules
charset = utf-8
end_of_line = lf
insert_final_newline = true

# Avoid overly complex patterns
[*.js]  # Better than [**/*.{js,jsx,ts,tsx,vue,svelte}]

# Use directory-specific configs for performance
# Place .editorconfig in subdirectories instead of complex root patterns
```

## Security Considerations

### Security Best Practices

- **Validate configuration sources** - Only use trusted `.editorconfig` files from known sources
- **Review inherited configurations** - Check parent directory configurations in complex projects
- **Limit file access scope** - Use specific patterns to avoid affecting system files
- **Protect against malicious patterns** - Avoid patterns that could match sensitive files
- **Version control security** - Ensure `.editorconfig` is properly tracked and reviewed
- **Plugin security** - Keep editor plugins updated to latest secure versions

### File Access Control

```ini
# Safe pattern examples
[src/**/*.{js,ts}]  # Limited to src directory
[*.{js,ts,css}]     # Specific file types only

# Avoid overly broad patterns
# [**/*]            # Too broad - could affect system files
# [.*]              # Could affect hidden system files

# Safe project-specific patterns
[{src,test,docs}/**/*]  # Explicit directory list
[!node_modules/**]      # Exclude dependencies
```

### Configuration Validation

```bash
# Validate EditorConfig files before committing
editorconfig-checker .editorconfig

# Automated validation in CI
npm install --save-dev editorconfig-checker
echo "editorconfig-checker" >> package.json scripts.lint

# Pre-commit hook validation
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Validate EditorConfig
if command -v editorconfig-checker >/dev/null 2>&1; then
    editorconfig-checker
fi
EOF
```

## AI Assistant Guidelines

When helping with EditorConfig:

1. **Always suggest placing `.editorconfig` at project root** with `root = true` directive
2. **Provide language-specific configurations** that follow established conventions for each language
3. **Include cross-platform considerations** for line endings and character encoding
4. **Suggest integration patterns** with popular formatting tools like Prettier and ESLint
5. **Provide debugging strategies** for editor plugin issues and pattern matching problems
6. **Include team onboarding guidance** for ensuring all developers have proper setup
7. **Reference security considerations** for file patterns and configuration validation
8. **Suggest automation opportunities** with Git hooks and CI/CD integration

### Code Generation Rules

- Generate `.editorconfig` files with clear section organization and comments
- Include appropriate patterns for the specific technology stack and project structure
- Provide cross-platform compatible settings with proper line ending configuration
- Follow established language conventions for indentation and formatting
- Include validation mechanisms and testing approaches for generated configurations
- Generate editor-specific setup instructions and troubleshooting guides
- Provide integration examples with popular development tools and workflows
- Include security considerations and best practices in generated configurations

## Installation & Setup

### EditorConfig File Creation

```bash
# Create .editorconfig in project root
touch .editorconfig

# Alternative: create in subdirectories for specific rules
mkdir -p src/frontend
touch src/frontend/.editorconfig

# Verify file placement
find . -name ".editorconfig" -type f
```

### Editor Plugin Installation

#### Visual Studio Code

```bash
# Install EditorConfig extension
code --install-extension EditorConfig.EditorConfig

# Verify installation
code --list-extensions | grep EditorConfig
```

#### JetBrains IDEs (IntelliJ, WebStorm, PyCharm)

```text
Built-in support (no plugin required)
File → Settings → Editor → Code Style → EditorConfig
Enable "Enable EditorConfig support"
```

#### Vim/Neovim

```bash
# Install via vim-plug
# Add to .vimrc or init.vim:
Plug 'editorconfig/editorconfig-vim'

# Install via Vundle
Plugin 'editorconfig/editorconfig-vim'

# Manual installation
git clone https://github.com/editorconfig/editorconfig-vim.git ~/.vim/bundle/editorconfig-vim
```

#### Sublime Text

```bash
# Install Package Control, then:
# Package Control: Install Package
# Search for "EditorConfig"
```

#### Atom

```bash
# Install EditorConfig package
apm install editorconfig
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
