---
applyTo: "**/*.ts,**/*.tsx"
---

# TypeScript Programming Instructions

Comprehensive TypeScript development guidelines emphasizing type safety, modern patterns, and maintainable code for AI coding assistants.

## 🧠 Context

- **Language**: TypeScript (4.9+)
- **Environments**: Node.js, Browser, Deno
- **Frameworks**: React, Vue, Angular, Express, NestJS
- **Build Tools**: tsc, Webpack, Vite, esbuild, Rollup
- **Testing**: Jest, Vitest, Playwright, Cypress

## 📁 Project Structure

```text
src/
  components/       # React/Vue components
  pages/           # Next.js pages or route components
  services/        # Business logic and API clients
  types/           # Type definitions
  utils/           # Utility functions
  hooks/           # React custom hooks
  stores/          # State management (Redux, Zustand)
  styles/          # CSS/SCSS files
tests/
  unit/            # Unit tests
  integration/     # Integration tests
  e2e/            # End-to-end tests
types/             # Global type declarations
public/           # Static assets
dist/             # Compiled output
```

## 🔧 Type System Best Practices

### Fundamental Types

```typescript
// ✅ Use specific types over any
interface User {
  readonly id: string;
  name: string;
  email: string;
  age?: number;
  preferences: UserPreferences;
  createdAt: Date;
}

interface UserPreferences {
  theme: 'light' | 'dark';
  notifications: boolean;
  language: string;
}

// ✅ Union types for limited options
type Status = 'pending' | 'approved' | 'rejected';
type HttpMethod = 'GET' | 'POST' | 'PUT' | 'DELETE';

// ✅ Generic types for reusability
interface ApiResponse<T> {
  data: T;
  success: boolean;
  message?: string;
  timestamp: string;
}

interface Repository<T, K = string> {
  findById(id: K): Promise<T | null>;
  create(entity: Omit<T, 'id'>): Promise<T>;
  update(id: K, updates: Partial<T>): Promise<T>;
  delete(id: K): Promise<void>;
}

// ✅ Utility types for transformations
type CreateUserRequest = Omit<User, 'id' | 'createdAt'>;
type UpdateUserRequest = Partial<Pick<User, 'name' | 'email' | 'preferences'>>;
type UserSummary = Pick<User, 'id' | 'name' | 'email'>;
```

### Advanced Type Patterns

```typescript
// ✅ Conditional types
type NonNullable<T> = T extends null | undefined ? never : T;
type ApiEndpoint<T> = T extends 'users' ? User[] : 
                     T extends 'posts' ? Post[] : 
                     unknown;

// ✅ Mapped types
type Optional<T> = {
  [K in keyof T]?: T[K];
};

type Readonly<T> = {
  readonly [K in keyof T]: T[K];
};

// ✅ Template literal types
type EventName<T extends string> = `on${Capitalize<T>}`;
type ApiPath<T extends string> = `/api/${T}`;

// Usage
type UserEventName = EventName<'userCreated'>; // 'onUserCreated'
type UserApiPath = ApiPath<'users'>; // '/api/users'

// ✅ Branded types for type safety
type UserId = string & { readonly brand: unique symbol };
type Email = string & { readonly brand: unique symbol };

function createUserId(id: string): UserId {
  // Validation logic here
  return id as UserId;
}

function sendEmail(to: Email, subject: string, body: string): void {
  // Email sending logic
}

// ✅ Type guards
function isUser(obj: unknown): obj is User {
  return typeof obj === 'object' && 
         obj !== null && 
         'id' in obj && 
         'name' in obj && 
         'email' in obj;
}

function assertIsNumber(value: unknown): asserts value is number {
  if (typeof value !== 'number') {
    throw new Error('Expected number');
  }
}
```

## 🏗️ Class and Interface Design

### Modern Class Patterns

```typescript
// ✅ Well-structured service class
export class UserService {
  constructor(
    private readonly repository: UserRepository,
    private readonly logger: Logger,
    private readonly cache: Cache
  ) {}

  async getUser(id: UserId): Promise<User | null> {
    try {
      // Check cache first
      const cached = await this.cache.get<User>(`user:${id}`);
      if (cached) {
        this.logger.debug('User found in cache', { userId: id });
        return cached;
      }

      // Fetch from repository
      const user = await this.repository.findById(id);
      if (user) {
        await this.cache.set(`user:${id}`, user, { ttl: 300 });
      }

      return user;
    } catch (error) {
      this.logger.error('Failed to get user', { userId: id, error });
      throw new UserServiceError('Failed to retrieve user', { cause: error });
    }
  }

  async createUser(request: CreateUserRequest): Promise<User> {
    this.validateCreateRequest(request);

    try {
      const user = await this.repository.create(request);
      this.logger.info('User created successfully', { userId: user.id });
      
      // Emit event
      this.emit('userCreated', user);
      
      return user;
    } catch (error) {
      this.logger.error('Failed to create user', { request, error });
      throw new UserServiceError('Failed to create user', { cause: error });
    }
  }

  private validateCreateRequest(request: CreateUserRequest): void {
    if (!request.email || !isValidEmail(request.email)) {
      throw new ValidationError('Invalid email address');
    }
    
    if (!request.name || request.name.trim().length < 2) {
      throw new ValidationError('Name must be at least 2 characters');
    }
  }
}

// ✅ Abstract base class
abstract class BaseRepository<T, K = string> implements Repository<T, K> {
  constructor(protected readonly db: Database) {}

  abstract findById(id: K): Promise<T | null>;
  abstract create(entity: Omit<T, 'id'>): Promise<T>;
  
  async update(id: K, updates: Partial<T>): Promise<T> {
    const entity = await this.findById(id);
    if (!entity) {
      throw new NotFoundError(`Entity with id ${id} not found`);
    }
    
    return this.doUpdate(id, updates);
  }
  
  protected abstract doUpdate(id: K, updates: Partial<T>): Promise<T>;
}
```

### Interface Design

```typescript
// ✅ Focused interfaces
interface EventEmitter<T extends Record<string, any>> {
  on<K extends keyof T>(event: K, listener: (data: T[K]) => void): void;
  emit<K extends keyof T>(event: K, data: T[K]): void;
  off<K extends keyof T>(event: K, listener: (data: T[K]) => void): void;
}

interface UserEvents {
  userCreated: User;
  userUpdated: { user: User; changes: Partial<User> };
  userDeleted: { userId: UserId };
}

// ✅ Composable interfaces
interface Timestamped {
  createdAt: Date;
  updatedAt: Date;
}

interface Identifiable {
  id: string;
}

interface AuditableEntity extends Identifiable, Timestamped {
  createdBy: UserId;
  updatedBy: UserId;
}

// ✅ Function interfaces
interface AuthMiddleware {
  (req: Request, res: Response, next: NextFunction): Promise<void>;
}

interface Validator<T> {
  (input: unknown): input is T;
}

interface AsyncHandler<T, R> {
  (input: T): Promise<R>;
}
```

## 🔄 Async Programming and Error Handling

### Modern Async Patterns

```typescript
// ✅ Proper async/await with error handling
export class ApiClient {
  constructor(
    private readonly baseURL: string,
    private readonly timeout: number = 5000
  ) {}

  async get<T>(endpoint: string, options?: RequestOptions): Promise<ApiResponse<T>> {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), this.timeout);

    try {
      const response = await fetch(`${this.baseURL}${endpoint}`, {
        method: 'GET',
        signal: controller.signal,
        headers: {
          'Content-Type': 'application/json',
          ...options?.headers,
        },
      });

      clearTimeout(timeoutId);

      if (!response.ok) {
        throw new HttpError(response.status, response.statusText);
      }

      const data = await response.json();
      return { data, success: true, timestamp: new Date().toISOString() };
    } catch (error) {
      clearTimeout(timeoutId);
      
      if (error instanceof AbortError) {
        throw new TimeoutError('Request timed out');
      }
      
      throw error;
    }
  }

  async post<T, R>(
    endpoint: string, 
    body: T, 
    options?: RequestOptions
  ): Promise<ApiResponse<R>> {
    // Implementation similar to get()
  }
}

// ✅ Result type for better error handling
type Result<T, E = Error> = Success<T> | Failure<E>;

interface Success<T> {
  success: true;
  data: T;
}

interface Failure<E> {
  success: false;
  error: E;
}

function createSuccess<T>(data: T): Success<T> {
  return { success: true, data };
}

function createFailure<E>(error: E): Failure<E> {
  return { success: false, error };
}

// Usage
async function safeApiCall<T>(fn: () => Promise<T>): Promise<Result<T>> {
  try {
    const data = await fn();
    return createSuccess(data);
  } catch (error) {
    return createFailure(error instanceof Error ? error : new Error(String(error)));
  }
}

// ✅ Promise utilities
class PromiseUtils {
  static async allSettledTyped<T extends readonly unknown[]>(
    promises: readonly [...T]
  ): Promise<{
    [K in keyof T]: T[K] extends Promise<infer U> 
      ? Result<U> 
      : Result<T[K]>
  }> {
    const results = await Promise.allSettled(promises);
    return results.map(result => 
      result.status === 'fulfilled' 
        ? createSuccess(result.value)
        : createFailure(result.reason)
    ) as any;
  }

  static async retry<T>(
    fn: () => Promise<T>,
    maxAttempts: number = 3,
    delay: number = 1000
  ): Promise<T> {
    for (let attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await fn();
      } catch (error) {
        if (attempt === maxAttempts) {
          throw error;
        }
        
        await new Promise(resolve => setTimeout(resolve, delay * attempt));
      }
    }
    
    throw new Error('Retry failed');
  }
}
```

## 🎯 React/Frontend Patterns

### Component Design

```typescript
// ✅ Well-typed React component
interface UserProfileProps {
  userId: UserId;
  showActions?: boolean;
  onUserUpdate?: (user: User) => void;
  className?: string;
}

export const UserProfile: React.FC<UserProfileProps> = ({
  userId,
  showActions = false,
  onUserUpdate,
  className
}) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const { data, error: fetchError, isLoading } = useQuery({
    queryKey: ['user', userId],
    queryFn: () => userService.getUser(userId),
    enabled: !!userId,
  });

  const updateUserMutation = useMutation({
    mutationFn: (updates: UpdateUserRequest) => 
      userService.updateUser(userId, updates),
    onSuccess: (updatedUser) => {
      setUser(updatedUser);
      onUserUpdate?.(updatedUser);
    },
  });

  if (isLoading) return <UserProfileSkeleton />;
  if (fetchError) return <ErrorMessage error={fetchError} />;
  if (!data) return <NotFound message="User not found" />;

  return (
    <div className={clsx('user-profile', className)}>
      <UserAvatar user={data} size="large" />
      <UserInfo user={data} />
      {showActions && (
        <UserActions 
          user={data}
          onUpdate={updateUserMutation.mutate}
          updating={updateUserMutation.isPending}
        />
      )}
    </div>
  );
};

// ✅ Custom hooks with proper typing
interface UseApiOptions<T> {
  initialData?: T;
  enabled?: boolean;
  onSuccess?: (data: T) => void;
  onError?: (error: Error) => void;
}

function useApi<T>(
  fetcher: () => Promise<T>,
  deps: React.DependencyList,
  options: UseApiOptions<T> = {}
) {
  const [data, setData] = useState<T | undefined>(options.initialData);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  const execute = useCallback(async () => {
    if (options.enabled === false) return;

    setLoading(true);
    setError(null);

    try {
      const result = await fetcher();
      setData(result);
      options.onSuccess?.(result);
    } catch (err) {
      const error = err instanceof Error ? err : new Error(String(err));
      setError(error);
      options.onError?.(error);
    } finally {
      setLoading(false);
    }
  }, deps);

  useEffect(() => {
    execute();
  }, [execute]);

  return { data, loading, error, refetch: execute };
}
```

## 🧪 Testing with TypeScript

### Unit Testing

```typescript
// user.service.test.ts
import { UserService } from './user.service';
import { createMockRepository, createMockLogger, createMockCache } from '../test-utils';

describe('UserService', () => {
  let userService: UserService;
  let mockRepository: jest.Mocked<UserRepository>;
  let mockLogger: jest.Mocked<Logger>;
  let mockCache: jest.Mocked<Cache>;

  beforeEach(() => {
    mockRepository = createMockRepository<User, UserId>();
    mockLogger = createMockLogger();
    mockCache = createMockCache();
    
    userService = new UserService(mockRepository, mockLogger, mockCache);
  });

  describe('getUser', () => {
    const userId = 'user-123' as UserId;
    const mockUser: User = {
      id: userId,
      name: 'John Doe',
      email: 'john@example.com' as Email,
      preferences: { theme: 'light', notifications: true, language: 'en' },
      createdAt: new Date(),
    };

    it('should return cached user when available', async () => {
      mockCache.get.mockResolvedValue(mockUser);

      const result = await userService.getUser(userId);

      expect(result).toEqual(mockUser);
      expect(mockCache.get).toHaveBeenCalledWith(`user:${userId}`);
      expect(mockRepository.findById).not.toHaveBeenCalled();
    });

    it('should fetch from repository when not cached', async () => {
      mockCache.get.mockResolvedValue(null);
      mockRepository.findById.mockResolvedValue(mockUser);

      const result = await userService.getUser(userId);

      expect(result).toEqual(mockUser);
      expect(mockRepository.findById).toHaveBeenCalledWith(userId);
      expect(mockCache.set).toHaveBeenCalledWith(
        `user:${userId}`,
        mockUser,
        { ttl: 300 }
      );
    });

    it('should handle repository errors gracefully', async () => {
      const error = new Error('Database connection failed');
      mockCache.get.mockResolvedValue(null);
      mockRepository.findById.mockRejectedValue(error);

      await expect(userService.getUser(userId)).rejects.toThrow(UserServiceError);
      expect(mockLogger.error).toHaveBeenCalledWith(
        'Failed to get user',
        { userId, error }
      );
    });
  });
});

// ✅ Type-safe test utilities
export function createMockRepository<T, K = string>(): jest.Mocked<Repository<T, K>> {
  return {
    findById: jest.fn(),
    create: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  };
}

export function createMockApiClient(): jest.Mocked<ApiClient> {
  return {
    get: jest.fn(),
    post: jest.fn(),
    put: jest.fn(),
    delete: jest.fn(),
  };
}

// ✅ Component testing
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { UserProfile } from './user-profile';

describe('UserProfile', () => {
  let queryClient: QueryClient;

  beforeEach(() => {
    queryClient = new QueryClient({
      defaultOptions: {
        queries: { retry: false },
        mutations: { retry: false },
      },
    });
  });

  const renderComponent = (props: Partial<UserProfileProps> = {}) => {
    const defaultProps: UserProfileProps = {
      userId: 'user-123' as UserId,
      ...props,
    };

    return render(
      <QueryClientProvider client={queryClient}>
        <UserProfile {...defaultProps} />
      </QueryClientProvider>
    );
  };

  it('should display user information when loaded', async () => {
    const mockUser: User = {
      id: 'user-123' as UserId,
      name: 'John Doe',
      email: 'john@example.com' as Email,
      preferences: { theme: 'light', notifications: true, language: 'en' },
      createdAt: new Date(),
    };

    jest.mocked(userService.getUser).mockResolvedValue(mockUser);

    renderComponent();

    await waitFor(() => {
      expect(screen.getByText('John Doe')).toBeInTheDocument();
      expect(screen.getByText('john@example.com')).toBeInTheDocument();
    });
  });
});
```

## 🛠️ Configuration and Build Setup

### TypeScript Configuration

```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "node",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "noImplicitThis": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "forceConsistentCasingInFileNames": true,
    "moduleDetection": "force",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"],
      "@/components/*": ["src/components/*"],
      "@/types/*": ["src/types/*"],
      "@/utils/*": ["src/utils/*"]
    }
  },
  "include": [
    "src/**/*",
    "tests/**/*",
    "types/**/*"
  ],
  "exclude": [
    "node_modules",
    "dist",
    "build"
  ]
}
```

### ESLint Configuration

```javascript
// .eslintrc.js
module.exports = {
  extends: [
    '@typescript-eslint/recommended',
    '@typescript-eslint/recommended-requiring-type-checking'
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    project: './tsconfig.json',
    tsconfigRootDir: __dirname,
  },
  rules: {
    '@typescript-eslint/no-unused-vars': 'error',
    '@typescript-eslint/explicit-function-return-type': 'warn',
    '@typescript-eslint/no-explicit-any': 'error',
    '@typescript-eslint/prefer-nullish-coalescing': 'error',
    '@typescript-eslint/prefer-optional-chain': 'error',
    '@typescript-eslint/strict-boolean-expressions': 'error',
    '@typescript-eslint/switch-exhaustiveness-check': 'error',
  }
};
```

## 🚫 Common TypeScript Pitfalls

- **Using `any` type**: Always prefer specific types or `unknown`
- **Ignoring strict compiler options**: Enable all strict flags
- **Not using type guards**: Validate types at runtime boundaries
- **Overusing assertions**: Prefer type guards over type assertions
- **Missing null checks**: Enable `strictNullChecks`
- **Not leveraging utility types**: Use `Pick`, `Omit`, `Partial`, etc.
- **Ignoring excess property checks**: Don't bypass with type assertions

## 📚 Resources

- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [TypeScript Deep Dive](https://basarat.gitbook.io/typescript/)
- [Type Challenges](https://github.com/type-challenges/type-challenges)
- [TypeScript ESLint Rules](https://typescript-eslint.io/rules/)
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/)
- [Utility Types Reference](https://www.typescriptlang.org/docs/handbook/utility-types.html)