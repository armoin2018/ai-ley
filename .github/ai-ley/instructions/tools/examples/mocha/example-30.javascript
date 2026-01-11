// test/config/secure-config.js
const config = {
  test: {
    database: {
      host: process.env.TEST_DB_HOST || 'localhost',
      username: process.env.TEST_DB_USER || 'test_user',
      password: process.env.TEST_DB_PASS || 'test_password',
      name: 'test_database',
    },
    api: {
      baseUrl: process.env.TEST_API_URL || 'http://localhost:3000',
      apiKey: process.env.TEST_API_KEY || 'test_api_key',
    },
  },
};

// Validate required environment variables
const requiredEnvVars = ['TEST_DB_HOST', 'TEST_API_URL'];
requiredEnvVars.forEach((envVar) => {
  if (!process.env[envVar]) {
    throw new Error(`Required environment variable ${envVar} is not set`);
  }
});

module.exports = config.test;