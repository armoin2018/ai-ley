# Optimize for performance
pnpm config set side-effects-cache true
pnpm config set package-import-method hardlink
pnpm install --prefer-offline --no-optional