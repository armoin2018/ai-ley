// ✅ Good: Pure functions with clear inputs/outputs
public Optional<User> findUserByEmail(String email) {
    Objects.requireNonNull(email, "Email cannot be null");
    return userRepository.findByEmail(email.toLowerCase().trim());
}

// ✅ Good: Use Javadoc for documentation
/**
 * Creates a new user account with the specified details.
 * 
 * @param username the unique username for the account
 * @param email the user's email address
 * @param initialStatus the initial status for the user account
 * @return the created user with generated ID
 * @throws UserAlreadyExistsException if username or email already exists
 * @throws IllegalArgumentException if any parameter is invalid
 */
public User createUser(String username, String email, UserStatus initialStatus) {
    validateUserInput(username, email);
    checkUserDoesNotExist(username, email);
    
    User user = new User.Builder()
            .setUsername(username)
            .setEmail(email)
            .setStatus(initialStatus)
            .setCreatedAt(LocalDateTime.now())
            .build();
            
    return userRepository.save(user);
}

// ✅ Good: Builder pattern for complex objects
public static class Builder {
    private String username;
    private String email;
    private UserStatus status = UserStatus.ACTIVE;
    private LocalDateTime createdAt = LocalDateTime.now();
    
    public Builder setUsername(String username) {
        this.username = username;
        return this;
    }
    
    public User build() {
        return new User(this);
    }
}