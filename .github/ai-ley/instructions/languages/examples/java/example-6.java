// ✅ Good: Proper asynchronous processing
@Service
public class AsyncUserService {
    private final UserService userService;
    private final ExecutorService executorService;
    
    public AsyncUserService(UserService userService) {
        this.userService = userService;
        this.executorService = Executors.newFixedThreadPool(10);
    }
    
    public CompletableFuture<List<User>> processUsersAsync(List<Long> userIds) {
        List<CompletableFuture<User>> futures = userIds.stream()
                .map(this::processUserAsync)
                .collect(Collectors.toList());
                
        return CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]))
                .thenApply(v -> futures.stream()
                        .map(CompletableFuture::join)
                        .collect(Collectors.toList()));
    }
    
    private CompletableFuture<User> processUserAsync(Long userId) {
        return CompletableFuture.supplyAsync(() -> {
            return userService.findUserById(userId)
                    .orElseThrow(() -> new UserNotFoundException("User not found: " + userId));
        }, executorService);
    }
    
    @PreDestroy
    public void shutdown() {
        executorService.shutdown();
        try {
            if (!executorService.awaitTermination(30, TimeUnit.SECONDS)) {
                executorService.shutdownNow();
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            executorService.shutdownNow();
        }
    }
}

// ✅ Good: Thread-safe singleton with concurrent collections
@Component
public class CacheManager {
    private final ConcurrentHashMap<String, Object> cache = new ConcurrentHashMap<>();
    private final ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
    
    public <T> Optional<T> get(String key, Class<T> type) {
        lock.readLock().lock();
        try {
            Object value = cache.get(key);
            return Optional.ofNullable(type.cast(value));
        } finally {
            lock.readLock().unlock();
        }
    }
    
    public void put(String key, Object value) {
        lock.writeLock().lock();
        try {
            cache.put(key, value);
        } finally {
            lock.writeLock().unlock();
        }
    }
}