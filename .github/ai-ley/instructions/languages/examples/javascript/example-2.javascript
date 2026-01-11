// ✅ Good: Use camelCase for variables and functions
const userName = 'john_doe';
const userAge = 25;

function calculateUserScore(user) {
  return user.points * user.multiplier;
}

// ✅ Good: Use PascalCase for classes and constructors
class UserManager {
  constructor(database) {
    this.database = database;
  }
}

// ✅ Good: Use UPPER_SNAKE_CASE for constants
const MAX_RETRY_ATTEMPTS = 3;
const API_BASE_URL = 'https://api.example.com';

// ✅ Good: Use descriptive names
const isUserAuthenticated = checkAuthStatus();
const filteredUsers = users.filter(user => user.isActive);