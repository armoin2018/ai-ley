# ASK-003: Model-Driven AI Agent Instruction System

**Date Created**: 2025-09-19  
**Status**: READY_FOR_INTEGRATION  
**Priority**: High  
**Type**: Major Architecture Enhancement  
**Source**: User Request - AI Agent Workflow System

## Original Ask

"adapt the nodes and flows to be model driven that are used to instruct the AI agents."

Comprehensive requirements including:

- Model-driven folder structure: `(nodes|flows)/(author)/{moduleName}.{moduleVersion}.md`
- Node models with name, label, colors, version, dependencies, endpoints, fields, documentation, plantuml
- Flow models with name, label, color, version, dependencies, documentation, plantuml
- Template generation for nodes and flows
- Markdown-driven approach replacing PlantUML editing
- Form-based creation from templates
- Compile button to generate PlantUML files
- Execute dropdown with AI systems integration and `/run-flow` command

## Analysis & Categorization

**Category**: Major Architecture Enhancement - High Priority  
**Scope**: Complete redesign of visual editor from direct manipulation to model-driven approach  
**Technical Complexity**: High - New architecture, file system integration, template system, compilation pipeline  
**Business Impact**: Transforms tool from visual editor to AI agent instruction platform

## Requirement Definition

**R36: Model-Driven AI Agent Instruction System**

**Description**: Transform the visual flow editor into a model-driven system where nodes and flows are defined through structured markdown models, compiled to PlantUML, and executed through AI agent systems.

**Acceptance Criteria**:

- [ ] Folder structure implemented: `(nodes|flows)/(author)/{moduleName}.{moduleVersion}.md`
- [ ] Node model schema includes all required fields (name, label, colors, version, dependencies, endpoints, fields, documentation, plantuml)
- [ ] Flow model schema includes all required fields (name, label, color, version, dependencies, documentation, plantuml)
- [ ] Template generation system for both node and flow models
- [ ] Form-based editors replace direct PlantUML manipulation
- [ ] Compile functionality generates PlantUML files to `.ai-ley/shared/uml-flows/user/{flowName}.puml`
- [ ] Execute dropdown integrates with enabled AI systems (CLI and API)
- [ ] `/run-flow {flowName}` command execution with compiled flow requirement
- [ ] Version control and dependency management for models
- [ ] Endpoint validation (input, output, success, failure, valid, invalid, true, false, debug, error)

**Priority**: High  
**Complexity**: Expert  
**Dependencies**: R30 (Scoped Storage System), R35 (Secure Path Construction)  
**Source**: ASK-003 - 2025-09-19 - Model-driven AI agent instruction system

## User Stories

### US13: Model-Driven Node Creation

**As an** AI workflow designer  
**I want** to create nodes using structured markdown models with templates  
**So that** I can define reusable, versioned AI instruction components

**Acceptance Criteria**:

- [ ] Template-based node creation form
- [ ] All required fields captured (name, label, colors, endpoints, etc.)
- [ ] Model saved to structured folder path
- [ ] Version management for node modules

### US14: Model-Driven Flow Creation

**As an** AI workflow designer  
**I want** to create flows using structured markdown models  
**So that** I can compose AI agent instruction sequences

**Acceptance Criteria**:

- [ ] Template-based flow creation form
- [ ] Flow dependency management
- [ ] Color and visual customization
- [ ] Documentation integration

### US15: Flow Compilation and Execution

**As an** AI workflow operator  
**I want** to compile models to PlantUML and execute through AI systems  
**So that** I can run structured AI agent workflows

**Acceptance Criteria**:

- [ ] Compile button generates valid PlantUML
- [ ] Execute dropdown shows enabled AI systems
- [ ] `/run-flow` command integration
- [ ] Flow validation before execution

## Technical Implementation Details

### Folder Structure

```
.ai-ley/shared/models/
├── nodes/
│   └── {author}/
│       └── {moduleName}.{moduleVersion}.md
└── flows/
    └── {author}/
        └── {moduleName}.{moduleVersion}.md
```

### Node Model Schema

````markdown
# Node: {moduleName} v{moduleVersion}

## Metadata

- **Name**: {name}
- **Label**: {displayLabel}
- **Author**: {author}
- **Version**: {semantic.version}
- **Created**: {ISO.date}
- **Updated**: {ISO.date}

## Visual Properties

- **Body Color**: {hex.color}
- **Text Color**: {hex.color}
- **Border Color**: {hex.color}
- **Line Color**: {hex.color}

## Dependencies

```yaml
dependencies:
  - module: { dependency.module }
    version: { dependency.version }
    type: { node|flow }
```
````

## Endpoints

```yaml
endpoints:
  - name: { endpoint.name }
    type: { input|output|success|failure|valid|invalid|true|false|debug|error }
    description: { endpoint.description }
```

## Fields

```yaml
fields:
  - name: { field.name }
    type: { string|number|boolean|select|textarea }
    label: { field.label }
    required: { boolean }
    default: { field.default }
    options: [{ option.list }] # for select type
```

## Documentation

{markdown.documentation}

## PlantUML

```plantuml
{generated.plantuml}
```

````

### Flow Model Schema
```markdown
# Flow: {moduleName} v{moduleVersion}

## Metadata
- **Name**: {name}
- **Label**: {displayLabel}
- **Author**: {author}
- **Version**: {semantic.version}
- **Created**: {ISO.date}
- **Updated**: {ISO.date}

## Visual Properties
- **Tab Color**: {hex.color}

## Dependencies
```yaml
dependencies:
  - module: {dependency.module}
    version: {dependency.version}
    type: {node|flow}
````

## Documentation

{markdown.documentation}

## PlantUML

```plantuml
{generated.plantuml}
```

```

### Compilation Pipeline
1. **Model Validation**: Validate markdown model structure and dependencies
2. **Dependency Resolution**: Ensure all dependencies are available
3. **PlantUML Generation**: Convert model to PlantUML syntax
4. **File Output**: Write to `.ai-ley/shared/uml-flows/user/{flowName}.puml`
5. **Validation**: Verify generated PlantUML syntax

### Execution Integration
1. **AI System Discovery**: Scan for enabled CLI and API AI systems
2. **Flow Validation**: Ensure flow is compiled and valid
3. **Command Generation**: Create `/run-flow {flowName}` command
4. **System Selection**: User selects AI system from dropdown
5. **Execution**: Execute command through selected AI system

## Architecture Considerations

**Model-Driven Benefits**:
- Version control and dependency management
- Reusable component library
- Structured documentation
- Validation and type safety
- Automated code generation

**Migration Strategy**:
- Maintain backward compatibility with existing flows
- Provide migration tools for existing PlantUML flows
- Gradual transition from visual editor to model-driven approach

**Performance Considerations**:
- Lazy loading of model definitions
- Caching of compiled PlantUML
- Incremental compilation for dependency changes

## Quality Assurance

**Testing Requirements**:
- [ ] Model schema validation tests
- [ ] Template generation tests
- [ ] Compilation pipeline tests
- [ ] AI system integration tests
- [ ] File system security tests
- [ ] Cross-platform compatibility tests

**Definition of Done**:
- [ ] Complete model-driven architecture implemented
- [ ] Templates and forms functional
- [ ] Compilation generates valid PlantUML
- [ ] Execution integrates with AI systems
- [ ] Documentation and examples provided
- [ ] Migration path from existing system

## Related Requirements

**Enhances**: R4 (Node Type Specifications), R7 (PlantUML Export Specification)
**Depends On**: R30 (Scoped Storage System), R35 (Secure Path Construction)
**Enables**: Advanced AI agent workflow composition and execution
```
