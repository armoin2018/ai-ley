// ✅ Comprehensive API documentation
/**
 * REST controller for managing user accounts.
 * 
 * <p>This controller provides endpoints for user CRUD operations,
 * including registration, authentication, and profile management.
 * 
 * @author Development Team
 * @version 1.0
 * @since 1.0
 */
@RestController
@RequestMapping("/api/v1/users")
@Validated
public class UserController {
    
    /**
     * Creates a new user account.
     * 
     * @param request the user creation request containing username, email, and password
     * @return the created user information (excluding password)
     * @throws UserAlreadyExistsException if username or email already exists
     */
    @PostMapping
    public ResponseEntity<UserResponse> createUser(@Valid @RequestBody CreateUserRequest request) {
        User user = userService.createUser(request);
        UserResponse response = UserResponse.fromUser(user);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}