// Custom rules in eslint.config.js
{
  rules: {
    "max-len": ["error", { "code": 120, "ignoreUrls": true }],
    "no-magic-numbers": ["warn", { "ignore": [0, 1, -1] }],
    "prefer-arrow-callback": "error"
  }
}