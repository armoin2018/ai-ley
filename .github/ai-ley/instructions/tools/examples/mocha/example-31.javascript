// test/fixtures/secure-fixtures.js
const crypto = require('crypto');

// Generate secure test data
function generateTestUser() {
  const randomId = crypto.randomBytes(16).toString('hex');
  return {
    id: randomId,
    email: `test_${randomId}@example.com`,
    password: 'secure_test_password_123',
    role: 'test_user',
  };
}

// Sanitize test outputs
function sanitizeOutput(data) {
  const sanitized = { ...data };
  delete sanitized.password;
  delete sanitized.apiKey;
  delete sanitized.secret;
  return sanitized;
}

module.exports = {
  generateTestUser,
  sanitizeOutput,
};