# Common Resources

This directory contains shared instructions, personas, prompts, and documentation used across all AI coding assistants in the agentic template system.

## 📂 Directory Structure

```
common/
├── instructions/           # Coding instructions and guidelines
│   ├── languages/         # Language-specific programming instructions
│   ├── frameworks/        # Framework-specific instructions
│   ├── tools/            # Tool and platform instructions
│   ├── workflows/        # Development workflow instructions
│   ├── best-practices/   # General coding best practices
│   ├── general/          # General development instructions
│   └── boilerplate-and-templates/  # Templates and boilerplate code
├── personas/             # AI assistant personas
│   ├── languages/        # Language-specific developer personas
│   ├── frameworks/       # Framework specialist personas
│   ├── roles/           # Job role-based personas
│   ├── domains/         # Domain-specific expert personas
│   ├── platforms/       # Cloud platform specialist personas
│   └── database/        # Database specialist personas
├── prompts/             # Reusable prompts and templates
├── docs/               # Common documentation
└── skills/             # Specialized skills and capabilities
```

## 📋 Instructions

### Languages

Comprehensive programming language instructions covering modern best practices, patterns, and AI coding assistant guidelines:

- **[C](instructions/languages/c.md)** - Modern C with memory safety and RAII patterns
- **[C++](instructions/languages/cpp.md)** - Modern C++ with smart pointers and RAII
- **[C#](instructions/languages/csharp.md)** - .NET development with modern C# features
- **[Go](instructions/languages/go.md)** - Idiomatic Go with concurrency patterns
- **[Java](instructions/languages/java.md)** - Modern Java with streams and functional programming
- **[JavaScript](instructions/languages/javascript.md)** - Modern ES6+ JavaScript with async/await
- **[Python](instructions/languages/python.md)** - Modern Python 3.9+ with type hints and async
- **[Rust](instructions/languages/rust.md)** - Safe systems programming with ownership
- **[TypeScript](instructions/languages/typescript.md)** - Type-safe JavaScript development
- **[CSS](instructions/languages/css.md)** - Modern CSS with grid, flexbox, and best practices
- **[HTML](instructions/languages/html.md)** - Semantic HTML5 and accessibility
- **[Bash](instructions/languages/bash.md)** - Shell scripting best practices
- **And more...**

### Frameworks

Framework-specific instructions for popular development frameworks:

- **[Express.js](instructions/frameworks/nodejs-typescript/express-api.instructions.md)** - Node.js REST API development
- **[Azure Functions](instructions/frameworks/nodejs-typescript/azure-function-app.instructions.md)** - Serverless TypeScript functions
- **[Cobra CLI](instructions/frameworks/cobra-cli-go/charmbracelet-cli.instructions.md)** - Go CLI applications with Charm libraries

### Tools

Instructions for development tools, platforms, and infrastructure:

- **[Terraform](instructions/tools/infra-as-code/terraform/)** - Infrastructure as Code
- **[Drupal](instructions/tools/cms/drupal/)** - CMS development
- **[Database](instructions/tools/database.md)** - General database development
- **[WordPress](instructions/tools/cms/wordpress.md)** - WordPress development

### Workflows

Development workflow and process instructions:

- **[AI Development](instructions/workflows/ai-development-instructions/)** - AI-assisted development processes
  - PRD Creation
  - Task Execution
  - Task Generation

### Best Practices

General coding and development best practices:

- **[Clean Code](instructions/best-practices/clean-code.md)** - Code quality and maintainability
- **[JavaScript Style Guide](instructions/best-practices/js-style-guide.md)** - JavaScript coding standards

## 👥 Personas

AI assistant personas organized by specialization:

### Language Specialists

- **[Senior Python Developer](personas/languages/senior-python-developer.md)**
- **[Senior Go Developer](personas/languages/senior-go-developer.md)**
- **[Senior Java Developer](personas/languages/senior-java-developer.md)**
- **[JavaScript Developer](personas/languages/javascript-developer.md)**
- **[TypeScript Developer](personas/languages/typescript-developer.md)**
- **And more language specialists...**

### Framework Experts

- **[React Developer](personas/frameworks/react-developer.md)**
- **[React Native Developer](personas/frameworks/react-native-developer.md)**
- **[Bootstrap Expert](personas/frameworks/bootstrap-expert.md)**
- **[jQuery Expert](personas/frameworks/jquery-expert.md)**

### Role-Based Personas

- **[Solution Architect](personas/roles/solution-architect.md)**
- **[Backend Engineer](personas/roles/backend-engineer.md)**
- **[Frontend Engineer](personas/roles/frontend-engineer.md)**
- **[DevOps Engineer](personas/roles/devops-engineer.md)**
- **[Security Engineer](personas/roles/security-engineer.md)**
- **[Data Engineer](personas/roles/data-engineer.md)**
- **[Product Manager](personas/roles/product-manager.md)**
- **[Project Manager](personas/roles/project-manager.md)**

### Domain Experts

- **[Blockchain Developer](personas/domains/blockchain-developer.md)**
- **[AI Engineer](personas/domains/ai-engineer.md)**
- **[Mobile Developer](personas/domains/mobile-developer.md)**
- **[Game Developer](personas/domains/mobile-game-developer.md)**
- **[NLP Expert](personas/domains/nlp-expert.md)**

### Platform Specialists

- **[AWS Architect](personas/platforms/aws-architect.md)**
- **[Azure Architect](personas/platforms/azure-architect.md)**

### Database Specialists

- **[SQL Developer](personas/database/sql-developer.md)** - Multi-platform SQL expertise
- **[Database Administrator](personas/database/database-administrator.md)**
- **[Database Architect](personas/database/database-architect.md)**
- **[Database Developer](personas/database/database-developer.md)**

## 🎯 Prompts

Reusable prompts and templates for common development tasks:

- **[AI Development Tasks](prompts/ai-development-tasks/)** - Prompts for AI-assisted development workflows

## 📖 Usage Guidelines

### For AI Coding Assistants

These resources are designed to be referenced by AI coding assistants to:

- Provide consistent, high-quality code generation
- Follow established best practices and conventions
- Maintain code style and architectural patterns
- Offer domain-specific expertise

### For Developers

Use these resources to:

- Understand coding standards for different languages and frameworks
- Learn best practices for specific technologies
- Get guidance on architectural decisions
- Access role-specific expertise and workflows

### File Naming Conventions

- **Instructions**: `{topic}.md` or `{topic}.instructions.md`
- **Personas**: `{role-or-specialty}.md`
- **Prompts**: `{task-name}.prompt.md`

### Contributing

When adding new resources:

1. Follow the established directory structure
2. Use clear, descriptive naming
3. Include comprehensive examples and best practices
4. Maintain consistency with existing files
5. Update this README when adding new categories

## 🔧 Integration

These common resources are automatically provisioned to AI-specific template directories through the template provisioning system. See the main project README for details on template provisioning and deployment.

## 📝 Maintenance

This directory is actively maintained to ensure:

- Instructions reflect current best practices
- Personas are comprehensive and accurate
- Prompts are effective and well-tested
- Documentation is up-to-date and clear

For questions or contributions, please refer to the main project documentation.

## Other projects that can be downloaded and have provided some influence to this project are:

[Awesome Copilot Instructions](https://github.com/Code-and-Sorts/awesome-copilot-instructions)
[Awesome Copilot](https://github.com/github/awesome-copilot)
[Awesome Copilot Chatmodes](https://github.com/dfinke/awesome-copilot-chatmodes)
