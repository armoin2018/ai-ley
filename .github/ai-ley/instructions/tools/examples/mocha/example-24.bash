# Install NYC
npm install nyc --save-dev

# Configure in package.json
{
  "nyc": {
    "reporter": ["html", "text", "lcov"],
    "exclude": [
      "test/**",
      "coverage/**",
      "node_modules/**"
    ],
    "check-coverage": true,
    "lines": 80,
    "functions": 80,
    "branches": 80,
    "statements": 80
  }
}