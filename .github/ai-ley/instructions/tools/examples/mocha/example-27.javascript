describe('Resource Management', function () {
  afterEach(function () {
    // Clean up resources
    sinon.restore();
    // Close database connections
    // Clear caches
  });

  after(function () {
    // Final cleanup
    process.removeAllListeners('unhandledRejection');
  });
});

// Configure timeouts appropriately
this.timeout(5000); // 5 second timeout