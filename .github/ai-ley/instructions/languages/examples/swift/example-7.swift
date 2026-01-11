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