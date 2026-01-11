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