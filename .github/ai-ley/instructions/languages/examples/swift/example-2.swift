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