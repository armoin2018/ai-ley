// eslint.config.js with Prettier
import prettier from 'eslint-config-prettier';

export default [
  // ... other configs
  prettier, // Must be last to override conflicting rules
  {
    rules: {
      // Custom rules that don't conflict with Prettier
      'no-console': 'warn',
    },
  },
];