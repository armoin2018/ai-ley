// ✅ Use appropriate collection types for performance
public Map<String, List<User>> groupUsersByDepartment(List<User> users) {
    return users.stream()
            .collect(Collectors.groupingBy(
                User::getDepartment,
                LinkedHashMap::new,  // Preserve insertion order
                Collectors.toList()
            ));
}

// ✅ Lazy initialization for expensive operations
public class ExpensiveResourceManager {
    private volatile ExpensiveResource resource;
    
    public ExpensiveResource getResource() {
        if (resource == null) {
            synchronized (this) {
                if (resource == null) {
                    resource = new ExpensiveResource();
                }
            }
        }
        return resource;
    }
}

// ❌ Bad: Inefficient string concatenation in loops
public String buildReport(List<User> users) {
    String report = "";
    for (User user : users) {
        report += user.getName() + ", ";  // Creates new string each iteration
    }
    return report;
}

// ✅ Good: Use StringBuilder for string concatenation
public String buildReport(List<User> users) {
    StringBuilder report = new StringBuilder();
    users.forEach(user -> report.append(user.getName()).append(", "));
    return report.toString();
}

// ✅ Even better: Use streams and joining
public String buildReport(List<User> users) {
    return users.stream()
            .map(User::getName)
            .collect(Collectors.joining(", "));
}