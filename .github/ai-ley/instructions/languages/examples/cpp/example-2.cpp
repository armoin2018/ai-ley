// ✅ Good: Use snake_case for variables and functions
int user_count = 0;
bool is_valid = true;
void process_user_data(const User& user);

// ✅ Good: Use PascalCase for classes, structs, and enums
class UserManager {
    // Class implementation
};

struct ConnectionConfig {
    std::string host;
    int port;
};

enum class StatusCode {
    Success,
    InvalidInput,
    NetworkError
};

// ✅ Good: Use UPPER_SNAKE_CASE for constants and macros
constexpr int MAX_CONNECTIONS = 100;
constexpr double PI = 3.14159265359;

// ✅ Good: Use descriptive names that express intent
auto connection_timeout = std::chrono::seconds{30};
auto filtered_users = users | std::views::filter(is_active);