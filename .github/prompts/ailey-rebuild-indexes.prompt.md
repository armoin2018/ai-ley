---
name: 'Rebuild Indexes'
description: 'Rebuild AI-Ley index files to accurately reflect current state of asset directories with enriched metadata for discovery and quality evaluation'
keywords: [index, rebuild, metadata, discovery, quality, automation, maintenance, prompt, ailey]
---



# Copilot Command: Rebuild Indexes

## Variables

- Folders, Files and Indexes are stored in `.github/ai-ley/ai-ley.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

**Personas:** Leverage domain expertise from `.github/ai-ley/personas/**/*.md`

**Instructions:** Follow best practices from `.github/ai-ley/instructions/**/*.md`

**Agents:** This prompt is designed for the agent system. See the Recommended Agent section below.




## Recommended Personas

Consider leveraging these persona domains:

- `.github/ai-ley/personas/_general/**/*.md`

These personas provide specialized expertise and perspective.

## Recommended Instructions

Consider referencing these instruction files:

- `.github/ai-ley/instructions/_general/developer/**/*.md`

These provide domain-specific guidance and best practices.

## Recommended Agent

This prompt works best with the **ailey-orchestrator** agent from `.github/agents/ailey-orchestrator.agent.md`.

To use this agent, reference it in your chat or workflow configuration.

## Goal

Given:

- Current state of AI-Ley asset directories (prompts, instructions, agents, personas)
- Existing index files (if present)
- Optional mode parameter: `apply` (default), `dry-run`, or `force`

Produce:

- Updated index files in `.ai-ley/shared/indexes/` for each asset type:
  - `prompts.md` - Index of all command prompts
  - `instructions.md` - Index of all technical instructions
  - `agents.md` - Index of all AI agents
  - `personas.md` - Index of all personas
- `.ai-ley/shared/indexes/INDEX_CHANGES.md` - Diff report of changes (if applicable)
- Updated `.ai-ley/shared/QUESTIONS.md` - Entries for unclear or poor-quality assets requiring review
- All indexes enriched with metadata: path, keywords, description, quality score

## Command

You are an expert information architect and metadata specialist with deep expertise in content classification, semantic analysis, and knowledge organization systems.

### Step 1: Initialize and Scan Directories

**Parse command parameters**:

- Extract `mode` parameter: `apply` (default), `dry-run`, or `force`
- Determine which indexes to rebuild (default: all)

**Scan asset directories**:

1. **Scan `.github/prompts/`** for all `.md` files

   - Recursively traverse subdirectories
   - Exclude hidden files, templates, and generated files
   - Collect file paths relative to workspace root

2. **Scan `.github/ai-ley/instructions/`** for all `.md` files

   - Include subdirectories (by category)
   - Maintain category structure in index

3. **Scan `.ai-ley/shared/agents/`** for all agent definition files

   - Include all agent configuration formats

4. **Scan `.github/ai-ley/personas/`** for all `.md` files
   - Include subdirectories (by role/category)
   - Preserve organizational structure

**Load existing indexes** (if present):

- Read current `.ai-ley/shared/indexes/prompts.md`
- Read current `.ai-ley/shared/indexes/instructions.md`
- Read current `.ai-ley/shared/indexes/agents.md`
- Read current `.ai-ley/shared/indexes/personas.md`
- Parse existing entries to preserve manual overrides and custom descriptions

### Step 2: Extract Metadata for Each Asset

**For each file discovered**, extract comprehensive metadata:

#### 2.1: Read File Contents

- Load full file contents
- Parse YAML frontmatter (if present)
- Identify document structure (headings, sections)

#### 2.2: Extract Path

- **Relative Path** from workspace root
- Format: `./ai-ley/shared/prompts/deploy.md`
- Ensure consistent path formatting across platforms

#### 2.3: Extract Keywords

**Priority order for keyword extraction**:

1. **From YAML frontmatter**: `keywords` field (if present)
2. **From filename**: Parse filename for semantic terms
3. **From headings**: Extract key terms from H1, H2 headings
4. **From content**: Identify recurring technical terms and concepts
5. **From category**: Include parent directory name as category keyword

**Keyword guidelines**:

- Use lowercase, comma-separated format
- Limit to 5-10 most relevant keywords
- Include primary function/purpose keywords
- Include technical domain keywords (e.g., deployment, testing, security)
- Avoid generic terms (e.g., "file", "document", "guide")
- Derive semantic keywords from summary if unclear

**Example keywords**:

- Prompt: `deployment, infrastructure, terraform, automation, validation`
- Instruction: `react, frontend, components, best-practices, hooks`
- Persona: `developer, backend, api, senior, python`
- Agent: `code-review, quality, automated, analysis`

#### 2.4: Generate Short Description

**Description requirements**:

- Maximum 150 words
- Summarize purpose and intended usage
- Describe functional intent, not implementation details
- Avoid duplicating full document content
- Focus on "what" and "when to use"
- Include key capabilities or features

**Description extraction strategy**:

1. **From YAML frontmatter**: Use `description` field (if present)
2. **From summary section**: Extract from "Goal" or "Purpose" section
3. **From first paragraph**: Use opening content if no formal summary
4. **Generate from analysis**: Create concise summary from content analysis

**Description format**:

```
[Primary purpose]. [Key capabilities or features]. [When to use or intended audience].
```

**Example descriptions**:

- **Prompt**: "Deploy cloud infrastructure using Terraform with validation and rollback capabilities. Supports multi-environment deployments, state management, and automated testing. Use when provisioning new infrastructure or updating existing resources."

- **Instruction**: "Best practices for React component development using functional components and hooks. Covers component composition, state management, performance optimization, and testing patterns. Reference when building React applications."

- **Persona**: "Senior backend developer with expertise in Python, API design, and microservices architecture. Communicates technically with focus on scalability and performance. Use for backend development tasks and API design reviews."

#### 2.5: Assess Quality Score

**Quality scoring criteria** (1-5 scale):

**Score 5 - Excellent**:

- Clear, well-structured content
- Complete documentation with examples
- Proper YAML frontmatter with all metadata
- Follows AI-LEY template conventions
- No ambiguities or unclear sections
- Recent updates and maintenance

**Score 4 - Good**:

- Clear content and structure
- Mostly complete documentation
- Proper frontmatter with most metadata
- Generally follows conventions
- Minor gaps or missing examples

**Score 3 - Adequate** (default if uncertain):

- Basic structure present
- Functional but incomplete documentation
- Some frontmatter present
- Partially follows conventions
- Missing examples or details
- May need updates

**Score 2 - Needs Improvement**:

- Unclear or inconsistent structure
- Incomplete or outdated content
- Missing or minimal frontmatter
- Does not follow conventions
- Significant gaps in documentation
- Questionable accuracy

**Score 1 - Poor**:

- Minimal or confusing content
- No clear structure
- Missing frontmatter
- Does not follow any conventions
- Severely incomplete or incorrect
- Requires complete rewrite

**Quality assessment process**:

1. Check YAML frontmatter completeness (20%)
2. Assess content clarity and structure (30%)
3. Evaluate completeness and examples (25%)
4. Check adherence to AI-LEY conventions (15%)
5. Consider recency and maintenance (10%)

**If quality score is uncertain**:

- Default to score of 3
- Add entry to `.ai-ley/shared/QUESTIONS.md` for manual review
- Flag specific quality concerns in QUESTIONS.md

### Step 3: Handle Existing Index Entries

**For each asset being indexed**:

1. **Check if entry already exists** in current index

2. **If entry exists and mode is NOT `force`**:

   **Preserve manual overrides**:

   - If existing description is significantly different from auto-generated:
     - Keep existing description (assume manual curation)
     - Mark as `[manual]` in change log
   - If existing keywords are different:
     - Merge with auto-generated keywords (union)
     - Prioritize manual keywords
   - If existing quality score differs significantly:
     - Keep existing score if it appears manually set
     - Flag discrepancy in INDEX_CHANGES.md

   **Update missing fields**:

   - Add any missing metadata fields
   - Update outdated information (e.g., path changes)
   - Preserve custom content

3. **If entry exists and mode is `force`**:

   - Overwrite all fields unconditionally
   - Document overwrites in INDEX_CHANGES.md
   - Warn user that manual changes will be lost

4. **If entry does NOT exist**:
   - Create new entry with all extracted metadata
   - Mark as `[new]` in change log

### Step 4: Generate Index Files

**For each index type**, generate formatted Markdown table:

#### 4.1: Index File Structure

**Header**:

```markdown
<!-- generated-by: ai-ley rebuild-indexes | timestamp: 2025-11-10T12:34:56Z | mode: apply -->

# {Asset Type} Index

This index provides a comprehensive catalog of all {asset-type} in the AI-LEY knowledge base.
Last updated: {timestamp}

## Index

| Path | Keywords | Description | Quality |
| ---- | -------- | ----------- | ------- |
```

**Table entries**:

- Sort alphabetically by path
- Format path as relative from workspace root
- Format keywords as comma-separated inline list
- Format description as single-line text (truncate if needed)
- Format quality as integer 1-5

**Example entry**:

```markdown
| `.github/prompts/deploy.md` | deployment, infrastructure, terraform, automation, validation | Deploy cloud infrastructure using Terraform with validation and rollback capabilities. Supports multi-environment deployments, state management, and automated testing. | 5 |
```

#### 4.2: Footer Metadata

**Index statistics**:

```markdown
## Statistics

- Total entries: {count}
- Average quality score: {average}
- Excellent (5): {count-5}
- Good (4): {count-4}
- Adequate (3): {count-3}
- Needs improvement (2): {count-2}
- Poor (1): {count-1}

## Maintenance

Last rebuild: {timestamp}
Mode: {mode}
Changes: See `INDEX_CHANGES.md`
```

### Step 5: Generate Change Report

**Create `.ai-ley/shared/indexes/INDEX_CHANGES.md`** (if changes detected):

```markdown
<!-- generated-by: ai-ley rebuild-indexes | timestamp: 2025-11-10T12:34:56Z -->

# Index Changes Report

Generated: {timestamp}
Mode: {mode}

## Summary

- New entries: {count}
- Updated entries: {count}
- Removed entries: {count}
- Manual overrides preserved: {count}
- Conflicts detected: {count}

---

## Prompts Index Changes

### New Entries

- `.github/prompts/new-command.md` - [new]
  - Keywords: new, command, automation
  - Quality: 3
  - Reason: Newly added prompt file

### Updated Entries

- `.github/prompts/deploy.md` - [updated]
  - Old description: "Deploy infrastructure"
  - New description: "Deploy cloud infrastructure using Terraform..."
  - Updated fields: description, keywords
  - Manual overrides: quality score preserved (5)

### Removed Entries

- `.github/prompts/deprecated-command.md` - [removed]
  - Reason: File no longer exists in directory

### Manual Overrides Preserved

- `.github/prompts/custom-prompt.md`
  - Preserved: Custom description (significantly different from auto-generated)
  - Merged: Keywords (manual + auto-generated)

### Conflicts Requiring Review

- `.github/prompts/ambiguous-prompt.md`
  - Issue: Existing quality score (5) differs from assessment (3)
  - Action: Preserved existing score, flagged in QUESTIONS.md
  - Recommendation: Manual review needed

---

## Instructions Index Changes

{Similar structure for instructions}

---

## Agents Index Changes

{Similar structure for agents}

---

## Personas Index Changes

{Similar structure for personas}

---

## Recommendations

1. Review conflict entries flagged above
2. Check QUESTIONS.md for quality concerns
3. Validate manual overrides are still accurate
4. Consider updating low-quality assets (scores 1-2)
```

### Step 6: Update QUESTIONS.md

**For uncertain or poor-quality entries**, append to `.ai-ley/shared/QUESTIONS.md`:

```markdown
## Q-INDEX-001: Poor Quality Prompt Requires Review

**Context**: Rebuild-indexes detected low-quality prompt
**Asset**: `.github/prompts/unclear-prompt.md`
**Quality Score**: 2 (Needs Improvement)
**Issues Identified**:

- Missing YAML frontmatter
- No clear structure or sections
- Incomplete documentation
- No examples provided
- Outdated content (last modified 2023)

**Impact**: Users may struggle to understand purpose and usage
**Source**: Automated index rebuild (2025-11-10T12:34:56Z)
**Status**: Open
**Assigned To**: Documentation Team
**Decision By**: 2025-11-17

**Recommended Actions**:

- [ ] Add proper YAML frontmatter
- [ ] Restructure following AI-LEY prompt template
- [ ] Add usage examples
- [ ] Update content to current standards
- [ ] Test prompt functionality

---

## Q-INDEX-002: Ambiguous Keywords for Instruction

**Context**: Unable to confidently determine keywords for instruction
**Asset**: `.github/ai-ley/instructions/technical/ambiguous-guide.md`
**Current Keywords**: general, technical, guide (low confidence)
**Issue**: Content covers multiple unrelated topics without clear focus

**Recommended Actions**:

- [ ] Review and clarify instruction focus
- [ ] Split into multiple focused instructions
- [ ] Update keywords manually after clarification

---

## Q-INDEX-003: Quality Score Conflict

**Context**: Existing manual quality score differs significantly from assessment
**Asset**: `.github/prompts/important-prompt.md`
**Existing Score**: 5 (Excellent)
**Assessed Score**: 3 (Adequate)
**Discrepancy**: Manual score may be outdated or assessment may be incorrect

**Recommended Actions**:

- [ ] Manual review to determine correct quality score
- [ ] Update assessment criteria if needed
- [ ] Document reason for score in frontmatter
```

### Step 7: Mode-Specific Behavior

#### Mode: `apply` (default)

- Update all index files
- Write INDEX_CHANGES.md
- Update QUESTIONS.md
- Preserve manual overrides
- Report summary of changes

#### Mode: `dry-run`

- **DO NOT write any files**
- Generate preview of all changes
- Show diff of what would be updated
- Display change report to console
- Provide summary:

```
🔍 Dry-run mode - No files were modified

Would update:
- .ai-ley/shared/indexes/prompts.md (12 entries updated, 3 new)
- .ai-ley/shared/indexes/instructions.md (5 entries updated, 1 new)
- .ai-ley/shared/indexes/agents.md (no changes)
- .ai-ley/shared/indexes/personas.md (8 entries updated, 2 removed)

Would create:
- .ai-ley/shared/indexes/INDEX_CHANGES.md

Would append to:
- .ai-ley/shared/QUESTIONS.md (4 new questions)

Run with mode=apply to commit changes.
```

#### Mode: `force`

- Overwrite ALL index entries unconditionally
- Do NOT preserve manual overrides
- Document all overwrites in INDEX_CHANGES.md
- Warn user before proceeding:

```
⚠️  Force mode will overwrite all manual changes!

This will replace:
- All custom descriptions
- All manual quality scores
- All manually curated keywords

Manual overrides that will be lost: 15 entries

Continue? (yes/no):
```

### Step 8: Validation and Quality Checks

**Validate generated indexes**:

- [ ] All discovered files are indexed
- [ ] All index entries have required fields (path, keywords, description, quality)
- [ ] Paths are valid and files exist
- [ ] Keywords are relevant and properly formatted
- [ ] Descriptions are within length limits (≤150 words)
- [ ] Quality scores are in valid range (1-5)
- [ ] Tables are properly formatted (no broken Markdown)
- [ ] Alphabetical sorting is correct
- [ ] Statistics are accurate
- [ ] Generated header is present with timestamp

**Consistency checks**:

- [ ] No duplicate entries in same index
- [ ] Cross-references between indexes are valid
- [ ] Manual overrides are properly preserved (unless force mode)
- [ ] Change report accurately reflects modifications
- [ ] QUESTIONS.md entries are well-formatted

**Quality checks**:

- [ ] Low-quality assets (scores 1-2) are flagged in QUESTIONS.md
- [ ] Uncertain assessments default to score 3
- [ ] Quality score distribution is reasonable
- [ ] Average quality score is calculated correctly

### Step 9: Deliver Results

**Success confirmation**:

```
✅ Index rebuild complete!

Updated indexes:
- .ai-ley/shared/indexes/prompts.md (45 entries, avg quality: 4.2)
- .ai-ley/shared/indexes/instructions.md (67 entries, avg quality: 3.8)
- .ai-ley/shared/indexes/agents.md (12 entries, avg quality: 4.5)
- .ai-ley/shared/indexes/personas.md (23 entries, avg quality: 4.0)

Changes:
- New entries: 6
- Updated entries: 18
- Removed entries: 2
- Manual overrides preserved: 15

Reports generated:
- .ai-ley/shared/indexes/INDEX_CHANGES.md
- 4 questions added to QUESTIONS.md for review

Quality summary:
- Excellent (5): 42 entries
- Good (4): 58 entries
- Adequate (3): 34 entries
- Needs improvement (2): 9 entries (flagged for review)
- Poor (1): 4 entries (flagged for review)

Next steps:
1. Review INDEX_CHANGES.md for details
2. Address questions in QUESTIONS.md
3. Consider improving assets with quality scores 1-2
```

## Examples

### Example 1: Basic Index Rebuild

**Command**:

```
/rebuild-indexes
```

**Expected Output**:

```
🔄 Rebuilding AI-LEY indexes...

Scanning directories...
- .github/prompts: 42 files found
- .github/ai-ley/instructions: 65 files found
- .ai-ley/shared/agents: 12 files found
- .github/ai-ley/personas: 21 files found

Extracting metadata...
- Prompts: 42/42 processed
- Instructions: 65/65 processed
- Agents: 12/12 processed
- Personas: 21/21 processed

Generating indexes...
✅ .ai-ley/shared/indexes/prompts.md
✅ .ai-ley/shared/indexes/instructions.md
✅ .ai-ley/shared/indexes/agents.md
✅ .ai-ley/shared/indexes/personas.md
✅ .ai-ley/shared/indexes/INDEX_CHANGES.md

Quality checks...
⚠️  3 low-quality assets flagged in QUESTIONS.md

✅ Index rebuild complete!
```

### Example 2: Dry-Run Mode

**Command**:

```
/rebuild-indexes mode=dry-run
```

**Expected Output**:

```
🔍 Dry-run mode - Previewing changes...

Would update .ai-ley/shared/indexes/prompts.md:
  New entries: 2
  - .github/prompts/new-feature.md
  - .github/prompts/experimental.md

  Updated entries: 5
  - .github/prompts/deploy.md (description enriched)
  - .github/prompts/test.md (keywords updated)
  - .github/prompts/build.md (quality reassessed: 4 → 5)

  Manual overrides preserved: 3
  - .github/prompts/custom.md (custom description)

📄 No files modified. Run with mode=apply to commit changes.
```

### Example 3: Force Mode with Confirmation

**Command**:

```
/rebuild-indexes mode=force
```

**Expected Output**:

```
⚠️  Force mode will overwrite all manual changes!

Manual overrides that will be lost:
- .github/prompts/custom-1.md (custom description)
- .github/prompts/custom-2.md (manual quality score)
- .github/ai-ley/instructions/special.md (curated keywords)
... 12 more entries

Continue with force rebuild? (yes/no): yes

🔄 Force rebuilding indexes (all manual changes will be overwritten)...

[Processing...]

✅ Force rebuild complete. All entries regenerated from source files.
⚠️  15 manual overrides were replaced. See INDEX_CHANGES.md for details.
```

### Example 4: Generated Index Entry

**Source file**: `.github/prompts/deploy.md`

**YAML Frontmatter**:

```yaml
---
agentMode: general
description: Deploy cloud infrastructure using Terraform
keywords: [deployment, infrastructure, terraform, cloud, automation]
title: Deploy Infrastructure
version: 1.2.0
---
```

**Generated Index Entry**:

| Path                               | Keywords                                                 | Description                                                                                                                                                                                                          | Quality |
| ---------------------------------- | -------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `.github/prompts/deploy.md` | deployment, infrastructure, terraform, cloud, automation | Deploy cloud infrastructure using Terraform with validation and rollback capabilities. Supports multi-environment deployments, state management, and automated testing. Use when provisioning or updating resources. | 5       |

## Notes

### Important Considerations

- **Manual overrides are valuable**: Preserve custom descriptions and curated metadata unless explicitly forced
- **Quality scores are subjective**: Default to 3 when uncertain and flag for manual review
- **Keywords enable discovery**: Invest time in extracting relevant, specific keywords
- **Descriptions should be actionable**: Focus on "what" and "when to use", not implementation details
- **Indexes are living documents**: Regular rebuilds keep them current with codebase changes

### Best Practices

- **Run dry-run first**: Always preview changes before applying, especially with existing indexes
- **Review change reports**: Check INDEX_CHANGES.md after rebuild to understand modifications
- **Address QUESTIONS.md**: Promptly review and resolve flagged quality issues
- **Maintain quality**: Use index rebuilds as opportunity to identify and improve low-quality assets
- **Preserve manual work**: Use `apply` mode by default to respect human curation
- **Document quality criteria**: Keep quality scoring criteria consistent across rebuilds

### Common Pitfalls to Avoid

- **Don't use force mode casually**: Only use when intentionally regenerating everything
- **Don't ignore quality flags**: Low scores indicate assets needing attention
- **Don't skip dry-run**: Preview changes to avoid unintended overwrites
- **Don't auto-accept uncertain scores**: Flag ambiguous cases in QUESTIONS.md
- **Don't forget statistics**: Use quality metrics to track knowledge base health

### Extensibility

- **Custom scoring**: Quality criteria can be tuned per asset type
- **Additional metadata**: Extend index schema with new fields as needed
- **Category filtering**: Support rebuilding specific index or category
- **Integration**: Indexes can feed other commands (search, suggest, validate)
- **Automation**: Schedule periodic rebuilds to maintain currency

## Troubleshooting

### Issue: Conflicting metadata between existing and generated

**Solution**: Preserve existing by default, document conflict in INDEX_CHANGES.md, flag in QUESTIONS.md

### Issue: Unable to determine quality score

**Solution**: Default to 3, add entry to QUESTIONS.md with specific issues identified

### Issue: Missing YAML frontmatter in source file

**Solution**: Extract metadata from content, assign quality score 2-3, flag for improvement

### Issue: File exists in index but not in directory

**Solution**: Mark as removed in INDEX_CHANGES.md, exclude from updated index

### Issue: Description exceeds 150 words

**Solution**: Truncate to 150 words, preserve full description in source file, flag if critical content lost

### Issue: Duplicate files with same name in different subdirectories

**Solution**: Use full relative path to disambiguate, ensure paths are unique in index
---

version: 1.0.0
updated: 2026-01-11
reviewed: 2026-01-11
score: 4.0
