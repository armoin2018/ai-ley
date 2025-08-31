# Documentation Instructions

## Overview
- **Domain**: Software Documentation and Knowledge Management
- **Purpose**: Create and maintain comprehensive, accessible, and useful documentation for software projects
- **Applicable To**: All software development projects, APIs, libraries, and systems
- **Integration Level**: Core component of development lifecycle and team collaboration

## Core Principles

### Fundamental Concepts
1. **User-Centered**: Documentation should serve the needs of its intended audience first
2. **Living Documentation**: Documentation evolves with the codebase and stays current
3. **Discoverability**: Information should be easy to find and navigate
4. **Accessibility**: Documentation should be accessible to users with diverse abilities and technical backgrounds

### Key Benefits
- Reduced onboarding time for new team members
- Improved code maintainability and knowledge sharing
- Better user adoption and customer satisfaction
- Reduced support burden and repeated questions
- Enhanced team productivity and collaboration

### Common Misconceptions
- **Myth**: Documentation is a one-time activity done at the end of development
  **Reality**: Best documentation is created incrementally throughout development
- **Myth**: More documentation is always better
  **Reality**: Concise, relevant documentation is more valuable than comprehensive but unused docs
- **Myth**: Only technical writers can create good documentation
  **Reality**: Developers and domain experts often write the most valuable documentation

## Implementation Framework

### Getting Started
#### Prerequisites
- Clear understanding of target audiences and their needs
- Established writing style guide and documentation standards
- Documentation tools and platforms selected
- Integration with development workflow

#### Initial Setup
1. **Audience Analysis**: Identify different user personas and their information needs
2. **Information Architecture**: Design logical structure and navigation
3. **Tool Selection**: Choose documentation platform, authoring tools, and workflow
4. **Style Guide**: Establish consistent writing style, formatting, and terminology

### Core Methodologies
#### Docs-as-Code Approach
- **Purpose**: Treat documentation with the same rigor as source code
- **When to Use**: Technical documentation, API docs, internal developer guides
- **Implementation Steps**:
  1. Store documentation in version control alongside code
  2. Use markup languages (Markdown, reStructuredText, AsciiDoc)
  3. Implement review processes for documentation changes
  4. Automate documentation builds and deployments
- **Success Metrics**: Documentation freshness, contributor participation, user engagement

#### API-First Documentation
- **Purpose**: Generate documentation directly from code and specifications
- **When to Use**: REST APIs, GraphQL APIs, SDK documentation
- **Implementation Steps**:
  1. Use OpenAPI/Swagger specifications for REST APIs
  2. Generate interactive documentation from specifications
  3. Include code examples in multiple programming languages
  4. Implement automated testing of documentation examples
- **Success Metrics**: API adoption rates, reduced support tickets, developer satisfaction

### Process Integration
#### Development Workflow Integration
```bash
# Example documentation workflow
git checkout -b feature/user-authentication
# Develop feature and update relevant documentation
echo "## Authentication API" >> docs/api-reference.md
echo "### POST /auth/login" >> docs/api-reference.md
git add docs/api-reference.md
git commit -m "feat: add user authentication

- Implements JWT-based authentication
- Updates API documentation with login endpoint
- Includes security considerations

Closes #123"
```

#### Continuous Integration Integration
```yaml
# Documentation CI/CD pipeline
name: Documentation
on:
  push:
    branches: [main]
    paths: ['docs/**', '**/*.md']

jobs:
  build-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '16'
          
      - name: Install dependencies
        run: |
          npm install -g @redocly/openapi-cli
          pip install mkdocs-material
          
      - name: Validate OpenAPI spec
        run: openapi lint docs/api/openapi.yaml
        
      - name: Build API documentation
        run: openapi build-docs docs/api/openapi.yaml --output docs/api/index.html
        
      - name: Build documentation site
        run: mkdocs build
        
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./site
```

#### Documentation Requirements
- README files for all repositories and major components
- API documentation for all public interfaces
- Architecture decision records (ADRs) for significant decisions
- User guides and tutorials for end-user features
- Troubleshooting guides and FAQ sections

## Best Practices

### Writing and Structure
#### README Structure
```markdown
# Project Name

Brief description of what this project does and who it's for.

## Quick Start

```bash
# Installation
npm install project-name

# Basic usage
project-name --help
```

## Features

-  Feature 1 with brief description
-  Feature 2 with brief description
- =§ Feature 3 (coming soon)

## Installation

### Prerequisites
- Node.js 16+ 
- Docker (optional)

### From npm
```bash
npm install -g project-name
```

### From source
```bash
git clone https://github.com/org/project-name
cd project-name
npm install
npm run build
```

## Usage

### Basic Example
```javascript
const project = require('project-name');

const result = project.doSomething({
  option1: 'value1',
  option2: true
});

console.log(result);
```

### Advanced Configuration
```javascript
// More complex example with explanation
const config = {
  environment: 'production',
  features: {
    featureA: true,
    featureB: false
  }
};
```

## API Reference

### Class: ProjectManager
#### constructor(options)
- `options` (Object)
  - `apiKey` (String) - Your API key
  - `timeout` (Number) - Request timeout in ms (default: 5000)

### projectManager.connect()
Returns: `Promise<Connection>`

Establishes connection to the service.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup and contribution guidelines.

## License

MIT - see [LICENSE](LICENSE) file.
```

#### API Documentation Structure
```yaml
# OpenAPI 3.0 specification example
openapi: 3.0.0
info:
  title: User Management API
  description: |
    Comprehensive API for user management operations including registration,
    authentication, and profile management.
    
    ## Authentication
    This API uses JWT tokens for authentication. Include the token in the 
    Authorization header: `Authorization: Bearer <token>`
    
  version: 2.1.0
  contact:
    name: API Support
    url: https://example.com/support
    email: support@example.com

servers:
  - url: https://api.example.com/v2
    description: Production server
  - url: https://staging-api.example.com/v2
    description: Staging server

paths:
  /users:
    post:
      summary: Create a new user
      description: |
        Creates a new user account with the provided information.
        
        ### Security
        - Passwords are hashed using bcrypt
        - Email verification is required
        - Rate limiting applies: 5 requests per minute
        
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateUserRequest'
            examples:
              basic_user:
                summary: Basic user creation
                value:
                  email: "user@example.com"
                  password: "securePassword123"
                  firstName: "John"
                  lastName: "Doe"
      responses:
        201:
          description: User created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        400:
          description: Invalid input data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ErrorResponse'
```

### Code Documentation
#### Inline Documentation Standards
```javascript
/**
 * Calculates the optimal route between two points using A* algorithm
 * 
 * @param {Object} start - Starting point coordinates
 * @param {number} start.lat - Latitude of starting point
 * @param {number} start.lng - Longitude of starting point
 * @param {Object} end - Ending point coordinates
 * @param {number} end.lat - Latitude of ending point
 * @param {number} end.lng - Longitude of ending point
 * @param {Object} [options] - Optional configuration
 * @param {string} [options.mode='driving'] - Travel mode (driving, walking, cycling)
 * @param {boolean} [options.avoidTolls=false] - Whether to avoid toll roads
 * @param {number} [options.maxDistance=Infinity] - Maximum allowed route distance in km
 * 
 * @returns {Promise<Object>} Route information
 * @returns {Object} return.path - Array of coordinates forming the route
 * @returns {number} return.distance - Total distance in kilometers
 * @returns {number} return.duration - Estimated duration in minutes
 * @returns {string} return.mode - Travel mode used
 * 
 * @throws {ValidationError} When start or end coordinates are invalid
 * @throws {RouteNotFoundError} When no route can be calculated
 * 
 * @example
 * // Basic usage
 * const route = await calculateRoute(
 *   { lat: 37.7749, lng: -122.4194 }, // San Francisco
 *   { lat: 34.0522, lng: -118.2437 }  // Los Angeles
 * );
 * 
 * @example
 * // With options
 * const route = await calculateRoute(start, end, {
 *   mode: 'walking',
 *   avoidTolls: true,
 *   maxDistance: 10
 * });
 */
async function calculateRoute(start, end, options = {}) {
    // Validate input coordinates
    if (!isValidCoordinate(start)) {
        throw new ValidationError('Invalid start coordinates');
    }
    
    if (!isValidCoordinate(end)) {
        throw new ValidationError('Invalid end coordinates');
    }
    
    const config = {
        mode: 'driving',
        avoidTolls: false,
        maxDistance: Infinity,
        ...options
    };
    
    try {
        // Implementation details...
        const pathfinder = new AStarPathfinder(config);
        return await pathfinder.findRoute(start, end);
    } catch (error) {
        if (error.code === 'NO_ROUTE_FOUND') {
            throw new RouteNotFoundError(`No route found between ${start} and ${end}`);
        }
        throw error;
    }
}
```

### Architecture Documentation
#### Architecture Decision Records (ADRs)
```markdown
# ADR-001: API Authentication Method

## Status
Accepted

## Context
Our application needs a secure authentication mechanism for API access. We need to balance security, developer experience, and implementation complexity.

Key requirements:
- Stateless authentication for scalability
- Support for web and mobile clients
- Secure token transmission
- Token expiration and refresh capabilities

## Decision
We will implement JWT (JSON Web Tokens) with refresh token rotation for API authentication.

## Rationale

### Advantages of JWT:
- **Stateless**: No server-side session storage required
- **Scalable**: Tokens contain all necessary information
- **Cross-domain**: Works well with microservices
- **Standard**: Industry-standard with good library support

### Implementation Details:
- Access tokens expire after 15 minutes
- Refresh tokens expire after 7 days
- Tokens are signed using RS256 (RSA with SHA-256)
- Public keys are rotated monthly

### Alternatives Considered:
1. **Session-based auth**: Rejected due to scalability concerns
2. **API keys**: Rejected due to lack of expiration mechanism
3. **OAuth 2.0**: Too complex for our current needs

## Consequences

### Positive:
- Scalable authentication system
- Good developer experience
- Industry standard approach

### Negative:
- Token revocation complexity
- Key management overhead
- Larger token size compared to session IDs

## Implementation Plan
1. Set up JWT library and key management
2. Implement token generation and validation
3. Create refresh token rotation mechanism
4. Update API documentation
5. Implement client-side token handling

## Compliance
This decision supports our security compliance requirements:
- SOC 2 Type II: Token-based auth with proper expiration
- GDPR: No personal data stored in tokens
- PCI DSS: Secure token handling practices

## References
- [RFC 7519: JSON Web Token (JWT)](https://tools.ietf.org/html/rfc7519)
- [OWASP JWT Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/JSON_Web_Token_for_Java_Cheat_Sheet.html)

---
**Date**: 2024-01-15  
**Authors**: John Doe, Jane Smith  
**Reviewers**: Security Team, Architecture Team
```

## Common Patterns and Examples

### Pattern 1: Progressive Documentation
**Scenario**: Building comprehensive documentation incrementally without overwhelming users
**Implementation**:
```markdown
# Getting Started (Level 1 - Essential)

Quick start guide that gets users running in 5 minutes.

## Installation
```bash
npm install my-package
```

## Basic Usage
```javascript
const pkg = require('my-package');
pkg.doBasicThing();
```

---

# User Guide (Level 2 - Detailed)

Comprehensive guide for regular users.

## Configuration
Detailed configuration options and examples.

## Advanced Features
Step-by-step tutorials for complex use cases.

---

# Developer Guide (Level 3 - Expert)

In-depth technical documentation for contributors and advanced users.

## Architecture Overview
System design and component interactions.

## API Reference
Complete technical reference with all parameters.

## Contributing
Development setup and contribution guidelines.
```
**Expected Outcomes**: Users can find information at their appropriate level without being overwhelmed

### Pattern 2: Living API Documentation
**Scenario**: Keeping API documentation synchronized with code changes
**Implementation**:
```typescript
// API route with embedded documentation
/**
 * @swagger
 * /api/users/{id}:
 *   get:
 *     summary: Get user by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *           format: uuid
 *     responses:
 *       200:
 *         description: User found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       404:
 *         description: User not found
 */
app.get('/api/users/:id', async (req: Request, res: Response) => {
    const { id } = req.params;
    
    if (!isValidUUID(id)) {
        return res.status(400).json({ error: 'Invalid user ID format' });
    }
    
    const user = await userService.findById(id);
    if (!user) {
        return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(user);
});

// Automated tests ensure documentation accuracy
describe('GET /api/users/:id', () => {
    it('should return user when valid ID provided', async () => {
        const user = await createTestUser();
        const response = await request(app)
            .get(`/api/users/${user.id}`)
            .expect(200);
            
        expect(response.body).toMatchObject({
            id: user.id,
            email: user.email,
            firstName: user.firstName,
            lastName: user.lastName
        });
    });
    
    it('should return 404 when user not found', async () => {
        const nonExistentId = 'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee';
        await request(app)
            .get(`/api/users/${nonExistentId}`)
            .expect(404);
    });
});
```
**Expected Outcomes**: API documentation stays accurate and current with automated validation

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Documentation Debt
- **Description**: Postponing documentation updates until they become overwhelming
- **Why It's Problematic**: Leads to inaccurate, outdated documentation that users can't trust
- **Better Approach**: Include documentation updates in definition of done for all features

#### Anti-Pattern 2: Over-Documentation
- **Description**: Documenting every trivial detail without considering user needs
- **Why It's Problematic**: Creates noise that obscures important information
- **Better Approach**: Focus on user scenarios and frequently asked questions

## Tools and Resources

### Essential Tools
#### Documentation Platforms
- **GitBook**: User-friendly documentation platform with great collaboration features
- **Notion**: Flexible workspace for internal documentation and knowledge management
- **MkDocs**: Static site generator for technical documentation from Markdown
- **Docusaurus**: Modern documentation website generator with React

#### API Documentation Tools
- **Swagger/OpenAPI**: Industry standard for REST API documentation
- **Redoc**: Beautiful API documentation from OpenAPI specifications
- **Postman**: API development and documentation platform
- **Insomnia**: REST client with documentation generation capabilities

#### Diagramming and Visual Tools
```mermaid
# Example system architecture diagram
graph TB
    A[Client App] -->|HTTPS| B[Load Balancer]
    B --> C[Web Server 1]
    B --> D[Web Server 2]
    C --> E[Database]
    D --> E[Database]
    E --> F[Backup Storage]
    
    subgraph "Security Zone"
        C
        D
        E
    end
    
    subgraph "Public Zone"
        A
        B
    end
```

### Templates and Checklists
#### Documentation Review Checklist
- [ ] **Accuracy**: Information is correct and up-to-date
- [ ] **Completeness**: All necessary information is included
- [ ] **Clarity**: Language is clear and jargon-free
- [ ] **Structure**: Information is well-organized and easy to navigate
- [ ] **Examples**: Practical examples and code samples are provided
- [ ] **Accessibility**: Content is accessible to target audience
- [ ] **Maintainability**: Documentation can be easily updated
- [ ] **Discoverability**: Users can easily find the information
- [ ] **Testing**: Code examples work as documented
- [ ] **Visual Design**: Formatting and visual elements enhance readability

### Learning Resources
- **Write the Docs**: Community and resources for technical writers
- **Google Developer Documentation Style Guide**: Comprehensive style guide
- **Microsoft Writing Style Guide**: Modern approach to technical writing
- **Divio Documentation System**: Framework for organizing technical documentation

## Quality and Compliance

### Quality Standards
- Documentation accuracy verified through automated testing
- Regular review cycles for content freshness (quarterly for critical docs)
- User feedback integration with satisfaction scores >4/5
- Accessibility compliance (WCAG 2.1 AA) for all public documentation

### Compliance Requirements
#### Internal Documentation Standards
- **Requirements**: Consistent formatting, style, and information architecture
- **Implementation**: Style guide enforcement through linting and review processes
- **Verification**: Regular audits and user feedback collection

#### External Documentation Requirements
- **Requirements**: Legal disclaimers, privacy policies, accessibility statements
- **Implementation**: Template-based approach with legal review
- **Verification**: Legal team approval for public-facing documentation

### Audit and Review Processes
- Monthly review of most-accessed documentation pages
- Quarterly comprehensive review of API documentation
- Annual documentation strategy and tooling evaluation
- Continuous user feedback collection and analysis

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Documentation Becomes Outdated Quickly
**Symptoms**: Users report inaccurate information, support tickets about outdated processes
**Root Causes**: No process for updating docs, documentation not integrated with development workflow
**Solutions**:
1. Include documentation updates in definition of done
2. Implement automated checks for documentation freshness
3. Set up notifications for related code changes
4. Regular review cycles with content owners
**Prevention**: Docs-as-code approach with CI/CD integration

#### Issue 2: Users Can't Find Information
**Symptoms**: Repeated questions in support, low documentation page views
**Root Causes**: Poor information architecture, missing search functionality, unclear navigation
**Solutions**:
1. Conduct user research and card sorting exercises
2. Implement site search with analytics
3. Create clear navigation hierarchies
4. Add cross-references and related links
**Prevention**: Regular user testing and navigation analysis

### Escalation Procedures
- Content accuracy issues: Escalate to subject matter expert
- Technical issues with documentation platform: IT/DevOps team
- Legal or compliance concerns: Legal team review
- User experience problems: UX team consultation

### Continuous Improvement
- Regular user surveys and feedback collection
- Analytics tracking for popular content and search terms
- A/B testing for different documentation approaches
- Documentation metrics dashboard with key performance indicators

## AI Assistant Guidelines

When helping with Documentation:

1. **User-Focused**: Always consider the target audience and their specific needs
2. **Clarity First**: Prioritize clear, simple language over comprehensive coverage
3. **Examples Heavy**: Include practical, working examples for all concepts
4. **Structure Matters**: Organize information logically with clear headings and navigation
5. **Maintainability**: Design documentation that can be easily updated and maintained
6. **Accessibility**: Ensure documentation is accessible to users with diverse abilities
7. **Integration**: Connect documentation with development workflows and tools
8. **Feedback Loops**: Include mechanisms for user feedback and continuous improvement

### Decision Making Framework
When helping teams improve documentation:

1. **Audience Analysis**: Understand who will use the documentation and how
2. **Content Audit**: Assess current documentation quality and gaps
3. **Tool Evaluation**: Choose appropriate tools for authoring and publishing
4. **Workflow Integration**: Integrate documentation into development processes
5. **Success Metrics**: Define measurable goals for documentation effectiveness
6. **Continuous Iteration**: Plan for regular updates and improvements

### Code Generation Rules
- Generate clear, well-commented code examples
- Include error handling and edge cases in examples
- Provide examples in multiple relevant programming languages when appropriate
- Ensure all code examples are tested and working
- Include setup instructions and prerequisites
- Add explanatory comments for complex logic

### Quality Enforcement
-  Enforce clear, concise writing style
-  Require practical examples for all documented features
-  Block documentation that lacks proper structure and navigation
-  Promote docs-as-code practices with version control
-  Require documentation updates for all feature changes
-  Enforce accessibility standards for all documentation
-  Block outdated information through automated checks
-  Promote user-centered design in all documentation