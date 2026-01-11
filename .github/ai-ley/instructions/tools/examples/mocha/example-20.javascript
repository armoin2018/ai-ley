describe('Flaky Integration Tests', function () {
  // Retry failed tests up to 3 times
  this.retries(3);

  it('should handle network timeouts', async function () {
    // This test might fail due to network issues
    const response = await fetch('https://api.example.com/data');
    expect(response.status).to.equal(200);
  });
});