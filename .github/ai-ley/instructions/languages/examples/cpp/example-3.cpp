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