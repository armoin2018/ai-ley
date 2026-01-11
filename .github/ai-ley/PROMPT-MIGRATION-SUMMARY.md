# Prompt Migration Summary

**Date:** 2026-01-11  
**Task:** Migrate and optimize prompts from `.ai-ley/shared/prompts/` to `.github/prompts/`

---

## Executive Summary

Successfully migrated 48 prompts from the legacy structure to the new AI-ley framework with:

- ✅ Agent-style frontmatter and footer formatting
- ✅ Updated variable paths and references
- ✅ ailey- prefix for namespace clarity
- ✅ Enhanced metadata and recommendations
- ✅ Comprehensive indexing system
- ✅ Template files for future prompt creation

---

## Migration Details

### Files Processed

**Source:** `.ai-ley/shared/prompts/` (48 files)  
**Target:** `.github/prompts/` (48 files)  
**Old Pointers Removed:** 47 files

### Naming Convention

All prompts now follow the pattern: `ailey-[name].prompt.md`

**Examples:**

- `ask.md` → `ailey-ask.prompt.md`
- `build-test-plan.md` → `ailey-build-test-plan.prompt.md`
- `ai-ley-validate.md` → `ailey-validate.prompt.md`

### Frontmatter Standardization

**Before:**

```yaml
---
agentMode: general
applyTo: general
author: AI-LEY
description: Long description...
extensions: [.md]
guidelines: Follow AI-LEY project standards...
instructionType: general
keywords: [keyword1, keyword2, keyword3]
lastUpdated: '2025-09-10T00:00:00.000000'
summaryScore: 4.0
title: Prompt Title
version: 1.0.0
---
```

**After:**

```yaml
---
name: 'Prompt Title'
description: 'Concise description of what this prompt does'
keywords: [keyword1, keyword2, keyword3, prompt, ailey]
---
```

### Footer Standardization

**Added to all prompts:**

```
---

version: 1.0.0
updated: 2026-01-11
reviewed: 2026-01-11
score: 4.0
```

### Path Updates

All variable references updated from:

- `.github/ai-ley/ai-ley.yaml` → `.github/ai-ley/ai-ley.yaml`
- `.ai-ley/shared/global-instructions.md` → `.github/ai-ley/global-instructions.md`
- `.ai-ley/shared/personas` → `.github/ai-ley/personas`
- `.ai-ley/shared/instructions` → `.github/ai-ley/instructions`
- `.ai-ley/shared/prompts` → `.github/prompts`

---

## Enhanced Features

### Agent Recommendations

Each prompt now includes recommended agent section:

```markdown
## Recommended Agent

This prompt works best with the **ailey-[agent-name]** agent from `.github/agents/ailey-[agent-name].agent.md`.

To use this agent, reference it in your chat or workflow configuration.
```

**Agent Distribution:**

- ailey-orchestrator: 19 prompts (40%)
- ailey-planner: 6 prompts (13%)
- ailey-entrepreneur: 5 prompts (10%)
- ailey-marketing: 4 prompts (8%)
- ailey-architect: 3 prompts (6%)
- ailey-optimizer: 3 prompts (6%)
- ailey-documentation: 2 prompts (4%)
- ailey-tester: 2 prompts (4%)
- ailey-brainstorm: 1 prompt (2%)
- ailey-designer: 1 prompt (2%)
- ailey-porting: 1 prompt (2%)
- ailey-security: 1 prompt (2%)

### Instruction References

Each prompt includes relevant instruction folder references:

```markdown
## Recommended Instructions

Consider referencing these instruction files:

- `.github/ai-ley/instructions/_general/developer/**/*.md`
- `.github/ai-ley/instructions/[category]/**/*.md`

These provide domain-specific guidance and best practices.
```

### Persona References

Each prompt includes relevant persona domain references:

```markdown
## Recommended Personas

Consider leveraging these persona domains:

- `.github/ai-ley/personas/_general/**/*.md`
- `.github/ai-ley/personas/[domain]/**/*.md`

These personas provide specialized expertise and perspective.
```

---

## Categorization

Prompts organized into 13 categories:

| Category | Count | Examples |
|----------|-------|----------|
| Analysis | 5 | assess, audit, health-check, validate, seo-report |
| Architecture | 2 | build-architecture, build-design |
| Business | 8 | business-plan, lean-canvas, pitch-deck, go-to-market |
| Development | 6 | build-flow, build-registry, launch-builder |
| Documentation | 1 | document |
| General | 1 | port |
| Innovation | 4 | innovate, new-feature, new-prompt, scaffold |
| Maintenance | 4 | evolve, repair-prompts, update-instructions |
| Operations | 4 | intake, run, run-flow, run-next |
| Optimization | 3 | optimize, refactor, bench |
| Planning | 4 | plan, extract-requirements, requirements |
| Testing | 2 | build-test-plan, build-unit-tests |
| Utilities | 4 | alias, ask, git-commit, glean |

---

## Complexity Analysis

Prompts rated by complexity based on steps, checklists, and examples:

- **Low Complexity:** 38 prompts (79%)
- **Medium Complexity:** 3 prompts (6%)
- **High Complexity:** 7 prompts (15%)

**High Complexity Prompts:**

1. ailey-evolve.prompt.md (Maintenance)
2. ailey-glean.prompt.md (Business)
3. ailey-intake.prompt.md (Operations)
4. ailey-rebuild-indexes.prompt.md (Development)
5. ailey-run-flow.prompt.md (Operations)
6. ailey-run.prompt.md (Operations)
7. ailey-build-flow.prompt.md (Development)

---

## Templates Created

### Prompt Template

**Location:** `.github/ai-ley/templates/template.prompt.md`

**Includes:**

- Standard frontmatter structure
- Variable references section
- Recommended agent/instruction/persona sections
- Goal and command structure
- Step-by-step format
- Examples section
- Quality checklist
- Standard footer

### Instruction Template

**Location:** `.github/ai-ley/templates/template.instructions.md`

**Includes:**

- Purpose and use cases
- Core principles
- Guidelines with best practices and anti-patterns
- Common patterns with examples
- Error handling
- Performance and security considerations
- Testing requirements
- Related resources

### Persona Template

**Location:** `.github/ai-ley/templates/template.persona.md`

**Includes:**

- Role and competencies
- Perspective and approach
- Communication style
- Problem-solving methodology
- Domain knowledge
- Collaboration style
- Responsibilities and deliverables
- Common scenarios
- Development path

### Flow Template

**Location:** `.github/ai-ley/flows/templates/template.flow.md`

**Includes:**

- Overview with participants
- Prerequisites
- PlantUML flow diagram
- Step-by-step execution
- Decision points
- Error handling
- Quality assurance
- Monitoring metrics

---

## Index Generation

**Location:** `.github/ai-ley/indexes/prompts.md` (446 lines)

**Features:**

- Quick navigation by category, agent, and complexity
- Searchable keyword index
- Alphabetical listing with metadata
- Usage guidelines
- Quality score definitions
- Complexity level explanations

**Index Sections:**

1. By Category - Organized tables with metadata
2. By Agent - Grouped by recommended agent
3. By Complexity - Sorted by complexity level
4. Alphabetical List - Complete sortable table
5. Search Guide - Keywords, categories, and agents

---

## Quality Metrics

### Frontmatter Validation

- ✅ 48/48 prompts (100%) with standardized frontmatter
- ✅ 48/48 prompts (100%) with single-line keywords array
- ✅ 48/48 prompts (100%) with name, description, keywords

### Footer Validation

- ✅ 48/48 prompts (100%) with version/updated/reviewed/score footer
- ✅ All updated dates set to 2026-01-11
- ✅ All versions set to 1.0.0
- ✅ Average score: 4.0

### Path References

- ✅ All `.ai-ley/shared/*` references updated
- ✅ All variable references use `.github/ai-ley/ai-ley.yaml`
- ✅ All persona/instruction references point to new locations

### Recommendations

- ✅ 48/48 prompts with agent recommendations
- ✅ Agent recommendations optimized for prompt type
- ✅ Instruction references added where applicable
- ✅ Persona references added where applicable

---

## Scripts Created

1. **migrate_prompts.py**
   - Migrates prompts from old to new structure
   - Updates frontmatter and footer
   - Updates path references
   - Adds agent/instruction/persona recommendations

2. **enhance_prompt_agents.py**
   - Optimizes agent recommendations
   - Maps prompts to appropriate agents
   - Updates agent references in content

3. **generate_prompt_index.py**
   - Generates comprehensive index
   - Categorizes prompts
   - Extracts metadata
   - Creates searchable documentation

---

## File Structure

```
.github/
├── prompts/
│   ├── ailey-alias.prompt.md
│   ├── ailey-ask.prompt.md
│   ├── ailey-assess.prompt.md
│   ├── ... (45 more prompts)
│   └── ailey-validate.prompt.md
│
└── ai-ley/
    ├── ai-ley.yaml (variable definitions)
    ├── global-instructions.md
    ├── indexes/
    │   └── prompts.md (446 lines)
    ├── templates/
    │   ├── template.prompt.md
    │   ├── template.instructions.md
    │   └── template.persona.md
    └── flows/
        └── templates/
            └── template.flow.md
```

---

## Next Steps

**Completed:**

- [x] Migrate all 48 prompts
- [x] Standardize frontmatter and footer
- [x] Update all path references
- [x] Add agent/instruction/persona recommendations
- [x] Remove old pointer prompts
- [x] Create template files
- [x] Generate comprehensive index

**Optional Future Enhancements:**

- [ ] Add examples to prompts
- [ ] Create prompt flow diagrams
- [ ] Build prompt dependency graph
- [ ] Add versioning system
- [ ] Create prompt testing framework
- [ ] Add usage analytics
- [ ] Build prompt builder UI

---

## Validation

**All prompts verified for:**

- ✅ Single-line keyword format: 48/48 (100%)
- ✅ Valid frontmatter: 48/48 (100%)
- ✅ Valid footer: 48/48 (100%)
- ✅ ailey- prefix: 48/48 (100%)
- ✅ Agent reference: 48/48 (100%)
- ✅ Updated paths: 48/48 (100%)

**Sample Verification:**

```bash
# Count prompts with single-line keywords
grep -l "^keywords: \[" .github/prompts/*.md | wc -l
# Output: 48

# Count ailey- prefixed prompts
find .github/prompts -name "ailey-*.prompt.md" | wc -l
# Output: 48

# Verify no old pointers remain
find .github/prompts -type f \( -name "*.md" -o -name "*.prompt.md" \) ! -name "ailey-*.prompt.md" | wc -l
# Output: 0
```

---

## Success Metrics

| Metric | Target | Achieved | Status |
|--------|--------|----------|--------|
| Prompts Migrated | 48 | 48 | ✅ |
| Frontmatter Standardized | 100% | 100% | ✅ |
| Footer Added | 100% | 100% | ✅ |
| Paths Updated | 100% | 100% | ✅ |
| Agent Recommendations | 100% | 100% | ✅ |
| Old Files Removed | 100% | 100% | ✅ |
| Templates Created | 4 | 4 | ✅ |
| Index Generated | Yes | Yes | ✅ |

---

## Conclusion

The prompt migration has been completed successfully with all 48 prompts:

1. **Migrated** from `.ai-ley/shared/prompts/` to `.github/prompts/`
2. **Renamed** with `ailey-` prefix for clarity
3. **Standardized** with agent-style frontmatter and footer
4. **Enhanced** with agent, instruction, and persona recommendations
5. **Updated** with new variable paths and references
6. **Indexed** with comprehensive metadata catalog
7. **Templated** for future prompt creation

All prompts are now aligned with the AI-ley framework and ready for use with the agent system.

---

version: 1.0.0
date: 2026-01-11
author: AI-ley Migration System
status: Complete
