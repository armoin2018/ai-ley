---
applyTo: "**/*.java"
---

# Java Programming Instructions

Comprehensive Java development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.

## 🧠 Context

- **Language**: Java (17+)
- **Environments**: JVM, Spring Boot, Jakarta EE, Android
- **Common Frameworks**: Spring Framework, Spring Boot, Hibernate, JUnit, Mockito
- **Package Managers**: Maven, Gradle
- **Build Tools**: Maven, Gradle, Ant
- **Testing**: JUnit 5, Mockito, TestNG, AssertJ

## 📁 Project Structure

```text
src/
  main/
    java/
      com/
        company/
          project/
            controllers/      # REST controllers
            services/         # Business logic
            repositories/     # Data access layer
            models/          # Domain entities
            dto/             # Data transfer objects
            config/          # Configuration classes
            exceptions/      # Custom exceptions
            utils/           # Utility classes
    resources/
      application.properties # Configuration
      static/               # Static web assets
      templates/            # View templates
  test/
    java/
      com/
        company/
          project/
            unit/            # Unit tests
            integration/     # Integration tests
    resources/
      application-test.properties
pom.xml                     # Maven configuration
build.gradle               # Gradle configuration
```

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern Java following established conventions
- Prioritize code readability and maintainability over cleverness
- Implement clear separation of concerns and modularity
- Use consistent formatting with google-java-format
- Follow the principle of least surprise
- Embrace SOLID principles and clean architecture patterns
- Use proper encapsulation with private fields and public methods

### Modern Language Features
- Leverage Java 17+ features (sealed classes, pattern matching, text blocks)
- Use Optional for nullable returns and better null safety
- Implement streams and lambda expressions for functional programming
- Utilize record classes for immutable data carriers
- Take advantage of var keyword for local variable type inference

## 📜 Code Style and Conventions

### Naming Conventions

```java
// ✅ Good: Use camelCase for variables and methods
String userName = "john_doe";
int orderCount = 42;
boolean isActive = true;

public void processOrder(Order order) { }
public Optional<User> findUserById(long id) { }

// ✅ Good: Use PascalCase for classes and interfaces
public class UserService { }
public interface OrderRepository { }
public enum UserStatus { ACTIVE, INACTIVE, SUSPENDED }

// ✅ Good: Use UPPER_SNAKE_CASE for constants
public static final int MAX_RETRY_COUNT = 3;
public static final String DEFAULT_ENCODING = "UTF-8";
private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);

// ✅ Good: Use descriptive names
List<User> activeUsers = findActiveUsers();
Map<String, Integer> userCountByDepartment = calculateUserStats();
```

### Function Design

```java
// ✅ Good: Pure functions with clear inputs/outputs
public Optional<User> findUserByEmail(String email) {
    Objects.requireNonNull(email, "Email cannot be null");
    return userRepository.findByEmail(email.toLowerCase().trim());
}

// ✅ Good: Use Javadoc for documentation
/**
 * Creates a new user account with the specified details.
 * 
 * @param username the unique username for the account
 * @param email the user's email address
 * @param initialStatus the initial status for the user account
 * @return the created user with generated ID
 * @throws UserAlreadyExistsException if username or email already exists
 * @throws IllegalArgumentException if any parameter is invalid
 */
public User createUser(String username, String email, UserStatus initialStatus) {
    validateUserInput(username, email);
    checkUserDoesNotExist(username, email);
    
    User user = new User.Builder()
            .setUsername(username)
            .setEmail(email)
            .setStatus(initialStatus)
            .setCreatedAt(LocalDateTime.now())
            .build();
            
    return userRepository.save(user);
}

// ✅ Good: Builder pattern for complex objects
public static class Builder {
    private String username;
    private String email;
    private UserStatus status = UserStatus.ACTIVE;
    private LocalDateTime createdAt = LocalDateTime.now();
    
    public Builder setUsername(String username) {
        this.username = username;
        return this;
    }
    
    public User build() {
        return new User(this);
    }
}
```

## 🏗️ Architecture Patterns

### Object-Oriented Design

```java
// ✅ Well-structured service layer with dependency injection
@Service
public class UserService {
    private final UserRepository userRepository;
    private final EmailValidator emailValidator;
    private final PasswordEncoder passwordEncoder;
    
    public UserService(UserRepository userRepository, 
                      EmailValidator emailValidator,
                      PasswordEncoder passwordEncoder) {
        this.userRepository = Objects.requireNonNull(userRepository);
        this.emailValidator = Objects.requireNonNull(emailValidator);
        this.passwordEncoder = Objects.requireNonNull(passwordEncoder);
    }
    
    @Transactional
    public User createUser(CreateUserRequest request) {
        validateRequest(request);
        
        User user = User.builder()
                .username(request.getUsername())
                .email(request.getEmail())
                .passwordHash(passwordEncoder.encode(request.getPassword()))
                .status(UserStatus.ACTIVE)
                .build();
                
        return userRepository.save(user);
    }
    
    private void validateRequest(CreateUserRequest request) {
        if (!emailValidator.isValid(request.getEmail())) {
            throw new InvalidEmailException("Invalid email format: " + request.getEmail());
        }
        
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new UserAlreadyExistsException("Username already exists: " + request.getUsername());
        }
    }
}
```

### Repository Pattern Implementation

```java
// ✅ Clean repository interface with Spring Data JPA
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    List<User> findByStatus(UserStatus status);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
    
    @Query("SELECT u FROM User u WHERE u.createdAt BETWEEN :start AND :end")
    List<User> findUsersCreatedBetween(@Param("start") LocalDateTime start, 
                                      @Param("end") LocalDateTime end);
}
```

## 🔄 Concurrent Programming

### CompletableFuture Best Practices

```java
// ✅ Good: Proper asynchronous processing
@Service
public class AsyncUserService {
    private final UserService userService;
    private final ExecutorService executorService;
    
    public AsyncUserService(UserService userService) {
        this.userService = userService;
        this.executorService = Executors.newFixedThreadPool(10);
    }
    
    public CompletableFuture<List<User>> processUsersAsync(List<Long> userIds) {
        List<CompletableFuture<User>> futures = userIds.stream()
                .map(this::processUserAsync)
                .collect(Collectors.toList());
                
        return CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]))
                .thenApply(v -> futures.stream()
                        .map(CompletableFuture::join)
                        .collect(Collectors.toList()));
    }
    
    private CompletableFuture<User> processUserAsync(Long userId) {
        return CompletableFuture.supplyAsync(() -> {
            return userService.findUserById(userId)
                    .orElseThrow(() -> new UserNotFoundException("User not found: " + userId));
        }, executorService);
    }
    
    @PreDestroy
    public void shutdown() {
        executorService.shutdown();
        try {
            if (!executorService.awaitTermination(30, TimeUnit.SECONDS)) {
                executorService.shutdownNow();
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            executorService.shutdownNow();
        }
    }
}

// ✅ Good: Thread-safe singleton with concurrent collections
@Component
public class CacheManager {
    private final ConcurrentHashMap<String, Object> cache = new ConcurrentHashMap<>();
    private final ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
    
    public <T> Optional<T> get(String key, Class<T> type) {
        lock.readLock().lock();
        try {
            Object value = cache.get(key);
            return Optional.ofNullable(type.cast(value));
        } finally {
            lock.readLock().unlock();
        }
    }
    
    public void put(String key, Object value) {
        lock.writeLock().lock();
        try {
            cache.put(key, value);
        } finally {
            lock.writeLock().unlock();
        }
    }
}
```

### Error Handling

```java
// ✅ Custom exception hierarchy
public class UserServiceException extends Exception {
    public UserServiceException(String message) {
        super(message);
    }
    
    public UserServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}

public class UserAlreadyExistsException extends UserServiceException {
    public UserAlreadyExistsException(String message) {
        super(message);
    }
}

public class UserNotFoundException extends UserServiceException {
    public UserNotFoundException(String message) {
        super(message);
    }
}

// ✅ Comprehensive error handling with proper logging
@ControllerAdvice
public class GlobalExceptionHandler {
    private static final Logger LOGGER = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    
    @ExceptionHandler(UserNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ResponseEntity<ErrorResponse> handleUserNotFound(UserNotFoundException ex) {
        LOGGER.warn("User not found: {}", ex.getMessage());
        return ResponseEntity.notFound().build();
    }
    
    @ExceptionHandler(UserAlreadyExistsException.class)
    @ResponseStatus(HttpStatus.CONFLICT)
    public ResponseEntity<ErrorResponse> handleUserAlreadyExists(UserAlreadyExistsException ex) {
        LOGGER.warn("User already exists: {}", ex.getMessage());
        ErrorResponse error = new ErrorResponse("USER_ALREADY_EXISTS", ex.getMessage());
        return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
    }
    
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ResponseEntity<ErrorResponse> handleGenericException(Exception ex) {
        LOGGER.error("Unexpected error occurred", ex);
        ErrorResponse error = new ErrorResponse("INTERNAL_ERROR", "An unexpected error occurred");
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
    }
}
```

## 🛡️ Memory Management

### Efficient Resource Handling

```java
// ✅ Try-with-resources for automatic resource management
public List<User> loadUsersFromFile(Path filePath) throws IOException {
    try (BufferedReader reader = Files.newBufferedReader(filePath, StandardCharsets.UTF_8)) {
        return reader.lines()
                .filter(line -> !line.trim().isEmpty())
                .map(this::parseUserFromLine)
                .collect(Collectors.toList());
    }
}

// ✅ Proper cleanup in services
@Service
public class FileProcessingService {
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(2);
    
    @PostConstruct
    public void initialize() {
        // Schedule cleanup tasks
        scheduler.scheduleAtFixedRate(this::cleanupTempFiles, 1, 1, TimeUnit.HOURS);
    }
    
    @PreDestroy
    public void cleanup() {
        scheduler.shutdown();
        try {
            if (!scheduler.awaitTermination(10, TimeUnit.SECONDS)) {
                scheduler.shutdownNow();
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            scheduler.shutdownNow();
        }
    }
}

// ✅ Memory-efficient streaming for large datasets
public Stream<User> streamAllUsers() {
    return userRepository.findAll().stream()
            .filter(user -> user.getStatus() == UserStatus.ACTIVE);
}
```

## ⚡ Performance Optimization

### Efficient Code Patterns

```java
// ✅ Use appropriate collection types for performance
public Map<String, List<User>> groupUsersByDepartment(List<User> users) {
    return users.stream()
            .collect(Collectors.groupingBy(
                User::getDepartment,
                LinkedHashMap::new,  // Preserve insertion order
                Collectors.toList()
            ));
}

// ✅ Lazy initialization for expensive operations
public class ExpensiveResourceManager {
    private volatile ExpensiveResource resource;
    
    public ExpensiveResource getResource() {
        if (resource == null) {
            synchronized (this) {
                if (resource == null) {
                    resource = new ExpensiveResource();
                }
            }
        }
        return resource;
    }
}

// ❌ Bad: Inefficient string concatenation in loops
public String buildReport(List<User> users) {
    String report = "";
    for (User user : users) {
        report += user.getName() + ", ";  // Creates new string each iteration
    }
    return report;
}

// ✅ Good: Use StringBuilder for string concatenation
public String buildReport(List<User> users) {
    StringBuilder report = new StringBuilder();
    users.forEach(user -> report.append(user.getName()).append(", "));
    return report.toString();
}

// ✅ Even better: Use streams and joining
public String buildReport(List<User> users) {
    return users.stream()
            .map(User::getName)
            .collect(Collectors.joining(", "));
}
```

## 🧪 Testing Guidelines

### Unit Testing Best Practices

```java
// UserServiceTest.java
@ExtendWith(MockitoExtension.class)
class UserServiceTest {
    
    @Mock
    private UserRepository userRepository;
    
    @Mock
    private EmailValidator emailValidator;
    
    @Mock
    private PasswordEncoder passwordEncoder;
    
    @InjectMocks
    private UserService userService;
    
    @Test
    @DisplayName("Should create user successfully with valid data")
    void shouldCreateUserSuccessfully() {
        // Arrange
        CreateUserRequest request = new CreateUserRequest("testuser", "test@example.com", "password123");
        String encodedPassword = "encoded_password";
        
        when(emailValidator.isValid(request.getEmail())).thenReturn(true);
        when(userRepository.existsByUsername(request.getUsername())).thenReturn(false);
        when(userRepository.existsByEmail(request.getEmail())).thenReturn(false);
        when(passwordEncoder.encode(request.getPassword())).thenReturn(encodedPassword);
        when(userRepository.save(any(User.class))).thenAnswer(invocation -> {
            User user = invocation.getArgument(0);
            return user.toBuilder().id(1L).build();
        });
        
        // Act
        User result = userService.createUser(request);
        
        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getUsername()).isEqualTo(request.getUsername());
        assertThat(result.getEmail()).isEqualTo(request.getEmail());
        assertThat(result.getPasswordHash()).isEqualTo(encodedPassword);
        assertThat(result.getStatus()).isEqualTo(UserStatus.ACTIVE);
        
        verify(userRepository).save(any(User.class));
        verify(passwordEncoder).encode(request.getPassword());
    }
    
    @ParameterizedTest
    @ValueSource(strings = {"", " ", "ab", "a".repeat(51)})
    @DisplayName("Should throw exception for invalid username")
    void shouldThrowExceptionForInvalidUsername(String invalidUsername) {
        // Arrange
        CreateUserRequest request = new CreateUserRequest(invalidUsername, "test@example.com", "password123");
        
        // Act & Assert
        assertThatThrownBy(() -> userService.createUser(request))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("Username");
    }
    
    @Test
    @DisplayName("Should return empty Optional when user not found")
    void shouldReturnEmptyOptionalWhenUserNotFound() {
        // Arrange
        long userId = 999L;
        when(userRepository.findById(userId)).thenReturn(Optional.empty());
        
        // Act
        Optional<User> result = userService.findUserById(userId);
        
        // Assert
        assertThat(result).isEmpty();
    }
}
```

### Integration Testing

```java
// UserIntegrationTest.java
@SpringBootTest
@Testcontainers
@Transactional
class UserIntegrationTest {
    
    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:13")
            .withDatabaseName("testdb")
            .withUsername("test")
            .withPassword("test");
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRepository userRepository;
    
    @Test
    @DisplayName("Should create and retrieve user from database")
    void shouldCreateAndRetrieveUser() {
        // Arrange
        CreateUserRequest request = new CreateUserRequest("integrationuser", "integration@test.com", "password123");
        
        // Act
        User createdUser = userService.createUser(request);
        Optional<User> retrievedUser = userService.findUserById(createdUser.getId());
        
        // Assert
        assertThat(retrievedUser).isPresent();
        assertThat(retrievedUser.get().getUsername()).isEqualTo(request.getUsername());
        assertThat(retrievedUser.get().getEmail()).isEqualTo(request.getEmail());
    }
}
```

## 🛠️ Development Environment

### Recommended Configuration

```xml
<!-- pom.xml -->
<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <spring.boot.version>3.1.0</spring.boot.version>
    <junit.version>5.9.3</junit.version>
</properties>

<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-validation</artifactId>
    </dependency>
</dependencies>
```

### Essential Tools
- **Formatter**: google-java-format - Consistent code formatting across projects
- **Linter**: Checkstyle, SpotBugs, PMD - Static analysis and code quality checks
- **Type Checker**: Built-in javac - Compile-time type checking and inference
- **Build Tool**: Maven/Gradle - Dependency management and build automation
- **Package Manager**: Maven Central/JCenter - Library dependency resolution

## 🔍 Code Quality Standards

### Static Analysis

```java
// ✅ Immutable data classes with validation
public record CreateUserRequest(
        @NotBlank @Size(min = 3, max = 50) String username,
        @Email @NotBlank String email,
        @NotBlank @Size(min = 8) String password
) {
    public CreateUserRequest {
        Objects.requireNonNull(username, "Username cannot be null");
        Objects.requireNonNull(email, "Email cannot be null");
        Objects.requireNonNull(password, "Password cannot be null");
    }
}
```

### Documentation Standards

```java
// ✅ Comprehensive API documentation
/**
 * REST controller for managing user accounts.
 * 
 * <p>This controller provides endpoints for user CRUD operations,
 * including registration, authentication, and profile management.
 * 
 * @author Development Team
 * @version 1.0
 * @since 1.0
 */
@RestController
@RequestMapping("/api/v1/users")
@Validated
public class UserController {
    
    /**
     * Creates a new user account.
     * 
     * @param request the user creation request containing username, email, and password
     * @return the created user information (excluding password)
     * @throws UserAlreadyExistsException if username or email already exists
     */
    @PostMapping
    public ResponseEntity<UserResponse> createUser(@Valid @RequestBody CreateUserRequest request) {
        User user = userService.createUser(request);
        UserResponse response = UserResponse.fromUser(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}
```

## 🚫 Common Pitfalls to Avoid

- **Raw Types Usage**: Always use generics for type safety and avoid raw collections
- **Field Injection**: Use constructor injection instead of @Autowired on fields for better testability
- **Exposing Entities**: Never expose JPA entities directly; always use DTOs for API responses
- **Ignoring Exceptions**: Always handle or properly propagate exceptions with meaningful messages
- **Static Utility Overuse**: Avoid static methods for business logic; prefer dependency injection
- **God Classes**: Keep classes focused on single responsibility; split large classes into smaller ones
- **Premature Optimization**: Write clear, readable code first; optimize only when performance issues are identified

## 📚 Essential Libraries

### Standard Library
```java
// Core collections and utilities
import java.util.*;
import java.util.stream.*;
import java.util.concurrent.*;
import java.time.*;
import java.nio.file.*;

// Modern Java features
import java.util.Optional;
import java.util.function.*;
```

### Recommended Third-Party Libraries
- **Spring Framework**: Comprehensive framework for enterprise Java development
- **Hibernate/JPA**: Object-relational mapping for database persistence
- **Jackson**: JSON processing and data binding for REST APIs
- **SLF4J + Logback**: Structured logging with performance optimization
- **AssertJ**: Fluent assertions for more readable test code
- **Testcontainers**: Integration testing with real database instances

## 🚦 AI Enforcement Summary

### Code Quality Rules
- ✅ Enforce proper encapsulation with private fields and public methods
- ✅ Require @Override annotations for all inherited method implementations
- ✅ Block raw types usage and enforce proper generic type parameters
- ✅ Enforce proper equals() and hashCode() implementation for entity classes
- ✅ Require comprehensive Javadoc for all public classes and methods
- ✅ Block deprecated Date/Calendar usage in favor of java.time API
- ✅ Enforce immutability with final keyword and builder patterns
- ✅ Auto-fix common formatting violations with google-java-format

### Performance Enforcement
- 🚫 Block string concatenation in loops without StringBuilder
- 🚫 Block inefficient collection operations (e.g., repeated List.contains())
- ✅ Promote stream operations for data processing and filtering
- ✅ Promote proper resource management with try-with-resources

### Security Enforcement
- 🔒 Enforce input validation with Bean Validation annotations
- 🔒 Block exposure of sensitive data in logs and API responses
- 🔒 Require proper password encoding and secure authentication

## 📖 References

- [Oracle Java Documentation](https://docs.oracle.com/en/java/)
- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- [Spring Framework Documentation](https://spring.io/guides)
- [JUnit 5 User Guide](https://junit.org/junit5/docs/current/user-guide/)
- [Java Performance: The Definitive Guide](https://www.oreilly.com/library/view/java-performance-the/9781449363512/)