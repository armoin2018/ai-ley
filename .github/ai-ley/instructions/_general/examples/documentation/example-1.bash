# Example documentation workflow
git checkout -b feature/user-authentication
# Develop feature and update relevant documentation
echo "## Authentication API" >> docs/api-reference.md
echo "### POST /auth/login" >> docs/api-reference.md
git add docs/api-reference.md
git commit -m "feat: add user authentication

- Implements JWT-based authentication
- Updates API documentation with login endpoint
- Includes security considerations

Closes #123"