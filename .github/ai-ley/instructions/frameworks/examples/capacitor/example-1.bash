# Install Capacitor core
npm install @capacitor/core
npm install -D @capacitor/cli

# Initialize Capacitor
npx cap init [appName] [appId]
# Example: npx cap init "My App" "com.example.myapp"

# Add platforms
npx cap add ios
npx cap add android

# Build web app and sync
npm run build
npx cap sync

# Open in native IDEs
npx cap open ios
npx cap open android