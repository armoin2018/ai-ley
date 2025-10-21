# ASK-002: Storage Folder Path Security and Proper Construction

**Date Created**: 2025-09-19  
**Status**: COMPLETED  
**Priority**: High  
**Type**: Security & Technical Fix  
**Source**: User Report - Path Construction Issue

## Original Ask

"in the storage folder the detected root and .ai-ley is missing a slash to separate. when paths are stored in the configuration it should always be based off the path below the detected root to restrict scope of the project and protect the integrity of the system. use the detected root rather that relative changes (eg ../../ and ../)"

## Analysis & Categorization

**Category**: Security & Technical Enhancement - High Priority  
**Scope**: Path handling utilities and storage configuration (src/visual-editor/src/utils/paths.ts)  
**Technical Complexity**: Moderate - Path manipulation and security considerations  
**Security Impact**: High - Path traversal vulnerability prevention

## Issue Identification

### Primary Issues

1. **Missing Path Separator**: In `getAiLeyRoot()` function, concatenation of `gitRoot` with `.ai-ley` lacks proper path separator

   - Current: `${gitRoot}.ai-ley` could result in `/Users/user/project.ai-ley`
   - Expected: `/Users/user/project/.ai-ley`

2. **Path Traversal Security Risk**: Relative paths like `../../` can allow path traversal outside project scope

   - Current fallback: `return '../../';` in `getGitRoot()`
   - Risk: Allows access outside detected project root

3. **Inconsistent Path Scoping**: Paths should be consistently scoped below detected root for security

## Requirement Definition

**R35: Secure Path Construction and Scoping**

**Description**: Implement secure path construction that ensures proper path separators and restricts all paths to be scoped below the detected project root, preventing path traversal vulnerabilities and ensuring system integrity.

**Acceptance Criteria**:

- [ ] `getAiLeyRoot()` function properly joins paths with correct separators
- [ ] All paths are constrained to be within or below the detected project root
- [ ] No relative path traversals (../, ../../) are used in path construction
- [ ] Path joining utility handles edge cases (trailing/leading slashes, empty parts)
- [ ] Storage folder paths are validated to be within project scope
- [ ] Fallback paths maintain security constraints
- [ ] Cross-platform path handling (Windows/Unix) works correctly

**Priority**: High  
**Complexity**: Moderate  
**Dependencies**: None  
**Source**: ASK-002 - 2025-09-19 - Path construction security issue

## User Story

**As a** system administrator or security-conscious user  
**I want** all file paths to be properly constructed and scoped within the project root  
**So that** the system is protected from path traversal attacks and maintains proper file system boundaries

## Technical Implementation Details

**Current Problematic Implementation**:

```typescript
export const getAiLeyRoot = (): string => {
  const gitRoot = getGitRoot();
  return `${gitRoot}.ai-ley`; // Missing path separator
};

export const getGitRoot = (): string => {
  // ...
  return '../../'; // Relative path traversal risk
};
```

**Required Changes**:

1. **Fix Path Separator Issue**:

   ```typescript
   export const getAiLeyRoot = (): string => {
     const gitRoot = getGitRoot();
     return joinPath(gitRoot, '.ai-ley'); // Use proper path joining
   };
   ```

2. **Secure Path Validation**:

   ```typescript
   const validatePathWithinRoot = (path: string, root: string): boolean => {
     const resolvedPath = resolvePath(path);
     const resolvedRoot = resolvePath(root);
     return resolvedPath.startsWith(resolvedRoot);
   };
   ```

3. **Enhanced Path Joining**:
   ```typescript
   const joinPath = (...parts: string[]): string => {
     return parts
       .filter((part) => part && part !== '.')
       .map((part) => part.replace(/^\/+|\/+$/g, '')) // Trim slashes
       .join('/')
       .replace(/\/+/g, '/'); // Remove duplicate slashes
   };
   ```

## Security Considerations

**Path Traversal Prevention**:

- Validate all constructed paths remain within project root
- Reject paths containing `../` or `..\\` sequences
- Use absolute paths when possible instead of relative navigation

**Cross-Platform Compatibility**:

- Handle both Unix (`/`) and Windows (`\`) path separators
- Normalize paths consistently across platforms
- Test on multiple operating systems

**Configuration Validation**:

- Validate storage folder paths before saving to configuration
- Prevent users from configuring paths outside project scope
- Provide clear error messages for invalid path configurations

## Quality Assurance

**Testing Requirements**:

- [ ] Unit tests for path construction functions
- [ ] Security tests for path traversal attempts
- [ ] Cross-platform path handling tests
- [ ] Configuration validation tests
- [ ] Integration tests with actual file system operations

**Definition of Done**:

- [ ] All path construction uses proper separators
- [ ] Path traversal vulnerabilities eliminated
- [ ] Storage paths validated and scoped correctly
- [ ] Security review completed
- [ ] Cross-platform testing passed
- [ ] Documentation updated

## Related Requirements

**Enhances**: R30 (Scoped Storage System)  
**Security Relates**: All file system interaction requirements  
**Supports**: Overall system security and integrity goals
