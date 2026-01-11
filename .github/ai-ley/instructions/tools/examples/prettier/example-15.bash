# Install husky and lint-staged
npm install husky lint-staged --save-dev

# Setup pre-commit hook
npx husky install
npx husky add .husky/pre-commit "npx lint-staged"