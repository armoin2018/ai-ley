# Enzyme React Testing Instructions

## Overview

Enzyme is a JavaScript testing utility for React that makes it easier to test React Components' output, manipulate, and traverse React Components. It provides a jQuery-like API for DOM manipulation and traversal, offering three types of rendering: shallow, mount, and static.

**Note:** Enzyme development has been slowed and React Testing Library is now the recommended testing approach for new projects. This guide covers Enzyme for legacy codebases and migration strategies.

## Core Principles

### Testing Philosophy
- **Component Isolation**: Test components in isolation without rendering child components
- **Behavior Testing**: Focus on testing component behavior rather than implementation details
- **API Familiarity**: jQuery-like API for easy DOM manipulation and querying
- **Rendering Flexibility**: Multiple rendering modes for different testing scenarios

### Rendering Strategies
- **Shallow Rendering**: Render only the component itself, not its children
- **Full DOM Rendering**: Complete component tree rendering with lifecycle methods
- **Static Rendering**: Render to static HTML for markup analysis
- **Enzyme Adapter**: Version-specific adapters for React compatibility

### Testing Patterns
- **Unit Testing**: Individual component behavior and props handling
- **Integration Testing**: Component interaction and data flow
- **Snapshot Testing**: Component output consistency verification
- **Event Testing**: User interaction simulation and event handling

## Implementation Framework

### Enzyme Setup and Configuration

```javascript
// enzyme.setup.js - Configure Enzyme for your React version
import { configure } from 'enzyme';
import Adapter from '@wojtekmaj/enzyme-adapter-react-17'; // React 17
// import Adapter from 'enzyme-adapter-react-16'; // React 16
// import Adapter from '@cfaester/enzyme-adapter-react-18'; // React 18

configure({ adapter: new Adapter() });

// jest.config.js - Jest configuration with Enzyme
module.exports = {
  setupFilesAfterEnv: ['<rootDir>/src/setupTests.js'],
  testEnvironment: 'jsdom',
  moduleNameMapping: {
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
    '\\.(gif|ttf|eot|svg|png)$': '<rootDir>/__mocks__/fileMock.js'
  },
  collectCoverageFrom: [
    'src/**/*.{js,jsx}',
    '!src/index.js',
    '!src/serviceWorker.js'
  ]
};

// setupTests.js - Test environment setup
import './enzyme.setup';
import 'jest-enzyme'; // Additional Jest matchers for Enzyme

// Mock common APIs for testing
global.fetch = require('jest-fetch-mock');
Object.defineProperty(window, 'localStorage', {
  value: {
    getItem: jest.fn(),
    setItem: jest.fn(),
    removeItem: jest.fn(),
    clear: jest.fn(),
  },
  writable: true,
});
```

### Basic Component Testing Patterns

```javascript
import React from 'react';
import { shallow, mount, render } from 'enzyme';
import UserProfile from './UserProfile';

// Shallow rendering - most common for unit tests
describe('UserProfile Component', () => {
  const defaultProps = {
    user: {
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      avatar: 'avatar.jpg'
    },
    onEdit: jest.fn(),
    onDelete: jest.fn()
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('Shallow Rendering Tests', () => {
    it('renders user information correctly', () => {
      const wrapper = shallow(<UserProfile {...defaultProps} />);
      
      expect(wrapper.find('.user-name')).toHaveLength(1);
      expect(wrapper.find('.user-name').text()).toBe('John Doe');
      expect(wrapper.find('.user-email').text()).toBe('john@example.com');
      expect(wrapper.find('img').prop('src')).toBe('avatar.jpg');
    });

    it('renders edit button when user can edit', () => {
      const props = { ...defaultProps, canEdit: true };
      const wrapper = shallow(<UserProfile {...props} />);
      
      expect(wrapper.find('.edit-button')).toHaveLength(1);
      expect(wrapper.find('.delete-button')).toHaveLength(1);
    });

    it('hides action buttons when user cannot edit', () => {
      const props = { ...defaultProps, canEdit: false };
      const wrapper = shallow(<UserProfile {...props} />);
      
      expect(wrapper.find('.edit-button')).toHaveLength(0);
      expect(wrapper.find('.delete-button')).toHaveLength(0);
    });
  });

  describe('Event Handling Tests', () => {
    it('calls onEdit when edit button is clicked', () => {
      const props = { ...defaultProps, canEdit: true };
      const wrapper = shallow(<UserProfile {...props} />);
      
      wrapper.find('.edit-button').simulate('click');
      expect(defaultProps.onEdit).toHaveBeenCalledWith(defaultProps.user.id);
    });

    it('calls onDelete with confirmation when delete button is clicked', () => {
      window.confirm = jest.fn(() => true);
      const props = { ...defaultProps, canEdit: true };
      const wrapper = shallow(<UserProfile {...props} />);
      
      wrapper.find('.delete-button').simulate('click');
      expect(window.confirm).toHaveBeenCalledWith('Are you sure you want to delete this user?');
      expect(defaultProps.onDelete).toHaveBeenCalledWith(defaultProps.user.id);
    });

    it('does not call onDelete when confirmation is cancelled', () => {
      window.confirm = jest.fn(() => false);
      const props = { ...defaultProps, canEdit: true };
      const wrapper = shallow(<UserProfile {...props} />);
      
      wrapper.find('.delete-button').simulate('click');
      expect(defaultProps.onDelete).not.toHaveBeenCalled();
    });
  });
});
```

### Advanced Component Testing

```javascript
// Complex component with state and lifecycle methods
import React from 'react';
import { mount } from 'enzyme';
import axios from 'axios';
import UserList from './UserList';

// Mock axios for API testing
jest.mock('axios');
const mockedAxios = axios;

describe('UserList Component - Full Mount Tests', () => {
  const mockUsers = [
    { id: 1, name: 'John Doe', email: 'john@example.com' },
    { id: 2, name: 'Jane Smith', email: 'jane@example.com' }
  ];

  beforeEach(() => {
    mockedAxios.get.mockResolvedValue({ data: mockUsers });
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('loads users on component mount', async () => {
    const wrapper = mount(<UserList />);
    
    // Check loading state
    expect(wrapper.find('.loading')).toHaveLength(1);
    expect(wrapper.state('loading')).toBe(true);
    
    // Wait for async operation
    await wrapper.instance().componentDidMount();
    wrapper.update();
    
    // Check loaded state
    expect(wrapper.state('loading')).toBe(false);
    expect(wrapper.state('users')).toEqual(mockUsers);
    expect(wrapper.find('.user-item')).toHaveLength(2);
  });

  it('handles API errors gracefully', async () => {
    const errorMessage = 'Network Error';
    mockedAxios.get.mockRejectedValue(new Error(errorMessage));
    
    const wrapper = mount(<UserList />);
    await wrapper.instance().componentDidMount();
    wrapper.update();
    
    expect(wrapper.state('error')).toBe(errorMessage);
    expect(wrapper.find('.error-message')).toHaveLength(1);
    expect(wrapper.find('.error-message').text()).toContain(errorMessage);
  });

  it('filters users based on search input', () => {
    const wrapper = mount(<UserList />);
    wrapper.setState({ users: mockUsers, loading: false });
    
    const searchInput = wrapper.find('input[type="search"]');
    searchInput.simulate('change', { target: { value: 'John' } });
    
    wrapper.update();
    expect(wrapper.find('.user-item')).toHaveLength(1);
    expect(wrapper.find('.user-item').text()).toContain('John Doe');
  });

  it('sorts users by name when sort button is clicked', () => {
    const unsortedUsers = [
      { id: 2, name: 'Jane Smith', email: 'jane@example.com' },
      { id: 1, name: 'John Doe', email: 'john@example.com' }
    ];
    
    const wrapper = mount(<UserList />);
    wrapper.setState({ users: unsortedUsers, loading: false });
    
    wrapper.find('.sort-button').simulate('click');
    wrapper.update();
    
    const userItems = wrapper.find('.user-item');
    expect(userItems.at(0).text()).toContain('Jane Smith');
    expect(userItems.at(1).text()).toContain('John Doe');
  });
});
```

### Form Testing Patterns

```javascript
import React from 'react';
import { shallow, mount } from 'enzyme';
import UserForm from './UserForm';

describe('UserForm Component', () => {
  const defaultProps = {
    onSubmit: jest.fn(),
    onCancel: jest.fn(),
    initialData: {}
  };

  describe('Form Validation', () => {
    it('shows validation errors for empty required fields', () => {
      const wrapper = mount(<UserForm {...defaultProps} />);
      
      // Try to submit without filling required fields
      wrapper.find('form').simulate('submit', { preventDefault: () => {} });
      wrapper.update();
      
      expect(wrapper.find('.error-message')).toHaveLength(2);
      expect(wrapper.find('.error-message').at(0).text()).toBe('Name is required');
      expect(wrapper.find('.error-message').at(1).text()).toBe('Email is required');
      expect(defaultProps.onSubmit).not.toHaveBeenCalled();
    });

    it('validates email format', () => {
      const wrapper = mount(<UserForm {...defaultProps} />);
      
      // Fill form with invalid email
      wrapper.find('input[name="name"]').simulate('change', { 
        target: { value: 'John Doe' } 
      });
      wrapper.find('input[name="email"]').simulate('change', { 
        target: { value: 'invalid-email' } 
      });
      
      wrapper.find('form').simulate('submit', { preventDefault: () => {} });
      wrapper.update();
      
      expect(wrapper.find('.error-message')).toHaveLength(1);
      expect(wrapper.find('.error-message').text()).toBe('Please enter a valid email');
    });

    it('submits form with valid data', () => {
      const wrapper = mount(<UserForm {...defaultProps} />);
      const formData = { name: 'John Doe', email: 'john@example.com' };
      
      // Fill form with valid data
      wrapper.find('input[name="name"]').simulate('change', { 
        target: { value: formData.name } 
      });
      wrapper.find('input[name="email"]').simulate('change', { 
        target: { value: formData.email } 
      });
      
      wrapper.find('form').simulate('submit', { preventDefault: () => {} });
      
      expect(defaultProps.onSubmit).toHaveBeenCalledWith(formData);
      expect(wrapper.find('.error-message')).toHaveLength(0);
    });
  });

  describe('Form Initialization', () => {
    it('populates form with initial data', () => {
      const initialData = { name: 'Jane Smith', email: 'jane@example.com' };
      const props = { ...defaultProps, initialData };
      const wrapper = mount(<UserForm {...props} />);
      
      expect(wrapper.find('input[name="name"]').prop('value')).toBe('Jane Smith');
      expect(wrapper.find('input[name="email"]').prop('value')).toBe('jane@example.com');
    });
  });
});
```

## Best Practices

### Component Testing Strategies

```javascript
// Testing Higher-Order Components (HOCs)
import React from 'react';
import { shallow } from 'enzyme';
import withAuth from './withAuth';

const TestComponent = () => <div>Test Component</div>;
const WrappedComponent = withAuth(TestComponent);

describe('withAuth HOC', () => {
  it('renders component when user is authenticated', () => {
    const props = { user: { id: 1, name: 'John' }, isAuthenticated: true };
    const wrapper = shallow(<WrappedComponent {...props} />);
    
    expect(wrapper.find(TestComponent)).toHaveLength(1);
    expect(wrapper.find('.login-required')).toHaveLength(0);
  });

  it('renders login prompt when user is not authenticated', () => {
    const props = { user: null, isAuthenticated: false };
    const wrapper = shallow(<WrappedComponent {...props} />);
    
    expect(wrapper.find(TestComponent)).toHaveLength(0);
    expect(wrapper.find('.login-required')).toHaveLength(1);
  });
});

// Testing React Hooks with Enzyme
import React, { useState } from 'react';
import { mount } from 'enzyme';

const Counter = () => {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <span className="count">{count}</span>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <button onClick={() => setCount(count - 1)}>Decrement</button>
    </div>
  );
};

describe('Counter with Hooks', () => {
  it('increments and decrements count', () => {
    const wrapper = mount(<Counter />);
    
    expect(wrapper.find('.count').text()).toBe('0');
    
    wrapper.find('button').at(0).simulate('click');
    expect(wrapper.find('.count').text()).toBe('1');
    
    wrapper.find('button').at(1).simulate('click');
    expect(wrapper.find('.count').text()).toBe('0');
  });
});
```

### Async Testing Patterns

```javascript
import React from 'react';
import { mount } from 'enzyme';
import { act } from 'react-dom/test-utils';
import AsyncComponent from './AsyncComponent';

describe('AsyncComponent', () => {
  it('handles async data loading', async () => {
    const mockData = { message: 'Hello World' };
    global.fetch = jest.fn(() =>
      Promise.resolve({
        json: () => Promise.resolve(mockData),
      })
    );

    let wrapper;
    await act(async () => {
      wrapper = mount(<AsyncComponent />);
    });

    // Wait for all promises to resolve
    await act(async () => {
      await new Promise(resolve => setTimeout(resolve, 0));
    });

    wrapper.update();

    expect(wrapper.find('.message').text()).toBe('Hello World');
    expect(global.fetch).toHaveBeenCalledTimes(1);
  });

  // Alternative approach using async/await
  it('handles async operations with proper waiting', async () => {
    const wrapper = mount(<AsyncComponent />);
    
    // Find and trigger async action
    wrapper.find('.load-button').simulate('click');
    
    // Wait for state update
    await act(async () => {
      await wrapper.instance().loadData();
    });
    
    wrapper.update();
    expect(wrapper.find('.loading')).toHaveLength(0);
    expect(wrapper.find('.data')).toHaveLength(1);
  });
});
```

### Error Boundary Testing

```javascript
import React from 'react';
import { shallow, mount } from 'enzyme';
import ErrorBoundary from './ErrorBoundary';

const ThrowError = ({ shouldThrow }) => {
  if (shouldThrow) {
    throw new Error('Test error');
  }
  return <div>No error</div>;
};

describe('ErrorBoundary', () => {
  beforeEach(() => {
    // Suppress console.error for testing
    jest.spyOn(console, 'error').mockImplementation(() => {});
  });

  afterEach(() => {
    console.error.mockRestore();
  });

  it('renders children when there is no error', () => {
    const wrapper = shallow(
      <ErrorBoundary>
        <ThrowError shouldThrow={false} />
      </ErrorBoundary>
    );

    expect(wrapper.find(ThrowError)).toHaveLength(1);
    expect(wrapper.find('.error-fallback')).toHaveLength(0);
  });

  it('renders error fallback when child component throws', () => {
    const wrapper = mount(
      <ErrorBoundary>
        <ThrowError shouldThrow={true} />
      </ErrorBoundary>
    );

    expect(wrapper.find('.error-fallback')).toHaveLength(1);
    expect(wrapper.find(ThrowError)).toHaveLength(0);
    expect(wrapper.state('hasError')).toBe(true);
  });
});
```

## Common Patterns

### Custom Enzyme Matchers

```javascript
// customMatchers.js - Extend Enzyme with custom matchers
import { configure } from 'enzyme';

const customMatchers = {
  toHaveState(received, expected) {
    const state = received.state();
    const pass = Object.keys(expected).every(key => 
      state[key] === expected[key]
    );

    return {
      pass,
      message: () => 
        `Expected component to have state ${JSON.stringify(expected)}, ` +
        `but got ${JSON.stringify(state)}`
    };
  },

  toHaveProps(received, expected) {
    const props = received.props();
    const pass = Object.keys(expected).every(key => 
      props[key] === expected[key]
    );

    return {
      pass,
      message: () => 
        `Expected component to have props ${JSON.stringify(expected)}, ` +
        `but got ${JSON.stringify(props)}`
    };
  }
};

expect.extend(customMatchers);

// Usage in tests
describe('Custom Matchers', () => {
  it('uses custom state matcher', () => {
    const wrapper = shallow(<MyComponent />);
    wrapper.setState({ count: 5, name: 'test' });
    
    expect(wrapper).toHaveState({ count: 5 });
  });
});
```

### Test Utilities and Helpers

```javascript
// testUtils.js - Reusable testing utilities
import { shallow, mount } from 'enzyme';
import { MemoryRouter } from 'react-router-dom';
import { Provider } from 'react-redux';
import { createStore } from 'redux';

export const createMockStore = (initialState = {}) => {
  return createStore(() => initialState);
};

export const shallowWithRouter = (component, route = '/') => {
  return shallow(
    <MemoryRouter initialEntries={[route]}>
      {component}
    </MemoryRouter>
  );
};

export const mountWithProviders = (component, { store, route = '/' } = {}) => {
  const mockStore = store || createMockStore();
  
  return mount(
    <Provider store={mockStore}>
      <MemoryRouter initialEntries={[route]}>
        {component}
      </MemoryRouter>
    </Provider>
  );
};

export const findByTestId = (wrapper, testId) => {
  return wrapper.find(`[data-testid="${testId}"]`);
};

export const getComponentState = (wrapper, component) => {
  return wrapper.find(component).state();
};

// Usage in tests
import { mountWithProviders, findByTestId } from './testUtils';

describe('Connected Component', () => {
  it('renders with Redux store', () => {
    const initialState = { users: [{ id: 1, name: 'John' }] };
    const wrapper = mountWithProviders(<UserList />, { 
      store: createMockStore(initialState) 
    });
    
    expect(findByTestId(wrapper, 'user-list')).toHaveLength(1);
  });
});
```

### Snapshot Testing Integration

```javascript
import React from 'react';
import { shallow } from 'enzyme';
import renderer from 'react-test-renderer';
import UserCard from './UserCard';

describe('UserCard Snapshots', () => {
  const defaultProps = {
    user: { id: 1, name: 'John Doe', email: 'john@example.com' }
  };

  it('matches snapshot for default state', () => {
    const component = renderer.create(<UserCard {...defaultProps} />);
    expect(component.toJSON()).toMatchSnapshot();
  });

  it('matches snapshot for loading state', () => {
    const props = { ...defaultProps, loading: true };
    const component = renderer.create(<UserCard {...props} />);
    expect(component.toJSON()).toMatchSnapshot();
  });

  it('matches snapshot for error state', () => {
    const props = { ...defaultProps, error: 'Failed to load user' };
    const component = renderer.create(<UserCard {...props} />);
    expect(component.toJSON()).toMatchSnapshot();
  });

  // Enzyme-specific snapshot testing
  it('matches Enzyme HTML snapshot', () => {
    const wrapper = shallow(<UserCard {...defaultProps} />);
    expect(wrapper.html()).toMatchSnapshot();
  });
});
```

## Tools and Resources

### Essential Enzyme APIs

```javascript
// Rendering Methods
import { shallow, mount, render } from 'enzyme';

// shallow() - Shallow rendering (most common)
const wrapper = shallow(<Component />);

// mount() - Full DOM rendering
const wrapper = mount(<Component />);

// render() - Static HTML rendering
const wrapper = render(<Component />);

// Common Wrapper Methods
wrapper.find(selector);          // Find elements by selector
wrapper.findWhere(predicate);    // Find by custom predicate
wrapper.at(index);              // Get element at index
wrapper.first();                // Get first element
wrapper.last();                 // Get last element
wrapper.text();                 // Get text content
wrapper.html();                 // Get HTML content
wrapper.props();                // Get component props
wrapper.state();                // Get component state
wrapper.setState(newState);     // Set component state
wrapper.simulate(event, data);  // Simulate events
wrapper.update();               // Force update
wrapper.unmount();              // Unmount component

// Property and State Assertions
wrapper.prop('propName');       // Get specific prop
wrapper.state('stateName');     // Get specific state
wrapper.hasClass('className');  // Check for CSS class
wrapper.exists();               // Check if element exists
wrapper.isEmptyRender();        // Check if renders null
```

### Migration to React Testing Library

```javascript
// Migration guide from Enzyme to React Testing Library
// OLD (Enzyme)
const wrapper = shallow(<Button onClick={onClick}>Click me</Button>);
wrapper.find('button').simulate('click');
expect(onClick).toHaveBeenCalled();

// NEW (React Testing Library)
import { render, fireEvent } from '@testing-library/react';

const { getByText } = render(<Button onClick={onClick}>Click me</Button>);
fireEvent.click(getByText('Click me'));
expect(onClick).toHaveBeenCalled();

// OLD (Enzyme) - Testing state
const wrapper = shallow(<Counter />);
expect(wrapper.state('count')).toBe(0);

// NEW (React Testing Library) - Testing behavior
const { getByText } = render(<Counter />);
expect(getByText('Count: 0')).toBeInTheDocument();

// Migration checklist:
// 1. Replace shallow/mount with render
// 2. Use queries instead of find methods
// 3. Test behavior over implementation
// 4. Use fireEvent instead of simulate
// 5. Focus on user interactions
```

### Debugging and Development Tools

```javascript
// Enzyme debugging utilities
const wrapper = shallow(<Component />);

// Debug output
console.log(wrapper.debug());           // Pretty-printed HTML
console.log(wrapper.debug({ verbose: true })); // Include props

// Prop and state inspection
console.log(wrapper.props());           // All props
console.log(wrapper.state());           // All state
console.log(wrapper.instance());        // Component instance

// Custom debugging helper
const debugWrapper = (wrapper, label = 'Component') => {
  console.group(`🔍 ${label} Debug Info`);
  console.log('HTML:', wrapper.html());
  console.log('Props:', wrapper.props());
  if (wrapper.state) {
    console.log('State:', wrapper.state());
  }
  console.log('Text:', wrapper.text());
  console.groupEnd();
};

// Usage
debugWrapper(wrapper, 'UserCard');
```

## Quality and Compliance

### Test Coverage and Quality

```javascript
// jest.config.js - Coverage configuration
module.exports = {
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  collectCoverageFrom: [
    'src/**/*.{js,jsx}',
    '!src/index.js',
    '!src/serviceWorker.js',
    '!src/**/*.test.{js,jsx}',
    '!src/**/*.stories.{js,jsx}'
  ]
};

// Test quality guidelines
describe('Test Quality Example', () => {
  // ✅ Good: Clear, descriptive test names
  it('displays error message when API call fails', () => {
    // Test implementation
  });

  // ❌ Bad: Vague test name
  it('works correctly', () => {
    // Test implementation
  });

  // ✅ Good: Test one thing at a time
  it('renders user name correctly', () => {
    // Single assertion
  });

  it('calls onEdit when edit button is clicked', () => {
    // Single behavior test
  });

  // ❌ Bad: Testing multiple concerns
  it('renders correctly and handles clicks', () => {
    // Too many responsibilities
  });
});
```

### Accessibility Testing Integration

```javascript
import { shallow, mount } from 'enzyme';
import { axe, toHaveNoViolations } from 'jest-axe';

expect.extend(toHaveNoViolations);

describe('Accessibility Tests', () => {
  it('has no accessibility violations', async () => {
    const wrapper = mount(<UserCard user={mockUser} />);
    const results = await axe(wrapper.getDOMNode());
    expect(results).toHaveNoViolations();
  });

  it('has proper ARIA attributes', () => {
    const wrapper = shallow(<Button disabled={true}>Submit</Button>);
    expect(wrapper.prop('aria-disabled')).toBe(true);
  });

  it('supports keyboard navigation', () => {
    const onKeyDown = jest.fn();
    const wrapper = mount(<Modal onKeyDown={onKeyDown} />);
    
    wrapper.simulate('keydown', { key: 'Escape' });
    expect(onKeyDown).toHaveBeenCalledWith(expect.objectContaining({
      key: 'Escape'
    }));
  });
});
```

## Troubleshooting

### Common Enzyme Issues

```javascript
// Issue: Component not updating after state change
// Solution: Use wrapper.update() after async operations
it('updates component after async action', async () => {
  const wrapper = mount(<AsyncComponent />);
  
  // Trigger async action
  wrapper.find('.load-button').simulate('click');
  
  // Wait for async operation
  await act(async () => {
    await new Promise(resolve => setTimeout(resolve, 0));
  });
  
  // Important: Update wrapper to reflect changes
  wrapper.update();
  
  expect(wrapper.find('.loading')).toHaveLength(0);
});

// Issue: Events not firing correctly
// Solution: Use proper event simulation
// ❌ Wrong way
wrapper.find('button').prop('onClick')();

// ✅ Correct way
wrapper.find('button').simulate('click');

// Issue: Mocks not working with Enzyme
// Solution: Proper mock setup and cleanup
beforeEach(() => {
  jest.clearAllMocks();
  global.fetch = jest.fn();
});

afterEach(() => {
  jest.restoreAllMocks();
});
```

### Performance Testing

```javascript
import { mount } from 'enzyme';
import { performance } from 'perf_hooks';

describe('Performance Tests', () => {
  it('renders large lists efficiently', () => {
    const largeList = Array.from({ length: 1000 }, (_, i) => ({
      id: i,
      name: `User ${i}`
    }));

    const start = performance.now();
    const wrapper = mount(<UserList users={largeList} />);
    const end = performance.now();

    expect(end - start).toBeLessThan(100); // Should render in < 100ms
    expect(wrapper.find('.user-item')).toHaveLength(1000);
  });

  it('updates efficiently when props change', () => {
    const wrapper = mount(<UserCard user={mockUser} />);
    
    const start = performance.now();
    wrapper.setProps({ user: { ...mockUser, name: 'Updated Name' } });
    const end = performance.now();

    expect(end - start).toBeLessThan(10); // Should update in < 10ms
  });
});
```

## Metrics and Monitoring

### Test Metrics Collection

```javascript
// testMetrics.js - Custom test metrics
class TestMetrics {
  constructor() {
    this.metrics = {
      totalTests: 0,
      passedTests: 0,
      failedTests: 0,
      renderTime: [],
      coverage: {}
    };
  }

  recordRenderTime(componentName, time) {
    this.metrics.renderTime.push({ component: componentName, time });
  }

  recordTestResult(testName, passed) {
    this.metrics.totalTests++;
    if (passed) {
      this.metrics.passedTests++;
    } else {
      this.metrics.failedTests++;
    }
  }

  getAverageRenderTime() {
    const times = this.metrics.renderTime.map(r => r.time);
    return times.reduce((a, b) => a + b, 0) / times.length;
  }

  generateReport() {
    return {
      ...this.metrics,
      successRate: (this.metrics.passedTests / this.metrics.totalTests) * 100,
      averageRenderTime: this.getAverageRenderTime()
    };
  }
}

const testMetrics = new TestMetrics();

// Usage in tests
beforeEach(() => {
  global.testStartTime = performance.now();
});

afterEach(() => {
  const renderTime = performance.now() - global.testStartTime;
  testMetrics.recordRenderTime(expect.getState().currentTestName, renderTime);
});
```

### Automated Test Quality Checks

```javascript
// testQuality.js - Test quality enforcement
const fs = require('fs');
const path = require('path');

const analyzeTestFile = (filePath) => {
  const content = fs.readFileSync(filePath, 'utf8');
  
  const issues = [];
  
  // Check for descriptive test names
  const vagueTestNames = content.match(/it\(['"](?:works|test|check)/gi);
  if (vagueTestNames) {
    issues.push(`Vague test names found: ${vagueTestNames.length}`);
  }
  
  // Check for proper cleanup
  if (!content.includes('afterEach') && content.includes('jest.fn()')) {
    issues.push('Missing afterEach cleanup for mocks');
  }
  
  // Check for async handling
  const asyncTests = content.match(/async.*=>/g);
  const actUsage = content.match(/act\(/g);
  if (asyncTests && !actUsage) {
    issues.push('Async tests without proper act() usage');
  }
  
  return issues;
};

// Run quality checks on all test files
const runTestQualityCheck = () => {
  const testFiles = glob.sync('src/**/*.test.{js,jsx}');
  
  testFiles.forEach(file => {
    const issues = analyzeTestFile(file);
    if (issues.length > 0) {
      console.warn(`Test quality issues in ${file}:`);
      issues.forEach(issue => console.warn(`  - ${issue}`));
    }
  });
};
```

## Integration Patterns

### CI/CD Integration

```yaml
# .github/workflows/test.yml
name: Test Suite
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Setup Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '16'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run Enzyme tests
      run: npm test -- --coverage --watchAll=false
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v2
      with:
        file: ./coverage/lcov.info
    
    - name: Run test quality checks
      run: npm run test:quality
```

### Documentation Integration

```javascript
// Generate documentation from tests
const generateTestDocs = () => {
  const testFiles = glob.sync('src/**/*.test.{js,jsx}');
  
  const documentation = testFiles.map(file => {
    const content = fs.readFileSync(file, 'utf8');
    const component = path.basename(file, '.test.js');
    
    // Extract test descriptions
    const tests = content.match(/it\(['"](.+?)['"],/g)
      ?.map(match => match.replace(/it\(['"](.+?)['"],/, '$1')) || [];
    
    return {
      component,
      behaviors: tests
    };
  });
  
  return documentation;
};
```

## Advanced Topics

### Custom Enzyme Extensions

```javascript
// enzymeExtensions.js - Custom utilities for Enzyme
export const createShallowRenderer = (defaultProps = {}) => {
  return (Component, props = {}) => {
    return shallow(<Component {...defaultProps} {...props} />);
  };
};

export const createMountRenderer = (providers = {}) => {
  return (Component, props = {}) => {
    let wrapper = <Component {...props} />;
    
    // Wrap with providers if specified
    if (providers.router) {
      wrapper = <MemoryRouter>{wrapper}</MemoryRouter>;
    }
    
    if (providers.redux) {
      wrapper = <Provider store={providers.redux}>{wrapper}</Provider>;
    }
    
    return mount(wrapper);
  };
};

// Usage
const renderUserCard = createShallowRenderer({ 
  theme: 'light', 
  showAvatar: true 
});

const mountWithStore = createMountRenderer({ 
  redux: mockStore, 
  router: true 
});
```

### Legacy Migration Strategies

```javascript
// Gradual migration from Enzyme to React Testing Library
const createMigrationTest = (component, testCases) => {
  describe(`${component.name} - Migration Tests`, () => {
    testCases.forEach(({ name, enzymeTest, rtlTest }) => {
      describe(name, () => {
        it('Enzyme version', enzymeTest);
        it('RTL version', rtlTest);
      });
    });
  });
};

// Usage
createMigrationTest(UserCard, [
  {
    name: 'renders user name',
    enzymeTest: () => {
      const wrapper = shallow(<UserCard user={mockUser} />);
      expect(wrapper.find('.user-name').text()).toBe('John Doe');
    },
    rtlTest: () => {
      render(<UserCard user={mockUser} />);
      expect(screen.getByText('John Doe')).toBeInTheDocument();
    }
  }
]);
```

## AI Assistant Guidelines

### When to Use Enzyme

**Recommended Scenarios:**
- Legacy React applications already using Enzyme
- Shallow rendering for isolated unit tests
- Testing implementation details when necessary
- Maintaining existing Enzyme test suites
- Gradual migration to React Testing Library

**Avoid When:**
- Starting new React projects (use React Testing Library)
- Testing user behavior and interactions
- Writing tests for React hooks
- Testing accessibility features
- Need for modern React features support

### Code Generation Rules

1. **Use shallow rendering** for unit tests of isolated components
2. **Include proper cleanup** with beforeEach/afterEach hooks
3. **Mock external dependencies** appropriately
4. **Test behavior over implementation** when possible
5. **Use act()** for async operations and state updates
6. **Include accessibility tests** where relevant
7. **Follow naming conventions** for clear test descriptions
8. **Provide migration paths** to React Testing Library

### Quality Enforcement

- Always use descriptive test names that explain the behavior being tested
- Include proper setup and teardown for all tests
- Mock external dependencies and APIs consistently
- Use appropriate rendering methods (shallow vs mount) based on test needs
- Include error boundary and edge case testing
- Implement proper async handling with act() and async/await
- Add accessibility testing for user-facing components
- Maintain test coverage above 80% for critical components

### Integration Patterns

- Combine with Jest for comprehensive testing framework
- Use with React Testing Library for migration scenarios
- Integrate with Storybook for component development and testing
- Include in CI/CD pipelines with proper coverage reporting
- Use with accessibility testing tools like jest-axe
- Combine with performance testing for component optimization
