// test/config/test-config.js
const config = {
  development: {
    db: {
      host: 'localhost',
      port: 27017,
      name: 'myapp_test',
    },
    api: {
      baseUrl: 'http://localhost:3000',
      timeout: 5000,
    },
  },

  ci: {
    db: {
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT) || 27017,
      name: process.env.DB_NAME || 'myapp_test_ci',
    },
    api: {
      baseUrl: process.env.API_BASE_URL || 'http://localhost:3000',
      timeout: 10000,
    },
  },
};

const env = process.env.NODE_ENV || 'development';
module.exports = config[env];