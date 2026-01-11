# Create new project
mkdir my-project && cd my-project
pnpm init

# Initialize with specific details
pnpm init --yes
pnpm init --scope=@company

# Convert from npm/yarn
cd existing-project
rm package-lock.json     # Remove npm lock
rm yarn.lock             # Remove yarn lock
pnpm install             # Generate pnpm-lock.yaml

# Create project from template
pnpm create react-app my-app
pnpm create next-app my-app
pnpm create vite my-app --template react-ts
pnpm create @vitejs/app my-vue-app --template vue-ts