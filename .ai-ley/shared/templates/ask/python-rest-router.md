# Python REST Router Project - ASK Template

## Project Overview

**API Service Name**: [Your Python REST API Name]
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

### Python Framework & Environment

- [ ] **Web Framework**: [FastAPI, Django REST, Flask, Tornado, Sanic]
- [ ] **Python Version**: [Python 3.x requirements and features]
- [ ] **Package Management**: [pip, poetry, pipenv preferences]
- [ ] **Virtual Environment**: [venv, conda, docker environment]

### Async vs Sync

- [ ] **Asynchronous Support**: [async/await, asyncio patterns]
- [ ] **ASGI vs WSGI**: [Framework deployment considerations]
- [ ] **Concurrency Model**: [Threading, multiprocessing, async]
- [ ] **Performance Requirements**: [High concurrency needs]

### Database Integration

- [ ] **Database Type**: [PostgreSQL, MySQL, MongoDB, SQLite]
- [ ] **ORM/Database**: [SQLAlchemy, Django ORM, Tortoise ORM, Motor]
- [ ] **Connection Management**: [Connection pooling, async connections]
- [ ] **Migration Strategy**: [Alembic, Django migrations]

## Request/Response Handling

### Input Processing

- [ ] **Request Validation**: [Pydantic, Marshmallow, Cerberus]
- [ ] **Input Sanitization**: [XSS prevention, data cleaning]
- [ ] **File Uploads**: [Multipart handling, file validation]
- [ ] **Query Parameters**: [Filtering, sorting, pagination]

### Response Format

- [ ] **JSON Structure**: [Consistent response format]
- [ ] **Error Responses**: [Standardized error format]
- [ ] **Response Models**: [Pydantic models, serializers]
- [ ] **Data Transformation**: [DTO patterns, field mapping]

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
- [ ] **Session-based**: [Cookie-based session management]

### Authorization Patterns

- [ ] **Role-based Access**: [User roles and permissions]
- [ ] **Resource-based**: [Resource-level access control]
- [ ] **Attribute-based**: [Dynamic permission evaluation]
- [ ] **Multi-tenant**: [Tenant isolation and access]

### Security Features

- [ ] **Rate Limiting**: [Request throttling, slowapi, limits]
- [ ] **Input Validation**: [SQL injection, XSS prevention]
- [ ] **HTTPS Enforcement**: [TLS/SSL requirements]
- [ ] **Security Headers**: [HSTS, CSP, X-Frame-Options]

## Performance & Scalability

### Performance Requirements

- [ ] **Response Time**: [Target response time SLAs]
- [ ] **Throughput**: [Requests per second capacity]
- [ ] **Concurrent Users**: [Simultaneous user support]
- [ ] **Memory Usage**: [Python memory optimization]

### Caching Strategy

- [ ] **Redis Integration**: [Application caching]
- [ ] **Memcached**: [Distributed caching]
- [ ] **Database Caching**: [Query result caching]
- [ ] **HTTP Caching**: [Response caching, CDN integration]

### Scalability Patterns

- [ ] **Horizontal Scaling**: [Load balancer configuration]
- [ ] **Microservices**: [Service decomposition strategy]
- [ ] **Database Scaling**: [Read replicas, sharding]
- [ ] **Stateless Design**: [Session externalization]

## Error Handling & Monitoring

### Error Management

- [ ] **Exception Handling**: [Global exception handlers]
- [ ] **Error Responses**: [HTTPException, custom exceptions]
- [ ] **Logging Strategy**: [Python logging, structured logs]
- [ ] **Error Recovery**: [Graceful degradation, fallbacks]

### Monitoring & Observability

- [ ] **Application Metrics**: [Prometheus, StatsD integration]
- [ ] **Performance Monitoring**: [APM tools, profiling]
- [ ] **Health Checks**: [Health endpoints, dependency checks]
- [ ] **Distributed Tracing**: [OpenTelemetry, Jaeger]

### Logging & Auditing

- [ ] **Structured Logging**: [JSON logging format]
- [ ] **Log Levels**: [Debug, info, warn, error levels]
- [ ] **Audit Trails**: [User action logging]
- [ ] **Log Aggregation**: [ELK stack, centralized logging]

## API Documentation & Testing

### Documentation Strategy

- [ ] **OpenAPI/Swagger**: [Automatic API documentation]
- [ ] **Interactive Docs**: [Swagger UI, ReDoc]
- [ ] **Code Examples**: [Python client examples, curl commands]
- [ ] **Changelog**: [API version history]

### Testing Approach

- [ ] **Unit Testing**: [pytest, unittest, business logic]
- [ ] **Integration Testing**: [Database, external services]
- [ ] **API Testing**: [FastAPI TestClient, requests testing]
- [ ] **Load Testing**: [locust, pytest-benchmark]

### Development Tools

- [ ] **API Client**: [httpx, requests, aiohttp]
- [ ] **Testing Frameworks**: [pytest, pytest-asyncio, factory_boy]
- [ ] **Code Quality**: [black, flake8, mypy, pre-commit]
- [ ] **Documentation**: [Sphinx, mkdocs]

## Deployment & DevOps

### ASGI/WSGI Deployment

- [ ] **Application Server**: [uvicorn, gunicorn, hypercorn]
- [ ] **Reverse Proxy**: [nginx, traefik]
- [ ] **Process Management**: [supervisor, systemd]
- [ ] **Container Deployment**: [Docker, Kubernetes]

### Python Environment

- [ ] **Dependency Management**: [requirements.txt, poetry, pipenv]
- [ ] **Virtual Environment**: [venv, conda, docker]
- [ ] **Environment Variables**: [python-dotenv, os.environ]
- [ ] **Configuration**: [Pydantic Settings, configparser]

### Deployment Strategy

- [ ] **Cloud Deployment**: [AWS, GCP, Azure services]
- [ ] **Serverless**: [AWS Lambda, Google Cloud Functions]
- [ ] **Container Orchestration**: [Kubernetes, Docker Swarm]
- [ ] **Platform as a Service**: [Heroku, Railway, Vercel]

### CI/CD Pipeline

- [ ] **Build Process**: [pip install, poetry install]
- [ ] **Testing Pipeline**: [pytest, coverage, quality checks]
- [ ] **Deployment Automation**: [GitHub Actions, GitLab CI]
- [ ] **Rollback Strategy**: [Version rollback procedures]

## Data Management

### Data Validation

- [ ] **Input Validation**: [Pydantic models, schema validation]
- [ ] **Business Validation**: [Domain rule validation]
- [ ] **Database Constraints**: [Foreign keys, unique constraints]
- [ ] **Serialization**: [Pydantic, Marshmallow serializers]

### Database Design

- [ ] **Schema Design**: [Entity relationships, indexing]
- [ ] **Query Optimization**: [Query performance tuning]
- [ ] **Connection Management**: [SQLAlchemy engine, async pools]
- [ ] **Migration Strategy**: [Alembic migrations, versioning]

### ORM & Data Access

- [ ] **ORM Usage**: [SQLAlchemy, Django ORM patterns]
- [ ] **Query Builder**: [SQLAlchemy Core, raw SQL]
- [ ] **Async Database**: [asyncpg, aiomysql, motor]
- [ ] **Transaction Management**: [Database transactions, rollbacks]

## Integration & External Services

### Third-party Integrations

- [ ] **HTTP Clients**: [httpx, aiohttp, requests]
- [ ] **Payment Processing**: [Stripe, PayPal integration]
- [ ] **Email Services**: [SendGrid, SMTP integration]
- [ ] **File Storage**: [AWS S3, Google Cloud Storage]

### Python Libraries & Packages

- [ ] **Data Processing**: [pandas, numpy for analytics]
- [ ] **ML Integration**: [scikit-learn, TensorFlow, PyTorch]
- [ ] **Image Processing**: [Pillow, OpenCV]
- [ ] **Validation**: [Pydantic, Cerberus, Marshmallow]

### Service Communication

- [ ] **Message Queues**: [Celery, RQ, asyncio queues]
- [ ] **Event Systems**: [Event-driven architecture]
- [ ] **WebSocket Support**: [FastAPI WebSockets, Socket.IO]
- [ ] **gRPC Integration**: [grpcio, async gRPC]

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

- [ ] **Test Coverage**: [pytest-cov coverage percentage]
- [ ] **Code Complexity**: [Complexity analysis]
- [ ] **Type Coverage**: [mypy type checking coverage]
- [ ] **Security Scores**: [bandit security analysis]

## Constraints & Limitations

### Python Environment Constraints

- [ ] **Python Version**: [Version compatibility requirements]
- [ ] **GIL Limitations**: [Global Interpreter Lock constraints]
- [ ] **Memory Usage**: [Python memory overhead]
- [ ] **Package Dependencies**: [Dependency conflicts, versions]

### Performance Constraints

- [ ] **CPU Intensive Tasks**: [Processing limitations]
- [ ] **I/O Bound Operations**: [Network, database bottlenecks]
- [ ] **Concurrency Limits**: [Thread, process limitations]
- [ ] **Memory Constraints**: [Large data processing limits]

### Business Constraints

- [ ] **Budget Limitations**: [Infrastructure and development costs]
- [ ] **Timeline Constraints**: [Project delivery deadlines]
- [ ] **Compliance Requirements**: [Regulatory compliance needs]
- [ ] **Legacy System Integration**: [Existing system constraints]

## Machine Learning & AI Integration

### ML/AI Features

- [ ] **Model Serving**: [TensorFlow Serving, MLflow]
- [ ] **Prediction APIs**: [Real-time inference endpoints]
- [ ] **Model Management**: [Model versioning, A/B testing]
- [ ] **Data Pipelines**: [Feature engineering, preprocessing]

### ML Libraries

- [ ] **Core Libraries**: [scikit-learn, pandas, numpy]
- [ ] **Deep Learning**: [TensorFlow, PyTorch, Keras]
- [ ] **NLP**: [spaCy, NLTK, transformers]
- [ ] **Computer Vision**: [OpenCV, Pillow, scikit-image]

### ML Operations

- [ ] **Model Training**: [Training pipeline integration]
- [ ] **Model Deployment**: [Containerized model serving]
- [ ] **Model Monitoring**: [Performance drift detection]
- [ ] **Data Validation**: [Schema validation, data quality]

## Future Enhancements

### API Evolution

- [ ] **Versioning Strategy**: [API version management]
- [ ] **Backward Compatibility**: [Legacy client support]
- [ ] **New Endpoints**: [Future API expansion]
- [ ] **Performance Improvements**: [Optimization opportunities]

### Technology Upgrades

- [ ] **Python Upgrades**: [Python version migrations]
- [ ] **Framework Updates**: [Framework version upgrades]
- [ ] **Database Upgrades**: [Database version updates]
- [ ] **Security Updates**: [Dependency vulnerability fixes]

### Feature Expansion

- [ ] **GraphQL Support**: [Strawberry, Ariadne integration]
- [ ] **Real-time Features**: [WebSocket, SSE support]
- [ ] **ML Integration**: [Advanced AI/ML features]
- [ ] **Microservices**: [Service decomposition strategy]

## Questions & Clarifications

### Technical Questions

1. [Questions about Python framework selection and architecture]
2. [Questions about async vs sync design decisions]
3. [Questions about database design and ORM choice]

### Business Questions

1. [Questions about API usage patterns and requirements]
2. [Questions about SLA and performance expectations]
3. [Questions about ML/AI integration needs]

### Infrastructure Questions

1. [Questions about deployment and scaling requirements]
2. [Questions about monitoring and observability needs]
3. [Questions about security and compliance requirements]

## Notes & Ideas

### Architecture Ideas

- [Microservices vs monolithic considerations]
- [Event-driven architecture patterns]
- [ML/AI pipeline integration strategies]

### Performance Ideas

- [Async programming optimization strategies]
- [Database query optimization approaches]
- [Caching layer implementation patterns]

### Python-Specific Considerations

- [FastAPI vs Django REST Framework trade-offs]
- [Async/await vs traditional synchronous patterns]
- [ML model serving and inference optimization]

---

**Template Version**: 1.0  
**Last Updated**: [Date]  
**Next Review**: [Schedule regular ASK review]
