func TestUserHandler_GetUser(t *testing.T) {
    gin.SetMode(gin.TestMode)
    
    tests := []struct {
        name           string
        userID         string
        setup          func(*MockUserService)
        expectedStatus int
        expectedBody   string
    }{
        {
            name:   "successful get",
            userID: "123",
            setup: func(service *MockUserService) {
                service.EXPECT().
                    GetUser(gomock.Any(), "123").
                    Return(&User{ID: "123", Name: "John"}, nil)
            },
            expectedStatus: http.StatusOK,
            expectedBody:   `{"id":"123","name":"John"}`,
        },
        {
            name:   "user not found",
            userID: "999",
            setup: func(service *MockUserService) {
                service.EXPECT().
                    GetUser(gomock.Any(), "999").
                    Return(nil, ErrUserNotFound)
            },
            expectedStatus: http.StatusNotFound,
        },
    }
    
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            ctrl := gomock.NewController(t)
            defer ctrl.Finish()
            
            mockService := NewMockUserService(ctrl)
            tt.setup(mockService)
            
            handler := NewUserHandler(mockService)
            
            w := httptest.NewRecorder()
            c, _ := gin.CreateTestContext(w)
            c.Params = []gin.Param{{Key: "id", Value: tt.userID}}
            
            handler.GetUser(c)
            
            assert.Equal(t, tt.expectedStatus, w.Code)
            if tt.expectedBody != "" {
                assert.JSONEq(t, tt.expectedBody, w.Body.String())
            }
        })
    }
}