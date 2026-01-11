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