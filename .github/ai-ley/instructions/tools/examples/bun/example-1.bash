# Install via curl (macOS and Linux)
curl -fsSL https://bun.sh/install | bash

# Install via npm (if Node.js is available)
npm install -g bun

# Install via Homebrew (macOS)
brew tap oven-sh/bun
brew install bun

# Install via Scoop (Windows)
scoop install bun

# Install via winget (Windows)
winget install Oven-sh.Bun

# Install via Docker
docker pull oven/bun:latest

# Verify installation
bun --version
bun --help

# Update Bun
bun upgrade