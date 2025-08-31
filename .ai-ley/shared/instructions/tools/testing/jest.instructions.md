
# Jest Testing Framework Instructions

## Tool Overview
- **Tool Name**: Jest
- **Version**: 29.7+ (stable), 30.0+ (latest with enhanced features)
- **Category**: Testing Tools
- **Purpose**: Comprehensive JavaScript testing framework with built-in assertions, mocking, and coverage
- **Prerequisites**: Node.js 16+ (18+ recommended), npm/yarn/pnpm

## Installation & Setup
### Basic Installation
```bash
# npm installation
npm install --save-dev jest
npm install --save-dev @types/jest  # TypeScript types

# yarn installation
yarn add --dev jest @types/jest

# pnpm installation
pnpm add -D jest @types/jest

# Initialize Jest configuration
npx jest --init

# Global installation (not recommended)
npm install -g jest
```

### TypeScript Setup
```bash
# Install TypeScript support
npm install --save-dev typescript ts-jest @types/jest

# Initialize TypeScript Jest config
npx ts-jest config:init

# Install additional TypeScript testing tools
npm install --save-dev ts-node @types/node
```

### React Testing Setup
```bash
# React Testing Library
npm install --save-dev @testing-library/react @testing-library/jest-dom @testing-library/user-event

# React Test Renderer (for snapshot testing)
npm install --save-dev react-test-renderer @types/react-test-renderer

# Jest environment for jsdom
npm install --save-dev jest-environment-jsdom
```

## Configuration

### Basic Configuration (jest.config.js)
```javascript
/** @type {import('jest').Config} */
module.exports = {
  // Test environment
  testEnvironment: 'node', // or 'jsdom' for browser-like environment
  
  // Test file patterns
  testMatch: [
    '**/__tests__/**/*.(js|jsx|ts|tsx)',
    '**/*.(test|spec).(js|jsx|ts|tsx)'
  ],
  
  // Coverage configuration
  collectCoverage: false,
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/index.js',
    '!src/setupTests.js'
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  
  // Setup files
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.js'],
  
  // Module name mapping for aliases
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '^components/(.*)$': '<rootDir>/src/components/$1'
  },
  
  // Transform configuration
  transform: {
    '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest'
  },
  
  // Module file extensions
  moduleFileExtensions: ['js', 'jsx', 'ts', 'tsx', 'json'],
  
  // Ignore patterns
  testPathIgnorePatterns: ['<rootDir>/node_modules/', '<rootDir>/build/'],
  
  // Clear mocks between tests
  clearMocks: true,
  
  // Verbose output
  verbose: true
}
```

### TypeScript Configuration (jest.config.js)
```javascript
/** @type {import('jest').Config} */
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  
  // TypeScript setup
  transform: {
    '^.+\\.tsx?$': 'ts-jest'
  },
  
  // Module resolution
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1'
  },
  
  // Setup files
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.ts'],
  
  // Test files
  testMatch: [
    '**/__tests__/**/*.ts?(x)',
    '**/*.(test|spec).ts?(x)'
  ],
  
  // Coverage
  collectCoverageFrom: [
    'src/**/*.{ts,tsx}',
    '!src/**/*.d.ts',
    '!src/types/**/*'
  ],
  
  // TypeScript configuration
  globals: {
    'ts-jest': {
      tsconfig: 'tsconfig.json'
    }
  }
}
```

### React Configuration (jest.config.js)
```javascript
/** @type {import('jest').Config} */
module.exports = {
  testEnvironment: 'jsdom',
  
  // Setup files
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.js'],
  
  // Transform configuration
  transform: {
    '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest',
    '^.+\\.css$': 'jest-transform-css'
  },
  
  // Module name mapping
  moduleNameMapping: {
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
    '\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$': 'jest-transform-file'
  },
  
  // Test files
  testMatch: [
    '<rootDir>/src/**/__tests__/**/*.{js,jsx,ts,tsx}',
    '<rootDir>/src/**/*.(test|spec).{js,jsx,ts,tsx}'
  ],
  
  // Coverage
  collectCoverageFrom: [
    'src/**/*.{js,jsx,ts,tsx}',
    '!src/**/*.d.ts',
    '!src/index.tsx',
    '!src/reportWebVitals.ts'
  ],
  
  // Additional options
  moduleFileExtensions: ['js', 'jsx', 'ts', 'tsx'],
  watchPlugins: [
    'jest-watch-typeahead/filename',
    'jest-watch-typeahead/testname'
  ]
}
```

### Advanced Configuration
```javascript
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
```

## Core Features

### Test Structure
- **Purpose**: Organize tests with describe blocks and individual test cases
- **Usage**: Group related tests and define test scenarios
- **Example**:
```javascript
// Basic test structure
describe('Calculator', () => {
  describe('addition', () => {
    test('should add two positive numbers', () => {
      expect(add(2, 3)).toBe(5)
    })
    
    test('should add negative numbers', () => {
      expect(add(-2, -3)).toBe(-5)
    })
    
    test('should handle zero', () => {
      expect(add(0, 5)).toBe(5)
      expect(add(5, 0)).toBe(5)
    })
  })
  
  describe('division', () => {
    test('should divide numbers correctly', () => {
      expect(divide(10, 2)).toBe(5)
    })
    
    test('should throw error when dividing by zero', () => {
      expect(() => divide(10, 0)).toThrow('Division by zero')
    })
  })
})

// Async testing
describe('Async operations', () => {
  test('should resolve promise', async () => {
    const result = await fetchData()
    expect(result).toBeDefined()
  })
  
  test('should handle promise rejection', async () => {
    await expect(fetchInvalidData()).rejects.toThrow('Invalid data')
  })
})
```

### Assertions (Matchers)
- **Purpose**: Verify that values meet certain conditions
- **Usage**: Use Jest's built-in matchers to test various conditions
- **Example**:
```javascript
describe('Jest matchers', () => {
  test('common matchers', () => {
    // Exact equality
    expect(2 + 2).toBe(4)
    expect({ name: 'John' }).toEqual({ name: 'John' })
    
    // Truthiness
    expect(true).toBeTruthy()
    expect(false).toBeFalsy()
    expect(null).toBeNull()
    expect(undefined).toBeUndefined()
    expect('Hello').toBeDefined()
    
    // Numbers
    expect(2 + 2).toBeGreaterThan(3)
    expect(Math.PI).toBeCloseTo(3.14159, 5)
    
    // Strings
    expect('Hello World').toMatch(/World/)
    expect('Jest testing').toContain('test')
    
    // Arrays and iterables
    expect(['apple', 'banana', 'orange']).toContain('banana')
    expect(['a', 'b', 'c']).toHaveLength(3)
    
    // Objects
    expect({ name: 'John', age: 30 }).toHaveProperty('name')
    expect({ name: 'John', age: 30 }).toHaveProperty('age', 30)
    
    // Exceptions
    expect(() => {
      throw new Error('Something went wrong')
    }).toThrow('Something went wrong')
  })
  
  test('custom matchers', () => {
    // Array matchers
    expect([1, 2, 3]).toEqual(expect.arrayContaining([1, 3]))
    expect(['a', 'b', 'c']).toEqual(expect.arrayContaining(['a']))
    
    // Object matchers
    expect({ name: 'John', age: 30, city: 'NYC' }).toMatchObject({
      name: 'John',
      age: 30
    })
    
    // Any type matchers
    expect('string').toEqual(expect.any(String))
    expect(123).toEqual(expect.any(Number))
    expect({ id: 1 }).toEqual({ id: expect.any(Number) })
  })
})
```

### Mocking
- **Purpose**: Replace real implementations with mock functions for testing
- **Usage**: Mock modules, functions, and external dependencies
- **Example**:
```javascript
// Mock functions
describe('Mock functions', () => {
  test('mock implementation', () => {
    const mockCallback = jest.fn(x => x * 2)
    const result = [1, 2, 3].map(mockCallback)
    
    expect(result).toEqual([2, 4, 6])
    expect(mockCallback).toHaveBeenCalledTimes(3)
    expect(mockCallback).toHaveBeenCalledWith(1)
    expect(mockCallback).toHaveBeenLastCalledWith(3)
  })
  
  test('mock return values', () => {
    const mockFn = jest.fn()
    mockFn.mockReturnValue(42)
    mockFn.mockReturnValueOnce(10)
    
    expect(mockFn()).toBe(10) // First call
    expect(mockFn()).toBe(42) // Subsequent calls
  })
  
  test('mock resolved values', async () => {
    const mockAsyncFn = jest.fn()
    mockAsyncFn.mockResolvedValue('async result')
    
    const result = await mockAsyncFn()
    expect(result).toBe('async result')
  })
})

// Module mocking
jest.mock('../services/api', () => ({
  fetchUser: jest.fn(() => Promise.resolve({ id: 1, name: 'John' })),
  createUser: jest.fn(() => Promise.resolve({ id: 2, name: 'Jane' }))
}))

describe('API service', () => {
  const { fetchUser, createUser } = require('../services/api')
  
  test('should fetch user', async () => {
    const user = await fetchUser(1)
    expect(user).toEqual({ id: 1, name: 'John' })
    expect(fetchUser).toHaveBeenCalledWith(1)
  })
})

// Partial mocking
jest.mock('../utils/helpers', () => ({
  ...jest.requireActual('../utils/helpers'),
  getCurrentDate: jest.fn(() => new Date('2023-01-01'))
}))

// Mock implementation
const axios = require('axios')
jest.mock('axios')
const mockedAxios = axios as jest.Mocked<typeof axios>

describe('HTTP requests', () => {
  test('should fetch data', async () => {
    const data = { users: [{ id: 1, name: 'John' }] }
    mockedAxios.get.mockResolvedValue({ data })
    
    const response = await fetchUsers()
    expect(response).toEqual(data.users)
    expect(mockedAxios.get).toHaveBeenCalledWith('/api/users')
  })
})
```

## Common Commands
```bash
# Test execution
jest                              # Run all tests
jest user.test.js                 # Run specific test file
jest --testPathPattern=user       # Run tests matching pattern
jest --testNamePattern="should add" # Run tests with specific name

# Watch modes
jest --watch                      # Watch mode (git files)
jest --watchAll                   # Watch all files
jest --watch --verbose            # Watch with verbose output

# Coverage reporting
jest --coverage                   # Generate coverage report
jest --coverage --watchAll        # Coverage in watch mode
jest --collectCoverageFrom="src/**/*.js" # Specific coverage files

# Debug and development
jest --verbose                    # Detailed test output
jest --silent                     # Minimal output
jest --no-cache                   # Disable cache
jest --clearCache                 # Clear Jest cache

# Specific test runs
jest --runInBand                  # Run tests serially
jest --maxWorkers=4               # Limit concurrent workers
jest --bail                       # Stop on first failure
jest --passWithNoTests            # Don't fail when no tests found

# Configuration and setup
jest --init                       # Initialize Jest configuration
jest --showConfig                 # Show resolved configuration
jest --listTests                  # List all test files
jest --findRelatedTests file.js   # Find tests related to files

# Snapshot testing
jest --updateSnapshot             # Update snapshots
jest --updateSnapshot --testPathPattern=component # Update specific snapshots

# CI/CD options
jest --ci                         # Optimize for CI environments
jest --forceExit                  # Force Jest to exit
jest --detectOpenHandles          # Detect handles preventing exit
```

## Advanced Features

### Snapshot Testing
```javascript
import { render } from '@testing-library/react'
import Button from '../Button'

describe('Button component', () => {
  test('renders correctly', () => {
    const { container } = render(<Button>Click me</Button>)
    expect(container.firstChild).toMatchSnapshot()
  })
  
  test('renders with different props', () => {
    const { container } = render(
      <Button variant="primary" size="large" disabled>
        Submit
      </Button>
    )
    expect(container.firstChild).toMatchSnapshot()
  })
  
  test('inline snapshot', () => {
    const user = { id: 1, name: 'John Doe', email: 'john@example.com' }
    expect(user).toMatchInlineSnapshot(`
      Object {
        "email": "john@example.com",
        "id": 1,
        "name": "John Doe",
      }
    `)
  })
})

// Custom snapshot serializer
expect.addSnapshotSerializer({
  test: (val) => val && val.hasOwnProperty('$$typeof'),
  print: (val, serialize) => serialize(val.props)
})
```

### Setup and Teardown
```javascript
describe('Database tests', () => {
  let db
  
  // Run once before all tests in this describe block
  beforeAll(async () => {
    db = await connectToDatabase()
  })
  
  // Run once after all tests in this describe block
  afterAll(async () => {
    await db.close()
  })
  
  // Run before each test
  beforeEach(async () => {
    await db.clear()
    await db.seed()
  })
  
  // Run after each test
  afterEach(async () => {
    await db.cleanup()
  })
  
  test('should create user', async () => {
    const user = await db.createUser({ name: 'John' })
    expect(user.id).toBeDefined()
  })
  
  test('should find user', async () => {
    await db.createUser({ name: 'John' })
    const user = await db.findUser({ name: 'John' })
    expect(user).toBeDefined()
  })
})
```

### Custom Matchers
```javascript
// Custom matcher definition
expect.extend({
  toBeWithinRange(received, floor, ceiling) {
    const pass = received >= floor && received <= ceiling
    if (pass) {
      return {
        message: () => `expected ${received} not to be within range ${floor} - ${ceiling}`,
        pass: true
      }
    } else {
      return {
        message: () => `expected ${received} to be within range ${floor} - ${ceiling}`,
        pass: false
      }
    }
  },
  
  toBeValidEmail(received) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    const pass = emailRegex.test(received)
    
    return {
      message: () => pass 
        ? `expected ${received} not to be a valid email`
        : `expected ${received} to be a valid email`,
      pass
    }
  }
})

// Usage
describe('Custom matchers', () => {
  test('should be within range', () => {
    expect(100).toBeWithinRange(90, 110)
  })
  
  test('should be valid email', () => {
    expect('user@example.com').toBeValidEmail()
    expect('invalid-email').not.toBeValidEmail()
  })
})
```

## Testing Patterns

### React Component Testing
```javascript
import React from 'react'
import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import '@testing-library/jest-dom'
import TodoList from '../TodoList'

describe('TodoList component', () => {
  const mockTodos = [
    { id: 1, text: 'Learn Jest', completed: false },
    { id: 2, text: 'Write tests', completed: true }
  ]
  
  test('renders todo items', () => {
    render(<TodoList todos={mockTodos} />)
    
    expect(screen.getByText('Learn Jest')).toBeInTheDocument()
    expect(screen.getByText('Write tests')).toBeInTheDocument()
  })
  
  test('adds new todo', async () => {
    const mockOnAdd = jest.fn()
    const user = userEvent.setup()
    
    render(<TodoList todos={[]} onAdd={mockOnAdd} />)
    
    const input = screen.getByPlaceholderText('Add new todo')
    const button = screen.getByText('Add')
    
    await user.type(input, 'New todo item')
    await user.click(button)
    
    expect(mockOnAdd).toHaveBeenCalledWith('New todo item')
  })
  
  test('toggles todo completion', async () => {
    const mockOnToggle = jest.fn()
    const user = userEvent.setup()
    
    render(<TodoList todos={mockTodos} onToggle={mockOnToggle} />)
    
    const checkbox = screen.getByRole('checkbox', { name: /learn jest/i })
    await user.click(checkbox)
    
    expect(mockOnToggle).toHaveBeenCalledWith(1)
  })
  
  test('handles loading state', () => {
    render(<TodoList todos={[]} loading={true} />)
    expect(screen.getByText('Loading...')).toBeInTheDocument()
  })
  
  test('handles error state', () => {
    render(<TodoList todos={[]} error="Failed to load todos" />)
    expect(screen.getByText('Failed to load todos')).toBeInTheDocument()
  })
})
```

### API Testing
```javascript
import { fetchUser, createUser, updateUser } from '../api/users'
import axios from 'axios'

jest.mock('axios')
const mockedAxios = axios as jest.Mocked<typeof axios>

describe('Users API', () => {
  afterEach(() => {
    jest.clearAllMocks()
  })
  
  describe('fetchUser', () => {
    test('should fetch user successfully', async () => {
      const userData = { id: 1, name: 'John Doe', email: 'john@example.com' }
      mockedAxios.get.mockResolvedValue({ data: userData })
      
      const result = await fetchUser(1)
      
      expect(result).toEqual(userData)
      expect(mockedAxios.get).toHaveBeenCalledWith('/api/users/1')
    })
    
    test('should handle fetch error', async () => {
      mockedAxios.get.mockRejectedValue(new Error('Network error'))
      
      await expect(fetchUser(1)).rejects.toThrow('Network error')
    })
  })
  
  describe('createUser', () => {
    test('should create user successfully', async () => {
      const newUser = { name: 'Jane Doe', email: 'jane@example.com' }
      const createdUser = { id: 2, ...newUser }
      
      mockedAxios.post.mockResolvedValue({ data: createdUser })
      
      const result = await createUser(newUser)
      
      expect(result).toEqual(createdUser)
      expect(mockedAxios.post).toHaveBeenCalledWith('/api/users', newUser)
    })
    
    test('should handle validation errors', async () => {
      const invalidUser = { name: '', email: 'invalid-email' }
      const errorResponse = {
        response: {
          status: 400,
          data: { errors: ['Name is required', 'Invalid email format'] }
        }
      }
      
      mockedAxios.post.mockRejectedValue(errorResponse)
      
      await expect(createUser(invalidUser)).rejects.toMatchObject({
        response: { status: 400 }
      })
    })
  })
})
```

### Utility Functions Testing
```javascript
import { 
  formatCurrency, 
  debounce, 
  deepClone, 
  validateEmail,
  calculateAge 
} from '../utils/helpers'

describe('Utility functions', () => {
  describe('formatCurrency', () => {
    test('should format positive numbers', () => {
      expect(formatCurrency(1234.56)).toBe('$1,234.56')
      expect(formatCurrency(0)).toBe('$0.00')
    })
    
    test('should format negative numbers', () => {
      expect(formatCurrency(-1234.56)).toBe('-$1,234.56')
    })
    
    test('should handle different currencies', () => {
      expect(formatCurrency(1234.56, 'EUR')).toBe('€1,234.56')
      expect(formatCurrency(1234.56, 'GBP')).toBe('£1,234.56')
    })
  })
  
  describe('debounce', () => {
    beforeEach(() => {
      jest.useFakeTimers()
    })
    
    afterEach(() => {
      jest.useRealTimers()
    })
    
    test('should delay function execution', () => {
      const mockFn = jest.fn()
      const debouncedFn = debounce(mockFn, 1000)
      
      debouncedFn('arg1')
      debouncedFn('arg2')
      debouncedFn('arg3')
      
      expect(mockFn).not.toHaveBeenCalled()
      
      jest.advanceTimersByTime(1000)
      
      expect(mockFn).toHaveBeenCalledTimes(1)
      expect(mockFn).toHaveBeenCalledWith('arg3')
    })
  })
  
  describe('deepClone', () => {
    test('should clone primitive values', () => {
      expect(deepClone(42)).toBe(42)
      expect(deepClone('hello')).toBe('hello')
      expect(deepClone(true)).toBe(true)
      expect(deepClone(null)).toBe(null)
    })
    
    test('should clone objects', () => {
      const original = { a: 1, b: { c: 2 } }
      const cloned = deepClone(original)
      
      expect(cloned).toEqual(original)
      expect(cloned).not.toBe(original)
      expect(cloned.b).not.toBe(original.b)
    })
    
    test('should clone arrays', () => {
      const original = [1, [2, 3], { a: 4 }]
      const cloned = deepClone(original)
      
      expect(cloned).toEqual(original)
      expect(cloned).not.toBe(original)
      expect(cloned[1]).not.toBe(original[1])
    })
  })
  
  describe('validateEmail', () => {
    test('should validate correct emails', () => {
      expect(validateEmail('user@example.com')).toBe(true)
      expect(validateEmail('test.email+tag@domain.co.uk')).toBe(true)
    })
    
    test('should reject invalid emails', () => {
      expect(validateEmail('invalid-email')).toBe(false)
      expect(validateEmail('user@')).toBe(false)
      expect(validateEmail('@domain.com')).toBe(false)
      expect(validateEmail('')).toBe(false)
    })
  })
  
  describe('calculateAge', () => {
    beforeEach(() => {
      jest.useFakeTimers()
      jest.setSystemTime(new Date('2023-06-15'))
    })
    
    afterEach(() => {
      jest.useRealTimers()
    })
    
    test('should calculate age correctly', () => {
      expect(calculateAge(new Date('1990-06-15'))).toBe(33)
      expect(calculateAge(new Date('1990-06-16'))).toBe(32) // Birthday hasn't passed
      expect(calculateAge(new Date('1990-06-14'))).toBe(33) // Birthday has passed
    })
  })
})
```

### Error Handling Testing
```javascript
describe('Error handling', () => {
  test('should handle synchronous errors', () => {
    function throwError() {
      throw new Error('Something went wrong')
    }
    
    expect(() => throwError()).toThrow('Something went wrong')
    expect(() => throwError()).toThrow(Error)
    expect(() => throwError()).toThrow(/went wrong/)
  })
  
  test('should handle async errors', async () => {
    async function asyncError() {
      throw new Error('Async error')
    }
    
    await expect(asyncError()).rejects.toThrow('Async error')
    await expect(asyncError()).rejects.toBeInstanceOf(Error)
  })
  
  test('should handle custom errors', () => {
    class CustomError extends Error {
      constructor(message, code) {
        super(message)
        this.name = 'CustomError'
        this.code = code
      }
    }
    
    function throwCustomError() {
      throw new CustomError('Custom error message', 'CUSTOM_001')
    }
    
    expect(() => throwCustomError()).toThrow(CustomError)
    expect(() => throwCustomError()).toThrow(expect.objectContaining({
      message: 'Custom error message',
      code: 'CUSTOM_001'
    }))
  })
})
```

## Environment-Specific Configuration

### package.json Scripts
```json
{
  "scripts": {
    "test": "jest",
    "test:watch": "jest --watch",
    "test:coverage": "jest --coverage",
    "test:ci": "jest --ci --coverage --watchAll=false",
    "test:debug": "node --inspect-brk node_modules/.bin/jest --runInBand",
    "test:unit": "jest --testPathPattern=unit",
    "test:integration": "jest --testPathPattern=integration",
    "test:e2e": "jest --testPathPattern=e2e",
    "test:update-snapshots": "jest --updateSnapshot"
  }
}
```

### CI/CD Configuration
```yaml
# GitHub Actions (.github/workflows/test.yml)
name: Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    strategy:
      matrix:
        node-version: [16, 18, 20]
    
    steps:
    - uses: actions/checkout@v4
    - name: Use Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v4
      with:
        node-version: ${{ matrix.node-version }}
        cache: 'npm'
    
    - run: npm ci
    - run: npm run test:ci
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage/lcov.info
```

### Docker Integration
```dockerfile
# Dockerfile for testing
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci --only=production

# Copy source code
COPY . .

# Run tests
CMD ["npm", "test"]
```

## Common Issues & Solutions

### Mocking Issues
**Problem**: Mock not working or being overridden
**Solution**: Proper mock placement and clearing
```javascript
// ❌ Bad: Mock after import
import { fetchData } from './api'
jest.mock('./api')

// ✅ Good: Mock before import
jest.mock('./api')
import { fetchData } from './api'

// ❌ Bad: Not clearing mocks
describe('Tests', () => {
  test('first test', () => {
    // Mock setup
  })
  test('second test', () => {
    // Mock might have state from previous test
  })
})

// ✅ Good: Clear mocks
describe('Tests', () => {
  afterEach(() => {
    jest.clearAllMocks()
  })
})
```

### Async Testing Issues
**Problem**: Tests passing when they should fail
**Solution**: Proper async/await usage
```javascript
// ❌ Bad: Missing await
test('async test', () => {
  return fetchData().then(data => {
    expect(data).toBeDefined()
  })
})

// ✅ Good: Using async/await
test('async test', async () => {
  const data = await fetchData()
  expect(data).toBeDefined()
})
```

### Memory Leaks
**Problem**: Tests running slowly or failing due to memory issues
**Solution**: Proper cleanup and mocking
```javascript
// ❌ Bad: No cleanup
describe('Timer tests', () => {
  test('should run timer', () => {
    setInterval(() => {}, 1000) // This keeps running
  })
})

// ✅ Good: Cleanup
describe('Timer tests', () => {
  beforeEach(() => {
    jest.useFakeTimers()
  })
  
  afterEach(() => {
    jest.useRealTimers()
  })
})
```

## Useful Resources
- **Official Documentation**: https://jestjs.io/docs/getting-started
- **API Reference**: https://jestjs.io/docs/api
- **Expect API**: https://jestjs.io/docs/expect
- **Mock Functions**: https://jestjs.io/docs/mock-functions
- **Testing Library**: https://testing-library.com/docs/react-testing-library/intro

## Tool-Specific Guidelines

### Best Practices
- Write descriptive test names that explain what is being tested
- Use `describe` blocks to group related tests logically
- Mock external dependencies to ensure test isolation
- Test both success and error scenarios
- Use setup/teardown methods for common test preparation

### Performance Tips
- Use `--maxWorkers` to optimize parallel execution
- Mock heavy operations and external services
- Use `--onlyChanged` to run only tests related to changed files
- Configure coverage collection to avoid performance overhead
- Use `--cache` to speed up subsequent test runs

### Security Considerations
- Never commit real API keys or credentials in test files
- Use environment variables for sensitive test configuration
- Mock authentication services rather than using real credentials
- Validate input sanitization in your tests
- Test authorization boundaries and access controls

## Version Compatibility
- **Node.js**: 16+ (18+ recommended)
- **TypeScript**: 4.3+ (with ts-jest)
- **Babel**: 7+ (for modern JavaScript features)
- **React**: 16.8+ (with React Testing Library)

## Troubleshooting

### Common Error Messages
- **Error**: `Cannot find module` during imports
  **Cause**: Module path resolution issues
  **Solution**: Check `moduleNameMapping` in jest.config.js

- **Error**: `ReferenceError: regeneratorRuntime is not defined`
  **Cause**: Missing async/await support
  **Solution**: Install and configure @babel/preset-env

- **Error**: `Tests are not defined`
  **Cause**: Jest not finding test files
  **Solution**: Check `testMatch` patterns in configuration

- **Error**: `Cannot read property of undefined`
  **Cause**: Improper mocking or missing setup
  **Solution**: Verify mock implementations and setup files