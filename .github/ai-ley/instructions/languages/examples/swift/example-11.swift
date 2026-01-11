import XCTest
import SwiftUI
@testable import App

class UserProfileViewTests: XCTestCase {
    func testUserProfileView_LoadsUserOnAppear() {
        // Given
        let mockGetUserUseCase = MockGetUserUseCase()
        let mockUpdateUserUseCase = MockUpdateUserUseCase()
        let userId = UUID()
        
        mockGetUserUseCase.executeResult = .success(User(
            id: userId,
            email: "test@example.com",
            name: "Test User",
            status: .active,
            createdAt: Date()
        ))
        
        // When
        let view = UserProfileView(
            userId: userId,
            getUserUseCase: mockGetUserUseCase,
            updateUserUseCase: mockUpdateUserUseCase
        )
        
        // Then
        let hostingController = UIHostingController(rootView: view)
        hostingController.loadViewIfNeeded()
        
        // Simulate view appearing
        hostingController.viewWillAppear(false)
        
        XCTAssertTrue(mockGetUserUseCase.executeCalled)
        XCTAssertEqual(mockGetUserUseCase.lastUsedId, userId)
    }
}