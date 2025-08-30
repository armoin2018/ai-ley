---
title: 'Mocha JavaScript Testing Framework Instructions'
description: 'Comprehensive guide for using Mocha testing framework for JavaScript and Node.js unit testing, integration testing, and test automation'
category: 'Testing Tools'

tags: ['mocha', 'javascript', 'nodejs', 'testing', 'unit-tests', 'integration-tests', 'bdd', 'tdd']
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/test/**/*.js'
  - '**/tests/**/*.js'
  - '**/*.test.js'
  - '**/*.spec.js'
  - '**/mocha.opts'
  - '**/.mocharc.*'
  - '**/package.json'
---

# Mocha JavaScript Testing Framework Instructions

## Tool Overview

- **Tool Name**: Mocha
- **Version**: 10.2+ (Latest stable with ESM support and improved performance)
- **Category**: Testing Tools - JavaScript Testing Framework
- **Purpose**: Flexible JavaScript testing framework for Node.js and browsers, supporting BDD, TDD, and asynchronous testing
- **Prerequisites**: Node.js 14+, npm/yarn/pnpm, JavaScript/TypeScript project

## When to Use Mocha

### ✅ **Use Mocha When**

- Need a flexible, unopinionated testing framework for JavaScript/Node.js projects
- Want to choose your own assertion library (Chai, Should.js, etc.)
- Working with complex testing scenarios requiring custom reporters and hooks
- Need extensive browser testing capabilities with multiple environments
- Prefer BDD (Behavior-Driven Development) or TDD (Test-Driven Development) approaches
- Working with asynchronous code requiring robust async testing support
- Need detailed test reporting and custom output formats
- Integrating with legacy codebases that require flexible test configuration
- Want granular control over test execution and filtering

### ❌ **Avoid Mocha When**

- Need a zero-configuration testing solution (consider Jest)
- Working with React applications primarily (Jest + React Testing Library)
- Want built-in mocking, spying, and assertion capabilities in one package
- Need snapshot testing out of the box
- Team prefers opinionated frameworks with less configuration overhead
- Working on simple projects where test setup complexity isn't justified

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | Mocha Recommendation                          | Configuration Priority         |
| ---------------------- | --------------------------------------------- | ------------------------------ |
| Node.js API Server     | ✅ **Essential** - Excellent async support    | High - API + database testing  |
| Express.js Application | ✅ **Essential** - Middleware + route testing | High - Integration test focus  |
| JavaScript Library     | ✅ **Recommended** - Flexible test scenarios  | Medium - Unit test coverage    |
| Browser JavaScript     | ✅ **Recommended** - Browser test support     | Medium - Cross-browser testing |
| TypeScript Project     | ✅ **Recommended** - Good TS integration      | Medium - Type-aware testing    |
| React Application      | 🔄 **Consider** - Jest often preferred        | Low - Component testing        |

### Complexity Assessment

| Factor                  | Low Complexity        | Medium Complexity         | High Complexity      |
| ----------------------- | --------------------- | ------------------------- | -------------------- |
| **Setup Time**          | 30 minutes (basic)    | 2 hours (with reporters)  | 1 day (custom setup) |
| **Test Types**          | Unit tests only       | Unit + integration        | Full test suite      |
| **Assertion Libraries** | Single library (Chai) | Multiple assertion styles | Custom assertions    |
| **Reporting**           | Basic console output  | HTML + JSON reports       | Custom reporters     |

## Installation & Setup

### Package Manager Installation

```bash
# npm installation (recommended for most projects)
npm install mocha --save-dev

# yarn installation
yarn add mocha --dev

# pnpm installation
pnpm add mocha --save-dev

# Global installation for CLI usage
npm install -g mocha

# Verify installation
npx mocha --version
mocha --version  # If installed globally
```

### Assertion Library Installation

```bash
# Chai (most popular assertion library for Mocha)
npm install chai --save-dev

# Additional Chai plugins
npm install chai-http --save-dev        # HTTP assertions
npm install chai-as-promised --save-dev # Promise assertions
npm install sinon-chai --save-dev       # Sinon spy/stub assertions

# Alternative assertion libraries
npm install should --save-dev           # Should.js
npm install expect.js --save-dev        # Expect.js
npm install assert --save-dev           # Node.js built-in assert
```

### TypeScript Support

```bash
# TypeScript and related packages
npm install typescript ts-node @types/mocha @types/chai --save-dev

# TypeScript configuration for Mocha
npm install tsconfig-paths --save-dev
```

### Project Integration

```bash
# Create test directory structure
mkdir -p test/{unit,integration,fixtures}
mkdir -p test/helpers

# Initialize package.json test script
npm init -y

# Add test scripts to package.json
cat > package.json << 'EOF'
{
  "scripts": {
    "test": "mocha",
    "test:watch": "mocha --watch",
    "test:coverage": "nyc mocha",
    "test:reporter": "mocha --reporter spec"
  }
}
EOF

# Create basic test file
cat > test/example.test.js << 'EOF'
const assert = require('assert');

describe('Example Test Suite', function() {
  it('should return true', function() {
    assert.strictEqual(true, true);
  });
});
EOF
```

## Configuration

### .mocharc.json Configuration

```json
{
  "spec": ["test/**/*.test.js", "test/**/*.spec.js"],
  "exclude": ["test/fixtures/**", "test/helpers/**"],
  "require": ["test/setup.js"],
  "reporter": "spec",
  "timeout": 5000,
  "recursive": true,
  "exit": true,
  "bail": false,
  "grep": "",
  "invert": false,
  "checkLeaks": true,
  "globals": ["expect"],
  "colors": true,
  "growl": false,
  "asyncOnly": false,
  "delay": false,
  "forbidOnly": false,
  "forbidPending": false,
  "fullTrace": false,
  "retries": 0,
  "slow": 75,
  "ui": "bdd"
}
```

### TypeScript Configuration (.mocharc.json)

```json
{
  "spec": ["test/**/*.test.ts", "test/**/*.spec.ts"],
  "require": ["ts-node/register", "tsconfig-paths/register", "test/setup.ts"],
  "extensions": ["ts"],
  "timeout": 10000,
  "recursive": true,
  "reporter": "spec",
  "exit": true
}
```

### package.json Configuration

```json
{
  "scripts": {
    "test": "mocha",
    "test:watch": "mocha --watch",
    "test:debug": "mocha --inspect-brk",
    "test:coverage": "nyc mocha",
    "test:unit": "mocha test/unit/**/*.test.js",
    "test:integration": "mocha test/integration/**/*.test.js",
    "test:smoke": "mocha --grep @smoke",
    "test:regression": "mocha --grep @regression",
    "test:ci": "mocha --reporter json > test-results.json"
  },
  "mocha": {
    "spec": "test/**/*.test.js",
    "reporter": "spec",
    "timeout": 5000,
    "recursive": true,
    "require": ["test/setup.js"]
  }
}
```

### Test Setup File

```javascript
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
```

### Environment-Specific Configuration

```javascript
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
```

## Core Features

### Test Structure and Organization

- **Purpose**: Organize tests using describe blocks and it statements for clear test hierarchy
- **Usage**: Foundation for readable and maintainable test suites
- **Example**:

```javascript
// test/user.test.js
const { expect } = require('chai');
const User = require('../src/models/User');

describe('User Model', function () {
  describe('User Creation', function () {
    it('should create a user with valid data', function () {
      const userData = {
        name: 'John Doe',
        email: 'john@example.com',
        age: 30,
      };

      const user = new User(userData);

      expect(user.name).to.equal('John Doe');
      expect(user.email).to.equal('john@example.com');
      expect(user.age).to.equal(30);
    });

    it('should throw error with invalid email', function () {
      const userData = {
        name: 'John Doe',
        email: 'invalid-email',
        age: 30,
      };

      expect(() => new User(userData)).to.throw('Invalid email format');
    });
  });

  describe('User Methods', function () {
    let user;

    beforeEach(function () {
      user = new User({
        name: 'Test User',
        email: 'test@example.com',
        age: 25,
      });
    });

    it('should return full name', function () {
      expect(user.getFullName()).to.equal('Test User');
    });

    it('should validate age', function () {
      expect(user.isAdult()).to.be.true;

      user.age = 16;
      expect(user.isAdult()).to.be.false;
    });
  });
});
```

### Asynchronous Testing

- **Purpose**: Test asynchronous code including Promises, callbacks, and async/await
- **Usage**: Essential for modern JavaScript applications with async operations
- **Example**:

```javascript
const { expect } = require('chai');
const request = require('supertest');
const app = require('../src/app');

describe('Async Testing', function () {
  // Promise-based testing
  it('should handle promises', function () {
    return fetchUserData(1).then((user) => {
      expect(user.id).to.equal(1);
      expect(user.name).to.be.a('string');
    });
  });

  // Async/await testing
  it('should handle async/await', async function () {
    const user = await fetchUserData(1);

    expect(user.id).to.equal(1);
    expect(user.name).to.be.a('string');
  });

  // Callback testing with done
  it('should handle callbacks', function (done) {
    fetchUserDataCallback(1, (err, user) => {
      if (err) return done(err);

      expect(user.id).to.equal(1);
      expect(user.name).to.be.a('string');
      done();
    });
  });

  // HTTP API testing
  it('should test API endpoints', async function () {
    const response = await request(app).get('/api/users/1').expect(200);

    expect(response.body).to.have.property('id', 1);
    expect(response.body.name).to.be.a('string');
  });

  // Testing promise rejection
  it('should handle rejected promises', function () {
    return expect(fetchInvalidUser()).to.be.rejectedWith('User not found');
  });

  // Testing with timeout
  it('should handle slow operations', async function () {
    this.timeout(10000); // 10 second timeout

    const result = await slowOperation();
    expect(result).to.be.ok;
  });
});
```

### Hooks and Test Lifecycle

- **Purpose**: Set up and tear down test environments using before, after, beforeEach, afterEach hooks
- **Usage**: Manage test data, database connections, and shared resources
- **Example**:

```javascript
const { expect } = require('chai');
const mongoose = require('mongoose');
const User = require('../src/models/User');

describe('Database Integration Tests', function () {
  // Run once before all tests in this describe block
  before(async function () {
    await mongoose.connect('mongodb://localhost:27017/test_db');
    console.log('Connected to test database');
  });

  // Run once after all tests in this describe block
  after(async function () {
    await mongoose.connection.close();
    console.log('Disconnected from test database');
  });

  // Run before each test
  beforeEach(async function () {
    // Clear database before each test
    await User.deleteMany({});

    // Seed test data
    await User.create([
      { name: 'User 1', email: 'user1@test.com' },
      { name: 'User 2', email: 'user2@test.com' },
    ]);
  });

  // Run after each test
  afterEach(function () {
    // Clean up any test artifacts
    console.log('Test completed, data cleaned');
  });

  describe('User Operations', function () {
    it('should find all users', async function () {
      const users = await User.find({});
      expect(users).to.have.lengthOf(2);
    });

    it('should create new user', async function () {
      const newUser = await User.create({
        name: 'New User',
        email: 'new@test.com',
      });

      expect(newUser.name).to.equal('New User');

      const allUsers = await User.find({});
      expect(allUsers).to.have.lengthOf(3);
    });
  });
});
```

### Mocking and Stubbing

- **Purpose**: Isolate units under test by mocking dependencies and external services
- **Usage**: Essential for unit testing and controlling test environment
- **Example**:

```javascript
const { expect } = require('chai');
const sinon = require('sinon');
const UserService = require('../src/services/UserService');
const EmailService = require('../src/services/EmailService');
const Database = require('../src/database/Database');

describe('User Service with Mocks', function () {
  let emailStub, dbStub;

  beforeEach(function () {
    // Stub external dependencies
    emailStub = sinon.stub(EmailService, 'sendWelcomeEmail');
    dbStub = sinon.stub(Database, 'save');
  });

  afterEach(function () {
    sinon.restore();
  });

  it('should create user and send welcome email', async function () {
    // Configure stubs
    dbStub.resolves({ id: 1, name: 'John Doe', email: 'john@test.com' });
    emailStub.resolves(true);

    const userData = { name: 'John Doe', email: 'john@test.com' };
    const result = await UserService.createUser(userData);

    // Verify behavior
    expect(result.id).to.equal(1);
    expect(dbStub.calledOnce).to.be.true;
    expect(emailStub.calledOnce).to.be.true;
    expect(emailStub.calledWith('john@test.com')).to.be.true;
  });

  it('should handle database errors', async function () {
    // Configure stub to reject
    dbStub.rejects(new Error('Database error'));

    const userData = { name: 'John Doe', email: 'john@test.com' };

    await expect(UserService.createUser(userData)).to.be.rejectedWith('Database error');

    // Verify email was not sent on database error
    expect(emailStub.called).to.be.false;
  });

  // Spying on existing methods
  it('should track method calls', function () {
    const user = { validate: () => true };
    const validateSpy = sinon.spy(user, 'validate');

    user.validate();
    user.validate();

    expect(validateSpy.callCount).to.equal(2);
    expect(validateSpy.alwaysReturned(true)).to.be.true;
  });
});
```

## Common Commands

```bash
# Essential daily commands
npx mocha                              # Run all tests
npx mocha test/unit/**/*.test.js       # Run specific test directory
npx mocha --grep "user creation"       # Run tests matching pattern
npx mocha --watch                      # Watch mode for development

# Test filtering and selection
npx mocha --grep @smoke                # Run tests with @smoke tag
npx mocha --invert --grep @slow        # Skip tests with @slow tag
npx mocha test/integration/*.test.js   # Run specific test files
npx mocha --bail                       # Stop on first failure

# Reporting and output
npx mocha --reporter json              # JSON output
npx mocha --reporter html              # HTML report
npx mocha --reporter tap               # TAP format
npx mocha --reporter spec              # Spec format (default)
npx mocha --reporter min               # Minimal output

# Debug and development
npx mocha --inspect-brk                # Debug with Chrome DevTools
npx mocha --timeout 10000              # Set timeout (10 seconds)
npx mocha --slow 1000                  # Mark tests as slow above 1s
npx mocha --recursive                  # Run tests recursively

# Coverage and analysis
npx nyc mocha                          # Run with coverage
npx nyc --reporter=html mocha          # HTML coverage report
npx nyc --reporter=lcov mocha          # LCOV coverage report

# Configuration and setup
npx mocha --opts mocha.opts            # Use options file
npx mocha --config .mocharc.json       # Use JSON config
npx mocha --require test/setup.js      # Require setup file
```

## Workflow Integration

### Development Workflow

1. **Setup**: Install Mocha, assertion library, and configure test environment
2. **Test Writing**: Create tests following BDD/TDD patterns with describe/it blocks
3. **Development**: Use watch mode for continuous testing during development
4. **Integration**: Set up hooks for database and external service mocking
5. **CI/CD**: Configure automated testing with coverage reporting

### Test-Driven Development (TDD) Workflow

```bash
# TDD Red-Green-Refactor cycle
# 1. Red: Write failing test
cat > test/calculator.test.js << 'EOF'
const { expect } = require('chai');
const Calculator = require('../src/Calculator');

describe('Calculator', function() {
  it('should add two numbers', function() {
    const calc = new Calculator();
    expect(calc.add(2, 3)).to.equal(5);
  });
});
EOF

# 2. Run test (should fail)
npx mocha test/calculator.test.js

# 3. Green: Write minimal code to pass
mkdir -p src
cat > src/Calculator.js << 'EOF'
class Calculator {
  add(a, b) {
    return a + b;
  }
}

module.exports = Calculator;
EOF

# 4. Run test (should pass)
npx mocha test/calculator.test.js

# 5. Refactor: Improve code quality
# 6. Repeat cycle
```

### CI/CD Integration

```yaml
# .github/workflows/test.yml
name: Test Suite
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: [16, 18, 20]

    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node-version }}
          cache: 'npm'

      - run: npm ci

      - name: Run tests
        run: npm test

      - name: Generate coverage
        run: npx nyc --reporter=lcov mocha

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage/lcov.info
```

### Package.json Scripts Integration

```json
{
  "scripts": {
    "test": "mocha",
    "test:unit": "mocha test/unit/**/*.test.js",
    "test:integration": "mocha test/integration/**/*.test.js",
    "test:watch": "mocha --watch",
    "test:debug": "mocha --inspect-brk",
    "test:coverage": "nyc mocha",
    "test:coverage:html": "nyc --reporter=html mocha",
    "test:smoke": "mocha --grep @smoke",
    "test:regression": "mocha --grep @regression --timeout 30000",
    "test:ci": "mocha --reporter json > test-results.json && nyc --reporter=lcov mocha",
    "pretest": "npm run lint",
    "posttest": "npm run coverage:check"
  }
}
```

## Best Practices

### ✅ **Test Organization Best Practices**

- **Use descriptive test names** - Test names should clearly explain what is being tested
- **Follow BDD structure** - Organize tests with describe blocks for features and it blocks for scenarios
- **Group related tests** - Use nested describe blocks to group related functionality
- **One assertion per test** - Keep tests focused on single behaviors for clarity
- **Use beforeEach for setup** - Set up fresh test data for each test to ensure isolation
- **Clean up after tests** - Use afterEach and after hooks to clean up resources

### ✅ **Asynchronous Testing Best Practices**

- **Prefer async/await** - Use modern async syntax over callbacks and raw promises
- **Handle promise rejections** - Always test both success and failure cases
- **Set appropriate timeouts** - Configure timeouts based on operation complexity
- **Use proper error handling** - Catch and assert on specific error types and messages
- **Mock external dependencies** - Use stubs and mocks to isolate units under test
- **Test edge cases** - Include tests for network failures, timeouts, and error conditions

### ✅ **Performance and Maintainability**

- **Keep tests fast** - Unit tests should run in milliseconds, integration tests in seconds
- **Use test fixtures** - Create reusable test data and helper functions
- **Avoid test interdependencies** - Each test should be independent and runnable in isolation
- **Use meaningful assertions** - Choose assertion methods that provide clear failure messages
- **Document complex tests** - Add comments explaining complex test scenarios
- **Regular test maintenance** - Update tests when requirements change

### ❌ **Common Pitfalls to Avoid**

- **Don't test implementation details** - Focus on behavior, not internal implementation
- **Avoid large, complex tests** - Break down complex scenarios into smaller, focused tests
- **Don't share state between tests** - Use beforeEach to ensure test isolation
- **Avoid hardcoded values** - Use constants and configuration for test data
- **Don't ignore flaky tests** - Fix intermittent test failures promptly
- **Avoid testing third-party libraries** - Focus on your application logic

## Advanced Mocha Usage

### Custom Reporters

```javascript
// test/reporters/custom-reporter.js
const { Base } = require('mocha').reporters;

function CustomReporter(runner) {
  Base.call(this, runner);

  runner.on('start', function () {
    console.log('🚀 Starting test suite...');
  });

  runner.on('pass', function (test) {
    console.log(`✅ ${test.title}`);
  });

  runner.on('fail', function (test, err) {
    console.log(`❌ ${test.title}: ${err.message}`);
  });

  runner.on('end', function () {
    console.log(
      `🏁 Tests completed: ${runner.stats.passes} passed, ${runner.stats.failures} failed`,
    );
  });
}

module.exports = CustomReporter;
```

### Parallel Testing

```json
// .mocharc.json - Parallel execution
{
  "spec": "test/**/*.test.js",
  "parallel": true,
  "jobs": 4,
  "timeout": 10000,
  "reporter": "spec"
}
```

### Test Retries for Flaky Tests

```javascript
describe('Flaky Integration Tests', function () {
  // Retry failed tests up to 3 times
  this.retries(3);

  it('should handle network timeouts', async function () {
    // This test might fail due to network issues
    const response = await fetch('https://api.example.com/data');
    expect(response.status).to.equal(200);
  });
});
```

### Dynamic Test Generation

```javascript
const testCases = [
  { input: [1, 2], expected: 3 },
  { input: [5, 7], expected: 12 },
  { input: [-1, 1], expected: 0 },
  { input: [0, 0], expected: 0 },
];

describe('Calculator Addition', function () {
  testCases.forEach(({ input, expected }) => {
    it(`should add ${input[0]} + ${input[1]} = ${expected}`, function () {
      const calc = new Calculator();
      expect(calc.add(...input)).to.equal(expected);
    });
  });
});
```

## Integration with Other Tools

### Chai Assertion Library

```javascript
const { expect, assert, should } = require('chai');

describe('Chai Integration', function () {
  it('should use expect style', function () {
    expect([1, 2, 3]).to.have.lengthOf(3);
    expect('hello').to.be.a('string');
    expect({ foo: 'bar' }).to.have.property('foo');
  });

  it('should use assert style', function () {
    assert.equal(true, true);
    assert.typeOf('hello', 'string');
    assert.lengthOf([1, 2, 3], 3);
  });

  it('should use should style', function () {
    'hello'.should.be.a('string');
    [1, 2, 3].should.have.lengthOf(3);
    ({ foo: 'bar' }).should.have.property('foo');
  });
});
```

### Sinon Integration

```javascript
const sinon = require('sinon');
const { expect } = require('chai');

describe('Sinon Integration', function () {
  it('should mock functions', function () {
    const mock = sinon.mock();
    mock.withArgs('hello').returns('world');

    expect(mock('hello')).to.equal('world');
    expect(mock.calledWith('hello')).to.be.true;
  });

  it('should stub methods', function () {
    const obj = { method: () => 'original' };
    const stub = sinon.stub(obj, 'method').returns('stubbed');

    expect(obj.method()).to.equal('stubbed');
    expect(stub.calledOnce).to.be.true;

    stub.restore();
  });
});
```

### NYC Code Coverage

```bash
# Install NYC
npm install nyc --save-dev

# Configure in package.json
{
  "nyc": {
    "reporter": ["html", "text", "lcov"],
    "exclude": [
      "test/**",
      "coverage/**",
      "node_modules/**"
    ],
    "check-coverage": true,
    "lines": 80,
    "functions": 80,
    "branches": 80,
    "statements": 80
  }
}
```

## Troubleshooting

### Common Issues

#### Tests Not Running

**Problem**: Mocha not finding or executing tests
**Symptoms**: "No test files found" or tests not executing
**Solution**:

```bash
# Check file patterns and location
npx mocha --dry-run

# Verify test file naming conventions
ls test/**/*.test.js
ls test/**/*.spec.js

# Check configuration
cat .mocharc.json
cat package.json | grep -A5 '"mocha"'

# Run with verbose output
npx mocha --verbose
```

#### Async Test Issues

**Problem**: Tests hanging or not completing properly
**Symptoms**: Tests timeout or don't finish execution
**Solution**:

```javascript
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
```

#### Memory Leaks and Resource Issues

**Problem**: Tests consuming too much memory or not cleaning up
**Symptoms**: Slow test execution or memory errors
**Solution**:

```javascript
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
```

### Debug Mode

```bash
# Debug with Node.js inspector
npx mocha --inspect-brk test/specific.test.js

# Debug with VS Code
# Add to launch.json:
{
  "type": "node",
  "request": "launch",
  "name": "Mocha Tests",
  "program": "${workspaceFolder}/node_modules/mocha/bin/_mocha",
  "args": ["--timeout", "999999", "--colors", "${workspaceFolder}/test"],
  "console": "integratedTerminal",
  "internalConsoleOptions": "neverOpen"
}
```

### Performance Optimization

```javascript
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
```

## Security Considerations

### Security Best Practices

- **Isolate test environment** - Use separate databases and services for testing
- **Secure test data** - Don't use production data or real credentials in tests
- **Validate dependencies** - Regularly audit test dependencies for vulnerabilities
- **Control test execution** - Restrict test execution to authorized environments
- **Protect sensitive outputs** - Ensure test reports don't expose sensitive information
- **Secure CI/CD integration** - Use secure practices for automated test execution

### Secure Test Configuration

```javascript
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
```

### Test Data Security

```javascript
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
```

## AI Assistant Guidelines

When helping with Mocha:

1. **Always suggest Mocha 10.2+** for latest features and performance improvements
2. **Provide complete test examples** with proper async handling and error management
3. **Include assertion library integration** with Chai or other popular assertion libraries
4. **Suggest appropriate test organization** with describe blocks and proper test isolation
5. **Provide debugging strategies** for common async and configuration issues
6. **Include CI/CD integration patterns** with coverage reporting and parallel execution
7. **Reference mocking and stubbing** best practices with Sinon integration
8. **Suggest performance optimization** techniques for large test suites

### Code Generation Rules

- Generate test files with proper describe/it structure and meaningful test names
- Include appropriate async handling patterns for promises and callbacks
- Provide proper test setup and teardown with before/after hooks
- Include assertion examples that provide clear failure messages
- Follow BDD/TDD patterns with behavior-focused test descriptions
- Generate configuration files that support both development and CI environments
- Include error handling and edge case testing in generated examples
- Provide integration examples with popular testing libraries and tools

## Installation & Setup

### Package Manager Installation

```bash
# npm/yarn installation
npm install -g [tool-name]
# or
yarn global add [tool-name]

# pip installation
pip install [tool-name]

# homebrew installation (macOS)
brew install [tool-name]

# Other platform-specific commands
[other installation methods]
```

### Project Integration

```bash
# Initialize in project
[tool] init

# Add to existing project
[project setup commands]
```

## Configuration

### Configuration File

```[config-format]
# [config-file-name] (e.g., .toolrc, tool.config.js, tool.yaml)
[configuration-example]
```

### Environment Variables

```bash
# Environment-specific settings
[TOOL_ENV_VAR]=[value]
[TOOL_CONFIG_PATH]=[path]
```

### CLI Configuration

```bash
# Global configuration
[tool] config set [option] [value]

# Project-specific configuration
[tool] config --local [option] [value]
```

## Core Features

### [Feature 1]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 2]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 3]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

## Common Commands

```bash
# Essential daily commands
[tool] [basic-command]              # Description
[tool] [frequent-command] [options] # Description
[tool] [status-command]             # Check status
[tool] [help-command]               # Get help

# Advanced operations
[tool] [advanced-command] [options] # Description
[tool] [config-command]             # Configuration management
[tool] [debug-command]              # Debugging and troubleshooting
```

## Workflow Integration

### Development Workflow

1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions
