`
---
applyTo: "redux, react-redux, @reduxjs/toolkit, **/*{store,reducer,slice}.{js,ts}"
---

# React Redux State Management Instructions

## Overview
- **Domain**: State Management for React Applications
- **Purpose**: Build scalable, predictable state management with Redux and React
- **Applicable To**: Complex React applications with shared state requirements
- **Integration Level**: Application-wide state management and data flow

## Core Principles

### Fundamental Concepts
1. **Single Source of Truth**: All application state lives in a single store
2. **State is Read-Only**: State changes only through dispatched actions
3. **Changes Made with Pure Functions**: Reducers are pure functions that return new state
4. **Predictable State Updates**: Actions describe what happened, reducers specify how state changes

### Key Benefits
- Predictable state management with time-travel debugging
- Excellent developer tools and debugging capabilities
- Clear data flow and state change tracking
- Powerful middleware ecosystem for async operations

### Common Misconceptions
- **Myth**: Redux is required for all React applications
  **Reality**: Use Redux only for complex state that needs to be shared across components
- **Myth**: Redux is too complex and has too much boilerplate
  **Reality**: Redux Toolkit significantly reduces boilerplate and complexity

## Implementation Framework

### Getting Started
#### Prerequisites
- React 16.8+ (with hooks support)
- Modern JavaScript/TypeScript knowledge
- Understanding of React component patterns

#### Initial Setup
```bash
# Install Redux Toolkit and React Redux (recommended)
npm install @reduxjs/toolkit react-redux

# Or traditional Redux (not recommended for new projects)
npm install redux react-redux redux-thunk
```

### Core Methodologies
#### Redux Toolkit Approach (Recommended)
- **Purpose**: Modern Redux development with less boilerplate
- **When to Use**: All new Redux applications
- **Implementation Steps**:
  1. Create store with configureStore()
  2. Define slices with createSlice()
  3. Use createAsyncThunk for async operations
  4. Connect components with useSelector and useDispatch hooks
- **Success Metrics**: Reduced boilerplate and improved developer experience

#### Traditional Redux Pattern
- **Purpose**: Understanding core Redux concepts
- **When to Use**: Legacy codebases or educational purposes
- **Implementation Steps**:
  1. Define action types and creators
  2. Create reducers with switch statements
  3. Combine reducers and create store
  4. Connect components with connect() HOC or hooks
- **Success Metrics**: Clear understanding of Redux fundamentals

### Process Integration
#### Development Workflow
```bash
# Development with Redux DevTools
npm install --save-dev @redux-devtools/extension

# Testing setup
npm install --save-dev @testing-library/react @testing-library/jest-dom
```

#### Type Safety with TypeScript
```bash
# TypeScript setup
npm install --save-dev typescript @types/react @types/react-redux
```

## Best Practices

### Modern Redux Toolkit Patterns
```typescript
// store/store.ts
import { configureStore } from '@reduxjs/toolkit'
import { userSlice } from './slices/userSlice'
import { todosSlice } from './slices/todosSlice'
import { apiSlice } from './slices/apiSlice'

export const store = configureStore({
  reducer: {
    user: userSlice.reducer,
    todos: todosSlice.reducer,
    api: apiSlice.reducer,
  },
  middleware: (getDefaultMiddleware) =>
    getDefaultMiddleware({
      serializableCheck: {
        ignoredActions: ['persist/PERSIST'],
      },
    }).concat(apiSlice.middleware),
  devTools: process.env.NODE_ENV !== 'production',
})

export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = typeof store.dispatch
```

### Slice Definition with TypeScript
```typescript
// store/slices/userSlice.ts
import { createSlice, createAsyncThunk, PayloadAction } from '@reduxjs/toolkit'

interface User {
  id: string
  name: string
  email: string
  avatar?: string
}

interface UserState {
  currentUser: User | null
  users: User[]
  loading: boolean
  error: string | null
}

const initialState: UserState = {
  currentUser: null,
  users: [],
  loading: false,
  error: null,
}

// Async thunk for user login
export const loginUser = createAsyncThunk(
  'user/login',
  async (credentials: { email: string; password: string }, { rejectWithValue }) => {
    try {
      const response = await fetch('/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(credentials),
      })
      
      if (!response.ok) {
        throw new Error('Login failed')
      }
      
      const userData = await response.json()
      return userData
    } catch (error) {
      return rejectWithValue(error instanceof Error ? error.message : 'Login failed')
    }
  }
)

// Async thunk for fetching users
export const fetchUsers = createAsyncThunk(
  'user/fetchUsers',
  async (_, { getState, rejectWithValue }) => {
    try {
      const response = await fetch('/api/users')
      if (!response.ok) throw new Error('Failed to fetch users')
      return await response.json()
    } catch (error) {
      return rejectWithValue(error instanceof Error ? error.message : 'Failed to fetch users')
    }
  }
)

export const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    // Synchronous actions
    setCurrentUser: (state, action: PayloadAction<User>) => {
      state.currentUser = action.payload
    },
    clearCurrentUser: (state) => {
      state.currentUser = null
    },
    updateUserProfile: (state, action: PayloadAction<Partial<User>>) => {
      if (state.currentUser) {
        state.currentUser = { ...state.currentUser, ...action.payload }
      }
    },
    clearError: (state) => {
      state.error = null
    },
  },
  extraReducers: (builder) => {
    builder
      // Login user cases
      .addCase(loginUser.pending, (state) => {
        state.loading = true
        state.error = null
      })
      .addCase(loginUser.fulfilled, (state, action) => {
        state.loading = false
        state.currentUser = action.payload
        state.error = null
      })
      .addCase(loginUser.rejected, (state, action) => {
        state.loading = false
        state.error = action.payload as string
      })
      // Fetch users cases
      .addCase(fetchUsers.pending, (state) => {
        state.loading = true
      })
      .addCase(fetchUsers.fulfilled, (state, action) => {
        state.loading = false
        state.users = action.payload
      })
      .addCase(fetchUsers.rejected, (state, action) => {
        state.loading = false
        state.error = action.payload as string
      })
  },
})

export const { setCurrentUser, clearCurrentUser, updateUserProfile, clearError } = userSlice.actions
export default userSlice.reducer
```

### Typed Hooks for Better DX
```typescript
// hooks/redux.ts
import { useDispatch, useSelector, TypedUseSelectorHook } from 'react-redux'
import type { RootState, AppDispatch } from '../store/store'

export const useAppDispatch = () => useDispatch<AppDispatch>()
export const useAppSelector: TypedUseSelectorHook<RootState> = useSelector

// Custom hooks for specific features
export const useAuth = () => {
  const dispatch = useAppDispatch()
  const { currentUser, loading, error } = useAppSelector((state) => state.user)
  
  const login = (credentials: { email: string; password: string }) => {
    return dispatch(loginUser(credentials))
  }
  
  const logout = () => {
    dispatch(clearCurrentUser())
  }
  
  return {
    user: currentUser,
    loading,
    error,
    login,
    logout,
    isAuthenticated: !!currentUser,
  }
}
```

### Component Integration
```tsx
// components/UserProfile.tsx
import React, { useEffect } from 'react'
import { useAuth } from '../hooks/redux'
import { useAppDispatch, useAppSelector } from '../hooks/redux'
import { updateUserProfile, clearError } from '../store/slices/userSlice'

const UserProfile: React.FC = () => {
  const dispatch = useAppDispatch()
  const { user, loading, error } = useAuth()
  const [isEditing, setIsEditing] = React.useState(false)
  const [formData, setFormData] = React.useState({
    name: user?.name || '',
    email: user?.email || '',
  })

  useEffect(() => {
    if (user) {
      setFormData({
        name: user.name,
        email: user.email,
      })
    }
  }, [user])

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    if (user) {
      dispatch(updateUserProfile({
        ...user,
        name: formData.name,
        email: formData.email,
      }))
      setIsEditing(false)
    }
  }

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    })
  }

  if (loading) return <div>Loading...</div>
  if (!user) return <div>Please log in</div>

  return (
    <div className="user-profile">
      <h2>User Profile</h2>
      
      {error && (
        <div className="error-message">
          {error}
          <button onClick={() => dispatch(clearError())}>✕</button>
        </div>
      )}

      {isEditing ? (
        <form onSubmit={handleSubmit}>
          <div>
            <label htmlFor="name">Name:</label>
            <input
              type="text"
              id="name"
              name="name"
              value={formData.name}
              onChange={handleInputChange}
              required
            />
          </div>
          <div>
            <label htmlFor="email">Email:</label>
            <input
              type="email"
              id="email"
              name="email"
              value={formData.email}
              onChange={handleInputChange}
              required
            />
          </div>
          <button type="submit">Save</button>
          <button type="button" onClick={() => setIsEditing(false)}>
            Cancel
          </button>
        </form>
      ) : (
        <div className="profile-display">
          <p><strong>Name:</strong> {user.name}</p>
          <p><strong>Email:</strong> {user.email}</p>
          <button onClick={() => setIsEditing(true)}>Edit Profile</button>
        </div>
      )}
    </div>
  )
}

export default UserProfile
```

## Common Patterns and Examples

### Pattern 1: RTK Query for API Management
**Scenario**: Efficient API state management with caching
**Implementation**:
```typescript
// store/slices/apiSlice.ts
import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react'

interface Post {
  id: number
  title: string
  content: string
  userId: number
}

export const apiSlice = createApi({
  reducerPath: 'api',
  baseQuery: fetchBaseQuery({
    baseUrl: '/api',
    prepareHeaders: (headers, { getState }) => {
      const token = (getState() as RootState).user.currentUser?.token
      if (token) {
        headers.set('authorization', `Bearer ${token}`)
      }
      return headers
    },
  }),
  tagTypes: ['Post', 'User'],
  endpoints: (builder) => ({
    getPosts: builder.query<Post[], void>({
      query: () => '/posts',
      providesTags: ['Post'],
    }),
    getPost: builder.query<Post, number>({
      query: (id) => `/posts/${id}`,
      providesTags: (result, error, id) => [{ type: 'Post', id }],
    }),
    createPost: builder.mutation<Post, Omit<Post, 'id'>>({
      query: (newPost) => ({
        url: '/posts',
        method: 'POST',
        body: newPost,
      }),
      invalidatesTags: ['Post'],
    }),
    updatePost: builder.mutation<Post, { id: number; updates: Partial<Post> }>({
      query: ({ id, updates }) => ({
        url: `/posts/${id}`,
        method: 'PATCH',
        body: updates,
      }),
      invalidatesTags: (result, error, { id }) => [{ type: 'Post', id }],
    }),
  }),
})

export const {
  useGetPostsQuery,
  useGetPostQuery,
  useCreatePostMutation,
  useUpdatePostMutation,
} = apiSlice
```
**Expected Outcomes**: Automated caching, loading states, and optimistic updates

### Pattern 2: Middleware for Complex Logic
**Scenario**: Custom middleware for analytics and logging
**Implementation**:
```typescript
// middleware/analyticsMiddleware.ts
import { Middleware } from '@reduxjs/toolkit'

const analyticsMiddleware: Middleware = (store) => (next) => (action) => {
  // Track specific actions
  if (action.type.includes('user/login')) {
    // Send analytics event
    analytics.track('User Login Attempt', {
      timestamp: new Date().toISOString(),
      userAgent: navigator.userAgent,
    })
  }

  if (action.type.includes('fulfilled')) {
    console.log('Action completed successfully:', action.type)
  }

  return next(action)
}

export default analyticsMiddleware
```
**Expected Outcomes**: Cross-cutting concerns handled consistently

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Storing All State in Redux
- **Description**: Putting component-local state in Redux store
- **Why It's Problematic**: Unnecessary complexity and performance issues
- **Better Approach**: Use local state for UI-only state, Redux for shared state

#### Anti-Pattern 2: Mutating State Directly
- **Description**: Modifying state objects directly in reducers
- **Why It's Problematic**: Breaks Redux's immutability contract
- **Better Approach**: Always return new state objects (Redux Toolkit uses Immer internally)

## Tools and Resources

### Essential Tools
#### Redux DevTools
```typescript
// Enhanced store configuration with DevTools
export const store = configureStore({
  reducer: rootReducer,
  devTools: process.env.NODE_ENV !== 'production' && {
    trace: true,
    traceLimit: 25,
  },
})
```

#### Testing Utilities
```typescript
// test-utils/redux-render.tsx
import React from 'react'
import { render, RenderOptions } from '@testing-library/react'
import { Provider } from 'react-redux'
import { configureStore } from '@reduxjs/toolkit'
import { userSlice } from '../store/slices/userSlice'

interface ExtendedRenderOptions extends Omit<RenderOptions, 'queries'> {
  preloadedState?: any
  store?: ReturnType<typeof configureStore>
}

export function renderWithRedux(
  ui: React.ReactElement,
  {
    preloadedState = {},
    store = configureStore({
      reducer: { user: userSlice.reducer },
      preloadedState,
    }),
    ...renderOptions
  }: ExtendedRenderOptions = {}
) {
  function Wrapper({ children }: { children?: React.ReactNode }) {
    return <Provider store={store}>{children}</Provider>
  }
  return { store, ...render(ui, { wrapper: Wrapper, ...renderOptions }) }
}
```

### Learning Resources
- **Redux Toolkit Documentation**: https://redux-toolkit.js.org/
- **React Redux Documentation**: https://react-redux.js.org/
- **Redux DevTools**: https://github.com/reduxjs/redux-devtools
- **Redux Style Guide**: https://redux.js.org/style-guide/style-guide

## Quality and Compliance

### Quality Standards
- All async operations handled with proper loading/error states
- TypeScript integration for type safety
- Proper action naming conventions following domain/action pattern
- Comprehensive error handling and user feedback

### Performance Standards
- Minimize unnecessary re-renders with proper selector usage
- Use memoization for expensive selector computations
- Implement proper normalization for nested data structures
- Optimize bundle size with code splitting

### Testing Requirements
- Unit tests for all reducers and selectors
- Integration tests for complex async flows
- Component tests with Redux integration
- End-to-end tests for critical user journeys

## AI Assistant Guidelines

When helping with React Redux:

1. **State Design First**: Analyze what state truly needs to be global vs local
2. **Modern Patterns**: Always recommend Redux Toolkit over traditional Redux
3. **Type Safety**: Include TypeScript patterns for better developer experience
4. **Performance Focus**: Consider re-render optimization and selector efficiency
5. **Testing Strategy**: Include comprehensive testing approaches
6. **Error Handling**: Implement proper error states and user feedback
7. **Best Practices**: Follow Redux style guide and community conventions
8. **Integration Planning**: Consider how Redux fits into the larger application architecture

### Decision Making Framework
When helping teams choose Redux approaches:

1. **State Complexity Assessment**: Evaluate if Redux is actually needed
2. **Team Experience**: Consider team familiarity with Redux concepts
3. **Application Scale**: Plan for current and future state management needs
4. **Performance Requirements**: Design for optimal rendering performance
5. **Testing Strategy**: Plan for maintainable and comprehensive test coverage

### Code Generation Rules
- Generate Redux Toolkit code with createSlice and createAsyncThunk
- Include proper TypeScript types and interfaces
- Use modern React hooks (useSelector, useDispatch) over connect()
- Include proper error handling and loading states
- Generate corresponding tests for reducers and components
- Follow naming conventions (domain/action pattern)
- Include performance optimization patterns
- Provide comprehensive documentation and examples

### Quality Enforcement
- ✅ Enforce Redux Toolkit usage over traditional Redux
- ✅ Require TypeScript integration for type safety
- ✅ Block direct state mutation outside of RTK slices
- ✅ Enforce proper async action handling with createAsyncThunk
- ✅ Require proper selector usage to prevent unnecessary re-renders
- ✅ Enforce consistent action naming conventions
- ✅ Require comprehensive error handling patterns
- ✅ Promote proper state normalization for complex data