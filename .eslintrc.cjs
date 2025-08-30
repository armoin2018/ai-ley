module.exports = {
  // Environment configuration
  env: {
    node: true,
    es2022: true,
    jest: true,
  },
  
  // Extend recommended configurations
  extends: [
    'eslint:recommended',
  ],
  
  // Parser configuration for TypeScript
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: 'module',
  },
  
  // TypeScript ESLint plugin
  plugins: ['@typescript-eslint'],
  
  // Rule configurations aligned with project standards
  rules: {
    // Basic JavaScript rules
    'no-unused-vars': 'off', // Turn off to use TypeScript version
    'no-undef': 'off', // TypeScript handles this
    
    // Code quality rules
    'no-console': 'warn',
    'no-debugger': 'error',
    'no-duplicate-imports': 'error',
    'prefer-const': 'error',
    'no-var': 'error',
    
    // Style rules (to complement Prettier)
    'max-len': ['warn', { code: 100, ignoreUrls: true, ignoreStrings: true }],
    'no-multiple-empty-lines': ['error', { max: 2, maxEOF: 1 }],
    'eol-last': 'error',
    'comma-dangle': ['error', 'always-multiline'],
    
    // Security rules
    'no-eval': 'error',
    'no-implied-eval': 'error',
    'no-new-func': 'error',
    
    // Best practices
    'prefer-promise-reject-errors': 'error',
    'require-atomic-updates': 'error',
    'no-return-await': 'error',
    'prefer-arrow-callback': 'error',
    
    // Import/export rules
    'no-duplicate-imports': 'error',
    'sort-imports': ['error', { ignoreDeclarationSort: true }],
  },
  
  // File-specific rule overrides
  overrides: [
    {
      // Test files can be more lenient
      files: ['tests/**/*.ts', '**/*.test.ts', '**/*.spec.ts'],
      rules: {
        '@typescript-eslint/no-explicit-any': 'off',
        'no-console': 'off',
        '@typescript-eslint/no-non-null-assertion': 'off',
      },
    },
    {
      // Configuration files
      files: ['*.config.js', '*.config.ts', 'jest.config.cjs'],
      rules: {
        '@typescript-eslint/no-var-requires': 'off',
        'no-console': 'off',
      },
    },
    {
      // MCP server file - allow any due to JSON-RPC nature
      files: ['src/mcp.ts'],
      rules: {
        '@typescript-eslint/no-explicit-any': 'off',
        '@typescript-eslint/no-unsafe-assignment': 'off',
        '@typescript-eslint/no-unsafe-member-access': 'off',
        '@typescript-eslint/no-unsafe-call': 'off',
        '@typescript-eslint/no-unsafe-return': 'off',
      },
    },
  ],
  
  // Ignore patterns
  ignorePatterns: [
    'dist/',
    'node_modules/',
    'coverage/',
    '*.js',
    '!.eslintrc.js',
    '!jest.config.cjs',
    'vscode-extension/',
  ],
};