# npm installation (most common)
npm install --save-dev esbuild
npm install -g esbuild

# yarn installation
yarn add --dev esbuild
yarn global add esbuild

# pnpm installation
pnpm add -D esbuild
pnpm add -g esbuild

# Deno installation
deno install --allow-all --name esbuild https://deno.land/x/esbuild/mod.js

# Go installation (native binary)
go install github.com/evanw/esbuild/cmd/esbuild@latest

# Download binary directly
curl -fsSL https://esbuild.github.io/download/latest | sh

# Platform-specific binaries
# macOS
curl -fsSL https://registry.npmjs.org/@esbuild/darwin-x64/-/darwin-x64-0.20.0.tgz

# Linux
curl -fsSL https://registry.npmjs.org/@esbuild/linux-x64/-/linux-x64-0.20.0.tgz

# Windows
curl -fsSL https://registry.npmjs.org/@esbuild/win32-x64/-/win32-x64-0.20.0.tgz

# Verify installation
esbuild --version
npx esbuild --version