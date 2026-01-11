// .eslintrc.js
module.exports = {
  overrides: [
    {
      files: ['**/*.test.{js,ts,jsx,tsx}', '**/*.spec.{js,ts,jsx,tsx}'],
      env: {
        'vitest-globals/env': true,
      },
      extends: ['plugin:vitest-globals/recommended'],
      plugins: ['vitest'],
      rules: {
        'vitest/expect-expect': 'error',
        'vitest/no-conditional-expect': 'error',
        'vitest/no-identical-title': 'error',
        'vitest/prefer-to-be': 'error',
        'vitest/prefer-to-have-length': 'error',
        'vitest/valid-expect': 'error',
      },
    },
  ],
}