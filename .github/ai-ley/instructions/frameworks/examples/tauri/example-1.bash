# Install Rust (prerequisite)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install Tauri CLI
cargo install tauri-cli

# Create new Tauri app with React
npm create tauri-app@latest my-app
cd my-app

# Or with specific frontend
npm create tauri-app@latest my-app -- --template react-ts
npm create tauri-app@latest my-app -- --template vue-ts
npm create tauri-app@latest my-app -- --template svelte-ts
npm create tauri-app@latest my-app -- --template vanilla-ts

# Install dependencies and start development
npm install
npm run tauri dev