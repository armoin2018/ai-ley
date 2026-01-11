/** @type {import('jest').Config} */
module.exports = {
  // Multiple projects
  projects: [
    {
      displayName: 'client',
      testEnvironment: 'jsdom',
      testMatch: ['<rootDir>/src/client/**/*.(test|spec).(js|ts)']
    },
    {
      displayName: 'server',
      testEnvironment: 'node',
      testMatch: ['<rootDir>/src/server/**/*.(test|spec).(js|ts)']
    }
  ],
  
  // Global setup and teardown
  globalSetup: '<rootDir>/tests/global-setup.js',
  globalTeardown: '<rootDir>/tests/global-teardown.js',
  
  // Custom test environment
  testEnvironment: '<rootDir>/tests/custom-environment.js',
  
  // Reporters
  reporters: [
    'default',
    ['jest-junit', { outputDirectory: 'test-results' }],
    ['jest-html-reporters', { publicPath: 'html-report' }]
  ],
  
  // Performance options
  maxWorkers: '50%',
  maxConcurrency: 5,
  
  // Error handling
  bail: 1, // Stop after first test failure
  errorOnDeprecated: true,
  
  // Cache
  cache: true,
  cacheDirectory: '<rootDir>/.jest-cache',
  
  // Snapshot serializers
  snapshotSerializers: ['enzyme-to-json/serializer'],
  
  // Watch options
  watchman: true,
  watchPathIgnorePatterns: ['<rootDir>/node_modules/']
}