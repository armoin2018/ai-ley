// Commands run in sequence, stop on first failure
'*.js': [
  'eslint --fix',        // Fix linting issues first
  'prettier --write',    // Format code
  'git add',             // Stage the fixed files
  'jest --findRelatedTests'  // Run related tests
]