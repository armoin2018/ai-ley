// test/setup.js - Global test configuration
const chai = require('chai');
const chaiHttp = require('chai-http');
const chaiAsPromised = require('chai-as-promised');
const sinon = require('sinon');
const sinonChai = require('sinon-chai');

// Configure Chai
chai.use(chaiHttp);
chai.use(chaiAsPromised);
chai.use(sinonChai);

// Global assertion styles
global.expect = chai.expect;
global.should = chai.should();
global.assert = chai.assert;
global.sinon = sinon;

// Global test hooks
beforeEach(function () {
  // Reset stubs and spies before each test
  sinon.restore();
});

after(function () {
  // Global cleanup after all tests
  console.log('All tests completed');
});

// Handle unhandled promise rejections in tests
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
  process.exit(1);
});

// Set longer timeout for slow tests
this.timeout = function (ms) {
  return ms || 5000;
};