// Example of efficient resource management in Neutralino
class ResourceManager {
  constructor() {
    this.watchedFiles = new Map();
    this.cachedData = new Map();
    this.cleanup = this.cleanup.bind(this);

    // Register cleanup on window close
    window.addEventListener('beforeunload', this.cleanup);
  }

  async watchFile(path, callback) {
    if (!this.watchedFiles.has(path)) {
      try {
        await Neutralino.filesystem.watchFile(path);
        this.watchedFiles.set(path, new Set());
      } catch (error) {
        console.error('Failed to watch file:', error);
        return false;
      }
    }

    this.watchedFiles.get(path).add(callback);
    return true;
  }

  unwatchFile(path, callback) {
    if (this.watchedFiles.has(path)) {
      const callbacks = this.watchedFiles.get(path);
      callbacks.delete(callback);

      if (callbacks.size === 0) {
        this.watchedFiles.delete(path);
        // Neutralino doesn't have unwatchFile, so we keep watching
        // but clear our callbacks
      }
    }
  }

  async cacheData(key, fetchFunction, ttl = 60000) {
    const cached = this.cachedData.get(key);
    const now = Date.now();

    if (cached && now - cached.timestamp < ttl) {
      return cached.data;
    }

    try {
      const data = await fetchFunction();
      this.cachedData.set(key, {
        data,
        timestamp: now,
      });
      return data;
    } catch (error) {
      console.error('Failed to fetch data:', error);
      return cached ? cached.data : null;
    }
  }

  clearCache() {
    this.cachedData.clear();
  }

  cleanup() {
    console.log('Cleaning up resources...');
    this.watchedFiles.clear();
    this.cachedData.clear();
  }
}

// Usage
const resourceManager = new ResourceManager();

// Watch file with automatic cleanup
resourceManager.watchFile('/path/to/file.txt', (event) => {
  console.log('File changed:', event);
});

// Cache expensive operations
const systemInfo = await resourceManager.cacheData(
  'systemInfo',
  () => Neutralino.computer.getMemoryInfo(),
  30000, // Cache for 30 seconds
);