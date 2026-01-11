---
name: 'React Redux.Instructions'
description: 'Development guidelines and best practices for React Redux.Instructions'
keywords: [api, common, async, better, compliance, architecture, assistant, avoid, benefits, complex]
---



`
---
applyTo: "redux, react-redux, @reduxjs/toolkit, **/*{store,reducer,slice}.{js,ts}"
---

# React Redux State Management Instructions

## Overview
- **Domain**: State Management for React Applications
- **Purpose**: Build scalable, predictable state management with Redux and React
- **Applicable To**: Complex React applications with shared state requirements
- **Integration Level**: Application-wide state management and data flow

## Core Principles

### Fundamental Concepts
1. **Single Source of Truth**: All application state lives in a single store
2. **State is Read-Only**: State changes only through dispatched actions
3. **Changes Made with Pure Functions**: Reducers are pure functions that return new state
4. **Predictable State Updates**: Actions describe what happened, reducers specify how state changes

### Key Benefits
- Predictable state management with time-travel debugging
- Excellent developer tools and debugging capabilities
- Clear data flow and state change tracking
- Powerful middleware ecosystem for async operations

### Common Misconceptions
- **Myth**: Redux is required for all React applications
  **Reality**: Use Redux only for complex state that needs to be shared across components
- **Myth**: Redux is too complex and has too much boilerplate
  **Reality**: Redux Toolkit significantly reduces boilerplate and complexity

## Implementation Framework

### Getting Started
#### Prerequisites
- React 16.8+ (with hooks support)
- Modern JavaScript/TypeScript knowledge
- Understanding of React component patterns

#### Initial Setup
See [example-1](./examples/react-redux/example-1.bash)

### Core Methodologies
#### Redux Toolkit Approach (Recommended)
- **Purpose**: Modern Redux development with less boilerplate
- **When to Use**: All new Redux applications
- **Implementation Steps**:
  1. Create store with configureStore()
  2. Define slices with createSlice()
  3. Use createAsyncThunk for async operations
  4. Connect components with useSelector and useDispatch hooks
- **Success Metrics**: Reduced boilerplate and improved developer experience

#### Traditional Redux Pattern
- **Purpose**: Understanding core Redux concepts
- **When to Use**: Legacy codebases or educational purposes
- **Implementation Steps**:
  1. Define action types and creators
  2. Create reducers with switch statements
  3. Combine reducers and create store
  4. Connect components with connect() HOC or hooks
- **Success Metrics**: Clear understanding of Redux fundamentals

### Process Integration
#### Development Workflow
See [example-2](./examples/react-redux/example-2.bash)

#### Type Safety with TypeScript
See [example-3](./examples/react-redux/example-3.bash)

## Best Practices

### Modern Redux Toolkit Patterns
See [example-4](./examples/react-redux/example-4.typescript)

### Slice Definition with TypeScript
See [example-5](./examples/react-redux/example-5.typescript)

### Typed Hooks for Better DX
See [example-6](./examples/react-redux/example-6.typescript)

### Component Integration
See [example-7](./examples/react-redux/example-7.tsx)

## Common Patterns and Examples

### Pattern 1: RTK Query for API Management
**Scenario**: Efficient API state management with caching
**Implementation**:
See [example-8](./examples/react-redux/example-8.typescript)
**Expected Outcomes**: Automated caching, loading states, and optimistic updates

### Pattern 2: Middleware for Complex Logic
**Scenario**: Custom middleware for analytics and logging
**Implementation**:
See [example-9](./examples/react-redux/example-9.typescript)
**Expected Outcomes**: Cross-cutting concerns handled consistently

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Storing All State in Redux
- **Description**: Putting component-local state in Redux store
- **Why It's Problematic**: Unnecessary complexity and performance issues
- **Better Approach**: Use local state for UI-only state, Redux for shared state

#### Anti-Pattern 2: Mutating State Directly
- **Description**: Modifying state objects directly in reducers
- **Why It's Problematic**: Breaks Redux's immutability contract
- **Better Approach**: Always return new state objects (Redux Toolkit uses Immer internally)

## Tools and Resources

### Essential Tools
#### Redux DevTools
See [example-10](./examples/react-redux/example-10.typescript)

#### Testing Utilities
See [example-11](./examples/react-redux/example-11.typescript)

### Learning Resources
- **Redux Toolkit Documentation**: https://redux-toolkit.js.org/
- **React Redux Documentation**: https://react-redux.js.org/
- **Redux DevTools**: https://github.com/reduxjs/redux-devtools
- **Redux Style Guide**: https://redux.js.org/style-guide/style-guide

## Quality and Compliance

### Quality Standards
- All async operations handled with proper loading/error states
- TypeScript integration for type safety
- Proper action naming conventions following domain/action pattern
- Comprehensive error handling and user feedback

### Performance Standards
- Minimize unnecessary re-renders with proper selector usage
- Use memoization for expensive selector computations
- Implement proper normalization for nested data structures
- Optimize bundle size with code splitting

### Testing Requirements
- Unit tests for all reducers and selectors
- Integration tests for complex async flows
- Component tests with Redux integration
- End-to-end tests for critical user journeys

## AI Assistant Guidelines

When helping with React Redux:

1. **State Design First**: Analyze what state truly needs to be global vs local
2. **Modern Patterns**: Always recommend Redux Toolkit over traditional Redux
3. **Type Safety**: Include TypeScript patterns for better developer experience
4. **Performance Focus**: Consider re-render optimization and selector efficiency
5. **Testing Strategy**: Include comprehensive testing approaches
6. **Error Handling**: Implement proper error states and user feedback
7. **Best Practices**: Follow Redux style guide and community conventions
8. **Integration Planning**: Consider how Redux fits into the larger application architecture

### Decision Making Framework
When helping teams choose Redux approaches:

1. **State Complexity Assessment**: Evaluate if Redux is actually needed
2. **Team Experience**: Consider team familiarity with Redux concepts
3. **Application Scale**: Plan for current and future state management needs
4. **Performance Requirements**: Design for optimal rendering performance
5. **Testing Strategy**: Plan for maintainable and comprehensive test coverage

### Code Generation Rules
- Generate Redux Toolkit code with createSlice and createAsyncThunk
- Include proper TypeScript types and interfaces
- Use modern React hooks (useSelector, useDispatch) over connect()
- Include proper error handling and loading states
- Generate corresponding tests for reducers and components
- Follow naming conventions (domain/action pattern)
- Include performance optimization patterns
- Provide comprehensive documentation and examples

### Quality Enforcement
- ✅ Enforce Redux Toolkit usage over traditional Redux
- ✅ Require TypeScript integration for type safety
- ✅ Block direct state mutation outside of RTK slices
- ✅ Enforce proper async action handling with createAsyncThunk
- ✅ Require proper selector usage to prevent unnecessary re-renders
- ✅ Enforce consistent action naming conventions
- ✅ Require comprehensive error handling patterns
- ✅ Promote proper state normalization for complex data

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
