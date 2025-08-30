---
applyTo: "**/*.{swift}"
---

# Swift Programming Instructions

Comprehensive Swift development guidelines for AI coding assistants, emphasizing modern best practices, performance optimization, and maintainable code patterns.

## 🧠 Context

- **Language**: Swift (5.9+)
- **Environments**: iOS, iPadOS, macOS, watchOS, tvOS, Linux, Server-side
- **Common Frameworks**: SwiftUI, UIKit, Combine, Foundation, Core Data, Vapor, Alamofire
- **Package Managers**: Swift Package Manager, CocoaPods, Carthage
- **Build Tools**: Xcode, swift build, Bazel
- **Testing**: XCTest, Quick/Nimble, SnapshotTesting

## 📁 Project Structure

```text
Sources/
  App/
    Models/              # Data models and business logic
      User.swift
      Product.swift
    Views/              # SwiftUI views and UIKit view controllers
      ContentView.swift
      UserProfileView.swift
    ViewModels/         # MVVM view models and state management
      UserViewModel.swift
      ProductListViewModel.swift
    Services/           # Business logic and data services
      NetworkService.swift
      DataService.swift
    Utilities/          # Helper classes and extensions
      Extensions/
      Helpers/
    Resources/          # Assets, localizable strings, etc.
Tests/
  UnitTests/           # Unit tests for models and services
  IntegrationTests/    # Integration tests for complete flows
  UITests/            # UI automation tests
Package.swift          # Swift Package Manager configuration
```

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern Swift following established conventions
- Prioritize code safety with optionals and error handling
- Implement clear separation of concerns and modularity
- Use consistent formatting with SwiftLint and swift-format
- Follow the principle of protocol-oriented programming
- Leverage value types (structs, enums) over reference types when appropriate
- Prefer composition over inheritance for better flexibility

### Modern Language Features
- Use async/await for asynchronous programming
- Leverage property wrappers for clean, declarative code
- Employ result builders for domain-specific languages
- Utilize concurrency features with actors and TaskGroups
- Apply generics and associated types for type safety
- Use computed properties and property observers effectively

## 📜 Code Style and Conventions

### Naming Conventions

```swift
// ✅ Good: Use camelCase for variables and functions
let userName = "john_doe"
let userAge = 25

func calculateTotalPrice(for items: [Item]) -> Decimal {
    return items.reduce(0) { $0 + $1.price }
}

// ✅ Good: Use PascalCase for types
struct UserProfile {
    let name: String
    let email: String
}

enum NetworkResult<T> {
    case success(T)
    case failure(Error)
}

// ✅ Good: Use descriptive names
let isUserAuthenticated = true
let hasValidEmail = user.email.contains("@")
func findUser(by email: String) -> User?
```

### Function Design

```swift
// ✅ Good: Pure functions with clear inputs/outputs
func calculateDiscount(price: Decimal, discountPercent: Int) -> Decimal {
    return price * (Decimal(discountPercent) / 100)
}

// ✅ Good: Use documentation comments for public APIs
/// Processes user registration with validation and notification.
/// 
/// - Parameters:
///   - userData: The user information to register
///   - sendWelcomeEmail: Whether to send a welcome email
/// - Returns: The created user with generated ID
/// - Throws: `ValidationError` if user data is invalid, `UserAlreadyExistsError` if email exists
func registerUser(
    userData: UserRegistrationData,
    sendWelcomeEmail: Bool = true
) async throws -> User {
    try validateUserData(userData)
    let user = try await userRepository.createUser(userData)
    if sendWelcomeEmail {
        try await emailService.sendWelcomeEmail(to: user.email)
    }
    return user
}

// ✅ Good: Use extensions for protocol conformance
extension User: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, email, name, createdAt
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return self.range(of: emailRegex, options: .regularExpression) != nil
    }
}
```

## 🏗️ Architecture Patterns

### MVVM with SwiftUI

```swift
// ✅ Well-structured domain model
struct User: Identifiable, Codable {
    let id: UUID
    let email: String
    let name: String
    let status: UserStatus
    let createdAt: Date
    
    init(email: String, name: String) throws {
        guard email.isValidEmail else {
            throw ValidationError.invalidEmail
        }
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw ValidationError.invalidName
        }
        
        self.id = UUID()
        self.email = email
        self.name = name
        self.status = .active
        self.createdAt = Date()
    }
}

enum UserStatus: String, Codable, CaseIterable {
    case active = "active"
    case inactive = "inactive"
    case suspended = "suspended"
}

// Repository protocol (domain layer)
protocol UserRepository {
    func findUser(by id: UUID) async throws -> User?
    func findUser(by email: String) async throws -> User?
    func saveUser(_ user: User) async throws -> User
    func deleteUser(id: UUID) async throws
}

// Use case (domain layer)
@MainActor
class RegisterUserUseCase: ObservableObject {
    private let userRepository: UserRepository
    private let emailService: EmailService
    
    init(userRepository: UserRepository, emailService: EmailService) {
        self.userRepository = userRepository
        self.emailService = emailService
    }
    
    func execute(request: UserRegistrationRequest) async -> Result<User, RegistrationError> {
        do {
            // Check if user already exists
            let existingUser = try await userRepository.findUser(by: request.email)
            if existingUser != nil {
                return .failure(.userAlreadyExists)
            }
            
            // Create new user
            let user = try User(email: request.email, name: request.name)
            let savedUser = try await userRepository.saveUser(user)
            
            // Send welcome email
            try await emailService.sendWelcomeEmail(to: savedUser.email)
            
            return .success(savedUser)
        } catch {
            return .failure(.unknownError(error))
        }
    }
}
```

### SwiftUI View and ViewModel Pattern

```swift
// ✅ ViewModel with proper state management
@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getUserUseCase: GetUserUseCase
    private let updateUserUseCase: UpdateUserUseCase
    
    init(getUserUseCase: GetUserUseCase, updateUserUseCase: UpdateUserUseCase) {
        self.getUserUseCase = getUserUseCase
        self.updateUserUseCase = updateUserUseCase
    }
    
    func loadUser(id: UUID) {
        Task {
            isLoading = true
            errorMessage = nil
            
            let result = await getUserUseCase.execute(id: id)
            
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
    
    func updateUserName(_ newName: String) {
        guard var currentUser = user else { return }
        
        Task {
            isLoading = true
            
            currentUser.name = newName
            let result = await updateUserUseCase.execute(user: currentUser)
            
            switch result {
            case .success(let updatedUser):
                self.user = updatedUser
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
}

// SwiftUI View
struct UserProfileView: View {
    @StateObject private var viewModel: UserProfileViewModel
    let userId: UUID
    
    init(userId: UUID, getUserUseCase: GetUserUseCase, updateUserUseCase: UpdateUserUseCase) {
        self.userId = userId
        self._viewModel = StateObject(wrapping: UserProfileViewModel(
            getUserUseCase: getUserUseCase,
            updateUserUseCase: updateUserUseCase
        ))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let user = viewModel.user {
                    UserInfoView(user: user) { newName in
                        viewModel.updateUserName(newName)
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage) {
                        viewModel.loadUser(id: userId)
                    }
                }
            }
            .navigationTitle("User Profile")
            .onAppear {
                viewModel.loadUser(id: userId)
            }
        }
    }
}

struct UserInfoView: View {
    let user: User
    let onNameUpdate: (String) -> Void
    
    @State private var isEditingName = false
    @State private var editedName = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Name:")
                    .font(.headline)
                
                if isEditingName {
                    TextField("Enter name", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Save") {
                        onNameUpdate(editedName)
                        isEditingName = false
                    }
                    .disabled(editedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                } else {
                    Text(user.name)
                    
                    Button("Edit") {
                        editedName = user.name
                        isEditingName = true
                    }
                }
            }
            
            HStack {
                Text("Email:")
                    .font(.headline)
                Text(user.email)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("Status:")
                    .font(.headline)
                StatusBadge(status: user.status)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
```

## 🔄 Concurrency Programming

### Modern async/await Patterns

```swift
// ✅ Good: Proper async/await usage
class UserService {
    private let userRepository: UserRepository
    private let emailService: EmailService
    
    init(userRepository: UserRepository, emailService: EmailService) {
        self.userRepository = userRepository
        self.emailService = emailService
    }
    
    func processUserRegistration(userData: UserRegistrationData) async throws -> User {
        // Create user
        let user = try await userRepository.createUser(userData)
        
        // Send welcome email concurrently (fire and forget)
        Task.detached { [emailService] in
            do {
                try await emailService.sendWelcomeEmail(to: user.email)
            } catch {
                // Log email sending failure, but don't fail user creation
                print("Failed to send welcome email: \(error)")
            }
        }
        
        return user
    }
    
    func getUsersWithProfiles(userIds: [UUID]) async throws -> [UserWithProfile] {
        return try await withThrowingTaskGroup(of: UserWithProfile.self) { group in
            for userId in userIds {
                group.addTask {
                    async let user = self.userRepository.findUser(by: userId)
                    async let profile = self.profileRepository.findProfile(for: userId)
                    
                    return try await UserWithProfile(
                        user: user ?? User.placeholder,
                        profile: profile
                    )
                }
            }
            
            var results: [UserWithProfile] = []
            for try await result in group {
                results.append(result)
            }
            return results
        }
    }
}

// ✅ Good: Actor for thread-safe state management
actor UserCache {
    private var cache: [UUID: User] = [:]
    private let maxCacheSize = 1000
    
    func getUser(id: UUID) -> User? {
        return cache[id]
    }
    
    func setUser(_ user: User) {
        cache[user.id] = user
        
        // Remove oldest entries if cache is too large
        if cache.count > maxCacheSize {
            let oldestKeys = Array(cache.keys.prefix(cache.count - maxCacheSize))
            for key in oldestKeys {
                cache.removeValue(forKey: key)
            }
        }
    }
    
    func removeUser(id: UUID) {
        cache.removeValue(forKey: id)
    }
    
    func clear() {
        cache.removeAll()
    }
}
```

### Error Handling

```swift
// ✅ Custom error types with good user experience
enum UserError: LocalizedError {
    case validationError(ValidationError)
    case userNotFound(UUID)
    case userAlreadyExists(String)
    case networkError(Error)
    case unauthorized
    
    var errorDescription: String? {
        switch self {
        case .validationError(let validationError):
            return "Invalid input: \(validationError.localizedDescription)"
        case .userNotFound(let id):
            return "User with ID \(id) was not found"
        case .userAlreadyExists(let email):
            return "A user with email \(email) already exists"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unauthorized:
            return "You don't have permission to perform this action"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .validationError:
            return "Please check your input and try again"
        case .userNotFound:
            return "Please verify the user ID and try again"
        case .userAlreadyExists:
            return "Try logging in instead or use a different email"
        case .networkError:
            return "Please check your internet connection and try again"
        case .unauthorized:
            return "Please log in and try again"
        }
    }
}

enum ValidationError: LocalizedError {
    case invalidEmail
    case invalidName
    case passwordTooShort
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address"
        case .invalidName:
            return "Name cannot be empty"
        case .passwordTooShort:
            return "Password must be at least 8 characters long"
        }
    }
}

// ✅ Comprehensive error handling with Result type
func updateUser(id: UUID, updates: UserUpdates) async -> Result<User, UserError> {
    do {
        guard let existingUser = try await userRepository.findUser(by: id) else {
            return .failure(.userNotFound(id))
        }
        
        let validatedUpdates = try validateUserUpdates(updates)
        
        let updatedUser = User(
            id: existingUser.id,
            email: validatedUpdates.email ?? existingUser.email,
            name: validatedUpdates.name ?? existingUser.name,
            status: existingUser.status,
            createdAt: existingUser.createdAt
        )
        
        let savedUser = try await userRepository.saveUser(updatedUser)
        return .success(savedUser)
        
    } catch let validationError as ValidationError {
        return .failure(.validationError(validationError))
    } catch {
        return .failure(.networkError(error))
    }
}
```

## 🛡️ Memory Management

### Efficient Resource Handling

```swift
// ✅ Proper memory management with weak references
class NotificationService {
    private weak var delegate: NotificationDelegate?
    private var observations: [NSKeyValueObservation] = []
    
    init(delegate: NotificationDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        observations.forEach { $0.invalidate() }
    }
    
    func startObserving(user: User) {
        let observation = user.observe(\.status) { [weak self] user, _ in
            self?.delegate?.userStatusDidChange(user)
        }
        observations.append(observation)
    }
}

// ✅ Value types for immutable data
struct UserPreferences: Codable {
    let theme: Theme
    let notificationsEnabled: Bool
    let language: String
    
    func with(theme: Theme) -> UserPreferences {
        return UserPreferences(
            theme: theme,
            notificationsEnabled: notificationsEnabled,
            language: language
        )
    }
}

// ✅ Lazy initialization for expensive operations
class ImageCache {
    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 50 * 1024 * 1024 // 50MB
        cache.countLimit = 100
        return cache
    }()
    
    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
```

## ⚡ Performance Optimization

### Efficient Code Patterns

```swift
// ✅ Use lazy properties for expensive computations
struct UserProfileData {
    let user: User
    let posts: [Post]
    
    lazy var sortedPosts: [Post] = {
        return posts.sorted { $0.createdAt > $1.createdAt }
    }()
    
    lazy var postsByCategory: [Category: [Post]] = {
        return Dictionary(grouping: posts) { $0.category }
    }()
}

// ✅ Efficient collection operations
extension Array where Element == User {
    func filterByStatus(_ status: UserStatus) -> [User] {
        return self.filter { $0.status == status }
    }
    
    func groupByCreationMonth() -> [String: [User]] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        
        return Dictionary(grouping: self) { user in
            formatter.string(from: user.createdAt)
        }
    }
}

// ✅ Use computed properties instead of stored properties when appropriate
struct Circle {
    let radius: Double
    
    var area: Double {
        return .pi * radius * radius
    }
    
    var circumference: Double {
        return 2 * .pi * radius
    }
}

// ❌ Bad: Inefficient string concatenation
func buildUserListBad(users: [User]) -> String {
    var result = "Users: "
    for (index, user) in users.enumerated() {
        if index > 0 { result += ", " }
        result += user.name
    }
    return result
}

// ✅ Good: Efficient string building
func buildUserList(users: [User]) -> String {
    let names = users.map(\.name)
    return "Users: " + names.joined(separator: ", ")
}
```

## 🧪 Testing Guidelines

### Unit Testing Best Practices

```swift
import XCTest
@testable import App

class UserServiceTests: XCTestCase {
    var userService: UserService!
    var mockUserRepository: MockUserRepository!
    var mockEmailService: MockEmailService!
    
    override func setUp() {
        super.setUp()
        mockUserRepository = MockUserRepository()
        mockEmailService = MockEmailService()
        userService = UserService(
            userRepository: mockUserRepository,
            emailService: mockEmailService
        )
    }
    
    override func tearDown() {
        userService = nil
        mockUserRepository = nil
        mockEmailService = nil
        super.tearDown()
    }
    
    func testRegisterUser_Success() async throws {
        // Given
        let userData = UserRegistrationData(email: "test@example.com", name: "Test User")
        let expectedUser = User(
            id: UUID(),
            email: "test@example.com",
            name: "Test User",
            status: .active,
            createdAt: Date()
        )
        
        mockUserRepository.findUserByEmailResult = .success(nil)
        mockUserRepository.createUserResult = .success(expectedUser)
        mockEmailService.sendWelcomeEmailResult = .success(())
        
        // When
        let result = await userService.registerUser(userData: userData)
        
        // Then
        switch result {
        case .success(let user):
            XCTAssertEqual(user.email, expectedUser.email)
            XCTAssertEqual(user.name, expectedUser.name)
            XCTAssertEqual(user.status, .active)
        case .failure(let error):
            XCTFail("Expected success, got error: \(error)")
        }
        
        XCTAssertTrue(mockUserRepository.createUserCalled)
        XCTAssertTrue(mockEmailService.sendWelcomeEmailCalled)
    }
    
    func testRegisterUser_UserAlreadyExists() async throws {
        // Given
        let userData = UserRegistrationData(email: "existing@example.com", name: "Existing User")
        let existingUser = User(
            id: UUID(),
            email: "existing@example.com",
            name: "Existing User",
            status: .active,
            createdAt: Date()
        )
        
        mockUserRepository.findUserByEmailResult = .success(existingUser)
        
        // When
        let result = await userService.registerUser(userData: userData)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            if case .userAlreadyExists(let email) = error {
                XCTAssertEqual(email, "existing@example.com")
            } else {
                XCTFail("Expected userAlreadyExists error, got: \(error)")
            }
        }
        
        XCTAssertFalse(mockUserRepository.createUserCalled)
        XCTAssertFalse(mockEmailService.sendWelcomeEmailCalled)
    }
}

// Mock implementations
class MockUserRepository: UserRepository {
    var findUserByEmailResult: Result<User?, Error> = .success(nil)
    var createUserResult: Result<User, Error> = .failure(MockError.notImplemented)
    var createUserCalled = false
    
    func findUser(by email: String) async throws -> User? {
        switch findUserByEmailResult {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
    
    func createUser(_ userData: UserRegistrationData) async throws -> User {
        createUserCalled = true
        switch createUserResult {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
}

enum MockError: Error {
    case notImplemented
}
```

### SwiftUI Testing

```swift
import XCTest
import SwiftUI
@testable import App

class UserProfileViewTests: XCTestCase {
    func testUserProfileView_LoadsUserOnAppear() {
        // Given
        let mockGetUserUseCase = MockGetUserUseCase()
        let mockUpdateUserUseCase = MockUpdateUserUseCase()
        let userId = UUID()
        
        mockGetUserUseCase.executeResult = .success(User(
            id: userId,
            email: "test@example.com",
            name: "Test User",
            status: .active,
            createdAt: Date()
        ))
        
        // When
        let view = UserProfileView(
            userId: userId,
            getUserUseCase: mockGetUserUseCase,
            updateUserUseCase: mockUpdateUserUseCase
        )
        
        // Then
        let hostingController = UIHostingController(rootView: view)
        hostingController.loadViewIfNeeded()
        
        // Simulate view appearing
        hostingController.viewWillAppear(false)
        
        XCTAssertTrue(mockGetUserUseCase.executeCalled)
        XCTAssertEqual(mockGetUserUseCase.lastUsedId, userId)
    }
}
```

## 🛠️ Development Environment

### Recommended Configuration

```swift
// Package.swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MyApp",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        .library(name: "App", targets: ["App"]),
        .executable(name: "CLI", targets: ["CLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0"),
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.52.0"),
        .package(url: "https://github.com/Quick/Quick.git", from: "7.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: ["Alamofire"],
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                "App",
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble")
            ]
        )
    ]
)
```

### Essential Tools
- **Formatter**: swift-format - Official Swift code formatter
- **Linter**: SwiftLint - Comprehensive Swift linting with customizable rules
- **Build Tool**: Xcode / swift build - Native Swift build tools
- **Package Manager**: Swift Package Manager - Native dependency management
- **Testing**: XCTest + Quick/Nimble - Comprehensive testing framework

## 🔍 Code Quality Standards

### Static Analysis

```swift
// ✅ Clean, well-structured class
final class UserService {
    private let userRepository: UserRepository
    private let emailService: EmailService
    private let validator: UserValidator
    
    init(
        userRepository: UserRepository,
        emailService: EmailService,
        validator: UserValidator
    ) {
        self.userRepository = userRepository
        self.emailService = emailService
        self.validator = validator
    }
    
    func createUser(request: CreateUserRequest) async -> Result<User, UserError> {
        do {
            try validator.validate(request)
            let user = try await userRepository.save(request.toUser())
            try await emailService.sendWelcomeEmail(to: user.email)
            return .success(user)
        } catch let error as ValidationError {
            return .failure(.validationError(error))
        } catch {
            return .failure(.unknownError(error))
        }
    }
}
```

### Documentation Standards

```swift
/// Service responsible for user management operations.
/// 
/// This service handles user creation, updates, and deletion while maintaining
/// business rules and sending appropriate notifications.
/// 
/// - Important: All operations are performed asynchronously and may throw errors.
/// - Note: Email sending is performed asynchronously and won't block user creation.
final class UserService {
    /// Repository for user data persistence
    private let userRepository: UserRepository
    
    /// Service for sending user-related emails
    private let emailService: EmailService
    
    /// Creates a UserService with the specified dependencies
    /// - Parameters:
    ///   - userRepository: Repository for user data operations
    ///   - emailService: Service for email operations
    init(userRepository: UserRepository, emailService: EmailService) {
        self.userRepository = userRepository
        self.emailService = emailService
    }
    
    /// Creates a new user with the provided information.
    /// 
    /// Validates the user data, ensures the email is unique, creates the user,
    /// and sends a welcome email.
    /// 
    /// - Parameter userData: The user information for registration
    /// - Returns: Result containing the created User or a UserError
    /// - Throws: Never throws directly, but returns errors in Result type
    func createUser(userData: UserCreationData) async -> Result<User, UserError> {
        // Implementation...
    }
}
```

## 🚫 Common Pitfalls to Avoid

- **Force unwrapping**: Avoid using `!` except in truly safe scenarios
- **Retain cycles**: Be careful with strong references in closures
- **Blocking the main thread**: Never perform long-running operations on the main queue
- **Ignoring optionals**: Always handle optional values explicitly
- **Over-using classes**: Prefer structs and value types when possible

## 📚 Essential Libraries

### Standard Library
```swift
// Foundation for basic data types and utilities
import Foundation

// Combine for reactive programming
import Combine

// SwiftUI for declarative UI
import SwiftUI
```

### Recommended Third-Party Libraries
- **Alamofire**: Modern HTTP networking library
- **SwiftLint**: Code style and consistency enforcement
- **Quick/Nimble**: Behavior-driven development testing framework
- **SnapKit**: Auto Layout DSL for programmatic UI
- **Kingfisher**: Image downloading and caching library

## 🚦 AI Enforcement Summary

### Code Quality Rules
- ✅ Enforce immutable properties with `let` over `var`
- ✅ Require proper optional handling without force unwrapping
- ✅ Block retain cycles in closures
- ✅ Enforce PascalCase naming for types and camelCase for variables
- ✅ Require documentation for public APIs
- ✅ Block blocking operations on main thread
- ✅ Enforce proper error handling with Result types
- ✅ Auto-fix import organization and formatting

### Performance Enforcement
- 🚫 Block inefficient string concatenation in loops
- 🚫 Block retain cycles and memory leaks
- ✅ Promote lazy initialization for expensive operations
- ✅ Promote value types over reference types when appropriate

### Security Enforcement
- 🔒 Enforce input validation for user-provided data
- 🔒 Block hardcoded secrets and credentials
- 🔒 Require proper keychain usage for sensitive data

## 📖 References

- [Swift Official Documentation](https://docs.swift.org/swift-book/)
- [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- [SwiftUI Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/swiftui)
- [Swift Concurrency Documentation](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
- [Swift Package Manager Guide](https://swift.org/package-manager/)