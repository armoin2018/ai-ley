// Test file specific configuration
export default [
  {
    files: ['**/*.test.{js,jsx,ts,tsx}', '**/__tests__/**'],
    plugins: {
      jest: jestPlugin,
    },
    rules: {
      'jest/expect-expect': 'error',
      'jest/no-disabled-tests': 'warn',
      'jest/prefer-to-be': 'error',
    },
  },
];