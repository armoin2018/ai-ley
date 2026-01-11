// eslint.config.js with Prettier integration
import prettier from 'eslint-config-prettier';

export default [
  // ... other ESLint configs
  prettier, // Must be last to override conflicting rules
  {
    rules: {
      // Custom rules that don't conflict with Prettier
      'prettier/prettier': 'error',
    },
  },
];