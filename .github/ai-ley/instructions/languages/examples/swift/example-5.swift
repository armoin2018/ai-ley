// ✅ ViewModel with proper state management
@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let getUserUseCase: GetUserUseCase
    private let updateUserUseCase: UpdateUserUseCase
    
    init(getUserUseCase: GetUserUseCase, updateUserUseCase: UpdateUserUseCase) {
        self.getUserUseCase = getUserUseCase
        self.updateUserUseCase = updateUserUseCase
    }
    
    func loadUser(id: UUID) {
        Task {
            isLoading = true
            errorMessage = nil
            
            let result = await getUserUseCase.execute(id: id)
            
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
    
    func updateUserName(_ newName: String) {
        guard var currentUser = user else { return }
        
        Task {
            isLoading = true
            
            currentUser.name = newName
            let result = await updateUserUseCase.execute(user: currentUser)
            
            switch result {
            case .success(let updatedUser):
                self.user = updatedUser
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
}

// SwiftUI View
struct UserProfileView: View {
    @StateObject private var viewModel: UserProfileViewModel
    let userId: UUID
    
    init(userId: UUID, getUserUseCase: GetUserUseCase, updateUserUseCase: UpdateUserUseCase) {
        self.userId = userId
        self._viewModel = StateObject(wrapping: UserProfileViewModel(
            getUserUseCase: getUserUseCase,
            updateUserUseCase: updateUserUseCase
        ))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let user = viewModel.user {
                    UserInfoView(user: user) { newName in
                        viewModel.updateUserName(newName)
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage) {
                        viewModel.loadUser(id: userId)
                    }
                }
            }
            .navigationTitle("User Profile")
            .onAppear {
                viewModel.loadUser(id: userId)
            }
        }
    }
}

struct UserInfoView: View {
    let user: User
    let onNameUpdate: (String) -> Void
    
    @State private var isEditingName = false
    @State private var editedName = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Name:")
                    .font(.headline)
                
                if isEditingName {
                    TextField("Enter name", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Save") {
                        onNameUpdate(editedName)
                        isEditingName = false
                    }
                    .disabled(editedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                } else {
                    Text(user.name)
                    
                    Button("Edit") {
                        editedName = user.name
                        isEditingName = true
                    }
                }
            }
            
            HStack {
                Text("Email:")
                    .font(.headline)
                Text(user.email)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Text("Status:")
                    .font(.headline)
                StatusBadge(status: user.status)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}