# Plan

Generate comprehensive project plans from requirements using Epic-Story-Task structure with JIRA compatibility and Gantt charts.

**Command Reference**: [.ai-ley/shared/prompts/plan.md](../../.ai-ley/shared/prompts/plan.md)

## Overview

The `plan` command converts detailed requirements into actionable project plans with:

- Epic-Story-Task hierarchical breakdown
- JIRA-compatible CSV import files
- PlantUML Gantt charts
- Resource allocation planning
- Business case documentation
- Architecture planning artifacts

## Usage

Use the plan command to generate comprehensive project plans:

```
plan
```

## Key Features

- **Epic Decomposition**: Break requirements into logical epics with business value
- **Story Planning**: Convert epics into user stories with acceptance criteria
- **Task Breakdown**: Decompose stories into actionable tasks with time estimates
- **JIRA Integration**: Generate import-ready CSV files for project management
- **Timeline Visualization**: Create PlantUML Gantt charts with dependencies
- **Resource Mapping**: Align tasks with available personas and instructions
- **Quality Gates**: Define validation criteria at task, story, and epic levels

## Input Requirements

- `{{files.requirements}}` - Detailed project requirements
- `{{files.suggestions}}` - Enhancement suggestions (optional)
- `{{files.bugs}}` - Known issues to address (optional)
- Available personas in `{{folders.personas}}/`
- Available instructions in `{{folders.instructions}}/`

## Output Structure

Creates comprehensive plan under `{{folders.plan}}/`:

- Epic-Story-Task hierarchy with detailed documentation
- JIRA import CSV and PlantUML Gantt charts
- Business case and architecture documentation
- Resource allocation and timeline planning
