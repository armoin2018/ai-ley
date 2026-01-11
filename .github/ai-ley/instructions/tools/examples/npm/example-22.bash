# Change global prefix
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH

# Or use Node Version Manager (recommended)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node