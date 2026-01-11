# Install dependencies for all workspace packages
pnpm install

# Install for specific workspace
pnpm install --filter=@company/frontend
pnpm install --filter=./packages/ui

# Add dependency to specific workspace
pnpm add react --filter=@company/frontend
pnpm add -D typescript --filter=./packages/shared

# Run scripts across workspaces
pnpm run build --filter=@company/frontend
pnpm run test --filter="./packages/*"
pnpm run lint --filter="...{packages/ui}"

# Recursive operations
pnpm run build --recursive          # Run in all workspaces
pnpm run test -r                    # Short form
pnpm run lint --parallel            # Run in parallel

# Workspace-specific operations
pnpm --filter=frontend run dev      # Run dev in frontend package
pnpm --filter="@company/*" run build # Run build in all @company packages