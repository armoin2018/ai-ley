// cypress/fixtures/users.json - Test data fixtures
{
  "adminUser": {
    "email": "admin@example.com",
    "password": "admin123",
    "firstName": "Admin",
    "lastName": "User",
    "role": "administrator"
  },
  "regularUser": {
    "email": "user@example.com",
    "password": "user123",
    "firstName": "Regular",
    "lastName": "User",
    "role": "user"
  },
  "userProfiles": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "avatar": "/images/john.jpg",
      "bio": "Software developer",
      "joinDate": "2023-01-15"
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "email": "jane@example.com",
      "avatar": "/images/jane.jpg",
      "bio": "Product manager",
      "joinDate": "2023-02-20"
    }
  ]
}