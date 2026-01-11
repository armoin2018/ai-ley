// Optimize test performance
describe('Performance Optimized Tests', function () {
  // Share expensive setup across tests
  before(async function () {
    this.timeout(30000);
    // Expensive one-time setup
    await setupDatabase();
  });

  // Use test isolation correctly
  beforeEach(function () {
    // Fast per-test setup only
    this.user = { id: 1, name: 'Test' };
  });

  // Group fast and slow tests
  describe('Fast Tests', function () {
    // Unit tests here
  });

  describe('Slow Tests', function () {
    this.timeout(10000);
    // Integration tests here
  });
});