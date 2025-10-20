# Visual Editor PlantUML Integration Requirements

## Executive Summary

The AI-LEY Visual Editor requires enhanced PlantUML integration to support seamless bidirectional conversion between visual workflow representations and PlantUML source files. The core challenge was bridging standard PlantUML activity diagrams with rich visual editor metadata requirements while preserving PlantUML tool compatibility.

## Problem Statement

The existing PlantUML parsing pipeline could not create proper visual representations because:
1. Standard PlantUML activity diagrams lack the rich metadata needed for visual editor nodes
2. Visual editor requires specific node types, positions, execution parameters, and other metadata
3. PlantUML files must remain compatible with standard PlantUML tools for external use
4. No mechanism existed to embed visual editor metadata without affecting PlantUML rendering

## Solution: Internal Documentation Metadata System

**R1: PlantUML Metadata Comment System**

- **Description**: Implement internal documentation metadata system using PlantUML comment syntax that preserves tool compatibility while providing rich visual editor information
- **Acceptance Criteria**:
  - [x] Parse `'@node-meta {JSON}` comment format in PlantUML files
  - [x] Extract node type, position, execution parameters from metadata
  - [x] Support all visual editor node types: input, custom-prompt, instruction, command-prompt-file, output-formatter, conditional, etc.
  - [x] Maintain PlantUML tool compatibility (comments are ignored by PlantUML renderers)
  - [x] Preserve original PlantUML activity diagram syntax for standard tools
- **Priority**: High
- **Complexity**: Moderate
- **Dependencies**: Enhanced plantuml-parser.ts, export.ts localStorage bridge
- **Source**: User requirement for PlantUML visual rendering

**R2: Enhanced PlantUML Parser**

- **Description**: Update PlantUML parser to read metadata comments and create visual editor compatible node structures
- **Acceptance Criteria**:
  - [x] Parse metadata comments preceding activity nodes
  - [x] Map metadata types to visual editor node types with fallback to auto-detection
  - [x] Extract position data from metadata for accurate visual layout
  - [x] Merge metadata with default node properties
  - [x] Support comprehensive debugging and logging for parsing pipeline
- **Priority**: High
- **Complexity**: High
- **Dependencies**: plantuml-parser.ts enhancements
- **Source**: Visual representation rendering failure

**R3: PlantUML Content Enhancement**

- **Description**: Enhance existing PlantUML files with comprehensive metadata for all workflow nodes
- **Acceptance Criteria**:
  - [x] Add metadata for all key workflow activities (requirements, learn, evolve, build-design, etc.)
  - [x] Include proper node types based on AI-LEY command patterns
  - [x] Define accurate position data for visual layout
  - [x] Add execution parameters (fileName, content, variables, persona, etc.)
  - [x] Preserve original PlantUML structure and comments
- **Priority**: High
- **Complexity**: Moderate
- **Dependencies**: Updated build-project.puml content in localStorage
- **Source**: Visual editor node creation requirements

## Implementation Details

### Metadata Format Specification

```plantuml
'@node-meta {"type": "command-prompt-file", "fileName": "design.md", "content": "System design and architecture planning", "position": {"x": 300, "y": 600}}
:build-design;
```

### Supported Node Types Mapping

- `input` → Requirements gathering, ASK document processing
- `custom-prompt` → Research, learning, innovation analysis
- `instruction` → Evolve operations, planning, general instructions  
- `command-prompt-file` → File generation (design.md, architecture.md, etc.)
- `output-formatter` → Documentation, reports, presentations
- `conditional` → Decision points and branching logic

### Enhanced Parser Features

- Metadata comment parsing with JSON extraction
- Type fallback to auto-detection based on activity names
- Position data integration for visual layout preservation
- Comprehensive property merging with defaults
- Debug logging for parsing pipeline visibility

## Technical Considerations

**Architecture Constraints**: 
- Browser-based application with localStorage file simulation
- PlantUML compatibility requirements for external tools
- React Flow visual editor integration

**Technology Stack**: 
- TypeScript/React with React Flow for visual editing
- PlantUML comment-based metadata embedding
- localStorage bridge for file system simulation

**Performance Architecture**: 
- Efficient JSON parsing of metadata comments
- Optimized node/edge creation for visual rendering
- Cached PlantUML content loading

## Success Metrics

**Technical Metrics**:
- [x] PlantUML files successfully parsed to visual representations
- [x] All workflow nodes render with correct types and properties
- [x] Source view displays original PlantUML content
- [x] Visual editor creates tabs from PlantUML files

**User Experience Metrics**:
- [x] Seamless switching between visual and source views
- [x] Accurate workflow representation from PlantUML imports
- [x] Preserved workflow execution metadata in visual editor

## Implementation Status

### Completed
- [x] Enhanced PlantUML parser with metadata comment support
- [x] Updated build-project.puml with comprehensive metadata
- [x] Implemented node type mapping and position extraction
- [x] Added debugging and logging throughout parsing pipeline
- [x] Forced localStorage refresh for metadata testing

### Integration Points
- Enhanced parser integrates with existing useWorkflowTabs hook
- Metadata system works with WorkflowManager PlantUML file listing
- Source editor displays original PlantUML content with metadata
- Visual editor creates proper node structures from parsed metadata

## Future Enhancements

**NF1: Metadata Validation**
- Schema validation for metadata JSON structure
- Type safety for node properties
- Error handling for malformed metadata

**NF2: Metadata Editor**
- Visual metadata editing in source view
- Automatic metadata generation from visual changes
- Metadata synchronization between views

**C1: PlantUML Standards Compliance**
- Ensure metadata comments remain invisible to PlantUML tools
- Validate generated PlantUML syntax compatibility
- Maintain standard activity diagram conventions

## Notes

The internal documentation metadata system successfully bridges the gap between standard PlantUML activity diagrams and rich visual editor requirements. By using PlantUML comment syntax (`'@node-meta`), we preserve full compatibility with external PlantUML tools while providing all necessary metadata for accurate visual representation.

This approach ensures that PlantUML files can be:
1. Edited and viewed in standard PlantUML tools without metadata interference
2. Parsed by the visual editor with full node type and execution information
3. Used for both visual workflow editing and traditional PlantUML documentation

The solution maintains the principle of single source of truth while supporting multiple presentation formats.