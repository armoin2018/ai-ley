---
applyTo: "**/*.go"
---

# Go Programming Instructions

Comprehensive Go development guidelines emphasizing idiomatic Go code, performance, and maintainability for AI coding assistants.

## 🧠 Context

- **Language**: Go (1.19+)
- **Common Frameworks**: Gin, Echo, Gorilla/Mux, Cobra (CLI)
- **Standard Libraries**: net/http, database/sql, encoding/json, context
- **Testing**: testing package, testify, GoMock
- **Build Tools**: go mod, go build, Makefile
- **Deployment**: Docker, Kubernetes, serverless

## 📁 Project Structure

```text
cmd/
  myapp/              # Application entry points
    main.go
internal/             # Private application code
  handlers/           # HTTP handlers
  services/           # Business logic
  repositories/       # Data access layer
  config/            # Configuration
  middleware/        # HTTP middleware
pkg/                 # Public library code
  client/            # Client libraries
  models/            # Shared models
tests/               # Test utilities and integration tests
docs/                # Documentation
scripts/             # Build and deployment scripts
Dockerfile
go.mod
go.sum
```

## 🔧 General Guidelines

### Core Principles
- Follow idiomatic Go conventions from Effective Go
- Write simple, readable, and maintainable code
- Use composition over inheritance
- Handle errors explicitly and gracefully
- Leverage Go's concurrency primitives appropriately
- Keep interfaces small and focused

### Go Idioms
- Use short variable names in limited scopes
- Return errors as the last return value
- Use named return parameters sparingly
- Prefer synchronous APIs, use async when beneficial
- Use channels for communication, mutexes for synchronization

## 📜 Code Style and Conventions

### Naming Conventions

```go
// ✅ Good: Use MixedCaps for exported names
type UserService struct {
    repository UserRepository
    logger     Logger
}

// ✅ Good: Use short names in limited scope
func (u *UserService) GetUser(ctx context.Context, id string) (*User, error) {
    user, err := u.repository.FindByID(ctx, id)
    if err != nil {
        return nil, fmt.Errorf("failed to get user: %w", err)
    }
    return user, nil
}

// ✅ Good: Package names are lowercase, single word
package user

// ✅ Good: Constants use MixedCaps
const (
    DefaultTimeout = 30 * time.Second
    MaxRetries     = 3
)
```

### Error Handling

```go
// ✅ Custom error types
type ValidationError struct {
    Field   string
    Message string
}

func (e ValidationError) Error() string {
    return fmt.Sprintf("validation error on field %s: %s", e.Field, e.Message)
}

// ✅ Wrapping errors with context
func (s *UserService) CreateUser(ctx context.Context, req CreateUserRequest) (*User, error) {
    if err := s.validateRequest(req); err != nil {
        return nil, fmt.Errorf("invalid request: %w", err)
    }
    
    user, err := s.repository.Create(ctx, req)
    if err != nil {
        return nil, fmt.Errorf("failed to create user: %w", err)
    }
    
    return user, nil
}

// ✅ Proper error checking
func processFile(filename string) error {
    file, err := os.Open(filename)
    if err != nil {
        return fmt.Errorf("failed to open file %s: %w", filename, err)
    }
    defer file.Close()
    
    data, err := io.ReadAll(file)
    if err != nil {
        return fmt.Errorf("failed to read file: %w", err)
    }
    
    return processData(data)
}
```

## 🏗️ Struct and Interface Design

### Struct Best Practices

```go
// ✅ Well-designed struct with composition
type Server struct {
    config     Config
    router     *gin.Engine
    db         *sql.DB
    logger     Logger
    middleware []gin.HandlerFunc
    
    // Embed for composition
    *http.Server
}

func NewServer(config Config, db *sql.DB, logger Logger) *Server {
    s := &Server{
        config: config,
        db:     db,
        logger: logger,
        router: gin.New(),
    }
    
    s.Server = &http.Server{
        Addr:         config.Address,
        Handler:      s.router,
        ReadTimeout:  config.ReadTimeout,
        WriteTimeout: config.WriteTimeout,
    }
    
    s.setupRoutes()
    return s
}

// ✅ Receiver methods
func (s *Server) Start(ctx context.Context) error {
    s.logger.Info("starting server", "address", s.config.Address)
    
    errCh := make(chan error, 1)
    go func() {
        if err := s.ListenAndServe(); err != nil && err != http.ErrServerClosed {
            errCh <- err
        }
    }()
    
    select {
    case err := <-errCh:
        return fmt.Errorf("server failed to start: %w", err)
    case <-ctx.Done():
        return s.Shutdown(context.Background())
    }
}
```

### Interface Design

```go
// ✅ Small, focused interfaces
type UserRepository interface {
    FindByID(ctx context.Context, id string) (*User, error)
    Create(ctx context.Context, user *User) error
    Update(ctx context.Context, user *User) error
    Delete(ctx context.Context, id string) error
}

type Logger interface {
    Info(msg string, keysAndValues ...interface{})
    Error(msg string, err error, keysAndValues ...interface{})
    Debug(msg string, keysAndValues ...interface{})
}

// ✅ Interface composition
type Service interface {
    UserService
    AuthService
    HealthChecker
}

// ✅ Implementing interfaces implicitly
type PostgresUserRepository struct {
    db *sql.DB
}

func (r *PostgresUserRepository) FindByID(ctx context.Context, id string) (*User, error) {
    var user User
    query := "SELECT id, name, email, created_at FROM users WHERE id = $1"
    
    err := r.db.QueryRowContext(ctx, query, id).Scan(
        &user.ID, &user.Name, &user.Email, &user.CreatedAt,
    )
    if err != nil {
        if errors.Is(err, sql.ErrNoRows) {
            return nil, ErrUserNotFound
        }
        return nil, fmt.Errorf("failed to query user: %w", err)
    }
    
    return &user, nil
}
```

## ⚡ Concurrency Patterns

### Goroutines and Channels

```go
// ✅ Worker pool pattern
func processJobs(ctx context.Context, jobs <-chan Job, results chan<- Result, workerCount int) {
    var wg sync.WaitGroup
    
    for i := 0; i < workerCount; i++ {
        wg.Add(1)
        go func() {
            defer wg.Done()
            for {
                select {
                case job, ok := <-jobs:
                    if !ok {
                        return
                    }
                    result := processJob(job)
                    select {
                    case results <- result:
                    case <-ctx.Done():
                        return
                    }
                case <-ctx.Done():
                    return
                }
            }
        }()
    }
    
    wg.Wait()
    close(results)
}

// ✅ Context cancellation
func fetchUserData(ctx context.Context, userID string) (*UserData, error) {
    ctx, cancel := context.WithTimeout(ctx, 5*time.Second)
    defer cancel()
    
    dataCh := make(chan *UserData, 1)
    errCh := make(chan error, 1)
    
    go func() {
        data, err := slowDatabaseCall(ctx, userID)
        if err != nil {
            errCh <- err
            return
        }
        dataCh <- data
    }()
    
    select {
    case data := <-dataCh:
        return data, nil
    case err := <-errCh:
        return nil, err
    case <-ctx.Done():
        return nil, ctx.Err()
    }
}

// ✅ Rate limiting with channels
type RateLimiter struct {
    tokens chan struct{}
    ticker *time.Ticker
}

func NewRateLimiter(rate time.Duration, burst int) *RateLimiter {
    rl := &RateLimiter{
        tokens: make(chan struct{}, burst),
        ticker: time.NewTicker(rate),
    }
    
    // Fill initial tokens
    for i := 0; i < burst; i++ {
        rl.tokens <- struct{}{}
    }
    
    go func() {
        for range rl.ticker.C {
            select {
            case rl.tokens <- struct{}{}:
            default:
            }
        }
    }()
    
    return rl
}

func (rl *RateLimiter) Allow(ctx context.Context) error {
    select {
    case <-rl.tokens:
        return nil
    case <-ctx.Done():
        return ctx.Err()
    }
}
```

## 🔒 Memory Management and Performance

### Efficient Memory Usage

```go
// ✅ Object pooling for frequently allocated objects
var bufferPool = sync.Pool{
    New: func() interface{} {
        return make([]byte, 4096)
    },
}

func processData(data []byte) ([]byte, error) {
    buf := bufferPool.Get().([]byte)
    defer bufferPool.Put(buf[:0]) // Reset length but keep capacity
    
    // Use buf for processing
    result := append(buf, processedData(data)...)
    
    // Return a copy since we're returning the buffer to the pool
    output := make([]byte, len(result))
    copy(output, result)
    
    return output, nil
}

// ✅ Slice pre-allocation when size is known
func processItems(items []Item) []ProcessedItem {
    results := make([]ProcessedItem, 0, len(items)) // Pre-allocate capacity
    
    for _, item := range items {
        if processed := processItem(item); processed != nil {
            results = append(results, *processed)
        }
    }
    
    return results
}

// ✅ String builder for efficient string concatenation
func buildLargeString(parts []string) string {
    var builder strings.Builder
    
    // Pre-allocate if we know approximate size
    totalSize := 0
    for _, part := range parts {
        totalSize += len(part)
    }
    builder.Grow(totalSize)
    
    for _, part := range parts {
        builder.WriteString(part)
    }
    
    return builder.String()
}
```

## 🧪 Testing Guidelines

### Unit Testing Best Practices

```go
// user_service_test.go
func TestUserService_CreateUser(t *testing.T) {
    tests := []struct {
        name    string
        request CreateUserRequest
        setup   func(*MockUserRepository)
        want    *User
        wantErr bool
    }{
        {
            name: "successful creation",
            request: CreateUserRequest{
                Name:  "John Doe",
                Email: "john@example.com",
            },
            setup: func(repo *MockUserRepository) {
                repo.EXPECT().
                    Create(gomock.Any(), gomock.Any()).
                    Return(nil)
            },
            want: &User{
                ID:    "123",
                Name:  "John Doe",
                Email: "john@example.com",
            },
            wantErr: false,
        },
        {
            name: "repository error",
            request: CreateUserRequest{
                Name:  "John Doe",
                Email: "john@example.com",
            },
            setup: func(repo *MockUserRepository) {
                repo.EXPECT().
                    Create(gomock.Any(), gomock.Any()).
                    Return(errors.New("database error"))
            },
            want:    nil,
            wantErr: true,
        },
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            ctrl := gomock.NewController(t)
            defer ctrl.Finish()
            
            mockRepo := NewMockUserRepository(ctrl)
            tt.setup(mockRepo)
            
            service := NewUserService(mockRepo, &testLogger{})
            
            got, err := service.CreateUser(context.Background(), tt.request)
            
            if tt.wantErr {
                assert.Error(t, err)
                assert.Nil(t, got)
            } else {
                assert.NoError(t, err)
                assert.Equal(t, tt.want.Name, got.Name)
                assert.Equal(t, tt.want.Email, got.Email)
            }
        })
    }
}

// ✅ Benchmark tests
func BenchmarkProcessData(b *testing.B) {
    data := generateTestData(1000)
    
    b.ResetTimer()
    for i := 0; i < b.N; i++ {
        processData(data)
    }
}

// ✅ Integration tests
func TestIntegration_UserAPI(t *testing.T) {
    if testing.Short() {
        t.Skip("skipping integration test")
    }
    
    // Setup test database
    db := setupTestDB(t)
    defer cleanupTestDB(t, db)
    
    server := setupTestServer(t, db)
    
    // Test cases...
}
```

### HTTP Handler Testing

```go
func TestUserHandler_GetUser(t *testing.T) {
    gin.SetMode(gin.TestMode)
    
    tests := []struct {
        name           string
        userID         string
        setup          func(*MockUserService)
        expectedStatus int
        expectedBody   string
    }{
        {
            name:   "successful get",
            userID: "123",
            setup: func(service *MockUserService) {
                service.EXPECT().
                    GetUser(gomock.Any(), "123").
                    Return(&User{ID: "123", Name: "John"}, nil)
            },
            expectedStatus: http.StatusOK,
            expectedBody:   `{"id":"123","name":"John"}`,
        },
        {
            name:   "user not found",
            userID: "999",
            setup: func(service *MockUserService) {
                service.EXPECT().
                    GetUser(gomock.Any(), "999").
                    Return(nil, ErrUserNotFound)
            },
            expectedStatus: http.StatusNotFound,
        },
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            ctrl := gomock.NewController(t)
            defer ctrl.Finish()
            
            mockService := NewMockUserService(ctrl)
            tt.setup(mockService)
            
            handler := NewUserHandler(mockService)
            
            w := httptest.NewRecorder()
            c, _ := gin.CreateTestContext(w)
            c.Params = []gin.Param{{Key: "id", Value: tt.userID}}
            
            handler.GetUser(c)
            
            assert.Equal(t, tt.expectedStatus, w.Code)
            if tt.expectedBody != "" {
                assert.JSONEq(t, tt.expectedBody, w.Body.String())
            }
        })
    }
}
```

## 🔧 Configuration and Deployment

### Configuration Management

```go
type Config struct {
    Server   ServerConfig   `mapstructure:"server"`
    Database DatabaseConfig `mapstructure:"database"`
    Redis    RedisConfig    `mapstructure:"redis"`
    Logger   LoggerConfig   `mapstructure:"logger"`
}

type ServerConfig struct {
    Host         string        `mapstructure:"host" validate:"required"`
    Port         int           `mapstructure:"port" validate:"required,min=1,max=65535"`
    ReadTimeout  time.Duration `mapstructure:"read_timeout"`
    WriteTimeout time.Duration `mapstructure:"write_timeout"`
}

func LoadConfig(path string) (*Config, error) {
    viper.SetConfigFile(path)
    viper.AutomaticEnv()
    viper.SetEnvKeyReplacer(strings.NewReplacer(".", "_"))
    
    if err := viper.ReadInConfig(); err != nil {
        return nil, fmt.Errorf("failed to read config: %w", err)
    }
    
    var config Config
    if err := viper.Unmarshal(&config); err != nil {
        return nil, fmt.Errorf("failed to unmarshal config: %w", err)
    }
    
    validate := validator.New()
    if err := validate.Struct(&config); err != nil {
        return nil, fmt.Errorf("invalid config: %w", err)
    }
    
    return &config, nil
}
```

## 🛠️ Development Tools

### Recommended Tooling

```makefile
# Makefile
.PHONY: test build lint format deps clean

deps:
	go mod download
	go mod verify

format:
	go fmt ./...
	goimports -w .

lint:
	golangci-lint run ./...

test:
	go test -v -race -cover ./...

test-short:
	go test -v -short ./...

build:
	go build -o bin/myapp ./cmd/myapp

clean:
	rm -rf bin/
	go clean -cache

docker-build:
	docker build -t myapp:latest .

generate:
	go generate ./...

.DEFAULT_GOAL := test
```

### golangci-lint Configuration

```yaml
# .golangci.yml
linters-settings:
  govet:
    check-shadowing: true
  golint:
    min-confidence: 0
  gocyclo:
    min-complexity: 15
  maligned:
    suggest-new: true
  dupl:
    threshold: 100
  goconst:
    min-len: 2
    min-occurrences: 2

linters:
  enable:
    - govet
    - errcheck
    - staticcheck
    - unused
    - gosimple
    - ineffassign
    - typecheck
    - gofmt
    - goimports
    - misspell
    - goconst
    - gocyclo
    - gosec

run:
  deadline: 5m
  tests: false
```

## 🚫 Common Pitfalls to Avoid

- **Goroutine leaks**: Always ensure goroutines can exit
- **Channel deadlocks**: Be careful with unbuffered channels
- **Race conditions**: Use proper synchronization
- **Memory leaks**: Close files, connections, and channels
- **Ignoring errors**: Always handle or explicitly ignore errors
- **Premature optimization**: Profile before optimizing
- **Global state**: Minimize package-level variables

## 📚 Resources

- [Effective Go](https://go.dev/doc/effective_go)
- [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
- [Go Memory Model](https://go.dev/ref/mem)
- [Go Concurrency Patterns](https://blog.golang.org/pipelines)
- [Standard Library Documentation](https://pkg.go.dev/std)
- [Go Testing Package](https://pkg.go.dev/testing)