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