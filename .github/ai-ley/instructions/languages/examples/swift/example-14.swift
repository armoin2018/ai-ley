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