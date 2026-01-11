# Create new project
mkdir my-project && cd my-project
bun init

# Initialize with specific template
bun create react-app my-react-app
bun create next-app my-next-app
bun create vite my-vite-app
bun create discord-bot my-bot

# Initialize existing project with Bun
cd existing-project
bun install                    # Creates bun.lockb

# Convert from package-lock.json or yarn.lock
rm package-lock.json yarn.lock
bun install