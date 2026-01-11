# Example Agile development workflow
git checkout -b feature/user-story-123
# Develop feature with TDD approach
npm run test:watch
# Commit frequently with descriptive messages
git commit -m "feat: add user authentication endpoint

- Implements OAuth 2.0 integration
- Adds input validation and error handling
- Includes unit tests with 95% coverage

Closes #123"