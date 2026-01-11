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