// prettier.config.js for monorepo
export default {
  semi: true,
  singleQuote: true,
  overrides: [
    {
      files: 'apps/web/**/*.{js,jsx,ts,tsx}',
      options: {
        printWidth: 80,
        jsxSingleQuote: true,
        plugins: ['prettier-plugin-tailwindcss'],
      },
    },
    {
      files: 'apps/api/**/*.{js,ts}',
      options: {
        printWidth: 120,
        trailingComma: 'all',
      },
    },
    {
      files: 'packages/**/*.{js,ts}',
      options: {
        printWidth: 100,
        tabWidth: 2,
      },
    },
  ],
};