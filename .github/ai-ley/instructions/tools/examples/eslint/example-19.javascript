// eslint.config.js for Node.js
import nodePlugin from 'eslint-plugin-node';

export default [
  {
    files: ['**/*.js'],
    plugins: {
      node: nodePlugin,
    },
    rules: {
      'node/no-missing-import': 'error',
      'node/no-unpublished-require': 'error',
      'node/prefer-global/process': 'error',
    },
    languageOptions: {
      globals: {
        global: 'readonly',
        process: 'readonly',
        Buffer: 'readonly',
      },
    },
  },
];