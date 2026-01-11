// prettier.config.js (for complex configurations)
export default {
  // Base configuration
  semi: true,
  singleQuote: true,
  printWidth: 80,
  tabWidth: 2,
  trailingComma: 'es5',

  // React/JSX specific
  jsxSingleQuote: true,
  bracketSameLine: false,

  // Import sorting (with plugin)
  importOrder: ['^react$', '^next', '<THIRD_PARTY_MODULES>', '^@/(.*)$', '^[./]'],
  importOrderSeparation: true,

  // Override for specific file types
  overrides: [
    {
      files: '*.{css,scss,less}',
      options: {
        singleQuote: false,
        printWidth: 120,
      },
    },
    {
      files: '*.md',
      options: {
        proseWrap: 'always',
        printWidth: 100,
      },
    },
    {
      files: '*.json',
      options: {
        printWidth: 120,
        tabWidth: 2,
      },
    },
  ],

  // Plugin configurations
  plugins: ['@trivago/prettier-plugin-sort-imports'],
};