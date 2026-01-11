// ✅ Try-with-resources for automatic resource management
public List<User> loadUsersFromFile(Path filePath) throws IOException {
    try (BufferedReader reader = Files.newBufferedReader(filePath, StandardCharsets.UTF_8)) {
        return reader.lines()
                .filter(line -> !line.trim().isEmpty())
                .map(this::parseUserFromLine)
                .collect(Collectors.toList());
    }
}

// ✅ Proper cleanup in services
@Service
public class FileProcessingService {
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(2);
    
    @PostConstruct
    public void initialize() {
        // Schedule cleanup tasks
        scheduler.scheduleAtFixedRate(this::cleanupTempFiles, 1, 1, TimeUnit.HOURS);
    }
    
    @PreDestroy
    public void cleanup() {
        scheduler.shutdown();
        try {
            if (!scheduler.awaitTermination(10, TimeUnit.SECONDS)) {
                scheduler.shutdownNow();
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            scheduler.shutdownNow();
        }
    }
}

// ✅ Memory-efficient streaming for large datasets
public Stream<User> streamAllUsers() {
    return userRepository.findAll().stream()
            .filter(user -> user.getStatus() == UserStatus.ACTIVE);
}