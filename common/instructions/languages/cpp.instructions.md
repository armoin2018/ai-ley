---
applyTo: "**/*.cpp,**/*.hpp,**/*.cc,**/*.cxx,**/*.h"
---

# C++ Programming Instructions

Comprehensive C++ development guidelines for AI coding assistants, emphasizing modern C++ best practices, RAII principles, performance optimization, and maintainable code patterns.

## 🧠 Context

- **Language**: C++ (C++17/C++20 preferred, C++23 features where available)
- **Environments**: Native binaries, embedded systems, high-performance computing, game engines
- **Common Frameworks**: STL, Boost, Qt, FLTK, wxWidgets, Unreal Engine, Godot
- **Package Managers**: Conan, vcpkg, CPM.cmake
- **Build Tools**: CMake, Bazel, Make, Ninja, MSBuild
- **Testing**: Google Test, Catch2, doctest, Boost.Test

## 📁 Project Structure

```text
project_root/
├── include/                  # Public headers
│   └── project_name/        # Namespaced public API
│       ├── core/            # Core functionality headers
│       ├── utils/           # Utility headers
│       └── config.hpp       # Configuration constants
├── src/                     # Implementation files
│   ├── core/               # Core implementation
│   ├── utils/              # Utility implementations
│   ├── detail/             # Private implementation details
│   └── main.cpp            # Application entry point
├── tests/                   # Test files
│   ├── unit/               # Unit tests
│   ├── integration/        # Integration tests
│   └── benchmarks/         # Performance benchmarks
├── examples/               # Usage examples
├── docs/                   # Documentation
├── cmake/                  # CMake modules and scripts
├── third_party/           # External dependencies
├── build/                 # Build artifacts (git-ignored)
└── CMakeLists.txt         # Root build configuration
```

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern C++ following C++ Core Guidelines
- Prioritize RAII (Resource Acquisition Is Initialization) for all resource management
- Implement clear separation of concerns and modular design
- Use consistent formatting with clang-format
- Follow the principle of least surprise and explicit intent
- Prefer composition over inheritance
- Embrace zero-cost abstractions and compile-time computation

### Modern C++ Features
- Use `auto` for type deduction where it improves readability
- Prefer range-based for loops over traditional iterator loops
- Leverage lambda expressions for local functionality and algorithms
- Use structured bindings (C++17) for multiple return values
- Utilize `std::optional` and `std::variant` for safer nullable and union types
- Apply `constexpr` and `consteval` for compile-time evaluation
- Use concepts (C++20) for template constraints and better error messages

## 📜 Code Style and Conventions

### Naming Conventions

```cpp
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
```

### Function Design

```cpp
// ✅ Good: Pure functions with clear inputs/outputs
[[nodiscard]] constexpr double calculate_circle_area(double radius) noexcept {
    return PI * radius * radius;
}

// ✅ Good: Use Doxygen-style documentation
/**
 * @brief Validates user credentials against the authentication service
 * @param username The username to validate (must not be empty)
 * @param password The password to check (must meet complexity requirements)
 * @return Authentication result with user details or error information
 * @throws std::invalid_argument if username is empty
 * @throws NetworkException if authentication service is unavailable
 */
[[nodiscard]] AuthResult authenticate_user(const std::string& username, 
                                         const std::string& password);

// ✅ Good: Use modern function syntax and attributes
template<typename T>
[[nodiscard]] constexpr auto clamp_value(T value, T min_val, T max_val) noexcept -> T {
    return std::max(min_val, std::min(value, max_val));
}
```

## 🏗️ Architecture Patterns

### RAII and Resource Management

```cpp
// ✅ Well-structured RAII resource manager
class DatabaseConnection {
private:
    std::unique_ptr<ConnectionHandle> handle_;
    std::atomic<bool> is_connected_{false};
    
public:
    explicit DatabaseConnection(const ConnectionConfig& config) 
        : handle_(std::make_unique<ConnectionHandle>(config)) {
        if (!handle_->connect()) {
            throw ConnectionException("Failed to establish database connection");
        }
        is_connected_ = true;
    }
    
    // Explicitly delete copy operations for unique resource
    DatabaseConnection(const DatabaseConnection&) = delete;
    DatabaseConnection& operator=(const DatabaseConnection&) = delete;
    
    // Enable move operations for transferring ownership
    DatabaseConnection(DatabaseConnection&& other) noexcept 
        : handle_(std::move(other.handle_)), 
          is_connected_(other.is_connected_.load()) {
        other.is_connected_ = false;
    }
    
    DatabaseConnection& operator=(DatabaseConnection&& other) noexcept {
        if (this != &other) {
            handle_ = std::move(other.handle_);
            is_connected_ = other.is_connected_.load();
            other.is_connected_ = false;
        }
        return *this;
    }
    
    ~DatabaseConnection() {
        if (is_connected_ && handle_) {
            handle_->disconnect();
        }
    }
    
    [[nodiscard]] bool is_connected() const noexcept {
        return is_connected_.load();
    }
    
    QueryResult execute_query(const std::string& query) {
        if (!is_connected()) {
            throw std::runtime_error("Connection is not active");
        }
        return handle_->execute(query);
    }
};
```

### Smart Pointer Management

```cpp
// ✅ Comprehensive smart pointer usage patterns
class ServiceManager {
private:
    std::unique_ptr<Logger> logger_;                    // Exclusive ownership
    std::shared_ptr<ConfigManager> config_;             // Shared ownership
    std::weak_ptr<EventBus> event_bus_;                 // Non-owning observer
    std::vector<std::unique_ptr<Service>> services_;    // Container of owned resources
    
public:
    explicit ServiceManager(std::shared_ptr<ConfigManager> config,
                          std::weak_ptr<EventBus> event_bus)
        : logger_(std::make_unique<Logger>("ServiceManager")),
          config_(std::move(config)),
          event_bus_(std::move(event_bus)) {}
    
    template<typename ServiceType, typename... Args>
    ServiceType& add_service(Args&&... args) {
        static_assert(std::is_base_of_v<Service, ServiceType>, 
                     "ServiceType must inherit from Service");
        
        auto service = std::make_unique<ServiceType>(std::forward<Args>(args)...);
        auto& ref = *service;
        services_.push_back(std::move(service));
        
        logger_->info("Added service: {}", typeid(ServiceType).name());
        return ref;
    }
    
    void initialize_all() {
        for (auto& service : services_) {
            service->initialize(*config_);
        }
        
        // Safe weak_ptr usage
        if (auto event_bus = event_bus_.lock()) {
            event_bus->publish(ServiceManagerEvent::AllServicesInitialized);
        }
    }
};
```

## 🔄 Concurrency and Threading

### Thread-Safe Programming Best Practices

```cpp
// ✅ Good: Thread-safe singleton with proper initialization
class ApplicationConfig {
private:
    static std::once_flag initialized_;
    static std::unique_ptr<ApplicationConfig> instance_;
    
    mutable std::shared_mutex config_mutex_;
    std::unordered_map<std::string, std::string> settings_;
    
    ApplicationConfig() = default;
    
public:
    static ApplicationConfig& get_instance() {
        std::call_once(initialized_, []() {
            instance_ = std::unique_ptr<ApplicationConfig>(new ApplicationConfig());
        });
        return *instance_;
    }
    
    [[nodiscard]] std::string get_setting(const std::string& key) const {
        std::shared_lock lock(config_mutex_);
        if (auto it = settings_.find(key); it != settings_.end()) {
            return it->second;
        }
        return {};
    }
    
    void set_setting(const std::string& key, const std::string& value) {
        std::unique_lock lock(config_mutex_);
        settings_[key] = value;
    }
    
    [[nodiscard]] std::unordered_map<std::string, std::string> get_all_settings() const {
        std::shared_lock lock(config_mutex_);
        return settings_; // Copy while holding lock
    }
};

// ✅ Good: Thread-safe queue with modern concurrency primitives
template<typename T>
class ThreadSafeQueue {
private:
    mutable std::mutex mutex_;
    std::queue<T> queue_;
    std::condition_variable condition_;
    std::atomic<bool> shutdown_{false};
    
public:
    void push(T item) {
        std::lock_guard lock(mutex_);
        if (shutdown_.load()) {
            throw std::runtime_error("Queue is shutdown");
        }
        queue_.push(std::move(item));
        condition_.notify_one();
    }
    
    [[nodiscard]] std::optional<T> try_pop() {
        std::lock_guard lock(mutex_);
        if (queue_.empty()) {
            return std::nullopt;
        }
        auto item = std::move(queue_.front());
        queue_.pop();
        return item;
    }
    
    [[nodiscard]] std::optional<T> wait_and_pop(std::chrono::milliseconds timeout = std::chrono::milliseconds::max()) {
        std::unique_lock lock(mutex_);
        
        bool success = condition_.wait_for(lock, timeout, [this] {
            return !queue_.empty() || shutdown_.load();
        });
        
        if (!success || (queue_.empty() && shutdown_.load())) {
            return std::nullopt;
        }
        
        auto item = std::move(queue_.front());
        queue_.pop();
        return item;
    }
    
    void shutdown() {
        {
            std::lock_guard lock(mutex_);
            shutdown_ = true;
        }
        condition_.notify_all();
    }
    
    [[nodiscard]] size_t size() const {
        std::lock_guard lock(mutex_);
        return queue_.size();
    }
    
    [[nodiscard]] bool empty() const {
        std::lock_guard lock(mutex_);
        return queue_.empty();
    }
};

// ✅ Good: Async task execution with futures and thread pools
class AsyncTaskManager {
private:
    std::vector<std::thread> workers_;
    ThreadSafeQueue<std::function<void()>> tasks_;
    std::atomic<bool> running_{true};
    
public:
    explicit AsyncTaskManager(size_t thread_count = std::thread::hardware_concurrency()) {
        for (size_t i = 0; i < thread_count; ++i) {
            workers_.emplace_back([this] { worker_loop(); });
        }
    }
    
    ~AsyncTaskManager() {
        shutdown();
    }
    
    template<typename Func, typename... Args>
    [[nodiscard]] auto submit(Func&& func, Args&&... args) 
        -> std::future<std::invoke_result_t<Func, Args...>> {
        using ReturnType = std::invoke_result_t<Func, Args...>;
        
        auto task = std::make_shared<std::packaged_task<ReturnType()>>(
            std::bind(std::forward<Func>(func), std::forward<Args>(args)...)
        );
        
        auto future = task->get_future();
        
        tasks_.push([task] { (*task)(); });
        
        return future;
    }
    
    void shutdown() {
        running_ = false;
        tasks_.shutdown();
        
        for (auto& worker : workers_) {
            if (worker.joinable()) {
                worker.join();
            }
        }
    }
    
private:
    void worker_loop() {
        while (running_) {
            if (auto task = tasks_.wait_and_pop(std::chrono::milliseconds{100})) {
                try {
                    (*task)();
                } catch (const std::exception& e) {
                    // Log error but don't let it crash the worker
                    std::cerr << "Task execution error: " << e.what() << std::endl;
                }
            }
        }
    }
};
```

### Error Handling

```cpp
// ✅ Custom exception hierarchy with detailed error information
class ApplicationException : public std::exception {
private:
    std::string message_;
    std::string component_;
    int error_code_;
    
public:
    ApplicationException(std::string message, std::string component, int code = 0)
        : message_(std::move(message)), component_(std::move(component)), error_code_(code) {}
    
    [[nodiscard]] const char* what() const noexcept override {
        return message_.c_str();
    }
    
    [[nodiscard]] const std::string& component() const noexcept { return component_; }
    [[nodiscard]] int error_code() const noexcept { return error_code_; }
};

class NetworkException : public ApplicationException {
public:
    NetworkException(const std::string& message, int code = 0)
        : ApplicationException(message, "Network", code) {}
};

class ValidationException : public ApplicationException {
public:
    ValidationException(const std::string& message, const std::string& field)
        : ApplicationException(message, "Validation"), field_(field) {}
    
    [[nodiscard]] const std::string& field() const noexcept { return field_; }
    
private:
    std::string field_;
};

// ✅ Result type for error handling without exceptions
template<typename T, typename E = std::string>
class Result {
private:
    std::variant<T, E> data_;
    
public:
    template<typename U>
    Result(U&& value) : data_(std::forward<U>(value)) {}
    
    [[nodiscard]] bool is_success() const noexcept {
        return std::holds_alternative<T>(data_);
    }
    
    [[nodiscard]] bool is_error() const noexcept {
        return std::holds_alternative<E>(data_);
    }
    
    [[nodiscard]] const T& value() const& {
        if (is_error()) {
            throw std::runtime_error("Attempted to access value of error result");
        }
        return std::get<T>(data_);
    }
    
    [[nodiscard]] T&& value() && {
        if (is_error()) {
            throw std::runtime_error("Attempted to access value of error result");
        }
        return std::get<T>(std::move(data_));
    }
    
    [[nodiscard]] const E& error() const& {
        if (is_success()) {
            throw std::runtime_error("Attempted to access error of success result");
        }
        return std::get<E>(data_);
    }
    
    template<typename F>
    auto and_then(F&& func) -> Result<std::invoke_result_t<F, T>, E> {
        if (is_success()) {
            return func(value());
        }
        return Result<std::invoke_result_t<F, T>, E>(error());
    }
    
    template<typename F>
    auto or_else(F&& func) -> Result<T, std::invoke_result_t<F, E>> {
        if (is_error()) {
            return func(error());
        }
        return Result<T, std::invoke_result_t<F, E>>(value());
    }
};

template<typename T, typename E>
[[nodiscard]] Result<T, E> make_success(T&& value) {
    return Result<T, E>(std::forward<T>(value));
}

template<typename T, typename E>
[[nodiscard]] Result<T, E> make_error(E&& error) {
    return Result<T, E>(std::forward<E>(error));
}
```

## ⚡ Performance Optimization

### Efficient Code Patterns

```cpp
// ✅ String building optimization
std::string build_query(const std::vector<std::string>& fields, const std::string& table) {
    if (fields.empty()) {
        return {};
    }
    
    // Pre-calculate required capacity
    size_t total_size = 14; // "SELECT  FROM " 
    total_size += table.size();
    for (const auto& field : fields) {
        total_size += field.size() + 2; // field + ", "
    }
    
    std::string query;
    query.reserve(total_size);
    
    query = "SELECT ";
    
    // Use efficient joining
    bool first = true;
    for (const auto& field : fields) {
        if (!first) {
            query += ", ";
        }
        query += field;
        first = false;
    }
    
    query += " FROM ";
    query += table;
    
    return query;
}

// ✅ Container optimization patterns
template<typename Container, typename Predicate>
[[nodiscard]] auto filter_and_transform(const Container& container, Predicate&& pred) {
    using ValueType = typename Container::value_type;
    using ResultType = std::vector<ValueType>;
    
    ResultType result;
    result.reserve(container.size()); // Pre-allocate for best case
    
    std::copy_if(container.begin(), container.end(), 
                 std::back_inserter(result), 
                 std::forward<Predicate>(pred));
    
    result.shrink_to_fit(); // Release unused capacity
    return result;
}

// ✅ Move semantics optimization
class DataProcessor {
private:
    std::vector<std::string> data_;
    
public:
    // Accept by value and move - optimal for various call scenarios
    void add_data(std::string value) {
        data_.push_back(std::move(value));
    }
    
    // Perfect forwarding for in-place construction
    template<typename... Args>
    void emplace_data(Args&&... args) {
        data_.emplace_back(std::forward<Args>(args)...);
    }
    
    // Return by value with move semantics
    [[nodiscard]] std::vector<std::string> extract_data() && {
        return std::move(data_);
    }
    
    // Const reference for read-only access
    [[nodiscard]] const std::vector<std::string>& get_data() const& {
        return data_;
    }
    
    // Deleted rvalue reference for safety
    const std::vector<std::string>& get_data() const&& = delete;
};

// ❌ Bad: Inefficient string concatenation in loops
std::string bad_build_csv(const std::vector<std::string>& values) {
    std::string result;
    for (const auto& value : values) {
        result += value + ","; // Multiple allocations
    }
    return result;
}

// ✅ Good: Efficient string building with pre-allocation
std::string good_build_csv(const std::vector<std::string>& values) {
    if (values.empty()) return {};
    
    size_t total_size = std::accumulate(values.begin(), values.end(), size_t{0},
        [](size_t sum, const std::string& s) { return sum + s.size() + 1; });
    
    std::string result;
    result.reserve(total_size);
    
    for (size_t i = 0; i < values.size(); ++i) {
        if (i > 0) result += ',';
        result += values[i];
    }
    
    return result;
}
```

## 🧪 Testing Guidelines

### Comprehensive Testing with Google Test

```cpp
// test_user_service.cpp
#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include "user_service.hpp"

class MockUserRepository : public UserRepository {
public:
    MOCK_METHOD(std::optional<User>, find_by_id, (int id), (const, override));
    MOCK_METHOD(bool, save, (const User& user), (override));
    MOCK_METHOD(std::vector<User>, find_all, (), (const, override));
    MOCK_METHOD(bool, delete_by_id, (int id), (override));
};

class MockLogger : public Logger {
public:
    MOCK_METHOD(void, info, (const std::string& message), (override));
    MOCK_METHOD(void, error, (const std::string& message), (override));
    MOCK_METHOD(void, debug, (const std::string& message), (override));
};

class UserServiceTest : public ::testing::Test {
protected:
    void SetUp() override {
        mock_repository_ = std::make_shared<MockUserRepository>();
        mock_logger_ = std::make_shared<MockLogger>();
        user_service_ = std::make_unique<UserService>(mock_repository_, mock_logger_);
    }
    
    void TearDown() override {
        // Cleanup if needed
    }
    
    std::shared_ptr<MockUserRepository> mock_repository_;
    std::shared_ptr<MockLogger> mock_logger_;
    std::unique_ptr<UserService> user_service_;
};

TEST_F(UserServiceTest, GetUser_ExistingUser_ReturnsUser) {
    // Arrange
    const User expected_user{1, "John Doe", "john@example.com"};
    EXPECT_CALL(*mock_repository_, find_by_id(1))
        .WillOnce(::testing::Return(expected_user));
    
    // Act
    auto result = user_service_->get_user(1);
    
    // Assert
    ASSERT_TRUE(result.has_value());
    EXPECT_EQ(result->get_id(), 1);
    EXPECT_EQ(result->get_name(), "John Doe");
    EXPECT_EQ(result->get_email(), "john@example.com");
}

TEST_F(UserServiceTest, GetUser_NonExistentUser_ReturnsNullopt) {
    // Arrange
    EXPECT_CALL(*mock_repository_, find_by_id(999))
        .WillOnce(::testing::Return(std::nullopt));
    
    // Act
    auto result = user_service_->get_user(999);
    
    // Assert
    EXPECT_FALSE(result.has_value());
}

TEST_F(UserServiceTest, CreateUser_ValidUser_LogsSuccessAndReturnsTrue) {
    // Arrange
    const User new_user{0, "Jane Doe", "jane@example.com"};
    EXPECT_CALL(*mock_repository_, save(::testing::_))
        .WillOnce(::testing::Return(true));
    EXPECT_CALL(*mock_logger_, info(::testing::HasSubstr("User created successfully")));
    
    // Act
    bool result = user_service_->create_user(new_user);
    
    // Assert
    EXPECT_TRUE(result);
}

// ✅ Parameterized testing for multiple scenarios
class EmailValidationTest : public ::testing::TestWithParam<std::pair<std::string, bool>> {};

INSTANTIATE_TEST_SUITE_P(
    ValidAndInvalidEmails,
    EmailValidationTest,
    ::testing::Values(
        std::make_pair("user@example.com", true),
        std::make_pair("test.email@domain.co.uk", true),
        std::make_pair("valid+email@test.org", true),
        std::make_pair("invalid.email", false),
        std::make_pair("@invalid.com", false),
        std::make_pair("user@", false)
    )
);

TEST_P(EmailValidationTest, ValidateEmail_VariousInputs_ReturnsExpectedResult) {
    auto [email, expected_valid] = GetParam();
    EXPECT_EQ(is_valid_email(email), expected_valid) 
        << "Email: " << email << " should be " << (expected_valid ? "valid" : "invalid");
}

// ✅ Performance benchmarking
class PerformanceTest : public ::testing::Test {
protected:
    static constexpr size_t LARGE_SIZE = 10000;
    
    std::vector<std::string> generate_test_data(size_t size) {
        std::vector<std::string> data;
        data.reserve(size);
        for (size_t i = 0; i < size; ++i) {
            data.push_back("test_string_" + std::to_string(i));
        }
        return data;
    }
};

TEST_F(PerformanceTest, StringBuilding_LargeDataSet_CompletesWithinTimeLimit) {
    auto test_data = generate_test_data(LARGE_SIZE);
    
    auto start = std::chrono::high_resolution_clock::now();
    auto result = good_build_csv(test_data);
    auto end = std::chrono::high_resolution_clock::now();
    
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
    
    EXPECT_LT(duration.count(), 100) << "String building took too long: " << duration.count() << "ms";
    EXPECT_FALSE(result.empty());
}
```

## 🛠️ Development Environment

### CMake Configuration Best Practices

```cmake
# CMakeLists.txt - Modern CMake practices
cmake_minimum_required(VERSION 3.20)

project(ModernCppProject 
    VERSION 1.0.0
    DESCRIPTION "A modern C++ project following best practices"
    LANGUAGES CXX
)

# Set C++ standard and compiler requirements
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Enable modern CMake features
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# Compiler-specific options
if(MSVC)
    add_compile_options(/W4 /WX /permissive-)
    add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
else()
    add_compile_options(-Wall -Wextra -Wpedantic -Werror)
    
    # Additional GCC/Clang warnings
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        add_compile_options(-Wduplicated-cond -Wduplicated-branches -Wlogical-op)
    endif()
    
    if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        add_compile_options(-Wlifetime -Wthread-safety)
    endif()
endif()

# Build types and configurations
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS_DEBUG "-g -O0 -DDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG")

# Find required packages
find_package(Threads REQUIRED)

# Optional packages
find_package(Boost QUIET COMPONENTS system filesystem)
find_package(fmt QUIET)

# Main library target
add_library(${PROJECT_NAME}_lib
    src/user_service.cpp
    src/database_connection.cpp
    src/async_task_manager.cpp
    src/thread_safe_queue.cpp
)

# Modern target-based configuration
target_include_directories(${PROJECT_NAME}_lib
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        src
)

target_compile_features(${PROJECT_NAME}_lib
    PUBLIC cxx_std_20
)

target_link_libraries(${PROJECT_NAME}_lib
    PUBLIC
        Threads::Threads
    PRIVATE
        $<$<TARGET_EXISTS:Boost::system>:Boost::system>
        $<$<TARGET_EXISTS:fmt::fmt>:fmt::fmt>
)

# Executable
add_executable(${PROJECT_NAME}
    src/main.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE ${PROJECT_NAME}_lib
)

# Testing
option(BUILD_TESTING "Build tests" ON)
if(BUILD_TESTING)
    enable_testing()
    
    find_package(GTest REQUIRED)
    
    add_executable(${PROJECT_NAME}_tests
        tests/test_user_service.cpp
        tests/test_database_connection.cpp
        tests/test_thread_safe_queue.cpp
    )
    
    target_link_libraries(${PROJECT_NAME}_tests
        PRIVATE
            ${PROJECT_NAME}_lib
            GTest::gtest_main
            GTest::gmock
    )
    
    include(GoogleTest)
    gtest_discover_tests(${PROJECT_NAME}_tests)
endif()

# Static analysis
option(ENABLE_STATIC_ANALYSIS "Enable static analysis tools" OFF)
if(ENABLE_STATIC_ANALYSIS)
    find_program(CLANG_TIDY_EXE NAMES clang-tidy)
    if(CLANG_TIDY_EXE)
        set_target_properties(${PROJECT_NAME}_lib PROPERTIES
            CXX_CLANG_TIDY "${CLANG_TIDY_EXE};-checks=*,-fuchsia-*,-google-*,-zircon-*,-abseil-*,-llvm-*"
        )
    endif()
    
    find_program(CPPCHECK_EXE NAMES cppcheck)
    if(CPPCHECK_EXE)
        set_target_properties(${PROJECT_NAME}_lib PROPERTIES
            CXX_CPPCHECK "${CPPCHECK_EXE};--enable=warning,performance,portability"
        )
    endif()
endif()

# Installation
install(TARGETS ${PROJECT_NAME}_lib ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
```

### Essential Development Tools

- **Formatter**: clang-format - Automatic code formatting with consistent style
- **Linter**: clang-tidy - Static analysis and modernization suggestions  
- **Sanitizers**: AddressSanitizer, ThreadSanitizer, UndefinedBehaviorSanitizer
- **Build System**: CMake - Modern, portable build configuration
- **Package Manager**: Conan or vcpkg - Dependency management
- **Profiler**: perf, Valgrind, or vendor-specific tools

## 🔍 Code Quality Standards

### Static Analysis Configuration

```cpp
// .clang-tidy configuration
Checks: >
    *,
    -fuchsia-*,
    -google-*,
    -zircon-*,
    -abseil-*,
    -llvm-*,
    -android-*,
    -altera-*,
    -cert-err58-cpp,
    -misc-non-private-member-variables-in-classes,
    -readability-identifier-length

WarningsAsErrors: '*'
HeaderFilterRegex: '.*'
AnalyzeTemporaryDtors: false

CheckOptions:
  - key: readability-identifier-naming.NamespaceCase
    value: lower_case
  - key: readability-identifier-naming.ClassCase  
    value: CamelCase
  - key: readability-identifier-naming.FunctionCase
    value: lower_case
  - key: readability-identifier-naming.VariableCase
    value: lower_case
  - key: readability-identifier-naming.ConstantCase
    value: UPPER_CASE
```

### Documentation Standards

```cpp
/**
 * @brief A comprehensive class demonstrating modern C++ documentation practices
 * 
 * This class serves as an example of how to document C++ code using Doxygen-style
 * comments. It includes detailed descriptions, parameter documentation, return value
 * specifications, and usage examples.
 * 
 * @tparam T The type of data to be managed (must be default constructible)
 * @tparam Allocator The allocator type for memory management
 * 
 * @since v1.0.0
 * @author Development Team
 * 
 * @example
 * ```cpp
 * DataManager<int> manager;
 * manager.add_data(42);
 * auto result = manager.get_data(0);
 * ```
 */
template<typename T, typename Allocator = std::allocator<T>>
class DataManager {
    /**
     * @brief Adds a new data element to the manager
     * 
     * @param data The data element to add (will be moved if possible)
     * @return The index where the data was inserted
     * 
     * @throws std::bad_alloc if memory allocation fails
     * @throws std::invalid_argument if data is invalid
     * 
     * @complexity O(1) amortized, O(n) worst case
     * @thread_safety This method is not thread-safe
     */
    [[nodiscard]] size_t add_data(T data);
};
```

## 🚫 Common C++ Pitfalls to Avoid

- **Manual Memory Management**: Always use RAII and smart pointers instead of raw `new`/`delete`
- **Rule of 3/5/0 Violations**: Properly implement or explicitly delete copy/move operations
- **Raw Array Usage**: Prefer `std::array`, `std::vector`, or `std::span` over C-style arrays
- **Const-Incorrectness**: Apply `const` wherever logically appropriate
- **Resource Leaks**: Ensure all resources are managed by RAII objects
- **Premature Optimization**: Profile before optimizing, focus on algorithmic improvements first
- **C-Style Casts**: Use C++ cast operators (`static_cast`, `dynamic_cast`, etc.)
- **Exception Unsafe Code**: Design for exception safety using RAII and strong exception guarantee
- **Undefined Behavior**: Be aware of common UB sources (signed overflow, dangling pointers, etc.)
- **Thread Safety Assumptions**: Explicitly design for thread safety or document thread requirements

## 📚 Essential Libraries

### Standard Library Mastery
```cpp
#include <algorithm>     // Algorithms and functional programming utilities
#include <memory>        // Smart pointers and memory management
#include <thread>        // Threading primitives
#include <mutex>         // Synchronization primitives
#include <future>        // Async programming utilities
#include <chrono>        // Time and duration utilities
#include <filesystem>    // File system operations (C++17)
#include <optional>      // Nullable value wrapper (C++17)
#include <variant>       // Type-safe union (C++17)
#include <string_view>   // Non-owning string reference (C++17)
```

### Recommended Third-Party Libraries
- **Boost**: Peer-reviewed portable C++ libraries
- **fmt**: Modern formatting library (std::format predecessor)
- **spdlog**: Fast C++ logging library  
- **nlohmann/json**: Modern JSON library for C++
- **Catch2 or Google Test**: Testing frameworks
- **Eigen**: Linear algebra and mathematical computations

## 🚦 AI Enforcement Summary

### Code Quality Rules
- ✅ Enforce RAII for all resource management
- ✅ Require smart pointers over raw pointers for ownership
- ✅ Block manual `new`/`delete` without corresponding RAII wrapper
- ✅ Enforce const-correctness in all contexts
- ✅ Require `noexcept` specification for functions that don't throw
- ✅ Block C-style casts in favor of C++ cast operators
- ✅ Enforce modern C++ feature usage (auto, range-for, lambdas)
- ✅ Require proper exception safety guarantees

### Performance Enforcement
- 🚫 Block string concatenation in loops without pre-allocation
- 🚫 Block inefficient container operations (repeated push_front on vector)
- ✅ Promote move semantics and perfect forwarding
- ✅ Promote compile-time computation with constexpr/consteval
- ✅ Enforce container reserve() calls when size is known
- ✅ Promote string_view for read-only string parameters

### Security Enforcement
- 🔒 Enforce bounds checking for array access
- 🔒 Block unsafe string functions (strcpy, sprintf)
- 🔒 Require input validation for all public interfaces
- 🔒 Enforce thread-safety annotations and practices
- 🔒 Block potential undefined behavior patterns

### Modern C++ Enforcement
- ✅ Promote C++17/20 features over legacy alternatives
- ✅ Enforce structured bindings for multiple return values
- ✅ Require concepts for template constraints (C++20)
- ✅ Promote ranges library usage (C++20)
- ✅ Enforce designated initializers for aggregate types (C++20)

## 📖 References

- [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/) - Authoritative best practices
- [cppreference.com](https://en.cppreference.com/) - Comprehensive language and library reference
- [Effective Modern C++ by Scott Meyers](https://www.oreilly.com/library/view/effective-modern-c/9781491908419/) - Essential modern C++ practices
- [C++ Concurrency in Action by Anthony Williams](https://www.manning.com/books/c-plus-plus-concurrency-in-action-second-edition) - Threading and concurrency
- [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html) - Industry-standard style guide
- [Clang-Tidy Checks Reference](https://clang.llvm.org/extra/clang-tidy/checks/list.html) - Static analysis rules
- [CMake Documentation](https://cmake.org/documentation/) - Modern build system practices
- [Boost Libraries](https://www.boost.org/) - High-quality C++ libraries