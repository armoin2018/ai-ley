# Measure hook performance
time ./.husky/pre-commit

# Use lint-staged for incremental checking
npx lint-staged --debug

# Profile specific commands
time npm run lint
time npm run test

# Optimize package.json scripts
{
  "scripts": {
    "lint:fast": "eslint --cache src/",
    "test:fast": "jest --onlyChanged"
  }
}