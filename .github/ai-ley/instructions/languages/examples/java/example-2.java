// ✅ Good: Use camelCase for variables and methods
String userName = "john_doe";
int orderCount = 42;
boolean isActive = true;

public void processOrder(Order order) { }
public Optional<User> findUserById(long id) { }

// ✅ Good: Use PascalCase for classes and interfaces
public class UserService { }
public interface OrderRepository { }
public enum UserStatus { ACTIVE, INACTIVE, SUSPENDED }

// ✅ Good: Use UPPER_SNAKE_CASE for constants
public static final int MAX_RETRY_COUNT = 3;
public static final String DEFAULT_ENCODING = "UTF-8";
private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);

// ✅ Good: Use descriptive names
List<User> activeUsers = findActiveUsers();
Map<String, Integer> userCountByDepartment = calculateUserStats();