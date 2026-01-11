# Install TypeScript parser
npm install @typescript-eslint/parser --save-dev

# Verify tsconfig.json exists and is valid
npx tsc --noEmit --skipLibCheck

# Update parser configuration
# Set parser: "@typescript-eslint/parser" in config