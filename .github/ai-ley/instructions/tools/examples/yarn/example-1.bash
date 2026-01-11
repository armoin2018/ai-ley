# Install via npm (Yarn 1.x)
npm install -g yarn

# Install via Homebrew (macOS)
brew install yarn

# Install via Chocolatey (Windows)
choco install yarn

# Install via package manager (Ubuntu/Debian)
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn

# Enable Corepack (Node.js 16.10+) - for Yarn 3+
corepack enable
corepack prepare yarn@stable --activate

# Verify installation
yarn --version