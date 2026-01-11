# Filter by package name
pnpm --filter="@company/frontend" run build
pnpm --filter="*ui*" run test

# Filter by path
pnpm --filter="./packages/frontend" install
pnpm --filter="./apps/*" run dev

# Filter by dependency relationship
pnpm --filter="...@company/shared" run build    # Dependents
pnpm --filter="@company/frontend..." run test   # Dependencies

# Filter with exclusions
pnpm --filter="./packages/*" --filter="!./packages/legacy" run lint

# Complex filtering
pnpm --filter="[origin/main]" run test          # Changed since main
pnpm --filter="{./packages/ui}..." run build    # Dependencies of ui