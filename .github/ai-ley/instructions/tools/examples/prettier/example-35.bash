# .prettierignore for security
# Environment files
.env*
*.key
*.pem

# Configuration with secrets
docker-compose.yml
kubernetes-secrets.yaml

# Large generated files
bundle.js
*.min.js
coverage/