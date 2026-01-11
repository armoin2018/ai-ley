// test_user_service.cpp
#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include "user_service.hpp"

class MockUserRepository : public UserRepository {
public:
    MOCK_METHOD(std::optional<User>, find_by_id, (int id), (const, override));
    MOCK_METHOD(bool, save, (const User& user), (override));
    MOCK_METHOD(std::vector<User>, find_all, (), (const, override));
    MOCK_METHOD(bool, delete_by_id, (int id), (override));
};

class MockLogger : public Logger {
public:
    MOCK_METHOD(void, info, (const std::string& message), (override));
    MOCK_METHOD(void, error, (const std::string& message), (override));
    MOCK_METHOD(void, debug, (const std::string& message), (override));
};

class UserServiceTest : public ::testing::Test {
protected:
    void SetUp() override {
        mock_repository_ = std::make_shared<MockUserRepository>();
        mock_logger_ = std::make_shared<MockLogger>();
        user_service_ = std::make_unique<UserService>(mock_repository_, mock_logger_);
    }
    
    void TearDown() override {
        // Cleanup if needed
    }
    
    std::shared_ptr<MockUserRepository> mock_repository_;
    std::shared_ptr<MockLogger> mock_logger_;
    std::unique_ptr<UserService> user_service_;
};

TEST_F(UserServiceTest, GetUser_ExistingUser_ReturnsUser) {
    // Arrange
    const User expected_user{1, "John Doe", "john@example.com"};
    EXPECT_CALL(*mock_repository_, find_by_id(1))
        .WillOnce(::testing::Return(expected_user));
    
    // Act
    auto result = user_service_->get_user(1);
    
    // Assert
    ASSERT_TRUE(result.has_value());
    EXPECT_EQ(result->get_id(), 1);
    EXPECT_EQ(result->get_name(), "John Doe");
    EXPECT_EQ(result->get_email(), "john@example.com");
}

TEST_F(UserServiceTest, GetUser_NonExistentUser_ReturnsNullopt) {
    // Arrange
    EXPECT_CALL(*mock_repository_, find_by_id(999))
        .WillOnce(::testing::Return(std::nullopt));
    
    // Act
    auto result = user_service_->get_user(999);
    
    // Assert
    EXPECT_FALSE(result.has_value());
}

TEST_F(UserServiceTest, CreateUser_ValidUser_LogsSuccessAndReturnsTrue) {
    // Arrange
    const User new_user{0, "Jane Doe", "jane@example.com"};
    EXPECT_CALL(*mock_repository_, save(::testing::_))
        .WillOnce(::testing::Return(true));
    EXPECT_CALL(*mock_logger_, info(::testing::HasSubstr("User created successfully")));
    
    // Act
    bool result = user_service_->create_user(new_user);
    
    // Assert
    EXPECT_TRUE(result);
}

// ✅ Parameterized testing for multiple scenarios
class EmailValidationTest : public ::testing::TestWithParam<std::pair<std::string, bool>> {};

INSTANTIATE_TEST_SUITE_P(
    ValidAndInvalidEmails,
    EmailValidationTest,
    ::testing::Values(
        std::make_pair("user@example.com", true),
        std::make_pair("test.email@domain.co.uk", true),
        std::make_pair("valid+email@test.org", true),
        std::make_pair("invalid.email", false),
        std::make_pair("@invalid.com", false),
        std::make_pair("user@", false)
    )
);

TEST_P(EmailValidationTest, ValidateEmail_VariousInputs_ReturnsExpectedResult) {
    auto [email, expected_valid] = GetParam();
    EXPECT_EQ(is_valid_email(email), expected_valid) 
        << "Email: " << email << " should be " << (expected_valid ? "valid" : "invalid");
}

// ✅ Performance benchmarking
class PerformanceTest : public ::testing::Test {
protected:
    static constexpr size_t LARGE_SIZE = 10000;
    
    std::vector<std::string> generate_test_data(size_t size) {
        std::vector<std::string> data;
        data.reserve(size);
        for (size_t i = 0; i < size; ++i) {
            data.push_back("test_string_" + std::to_string(i));
        }
        return data;
    }
};

TEST_F(PerformanceTest, StringBuilding_LargeDataSet_CompletesWithinTimeLimit) {
    auto test_data = generate_test_data(LARGE_SIZE);
    
    auto start = std::chrono::high_resolution_clock::now();
    auto result = good_build_csv(test_data);
    auto end = std::chrono::high_resolution_clock::now();
    
    auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
    
    EXPECT_LT(duration.count(), 100) << "String building took too long: " << duration.count() << "ms";
    EXPECT_FALSE(result.empty());
}