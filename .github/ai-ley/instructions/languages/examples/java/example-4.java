// ✅ Well-structured service layer with dependency injection
@Service
public class UserService {
    private final UserRepository userRepository;
    private final EmailValidator emailValidator;
    private final PasswordEncoder passwordEncoder;
    
    public UserService(UserRepository userRepository, 
                      EmailValidator emailValidator,
                      PasswordEncoder passwordEncoder) {
        this.userRepository = Objects.requireNonNull(userRepository);
        this.emailValidator = Objects.requireNonNull(emailValidator);
        this.passwordEncoder = Objects.requireNonNull(passwordEncoder);
    }
    
    @Transactional
    public User createUser(CreateUserRequest request) {
        validateRequest(request);
        
        User user = User.builder()
                .username(request.getUsername())
                .email(request.getEmail())
                .passwordHash(passwordEncoder.encode(request.getPassword()))
                .status(UserStatus.ACTIVE)
                .build();
                
        return userRepository.save(user);
    }
    
    private void validateRequest(CreateUserRequest request) {
        if (!emailValidator.isValid(request.getEmail())) {
            throw new InvalidEmailException("Invalid email format: " + request.getEmail());
        }
        
        if (userRepository.existsByUsername(request.getUsername())) {
            throw new UserAlreadyExistsException("Username already exists: " + request.getUsername());
        }
    }
}