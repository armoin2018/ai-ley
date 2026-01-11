# Install Node.js and npm (v16+ recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install --lts
nvm use --lts

# Install essential blockchain development tools
npm install -g @remix-project/remixd
npm install -g truffle
npm install -g @openzeppelin/cli
npm install -g hardhat-shorthand

# Install Foundry (Rust-based development framework)
curl -L https://foundry.paradigm.xyz | bash
foundryup