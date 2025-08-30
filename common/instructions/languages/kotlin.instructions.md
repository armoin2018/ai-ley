---
applyTo: "**/*.{kt,kts}"
---

# Kotlin Programming Instructions

Comprehensive Kotlin development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.

## 🧠 Context

- **Language**: Kotlin (1.9+)
- **Environments**: JVM, Android, Native, JavaScript/WASM
- **Common Frameworks**: Ktor, Spring Boot, Jetpack Compose, Coroutines, Exposed
- **Package Managers**: Gradle, Maven
- **Build Tools**: Gradle Kotlin DSL, Maven
- **Testing**: JUnit 5, Kotest, MockK, Turbine

## 📁 Project Structure

```text
src/
  main/
    kotlin/
      com/
        example/
          domain/          # Business logic and entities
            model/         # Domain models
            repository/    # Repository interfaces
            usecase/       # Use cases/interactors
          data/            # Data layer implementation
            local/         # Local storage (Room, etc.)
            remote/        # Network layer (Retrofit, etc.)
            repository/    # Repository implementations
          presentation/    # UI layer
            ui/            # Composables/Views
            viewmodel/     # ViewModels
            navigation/    # Navigation logic
          di/              # Dependency injection
          utils/           # Utility classes
    resources/             # Resources and configuration
  test/
    kotlin/               # Unit tests
  androidTest/            # Android instrumentation tests (if Android)
```

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern Kotlin following established conventions
- Prioritize code readability and maintainability over cleverness
- Implement clear separation of concerns and modularity
- Use consistent formatting with ktlint or detekt
- Follow the principle of least surprise
- Leverage Kotlin's null safety and type system effectively
- Prefer immutable data structures and pure functions

### Modern Language Features
- Use data classes for simple data containers
- Leverage sealed classes for representing restricted hierarchies
- Employ extension functions for clean, readable APIs
- Utilize coroutines for asynchronous programming
- Apply scope functions (let, run, with, apply, also) appropriately
- Use delegation patterns (by lazy, by observable)
- Leverage inline functions for performance-critical code

## 📜 Code Style and Conventions

### Naming Conventions

```kotlin
// ✅ Good: Use camelCase for variables and functions
val userName = "john_doe"
val userAge = 25

fun calculateTotalPrice(items: List<Item>): BigDecimal {
    return items.sumOf { it.price }
}

// ✅ Good: Use PascalCase for classes
class UserRepository
data class UserProfile(val name: String, val email: String)
sealed class NetworkResult<T>

// ✅ Good: Use SCREAMING_SNAKE_CASE for constants
const val MAX_RETRY_COUNT = 3
const val DEFAULT_TIMEOUT_SECONDS = 30

// ✅ Good: Use descriptive names
val isUserAuthenticated = true
val hasValidEmail = user.email.contains("@")
fun findUserByEmail(email: String): User?
```

### Function Design

```kotlin
// ✅ Good: Pure functions with clear inputs/outputs
fun calculateDiscount(price: BigDecimal, discountPercent: Int): BigDecimal {
    return price * (discountPercent.toBigDecimal() / 100.toBigDecimal())
}

// ✅ Good: Use KDoc for documentation
/**
 * Processes user registration with validation and notification.
 * 
 * @param userData The user information to register
 * @param sendWelcomeEmail Whether to send a welcome email
 * @return The created user with generated ID
 * @throws ValidationException if user data is invalid
 * @throws UserAlreadyExistsException if email is already registered
 */
suspend fun registerUser(
    userData: UserRegistrationData,
    sendWelcomeEmail: Boolean = true
): User {
    validateUserData(userData)
    val user = userRepository.createUser(userData)
    if (sendWelcomeEmail) {
        emailService.sendWelcomeEmail(user.email)
    }
    return user
}

// ✅ Good: Use extension functions for clean APIs
fun String.isValidEmail(): Boolean {
    return this.contains("@") && this.contains(".")
}

fun List<User>.filterByStatus(status: UserStatus): List<User> {
    return this.filter { it.status == status }
}
```

## 🏗️ Architecture Patterns

### Clean Architecture Design

```kotlin
// ✅ Well-structured domain model
data class User(
    val id: UserId,
    val email: String,
    val name: String,
    val status: UserStatus,
    val createdAt: Instant
) {
    init {
        require(email.isValidEmail()) { "Invalid email format" }
        require(name.isNotBlank()) { "Name cannot be blank" }
    }
}

sealed class UserStatus {
    object Active : UserStatus()
    object Inactive : UserStatus()
    object Suspended : UserStatus()
}

// Repository interface (domain layer)
interface UserRepository {
    suspend fun findById(id: UserId): User?
    suspend fun findByEmail(email: String): User?
    suspend fun save(user: User): User
    suspend fun delete(id: UserId)
}

// Use case (domain layer)
class RegisterUserUseCase(
    private val userRepository: UserRepository,
    private val emailService: EmailService
) {
    suspend operator fun invoke(request: UserRegistrationRequest): Result<User> {
        return try {
            val existingUser = userRepository.findByEmail(request.email)
            if (existingUser != null) {
                return Result.failure(UserAlreadyExistsException(request.email))
            }
            
            val user = User(
                id = UserId.generate(),
                email = request.email,
                name = request.name,
                status = UserStatus.Active,
                createdAt = Instant.now()
            )
            
            val savedUser = userRepository.save(user)
            emailService.sendWelcomeEmail(savedUser.email)
            
            Result.success(savedUser)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
}
```

### MVVM Pattern Implementation

```kotlin
// ✅ ViewModel with proper state management
class UserProfileViewModel(
    private val getUserUseCase: GetUserUseCase,
    private val updateUserUseCase: UpdateUserUseCase
) : ViewModel() {
    
    private val _uiState = MutableStateFlow(UserProfileUiState())
    val uiState: StateFlow<UserProfileUiState> = _uiState.asStateFlow()
    
    fun loadUser(userId: String) {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true) }
            
            getUserUseCase(userId)
                .onSuccess { user ->
                    _uiState.update { 
                        it.copy(
                            isLoading = false,
                            user = user,
                            error = null
                        )
                    }
                }
                .onFailure { error ->
                    _uiState.update { 
                        it.copy(
                            isLoading = false,
                            error = error.message
                        )
                    }
                }
        }
    }
    
    fun updateUserName(newName: String) {
        val currentUser = _uiState.value.user ?: return
        
        viewModelScope.launch {
            _uiState.update { it.copy(isUpdating = true) }
            
            updateUserUseCase(currentUser.copy(name = newName))
                .onSuccess { updatedUser ->
                    _uiState.update { 
                        it.copy(
                            isUpdating = false,
                            user = updatedUser
                        )
                    }
                }
                .onFailure { error ->
                    _uiState.update { 
                        it.copy(
                            isUpdating = false,
                            error = error.message
                        )
                    }
                }
        }
    }
}

data class UserProfileUiState(
    val isLoading: Boolean = false,
    val isUpdating: Boolean = false,
    val user: User? = null,
    val error: String? = null
)
```

## 🔄 Coroutines Programming

### Structured Concurrency Best Practices

```kotlin
// ✅ Good: Proper coroutine scope usage
class UserService(
    private val userRepository: UserRepository,
    private val emailService: EmailService,
    private val coroutineScope: CoroutineScope = CoroutineScope(Dispatchers.IO + SupervisorJob())
) {
    
    suspend fun processUserRegistration(userData: UserRegistrationData): User {
        return withContext(Dispatchers.IO) {
            val user = userRepository.createUser(userData)
            
            // Launch independent email sending (fire and forget)
            coroutineScope.launch {
                try {
                    emailService.sendWelcomeEmail(user.email)
                } catch (e: Exception) {
                    // Log email sending failure, but don't fail user creation
                    logger.warn("Failed to send welcome email", e)
                }
            }
            
            user
        }
    }
    
    suspend fun getUsersWithProfiles(userIds: List<String>): List<UserWithProfile> {
        return withContext(Dispatchers.IO) {
            userIds.map { userId ->
                async {
                    val user = userRepository.findById(userId)
                    val profile = profileRepository.findByUserId(userId)
                    UserWithProfile(user, profile)
                }
            }.awaitAll()
        }
    }
}

// ✅ Good: Flow-based reactive programming
class UserRepository {
    fun observeUser(userId: String): Flow<User?> = flow {
        while (currentCoroutineContext().isActive) {
            val user = database.userDao().findById(userId)
            emit(user)
            delay(1000) // Poll every second
        }
    }.flowOn(Dispatchers.IO)
    
    fun searchUsers(query: String): Flow<List<User>> = 
        database.userDao()
            .searchUsers("%$query%")
            .map { entities -> entities.map { it.toDomain() } }
            .flowOn(Dispatchers.IO)
}
```

### Error Handling

```kotlin
// ✅ Custom error types
sealed class UserError : Exception() {
    data class ValidationError(val field: String, override val message: String) : UserError()
    data class UserNotFound(val userId: String) : UserError() {
        override val message = "User with ID $userId not found"
    }
    data class UserAlreadyExists(val email: String) : UserError() {
        override val message = "User with email $email already exists"
    }
    data class NetworkError(override val cause: Throwable) : UserError()
}

// ✅ Comprehensive error handling with Result
suspend fun updateUser(userId: String, updates: UserUpdates): Result<User> {
    return try {
        val existingUser = userRepository.findById(userId)
            ?: return Result.failure(UserError.UserNotFound(userId))
        
        val validatedUpdates = validateUserUpdates(updates)
            .getOrElse { return Result.failure(it) }
        
        val updatedUser = existingUser.copy(
            name = validatedUpdates.name ?: existingUser.name,
            email = validatedUpdates.email ?: existingUser.email
        )
        
        val savedUser = userRepository.save(updatedUser)
        Result.success(savedUser)
        
    } catch (e: Exception) {
        Result.failure(UserError.NetworkError(e))
    }
}
```

## 🛡️ Memory Management

### Efficient Resource Handling

```kotlin
// ✅ Proper resource management with use
fun readConfigFile(fileName: String): Properties {
    return Properties().apply {
        FileInputStream(fileName).use { input ->
            load(input)
        }
    }
}

// ✅ Lazy initialization for expensive operations
class DatabaseConnection {
    private val connectionPool by lazy {
        HikariDataSource().apply {
            jdbcUrl = config.databaseUrl
            username = config.username
            password = config.password
            maximumPoolSize = 10
        }
    }
    
    fun getConnection(): Connection = connectionPool.connection
}

// ✅ Memory-efficient collection processing
fun processLargeDataset(data: Sequence<DataItem>): List<ProcessedItem> {
    return data
        .filter { it.isValid() }
        .map { it.process() }
        .take(1000) // Limit results to prevent memory issues
        .toList()
}
```

## ⚡ Performance Optimization

### Efficient Code Patterns

```kotlin
// ✅ Use inline functions for higher-order functions
inline fun <T> measureTime(operation: () -> T): Pair<T, Long> {
    val startTime = System.currentTimeMillis()
    val result = operation()
    val endTime = System.currentTimeMillis()
    return result to (endTime - startTime)
}

// ✅ Efficient string building
fun buildComplexString(items: List<String>): String = buildString {
    append("Items: ")
    items.forEachIndexed { index, item ->
        if (index > 0) append(", ")
        append(item)
    }
}

// ❌ Bad: Inefficient string concatenation
fun buildStringBad(items: List<String>): String {
    var result = "Items: "
    items.forEachIndexed { index, item ->
        if (index > 0) result += ", "
        result += item
    }
    return result
}

// ✅ Good: Use sequences for large collections
fun processLargeList(items: List<Item>): List<ProcessedItem> {
    return items.asSequence()
        .filter { it.isActive }
        .map { it.process() }
        .filter { it.isValid }
        .toList()
}
```

## 🧪 Testing Guidelines

### Unit Testing Best Practices

```kotlin
class UserServiceTest {
    
    @MockK
    private lateinit var userRepository: UserRepository
    
    @MockK
    private lateinit var emailService: EmailService
    
    private lateinit var userService: UserService
    
    @BeforeEach
    fun setup() {
        MockKAnnotations.init(this)
        userService = UserService(userRepository, emailService)
    }
    
    @Test
    fun `registerUser should create user and send welcome email`() = runTest {
        // Given
        val userData = UserRegistrationData("test@example.com", "Test User")
        val expectedUser = User(
            id = UserId("123"),
            email = "test@example.com",
            name = "Test User",
            status = UserStatus.Active,
            createdAt = Instant.now()
        )
        
        coEvery { userRepository.findByEmail(userData.email) } returns null
        coEvery { userRepository.save(any()) } returns expectedUser
        coEvery { emailService.sendWelcomeEmail(any()) } just Runs
        
        // When
        val result = userService.registerUser(userData)
        
        // Then
        result.isSuccess shouldBe true
        result.getOrNull() shouldBe expectedUser
        
        coVerify { userRepository.save(any()) }
        coVerify { emailService.sendWelcomeEmail(expectedUser.email) }
    }
    
    @Test
    fun `registerUser should fail when user already exists`() = runTest {
        // Given
        val userData = UserRegistrationData("existing@example.com", "Existing User")
        val existingUser = User(
            id = UserId("456"),
            email = "existing@example.com",
            name = "Existing User",
            status = UserStatus.Active,
            createdAt = Instant.now()
        )
        
        coEvery { userRepository.findByEmail(userData.email) } returns existingUser
        
        // When
        val result = userService.registerUser(userData)
        
        // Then
        result.isFailure shouldBe true
        result.exceptionOrNull() shouldBe instanceOf<UserAlreadyExistsException>()
        
        coVerify(exactly = 0) { userRepository.save(any()) }
        coVerify(exactly = 0) { emailService.sendWelcomeEmail(any()) }
    }
}
```

### Integration Testing

```kotlin
@SpringBootTest
@Testcontainers
class UserRepositoryIntegrationTest {
    
    companion object {
        @Container
        val postgresContainer = PostgreSQLContainer<Nothing>("postgres:14").apply {
            withDatabaseName("testdb")
            withUsername("test")
            withPassword("test")
        }
    }
    
    @Autowired
    private lateinit var userRepository: UserRepository
    
    @Test
    fun `should save and retrieve user`() = runTest {
        // Given
        val user = User(
            id = UserId.generate(),
            email = "integration@test.com",
            name = "Integration Test",
            status = UserStatus.Active,
            createdAt = Instant.now()
        )
        
        // When
        val savedUser = userRepository.save(user)
        val retrievedUser = userRepository.findById(savedUser.id)
        
        // Then
        retrievedUser shouldNotBe null
        retrievedUser?.email shouldBe user.email
        retrievedUser?.name shouldBe user.name
    }
}
```

## 🛠️ Development Environment

### Recommended Configuration

```kotlin
// build.gradle.kts
plugins {
    kotlin("jvm") version "1.9.20"
    kotlin("plugin.serialization") version "1.9.20"
    id("org.jlleitschuh.gradle.ktlint") version "11.6.1"
    id("io.gitlab.arturbosch.detekt") version "1.23.3"
}

dependencies {
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.7.3")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.6.0")
    
    testImplementation("org.junit.jupiter:junit-jupiter:5.10.0")
    testImplementation("io.kotest:kotest-runner-junit5:5.7.2")
    testImplementation("io.mockk:mockk:1.13.8")
    testImplementation("org.jetbrains.kotlinx:kotlinx-coroutines-test:1.7.3")
}

ktlint {
    version.set("0.50.0")
    android.set(false)
    outputToConsole.set(true)
    coloredOutput.set(true)
}

detekt {
    toolVersion = "1.23.3"
    config.setFrom("$projectDir/config/detekt/detekt.yml")
    buildUponDefaultConfig = true
}
```

### Essential Tools
- **Formatter**: ktlint - Kotlin code formatter with consistent styling rules
- **Linter**: detekt - Static code analysis for Kotlin with customizable rules
- **Build Tool**: Gradle Kotlin DSL - Type-safe build scripts with IDE support
- **Package Manager**: Gradle - Comprehensive dependency management and build automation
- **Testing**: JUnit 5 + Kotest + MockK - Modern testing framework with powerful assertions

## 🔍 Code Quality Standards

### Static Analysis

```kotlin
// ✅ Clean, well-structured class
class UserService(
    private val userRepository: UserRepository,
    private val emailService: EmailService,
    private val validator: UserValidator
) {
    
    suspend fun createUser(request: CreateUserRequest): Result<User> {
        return validator.validate(request)
            .map { validatedRequest ->
                userRepository.save(validatedRequest.toUser())
            }
            .onSuccess { user ->
                emailService.sendWelcomeEmail(user.email)
            }
    }
}
```

### Documentation Standards

```kotlin
/**
 * Service responsible for user management operations.
 * 
 * This service handles user creation, updates, and deletion while maintaining
 * business rules and sending appropriate notifications.
 * 
 * @property userRepository Repository for user data persistence
 * @property emailService Service for sending user-related emails
 * @constructor Creates a UserService with the specified dependencies
 */
class UserService(
    private val userRepository: UserRepository,
    private val emailService: EmailService
) {
    
    /**
     * Creates a new user with the provided information.
     * 
     * Validates the user data, ensures the email is unique, creates the user,
     * and sends a welcome email.
     * 
     * @param userData The user information for registration
     * @return Result containing the created User or an error
     * @throws ValidationException if user data is invalid
     */
    suspend fun createUser(userData: UserCreationData): Result<User>
}
```

## 🚫 Common Pitfalls to Avoid

- **Overusing scope functions**: Don't chain multiple scope functions unnecessarily
- **Ignoring null safety**: Always handle nullable types explicitly
- **Blocking coroutines**: Avoid blocking calls in suspend functions
- **Memory leaks**: Properly cancel coroutines and clean up resources
- **Platform violations**: Don't perform long-running operations on the main thread

## 📚 Essential Libraries

### Standard Library
```kotlin
// Coroutines for asynchronous programming
import kotlinx.coroutines.*

// Serialization for JSON handling
import kotlinx.serialization.*

// Collections utilities
import kotlin.collections.*
```

### Recommended Third-Party Libraries
- **Ktor**: Modern HTTP client and server framework
- **Exposed**: Lightweight SQL library for Kotlin
- **Koin**: Lightweight dependency injection framework
- **Kotest**: Comprehensive testing framework with powerful matchers
- **Arrow**: Functional programming library with advanced type safety

## 🚦 AI Enforcement Summary

### Code Quality Rules
- ✅ Enforce immutable data classes and val over var
- ✅ Require null safety with proper null handling
- ✅ Block platform-specific Android code in shared modules
- ✅ Enforce camelCase naming for functions and variables
- ✅ Require KDoc documentation for public APIs
- ✅ Block inefficient string concatenation in loops
- ✅ Enforce proper coroutine scope usage
- ✅ Auto-fix import organization and formatting

### Performance Enforcement
- 🚫 Block blocking calls in coroutines (runBlocking in production)
- 🚫 Block inefficient collection operations on large datasets
- ✅ Promote lazy initialization for expensive resources
- ✅ Promote sequence usage for large collection processing

### Security Enforcement
- 🔒 Enforce input validation for user-provided data
- 🔒 Block hardcoded secrets and credentials
- 🔒 Require proper exception handling with specific types

## 📖 References

- [Kotlin Official Documentation](https://kotlinlang.org/docs/home.html)
- [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html)
- [Coroutines Best Practices](https://kotlinlang.org/docs/coroutines-best-practices.html)
- [Android Kotlin Style Guide](https://developer.android.com/kotlin/style-guide)
- [Effective Kotlin](https://kt.academy/book/effectivekotlin)