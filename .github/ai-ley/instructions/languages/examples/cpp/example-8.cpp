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