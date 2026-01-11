# User information
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Editor and merge tool
git config --global core.editor "code --wait"
git config --global merge.tool vimdiff

# Aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.up 'pull --rebase'
git config --global alias.lg 'log --oneline --graph --decorate'

# Default behaviors
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.default simple