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