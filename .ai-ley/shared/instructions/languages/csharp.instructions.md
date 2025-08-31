C# Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for C# projects. These include AI linting hints to automatically enforce style rules and maintain clean, performant, and maintainable code across multiple project types.

⸻

📂 Project Architecture

✅ Rule: Enforce API-first architecture

- Backend (C#) should provide API logic and return JSON/structured data. Separate business logic from presentation.
- Frontend should consume API data and render UI. Avoid embedding business logic in views.
- Use dependency injection for loose coupling and testability.

✅ Rule: Strict separation of concerns

- Controllers → API endpoints and request/response handling
- Services → Business logic and domain operations  
- Models → Data structures and domain entities
- Views → UI presentation (MVC/Razor) or client-side rendering
- Data Access → Repository pattern or Entity Framework

✅ Rule: Namespaces and Organization

- Organize code into logical namespaces (e.g., `ProjectName.Api`, `ProjectName.Services`, `ProjectName.Models`).
- Use consistent folder structure matching namespace hierarchy.
- Follow .NET naming conventions (PascalCase for public members, camelCase for private fields).

✅ Rule: Dependency Injection

- Register services in Program.cs or Startup.cs for .NET Core/.NET 5+.
- Use interfaces for service contracts to enable testing and flexibility.
- Prefer constructor injection over service locator pattern.

✅ Rule: Configuration Management

- Use IConfiguration for application settings.
- Store sensitive data in user secrets (development) or Azure Key Vault (production).
- Use strongly-typed configuration classes with IOptions<T>.


⸻

📦 Package Management

✅ Rule: Use approved NuGet packages

**Core Packages:**
- Microsoft.AspNetCore.* for web APIs
- Entity Framework Core for data access
- AutoMapper for object mapping
- FluentValidation for input validation
- Serilog for structured logging
- xUnit for unit testing
- Moq for mocking in tests

**Frontend (if applicable):**
- SignalR for real-time communication
- Swagger/OpenAPI for API documentation

✅ Rule: Package Versioning

- Keep packages up to date but test thoroughly before major version upgrades.
- Use package lock files (packages.lock.json) for reproducible builds.


⸻

🖋 C# Coding Standards

✅ String Handling

- Use string interpolation (`$""`) for simple variable embedding.
- Use StringBuilder for multiple concatenations or loop-based string building.
- Use verbatim strings (`@""`) for file paths and multi-line strings.
- Define constants for repeated string values.

✅ Example:

```csharp
// Good: String interpolation
var message = $"Hello, {username}!";

// Good: StringBuilder for multiple operations
var sb = new StringBuilder();
foreach (var item in items)
{
    sb.AppendLine(item.ToString());
}
var result = sb.ToString();

// Good: Constants for repeated values
private const string NewLine = "\n";
```

⸻

✅ Async/Await Patterns

- Use async/await for I/O operations (database, HTTP calls, file operations).
- Always return Task or Task<T> from async methods.
- Use ConfigureAwait(false) in library code to avoid deadlocks.
- Never use .Result or .Wait() - use await instead.

✅ Example:

```csharp
// Good: Proper async pattern
public async Task<User> GetUserAsync(int id)
{
    return await _repository.FindByIdAsync(id).ConfigureAwait(false);
}

// Bad: Blocking async code
public User GetUser(int id)
{
    return _repository.FindByIdAsync(id).Result; // Deadlock risk
}
```

⸻

✅ Loops & Memory (C#)

- Use LINQ methods (Select, Where, etc.) instead of manual loops when appropriate.
- 🚫 Avoid string concatenation inside loops using += operator.
- 🚫 Avoid repeatedly calling List.Add() for large collections - use List constructor with capacity or AddRange.
- ✅ Use StringBuilder, string.Join(), or LINQ for string operations.

❌ Bad:

```csharp
string result = "";
foreach (var line in lines)
{
    result += line; // prohibited - creates new strings
}
```

❌ Also Bad:

```csharp
var parts = new List<string>();
foreach (var line in lines)
{
    parts.Add(line); // inefficient for large collections
}
```

✅ Good:

```csharp
var result = string.Join(Environment.NewLine, lines);
// or
var result = lines.Aggregate((a, b) => a + Environment.NewLine + b);
```

⸻

✅ Pattern Matching & Polymorphism (C#)

- Use pattern matching instead of lengthy switch statements when appropriate.
- Follow Strategy pattern: use interfaces and dependency injection instead of switch/case.
- Implement consistent message processing patterns for flexibility.

✅ Example:

```csharp
// Bad: Multiple case statements
string result = operation switch
{
    "validate" => ValidateData(data),
    "transform" => TransformData(data),
    "save" => SaveData(data),
    _ => throw new ArgumentException("Unknown operation")
};

// Good: Strategy pattern with DI
public interface IDataProcessor
{
    Task<ProcessResult> ProcessAsync(ProcessMessage message);
}

public class ValidationProcessor : IDataProcessor
{
    public async Task<ProcessResult> ProcessAsync(ProcessMessage message)
    {
        message.Payload = await ValidateDataAsync(message.Payload);
        return new ProcessResult { Success = true, Payload = message.Payload };
    }
}

// Usage with factory or DI container
var processor = _processorFactory.Create(message.Operation);
var result = await processor.ProcessAsync(message);
```

✅ Base Classes & Interfaces (C#)

- Implement consistent interfaces: IDisposable for cleanup, standard CRUD operations.
- Use abstract base classes for shared functionality.
- Follow Repository and Unit of Work patterns for data access.

✅ Example:

```csharp
public abstract class BaseProcessor<T> : IDisposable
{
    protected readonly ILogger<BaseProcessor<T>> _logger;
    protected readonly IConfiguration _configuration;
    
    protected BaseProcessor(ILogger<BaseProcessor<T>> logger, IConfiguration configuration)
    {
        _logger = logger;
        _configuration = configuration;
    }
    
    public abstract Task<ProcessResult<T>> ProcessAsync(ProcessMessage<T> message);
    
    protected virtual void LogOperation(string operation, object data)
    {
        _logger.LogInformation("Processing {Operation} with data {Data}", operation, data);
    }
    
    public virtual void Dispose()
    {
        // Cleanup resources
    }
}

// Usage with generic constraints
public class ValidationProcessor<T> : BaseProcessor<T> where T : class
{
    public override async Task<ProcessResult<T>> ProcessAsync(ProcessMessage<T> message)
    {
        LogOperation("Validation", message.Payload);
        // Process validation
        return new ProcessResult<T> { Success = true, Payload = message.Payload };
    }
}
```

⸻

✅ Error Handling & Logging

- Use structured logging with Serilog or Microsoft.Extensions.Logging.
- Implement proper exception handling with specific exception types.
- Use Result pattern or custom response types instead of throwing exceptions for business logic failures.
- Always log at appropriate levels (Debug, Information, Warning, Error, Critical).

✅ Example:

```csharp
public async Task<Result<User>> CreateUserAsync(CreateUserRequest request)
{
    try
    {
        _logger.LogInformation("Creating user {Email}", request.Email);
        
        var existingUser = await _userRepository.FindByEmailAsync(request.Email);
        if (existingUser != null)
        {
            _logger.LogWarning("User creation failed - email already exists: {Email}", request.Email);
            return Result<User>.Failure("Email already exists");
        }
        
        var user = new User { Email = request.Email };
        await _userRepository.AddAsync(user);
        
        _logger.LogInformation("User created successfully {UserId}", user.Id);
        return Result<User>.Success(user);
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Error creating user {Email}", request.Email);
        return Result<User>.Failure("An error occurred while creating the user");
    }
}
```

⸻

🧠 Performance

- Use async/await for I/O operations to improve scalability.
- Minimize database round trips with eager loading or projection.
- Use caching (IMemoryCache, IDistributedCache) for frequently accessed data.
- Implement pagination for large data sets.
- Use value types (structs) for small, immutable data.

✅ Example:

```csharp
// Good: Efficient data loading with projection
public async Task<IEnumerable<UserDto>> GetUsersAsync(int pageSize, int pageNumber)
{
    return await _context.Users
        .Where(u => u.IsActive)
        .Select(u => new UserDto { Id = u.Id, Name = u.Name, Email = u.Email })
        .Skip(pageNumber * pageSize)
        .Take(pageSize)
        .ToListAsync();
}
```

⸻

✅ Testing Standards

- Use xUnit for unit tests with descriptive test method names.
- Follow AAA pattern: Arrange, Act, Assert.
- Use Moq for mocking dependencies.
- Aim for high code coverage but focus on critical business logic.
- Use integration tests for API endpoints.

✅ Example:

```csharp
[Fact]
public async Task CreateUserAsync_WithValidData_ShouldReturnSuccessResult()
{
    // Arrange
    var request = new CreateUserRequest { Email = "test@example.com" };
    var mockRepository = new Mock<IUserRepository>();
    mockRepository.Setup(r => r.FindByEmailAsync(It.IsAny<string>()))
              .ReturnsAsync((User)null);
    
    var service = new UserService(mockRepository.Object, Mock.Of<ILogger<UserService>>());
    
    // Act
    var result = await service.CreateUserAsync(request);
    
    // Assert
    Assert.True(result.IsSuccess);
    Assert.Equal(request.Email, result.Value.Email);
    mockRepository.Verify(r => r.AddAsync(It.IsAny<User>()), Times.Once);
}
```

⸻

⚡ Performance Rules

✅ Unified String Building Rules

- 🚫 Avoid string concatenation inside loops using += operator.
- 🚫 Avoid repeated List.Add() operations for large collections without capacity planning.
- ✅ Use StringBuilder, string.Join(), or LINQ methods for string operations.
- ✅ Use List<T> constructor with capacity for known collection sizes.

⸻

✍️ Commit Message Conventions

- Prefix commits with: `style:`, `perf:`, `refactor:`, `fix:`, `feat:`, `test:`, or `docs:`
- Example: `feat: add user authentication service`
- Example: `perf: optimize database queries for user lookup`

⸻

🚦 AI Enforcement Summary

✅ Enforce API-first architecture with proper separation of concerns
✅ Enforce async/await patterns for I/O operations  
✅ Block string concatenation in loops and inefficient collection operations
✅ Enforce dependency injection and interface-based design
✅ Enforce proper error handling and structured logging
✅ Prefer pattern matching and strategy pattern over switch statements
✅ Enforce consistent naming conventions and code organization
✅ Enforce proper testing patterns with AAA structure
✅ Auto-fix violations where possible