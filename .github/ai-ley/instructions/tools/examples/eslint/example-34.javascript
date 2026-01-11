// Optimized configuration for large projects
export default [
  {
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.json', './packages/*/tsconfig.json'],
        tsconfigRootDir: import.meta.dirname,
        EXPERIMENTAL_useSourceOfProjectReferenceRedirect: true,
      },
    },
  },
];