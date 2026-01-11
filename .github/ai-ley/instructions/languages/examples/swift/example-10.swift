import XCTest
@testable import App

class UserServiceTests: XCTestCase {
    var userService: UserService!
    var mockUserRepository: MockUserRepository!
    var mockEmailService: MockEmailService!
    
    override func setUp() {
        super.setUp()
        mockUserRepository = MockUserRepository()
        mockEmailService = MockEmailService()
        userService = UserService(
            userRepository: mockUserRepository,
            emailService: mockEmailService
        )
    }
    
    override func tearDown() {
        userService = nil
        mockUserRepository = nil
        mockEmailService = nil
        super.tearDown()
    }
    
    func testRegisterUser_Success() async throws {
        // Given
        let userData = UserRegistrationData(email: "test@example.com", name: "Test User")
        let expectedUser = User(
            id: UUID(),
            email: "test@example.com",
            name: "Test User",
            status: .active,
            createdAt: Date()
        )
        
        mockUserRepository.findUserByEmailResult = .success(nil)
        mockUserRepository.createUserResult = .success(expectedUser)
        mockEmailService.sendWelcomeEmailResult = .success(())
        
        // When
        let result = await userService.registerUser(userData: userData)
        
        // Then
        switch result {
        case .success(let user):
            XCTAssertEqual(user.email, expectedUser.email)
            XCTAssertEqual(user.name, expectedUser.name)
            XCTAssertEqual(user.status, .active)
        case .failure(let error):
            XCTFail("Expected success, got error: \(error)")
        }
        
        XCTAssertTrue(mockUserRepository.createUserCalled)
        XCTAssertTrue(mockEmailService.sendWelcomeEmailCalled)
    }
    
    func testRegisterUser_UserAlreadyExists() async throws {
        // Given
        let userData = UserRegistrationData(email: "existing@example.com", name: "Existing User")
        let existingUser = User(
            id: UUID(),
            email: "existing@example.com",
            name: "Existing User",
            status: .active,
            createdAt: Date()
        )
        
        mockUserRepository.findUserByEmailResult = .success(existingUser)
        
        // When
        let result = await userService.registerUser(userData: userData)
        
        // Then
        switch result {
        case .success:
            XCTFail("Expected failure, got success")
        case .failure(let error):
            if case .userAlreadyExists(let email) = error {
                XCTAssertEqual(email, "existing@example.com")
            } else {
                XCTFail("Expected userAlreadyExists error, got: \(error)")
            }
        }
        
        XCTAssertFalse(mockUserRepository.createUserCalled)
        XCTAssertFalse(mockEmailService.sendWelcomeEmailCalled)
    }
}

// Mock implementations
class MockUserRepository: UserRepository {
    var findUserByEmailResult: Result<User?, Error> = .success(nil)
    var createUserResult: Result<User, Error> = .failure(MockError.notImplemented)
    var createUserCalled = false
    
    func findUser(by email: String) async throws -> User? {
        switch findUserByEmailResult {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
    
    func createUser(_ userData: UserRegistrationData) async throws -> User {
        createUserCalled = true
        switch createUserResult {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
}

enum MockError: Error {
    case notImplemented
}