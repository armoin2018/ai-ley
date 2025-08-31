# Instruction Template Standards

## Purpose and Scope

This document defines the standardized structure and requirements for AI agent instruction templates. All instruction templates should follow this format to ensure consistency, reduce duplication, and optimize for AI agent effectiveness.

## Template Categories

### 1. **Technology-Specific Templates**

- **Purpose**: Instructions for specific programming languages, frameworks, or tools
- **Examples**: `python.instructions.md`, `react.instructions.md`, `terraform.instructions.md`
- **Target Length**: 150-250 lines
- **Focus**: Technical implementation, syntax, and tool-specific best practices

### 2. **Domain-Specific Templates**

- **Purpose**: Instructions for specialized domains or methodologies
- **Examples**: `data-science.instructions.md`, `finance-trading.instructions.md`, `cloud-platform.instructions.md`
- **Target Length**: 200-300 lines
- **Focus**: Domain expertise, workflows, and industry-specific patterns

### 3. **Process Templates**

- **Purpose**: Instructions for workflows, methodologies, and organizational processes
- **Examples**: `workflows.instructions.md`, `best-practices.instructions.md`
- **Target Length**: 100-200 lines
- **Focus**: Process steps, decision frameworks, and organizational patterns

## Standardized Template Structure

All instruction templates must follow this structure:

````markdown
# {TECHNOLOGY/DOMAIN} Instructions

## Overview

- **Domain**: [Specific domain or area]
- **Purpose**: [Primary objective and scope]
- **Applicable To**: [Types of projects, teams, or scenarios]
- **Complexity Level**: [Beginner/Intermediate/Advanced/Expert]

## Core Concepts

### Essential Concepts

- **Concept 1**: [Brief description and importance]
- **Concept 2**: [Brief description and importance]
- **Concept 3**: [Brief description and importance]

### Key Benefits

- [Specific, measurable benefit 1]
- [Specific, measurable benefit 2]
- [Specific, measurable benefit 3]

## Implementation Guidelines

### Getting Started

- [Prerequisites and setup requirements]
- [Initial configuration steps]
- [Quick start example]

### Core Patterns

```{syntax}
// Pattern 1: [Pattern name and purpose]
{practical-example-1}

// Pattern 2: [Pattern name and purpose]
{practical-example-2}
```
````

### Best Practices

- **[Category 1]**: [Specific practices with rationale]
- **[Category 2]**: [Specific practices with rationale]
- **[Category 3]**: [Specific practices with rationale]

## Common Use Cases

### Use Case 1: [Scenario Name]

**When**: [When this applies]
**Implementation**: [How to implement]
**Expected Result**: [What should happen]

### Use Case 2: [Scenario Name]

**When**: [When this applies]
**Implementation**: [How to implement]
**Expected Result**: [What should happen]

## Anti-Patterns to Avoid

- **[Anti-Pattern 1]**: [Why to avoid and better approach]
- **[Anti-Pattern 2]**: [Why to avoid and better approach]
- **[Anti-Pattern 3]**: [Why to avoid and better approach]

## Integration & Tools

### Essential Tools

- **[Tool 1]**: [Purpose and when to use]
- **[Tool 2]**: [Purpose and when to use]
- **[Tool 3]**: [Purpose and when to use]

### Integration Patterns

```{syntax}
// Integration example
{integration-code-example}
```

## AI Assistant Guidelines

{INSERT_SHARED_AI_GUIDELINES_COMPONENT}

## Resources

- **Official Documentation**: [URL]
- **Key References**: [URLs to authoritative sources]
- **Community Resources**: [URLs to helpful communities]

```

## Content Requirements

### Mandatory Sections
1. **Overview** - Clear scope and purpose definition
2. **Core Concepts** - Essential knowledge for the domain
3. **Implementation Guidelines** - Practical how-to guidance
4. **Common Use Cases** - Real-world application scenarios
5. **Anti-Patterns** - What to avoid and why
6. **AI Assistant Guidelines** - AI-specific guidance (use shared component)

### Optional Sections (use when relevant)
- **Advanced Topics** - Expert-level guidance
- **Performance Optimization** - Efficiency improvements
- **Security Considerations** - Security-specific guidance
- **Troubleshooting** - Problem resolution guidance
- **Migration** - Upgrade or transition guidance

### Prohibited Sections
- **Case Studies** - Too verbose for AI agents
- **Detailed History** - Not relevant for implementation
- **Extensive Theory** - Keep focused on practical implementation
- **Marketing Content** - Avoid promotional language

## Content Guidelines

### Writing Style
- **Concise and Actionable**: Every sentence should provide actionable guidance
- **Structured and Scannable**: Use consistent formatting and clear headings
- **Example-Heavy**: Include practical code examples for all concepts
- **AI-Optimized**: Write for AI parsing and understanding, not human reading

### Code Examples
- **Practical and Complete**: Examples should be runnable and realistic
- **Well-Commented**: Explain the reasoning behind code choices
- **Multiple Approaches**: Show different ways to accomplish tasks when relevant
- **Error Handling**: Include proper error handling patterns

### Length Guidelines
- **Overview**: 3-5 bullet points
- **Core Concepts**: 3-5 concepts, 1-2 sentences each
- **Implementation Guidelines**: 5-10 practical steps or patterns
- **Use Cases**: 2-4 scenarios with concrete examples
- **Anti-Patterns**: 3-5 things to avoid

## Quality Standards

### Content Quality
- All examples must be tested and functional
- Links must be current and authoritative
- Information must be accurate and up-to-date
- Language must be clear and unambiguous

### Consistency Requirements
- Use shared components for common sections
- Follow standardized formatting and structure
- Maintain consistent terminology across templates
- Apply uniform code example formatting

### Review Process
1. **Technical Review**: Verify all examples and recommendations
2. **Structure Review**: Ensure adherence to template standards
3. **AI Optimization Review**: Confirm AI agent usability
4. **Final Approval**: Template owner approves for publication

## Maintenance Guidelines

### Update Frequency
- **Technology Templates**: Review quarterly for technology updates
- **Domain Templates**: Review bi-annually for methodology changes
- **Process Templates**: Review annually for organizational changes

### Change Management
- All changes must maintain backward compatibility
- Breaking changes require version increment
- Updates must be tested with AI agents before publication

### Deprecation Process
1. Mark template as deprecated with migration guidance
2. Provide 6-month notice before removal
3. Archive template with redirect to replacement

## Template Relationship Map

```

┌─ Technology Templates ─┐
│ ├─ language._ │
│ ├─ frameworks._ │
│ ├─ tools._ │
│ └─ database._ │
│ │
├─ Domain Templates ─────┤
│ ├─ data-science._ │
│ ├─ finance-trading._ │
│ ├─ cloud-platform._ │
│ └─ cms._ │
│ │
└─ Process Templates ────┤
├─ workflows._ │
├─ best-practices._ │
└─ general-guidelines.│

```

This structure ensures:
- **Clear Template Purposes**: Each template has a distinct, well-defined scope
- **Reduced Overlap**: Eliminates content duplication across templates
- **Optimal AI Performance**: Structured for AI parsing and application
- **Maintainable System**: Easier to update and keep current
- **Scalable Framework**: Easy to add new templates following standards
```
