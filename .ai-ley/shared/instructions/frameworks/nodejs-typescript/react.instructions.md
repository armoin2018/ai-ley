# React Framework Instructions

## Framework Overview
- **Framework Name**: React
- **Version**: 19.x (Current), 18.x LTS
- **Type**: JavaScript UI Library/Framework
- **Language**: JavaScript/TypeScript
- **Use Cases**: Single-page applications, component-based UIs, mobile apps with React Native

## Installation & Setup
```bash
# Create new React app
npx create-react-app my-app
npx create-react-app my-app --template typescript

# With Vite (recommended for better performance)
npm create vite@latest my-app -- --template react
npm create vite@latest my-app -- --template react-ts

# Install in existing project
npm install react react-dom
npm install --save-dev @types/react @types/react-dom # For TypeScript
```

## Project Structure
```
src/
├── components/          # Reusable UI components
│   ├── common/         # Shared components
│   ├── forms/          # Form components
│   └── layout/         # Layout components
├── pages/              # Page components
├── hooks/              # Custom React hooks
├── context/            # React context providers
├── services/           # API calls and external services
├── utils/              # Utility functions
├── types/              # TypeScript type definitions
├── assets/             # Static assets
├── styles/             # CSS/SCSS files
├── App.tsx             # Main app component
└── index.tsx           # Entry point
```

## Core Concepts
### Components
- **Purpose**: Reusable UI building blocks
- **Usage**: Create functional components with hooks
- **Example**:
```tsx
import React, { useState } from 'react';

interface ButtonProps {
  label: string;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
}

const Button: React.FC<ButtonProps> = ({
  label,
  onClick,
  variant = 'primary'
}) => {
  return (
    <button
      className={`btn btn-${variant}`}
      onClick={onClick}
    >
      {label}
    </button>
  );
};

export default Button;
```

### State Management
- **Purpose**: Manage component and application state
- **Usage**: Use useState for local state, useReducer for complex state
- **Example**:
```tsx
import React, { useState, useReducer } from 'react';

// Simple state
const Counter: React.FC = () => {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
};

// Complex state with useReducer
interface State {
  loading: boolean;
  data: any[];
  error: string | null;
}

type Action =
  | { type: 'FETCH_START' }
  | { type: 'FETCH_SUCCESS'; payload: any[] }
  | { type: 'FETCH_ERROR'; payload: string };

const dataReducer = (state: State, action: Action): State => {
  switch (action.type) {
    case 'FETCH_START':
      return { ...state, loading: true, error: null };
    case 'FETCH_SUCCESS':
      return { ...state, loading: false, data: action.payload };
    case 'FETCH_ERROR':
      return { ...state, loading: false, error: action.payload };
    default:
      return state;
  }
};
```

### Effects and Side Effects
- **Purpose**: Handle side effects like API calls, subscriptions
- **Usage**: Use useEffect for lifecycle events
- **Example**:
```tsx
import React, { useState, useEffect } from 'react';

const UserProfile: React.FC<{ userId: string }> = ({ userId }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        setLoading(true);
        const response = await fetch(`/api/users/${userId}`);
        const userData = await response.json();
        setUser(userData);
      } catch (error) {
        console.error('Failed to fetch user:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchUser();
  }, [userId]); // Re-run when userId changes

  if (loading) return <div>Loading...</div>;
  if (!user) return <div>User not found</div>;

  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </div>
  );
};
```

## Development Workflow
1. **Setup**: Initialize project with Create React App or Vite
2. **Development**: Run development server with hot reload
3. **Testing**: Write unit tests with Jest and React Testing Library
4. **Building**: Build optimized production bundle
5. **Deployment**: Deploy to hosting platforms

## Best Practices
### Component Design
- Keep components small and focused on a single responsibility
- Use composition over inheritance
- Implement proper prop validation with TypeScript or PropTypes
- Extract reusable logic into custom hooks

### Performance Optimization
- Use React.memo for expensive component re-renders
- Implement useMemo and useCallback for expensive computations
- Lazy load components with React.lazy and Suspense
- Optimize bundle size with code splitting

### State Management
- Keep state as local as possible
- Use Context API for global state that doesn't change frequently
- Consider external libraries (Redux Toolkit, Zustand) for complex state

## Common Patterns
### Custom Hooks
```tsx
// Custom hook for API data fetching
import { useState, useEffect } from 'react';

interface UseFetchResult<T> {
  data: T | null;
  loading: boolean;
  error: string | null;
  refetch: () => void;
}

function useFetch<T>(url: string): UseFetchResult<T> {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchData = async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetch(url);
      if (!response.ok) throw new Error('Failed to fetch');
      const result = await response.json();
      setData(result);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchData();
  }, [url]);

  return { data, loading, error, refetch: fetchData };
}
```

### Context Provider Pattern
```tsx
import React, { createContext, useContext, useReducer } from 'react';

interface AuthState {
  user: User | null;
  isAuthenticated: boolean;
}

interface AuthContextType extends AuthState {
  login: (credentials: LoginCredentials) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({
  children
}) => {
  const [state, dispatch] = useReducer(authReducer, initialState);

  const login = async (credentials: LoginCredentials) => {
    // Login implementation
  };

  const logout = () => {
    // Logout implementation
  };

  const value = {
    ...state,
    login,
    logout,
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
};
```

## Configuration
### Package.json Scripts
```json
{
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test": "jest",
    "test:watch": "jest --watch",
    "lint": "eslint src --ext .ts,.tsx",
    "type-check": "tsc --noEmit"
  }
}
```

### ESLint Configuration
```json
{
  "extends": [
    "react-app",
    "react-app/jest",
    "@typescript-eslint/recommended"
  ],
  "rules": {
    "react-hooks/exhaustive-deps": "error",
    "react/prop-types": "off",
    "@typescript-eslint/explicit-function-return-type": "warn"
  }
}
```

## Essential Commands
```bash
# Development
npm start                    # Start development server
npm run dev                  # Start with Vite

# Testing
npm test                     # Run tests
npm run test:coverage        # Run tests with coverage

# Building
npm run build               # Build for production
npm run preview             # Preview production build

# Linting
npm run lint                # Lint code
npm run lint:fix            # Fix linting issues

# Package management
npm install <package>       # Install dependency
npm install -D <package>    # Install dev dependency
npm update                  # Update packages
```

## Common Issues & Solutions
### State Updates Not Reflecting
**Problem**: Component doesn't re-render when state changes
**Solution**: Ensure state updates are immutable and use functional updates

### Memory Leaks
**Problem**: Components continue to update after unmounting
**Solution**: Clean up subscriptions and cancel pending requests in useEffect cleanup

### Performance Issues
**Problem**: Unnecessary re-renders causing slow performance
**Solution**: Use React DevTools Profiler, implement memoization strategies

## Performance Optimization
### Code Splitting
```tsx
import React, { Suspense, lazy } from 'react';

const LazyComponent = lazy(() => import('./LazyComponent'));

const App: React.FC = () => {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <LazyComponent />
    </Suspense>
  );
};
```

### Memoization
```tsx
import React, { memo, useMemo, useCallback } from 'react';

const ExpensiveComponent = memo<Props>(({ data, onUpdate }) => {
  const processedData = useMemo(() => {
    return data.map(item => expensiveProcessing(item));
  }, [data]);

  const handleClick = useCallback((id: string) => {
    onUpdate(id);
  }, [onUpdate]);

  return (
    <div>
      {processedData.map(item => (
        <Item key={item.id} data={item} onClick={handleClick} />
      ))}
    </div>
  );
});
```

## Security Considerations
- Sanitize user inputs to prevent XSS attacks
- Use HTTPS for all API communications
- Implement proper authentication and authorization
- Validate data on both client and server sides

## Useful Resources
- **Official Documentation**: https://react.dev/
- **React DevTools**: Browser extension for debugging
- **Testing Library**: https://testing-library.com/docs/react-testing-library/intro/
- **React Patterns**: https://reactpatterns.com/
- **Awesome React**: https://github.com/enaqx/awesome-react

## Framework-Specific Guidelines
### Code Style
- Use functional components over class components
- Prefer hooks over higher-order components
- Use TypeScript for better type safety
- Follow consistent naming conventions (PascalCase for components)

### Architecture Patterns
- Implement container/presentational component pattern
- Use compound components for complex UI patterns
- Implement proper error boundaries for error handling
- Use render props pattern for shared logic

## Integration Points
### React Router
- **Purpose**: Client-side routing for single-page applications
- **Setup**: Install react-router-dom and configure routes
- **Usage**: Define routes and navigation components

### State Management Libraries
- **Purpose**: Manage global application state
- **Setup**: Choose between Redux Toolkit, Zustand, or Context API
- **Usage**: Connect components to global state

## Version Compatibility
- **Node.js**: 16.0+
- **TypeScript**: 4.5+
- **Browser Support**: Modern browsers (ES2015+)
- **React Native**: Compatible for mobile development

## Troubleshooting
### Debug Mode
```bash
# Enable React DevTools
npm install --save-dev react-devtools

# Debug bundle size
npm run build && npx webpack-bundle-analyzer build/static/js/*.js
```

### Log Analysis
- Use React DevTools for component debugging
- Implement error boundaries for error catching
- Use browser DevTools for performance profiling

### Common Error Messages
- **Error**: `Cannot read property of undefined`
  **Cause**: Accessing properties of null/undefined objects
  **Solution**: Use optional chaining or null checks

- **Error**: `Maximum update depth exceeded`
  **Cause**: Infinite re-render loops
  **Solution**: Check useEffect dependencies and state updates

## React 19 Modern Features
### React Compiler (Experimental)
```tsx
// Automatic optimization of components and hooks
// No need for manual useMemo/useCallback in many cases
const OptimizedComponent = ({ items, onSelect }) => {
  // React Compiler automatically optimizes this
  const expensiveValue = items.filter(item => item.isActive)
    .map(item => ({ ...item, processed: true }));
  
  return (
    <ul>
      {expensiveValue.map(item => (
        <li key={item.id} onClick={() => onSelect(item)}>
          {item.name}
        </li>
      ))}
    </ul>
  );
};
```

### Server Components Integration
```tsx
// Server Component (runs on server)
async function ServerUserProfile({ userId }: { userId: string }) {
  // This runs on the server, can access databases directly
  const user = await getUserFromDatabase(userId);
  
  return (
    <div>
      <h1>{user.name}</h1>
      <ClientInteractiveButton userId={userId} />
    </div>
  );
}

// Client Component (runs in browser)
'use client';
function ClientInteractiveButton({ userId }: { userId: string }) {
  const [liked, setLiked] = useState(false);
  
  return (
    <button onClick={() => setLiked(!liked)}>
      {liked ? 'Unlike' : 'Like'}
    </button>
  );
}
```

### Actions and Form Handling
```tsx
// React 19 form actions
function ContactForm() {
  const [pending, setPending] = useState(false);
  const [message, setMessage] = useState('');
  
  async function submitForm(formData: FormData) {
    setPending(true);
    try {
      const response = await fetch('/api/contact', {
        method: 'POST',
        body: formData
      });
      
      if (response.ok) {
        setMessage('Message sent successfully!');
      } else {
        setMessage('Failed to send message.');
      }
    } finally {
      setPending(false);
    }
  }
  
  return (
    <form action={submitForm}>
      <input 
        name="email" 
        type="email" 
        placeholder="Your email" 
        required 
      />
      <textarea 
        name="message" 
        placeholder="Your message" 
        required 
      />
      <button type="submit" disabled={pending}>
        {pending ? 'Sending...' : 'Send Message'}
      </button>
      {message && <p>{message}</p>}
    </form>
  );
}
```

## AI Assistant Guidelines
When helping with React:

1. **Always use functional components with hooks over class components**
2. **Prioritize TypeScript for type safety and better developer experience**
3. **Implement proper error boundaries for production applications**
4. **Suggest modern patterns: hooks, context, and composition over inheritance**
5. **Include accessibility considerations in component design**
6. **Recommend React 19 features when appropriate (Server Components, Compiler)**
7. **Provide testing examples with React Testing Library**
8. **Include performance optimization strategies**

### Code Generation Rules
- Generate functional components with TypeScript interfaces
- Include proper error handling and loading states
- Use semantic HTML and ARIA attributes for accessibility
- Implement proper key props for lists
- Include ESLint and Prettier configuration suggestions
- Provide both development and production optimization examples
- Use modern React patterns (hooks, suspense, error boundaries)
- Include unit test examples for generated components
