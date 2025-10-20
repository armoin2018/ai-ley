# Ask Files Index

This directory contains user requests and feature asks that have been processed through the ask.prompt.md framework.

## Active Asks

### ASK-001: Tab Dropdown Menu Always Visible

- **File**: `ask-001-dropdown-visibility.md`
- **Status**: COMPLETED
- **Priority**: Medium
- **Type**: UI Enhancement
- **Created**: 2025-01-21
- **Description**: Make three vertical dots dropdown menu on tabs always visible instead of hover-only

### ASK-002: Storage Folder Path Security and Proper Construction

- **File**: `ask-002-path-security.md`
- **Status**: COMPLETED
- **Priority**: High
- **Type**: Security & Technical Fix
- **Created**: 2025-09-19
- **Description**: Fix missing slash separator in path construction and ensure all paths are scoped below detected root for security

### ASK-003: Model-Driven AI Agent Instruction System

- **File**: `ask-003-model-driven-system.md`
- **Status**: READY_FOR_INTEGRATION
- **Priority**: High
- **Type**: Architecture Enhancement
- **Created**: 2025-01-21
- **Description**: Transform visual editor to model-driven approach with templates, compilation, and AI system integration

## Ask Processing Workflow

1. **Parse and Analyze Ask** - Categorize request and assess priority/complexity
2. **Requirements Integration** - Create formal requirement (R[X]) with acceptance criteria
3. **Ask File Management** - Document in this directory with proper tracking
4. **Implementation** - Execute technical changes following the requirement
5. **Quality Assurance** - Validate implementation meets acceptance criteria
6. **Documentation Update** - Update relevant documentation and mark complete

## Status Definitions

- **READY_FOR_INTEGRATION**: Ask analyzed, requirement created, ready for implementation
- **IN_PROGRESS**: Technical implementation underway
- **COMPLETED**: Implementation finished and validated
- **ARCHIVED**: Historical ask, implementation complete

## File Naming Convention

- **Format**: `ask-[XXX]-[descriptive-name].md`
- **XXX**: Zero-padded sequential number (001, 002, etc.)
- **descriptive-name**: Kebab-case description of the ask
