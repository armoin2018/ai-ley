// prettier.config.js with complex overrides
export default {
  semi: true,
  singleQuote: true,
  overrides: [
    // React components
    {
      files: 'src/components/**/*.{jsx,tsx}',
      options: {
        printWidth: 80,
        jsxSingleQuote: true,
        bracketSameLine: false,
      },
    },
    // Utility files
    {
      files: 'src/utils/**/*.{js,ts}',
      options: {
        printWidth: 120,
        arrowParens: 'always',
      },
    },
    // Test files
    {
      files: '**/*.{test,spec}.{js,ts,jsx,tsx}',
      options: {
        printWidth: 100,
        trailingComma: 'all',
      },
    },
    // Configuration files
    {
      files: ['*.config.{js,ts}', '.*rc.{js,json}'],
      options: {
        printWidth: 120,
        tabWidth: 2,
      },
    },
  ],
};