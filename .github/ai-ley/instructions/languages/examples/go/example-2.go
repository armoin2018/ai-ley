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