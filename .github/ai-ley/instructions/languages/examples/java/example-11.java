// UserIntegrationTest.java
@SpringBootTest
@Testcontainers
@Transactional
class UserIntegrationTest {
    
    @Container
    static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:13")
            .withDatabaseName("testdb")
            .withUsername("test")
            .withPassword("test");
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserRepository userRepository;
    
    @Test
    @DisplayName("Should create and retrieve user from database")
    void shouldCreateAndRetrieveUser() {
        // Arrange
        CreateUserRequest request = new CreateUserRequest("integrationuser", "integration@test.com", "password123");
        
        // Act
        User createdUser = userService.createUser(request);
        Optional<User> retrievedUser = userService.findUserById(createdUser.getId());
        
        // Assert
        assertThat(retrievedUser).isPresent();
        assertThat(retrievedUser.get().getUsername()).isEqualTo(request.getUsername());
        assertThat(retrievedUser.get().getEmail()).isEqualTo(request.getEmail());
    }
}