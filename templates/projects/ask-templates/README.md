# ASK Templates Collection

This directory contains comprehensive ASK.md templates for different types of projects. These templates provide structured starting points for project requirements gathering and planning.

## Available Templates

### Web Development

- **[WordPress Plugin](wordpress-plugin-ASK.md)** - WordPress plugin development with WordPress.org integration
- **[WordPress Theme](wordpress-theme-ASK.md)** - WordPress theme development with FSE and customization features
- **[Node.js REST Router](node-rest-router-ASK.md)** - Node.js REST API development with Express/Fastify
- **[PHP REST Router](php-rest-router-ASK.md)** - PHP REST API development with Laravel/Symfony
- **[Python REST Router](python-rest-router-ASK.md)** - Python REST API development with FastAPI/Django

### AI & Machine Learning

- **[AI Agent Python](ai-agent-python-ASK.md)** - Python-based AI agent with ML/NLP capabilities
- **[AI Agent Node.js](ai-agent-node-ASK.md)** - Node.js-based AI agent with real-time features

### Data Processing & Messaging

- **[Kafka Consumer](kafka-consumer-ASK.md)** - Kafka message consumer with stream processing
- **[Kafka Producer](kafka-producer-ASK.md)** - Kafka message producer with event publishing

### Integration & Protocols

- **[MCP Server](mcp-server-ASK.md)** - Model Context Protocol server for AI integrations

## How to Use These Templates

### 1. Select the Right Template

Choose the template that best matches your project type. Each template is specifically designed for common project patterns and includes relevant sections for that domain.

### 2. Copy and Customize

1. Copy the appropriate template to your project's `project/ASK.md`
2. Replace placeholder text with your specific requirements
3. Check or uncheck items based on your needs
4. Add additional sections if needed

### 3. Work Through Systematically

- **Overview Section**: Define the core purpose and problem statement
- **Requirements Sections**: Detail functional and technical requirements
- **Architecture Sections**: Plan technical architecture and integrations
- **Success Metrics**: Define measurable success criteria
- **Constraints**: Document limitations and constraints
- **Future Enhancements**: Plan for evolution and growth

### 4. Use with Build-Plan-Run Workflow

These ASK templates integrate seamlessly with the build-plan-run workflow:

1. **ASK Phase**: Use template to gather comprehensive requirements
2. **Build Requirements**: Transform ASK into detailed REQUIREMENTS.md
3. **Plan**: Create actionable project plans with epics, stories, and tasks
4. **Run**: Execute with intelligent model selection and continuous optimization

## Template Structure

Each template follows a consistent structure:

### Core Sections

- **Project Overview** - Purpose, audience, problem statement
- **Requirements** - Functional and technical requirements
- **Architecture** - Technical architecture and technology choices
- **Integration** - External systems and API integrations
- **Security** - Authentication, authorization, and data protection
- **Performance** - Scalability and optimization requirements
- **Testing** - Quality assurance and testing strategies
- **Deployment** - Infrastructure and DevOps considerations

### Additional Sections (Domain-Specific)

- **Business Logic** (for business applications)
- **Conversational Design** (for AI agents)
- **Message Processing** (for Kafka projects)
- **Protocol Compliance** (for MCP servers)
- **WordPress Standards** (for WordPress projects)

### Common Features

- **Checkbox Lists** - Easy requirement tracking
- **Questions & Clarifications** - Capture unknowns and decisions needed
- **Notes & Ideas** - Brainstorming and inspiration capture
- **Success Metrics** - Measurable outcomes and KPIs
- **Constraints & Limitations** - Technical and business constraints
- **Future Enhancements** - Evolution and roadmap planning

## Best Practices

### Requirements Gathering

1. **Be Specific** - Replace generic placeholders with concrete requirements
2. **Prioritize** - Mark requirements as must-have, should-have, or nice-to-have
3. **Think End-to-End** - Consider the complete user journey and system flow
4. **Include Stakeholders** - Gather input from all relevant team members and users

### Technical Planning

1. **Consider Constraints Early** - Document technical and business limitations upfront
2. **Plan for Scale** - Consider future growth and scaling requirements
3. **Security First** - Include security considerations throughout the planning
4. **Performance Budgets** - Set concrete performance targets and requirements

### Validation and Review

1. **Regular Reviews** - Schedule periodic ASK reviews and updates
2. **Stakeholder Validation** - Confirm requirements with stakeholders
3. **Technical Feasibility** - Validate technical approach and constraints
4. **Business Alignment** - Ensure alignment with business goals and metrics

## Integration with AI Agents

### Model Recommendations

Each template includes model recommendations for different aspects:

- **High/Technical** tasks: GPT-4, Claude-3-Opus
- **Moderate/Creative** tasks: Claude-3-Sonnet
- **Specialized** tasks: Domain-specific model suggestions

### Persona Mappings

Templates reference relevant personas from the `common/personas/` directory:

- **Developer personas** for technical implementation
- **Designer personas** for UX and interface design
- **Business personas** for requirements and strategy
- **Specialist personas** for domain expertise

### Workflow Integration

Templates are designed to work with:

- **Dynamic Model Selection** - Intelligent model routing based on task complexity
- **Build-Plan-Run Workflow** - Complete development lifecycle management
- **JIRA Integration** - Export to project management tools
- **Documentation Generation** - Automatic documentation creation

## Contributing

To contribute new templates or improve existing ones:

1. **Follow the Structure** - Use the established template format and sections
2. **Domain Expertise** - Include domain-specific best practices and considerations
3. **Comprehensive Coverage** - Cover all aspects from planning to deployment
4. **Clear Examples** - Provide clear placeholder text and examples
5. **Integration Ready** - Ensure compatibility with build-plan-run workflow

## Version History

- **v1.0** - Initial release with 10 comprehensive project templates
- **Future** - Additional templates for mobile development, blockchain, IoT, and more

---

These templates provide a solid foundation for project planning and requirements gathering. They're designed to work seamlessly with the agentic template system and intelligent model selection to accelerate development from initial concept to production deployment.
