# Pre-commit hook example
#!/bin/sh
docker build -t myapp:test . && docker run --rm myapp:test npm test