// Example of secure NW.js application patterns
class SecureNWJSApp {
  constructor() {
    this.initSecurity();
  }

  initSecurity() {
    // Disable Node.js in child windows
    nw.Window.open('about.html', {
      'node-integration': false,
    });

    // Validate file paths
    this.validatePath = (filePath) => {
      const path = require('path');
      const resolved = path.resolve(filePath);

      // Prevent directory traversal attacks
      if (resolved.includes('..')) {
        throw new Error('Invalid file path');
      }

      return resolved;
    };

    // Sanitize file operations
    this.safeFileOperation = async (operation, filePath, ...args) => {
      try {
        const safePath = this.validatePath(filePath);
        return await operation(safePath, ...args);
      } catch (error) {
        console.error('File operation failed:', error);
        throw error;
      }
    };
  }

  // Memory management
  cleanup() {
    // Clear large objects
    this.fileCache = null;
    this.imageCache = null;

    // Force garbage collection if available
    if (global.gc) {
      global.gc();
    }
  }

  // Performance monitoring
  monitorPerformance() {
    const used = process.memoryUsage();
    console.log('Memory usage:', {
      rss: Math.round(used.rss / 1024 / 1024) + ' MB',
      heapTotal: Math.round(used.heapTotal / 1024 / 1024) + ' MB',
      heapUsed: Math.round(used.heapUsed / 1024 / 1024) + ' MB',
    });
  }
}