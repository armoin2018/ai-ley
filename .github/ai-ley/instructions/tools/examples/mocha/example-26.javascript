// Ensure proper async handling
it('should handle promises correctly', function () {
  return Promise.resolve('success') // Return promise
    .then((result) => {
      expect(result).to.equal('success');
    });
});

// Or use async/await
it('should handle async/await', async function () {
  const result = await Promise.resolve('success');
  expect(result).to.equal('success');
});

// For callbacks, use done parameter
it('should handle callbacks', function (done) {
  setTimeout(() => {
    expect(true).to.be.true;
    done(); // Must call done()
  }, 100);
});