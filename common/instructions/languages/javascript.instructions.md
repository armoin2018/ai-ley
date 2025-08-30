---
applyTo: "**/*.js,**/*.mjs,**/*.jsx"
---

# JavaScript Programming Instructions

Modern JavaScript development guidelines for AI coding assistants, emphasizing ES6+ features, best practices, and maintainable code patterns.

## 🧠 Context

- **Language**: JavaScript (ES2018+)
- **Environments**: Node.js, Browser, Deno
- **Common Frameworks**: Express.js, React, Vue.js, Angular
- **Package Managers**: npm, yarn, pnpm
- **Build Tools**: Webpack, Vite, Rollup, Parcel
- **Testing**: Jest, Mocha, Cypress, Playwright

## 📁 Project Structure

```text
src/
  components/       # Reusable UI components (React/Vue)
  controllers/      # API route handlers (Express)
  services/         # Business logic layer
  repositories/     # Data access layer
  utils/           # Utility functions
  types/           # Type definitions (JSDoc or TypeScript)
  config/          # Configuration files
  middleware/      # Express middleware
tests/
  unit/            # Unit tests
  integration/     # Integration tests
  e2e/            # End-to-end tests
docs/              # Documentation
public/           # Static assets (browser)
```

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, modern JavaScript using ES6+ features
- Prefer functional programming patterns where appropriate
- Use consistent formatting with Prettier
- Implement clear separation of concerns
- Follow the principle of least surprise
- Prioritize readability over cleverness

### Modern JavaScript Features
- Use `const` and `let` instead of `var`
- Prefer arrow functions for callbacks and short functions
- Use template literals for string interpolation
- Leverage destructuring for cleaner code
- Use async/await for asynchronous operations
- Utilize modules (import/export) for code organization

## 📜 Code Style and Conventions

### Variable and Function Naming

```javascript
// ✅ Good: Use camelCase for variables and functions
const userName = 'john_doe';
const userAge = 25;

function calculateUserScore(user) {
  return user.points * user.multiplier;
}

// ✅ Good: Use PascalCase for classes and constructors
class UserManager {
  constructor(database) {
    this.database = database;
  }
}

// ✅ Good: Use UPPER_SNAKE_CASE for constants
const MAX_RETRY_ATTEMPTS = 3;
const API_BASE_URL = 'https://api.example.com';

// ✅ Good: Use descriptive names
const isUserAuthenticated = checkAuthStatus();
const filteredUsers = users.filter(user => user.isActive);
```

### Function Design

```javascript
// ✅ Good: Pure functions with clear inputs/outputs
function calculateTax(amount, rate) {
  if (typeof amount !== 'number' || typeof rate !== 'number') {
    throw new Error('Amount and rate must be numbers');
  }
  
  if (amount < 0 || rate < 0) {
    throw new Error('Amount and rate must be non-negative');
  }
  
  return amount * rate;
}

// ✅ Good: Use JSDoc for documentation
/**
 * Fetches user data from the API
 * @param {string} userId - The unique identifier for the user
 * @param {Object} options - Additional options
 * @param {boolean} options.includeProfile - Whether to include profile data
 * @returns {Promise<Object>} The user data object
 * @throws {Error} When user is not found or network error occurs
 */
async function fetchUserData(userId, options = {}) {
  const { includeProfile = false } = options;
  
  try {
    const response = await api.get(`/users/${userId}`, {
      params: { includeProfile }
    });
    
    return response.data;
  } catch (error) {
    throw new Error(`Failed to fetch user data: ${error.message}`);
  }
}

// ✅ Good: Use arrow functions for short callbacks
const activeUsers = users.filter(user => user.isActive);
const userNames = users.map(user => user.name);
const totalScore = scores.reduce((sum, score) => sum + score, 0);
```

## 🔄 Asynchronous Programming

### Async/Await Best Practices

```javascript
// ✅ Good: Proper error handling with async/await
async function processUserData(userId) {
  try {
    const user = await fetchUser(userId);
    const profile = await fetchUserProfile(user.profileId);
    const preferences = await fetchUserPreferences(userId);
    
    return {
      ...user,
      profile,
      preferences
    };
  } catch (error) {
    console.error('Error processing user data:', error);
    throw new Error(`User processing failed: ${error.message}`);
  }
}

// ✅ Good: Concurrent operations with Promise.all
async function loadDashboardData(userId) {
  try {
    const [user, analytics, notifications] = await Promise.all([
      fetchUser(userId),
      fetchAnalytics(userId),
      fetchNotifications(userId)
    ]);
    
    return { user, analytics, notifications };
  } catch (error) {
    throw new Error(`Dashboard loading failed: ${error.message}`);
  }
}

// ✅ Good: Handle partial failures with Promise.allSettled
async function loadOptionalData(userId) {
  const results = await Promise.allSettled([
    fetchUserProfile(userId),
    fetchUserPreferences(userId),
    fetchUserStats(userId)
  ]);
  
  const data = {};
  results.forEach((result, index) => {
    if (result.status === 'fulfilled') {
      const keys = ['profile', 'preferences', 'stats'];
      data[keys[index]] = result.value;
    }
  });
  
  return data;
}
```

### Promise Best Practices

```javascript
// ✅ Good: Create promises for callback-based APIs
function readFileAsync(filename) {
  return new Promise((resolve, reject) => {
    fs.readFile(filename, 'utf8', (error, data) => {
      if (error) {
        reject(error);
      } else {
        resolve(data);
      }
    });
  });
}

// ✅ Good: Chain promises properly
function processData(input) {
  return validateInput(input)
    .then(transformData)
    .then(saveToDatabase)
    .then(sendNotification)
    .catch(handleError);
}
```

## 🛡️ Error Handling

### Comprehensive Error Handling

```javascript
// ✅ Custom error classes
class ValidationError extends Error {
  constructor(message, field) {
    super(message);
    this.name = 'ValidationError';
    this.field = field;
  }
}

class NetworkError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.name = 'NetworkError';
    this.statusCode = statusCode;
  }
}

// ✅ Error handling middleware (Express.js)
function errorHandler(error, req, res, next) {
  console.error('Error:', error);
  
  if (error instanceof ValidationError) {
    return res.status(400).json({
      error: 'Validation Error',
      message: error.message,
      field: error.field
    });
  }
  
  if (error instanceof NetworkError) {
    return res.status(error.statusCode).json({
      error: 'Network Error',
      message: error.message
    });
  }
  
  // Default error response
  res.status(500).json({
    error: 'Internal Server Error',
    message: 'An unexpected error occurred'
  });
}

// ✅ Graceful error handling in async functions
async function safeApiCall(url, options = {}) {
  const maxRetries = 3;
  let lastError;
  
  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      const response = await fetch(url, options);
      
      if (!response.ok) {
        throw new NetworkError(
          `HTTP ${response.status}: ${response.statusText}`,
          response.status
        );
      }
      
      return await response.json();
    } catch (error) {
      lastError = error;
      
      if (attempt < maxRetries && error instanceof NetworkError) {
        const delay = Math.pow(2, attempt) * 1000; // Exponential backoff
        await new Promise(resolve => setTimeout(resolve, delay));
        continue;
      }
      
      throw error;
    }
  }
  
  throw lastError;
}
```

## 🏗️ Object-Oriented Programming

### Classes and Inheritance

```javascript
// ✅ Good: Well-structured class with proper encapsulation
class UserService {
  #database;
  #cache;
  
  constructor(database, cache) {
    this.#database = database;
    this.#cache = cache;
  }
  
  async getUser(userId) {
    // Check cache first
    const cachedUser = await this.#cache.get(`user:${userId}`);
    if (cachedUser) {
      return cachedUser;
    }
    
    // Fetch from database
    const user = await this.#database.findUserById(userId);
    if (!user) {
      throw new Error(`User with ID ${userId} not found`);
    }
    
    // Cache the result
    await this.#cache.set(`user:${userId}`, user, { ttl: 300 });
    
    return user;
  }
  
  async updateUser(userId, updates) {
    const user = await this.getUser(userId);
    
    // Validate updates
    this.#validateUserUpdates(updates);
    
    // Update in database
    const updatedUser = await this.#database.updateUser(userId, updates);
    
    // Invalidate cache
    await this.#cache.delete(`user:${userId}`);
    
    return updatedUser;
  }
  
  #validateUserUpdates(updates) {
    const allowedFields = ['name', 'email', 'preferences'];
    const invalidFields = Object.keys(updates).filter(
      field => !allowedFields.includes(field)
    );
    
    if (invalidFields.length > 0) {
      throw new ValidationError(
        `Invalid fields: ${invalidFields.join(', ')}`,
        invalidFields[0]
      );
    }
  }
}
```

## 🔧 Functional Programming

### Higher-Order Functions and Composition

```javascript
// ✅ Function composition utilities
const pipe = (...fns) => value => fns.reduce((acc, fn) => fn(acc), value);
const compose = (...fns) => value => fns.reduceRight((acc, fn) => fn(acc), value);

// ✅ Utility functions
const curry = fn => (...args) => {
  if (args.length >= fn.length) {
    return fn(...args);
  }
  return (...nextArgs) => curry(fn)(...args, ...nextArgs);
};

// ✅ Data transformation pipeline
const processUsers = pipe(
  users => users.filter(user => user.isActive),
  users => users.map(user => ({
    ...user,
    fullName: `${user.firstName} ${user.lastName}`
  })),
  users => users.sort((a, b) => a.createdAt - b.createdAt)
);

// ✅ Curried functions for reusability
const filterBy = curry((predicate, array) => array.filter(predicate));
const mapTo = curry((mapper, array) => array.map(mapper));

const activeUsers = filterBy(user => user.isActive);
const userNames = mapTo(user => user.name);

// Usage
const result = pipe(
  activeUsers,
  userNames
)(allUsers);
```

## 🎯 Performance Optimization

### Efficient Code Patterns

```javascript
// ✅ Debouncing for frequent operations
function debounce(func, delay) {
  let timeoutId;
  
  return function debounced(...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func.apply(this, args), delay);
  };
}

// ✅ Throttling for rate limiting
function throttle(func, limit) {
  let inThrottle;
  
  return function throttled(...args) {
    if (!inThrottle) {
      func.apply(this, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
}

// ✅ Memoization for expensive calculations
function memoize(fn) {
  const cache = new Map();
  
  return function memoized(...args) {
    const key = JSON.stringify(args);
    
    if (cache.has(key)) {
      return cache.get(key);
    }
    
    const result = fn.apply(this, args);
    cache.set(key, result);
    
    return result;
  };
}

// ✅ Lazy evaluation for large datasets
function* lazyFilter(iterable, predicate) {
  for (const item of iterable) {
    if (predicate(item)) {
      yield item;
    }
  }
}

function* lazyMap(iterable, mapper) {
  for (const item of iterable) {
    yield mapper(item);
  }
}

// Usage
const largeDataset = [/* millions of items */];
const processedData = lazyMap(
  lazyFilter(largeDataset, item => item.isValid),
  item => ({ id: item.id, name: item.name })
);

// Only processes items as needed
for (const item of processedData) {
  if (someCondition) break; // Can exit early
  console.log(item);
}
```

## 🧪 Testing Guidelines

### Unit Testing with Jest

```javascript
// user.service.test.js
import { UserService } from '../src/services/user.service.js';

describe('UserService', () => {
  let userService;
  let mockDatabase;
  let mockCache;
  
  beforeEach(() => {
    mockDatabase = {
      findUserById: jest.fn(),
      updateUser: jest.fn()
    };
    
    mockCache = {
      get: jest.fn(),
      set: jest.fn(),
      delete: jest.fn()
    };
    
    userService = new UserService(mockDatabase, mockCache);
  });
  
  afterEach(() => {
    jest.clearAllMocks();
  });
  
  describe('getUser', () => {
    it('should return cached user when available', async () => {
      const userId = '123';
      const cachedUser = { id: userId, name: 'John Doe' };
      
      mockCache.get.mockResolvedValue(cachedUser);
      
      const result = await userService.getUser(userId);
      
      expect(result).toEqual(cachedUser);
      expect(mockCache.get).toHaveBeenCalledWith(`user:${userId}`);
      expect(mockDatabase.findUserById).not.toHaveBeenCalled();
    });
    
    it('should fetch from database when not cached', async () => {
      const userId = '123';
      const user = { id: userId, name: 'John Doe' };
      
      mockCache.get.mockResolvedValue(null);
      mockDatabase.findUserById.mockResolvedValue(user);
      
      const result = await userService.getUser(userId);
      
      expect(result).toEqual(user);
      expect(mockDatabase.findUserById).toHaveBeenCalledWith(userId);
      expect(mockCache.set).toHaveBeenCalledWith(
        `user:${userId}`,
        user,
        { ttl: 300 }
      );
    });
    
    it('should throw error when user not found', async () => {
      const userId = '123';
      
      mockCache.get.mockResolvedValue(null);
      mockDatabase.findUserById.mockResolvedValue(null);
      
      await expect(userService.getUser(userId))
        .rejects
        .toThrow(`User with ID ${userId} not found`);
    });
  });
});
```

### Integration Testing

```javascript
// api.integration.test.js
import request from 'supertest';
import app from '../src/app.js';

describe('User API', () => {
  beforeEach(async () => {
    await setupTestDatabase();
  });
  
  afterEach(async () => {
    await cleanupTestDatabase();
  });
  
  describe('GET /api/users/:id', () => {
    it('should return user data for valid ID', async () => {
      const user = await createTestUser({ name: 'John Doe' });
      
      const response = await request(app)
        .get(`/api/users/${user.id}`)
        .expect(200);
      
      expect(response.body).toMatchObject({
        id: user.id,
        name: 'John Doe'
      });
    });
    
    it('should return 404 for non-existent user', async () => {
      const response = await request(app)
        .get('/api/users/non-existent-id')
        .expect(404);
      
      expect(response.body.error).toBe('User not found');
    });
  });
});
```

## 📦 Module System

### ES6 Modules Best Practices

```javascript
// ✅ Named exports for utilities
// utils/validation.js
export function validateEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

export function validatePassword(password) {
  return password.length >= 8 && /[A-Za-z]/.test(password) && /\d/.test(password);
}

export const ValidationError = class extends Error {
  constructor(message, field) {
    super(message);
    this.name = 'ValidationError';
    this.field = field;
  }
};

// ✅ Default export for main class/function
// services/user.service.js
export default class UserService {
  // Class implementation
}

// ✅ Re-exports for clean API
// services/index.js
export { default as UserService } from './user.service.js';
export { default as AuthService } from './auth.service.js';
export { default as EmailService } from './email.service.js';

// ✅ Import patterns
// app.js
import express from 'express';
import { UserService, AuthService } from './services/index.js';
import { validateEmail, validatePassword } from './utils/validation.js';
```

## 🛠️ Development Tools

### Recommended Configuration

```javascript
// .eslintrc.js
module.exports = {
  env: {
    node: true,
    browser: true,
    es2022: true,
    jest: true
  },
  extends: [
    'eslint:recommended',
    '@eslint/js/recommended'
  ],
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: 'module'
  },
  rules: {
    'no-console': 'warn',
    'no-unused-vars': 'error',
    'prefer-const': 'error',
    'no-var': 'error',
    'prefer-arrow-callback': 'error',
    'prefer-template': 'error',
    'object-shorthand': 'error'
  }
};

// prettier.config.js
export default {
  semi: true,
  singleQuote: true,
  tabWidth: 2,
  trailingComma: 'es5',
  printWidth: 80,
  bracketSpacing: true,
  arrowParens: 'avoid'
};
```

## 🚫 Common Pitfalls to Avoid

- **Callback Hell**: Use async/await or promises instead of nested callbacks
- **Global Variables**: Minimize global scope pollution
- **== vs ===**: Always use strict equality unless specifically needed
- **Mutating Props**: Don't mutate function parameters or external objects
- **Memory Leaks**: Remove event listeners, clear intervals/timeouts
- **Blocking Operations**: Use async operations for I/O
- **Error Swallowing**: Always handle or propagate errors appropriately

## 📚 Resources

- [MDN JavaScript Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
- [JavaScript.info](https://javascript.info/)
- [ESLint Rules](https://eslint.org/docs/rules/)
- [Jest Testing Framework](https://jestjs.io/)
- [Node.js Documentation](https://nodejs.org/docs/)
- [You Don't Know JS Book Series](https://github.com/getify/You-Dont-Know-JS)