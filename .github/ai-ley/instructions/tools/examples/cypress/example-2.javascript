// cypress.config.js - Modern Cypress configuration
const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    // Base URL for your application
    baseUrl: 'http://localhost:3000',

    // Browser and viewport settings
    viewportWidth: 1280,
    viewportHeight: 720,

    // Test file patterns
    specPattern: 'cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',
    supportFile: 'cypress/support/e2e.js',

    // Screenshots and videos
    screenshotsFolder: 'cypress/screenshots',
    videosFolder: 'cypress/videos',
    video: true,
    screenshotOnRunFailure: true,

    // Test behavior
    defaultCommandTimeout: 10000,
    requestTimeout: 10000,
    responseTimeout: 10000,
    pageLoadTimeout: 30000,

    // Test execution
    testIsolation: true,
    experimentalStudio: true,

    setupNodeEvents(on, config) {
      // Code coverage plugin
      require('@cypress/code-coverage/task')(on, config);

      // Custom tasks
      on('task', {
        log(message) {
          console.log(message);
          return null;
        },

        // Database seeding task
        seedDb(fixture) {
          // Custom database seeding logic
          return null;
        },

        // API mocking task
        setupApiMocks() {
          // Setup API mocking
          return null;
        },
      });

      return config;
    },
  },

  component: {
    devServer: {
      framework: 'react', // or 'vue', 'angular'
      bundler: 'vite', // or 'webpack'
    },
    specPattern: 'src/**/*.cy.{js,jsx,ts,tsx}',
    supportFile: 'cypress/support/component.js',
  },

  // Environment variables
  env: {
    auth_username: 'testuser@example.com',
    auth_password: 'password123',
    api_server: 'http://localhost:8080',
  },

  // Retry configuration
  retries: {
    runMode: 2,
    openMode: 0,
  },
});