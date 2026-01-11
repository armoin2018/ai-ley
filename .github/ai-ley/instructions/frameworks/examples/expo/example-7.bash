# Project management
npx create-expo-app <name> --template  # Create new project
expo init <name>                       # Legacy create command
expo install <package>                 # Install Expo-compatible package

# Development
expo start                            # Start development server
expo start --ios                     # Start with iOS simulator
expo start --android                 # Start with Android emulator
expo start --web                     # Start web development

# Building and deployment
eas build:configure                   # Setup EAS Build
eas build --platform all            # Build for all platforms
eas submit                          # Submit to app stores
eas update                          # Push over-the-air updates

# Debugging and analysis
expo doctor                         # Check project health
expo install --fix                 # Fix dependency issues
expo customize                     # Eject to bare workflow