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