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