// user_service_test.go
func TestUserService_CreateUser(t *testing.T) {
    tests := []struct {
        name    string
        request CreateUserRequest
        setup   func(*MockUserRepository)
        want    *User
        wantErr bool
    }{
        {
            name: "successful creation",
            request: CreateUserRequest{
                Name:  "John Doe",
                Email: "john@example.com",
            },
            setup: func(repo *MockUserRepository) {
                repo.EXPECT().
                    Create(gomock.Any(), gomock.Any()).
                    Return(nil)
            },
            want: &User{
                ID:    "123",
                Name:  "John Doe",
                Email: "john@example.com",
            },
            wantErr: false,
        },
        {
            name: "repository error",
            request: CreateUserRequest{
                Name:  "John Doe",
                Email: "john@example.com",
            },
            setup: func(repo *MockUserRepository) {
                repo.EXPECT().
                    Create(gomock.Any(), gomock.Any()).
                    Return(errors.New("database error"))
            },
            want:    nil,
            wantErr: true,
        },
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            ctrl := gomock.NewController(t)
            defer ctrl.Finish()
            
            mockRepo := NewMockUserRepository(ctrl)
            tt.setup(mockRepo)
            
            service := NewUserService(mockRepo, &testLogger{})
            
            got, err := service.CreateUser(context.Background(), tt.request)
            
            if tt.wantErr {
                assert.Error(t, err)
                assert.Nil(t, got)
            } else {
                assert.NoError(t, err)
                assert.Equal(t, tt.want.Name, got.Name)
                assert.Equal(t, tt.want.Email, got.Email)
            }
        })
    }
}

// ✅ Benchmark tests
func BenchmarkProcessData(b *testing.B) {
    data := generateTestData(1000)
    
    b.ResetTimer()
    for i := 0; i < b.N; i++ {
        processData(data)
    }
}

// ✅ Integration tests
func TestIntegration_UserAPI(t *testing.T) {
    if testing.Short() {
        t.Skip("skipping integration test")
    }
    
    // Setup test database
    db := setupTestDB(t)
    defer cleanupTestDB(t, db)
    
    server := setupTestServer(t, db)
    
    // Test cases...
}