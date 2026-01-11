---
name: 'Php.Instructions'
description: 'Development guidelines and best practices for Php.Instructions'
keywords: [audit, api, avoid, benchmarking, adaptation, assistant, architecture, authentication, backend, advanced]
---



`
---
applyTo: "**/*.php,**/*.phtml"
---

# PHP Programming Instructions

## Core Principles

### Fundamental Concepts
1. **API-First Architecture**: Strict separation between backend logic and frontend presentation
2. **Modern PHP Standards**: Use PHP 8.0+ features with strict typing and performance optimization
3. **Security-First Development**: Input validation, prepared statements, and comprehensive sanitization
4. **Performance Optimization**: Efficient coding patterns and caching strategies

### Key Benefits
- Rapid development with extensive ecosystem and frameworks
- Strong type system with PHP 8+ features for better code reliability
- Excellent performance with modern optimization techniques
- Comprehensive security features and well-established best practices

### Common Misconceptions
- **Myth**: PHP is inherently insecure and slow
  **Reality**: Modern PHP 8+ with proper practices is secure and performant
- **Myth**: PHP lacks strong typing capabilities
  **Reality**: PHP 8+ provides robust type system with union types, enums, and strict typing
- **Myth**: PHP is only for small projects
  **Reality**: PHP powers large-scale applications like Facebook, Wikipedia, and WordPress

## Implementation Framework

### Getting Started
#### Prerequisites
- PHP 8.0+ (8.2+ recommended for latest features)
- Composer for dependency management
- Web server (Apache/Nginx) or PHP built-in server for development
- Database server (MySQL/PostgreSQL recommended)

#### Initial Setup
1. **Environment Setup**: Configure PHP with proper extensions and settings
2. **Project Structure**: Organize code with PSR-4 autoloading and clear separation of concerns
3. **Dependency Management**: Use Composer for all third-party libraries
4. **Configuration Management**: Environment-based configuration with proper secret handling

### Core Methodologies
#### Strict Type Declaration
- **Purpose**: Enforce type safety and improve code reliability
- **When to Use**: All PHP files should use strict types
- **Implementation Steps**:
  1. Add strict_types declaration at the top of all PHP files
  2. Use type hints for all function parameters and return values
  3. Leverage union types and nullable types for flexible APIs
- **Success Metrics**: Zero type-related runtime errors

#### API-First Development
- **Purpose**: Create maintainable backend services with clear frontend separation
- **When to Use**: All web applications and services
- **Implementation Steps**:
  1. Design REST API endpoints with clear resource structure
  2. Return JSON responses from all API endpoints
  3. Separate business logic from presentation logic
  4. Implement proper HTTP status codes and error handling
- **Success Metrics**: Clean API documentation and frontend/backend independence

### Process Integration
#### Development Workflow Integration
See [example-1](./examples/php/example-1.bash)

#### Quality Assurance Integration
See [example-2](./examples/php/example-2.bash)

#### Documentation Requirements
- PHPDoc comments for all public methods and classes
- API documentation using OpenAPI/Swagger specifications
- README files with setup and usage instructions
- Architecture decision records for significant design choices

## Best Practices

### Modern PHP Syntax and Features
See [example-3](./examples/php/example-3.php)

### Database Integration with Security
See [example-4](./examples/php/example-4.php)

### API Controller Best Practices
See [example-5](./examples/php/example-5.php)

## Common Patterns and Examples

### Pattern 1: Repository Pattern with Caching
**Scenario**: Implement data access layer with caching for improved performance
**Implementation**:
See [example-6](./examples/php/example-6.php)
**Expected Outcomes**: Improved performance with automatic cache invalidation

### Pattern 2: Event-Driven Architecture
**Scenario**: Implement domain events for loose coupling and extensibility
**Implementation**:
See [example-7](./examples/php/example-7.php)
**Expected Outcomes**: Decoupled architecture with easy extensibility

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Direct Database Access in Controllers
- **Description**: Executing SQL queries directly in controller methods
- **Why It's Problematic**: Violates separation of concerns and makes testing difficult
- **Better Approach**: Use repository pattern with proper abstraction layers

#### Anti-Pattern 2: String Concatenation in Loops
- **Description**: Building strings using concatenation operators in loops
- **Why It's Problematic**: Poor performance due to string immutability
- **Better Approach**: Use array collection and implode() for string building

## Tools and Resources

### Essential Tools
#### Development Environment
- **PHP**: Version 8.0+ with OPcache enabled for production
- **Composer**: Dependency management and autoloading
- **Xdebug**: Debugging and profiling for development
- **PHPStan**: Static analysis for type checking and error detection

#### Framework Ecosystem
- **Laravel**: Full-featured framework with elegant syntax and comprehensive ecosystem
- **Symfony**: Component-based framework for enterprise applications
- **API Platform**: API-first framework built on Symfony
- **Laminas**: Enterprise-ready components and framework

#### Testing and Quality
See [example-8](./examples/php/example-8.php)

### Templates and Checklists
#### PHP Project Checklist
- [ ] **Security**: Input validation, prepared statements, HTTPS enforcement
- [ ] **Performance**: OPcache enabled, database indexing, caching strategy
- [ ] **Code Quality**: Strict types, PHPStan analysis, PSR-12 formatting
- [ ] **Testing**: Unit tests, integration tests, code coverage >80%
- [ ] **Documentation**: PHPDoc comments, API documentation, README
- [ ] **Deployment**: Environment configuration, error logging, monitoring

### Learning Resources
- **PHP Manual**: https://www.php.net/manual/
- **PHP Standards**: https://www.php-fig.org/
- **Laravel Documentation**: https://laravel.com/docs
- **Symfony Documentation**: https://symfony.com/doc
- **PHPUnit Documentation**: https://phpunit.de/documentation.html

## Quality and Compliance

### Quality Standards
- Code coverage of 80%+ for critical business logic
- PHPStan level 8 analysis with zero errors
- PSR-12 coding standard compliance
- Response time <200ms for API endpoints under normal load

### Compliance Requirements
#### Security Standards
- **Requirements**: Input validation, SQL injection prevention, XSS protection
- **Implementation**: Prepared statements, CSRF tokens, content security policy
- **Verification**: Security testing and penetration testing

#### Performance Standards
- **Requirements**: Page load times <2 seconds, API response times <500ms
- **Implementation**: Caching strategies, database optimization, code profiling
- **Verification**: Performance testing and monitoring

### Audit and Review Processes
- Weekly code reviews with security and performance focus
- Monthly dependency updates and security audits
- Quarterly architecture reviews and performance analysis
- Annual comprehensive security assessment

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Memory Exhaustion in Large Data Processing
**Symptoms**: Fatal error: Allowed memory size exhausted
**Root Causes**: Loading large datasets into memory, memory leaks in loops
**Solutions**:
1. Use generators for large dataset processing
2. Implement batch processing with proper memory management
3. Use database cursors for streaming large result sets
4. Profile memory usage with Xdebug or Blackfire
**Prevention**: Regular memory profiling and generator-based data processing

#### Issue 2: SQL Injection Vulnerabilities
**Symptoms**: Unexpected database behavior, security scan alerts
**Root Causes**: String concatenation in SQL queries, improper input sanitization
**Solutions**:
1. Use prepared statements exclusively for database queries
2. Implement comprehensive input validation
3. Use parameterized queries with type checking
4. Regular security audits and penetration testing
**Prevention**: Enforce prepared statement usage through code analysis tools

### Escalation Procedures
- **Performance Issues**: Database team → Infrastructure team → Architecture review
- **Security Issues**: Security team → Legal compliance → External audit
- **Critical Bugs**: Lead developer → Product team → Customer communication

### Continuous Improvement
- Regular performance profiling and optimization
- Security training and awareness programs
- Code review process improvements
- Tool and framework evaluation and updates

## Metrics and KPIs

### Success Metrics
- **Code Quality**: PHPStan level 8 compliance, PSR-12 formatting
- **Performance**: API response times <200ms, page load times <2s
- **Security**: Zero critical vulnerabilities, regular security audits
- **Maintainability**: Code coverage >80%, documentation coverage >90%

### Monitoring and Reporting
- Real-time application performance monitoring
- Weekly security scan reports
- Monthly code quality metrics dashboard
- Quarterly architecture and performance reviews

### Benchmarking
- Industry standard performance benchmarks
- Security compliance framework alignment
- Framework and library update tracking
- Competitive performance analysis

## Integration with Other Practices

### Related Disciplines
#### Frontend Development
- **Integration Points**: API design, authentication, data formatting
- **Shared Responsibilities**: Security, performance, user experience
- **Coordination Mechanisms**: API documentation, shared data models

#### DevOps and Infrastructure
- **Integration Points**: Deployment automation, monitoring, scaling
- **Shared Responsibilities**: Performance optimization, security configuration
- **Coordination Mechanisms**: Infrastructure as code, monitoring dashboards

### Technology Integration
- CI/CD pipeline integration with automated testing
- Database migration and schema management
- Caching layer configuration and management
- Monitoring and alerting system integration

## Advanced Topics

### Scaling Considerations
- Horizontal scaling with load balancers and multiple application servers
- Database sharding and read replica strategies
- Caching layers with Redis or Memcached
- Microservices architecture for large applications

### Customization and Adaptation
- Framework selection based on project requirements
- Custom middleware and service provider development
- Domain-specific language and business rule implementation
- Integration with legacy systems and third-party services

### Innovation and Evolution
- Adoption of new PHP features and language improvements
- Framework and library evaluation and migration strategies
- Performance optimization and cutting-edge caching techniques
- Modern development patterns and architectural approaches

## AI Assistant Guidelines

When helping with PHP Development:

1. **Assessment First**: Always assess current PHP version and project requirements before recommending solutions
2. **Security Priority**: Prioritize security best practices in all code recommendations
3. **Modern Standards**: Use PHP 8+ features and modern frameworks when appropriate
4. **Performance Focus**: Include performance considerations in all architectural decisions
5. **Type Safety**: Enforce strict typing and proper type declarations
6. **Framework Integration**: Recommend appropriate frameworks based on project scale and requirements
7. **Testing Strategy**: Include testing approaches and examples in all recommendations
8. **Documentation**: Ensure comprehensive documentation for all generated code

### Decision Making Framework
When helping teams choose PHP approaches:

1. **Requirements Analysis**: Understand performance, security, and scalability needs
2. **Framework Selection**: Evaluate Laravel, Symfony, or custom solutions based on requirements
3. **Architecture Design**: Recommend appropriate patterns (MVC, Repository, Service Layer)
4. **Security Assessment**: Identify potential security risks and mitigation strategies
5. **Performance Planning**: Design for expected load and growth patterns
6. **Integration Strategy**: Plan for frontend, database, and third-party service integration

### Code Generation Rules
- Generate code using PHP 8+ features and strict typing
- Include comprehensive error handling and validation

*Content optimized for conciseness. See external references for additional details.*

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
