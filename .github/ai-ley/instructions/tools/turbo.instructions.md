---
name: 'Turbo.Instructions'
description: 'See [example-5](./examples/turbo/example-5.'
keywords: [advanced, build, architecture, authentication, assistant, backend, cache, avoid, ci/cd, benefits]
---



`
---
applyTo: "turbo, build-tools, monorepo, **/turbo.json, **/package.json, turborepo"
---

# Turbo Build Tool Instructions

## Overview
- **Domain**: High-Performance Monorepo Build System and Task Runner
- **Purpose**: Accelerate builds and task execution in JavaScript/TypeScript monorepos with intelligent caching
- **Applicable To**: Monorepos, multi-package projects, CI/CD pipelines, and development workflows
- **Integration Level**: Development toolchains, deployment automation, and team collaboration

## Core Principles

### Fundamental Concepts
1. **Intelligent Caching**: Cache build outputs and share them across machines and developers
2. **Incremental Builds**: Only rebuild what has changed, dramatically reducing build times
3. **Task Pipeline Optimization**: Parallelizes and schedules tasks based on dependencies
4. **Remote Caching**: Share cache artifacts across team members and CI/CD systems

### Key Benefits
- Dramatic build time reduction (often 85%+ faster with cache hits)
- Zero-configuration intelligent caching out of the box
- Parallel task execution with dependency-aware scheduling
- Seamless integration with existing package managers (npm, yarn, pnpm)
- Built-in support for remote caching and team collaboration

### Common Misconceptions
- **Myth**: Turbo is only for large monorepos
  **Reality**: Turbo provides benefits for any project with multiple packages or complex build steps
- **Myth**: Setting up Turbo requires significant configuration changes
  **Reality**: Turbo works with minimal configuration and respects existing package.json scripts

## Implementation Framework

### Getting Started
#### Prerequisites
- Node.js 14+ (Node.js 16+ recommended for optimal performance)
- A monorepo structure with multiple packages
- npm, yarn, or pnpm as package manager

#### Initial Setup
See [example-1](./examples/turbo/example-1.bash)

### Core Methodologies
#### Monorepo Setup and Configuration
- **Purpose**: Structure monorepo for optimal build performance and caching
- **When to Use**: Setting up new monorepos or optimizing existing ones
- **Implementation Steps**:
  1. Define package structure with clear dependencies
  2. Configure turbo.json with build pipelines
  3. Set up task dependencies and parallelization
  4. Implement caching strategies for different task types
- **Success Metrics**: Reduced build times and consistent development experience

#### Remote Caching Strategy
- **Purpose**: Share build artifacts across team members and CI/CD systems
- **When to Use**: Team development and continuous integration environments
- **Implementation Steps**:
  1. Set up Vercel remote cache or custom cache backend
  2. Configure authentication and access controls
  3. Implement cache invalidation strategies
  4. Monitor cache hit rates and performance
- **Success Metrics**: High cache hit rates (>80%) and improved CI/CD performance

### Process Integration
#### Comprehensive Turbo Configuration
See [example-2](./examples/turbo/example-2.json)

#### Monorepo Package Structure
See [example-3](./examples/turbo/example-3.txt)

## Best Practices

### Optimized Package.json Configuration
See [example-4](./examples/turbo/example-4.json)

See [example-5](./examples/turbo/example-5.json)

See [example-6](./examples/turbo/example-6.json)

### Advanced CI/CD Integration
See [example-7](./examples/turbo/example-7.yaml)

### Performance Monitoring and Optimization
See [example-8](./examples/turbo/example-8.typescript)

## Common Patterns and Examples

### Pattern 1: Micro-Frontend Architecture with Turbo
**Scenario**: Build and deploy multiple micro-frontends with shared dependencies
**Implementation**:
See [example-9](./examples/turbo/example-9.json)

See [example-10](./examples/turbo/example-10.javascript)
**Expected Outcomes**: Scalable micro-frontend architecture with optimized builds and caching

### Pattern 2: Full-Stack Development with Turbo
**Scenario**: Coordinate frontend, backend, and shared library development
**Implementation**:
See [example-11](./examples/turbo/example-11.json)

See [example-12](./examples/turbo/example-12.yaml)
**Expected Outcomes**: Coordinated full-stack development with optimized build pipeline

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Over-Granular Task Dependencies
- **Description**: Creating too many small, interdependent tasks that don't provide caching benefits
- **Why It's Problematic**: Reduces parallelization opportunities and complicates dependency graph
- **Better Approach**: Group related operations into meaningful, cacheable tasks

#### Anti-Pattern 2: Ignoring Cache Configuration
- **Description**: Not configuring proper inputs and outputs for caching
- **Why It's Problematic**: Results in cache misses and poor performance
- **Better Approach**: Carefully configure inputs, outputs, and dependencies for optimal caching

## Tools and Resources

### Turbo CLI and Development Tools
See [example-13](./examples/turbo/example-13.bash)

### Remote Cache Setup
See [example-14](./examples/turbo/example-14.bash)

### Learning Resources
- **Turbo Documentation**: https://turbo.build/repo/docs
- **Turbo Examples**: https://github.com/vercel/turbo/tree/main/examples
- **Monorepo Best Practices**: https://turbo.build/repo/docs/handbook
- **Performance Guide**: https://turbo.build/repo/docs/core-concepts/caching

## Quality and Compliance

### Quality Standards
- Fast incremental builds (>80% cache hit rate in steady state)
- Proper task dependency configuration with optimal parallelization
- Comprehensive test coverage across all packages
- Consistent code formatting and linting across monorepo
- Automated dependency management and security updates

### Security Standards
- Secure remote cache access with proper authentication
- Regular dependency vulnerability scanning and updates
- Proper secret management for CI/CD environments
- Code signing and verification for published packages
- Access controls for monorepo package publishing

### Performance Standards
- Build time reduction of >50% compared to non-cached builds
- Optimal task parallelization with dependency-aware scheduling
- Efficient use of CI/CD resources with intelligent caching
- Fast local development feedback loops (<5 seconds for incremental changes)
- Effective use of remote cache across team members

## AI Assistant Guidelines

When helping with Turbo Build Tool:

1. **Caching Strategy**: Prioritize intelligent caching configuration for maximum performance gains
2. **Dependency Optimization**: Design task pipelines for optimal parallelization and dependency management
3. **Monorepo Structure**: Recommend proper package organization and workspace configuration
4. **Performance Focus**: Emphasize build speed optimization and cache hit rate improvement
5. **Team Collaboration**: Implement remote caching for team efficiency and CI/CD optimization
6. **Incremental Adoption**: Support gradual migration from existing build systems
7. **Monitoring Strategy**: Include performance monitoring and optimization techniques
8. **Integration Planning**: Consider integration with existing tools and workflows

### Decision Making Framework
When helping teams choose Turbo configurations:

1. **Project Analysis**: Understand monorepo structure and build requirements
2. **Performance Requirements**: Define build speed and caching targets
3. **Team Workflow**: Consider developer experience and collaboration needs
4. **CI/CD Integration**: Plan for automated build and deployment pipelines
5. **Scaling Strategy**: Design for future growth and package additions

### Code Generation Rules
- Generate optimal turbo.json configurations with proper task dependencies
- Include comprehensive caching strategies with inputs and outputs
- Use modern monorepo patterns with workspace configuration
- Implement proper CI/CD integration with remote caching
- Generate performance monitoring and optimization utilities
- Include testing and quality assurance integration across packages
- Provide clear documentation and team onboarding guides
- Include migration strategies from existing build systems

### Quality Enforcement
- ✅ Enforce proper task dependency configuration in turbo.json
- ✅ Require cache hit rate monitoring and optimization (target >80%)
- ✅ Block commits that break build pipeline or dependency graph
- ✅ Enforce consistent package.json scripts across workspace
- ✅ Require comprehensive testing strategy across all packages
- ✅ Enforce proper remote cache configuration for team environments
- ✅ Promote incremental migration strategies for existing projects
- ✅ Require performance monitoring and optimization documentation

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
