// ✅ Proper memory management with weak references
class NotificationService {
    private weak var delegate: NotificationDelegate?
    private var observations: [NSKeyValueObservation] = []
    
    init(delegate: NotificationDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        observations.forEach { $0.invalidate() }
    }
    
    func startObserving(user: User) {
        let observation = user.observe(\.status) { [weak self] user, _ in
            self?.delegate?.userStatusDidChange(user)
        }
        observations.append(observation)
    }
}

// ✅ Value types for immutable data
struct UserPreferences: Codable {
    let theme: Theme
    let notificationsEnabled: Bool
    let language: String
    
    func with(theme: Theme) -> UserPreferences {
        return UserPreferences(
            theme: theme,
            notificationsEnabled: notificationsEnabled,
            language: language
        )
    }
}

// ✅ Lazy initialization for expensive operations
class ImageCache {
    private lazy var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 50 * 1024 * 1024 // 50MB
        cache.countLimit = 100
        return cache
    }()
    
    func image(for url: URL) -> UIImage? {
        return cache.object(forKey: url.absoluteString as NSString)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
}