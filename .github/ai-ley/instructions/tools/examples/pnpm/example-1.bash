# Install via npm (most common)
npm install -g pnpm

# Install via Homebrew (macOS)
brew install pnpm

# Install via Scoop (Windows)
scoop install nodejs pnpm

# Install via Chocolatey (Windows)
choco install pnpm

# Install via standalone script (Linux/macOS)
curl -fsSL https://get.pnpm.io/install.sh | sh -
wget -qO- https://get.pnpm.io/install.sh | sh -

# Install via Corepack (Node.js 16.13+)
corepack enable
corepack prepare pnpm@latest --activate

# Update pnpm
pnpm add -g pnpm
# or
pnpm install -g pnpm@latest

# Verify installation
pnpm --version
pnpm info