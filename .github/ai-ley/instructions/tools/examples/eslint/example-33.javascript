// eslint.config.js for monorepo
export default [
  {
    files: ['packages/frontend/**/*.{js,jsx,ts,tsx}'],
    // Frontend-specific configuration
  },
  {
    files: ['packages/backend/**/*.{js,ts}'],
    // Backend-specific configuration
  },
  {
    files: ['packages/shared/**/*.{js,ts}'],
    // Shared code configuration
  },
];