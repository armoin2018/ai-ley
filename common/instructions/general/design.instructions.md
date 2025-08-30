# Software Design Instructions

## Overview
- **Domain**: Software Architecture and Design Methodology
- **Purpose**: Guide AI agents in creating scalable, maintainable, and robust software designs
- **Applicable To**: All software development projects requiring architectural design and system planning
- **Integration Level**: Core methodology affecting all development phases from conception to deployment

## Core Principles

### Fundamental Concepts
1. **Design for Change**: Create flexible architectures that can evolve with changing requirements
2. **Separation of Concerns**: Organize code into distinct sections handling different aspects of functionality
3. **Principle of Least Knowledge**: Components should know only what they need to accomplish their responsibilities
4. **Composition over Inheritance**: Favor object composition over class inheritance for flexibility

### Key Benefits
- Improved maintainability through clear separation of responsibilities
- Enhanced scalability with modular and loosely coupled components
- Reduced complexity through well-defined interfaces and abstractions
- Faster development cycles with reusable and testable components
- Better collaboration through shared design patterns and conventions

### Common Misconceptions
- **Myth**: Good design means complex architecture with many patterns
  **Reality**: Good design is often simple, focused, and uses patterns judiciously
- **Myth**: Design decisions are permanent and cannot be changed
  **Reality**: Good design enables evolution and refactoring as requirements change
- **Myth**: Design is only needed for large, complex systems
  **Reality**: Design principles apply to all software, from simple scripts to enterprise systems

## Implementation Framework

### Getting Started
#### Prerequisites
- Understanding of software design patterns and architectural principles
- Knowledge of relevant programming languages and frameworks
- Familiarity with the problem domain and business requirements
- Access to stakeholders for requirements clarification and validation

#### Initial Setup
1. **Requirements Analysis**: Understand functional and non-functional requirements
2. **Technology Selection**: Choose appropriate languages, frameworks, and tools
3. **Architecture Planning**: Define high-level system structure and components
4. **Design Documentation**: Create comprehensive design documentation and diagrams

### Core Methodologies
#### Domain-Driven Design (DDD)
- **Purpose**: Align software design with business domain and requirements
- **When to Use**: Complex business domains with rich business logic and rules
- **Implementation Steps**:
  1. Collaborate with domain experts to understand business requirements
  2. Identify bounded contexts and define domain models
  3. Create ubiquitous language shared between developers and domain experts
  4. Design aggregates, entities, and value objects based on business rules
- **Success Metrics**: Clear alignment between code structure and business concepts

#### SOLID Principles Application
- **Purpose**: Create maintainable and extensible object-oriented designs
- **When to Use**: Object-oriented programming projects requiring flexibility
- **Implementation Steps**:
  1. **Single Responsibility**: Ensure each class has one reason to change
  2. **Open/Closed**: Design classes open for extension, closed for modification
  3. **Liskov Substitution**: Derived classes must be substitutable for base classes
  4. **Interface Segregation**: Create focused interfaces rather than large, general ones
  5. **Dependency Inversion**: Depend on abstractions, not concrete implementations
- **Success Metrics**: Low coupling, high cohesion, and easy testability

### Process Integration
#### Design Review Workflow
```markdown
# Design Review Checklist

## Architecture Review
- [ ] **Scalability**: Design can handle expected load and growth
- [ ] **Performance**: Architecture supports performance requirements
- [ ] **Security**: Security considerations integrated into design
- [ ] **Maintainability**: Code structure supports easy maintenance and evolution

## Component Design
- [ ] **Single Responsibility**: Each component has clear, focused purpose
- [ ] **Interface Design**: Well-defined contracts between components
- [ ] **Error Handling**: Comprehensive error handling and recovery strategies
- [ ] **Testing Strategy**: Components designed for comprehensive testing

## Implementation Planning
- [ ] **Development Phases**: Clear implementation roadmap with milestones
- [ ] **Risk Assessment**: Potential risks identified with mitigation strategies
- [ ] **Dependencies**: External dependencies and integration points defined
- [ ] **Deployment Strategy**: Deployment and rollback procedures planned
```

#### Documentation Requirements
- System architecture diagrams showing component relationships
- API specifications and interface contracts
- Data model documentation with relationships and constraints
- Deployment architecture and infrastructure requirements
- Security design and threat model documentation

## Best Practices

### Architectural Patterns
#### Layered Architecture Implementation
```typescript
// Example layered architecture structure
// Presentation Layer
export class UserController {
  constructor(private userService: UserService) {}
  
  async createUser(request: CreateUserRequest): Promise<UserResponse> {
    try {
      const user = await this.userService.createUser(request);
      return this.mapToResponse(user);
    } catch (error) {
      throw new HttpException(error.message, HttpStatus.BAD_REQUEST);
    }
  }
}

// Business Logic Layer
export class UserService {
  constructor(
    private userRepository: UserRepository,
    private emailService: EmailService
  ) {}
  
  async createUser(userData: CreateUserData): Promise<User> {
    // Business logic validation
    await this.validateUserData(userData);
    
    // Create user entity
    const user = new User(userData);
    
    // Persist user
    const savedUser = await this.userRepository.save(user);
    
    // Send welcome email
    await this.emailService.sendWelcomeEmail(savedUser.email);
    
    return savedUser;
  }
  
  private async validateUserData(userData: CreateUserData): Promise<void> {
    if (!userData.email || !this.isValidEmail(userData.email)) {
      throw new ValidationError('Valid email is required');
    }
    
    const existingUser = await this.userRepository.findByEmail(userData.email);
    if (existingUser) {
      throw new BusinessError('User with this email already exists');
    }
  }
}

// Data Access Layer
export class UserRepository {
  constructor(private database: Database) {}
  
  async save(user: User): Promise<User> {
    const result = await this.database.query(
      'INSERT INTO users (email, name, created_at) VALUES (?, ?, ?)',
      [user.email, user.name, new Date()]
    );
    
    return { ...user, id: result.insertId };
  }
  
  async findByEmail(email: string): Promise<User | null> {
    const result = await this.database.query(
      'SELECT * FROM users WHERE email = ?',
      [email]
    );
    
    return result.length > 0 ? this.mapToUser(result[0]) : null;
  }
}
```

#### Microservices Design Pattern
```typescript
// Example microservice design with clear boundaries
// User Service
export class UserMicroservice {
  private eventBus: EventBus;
  private userRepository: UserRepository;
  
  constructor(eventBus: EventBus, userRepository: UserRepository) {
    this.eventBus = eventBus;
    this.userRepository = userRepository;
  }
  
  async createUser(userData: CreateUserData): Promise<User> {
    // Validate user data
    this.validateUserData(userData);
    
    // Create user
    const user = await this.userRepository.create(userData);
    
    // Publish user created event
    await this.eventBus.publish(new UserCreatedEvent(user));
    
    return user;
  }
  
  private validateUserData(userData: CreateUserData): void {
    if (!userData.email || !this.isValidEmail(userData.email)) {
      throw new ValidationError('Valid email is required');
    }
  }
}

// Order Service (separate microservice)
export class OrderMicroservice {
  private eventBus: EventBus;
  private orderRepository: OrderRepository;
  
  constructor(eventBus: EventBus, orderRepository: OrderRepository) {
    this.eventBus = eventBus;
    this.orderRepository = orderRepository;
    
    // Subscribe to user events
    this.eventBus.subscribe(UserCreatedEvent, this.handleUserCreated.bind(this));
  }
  
  private async handleUserCreated(event: UserCreatedEvent): Promise<void> {
    // Initialize user's order history
    await this.orderRepository.initializeUserOrderHistory(event.user.id);
  }
  
  async createOrder(orderData: CreateOrderData): Promise<Order> {
    // Verify user exists (cross-service validation)
    const userExists = await this.verifyUserExists(orderData.userId);
    if (!userExists) {
      throw new BusinessError('User does not exist');
    }
    
    // Create order
    const order = await this.orderRepository.create(orderData);
    
    // Publish order created event
    await this.eventBus.publish(new OrderCreatedEvent(order));
    
    return order;
  }
}
```

### Design Patterns Implementation
#### Repository Pattern with Dependency Injection
```typescript
// Abstract repository interface
export interface Repository<T, ID> {
  findById(id: ID): Promise<T | null>;
  findAll(): Promise<T[]>;
  save(entity: T): Promise<T>;
  delete(id: ID): Promise<void>;
}

// Concrete implementation
export class DatabaseUserRepository implements Repository<User, string> {
  constructor(private database: Database) {}
  
  async findById(id: string): Promise<User | null> {
    const result = await this.database.query(
      'SELECT * FROM users WHERE id = ?',
      [id]
    );
    return result.length > 0 ? this.mapToUser(result[0]) : null;
  }
  
  async findAll(): Promise<User[]> {
    const results = await this.database.query('SELECT * FROM users');
    return results.map(row => this.mapToUser(row));
  }
  
  async save(user: User): Promise<User> {
    if (user.id) {
      return this.update(user);
    } else {
      return this.create(user);
    }
  }
  
  async delete(id: string): Promise<void> {
    await this.database.query('DELETE FROM users WHERE id = ?', [id]);
  }
  
  private mapToUser(row: any): User {
    return new User({
      id: row.id,
      email: row.email,
      name: row.name,
      createdAt: row.created_at
    });
  }
}

// Dependency injection container
export class DIContainer {
  private services = new Map<string, any>();
  
  register<T>(key: string, factory: () => T): void {
    this.services.set(key, factory);
  }
  
  resolve<T>(key: string): T {
    const factory = this.services.get(key);
    if (!factory) {
      throw new Error(`Service ${key} not registered`);
    }
    return factory();
  }
}

// Service registration
const container = new DIContainer();
container.register('Database', () => new Database(config.database));
container.register('UserRepository', () => 
  new DatabaseUserRepository(container.resolve('Database'))
);
container.register('UserService', () => 
  new UserService(container.resolve('UserRepository'))
);
```

## Common Patterns and Examples

### Pattern 1: Event-Driven Architecture
**Scenario**: Building a scalable e-commerce system with multiple services
**Implementation**:
```typescript
// Event system design
export interface DomainEvent {
  eventId: string;
  eventType: string;
  aggregateId: string;
  timestamp: Date;
  version: number;
}

export class UserCreatedEvent implements DomainEvent {
  eventId: string;
  eventType = 'UserCreated';
  aggregateId: string;
  timestamp: Date;
  version: number;
  
  constructor(
    public user: User,
    version: number = 1
  ) {
    this.eventId = generateUUID();
    this.aggregateId = user.id;
    this.timestamp = new Date();
    this.version = version;
  }
}

export class EventStore {
  constructor(private database: Database) {}
  
  async saveEvent(event: DomainEvent): Promise<void> {
    await this.database.query(
      'INSERT INTO events (id, type, aggregate_id, data, timestamp, version) VALUES (?, ?, ?, ?, ?, ?)',
      [
        event.eventId,
        event.eventType,
        event.aggregateId,
        JSON.stringify(event),
        event.timestamp,
        event.version
      ]
    );
  }
  
  async getEvents(aggregateId: string): Promise<DomainEvent[]> {
    const results = await this.database.query(
      'SELECT * FROM events WHERE aggregate_id = ? ORDER BY version',
      [aggregateId]
    );
    
    return results.map(row => JSON.parse(row.data));
  }
}
```

### Pattern 2: CQRS (Command Query Responsibility Segregation)
**Scenario**: System with complex business logic requiring optimized read and write operations
**Implementation**:
```typescript
// Command side (writes)
export interface Command {
  commandId: string;
  timestamp: Date;
}

export class CreateUserCommand implements Command {
  commandId: string;
  timestamp: Date;
  
  constructor(
    public userData: CreateUserData
  ) {
    this.commandId = generateUUID();
    this.timestamp = new Date();
  }
}

export class UserCommandHandler {
  constructor(
    private userRepository: UserRepository,
    private eventBus: EventBus
  ) {}
  
  async handle(command: CreateUserCommand): Promise<void> {
    // Business logic validation
    await this.validateCreateUser(command.userData);
    
    // Create user aggregate
    const user = new User(command.userData);
    
    // Save to write model
    await this.userRepository.save(user);
    
    // Publish events for read model updates
    await this.eventBus.publish(new UserCreatedEvent(user));
  }
}

// Query side (reads)
export interface Query {
  queryId: string;
  timestamp: Date;
}

export class GetUsersByStatusQuery implements Query {
  queryId: string;
  timestamp: Date;
  
  constructor(
    public status: UserStatus,
    public pagination: PaginationParams
  ) {
    this.queryId = generateUUID();
    this.timestamp = new Date();
  }
}

export class UserQueryHandler {
  constructor(private readModelRepository: UserReadModelRepository) {}
  
  async handle(query: GetUsersByStatusQuery): Promise<UserSummary[]> {
    return await this.readModelRepository.findByStatus(
      query.status,
      query.pagination
    );
  }
}
```

### Anti-Patterns to Avoid
#### Anti-Pattern 1: God Object
- **Description**: Single class or component responsible for too many functions
- **Why It's Problematic**: Difficult to maintain, test, and extend; violates single responsibility principle
- **Better Approach**: Break down into smaller, focused components with clear responsibilities

#### Anti-Pattern 2: Tight Coupling
- **Description**: Components directly dependent on concrete implementations of other components
- **Why It's Problematic**: Makes system difficult to change, test, and extend
- **Better Approach**: Use dependency injection and interface-based design for loose coupling

## Tools and Resources

### Essential Tools
#### Design and Modeling Tools
- **UML Diagrams**: Comprehensive system modeling with class, sequence, and component diagrams
- **Architecture Decision Records (ADRs)**: Document important architectural decisions
- **C4 Model**: Visual architecture documentation at different levels of abstraction
- **Domain Modeling Tools**: Visual representation of business domain and relationships

#### Code Analysis and Quality
- **Static Code Analysis**: Automated detection of design issues and code smells
- **Dependency Analysis**: Visualization of component dependencies and coupling metrics
- **Complexity Metrics**: Measurement of cyclomatic complexity and maintainability
- **Architecture Testing**: Automated validation of architectural constraints

### Templates and Checklists
#### Design Review Checklist
- [ ] **Business Requirements**: Design addresses all functional requirements
- [ ] **Non-Functional Requirements**: Performance, security, and scalability requirements met
- [ ] **Component Design**: Clear responsibilities and well-defined interfaces
- [ ] **Data Design**: Appropriate data modeling and storage strategies
- [ ] **Integration Design**: External system integration patterns and error handling
- [ ] **Security Design**: Authentication, authorization, and data protection measures
- [ ] **Testing Strategy**: Comprehensive testing approach at all levels
- [ ] **Deployment Design**: Infrastructure requirements and deployment procedures

### Learning Resources
- **Design Patterns**: Gang of Four patterns and modern architectural patterns
- **Clean Architecture**: Uncle Bob's architectural principles and practices
- **Domain-Driven Design**: Eric Evans' strategic design and tactical patterns
- **Microservices Patterns**: Chris Richardson's microservices design patterns

## Quality and Compliance

### Quality Standards
- All design decisions documented with rationale and trade-offs
- Architecture supports testability with clear component boundaries
- Performance requirements addressed with appropriate design patterns
- Security considerations integrated into architectural design

### Compliance Requirements
#### Documentation Standards
- **Requirements**: Comprehensive design documentation maintained and version-controlled
- **Implementation**: Structured documentation with diagrams, ADRs, and API specifications
- **Verification**: Regular design review and documentation currency validation

#### Design Review Process
- **Requirements**: Peer review of all significant design decisions
- **Implementation**: Formal design review process with checkpoints and approvals
- **Verification**: Design review meeting minutes and approval documentation

### Audit and Review Processes
- Weekly component design review for new features
- Monthly architecture review for significant changes
- Quarterly comprehensive architecture assessment
- Annual technology stack and design pattern evaluation

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Performance Problems Due to Poor Design
**Symptoms**: Slow response times, high resource usage, scalability limitations
**Root Causes**: Inefficient algorithms, inappropriate data structures, poor caching strategy
**Solutions**:
1. Performance profiling to identify bottlenecks
2. Algorithm optimization and data structure improvements
3. Implement appropriate caching strategies
4. Consider architectural changes for better scalability
**Prevention**: Performance requirements integration into design phase

#### Issue 2: Maintenance Difficulties
**Symptoms**: Frequent bugs, difficult to add new features, long development cycles
**Root Causes**: Tight coupling, poor separation of concerns, inadequate documentation
**Solutions**:
1. Refactor to improve separation of concerns
2. Introduce dependency injection and interface-based design
3. Improve documentation and code organization
4. Implement comprehensive testing strategy
**Prevention**: Regular code review and refactoring, adherence to SOLID principles

### Escalation Procedures
- Design issues: Escalate to senior architects and technical leads
- Performance problems: Escalate to performance engineering team
- Security concerns: Escalate to security architecture team
- Technology decisions: Escalate to architecture review board

### Continuous Improvement
- Regular architecture review and improvement sessions
- Technology evaluation and adoption planning
- Design pattern training and knowledge sharing
- Lessons learned documentation and process improvement

## AI Assistant Guidelines

When helping with Software Design:

1. **Requirements Focus**: Always understand business requirements before proposing technical solutions
2. **Simplicity First**: Start with simple designs and add complexity only when necessary
3. **Pattern Application**: Use established design patterns appropriately, not for their own sake
4. **Quality Attributes**: Consider performance, security, maintainability, and scalability in all designs
5. **Future Evolution**: Design for change and extensibility while avoiding over-engineering
6. **Testing Integration**: Ensure designs support comprehensive testing strategies
7. **Documentation Emphasis**: Create clear, comprehensive design documentation
8. **Stakeholder Communication**: Use clear language and visual aids for design communication

### Decision Making Framework
When helping teams with software design:

1. **Problem Analysis**: Thoroughly understand the problem domain and constraints
2. **Solution Evaluation**: Compare multiple design alternatives with trade-off analysis
3. **Pattern Selection**: Choose appropriate architectural and design patterns
4. **Quality Assessment**: Evaluate design against quality attributes and requirements
5. **Implementation Planning**: Break design into implementable components and phases
6. **Risk Assessment**: Identify design risks and mitigation strategies

### Code Generation Rules
- Generate well-structured code following SOLID principles
- Include comprehensive interface definitions and abstractions
- Implement appropriate error handling and validation
- Create modular, loosely coupled components
- Include comprehensive documentation and examples
- Generate appropriate test structures and patterns

### Quality Enforcement
-  Enforce single responsibility principle in all components
-  Require interface-based design for flexibility and testability
-  Block tight coupling between unrelated components
-  Promote composition over inheritance for flexibility
-  Require comprehensive error handling and validation
-  Enforce separation of concerns across architectural layers
-  Promote dependency injection and inversion of control
-  Require comprehensive documentation of design decisions