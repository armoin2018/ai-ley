---
name: 'Phpunit.Instructions'
description: 'Development guidelines and best practices for Phpunit.Instructions'
keywords: [.toolrc,, [config, commands, applicable), assistant, (e.g.,, configuration, analysis, advanced, commit]
---



# Tool Instructions Template

## Tool Overview
- **Tool Name**: [Name of the tool]
- **Version**: [Current stable version or version range]
- **Category**: [Development, Testing, Deployment, Monitoring, etc.]
- **Purpose**: [Primary use case and problem it solves]
- **Prerequisites**: [Required dependencies or tools]

## Installation & Setup
### Package Manager Installation
See [example-1](./examples/phpunit/example-1.bash)

### Project Integration
See [example-2](./examples/phpunit/example-2.bash)

## Configuration
### Configuration File
```[config-format]
# [config-file-name] (e.g., .toolrc, tool.config.js, tool.yaml)
[configuration-example]
See [example-3](./examples/phpunit/example-3.txt)bash
# Environment-specific settings
[TOOL_ENV_VAR]=[value]
[TOOL_CONFIG_PATH]=[path]
See [example-4](./examples/phpunit/example-4.txt)bash
# Global configuration
[tool] config set [option] [value]

# Project-specific configuration
[tool] config --local [option] [value]
See [example-5](./examples/phpunit/example-5.txt)bash
[tool] [command] [options]
See [example-6](./examples/phpunit/example-6.txt)bash
[tool] [command] [options]
See [example-7](./examples/phpunit/example-7.txt)bash
[tool] [command] [options]
See [example-8](./examples/phpunit/example-8.txt)bash
# Essential daily commands
[tool] [basic-command]              # Description
[tool] [frequent-command] [options] # Description
[tool] [status-command]             # Check status
[tool] [help-command]               # Get help

# Advanced operations
[tool] [advanced-command] [options] # Description
[tool] [config-command]             # Configuration management
[tool] [debug-command]              # Debugging and troubleshooting
See [example-9](./examples/phpunit/example-9.txt)bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
See [example-10](./examples/phpunit/example-10.txt)bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
See [example-11](./examples/phpunit/example-11.txt)bash
[tool] [specific-commands]
See [example-12](./examples/phpunit/example-12.txt)bash
[tool] [specific-commands]
See [example-13](./examples/phpunit/example-13.txt)bash
[tool] [specific-commands]
See [example-14](./examples/phpunit/example-14.txt)bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
See [example-15](./examples/phpunit/example-15.txt)[config-format]
# Plugin configuration
[plugin-config-example]
See [example-16](./examples/phpunit/example-16.txt)bash
# Advanced scripting examples
[automation-script-example]
See [example-17](./examples/phpunit/example-17.txt)[config-format]
# Performance optimization settings
[performance-config-example]
See [example-18](./examples/phpunit/example-18.txt)[language]
// Example usage in context
[practical-example]
See [example-19](./examples/phpunit/example-19.txt)[language]
// Advanced usage pattern
[advanced-example]
See [example-20](./examples/phpunit/example-20.txt)[format]
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

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
