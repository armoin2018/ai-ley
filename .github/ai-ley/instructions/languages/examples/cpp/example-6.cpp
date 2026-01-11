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