# PHP REST Router Project - ASK Template

## Project Overview

**API Service Name**: [Your PHP REST API Name]
**Primary Purpose**: [What business functionality does this API provide?]
**Target Clients**: [Web applications, mobile apps, third-party integrations]
**Problem Statement**: [What business problem does this API solve?]

## API Requirements

### Core Endpoints

- [ ] **Resource Endpoints**: [Users, products, orders, etc.]
- [ ] **CRUD Operations**: [Create, Read, Update, Delete operations]
- [ ] **Search & Filtering**: [Query parameters, filtering options]
- [ ] **Pagination**: [Offset-based, cursor-based pagination]

### Business Logic

- [ ] **Domain Rules**: [Core business rules and validations]
- [ ] **Workflow Processes**: [Multi-step business processes]
- [ ] **Integration Logic**: [Third-party service integration]
- [ ] **Data Processing**: [Calculations, transformations, aggregations]

### API Design

- [ ] **RESTful Design**: [Resource-based URL structure]
- [ ] **HTTP Methods**: [GET, POST, PUT, PATCH, DELETE usage]
- [ ] **Status Codes**: [Appropriate HTTP status code usage]
- [ ] **Content Types**: [JSON, XML, multipart support]

## Technical Architecture

### PHP Framework & Environment

- [ ] **PHP Framework**: [Laravel, Symfony, Slim, CodeIgniter, CakePHP]
- [ ] **PHP Version**: [PHP 8.x requirements and features]
- [ ] **Composer Dependencies**: [Package management strategy]
- [ ] **Autoloading**: [PSR-4 autoloading standards]

### Routing & Middleware

- [ ] **Router Framework**: [Framework-specific routing]
- [ ] **Route Definition**: [Route file organization, naming]
- [ ] **Middleware Stack**: [Authentication, CORS, rate limiting]
- [ ] **Route Caching**: [Performance optimization]

### Database Integration

- [ ] **Database Type**: [MySQL, PostgreSQL, SQLite, MongoDB]
- [ ] **ORM/Database**: [Eloquent, Doctrine, PDO, Query Builder]
- [ ] **Connection Management**: [Connection pooling, retry logic]
- [ ] **Migration Strategy**: [Schema versioning, data migrations]

## Request/Response Handling

### Input Processing

- [ ] **Request Validation**: [Form validation, data types]
- [ ] **Input Sanitization**: [XSS prevention, data cleaning]
- [ ] **File Uploads**: [Multipart handling, file validation]
- [ ] **Query Parameters**: [Filtering, sorting, pagination]

### Response Format

- [ ] **JSON Structure**: [Consistent response format]
- [ ] **Error Responses**: [Standardized error format]
- [ ] **Response Headers**: [Content-Type, CORS headers]
- [ ] **Data Transformation**: [Resource transformation, serialization]

### Content Negotiation

- [ ] **Accept Headers**: [JSON, XML response format]
- [ ] **Compression**: [Gzip compression support]
- [ ] **CORS**: [Cross-origin resource sharing]
- [ ] **Caching**: [ETag, Last-Modified headers]

## Authentication & Authorization

### Authentication Methods

- [ ] **JWT Tokens**: [JSON Web Token implementation]
- [ ] **OAuth 2.0**: [OAuth provider integration]
- [ ] **API Keys**: [API key management and validation]
- [ ] **Session-based**: [PHP session management]

### Authorization Patterns

- [ ] **Role-based Access**: [User roles and permissions]
- [ ] **Resource-based**: [Resource-level access control]
- [ ] **Attribute-based**: [Dynamic permission evaluation]
- [ ] **Multi-tenant**: [Tenant isolation and access]

### Security Features

- [ ] **Rate Limiting**: [Request throttling, abuse prevention]
- [ ] **Input Validation**: [SQL injection, XSS prevention]
- [ ] **CSRF Protection**: [Cross-site request forgery prevention]
- [ ] **Security Headers**: [HSTS, CSP, X-Frame-Options]

## Performance & Scalability

### Performance Requirements

- [ ] **Response Time**: [Target response time SLAs]
- [ ] **Throughput**: [Requests per second capacity]
- [ ] **Concurrent Users**: [Simultaneous user support]
- [ ] **Memory Usage**: [PHP memory optimization]

### Caching Strategy

- [ ] **OPcache**: [PHP opcode caching]
- [ ] **Redis/Memcached**: [Application caching]
- [ ] **Database Caching**: [Query result caching]
- [ ] **HTTP Caching**: [Response caching, CDN integration]

### Scalability Patterns

- [ ] **Horizontal Scaling**: [Load balancer configuration]
- [ ] **Session Management**: [Shared session storage]
- [ ] **Database Scaling**: [Read replicas, connection pooling]
- [ ] **Stateless Design**: [Stateless API design]

## Error Handling & Monitoring

### Error Management

- [ ] **Exception Handling**: [Global exception handlers]
- [ ] **Error Responses**: [Consistent error format, HTTP codes]
- [ ] **Logging Strategy**: [Error logging, audit trails]
- [ ] **Debug Mode**: [Development vs production error handling]

### Monitoring & Observability

- [ ] **Application Metrics**: [Response time, error rate, throughput]
- [ ] **PHP Metrics**: [Memory usage, execution time]
- [ ] **Health Checks**: [Application health endpoints]
- [ ] **APM Integration**: [Application performance monitoring]

### Logging & Auditing

- [ ] **Log Management**: [Monolog, file-based logging]
- [ ] **Log Levels**: [Debug, info, warn, error levels]
- [ ] **Audit Trails**: [User action logging]
- [ ] **Log Rotation**: [Log file management]

## API Documentation & Testing

### Documentation Strategy

- [ ] **OpenAPI/Swagger**: [API specification format]
- [ ] **Interactive Docs**: [Swagger UI, API documentation]
- [ ] **Code Examples**: [PHP client examples, curl commands]
- [ ] **Changelog**: [API version history]

### Testing Approach

- [ ] **Unit Testing**: [PHPUnit, business logic testing]
- [ ] **Integration Testing**: [Database, external services]
- [ ] **API Testing**: [HTTP testing, contract testing]
- [ ] **Load Testing**: [Performance and stress testing]

### Development Tools

- [ ] **API Client**: [Postman, Insomnia collections]
- [ ] **PHP Development**: [Xdebug, PHP-CS-Fixer]
- [ ] **Testing Frameworks**: [PHPUnit, Behat, Codeception]
- [ ] **Code Quality**: [PHP_CodeSniffer, PHPStan, Psalm]

## Deployment & DevOps

### Web Server Configuration

- [ ] **Web Server**: [Apache, Nginx, PHP-FPM]
- [ ] **Virtual Hosts**: [Domain configuration]
- [ ] **SSL/TLS**: [HTTPS configuration]
- [ ] **URL Rewriting**: [Clean URL configuration]

### PHP Environment

- [ ] **PHP Configuration**: [php.ini optimization]
- [ ] **Process Management**: [PHP-FPM pool configuration]
- [ ] **Memory Management**: [Memory limits, garbage collection]
- [ ] **Extension Management**: [Required PHP extensions]

### Deployment Strategy

- [ ] **Environment Setup**: [Development, staging, production]
- [ ] **Container Deployment**: [Docker containerization]
- [ ] **Cloud Deployment**: [AWS, GCP, Azure services]
- [ ] **Shared Hosting**: [Traditional hosting compatibility]

### Environment Management

- [ ] **Environment Variables**: [Configuration management]
- [ ] **Secret Management**: [API keys, database credentials]
- [ ] **Configuration Files**: [Environment-specific configs]
- [ ] **Dependency Management**: [Composer autoload optimization]

## Data Management

### Data Validation

- [ ] **Input Validation**: [Form validation, data types]
- [ ] **Business Validation**: [Domain rule validation]
- [ ] **Database Constraints**: [Foreign keys, unique constraints]
- [ ] **Sanitization**: [Data cleaning, normalization]

### Database Design

- [ ] **Schema Design**: [Entity relationships, indexing]
- [ ] **Query Optimization**: [Query performance tuning]
- [ ] **Connection Management**: [PDO, connection pooling]
- [ ] **Migration Strategy**: [Database schema evolution]

### ORM & Data Access

- [ ] **ORM Usage**: [Eloquent, Doctrine ORM patterns]
- [ ] **Query Builder**: [Fluent query construction]
- [ ] **Raw Queries**: [Custom SQL optimization]
- [ ] **Transaction Management**: [Database transactions]

## Integration & External Services

### Third-party Integrations

- [ ] **Payment Processing**: [Stripe, PayPal integration]
- [ ] **Email Services**: [PHPMailer, SMTP integration]
- [ ] **File Storage**: [Local storage, cloud storage]
- [ ] **External APIs**: [cURL, Guzzle HTTP client]

### PHP Libraries & Packages

- [ ] **HTTP Clients**: [Guzzle, cURL wrapper]
- [ ] **Validation Libraries**: [Respect/Validation, custom]
- [ ] **Serialization**: [JSON, XML handling]
- [ ] **Image Processing**: [GD, ImageMagick integration]

### Service Communication

- [ ] **HTTP Requests**: [REST API client implementation]
- [ ] **Queue Systems**: [Laravel Queues, Beanstalkd]
- [ ] **Event Systems**: [Event dispatching, listeners]
- [ ] **Webhook Support**: [Webhook endpoint handling]

## Success Metrics

### Performance Metrics

- [ ] **Response Time**: [Average, p95, p99 response times]
- [ ] **Throughput**: [Requests per second]
- [ ] **Error Rate**: [Error percentage, availability]
- [ ] **Resource Utilization**: [CPU, memory, database usage]

### Business Metrics

- [ ] **API Adoption**: [Number of clients, endpoints used]
- [ ] **Feature Usage**: [Popular endpoints, feature adoption]
- [ ] **User Satisfaction**: [API rating, feedback scores]
- [ ] **Business Value**: [Revenue impact, cost savings]

### Code Quality Metrics

- [ ] **Code Coverage**: [Test coverage percentage]
- [ ] **Code Complexity**: [Cyclomatic complexity scores]
- [ ] **Technical Debt**: [Code quality metrics]
- [ ] **Security Scores**: [Security vulnerability assessments]

## Constraints & Limitations

### PHP Environment Constraints

- [ ] **PHP Version**: [Version compatibility requirements]
- [ ] **Memory Limits**: [PHP memory_limit constraints]
- [ ] **Execution Time**: [max_execution_time limits]
- [ ] **Extension Dependencies**: [Required PHP extensions]

### Web Server Constraints

- [ ] **Request Limits**: [Server request handling capacity]
- [ ] **File Upload Limits**: [upload_max_filesize constraints]
- [ ] **Connection Limits**: [Concurrent connection limits]
- [ ] **Resource Limits**: [CPU, memory, disk space]

### Business Constraints

- [ ] **Budget Limitations**: [Hosting and development costs]
- [ ] **Timeline Constraints**: [Project delivery deadlines]
- [ ] **Compliance Requirements**: [Regulatory compliance needs]
- [ ] **Legacy System Integration**: [Existing system constraints]

## Security Considerations

### PHP Security

- [ ] **Input Filtering**: [filter_var, custom validation]
- [ ] **SQL Injection**: [Prepared statements, parameterized queries]
- [ ] **XSS Prevention**: [Output escaping, CSP headers]
- [ ] **CSRF Protection**: [Token-based CSRF prevention]

### Application Security

- [ ] **Authentication Security**: [Password hashing, secure sessions]
- [ ] **Authorization**: [Access control, permission checking]
- [ ] **Data Encryption**: [Sensitive data encryption]
- [ ] **File Security**: [Upload validation, path traversal prevention]

### Infrastructure Security

- [ ] **HTTPS Enforcement**: [SSL/TLS configuration]
- [ ] **Security Headers**: [Security-related HTTP headers]
- [ ] **Server Hardening**: [Web server security configuration]
- [ ] **Dependency Security**: [Composer security updates]

## Future Enhancements

### API Evolution

- [ ] **Versioning Strategy**: [API version management]
- [ ] **Backward Compatibility**: [Legacy client support]
- [ ] **New Endpoints**: [Future API expansion]
- [ ] **Performance Improvements**: [Optimization opportunities]

### Technology Upgrades

- [ ] **PHP Upgrades**: [PHP version migrations]
- [ ] **Framework Updates**: [Framework version upgrades]
- [ ] **Database Upgrades**: [Database version updates]
- [ ] **Security Updates**: [Dependency vulnerability fixes]

### Feature Expansion

- [ ] **GraphQL Support**: [GraphQL endpoint addition]
- [ ] **Real-time Features**: [WebSocket, SSE support]
- [ ] **Mobile Optimization**: [Mobile-specific endpoints]
- [ ] **Microservices**: [Service decomposition strategy]

## Questions & Clarifications

### Technical Questions

1. [Questions about PHP framework selection and architecture]
2. [Questions about database design and ORM choice]
3. [Questions about security and authentication requirements]

### Business Questions

1. [Questions about API usage patterns and requirements]
2. [Questions about SLA and performance expectations]
3. [Questions about integration and client needs]

### Infrastructure Questions

1. [Questions about hosting and deployment requirements]
2. [Questions about web server and PHP configuration]
3. [Questions about monitoring and maintenance needs]

## Notes & Ideas

### Architecture Ideas

- [Microservices vs monolithic considerations]
- [API gateway integration strategies]
- [Event-driven architecture patterns]

### Performance Ideas

- [OPcache optimization strategies]
- [Database query optimization approaches]
- [Caching layer implementation patterns]

### Security Considerations

- [OAuth 2.0 vs session-based authentication]
- [Rate limiting and abuse prevention strategies]
- [Input validation and sanitization best practices]

---

**Template Version**: 1.0  
**Last Updated**: [Date]  
**Next Review**: [Schedule regular ASK review]
