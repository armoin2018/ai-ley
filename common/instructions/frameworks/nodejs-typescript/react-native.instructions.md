---
applyTo: 'react-native, expo'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on React Native with Expo and modern mobile development'
---

# React Native Framework Instructions for AI Agents

## When to Use React Native

Use React Native when you need:

- Cross-platform mobile apps with shared codebase (iOS + Android)
- Leveraging existing React knowledge and ecosystem
- Rapid prototyping and MVP development
- Apps requiring native performance and platform features
- Team already skilled in React/JavaScript/TypeScript
- Integration with existing React web applications
- Over-the-air updates and continuous deployment

## When to Avoid React Native

Consider alternatives when:

- Building platform-specific apps requiring deep native optimization
- Complex animations and high-performance graphics (consider Flutter/native)
- Extensive use of platform-specific APIs
- Team lacks React experience
- Budget allows for separate native development teams
- Apps requiring maximum performance (games, AR/VR)

## Framework Overview

- **Framework**: React Native 0.72+ with Expo SDK 49+
- **Type**: Cross-platform mobile application framework
- **Architecture**: JavaScript bridge with native components
- **Language**: JavaScript/TypeScript with React patterns
- **Use Cases**: Cross-platform mobile apps, MVPs, business applications

## Installation & Setup

### ✅ Recommended: Expo (Managed workflow)

```bash
# Install Expo CLI
npm install -g @expo/cli

# Create new Expo project
npx create-expo-app@latest MyApp
cd MyApp

# Start development server
npx expo start

# Run on simulators
npx expo start --ios
npx expo start --android
```

### ✅ Alternative: React Native CLI (Bare workflow)

```bash
# Install React Native CLI
npm install -g @react-native-community/cli

# Create new project
npx react-native@latest init MyApp
cd MyApp

# Run on platforms
npx react-native run-ios
npx react-native run-android
```

### ❌ Avoid: Outdated CLI tools

```bash
# Don't use deprecated tools
npm install -g react-native-cli  # Deprecated
```

### AI Agent Decision Tree

- **For beginners**: Use Expo managed workflow
- **For rapid prototyping**: Use Expo with EAS Build
- **For complex native requirements**: Use bare React Native
- **For existing apps**: Progressive adoption or brownfield integration

## Project Structure

### ✅ Expo Project Structure

```
expo-app/
├── app/                     # Expo Router (app directory routing)
│   ├── (tabs)/             # Tab navigation
│   ├── +layout.tsx         # Root layout
│   └── index.tsx           # Home screen
├── components/             # Reusable components
│   ├── ui/                # Basic UI components
│   ├── forms/             # Form components
│   └── navigation/        # Navigation components
├── hooks/                 # Custom React hooks
├── services/              # API and external services
├── utils/                 # Utility functions
├── constants/             # App constants
├── assets/                # Images, fonts, etc.
├── app.json              # Expo configuration
├── babel.config.js       # Babel configuration
└── package.json
```

### ✅ Component Architecture

```
components/
├── ui/
│   ├── Button.tsx
│   ├── Input.tsx
│   ├── Card.tsx
│   └── LoadingSpinner.tsx
├── forms/
│   ├── LoginForm.tsx
│   ├── SignupForm.tsx
│   └── ContactForm.tsx
├── lists/
│   ├── UserList.tsx
│   ├── ProductCard.tsx
│   └── FlatListItem.tsx
└── navigation/
    ├── TabBar.tsx
    ├── Header.tsx
    └── DrawerContent.tsx
```

## Core Concepts

### Components and Styling

✅ **Best Practice**: TypeScript components with StyleSheet

```typescript
// components/ui/UserCard.tsx
import React from 'react';
import { View, Text, Image, TouchableOpacity, StyleSheet, Alert } from 'react-native';

interface User {
  id: string;
  name: string;
  email: string;
  avatar: string;
}

interface UserCardProps {
  user: User;
  onEdit: (user: User) => void;
  onDelete: (userId: string) => void;
  loading?: boolean;
}

export const UserCard: React.FC<UserCardProps> = ({ user, onEdit, onDelete, loading = false }) => {
  const handleDelete = () => {
    Alert.alert('Delete User', `Are you sure you want to delete ${user.name}?`, [
      { text: 'Cancel', style: 'cancel' },
      { text: 'Delete', style: 'destructive', onPress: () => onDelete(user.id) },
    ]);
  };

  return (
    <View style={styles.container}>
      <Image source={{ uri: user.avatar }} style={styles.avatar} />
      <View style={styles.content}>
        <Text style={styles.name}>{user.name}</Text>
        <Text style={styles.email}>{user.email}</Text>
      </View>
      <View style={styles.actions}>
        <TouchableOpacity
          style={[styles.button, styles.editButton]}
          onPress={() => onEdit(user)}
          disabled={loading}
        >
          <Text style={styles.editButtonText}>{loading ? 'Loading...' : 'Edit'}</Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={[styles.button, styles.deleteButton]}
          onPress={handleDelete}
          disabled={loading}
        >
          <Text style={styles.deleteButtonText}>Delete</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    padding: 16,
    backgroundColor: '#ffffff',
    borderRadius: 8,
    marginVertical: 4,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 3,
    elevation: 3,
  },
  avatar: {
    width: 50,
    height: 50,
    borderRadius: 25,
    marginRight: 12,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
  },
  name: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  email: {
    fontSize: 14,
    color: '#666',
  },
  actions: {
    justifyContent: 'center',
    gap: 8,
  },
  button: {
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 4,
    minWidth: 60,
    alignItems: 'center',
  },
  editButton: {
    backgroundColor: '#007AFF',
  },
  editButtonText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '500',
  },
  deleteButton: {
    backgroundColor: '#FF3B30',
  },
  deleteButtonText: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '500',
  },
});
```

### Navigation with Expo Router

✅ **Best Practice**: File-based routing with TypeScript

```typescript
// app/(tabs)/_layout.tsx
import { Tabs } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';

export default function TabLayout() {
  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: '#007AFF',
        tabBarInactiveTintColor: '#8E8E93',
        headerShown: false,
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: 'Home',
          tabBarIcon: ({ color, size }) => <Ionicons name="home" size={size} color={color} />,
        }}
      />
      <Tabs.Screen
        name="users"
        options={{
          title: 'Users',
          tabBarIcon: ({ color, size }) => <Ionicons name="people" size={size} color={color} />,
        }}
      />
      <Tabs.Screen
        name="profile"
        options={{
          title: 'Profile',
          tabBarIcon: ({ color, size }) => <Ionicons name="person" size={size} color={color} />,
        }}
      />
    </Tabs>
  );
}
```

```typescript
// app/(tabs)/users.tsx
import React, { useState, useEffect } from 'react';
import { View, FlatList, StyleSheet, RefreshControl, Text } from 'react-native';
import { UserCard } from '../../components/ui/UserCard';
import { useUsers } from '../../hooks/useUsers';

interface User {
  id: string;
  name: string;
  email: string;
  avatar: string;
}

export default function UsersScreen() {
  const { users, loading, error, fetchUsers, deleteUser } = useUsers();
  const [refreshing, setRefreshing] = useState(false);

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleRefresh = async () => {
    setRefreshing(true);
    await fetchUsers();
    setRefreshing(false);
  };

  const handleEditUser = (user: User) => {
    // Navigate to edit screen
    // router.push(`/users/${user.id}/edit`);
  };

  const handleDeleteUser = async (userId: string) => {
    await deleteUser(userId);
  };

  const renderUser = ({ item }: { item: User }) => (
    <UserCard user={item} onEdit={handleEditUser} onDelete={handleDeleteUser} loading={loading} />
  );

  if (error) {
    return (
      <View style={styles.errorContainer}>
        <Text style={styles.errorText}>Error: {error}</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <FlatList
        data={users}
        renderItem={renderUser}
        keyExtractor={(item) => item.id}
        refreshControl={<RefreshControl refreshing={refreshing} onRefresh={handleRefresh} />}
        contentContainerStyle={styles.listContainer}
        showsVerticalScrollIndicator={false}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  listContainer: {
    padding: 16,
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  errorText: {
    fontSize: 16,
    color: '#FF3B30',
    textAlign: 'center',
  },
});
```

### Custom Hooks for Data Management

✅ **Best Practice**: Extract business logic into custom hooks

```typescript
// hooks/useUsers.ts
import { useState, useCallback } from 'react';

interface User {
  id: string;
  name: string;
  email: string;
  avatar: string;
}

export const useUsers = () => {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchUsers = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch('https://api.example.com/users');
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      const data = await response.json();
      setUsers(data);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setLoading(false);
    }
  }, []);

  const deleteUser = useCallback(async (userId: string) => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch(`https://api.example.com/users/${userId}`, {
        method: 'DELETE',
      });
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      setUsers((prev) => prev.filter((user) => user.id !== userId));
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setLoading(false);
    }
  }, []);

  const addUser = useCallback(async (userData: Omit<User, 'id'>) => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch('https://api.example.com/users', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData),
      });
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }
      const newUser = await response.json();
      setUsers((prev) => [...prev, newUser]);
      return newUser;
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
      throw err;
    } finally {
      setLoading(false);
    }
  }, []);

  return {
    users,
    loading,
    error,
    fetchUsers,
    deleteUser,
    addUser,
  };
};
```

### State Management with Context

✅ **Best Practice**: Context for global state

```typescript
// contexts/AuthContext.tsx
import React, { createContext, useContext, useReducer, useEffect } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';

interface User {
  id: string;
  name: string;
  email: string;
}

interface AuthState {
  user: User | null;
  token: string | null;
  loading: boolean;
  error: string | null;
}

type AuthAction =
  | { type: 'LOGIN_START' }
  | { type: 'LOGIN_SUCCESS'; payload: { user: User; token: string } }
  | { type: 'LOGIN_FAILURE'; payload: string }
  | { type: 'LOGOUT' }
  | { type: 'RESTORE_TOKEN'; payload: { user: User; token: string } | null };

const initialState: AuthState = {
  user: null,
  token: null,
  loading: true,
  error: null,
};

const authReducer = (state: AuthState, action: AuthAction): AuthState => {
  switch (action.type) {
    case 'LOGIN_START':
      return { ...state, loading: true, error: null };
    case 'LOGIN_SUCCESS':
      return {
        ...state,
        user: action.payload.user,
        token: action.payload.token,
        loading: false,
        error: null,
      };
    case 'LOGIN_FAILURE':
      return {
        ...state,
        user: null,
        token: null,
        loading: false,
        error: action.payload,
      };
    case 'LOGOUT':
      return {
        ...state,
        user: null,
        token: null,
        loading: false,
        error: null,
      };
    case 'RESTORE_TOKEN':
      return {
        ...state,
        user: action.payload?.user || null,
        token: action.payload?.token || null,
        loading: false,
      };
    default:
      return state;
  }
};

interface AuthContextType {
  state: AuthState;
  login: (email: string, password: string) => Promise<void>;
  logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [state, dispatch] = useReducer(authReducer, initialState);

  useEffect(() => {
    const restoreToken = async () => {
      try {
        const token = await AsyncStorage.getItem('token');
        const userData = await AsyncStorage.getItem('user');
        if (token && userData) {
          const user = JSON.parse(userData);
          dispatch({ type: 'RESTORE_TOKEN', payload: { user, token } });
        } else {
          dispatch({ type: 'RESTORE_TOKEN', payload: null });
        }
      } catch (error) {
        dispatch({ type: 'RESTORE_TOKEN', payload: null });
      }
    };

    restoreToken();
  }, []);

  const login = async (email: string, password: string) => {
    dispatch({ type: 'LOGIN_START' });
    try {
      const response = await fetch('https://api.example.com/auth/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email, password }),
      });

      if (!response.ok) {
        throw new Error('Invalid credentials');
      }

      const data = await response.json();
      await AsyncStorage.setItem('token', data.token);
      await AsyncStorage.setItem('user', JSON.stringify(data.user));

      dispatch({
        type: 'LOGIN_SUCCESS',
        payload: { user: data.user, token: data.token },
      });
    } catch (error) {
      dispatch({
        type: 'LOGIN_FAILURE',
        payload: error instanceof Error ? error.message : 'Login failed',
      });
    }
  };

  const logout = async () => {
    await AsyncStorage.removeItem('token');
    await AsyncStorage.removeItem('user');
    dispatch({ type: 'LOGOUT' });
  };

  return <AuthContext.Provider value={{ state, login, logout }}>{children}</AuthContext.Provider>;
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};
```

## Best Practices

### ✅ Do's

- Use TypeScript for better development experience and error prevention
- Implement proper error boundaries and loading states
- Use FlatList for performance with large datasets
- Optimize images with proper resizing and caching
- Use Expo SDK for faster development and easier deployment
- Implement proper navigation patterns with deep linking
- Use native device features through Expo APIs
- Test on both iOS and Android devices regularly

### ❌ Don'ts

- Don't use ScrollView for long lists (use FlatList/VirtualizedList)
- Don't ignore memory management for images and components
- Don't forget to handle keyboard avoiding for forms
- Don't use inline styles extensively (prefer StyleSheet)
- Don't ignore accessibility (a11y) requirements
- Don't forget to handle different screen sizes and orientations
- Don't skip error handling for network requests
- Don't ignore platform-specific UI differences

### Performance Optimization

```typescript
// Optimized FlatList component
import React, { memo, useMemo } from 'react';
import { FlatList, FlatListProps } from 'react-native';

interface OptimizedListProps<T> extends Omit<FlatListProps<T>, 'data'> {
  data: T[];
  keyExtractor: (item: T, index: number) => string;
}

export const OptimizedList = memo(<T>({ data, keyExtractor, ...props }: OptimizedListProps<T>) => {
  const memoizedData = useMemo(() => data, [data]);

  return (
    <FlatList
      data={memoizedData}
      keyExtractor={keyExtractor}
      removeClippedSubviews={true}
      maxToRenderPerBatch={10}
      updateCellsBatchingPeriod={50}
      initialNumToRender={10}
      windowSize={10}
      getItemLayout={
        props.getItemLayout ||
        ((data, index) => ({
          length: 80, // Estimated item height
          offset: 80 * index,
          index,
        }))
      }
      {...props}
    />
  );
});
```

```typescript
// Image optimization
import React from 'react';
import { Image, ImageStyle } from 'react-native';
import { Image as ExpoImage } from 'expo-image';

interface OptimizedImageProps {
  uri: string;
  style: ImageStyle;
  placeholder?: string;
}

export const OptimizedImage: React.FC<OptimizedImageProps> = ({ uri, style, placeholder }) => {
  return (
    <ExpoImage
      source={{ uri }}
      style={style}
      placeholder={placeholder}
      contentFit="cover"
      transition={200}
      cachePolicy="memory-disk"
    />
  );
};
```

## Development Workflow

### ✅ Recommended Development Setup

```bash
# Development
npx expo start

# Platform-specific development
npx expo start --ios
npx expo start --android

# Type checking
npx tsc --noEmit

# Testing
npm test
npm run test:watch

# Building
eas build --platform all
eas build --platform ios
eas build --platform android

# Deployment
eas submit --platform all
```

### IDE Configuration

- **VS Code Extensions**: React Native Tools, Expo Tools, TypeScript
- **Settings**: Enable TypeScript strict mode, React Native debugging
- **Debugging**: Use Flipper or React Native Debugger

### AI Agent Decision Matrix

| Scenario             | Recommended Approach        | Avoid                 |
| -------------------- | --------------------------- | --------------------- |
| New app              | Expo managed workflow       | Bare React Native     |
| Rapid prototyping    | Expo with EAS               | Native development    |
| Complex native needs | Expo dev build or bare      | Ejecting from Expo    |
| State management     | Context + useReducer        | Redux for simple apps |
| Navigation           | Expo Router                 | React Navigation v5-  |
| Styling              | StyleSheet + responsive     | Inline styles         |
| Testing              | Jest + React Native Testing | Manual testing only   |

## Integration Guidelines

- **With APIs**: Use proper error handling and loading states
- **With databases**: Use SQLite or remote APIs, avoid direct database connections
- **With authentication**: Implement secure token storage with AsyncStorage/Keychain
- **With push notifications**: Use Expo Notifications for managed workflow
- **With analytics**: Integrate Firebase Analytics or similar
- **With payments**: Use Stripe or platform-specific payment solutions

## Testing

### ✅ Component Testing

```typescript
// __tests__/UserCard.test.tsx
import React from 'react';
import { render, fireEvent } from '@testing-library/react-native';
import { UserCard } from '../components/ui/UserCard';

describe('UserCard', () => {
  const mockUser = {
    id: '1',
    name: 'John Doe',
    email: 'john@example.com',
    avatar: 'https://example.com/avatar.jpg',
  };

  const mockProps = {
    user: mockUser,
    onEdit: jest.fn(),
    onDelete: jest.fn(),
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders user information correctly', () => {
    const { getByText } = render(<UserCard {...mockProps} />);

    expect(getByText('John Doe')).toBeTruthy();
    expect(getByText('john@example.com')).toBeTruthy();
  });

  it('calls onEdit when edit button is pressed', () => {
    const { getByText } = render(<UserCard {...mockProps} />);

    fireEvent.press(getByText('Edit'));
    expect(mockProps.onEdit).toHaveBeenCalledWith(mockUser);
  });

  it('shows loading state correctly', () => {
    const { getByText } = render(<UserCard {...mockProps} loading={true} />);

    expect(getByText('Loading...')).toBeTruthy();
  });
});
```

### ✅ Integration Testing

```typescript
// e2e/users.e2e.ts (with Detox)
import { device, expect, element, by } from 'detox';

describe('Users Screen', () => {
  beforeAll(async () => {
    await device.launchApp();
  });

  beforeEach(async () => {
    await device.reloadReactNative();
  });

  it('should display users list', async () => {
    await element(by.text('Users')).tap();
    await expect(element(by.id('users-list'))).toBeVisible();
  });

  it('should navigate to user edit screen', async () => {
    await element(by.text('Users')).tap();
    await element(by.text('Edit')).atIndex(0).tap();
    await expect(element(by.text('Edit User'))).toBeVisible();
  });
});
```

## Security Considerations

- Store sensitive data in Keychain/Keystore, not AsyncStorage
- Implement certificate pinning for API requests
- Validate and sanitize all user inputs
- Use secure authentication flows (OAuth2, JWT)
- Implement proper session management
- Enable network security config for production
- Use obfuscation for sensitive code

## Error Handling

```typescript
// utils/errorHandler.ts
import { Alert } from 'react-native';

export class ApiError extends Error {
  constructor(message: string, public status: number, public code?: string) {
    super(message);
    this.name = 'ApiError';
  }
}

export const handleError = (error: unknown) => {
  if (error instanceof ApiError) {
    switch (error.status) {
      case 401:
        // Handle unauthorized
        Alert.alert('Session Expired', 'Please log in again.');
        break;
      case 403:
        Alert.alert('Access Denied', 'You do not have permission.');
        break;
      case 500:
        Alert.alert('Server Error', 'Please try again later.');
        break;
      default:
        Alert.alert('Error', error.message);
    }
  } else if (error instanceof Error) {
    Alert.alert('Error', error.message);
  } else {
    Alert.alert('Error', 'An unknown error occurred.');
  }
};

// Error boundary component
import React, { Component, ReactNode } from 'react';
import { View, Text, TouchableOpacity, StyleSheet } from 'react-native';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error?: Error;
}

export class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error('Error caught by boundary:', error, errorInfo);
  }

  render() {
    if (this.state.hasError) {
      return (
        <View style={styles.container}>
          <Text style={styles.title}>Something went wrong</Text>
          <Text style={styles.message}>
            {this.state.error?.message || 'An unexpected error occurred'}
          </Text>
          <TouchableOpacity
            style={styles.button}
            onPress={() => this.setState({ hasError: false, error: undefined })}
          >
            <Text style={styles.buttonText}>Try Again</Text>
          </TouchableOpacity>
        </View>
      );
    }

    return this.props.children;
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  message: {
    fontSize: 16,
    textAlign: 'center',
    marginBottom: 20,
    color: '#666',
  },
  button: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 5,
  },
  buttonText: {
    color: '#ffffff',
    fontWeight: '500',
  },
});
```

## AI Agent Quick Reference

- **Project Setup**: Use Expo for faster development, bare React Native for complex native needs
- **Component Creation**: Focus on TypeScript, StyleSheet, and proper prop interfaces
- **Navigation**: Implement file-based routing with Expo Router
- **State Management**: Use Context + useReducer for global state, custom hooks for data fetching
- **Performance**: Use FlatList for lists, optimize images, implement proper loading states
- **Testing**: Use React Native Testing Library for components, Detox for E2E
- **Deployment**: Use EAS Build and Submit for streamlined app store deployment

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
