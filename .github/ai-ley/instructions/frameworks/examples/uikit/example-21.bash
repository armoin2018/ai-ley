# Lint Less/CSS
stylelint "src/**/*.less"

# Lint JavaScript
eslint src/**/*.js

# Run accessibility tests
pa11y http://localhost:3000

# Performance testing
lighthouse http://localhost:3000 --output html --output-path ./report.html