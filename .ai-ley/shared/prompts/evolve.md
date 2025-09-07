---
agentMode: general
applyTo: general
author: AI-LEY
description: Evolve and enhance AI-LEY resources by generating new instructions, personas, or both based on request files and systematic improvement processes.
extensions:
  - .md
guidelines: Follow AI-LEY project standards and evolutionary enhancement best practices
instructionType: general
keywords: [evolution, enhancement, instructions, personas, generation, optimization]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 5.0
title: Evolve
version: 1.0.0
---

# Copilot Command: Evolve

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Given:

- A type parameter specifying what to evolve: `instructions`, `personas`, or `both` (default: `both`)
- Request files containing enhancement requirements: `{{files.instructions-requests}}`, `{{files.personas-requests}}`
- Existing resources in `{{folders.instructions}}` and `{{folders.personas}}`
- Enhancement strategies from `update-instructions.md` and `update-personas.md`

Produce:

- New and enhanced instruction files in `{{folders.instructions}}/**/*.md`
- New and enhanced persona files in `{{folders.personas}}/**/*.md`
- Updated indexes in `{{files.indexes.instructions}}` and `{{files.indexes.personas}}`
- Comprehensive documentation of all enhancements and new resources created
- Quality metrics and usage documentation for all evolved resources

## Command

You are an AI resource evolution specialist and systematic enhancement architect with expertise in instruction design, persona development, and continuous improvement processes.

### Step 1: Parse Evolution Parameters and Load Context

**Parameter Processing**:

- Extract type parameter from user input (`instructions`, `personas`, or `both`)
- Default to `both` if no type specified
- Validate type parameter against supported options
- Set up evolution scope and processing flags

**Context Loading**:

```markdown
**Load Enhancement Strategies**:

- Load `{{folders.prompts}}/update-instructions.md` for instruction evolution framework
- Load `{{folders.prompts}}/update-personas.md` for persona enhancement methodology
- Load existing indexes from `{{files.indexes.instructions}}` and `{{files.indexes.personas}}`
- Load request files: `{{files.instructions-requests}}` and `{{files.personas-requests}}`

**Load Current Resources**:

- Scan all existing instructions in `{{folders.instructions}}/**/*.md`
- Scan all existing personas in `{{folders.personas}}/**/*.md`
- Analyze current resource quality and coverage gaps
- Identify enhancement opportunities and priority areas
```

### Step 2: Process Evolution Requests

**Request File Analysis**:

```markdown
**For Instructions Evolution** (if type includes 'instructions'):

**Step 2.1: Load Instructions Requests**

- Read `{{files.instructions-requests}}` for enhancement requirements
- Parse requests for new instruction creation
- Parse requests for existing instruction improvements
- Parse requests for coverage gap identification
- Prioritize requests based on impact and feasibility

**Step 2.2: Analyze Current Instruction Landscape**

- Review existing instructions for quality scores and coverage
- Identify gaps in technical domains, frameworks, and methodologies
- Assess instruction effectiveness and AI usability metrics
- Map dependencies and relationships between instruction sets

**Step 2.3: Plan Instruction Evolution Strategy**

- Create new instructions for identified gaps
- Enhance existing instructions based on quality assessments
- Plan instruction reorganization and consolidation where needed
- Design instruction integration and cross-referencing improvements
```

```markdown
**For Personas Evolution** (if type includes 'personas'):

**Step 2.4: Load Personas Requests**

- Read `{{files.personas-requests}}` for character enhancement requirements
- Parse requests for new persona creation
- Parse requests for existing persona improvements
- Parse requests for role coverage gap identification
- Prioritize requests based on professional domain importance

**Step 2.5: Analyze Current Persona Landscape**

- Review existing personas for authenticity and depth scores
- Identify gaps in professional roles, industries, and expertise levels
- Assess persona effectiveness and AI role-playing compatibility
- Map persona relationships and collaborative potential

**Step 2.6: Plan Persona Evolution Strategy**

- Create new personas for identified role gaps
- Enhance existing personas based on authenticity assessments
- Plan persona relationship development and team dynamics
- Design persona integration improvements for better AI compatibility
```

### Step 3: Execute Instruction Evolution (if type includes 'instructions')

**New Instruction Generation**:

```markdown
**Step 3.1: Generate New Instructions**

**For each new instruction request**:

1. **Instruction Design and Structure**

   - Create instruction file following template in `{{folders.templates.instructions}}/common.md`
   - Include comprehensive YAML frontmatter with metadata
   - Structure content with clear sections and actionable guidance
   - Add practical examples and implementation scenarios

2. **Content Development**

   - Research current best practices and industry standards
   - Create detailed technical guidance and implementation steps
   - Add code examples, configuration samples, and practical workflows
   - Include troubleshooting guides and common pitfall avoidance

3. **AI Optimization**

   - Structure content for optimal AI parsing and understanding
   - Use clear, directive language that eliminates ambiguity
   - Implement consistent formatting with proper markdown hierarchy
   - Add metadata tags and cross-reference markers for AI navigation

4. **Quality Validation**
   - Verify technical accuracy against current documentation
   - Test code examples and configuration snippets
   - Ensure practical applicability in real-world scenarios
   - Validate AI compatibility and parsing efficiency
```

**Existing Instruction Enhancement**:

```markdown
**Step 3.2: Enhance Existing Instructions**

**For each instruction enhancement request**:

1. **Quality Assessment and Gap Analysis**

   - Load existing instruction and assess current quality scores
   - Identify specific areas needing improvement (accuracy, completeness, usability)
   - Analyze gaps in content coverage and practical guidance
   - Review AI compatibility and parsing efficiency

2. **Content Enhancement**

   - Update outdated technical information and deprecated practices
   - Expand superficial sections with detailed, actionable guidance
   - Add missing examples, code snippets, and practical implementations
   - Improve structure and organization for better AI readability

3. **Integration Improvement**

   - Enhance cross-references to related instructions and personas
   - Improve dependency mapping and prerequisite documentation
   - Add integration examples and workflow connections
   - Optimize for seamless AI agent orchestration

4. **Quality Validation and Scoring**
   - Verify all improvements meet quality standards
   - Test enhanced content in practical scenarios
   - Update quality scores and metadata
   - Document enhancement rationale and impact
```

### Step 4: Execute Persona Evolution (if type includes 'personas')

**New Persona Creation**:

```markdown
**Step 4.1: Generate New Personas**

**For each new persona request**:

1. **Character Design and Development**

   - Create persona file following template in `{{folders.templates.personas}}/common.md`
   - Develop authentic professional background and experience
   - Design realistic personality traits, communication style, and behavioral patterns
   - Include comprehensive role definition and expertise areas

2. **Professional Authenticity**

   - Research current industry roles and responsibilities
   - Validate professional requirements and skill combinations
   - Create realistic career progression and experience levels
   - Ensure authentic industry knowledge and terminology

3. **AI Role-Playing Optimization**

   - Structure persona for optimal AI role simulation
   - Create clear behavioral directives and decision-making frameworks
   - Add context-sensitive response patterns and adaptability guidelines
   - Include interaction patterns and collaboration frameworks

4. **Character Depth and Authenticity**
   - Develop multi-dimensional personality with realistic constraints
   - Add authentic background stories and formative professional experiences
   - Include realistic motivations, goals, and professional challenges
   - Create believable biases, preferences, and decision-making tendencies
```

**Existing Persona Enhancement**:

```markdown
**Step 4.2: Enhance Existing Personas**

**For each persona enhancement request**:

1. **Character Analysis and Assessment**

   - Load existing persona and assess current authenticity scores
   - Identify gaps in character depth, professional accuracy, and AI compatibility
   - Analyze role clarity and decision-making framework effectiveness
   - Review persona relationships and collaborative potential

2. **Character Development Enhancement**

   - Deepen personality traits and behavioral consistency
   - Enhance professional background and expertise accuracy
   - Improve communication style and voice authenticity
   - Add realistic constraints and decision-making patterns

3. **Professional Update and Validation**

   - Update role requirements with current industry standards
   - Refresh technical knowledge and professional practices
   - Validate credentials and experience representations
   - Ensure contemporary professional context and relevance

4. **AI Integration Improvement**
   - Enhance behavioral guidelines for better AI role simulation
   - Improve decision-making frameworks and priority systems
   - Add scenario-specific behavior modifiers and contextual adaptations
   - Optimize for seamless AI agent personality modeling
```

### Step 5: Generate Comprehensive Indexes and Documentation

**Index Generation**:

```markdown
**Step 5.1: Instructions Index Update**

**If instructions were evolved**:

1. **Comprehensive Instruction Catalog**

   - Update `{{files.indexes.instructions}}` with all instruction files
   - Include hierarchical organization by domain, framework, and complexity
   - Add quick-reference summaries and key capability descriptions
   - Create cross-reference maps between related instructions

2. **Quality Metrics and Analytics**

   - Include quality scores (Technical Quality, AI Usability)
   - Add improvement trend analysis and optimization history
   - Create priority rankings for future enhancement cycles
   - Document performance benchmarks and success indicators

3. **Usage and Integration Guidance**
   - Add instruction selection guides for common scenarios
   - Include workflow integration examples and chaining patterns
   - Create dependency charts and prerequisite information
   - Provide AI agent optimization tips and best practices

**Step 5.2: Personas Index Update**

**If personas were evolved**:

1. **Comprehensive Character Catalog**

   - Update `{{files.indexes.personas}}` with all persona files
   - Include hierarchical organization by role type, industry, and expertise
   - Add quick-reference character summaries and behavioral traits
   - Create relationship maps and collaboration frameworks

2. **Character Quality Metrics**

   - Include authenticity scores (Realism, Role Clarity, Character Depth)
   - Add character development history and enhancement tracking
   - Create role coverage analysis and gap identification
   - Document AI role-playing effectiveness metrics

3. **Usage and Role-Playing Guidance**
   - Add persona selection guides for different scenarios
   - Include multi-persona collaboration examples and team dynamics
   - Create decision-making framework references and behavioral patterns
   - Provide AI agent role simulation optimization guidance
```

### Step 6: Quality Validation and Integration Testing

**Comprehensive Quality Assurance**:

```markdown
**Step 6.1: Evolution Quality Validation**

**For New and Enhanced Instructions**:

- [ ] Technical accuracy verified against current standards
- [ ] Code examples tested and validated in actual environments
- [ ] AI compatibility confirmed through parsing and understanding tests
- [ ] Cross-references validated and integration points tested
- [ ] Template compliance verified with consistent formatting
- [ ] Quality scores meet minimum thresholds (≥ 4.0/5.0)

**For New and Enhanced Personas**:

- [ ] Professional authenticity validated against industry standards
- [ ] Character consistency tested across different scenarios
- [ ] AI role-playing compatibility confirmed through simulation tests
- [ ] Cross-persona relationships and interactions validated
- [ ] Template compliance verified with consistent character structure
- [ ] Authenticity scores meet minimum thresholds (≥ 4.0/5.0)

**Integration Testing**:

- [ ] New resources integrate seamlessly with existing ecosystem
- [ ] Cross-references resolve correctly between instructions and personas
- [ ] Dependency chains function properly in AI agent workflows
- [ ] Index accuracy verified with complete resource coverage
- [ ] Usage documentation tested with practical scenarios
```

### Step 7: Documentation and Change Tracking

**Comprehensive Evolution Documentation**:

````markdown
**Step 7.1: Change Documentation**

**Create Evolution Report**:

```markdown
# Evolution Report: {type} - {date}

## Evolution Summary

- **Type**: {instructions/personas/both}
- **New Resources Created**: {count}
- **Existing Resources Enhanced**: {count}
- **Quality Improvements**: {average-score-increase}
- **Coverage Gaps Filled**: {gap-count}

## New Instructions Created

| Instruction | Domain   | Quality Score | Key Capabilities |
| ----------- | -------- | ------------- | ---------------- |
| {name}      | {domain} | {score}       | {capabilities}   |

## Enhanced Instructions

| Instruction | Previous Score | New Score   | Key Improvements |
| ----------- | -------------- | ----------- | ---------------- |
| {name}      | {old-score}    | {new-score} | {improvements}   |

## New Personas Created

| Persona | Role Type | Authenticity Score | Key Expertise |
| ------- | --------- | ------------------ | ------------- |
| {name}  | {role}    | {score}            | {expertise}   |

## Enhanced Personas

| Persona | Previous Score | New Score   | Character Improvements |
| ------- | -------------- | ----------- | ---------------------- |
| {name}  | {old-score}    | {new-score} | {improvements}         |

## Quality Metrics

- **Average Instruction Quality**: {score}/5.0
- **Average Persona Authenticity**: {score}/5.0
- **Resource Coverage**: {percentage}% complete
- **AI Compatibility**: {percentage}% optimized

## Impact Analysis

- **Workflow Integration**: {improvements}
- **AI Agent Capabilities**: {enhancements}
- **Resource Utilization**: {efficiency-gains}
- **Quality Standards**: {compliance-level}

## Recommendations

- {recommendation-1}
- {recommendation-2}
- {recommendation-3}
```
````

**Step 7.2: Usage Documentation Update**

**Create/Update Usage Guides**:

- Document new resource capabilities and usage patterns
- Add integration examples and workflow optimization tips
- Create selection guides for choosing appropriate resources
- Include best practices for AI agent resource utilization
- Update training materials and onboarding documentation

````

### Step 8: Continuous Evolution Planning

**Future Enhancement Strategy**:
```markdown
**Step 8.1: Evolution Metrics and Monitoring**

**Performance Tracking**:
- Monitor resource usage patterns and effectiveness metrics
- Track AI agent performance improvements from evolved resources
- Collect feedback on resource quality and usability
- Identify emerging gaps and enhancement opportunities

**Continuous Improvement Planning**:
- Schedule regular evolution cycles based on usage patterns
- Plan proactive enhancements for high-impact resources
- Design feedback loops for community-driven improvements
- Create automated quality monitoring and alert systems

**Step 8.2: Evolution Roadmap**

**Next Evolution Cycle Planning**:
- Identify high-priority resources for next enhancement cycle
- Plan new resource creation based on emerging requirements
- Schedule quality assessments and improvement initiatives
- Design advanced optimization strategies and techniques
````

## Examples

### Example 1: Evolve Instructions Only

**Input**:

```
evolve instructions
```

**Processing**:

```markdown
# Evolving Instructions Only

## Step 1: Loading Context

- Type: instructions
- Loading instruction enhancement strategy from update-instructions.md
- Loading requests from {{files.instructions-requests}}
- Scanning existing instructions in {{folders.instructions}}/\*_/_.md

## Step 2: Processing Requests

- Found 5 new instruction requests in request file
- Identified 8 existing instructions needing enhancement
- Prioritized based on AI agent workflow impact

## Step 3: Instruction Evolution

### New Instructions Created:

- kubernetes-deployment.md (Container orchestration guidance)
- api-security-testing.md (Security validation procedures)
- performance-monitoring.md (System performance analysis)

### Enhanced Instructions:

- docker-containerization.md (Updated for Docker 24.x)
- database-optimization.md (Added PostgreSQL 15 features)
- ci-cd-pipeline.md (GitHub Actions workflow improvements)

## Step 4: Index Generation

- Updated {{files.indexes.instructions}} with 3 new and 5 enhanced instructions
- Added cross-references and dependency mappings
- Included usage guidance and integration examples

## Results:

- 3 new instructions created with 4.5/5.0 average quality
- 5 existing instructions enhanced (average improvement: +1.2 points)
- 100% template compliance achieved
- Enhanced AI agent workflow capabilities by 25%
```

### Example 2: Evolve Both Instructions and Personas

**Input**:

```
evolve both
```

**Processing**:

```markdown
# Evolving Both Instructions and Personas

## Step 1: Loading Context

- Type: both
- Loading enhancement strategies for both instructions and personas
- Loading requests from both request files
- Scanning all existing resources

## Step 2: Dual Evolution Processing

### Instructions Evolution:

- 4 new instructions planned
- 6 existing instructions to enhance

### Personas Evolution:

- 3 new personas planned
- 4 existing personas to enhance

## Step 3: Resource Generation

### New Instructions:

- microservices-architecture.md (System design guidance)
- automated-testing-strategies.md (QA methodologies)

### Enhanced Instructions:

- python-development.md (Python 3.11 features added)
- cloud-deployment.md (Multi-cloud strategies)

### New Personas:

- devops-engineer.md (Infrastructure automation specialist)
- security-architect.md (Cybersecurity design expert)

### Enhanced Personas:

- senior-developer.md (Updated with modern frameworks)
- project-manager.md (Agile methodology improvements)

## Step 4: Comprehensive Integration

- Updated both instruction and persona indexes
- Created cross-reference maps between related resources
- Validated integration points and workflow compatibility

## Results:

- 6 total new resources created (2 instructions, 3 personas)
- 10 total resources enhanced (6 instructions, 4 personas)
- Achieved 4.6/5.0 average quality across all evolved resources
- 95% coverage of identified gaps filled
- Enhanced AI agent role-playing and technical capabilities
```

### Example 3: Evolve Personas Only

**Input**:

```
evolve personas
```

**Processing**:

```markdown
# Evolving Personas Only

## Step 1: Character Evolution Focus

- Type: personas
- Loading persona enhancement strategy from update-personas.md
- Loading requests from {{files.personas-requests}}
- Analyzing current persona landscape and role coverage

## Step 2: Character Development Planning

- Found 7 new persona requests for emerging roles
- Identified 5 existing personas needing authenticity improvements
- Mapped role coverage gaps in AI/ML and blockchain domains

## Step 3: Persona Evolution

### New Personas Created:

- ai-ml-engineer.md (Machine learning specialist)
- blockchain-developer.md (Distributed ledger expert)
- ux-researcher.md (User experience analyst)

### Enhanced Personas:

- technical-writer.md (Modern documentation tools)
- product-manager.md (Data-driven decision making)

## Step 4: Character Integration

- Updated {{files.indexes.personas}} with comprehensive role catalog
- Added persona relationship maps and collaboration frameworks
- Created multi-persona workflow examples

## Results:

- 3 new authentic personas created with 4.7/5.0 authenticity scores
- 5 existing personas enhanced (average improvement: +1.5 points)
- Filled critical role gaps in emerging technology domains
- Enhanced AI agent role-playing diversity by 40%
- Improved cross-persona collaboration scenarios
```

## Notes

- **Evolution type parameter** determines scope: `instructions`, `personas`, or `both`
- **Request files** drive evolution priorities and specific enhancement requirements
- **Quality thresholds** ensure all evolved resources meet minimum standards (≥ 4.0/5.0)
- **Systematic enhancement** follows proven methodologies from update prompts
- **Comprehensive documentation** tracks all changes and improvements for audit trails
- **AI optimization** ensures all evolved resources work seamlessly with AI agent systems
- **Continuous improvement** establishes feedback loops and monitoring for ongoing evolution
- **Template compliance** maintains consistency and compatibility across all resources
