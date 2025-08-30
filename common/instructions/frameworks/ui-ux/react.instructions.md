---
applyTo: '**/*.jsx,**/*.tsx,**/*.js,**/*.ts'
---

# React Framework Instructions

AI agent guidelines for React development emphasizing modern patterns, hooks, and component best practices.

## Framework Overview

- **Framework Name**: React
- **Version**: 18.0+
- **Type**: JavaScript UI Library/Framework
- **Language**: JavaScript/TypeScript
- **Use Cases**: Single-page applications, component-based UIs, server-side rendering, mobile apps with React Native

## Installation & Setup

```bash
# Create React App (traditional)
npx create-react-app my-app
npx create-react-app my-app --template typescript

# Vite (modern, faster)
npm create vite@latest my-app -- --template react
npm create vite@latest my-app -- --template react-ts

# Next.js (full-stack)
npx create-next-app@latest my-app

# Manual setup
npm install react react-dom
npm install -D @types/react @types/react-dom # TypeScript
```

## Project Structure

```
src/
├── components/
│   ├── ui/              # Reusable UI components
│   ├── features/        # Feature-specific components
│   └── layout/          # Layout components
├── hooks/               # Custom hooks
├── context/             # React context providers
├── services/            # API calls and external services
├── utils/               # Utility functions
├── types/               # TypeScript type definitions
├── assets/              # Static assets
└── App.jsx              # Main application component
```

## Core Concepts

### Components and JSX

- **Purpose**: Create reusable UI components using JSX syntax
- **Usage**: Use functional components with hooks for state and effects
- **Example**:

```jsx
// Functional component with props
const UserCard = ({ user, onEdit }) => {
  return (
    <div className="user-card">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      <button onClick={() => onEdit(user.id)}>Edit</button>
    </div>
  );
};
```

### State Management with Hooks

- **Purpose**: Manage component state and side effects
- **Usage**: Use useState for local state, useEffect for side effects
- **Example**:

```jsx
import { useState, useEffect } from 'react';

const UserList = () => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await fetch('/api/users');
        const userData = await response.json();
        setUsers(userData);
      } catch (error) {
        console.error('Failed to fetch users:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchUsers();
  }, []);

  if (loading) return <div>Loading...</div>;

  return (
    <div>
      {users.map((user) => (
        <UserCard key={user.id} user={user} />
      ))}
    </div>
  );
};
```

## Development Workflow

1. **Setup**: Initialize project with Create React App, Vite, or Next.js
2. **Development**: Use development server with hot reload (`npm start`)
3. **Testing**: Write unit tests with Jest and React Testing Library
4. **Building**: Create production build (`npm run build`)
5. **Deployment**: Deploy to platforms like Vercel, Netlify, or AWS

## Best Practices

### ✅ Good Practices

- Use functional components with hooks instead of class components
- Keep components small and focused on single responsibility
- Use TypeScript for better type safety and developer experience
- Implement proper error boundaries for error handling
- Use React DevTools for debugging and performance monitoring
- Follow consistent naming conventions (PascalCase for components)

### ❌ Avoid These

- Don't mutate state directly; always use setState functions
- Avoid inline styles; use CSS modules or styled-components
- Don't use array indexes as keys unless items are static
- Avoid using useEffect without dependency arrays
- Don't create components inside render functions

## Common Patterns

### Custom Hooks

```jsx
// Custom hook for API calls
const useApi = (url) => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const response = await fetch(url);
        if (!response.ok) throw new Error('Network response was not ok');
        const result = await response.json();
        setData(result);
      } catch (err) {
        setError(err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [url]);

  return { data, loading, error };
};
```

### Context for State Management

```jsx
// Create context
const UserContext = createContext();

// Provider component
const UserProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  const login = async (credentials) => {
    // Login logic
    setUser(userData);
  };

  const logout = () => {
    setUser(null);
  };

  return <UserContext.Provider value={{ user, login, logout }}>{children}</UserContext.Provider>;
};

// Hook to use context
const useUser = () => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUser must be used within UserProvider');
  }
  return context;
};
```

### Error Boundary

```jsx
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true };
  }

  componentDidCatch(error, errorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return <h1>Something went wrong.</h1>;
    }

    return this.props.children;
  }
}
```

## Configuration

### Package.json Scripts

```json
{
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject",
    "lint": "eslint src/",
    "format": "prettier --write src/"
  }
}
```

### ESLint Configuration

```json
{
  "extends": ["react-app", "react-app/jest"],
  "rules": {
    "react-hooks/exhaustive-deps": "warn",
    "react/prop-types": "error"
  }
}
```

## Essential Commands

```bash
# Development
npm start              # Start development server
npm run build          # Create production build
npm test               # Run tests
npm run lint           # Run ESLint
npm run format         # Format code with Prettier

# Package management
npm install package-name
npm install -D package-name  # Dev dependency
npm update               # Update dependencies
```

## Common Issues & Solutions

### State Not Updating

**Problem**: State updates not reflecting in component
**Solution**: Ensure you're not mutating state directly; use functional updates for complex state

### Infinite Re-renders

**Problem**: Component re-renders continuously
**Solution**: Check useEffect dependencies and ensure functions are memoized with useCallback

### Memory Leaks

**Problem**: Memory leaks from async operations
**Solution**: Clean up subscriptions and cancel async operations in useEffect cleanup

## Performance Optimization

- Use React.memo for preventing unnecessary re-renders
- Implement useMemo and useCallback for expensive calculations
- Use code splitting with React.lazy and Suspense
- Optimize bundle size with tree shaking and proper imports
- Use React DevTools Profiler to identify performance bottlenecks

## Security Considerations

- Sanitize user input to prevent XSS attacks
- Use HTTPS for all API communications
- Implement proper authentication and authorization
- Avoid storing sensitive data in local storage
- Use environment variables for API keys and secrets

## Framework-Specific Guidelines

### Component Design

- Keep components pure and predictable
- Use composition over inheritance
- Implement consistent prop interfaces
- Use TypeScript for better type safety
- Test components with React Testing Library

### State Management Strategy

- Use local state for component-specific data
- Use Context for app-wide state
- Consider Redux or Zustand for complex state
- Implement proper error handling and loading states

## Integration Points

### Popular Libraries

```bash
# State Management
npm install @reduxjs/toolkit react-redux
npm install zustand

# Routing
npm install react-router-dom

# UI Libraries
npm install @mui/material @emotion/react @emotion/styled
npm install antd

# Forms
npm install react-hook-form
npm install formik yup

# HTTP Client
npm install axios
```

### Testing Setup

```jsx
// Component test example
import { render, screen, fireEvent } from '@testing-library/react';
import UserCard from './UserCard';

test('renders user information', () => {
  const user = { id: 1, name: 'John Doe', email: 'john@example.com' };
  render(<UserCard user={user} onEdit={jest.fn()} />);

  expect(screen.getByText('John Doe')).toBeInTheDocument();
  expect(screen.getByText('john@example.com')).toBeInTheDocument();
});

test('calls onEdit when edit button is clicked', () => {
  const user = { id: 1, name: 'John Doe', email: 'john@example.com' };
  const onEdit = jest.fn();
  render(<UserCard user={user} onEdit={onEdit} />);

  fireEvent.click(screen.getByText('Edit'));
  expect(onEdit).toHaveBeenCalledWith(1);
});
```

## Common Error Messages

- **Error**: `Can't perform a React state update on an unmounted component`
  **Cause**: Async operation completing after component unmount
  **Solution**: Use cleanup function in useEffect or abort controller

- **Error**: `Objects are not valid as a React child`
  **Cause**: Trying to render an object directly in JSX
  **Solution**: Extract specific properties or use JSON.stringify for debugging

## Decision Guidelines for AI Agents

### When to Use React

- ✅ Component-based UI requirements
- ✅ Need for rich interactivity
- ✅ Large-scale applications
- ✅ Strong TypeScript support needed
- ✅ Extensive ecosystem and community

### When to Consider Alternatives

- ❌ Simple static websites (use HTML/CSS)
- ❌ SEO-critical content sites (consider Next.js or Gatsby)
- ❌ Very small projects (overhead may be excessive)
- ❌ Team unfamiliar with JavaScript ecosystem

### Decision Tree for React Projects

1. **Need dynamic UI?** → Yes: React is excellent choice
2. **SEO important?** → Yes: Consider Next.js for SSR
3. **Team size large?** → Yes: TypeScript + strict patterns recommended
4. **Performance critical?** → Yes: Implement optimization strategies
5. **State complex?** → Yes: Consider Redux or Zustand

### Code Quality Checks for AI Agents

- ✅ Verify components follow single responsibility principle
- ✅ Check for proper key props in lists
- ✅ Ensure useEffect dependencies are correct
- ✅ Validate prop types (TypeScript or PropTypes)
- ✅ Test component behavior, not implementation
- ✅ Check for memory leaks in async operations
- ✅ Ensure accessibility attributes are present

## Common Patterns

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

## Configuration

### [Config File 1]

```[format]
# Configuration options
[example configuration]
```

### [Config File 2]

```[format]
# Configuration options
[example configuration]
```

## Essential Commands

```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions

### [Issue 1]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization

- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations

- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources

- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines

### Code Style

- [Coding conventions specific to this framework]
- [Naming conventions]
- [File organization patterns]

### Architecture Patterns

- [Recommended architectural patterns]
- [State management approaches]
- [Component/module organization]

## Integration Points

### [External Service/Tool 1]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

### [External Service/Tool 2]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

## Version Compatibility

- **Node.js**: [Supported versions]
- **Dependencies**: [Key dependency versions]
- **Browser Support**: [If applicable]
- **OS Support**: [If applicable]

## Troubleshooting

### Debug Mode

```bash
[debug commands]
```

### Log Analysis

- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages

- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]

```

```
