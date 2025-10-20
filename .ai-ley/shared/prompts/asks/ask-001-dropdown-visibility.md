# ASK-001: Tab Dropdown Menu Always Visible

**Date Created**: 2025-01-21  
**Status**: COMPLETED  
**Priority**: Medium  
**Type**: UI Enhancement  
**Source**: User Request - Tab UX Improvement

## Original Ask

"3 vertical dots for dropdown menu on the tabs should always be visible"

## Analysis & Categorization

**Category**: UI Enhancement - Immediate Priority  
**Scope**: WorkflowTabs Component (visual-editor/src/features/tabs/components/WorkflowTabs.tsx)  
**Technical Complexity**: Simple CSS styling change  
**Impact**: Low-risk UX improvement for tab discoverability

## Requirement Definition

**R34: Persistent Tab Dropdown Menu Visibility**

**Description**: Modify the WorkflowTabs component to make the three vertical dots dropdown menu permanently visible instead of only appearing on hover, improving user experience and feature discoverability.

**Acceptance Criteria**:

- [ ] Three vertical dots (MoreVertical icon) are always visible on all tabs
- [ ] Dropdown functionality remains unchanged (click to open menu)
- [ ] Visual styling maintains professional appearance
- [ ] Keyboard navigation and accessibility standards are preserved
- [ ] No performance impact from CSS changes
- [ ] Consistent behavior across all browser environments

**Priority**: Medium  
**Complexity**: Simple  
**Dependencies**: None  
**Source**: User request for tab UX improvement

## User Story

**As a** workflow creator using the AI-Ley Builder Visual Flow Editor  
**I want** the tab dropdown menu (three dots) to always be visible  
**So that** I can quickly discover and access tab actions without needing to hover first

## Technical Implementation Details

**Current State**:

- CSS classes: `opacity-0 group-hover:opacity-100 transition-opacity`
- Hidden by default, shows on tab hover

**Required Change**:

- Remove `opacity-0` and `group-hover:opacity-100` classes
- Maintain `transition-opacity` for smooth interactions
- Ensure proper contrast and accessibility compliance

**File to Modify**:

- `/src/visual-editor/src/features/tabs/components/WorkflowTabs.tsx` (line ~703)

## WCAG Compliance Considerations

- Ensure dropdown button meets WCAG 2.1 AA color contrast requirements
- Maintain keyboard navigation accessibility
- Preserve screen reader compatibility
- Follow focus management best practices

## Quality Assurance

**Testing Requirements**:

- [ ] Visual regression testing for tab appearance
- [ ] Functional testing of dropdown menu behavior
- [ ] Accessibility testing with keyboard navigation
- [ ] Cross-browser compatibility verification
- [ ] Performance impact assessment

**Definition of Done**:

- [ ] Dropdown dots are always visible on all tabs
- [ ] All existing functionality preserved
- [ ] Accessibility compliance maintained
- [ ] Code changes reviewed and approved
- [ ] Documentation updated if necessary

## Related Requirements

**Enhances**: R8 (User Experience Requirements), R18 (Node Visual Styling Enhancement)  
**Supports**: Overall visual consistency and user experience goals
