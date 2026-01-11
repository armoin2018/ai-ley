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