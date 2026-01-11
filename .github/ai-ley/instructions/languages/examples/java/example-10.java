// UserServiceTest.java
@ExtendWith(MockitoExtension.class)
class UserServiceTest {
    
    @Mock
    private UserRepository userRepository;
    
    @Mock
    private EmailValidator emailValidator;
    
    @Mock
    private PasswordEncoder passwordEncoder;
    
    @InjectMocks
    private UserService userService;
    
    @Test
    @DisplayName("Should create user successfully with valid data")
    void shouldCreateUserSuccessfully() {
        // Arrange
        CreateUserRequest request = new CreateUserRequest("testuser", "test@example.com", "password123");
        String encodedPassword = "encoded_password";
        
        when(emailValidator.isValid(request.getEmail())).thenReturn(true);
        when(userRepository.existsByUsername(request.getUsername())).thenReturn(false);
        when(userRepository.existsByEmail(request.getEmail())).thenReturn(false);
        when(passwordEncoder.encode(request.getPassword())).thenReturn(encodedPassword);
        when(userRepository.save(any(User.class))).thenAnswer(invocation -> {
            User user = invocation.getArgument(0);
            return user.toBuilder().id(1L).build();
        });
        
        // Act
        User result = userService.createUser(request);
        
        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getUsername()).isEqualTo(request.getUsername());
        assertThat(result.getEmail()).isEqualTo(request.getEmail());
        assertThat(result.getPasswordHash()).isEqualTo(encodedPassword);
        assertThat(result.getStatus()).isEqualTo(UserStatus.ACTIVE);
        
        verify(userRepository).save(any(User.class));
        verify(passwordEncoder).encode(request.getPassword());
    }
    
    @ParameterizedTest
    @ValueSource(strings = {"", " ", "ab", "a".repeat(51)})
    @DisplayName("Should throw exception for invalid username")
    void shouldThrowExceptionForInvalidUsername(String invalidUsername) {
        // Arrange
        CreateUserRequest request = new CreateUserRequest(invalidUsername, "test@example.com", "password123");
        
        // Act & Assert
        assertThatThrownBy(() -> userService.createUser(request))
                .isInstanceOf(IllegalArgumentException.class)
                .hasMessageContaining("Username");
    }
    
    @Test
    @DisplayName("Should return empty Optional when user not found")
    void shouldReturnEmptyOptionalWhenUserNotFound() {
        // Arrange
        long userId = 999L;
        when(userRepository.findById(userId)).thenReturn(Optional.empty());
        
        // Act
        Optional<User> result = userService.findUserById(userId);
        
        // Assert
        assertThat(result).isEmpty();
    }
}