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