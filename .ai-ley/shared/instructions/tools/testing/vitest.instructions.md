# Vitest Testing Framework Instructions

## Tool Overview
- **Tool Name**: Vitest
- **Version**: 0.34+ (stable), 1.0+ (latest with enhanced features)
- **Category**: Testing Tools
- **Purpose**: Blazing fast unit testing framework powered by Vite
- **Prerequisites**: Node.js 16+, Vite project (recommended), npm/yarn/pnpm

## Installation & Setup
### Package Manager Installation
```bash
# npm installation
npm install --save-dev vitest

# yarn installation
yarn add --dev vitest

# pnpm installation
pnpm add -D vitest

# With additional testing utilities
npm install --save-dev vitest @vitest/ui @testing-library/jest-dom
npm install --save-dev @testing-library/react @testing-library/user-event

# For coverage reporting
npm install --save-dev @vitest/coverage-v8
# or
npm install --save-dev @vitest/coverage-istanbul
```

### Project Integration
```bash
# Add test scripts to package.json
{
  "scripts": {
    "test": "vitest",
    "test:run": "vitest run",
    "test:watch": "vitest watch",
    "test:ui": "vitest --ui",
    "test:coverage": "vitest run --coverage"
  }
}

# Create basic test file
mkdir src/__tests__
touch src/__tests__/example.test.ts

# Initialize configuration (optional)
npx vitest init
```

## Configuration

### vitest.config.ts (Basic)
```typescript
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    // Test environment
    environment: 'jsdom', // or 'node', 'happy-dom'

    // Global test setup
    globals: true,
    setupFiles: ['./src/test/setup.ts'],

    // File patterns
    include: ['**/*.{test,spec}.{js,mjs,cjs,ts,mts,cts,jsx,tsx}'],
    exclude: ['node_modules', 'dist', '.idea', '.git', '.cache'],

    // Coverage configuration
    coverage: {
      provider: 'v8', // or 'istanbul'
      reporter: ['text', 'json', 'html'],
      exclude: [
        'coverage/**',
        'dist/**',
        'packages/*/test{,s}/**',
        '**/*.d.ts',
        '**/{karma,rollup,webpack,vite,vitest,jest,ava,babel,nyc,cypress,tsup,build}.config.*',
        '**/.{eslint,mocha,prettier}rc.{js,cjs,yml}',
      ],
    },
  },
})
```

### Advanced Configuration
```typescript
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import { resolve } from 'path'

export default defineConfig({
  plugins: [react()],

  test: {
    // Environment configuration
    environment: 'jsdom',
    environmentOptions: {
      jsdom: {
        resources: 'usable',
      },
    },

    // Global setup
    globals: true,
    setupFiles: [
      './src/test/setup.ts',
      './src/test/mocks.ts',
    ],

    // Path resolution
    alias: {
      '@': resolve(__dirname, './src'),
      '@components': resolve(__dirname, './src/components'),
      '@utils': resolve(__dirname, './src/utils'),
    },

    // Test patterns
    include: [
      'src/**/*.{test,spec}.{js,ts,jsx,tsx}',
      'tests/**/*.{test,spec}.{js,ts,jsx,tsx}',
    ],
    exclude: [
      'node_modules',
      'dist',
      'e2e',
      '**/*.d.ts',
    ],

    // Timeouts
    testTimeout: 10000,
    hookTimeout: 10000,

    // Reporter configuration
    reporter: ['verbose', 'json', 'html'],
    outputFile: {
      json: './test-results.json',
      html: './test-results.html',
    },

    // Coverage settings
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json-summary', 'html', 'lcov'],
      reportsDirectory: './coverage',
      exclude: [
        'coverage/**',
        'dist/**',
        '**/*.d.ts',
        '**/*.config.*',
        '**/node_modules/**',
        'src/main.tsx',
        'src/vite-env.d.ts',
      ],
      thresholds: {
        global: {
          branches: 80,
          functions: 80,
          lines: 80,
          statements: 80,
        },
      },
    },

    // Watch mode configuration
    watch: {
      ignore: ['node_modules/**', 'dist/**'],
    },

    // Browser testing
    browser: {
      enabled: false,
      name: 'chrome', // or 'firefox', 'webkit'
      provider: 'playwright', // or 'webdriverio'
      headless: true,
    },

    // Workspace configuration for monorepos
    workspace: [
      'packages/*/vitest.config.{e2e,unit}.ts',
    ],
  },

  // Resolve configuration
  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
    },
  },
})
```

### Setup Files
```typescript
// src/test/setup.ts
import { expect, afterEach } from 'vitest'
import { cleanup } from '@testing-library/react'
import matchers from '@testing-library/jest-dom/matchers'

// Extend Vitest's expect with jest-dom matchers
expect.extend(matchers)

// Global test setup
beforeAll(() => {
  // Global setup code
})

afterEach(() => {
  cleanup() // Cleanup React Testing Library
})

// Mock window.matchMedia
Object.defineProperty(window, 'matchMedia', {
  writable: true,
  value: vi.fn().mockImplementation(query => ({
    matches: false,
    media: query,
    onchange: null,
    addListener: vi.fn(), // deprecated
    removeListener: vi.fn(), // deprecated
    addEventListener: vi.fn(),
    removeEventListener: vi.fn(),
    dispatchEvent: vi.fn(),
  })),
})

// Mock IntersectionObserver
global.IntersectionObserver = vi.fn().mockImplementation(() => ({
  observe: vi.fn(),
  unobserve: vi.fn(),
  disconnect: vi.fn(),
}))
```

### Mock Configuration
```typescript
// src/test/mocks.ts
import { vi } from 'vitest'

// Mock external dependencies
vi.mock('axios', () => ({
  default: {
    get: vi.fn(),
    post: vi.fn(),
    put: vi.fn(),
    delete: vi.fn(),
  },
}))

// Mock browser APIs
vi.mock('localStorage', () => ({
  getItem: vi.fn(),
  setItem: vi.fn(),
  removeItem: vi.fn(),
  clear: vi.fn(),
}))

// Mock environment variables
vi.mock('@/config/env', () => ({
  API_URL: 'http://localhost:3000/api',
  NODE_ENV: 'test',
}))
```

## Core Features

### Unit Testing
- **Purpose**: Test individual functions and components in isolation
- **Usage**: Write focused tests for specific functionality
- **Example**:
```typescript
// src/utils/math.ts
export function add(a: number, b: number): number {
  return a + b
}

export function divide(a: number, b: number): number {
  if (b === 0) {
    throw new Error('Division by zero')
  }
  return a / b
}

// src/utils/__tests__/math.test.ts
import { describe, it, expect } from 'vitest'
import { add, divide } from '../math'

describe('Math utilities', () => {
  describe('add', () => {
    it('should add two numbers correctly', () => {
      expect(add(2, 3)).toBe(5)
      expect(add(-1, 1)).toBe(0)
      expect(add(0, 0)).toBe(0)
    })

    it('should handle floating point numbers', () => {
      expect(add(0.1, 0.2)).toBeCloseTo(0.3)
    })
  })

  describe('divide', () => {
    it('should divide two numbers correctly', () => {
      expect(divide(10, 2)).toBe(5)
      expect(divide(7, 2)).toBe(3.5)
    })

    it('should throw error for division by zero', () => {
      expect(() => divide(10, 0)).toThrow('Division by zero')
    })
  })
})
```

### Component Testing (React)
- **Purpose**: Test React components behavior and rendering
- **Usage**: Test component props, state, events, and DOM interaction
- **Example**:
```typescript
// src/components/Button.tsx
import React from 'react'

interface ButtonProps {
  children: React.ReactNode
  onClick?: () => void
  disabled?: boolean
  variant?: 'primary' | 'secondary'
}

export function Button({
  children,
  onClick,
  disabled = false,
  variant = 'primary'
}: ButtonProps) {
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`btn btn--${variant}`}
      data-testid="button"
    >
      {children}
    </button>
  )
}

// src/components/__tests__/Button.test.tsx
import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { Button } from '../Button'

describe('Button', () => {
  it('renders children correctly', () => {
    render(<Button>Click me</Button>)
    expect(screen.getByText('Click me')).toBeInTheDocument()
  })

  it('applies correct CSS classes', () => {
    render(<Button variant="secondary">Test</Button>)
    const button = screen.getByTestId('button')
    expect(button).toHaveClass('btn', 'btn--secondary')
  })

  it('handles click events', async () => {
    const handleClick = vi.fn()
    const user = userEvent.setup()

    render(<Button onClick={handleClick}>Click me</Button>)

    await user.click(screen.getByText('Click me'))
    expect(handleClick).toHaveBeenCalledTimes(1)
  })

  it('respects disabled state', async () => {
    const handleClick = vi.fn()
    const user = userEvent.setup()

    render(
      <Button onClick={handleClick} disabled>
        Disabled
      </Button>
    )

    const button = screen.getByTestId('button')
    expect(button).toBeDisabled()

    await user.click(button)
    expect(handleClick).not.toHaveBeenCalled()
  })
})
```

### Mocking and Spying
- **Purpose**: Replace dependencies with controlled test doubles
- **Usage**: Mock external APIs, modules, and functions
- **Example**:
```typescript
// src/services/api.ts
export async function fetchUser(id: string) {
  const response = await fetch(`/api/users/${id}`)
  if (!response.ok) {
    throw new Error('Failed to fetch user')
  }
  return response.json()
}

// src/services/__tests__/api.test.ts
import { describe, it, expect, vi, beforeEach } from 'vitest'
import { fetchUser } from '../api'

// Mock global fetch
global.fetch = vi.fn()

describe('API service', () => {
  beforeEach(() => {
    vi.resetAllMocks()
  })

  describe('fetchUser', () => {
    it('should fetch user successfully', async () => {
      const mockUser = { id: '1', name: 'John Doe' }

      vi.mocked(fetch).mockResolvedValueOnce({
        ok: true,
        json: async () => mockUser,
      } as Response)

      const result = await fetchUser('1')

      expect(fetch).toHaveBeenCalledWith('/api/users/1')
      expect(result).toEqual(mockUser)
    })

    it('should throw error on failed request', async () => {
      vi.mocked(fetch).mockResolvedValueOnce({
        ok: false,
        status: 404,
      } as Response)

      await expect(fetchUser('999')).rejects.toThrow('Failed to fetch user')
    })
  })
})

// Module mocking
vi.mock('../config', () => ({
  API_BASE_URL: 'http://test-api.com',
}))

// Partial mocking
vi.mock('../utils', async () => {
  const actual = await vi.importActual('../utils')
  return {
    ...actual,
    formatDate: vi.fn(() => '2023-01-01'),
  }
})

// Mock implementation
const mockLogger = {
  info: vi.fn(),
  error: vi.fn(),
  warn: vi.fn(),
}

vi.mock('../logger', () => ({
  default: mockLogger,
}))
```

## Common Commands
```bash
# Basic test execution
npm test                           # Run tests in watch mode
npm run test:run                   # Run tests once
npm run test:watch                 # Explicit watch mode

# Test filtering
npx vitest math                    # Run tests matching "math"
npx vitest --run src/utils         # Run tests in specific directory
npx vitest button.test.ts          # Run specific test file

# Coverage reporting
npm run test:coverage              # Run with coverage
npx vitest --coverage              # Direct coverage command
npx vitest --coverage.enabled      # Enable coverage flag

# UI and reporting
npm run test:ui                    # Open Vitest UI
npx vitest --ui                    # Direct UI command
npx vitest --reporter=verbose      # Verbose output
npx vitest --reporter=json         # JSON output

# Browser testing
npx vitest --browser               # Run in browser mode
npx vitest --browser.name=firefox  # Specific browser

# Configuration
npx vitest --config vitest.config.ts  # Custom config file
npx vitest --root ./packages/core     # Custom root directory

# Debug mode
npx vitest --inspect               # Enable Node.js inspector
npx vitest --inspect-brk           # Break on start
DEBUG=vitest:* npx vitest          # Debug logging

# Parallel execution
npx vitest --threads=false         # Disable threading
npx vitest --max-threads=4         # Limit thread count
npx vitest --min-threads=2         # Minimum threads

# File watching
npx vitest --watch=false           # Disable watch mode
npx vitest --changed               # Only changed files
npx vitest --related              # Files related to changed
```

## Advanced Features

### Custom Matchers
```typescript
// src/test/matchers.ts
import { expect } from 'vitest'

interface CustomMatchers<R = unknown> {
  toBeValidEmail(): R
  toHaveErrorMessage(message: string): R
}

declare module 'vitest' {
  interface Assertion<T = any> extends CustomMatchers<T> {}
  interface AsymmetricMatchersContaining extends CustomMatchers {}
}

expect.extend({
  toBeValidEmail(received: string) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    const pass = emailRegex.test(received)

    return {
      pass,
      message: () =>
        pass
          ? `Expected ${received} not to be a valid email`
          : `Expected ${received} to be a valid email`,
    }
  },

  toHaveErrorMessage(received: HTMLElement, message: string) {
    const errorElement = received.querySelector('[data-testid="error"]')
    const pass = errorElement?.textContent === message

    return {
      pass,
      message: () =>
        pass
          ? `Expected element not to have error message "${message}"`
          : `Expected element to have error message "${message}", got "${errorElement?.textContent}"`,
    }
  },
})

// Usage in tests
it('validates email format', () => {
  expect('test@example.com').toBeValidEmail()
  expect('invalid-email').not.toBeValidEmail()
})
```

### Test Fixtures and Factories
```typescript
// src/test/factories.ts
import { faker } from '@faker-js/faker'

export interface User {
  id: string
  name: string
  email: string
  age: number
  isActive: boolean
}

export function createUser(overrides: Partial<User> = {}): User {
  return {
    id: faker.string.uuid(),
    name: faker.person.fullName(),
    email: faker.internet.email(),
    age: faker.number.int({ min: 18, max: 80 }),
    isActive: true,
    ...overrides,
  }
}

export function createUsers(count: number, overrides: Partial<User> = {}): User[] {
  return Array.from({ length: count }, () => createUser(overrides))
}

// Usage in tests
describe('UserList', () => {
  it('displays multiple users', () => {
    const users = createUsers(3)
    render(<UserList users={users} />)

    users.forEach(user => {
      expect(screen.getByText(user.name)).toBeInTheDocument()
    })
  })

  it('handles inactive users', () => {
    const inactiveUser = createUser({ isActive: false })
    render(<UserProfile user={inactiveUser} />)

    expect(screen.getByText('Inactive')).toBeInTheDocument()
  })
})
```

### Snapshot Testing
```typescript
// src/components/__tests__/Card.test.tsx
import { describe, it, expect } from 'vitest'
import { render } from '@testing-library/react'
import { Card } from '../Card'

describe('Card', () => {
  it('matches snapshot', () => {
    const { container } = render(
      <Card title="Test Card" subtitle="Test Subtitle">
        <p>Card content</p>
      </Card>
    )

    expect(container.firstChild).toMatchSnapshot()
  })

  it('matches inline snapshot', () => {
    const { container } = render(<Card title="Simple" />)

    expect(container.innerHTML).toMatchInlineSnapshot(`
      "<div class=\\"card\\">
        <h2>Simple</h2>
      </div>"
    `)
  })
})

// Custom snapshot serializer
// vitest.config.ts
export default defineConfig({
  test: {
    snapshotSerializers: ['./src/test/serializers/react.ts'],
  },
})

// src/test/serializers/react.ts
import { ReactTestInstance } from 'react-test-renderer'

export function test(val: any): boolean {
  return val && val.$$typeof === Symbol.for('react.test.json')
}

export function serialize(val: ReactTestInstance): string {
  // Custom serialization logic
  return JSON.stringify(val, null, 2)
}
```

### Performance Testing
```typescript
// src/utils/__tests__/performance.test.ts
import { describe, it, expect } from 'vitest'
import { fibonacci, quickSort } from '../algorithms'

describe('Performance tests', () => {
  it('fibonacci should complete within time limit', () => {
    const start = performance.now()
    const result = fibonacci(30)
    const end = performance.now()

    expect(end - start).toBeLessThan(1000) // 1 second limit
    expect(result).toBe(832040)
  })

  it('quickSort should handle large arrays efficiently', () => {
    const largeArray = Array.from({ length: 10000 }, () =>
      Math.floor(Math.random() * 1000)
    )

    const start = performance.now()
    const sorted = quickSort([...largeArray])
    const end = performance.now()

    expect(end - start).toBeLessThan(100) // 100ms limit
    expect(sorted).toEqual([...largeArray].sort((a, b) => a - b))
  })
})
```

## Common Patterns

### Testing React Hooks
```typescript
// src/hooks/useCounter.ts
import { useState, useCallback } from 'react'

export function useCounter(initialValue = 0) {
  const [count, setCount] = useState(initialValue)

  const increment = useCallback(() => {
    setCount(prev => prev + 1)
  }, [])

  const decrement = useCallback(() => {
    setCount(prev => prev - 1)
  }, [])

  const reset = useCallback(() => {
    setCount(initialValue)
  }, [initialValue])

  return { count, increment, decrement, reset }
}

// src/hooks/__tests__/useCounter.test.ts
import { renderHook, act } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import { useCounter } from '../useCounter'

describe('useCounter', () => {
  it('initializes with default value', () => {
    const { result } = renderHook(() => useCounter())
    expect(result.current.count).toBe(0)
  })

  it('initializes with custom value', () => {
    const { result } = renderHook(() => useCounter(10))
    expect(result.current.count).toBe(10)
  })

  it('increments count', () => {
    const { result } = renderHook(() => useCounter(5))

    act(() => {
      result.current.increment()
    })

    expect(result.current.count).toBe(6)
  })

  it('decrements count', () => {
    const { result } = renderHook(() => useCounter(5))

    act(() => {
      result.current.decrement()
    })

    expect(result.current.count).toBe(4)
  })

  it('resets to initial value', () => {
    const { result } = renderHook(() => useCounter(10))

    act(() => {
      result.current.increment()
      result.current.increment()
    })

    expect(result.current.count).toBe(12)

    act(() => {
      result.current.reset()
    })

    expect(result.current.count).toBe(10)
  })
})
```

### Testing Async Operations
```typescript
// src/services/userService.ts
export class UserService {
  async getUser(id: string): Promise<User> {
    const response = await fetch(`/api/users/${id}`)
    if (!response.ok) {
      throw new Error(`User not found: ${id}`)
    }
    return response.json()
  }

  async createUser(userData: Omit<User, 'id'>): Promise<User> {
    const response = await fetch('/api/users', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(userData),
    })

    if (!response.ok) {
      throw new Error('Failed to create user')
    }

    return response.json()
  }
}

// src/services/__tests__/userService.test.ts
import { describe, it, expect, vi, beforeEach } from 'vitest'
import { UserService } from '../userService'

global.fetch = vi.fn()

describe('UserService', () => {
  let userService: UserService

  beforeEach(() => {
    userService = new UserService()
    vi.resetAllMocks()
  })

  describe('getUser', () => {
    it('fetches user successfully', async () => {
      const mockUser = { id: '1', name: 'John', email: 'john@example.com' }

      vi.mocked(fetch).mockResolvedValueOnce({
        ok: true,
        json: async () => mockUser,
      } as Response)

      const user = await userService.getUser('1')

      expect(fetch).toHaveBeenCalledWith('/api/users/1')
      expect(user).toEqual(mockUser)
    })

    it('throws error when user not found', async () => {
      vi.mocked(fetch).mockResolvedValueOnce({
        ok: false,
        status: 404,
      } as Response)

      await expect(userService.getUser('999'))
        .rejects.toThrow('User not found: 999')
    })
  })

  describe('createUser', () => {
    it('creates user successfully', async () => {
      const userData = { name: 'Jane', email: 'jane@example.com' }
      const createdUser = { id: '2', ...userData }

      vi.mocked(fetch).mockResolvedValueOnce({
        ok: true,
        json: async () => createdUser,
      } as Response)

      const user = await userService.createUser(userData)

      expect(fetch).toHaveBeenCalledWith('/api/users', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(userData),
      })
      expect(user).toEqual(createdUser)
    })
  })
})
```

### Testing Context and Providers
```typescript
// src/contexts/AuthContext.tsx
import React, { createContext, useContext, useState } from 'react'

interface AuthContextType {
  user: User | null
  login: (user: User) => void
  logout: () => void
  isAuthenticated: boolean
}

const AuthContext = createContext<AuthContextType | undefined>(undefined)

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null)

  const login = (user: User) => setUser(user)
  const logout = () => setUser(null)
  const isAuthenticated = !!user

  return (
    <AuthContext.Provider value={{ user, login, logout, isAuthenticated }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider')
  }
  return context
}

// src/contexts/__tests__/AuthContext.test.tsx
import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import { AuthProvider, useAuth } from '../AuthContext'

function TestComponent() {
  const { user, login, logout, isAuthenticated } = useAuth()

  return (
    <div>
      <div data-testid="auth-status">
        {isAuthenticated ? 'Authenticated' : 'Not authenticated'}
      </div>
      <div data-testid="user-name">{user?.name || 'No user'}</div>
      <button onClick={() => login({ id: '1', name: 'John' })}>
        Login
      </button>
      <button onClick={logout}>
        Logout
      </button>
    </div>
  )
}

describe('AuthContext', () => {
  function renderWithProvider() {
    return render(
      <AuthProvider>
        <TestComponent />
      </AuthProvider>
    )
  }

  it('provides authentication state', () => {
    renderWithProvider()

    expect(screen.getByTestId('auth-status')).toHaveTextContent('Not authenticated')
    expect(screen.getByTestId('user-name')).toHaveTextContent('No user')
  })

  it('handles login', async () => {
    const user = userEvent.setup()
    renderWithProvider()

    await user.click(screen.getByText('Login'))

    expect(screen.getByTestId('auth-status')).toHaveTextContent('Authenticated')
    expect(screen.getByTestId('user-name')).toHaveTextContent('John')
  })

  it('handles logout', async () => {
    const user = userEvent.setup()
    renderWithProvider()

    // Login first
    await user.click(screen.getByText('Login'))
    expect(screen.getByTestId('auth-status')).toHaveTextContent('Authenticated')

    // Then logout
    await user.click(screen.getByText('Logout'))
    expect(screen.getByTestId('auth-status')).toHaveTextContent('Not authenticated')
  })

  it('throws error when used outside provider', () => {
    // Suppress console.error for this test
    const consoleSpy = vi.spyOn(console, 'error').mockImplementation(() => {})

    expect(() => {
      render(<TestComponent />)
    }).toThrow('useAuth must be used within AuthProvider')

    consoleSpy.mockRestore()
  })
})
```

## Performance Optimization

### Test Execution Speed
```typescript
// vitest.config.ts
export default defineConfig({
  test: {
    // Parallel execution
    pool: 'threads',
    poolOptions: {
      threads: {
        maxThreads: 4,
        minThreads: 2,
      },
    },

    // Faster test discovery
    cache: {
      dir: 'node_modules/.vitest',
    },

    // Optimize file watching
    watch: {
      ignore: ['**/node_modules/**', '**/dist/**', '**/coverage/**'],
    },

    // Only run changed tests in watch mode
    changed: true,

    // Skip type checking for faster execution
    typecheck: {
      enabled: false, // Run separately
    },
  },
})
```

### Memory Optimization
```typescript
// vitest.config.ts
export default defineConfig({
  test: {
    // Isolate tests to prevent memory leaks
    isolate: true,

    // Pool options for memory management
    poolOptions: {
      threads: {
        isolate: true,
      },
    },

    // Cleanup between tests
    sequence: {
      hooks: 'stack',
    },
  },
})

// In test files - cleanup heavy resources
describe('Heavy component tests', () => {
  afterEach(() => {
    // Cleanup DOM
    cleanup()

    // Clear mocks
    vi.clearAllMocks()

    // Reset modules
    vi.resetModules()
  })
})
```

### Selective Test Running
```bash
# Run only unit tests
npx vitest --run src/**/*.unit.test.ts

# Skip integration tests
npx vitest --run --exclude="**/*.integration.test.ts"

# Run tests for specific components
npx vitest --run src/components/**/*.test.tsx

# Run tests based on changed files
npx vitest --run --changed HEAD~1

# Run tests with specific tags
npx vitest --run --grep="@fast"
```

## Common Issues & Solutions

### Mock Resolution Issues
**Problem**: Mocks not working correctly
**Solution**: Ensure proper mock setup and placement
```typescript
// Hoist mocks to the top of the file
vi.mock('@/api/client', () => ({
  apiClient: {
    get: vi.fn(),
    post: vi.fn(),
  },
}))

// For ES modules, use vi.hoisted
const mockApiClient = vi.hoisted(() => ({
  get: vi.fn(),
  post: vi.fn(),
}))

vi.mock('@/api/client', () => ({
  apiClient: mockApiClient,
}))
```

### Async Test Issues
**Problem**: Tests timing out or not waiting for async operations
**Solution**: Proper async/await usage and increased timeouts
```typescript
// Use proper async patterns
it('handles async operations', async () => {
  const promise = asyncFunction()
  await expect(promise).resolves.toBe('expected value')
})

// Wait for elements to appear
it('waits for elements', async () => {
  render(<AsyncComponent />)

  await waitFor(() => {
    expect(screen.getByText('Loaded')).toBeInTheDocument()
  })
})

// Custom timeout for slow operations
it('handles slow operations', async () => {
  await slowAsyncFunction()
}, 30000) // 30 second timeout
```

### Environment Setup Issues
**Problem**: Browser APIs not available in test environment
**Solution**: Proper environment configuration and polyfills
```typescript
// vitest.config.ts
export default defineConfig({
  test: {
    environment: 'jsdom',
    setupFiles: ['./src/test/setup.ts'],
  },
})

// src/test/setup.ts
import { vi } from 'vitest'

// Mock browser APIs
global.ResizeObserver = vi.fn().mockImplementation(() => ({
  observe: vi.fn(),
  unobserve: vi.fn(),
  disconnect: vi.fn(),
}))

global.matchMedia = vi.fn().mockImplementation(query => ({
  matches: false,
  media: query,
  onchange: null,
  addListener: vi.fn(),
  removeListener: vi.fn(),
  addEventListener: vi.fn(),
  removeEventListener: vi.fn(),
  dispatchEvent: vi.fn(),
}))

// Mock window.location
delete (window as any).location
window.location = {
  ...window.location,
  assign: vi.fn(),
  replace: vi.fn(),
  reload: vi.fn(),
}
```

## Integration with Development Tools

### CI/CD Integration
```yaml
# GitHub Actions
name: Test
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4

    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'
        cache: 'npm'

    - name: Install dependencies
      run: npm ci

    - name: Run unit tests
      run: npm run test:run

    - name: Run tests with coverage
      run: npm run test:coverage

    - name: Upload coverage reports
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage/lcov.info

    - name: Comment coverage on PR
      uses: romeovs/lcov-reporter-action@v0.3.1
      with:
        github-token: ${{ secrets.GITHUB_TOKEN }}
        lcov-file: ./coverage/lcov.info
```

### VS Code Integration
```json
// .vscode/settings.json
{
  "vitest.enable": true,
  "vitest.commandLine": "npm run test",
  "testing.automaticallyOpenPeekView": "never",
  "testing.followRunningTest": false,
  "vitest.include": ["**/*.{test,spec}.{js,mjs,cjs,ts,mts,cts,jsx,tsx}"],
  "vitest.exclude": ["**/node_modules/**", "**/dist/**"]
}

// .vscode/launch.json for debugging
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Vitest Tests",
      "type": "node",
      "request": "launch",
      "autoAttachChildProcesses": true,
      "skipFiles": ["<node_internals>/**", "**/node_modules/**"],
      "program": "${workspaceRoot}/node_modules/vitest/vitest.mjs",
      "args": ["--inspect-brk", "--no-coverage", "${relativeFile}"],
      "smartStep": true,
      "console": "integratedTerminal"
    }
  ]
}
```

### ESLint Integration
```javascript
// .eslintrc.js
module.exports = {
  overrides: [
    {
      files: ['**/*.test.{js,ts,jsx,tsx}', '**/*.spec.{js,ts,jsx,tsx}'],
      env: {
        'vitest-globals/env': true,
      },
      extends: ['plugin:vitest-globals/recommended'],
      plugins: ['vitest'],
      rules: {
        'vitest/expect-expect': 'error',
        'vitest/no-conditional-expect': 'error',
        'vitest/no-identical-title': 'error',
        'vitest/prefer-to-be': 'error',
        'vitest/prefer-to-have-length': 'error',
        'vitest/valid-expect': 'error',
      },
    },
  ],
}
```

## Useful Resources
- **Official Documentation**: https://vitest.dev/
- **API Reference**: https://vitest.dev/api/
- **Configuration Guide**: https://vitest.dev/config/
- **Examples**: https://github.com/vitest-dev/vitest/tree/main/examples
- **Testing Library Integration**: https://testing-library.com/docs/react-testing-library/intro/
- **Migration from Jest**: https://vitest.dev/guide/migration.html

## Tool-Specific Guidelines

### Test Organization
- Group related tests in describe blocks
- Use descriptive test names that explain the expected behavior
- Follow the Arrange-Act-Assert pattern
- Keep tests focused and independent
- Use proper setup and teardown for test isolation

### Mocking Best Practices
- Mock at the boundary of your system (external APIs, file system)
- Use factory functions for creating test data
- Reset mocks between tests to prevent interference
- Mock only what you need for the specific test
- Verify mock calls when testing interactions

### Performance Considerations
- Run tests in parallel when possible
- Use selective test execution during development
- Monitor test execution time and optimize slow tests
- Use proper cleanup to prevent memory leaks
- Cache dependencies for faster startup

## Version Compatibility
- **Vitest**: 0.34+ (stable), 1.0+ (latest features)
- **Node.js**: 16+ (minimum), 18+ (recommended)
- **Vite**: 4.0+ (recommended), works with 3.x
- **Testing Library**: @testing-library/react 13+, @testing-library/jest-dom 5+

## Troubleshooting

### Debug Mode
```bash
# Enable debug logging
DEBUG=vitest:* npm test

# Run with Node.js inspector
npx vitest --inspect-brk

# Debug specific test file
npx vitest --inspect-brk src/component.test.tsx

# Run single test in debug mode
npx vitest --run --reporter=verbose button.test.ts
```

### Common Error Messages
- **Error**: `ReferenceError: vi is not defined`
  **Cause**: Missing globals configuration
  **Solution**: Add `globals: true` in vitest config

- **Error**: `Cannot find module '@testing-library/jest-dom'`
  **Cause**: Missing setup file configuration
  **Solution**: Configure setupFiles in vitest config

- **Error**: `TypeError: Cannot read property 'mockImplementation' of undefined`
  **Cause**: Incorrect mock syntax
  **Solution**: Use `vi.fn()` instead of `jest.fn()`
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

```

```
