# Development workflow
npm run dev                   # Start web dev server
npx cap sync                  # Sync web build to native projects

# Live reload on device
npx cap run ios --livereload-url=http://localhost:3000
npx cap run android --livereload-url=http://localhost:3000

# Build and test
npm run build                 # Build web app
npx cap sync                  # Sync build to native
npx cap build ios            # Build iOS app
npx cap build android        # Build Android app

# Debug native apps
npx cap open ios             # Open Xcode
npx cap open android         # Open Android Studio

# Plugin management
npm install @capacitor/camera
npx cap sync                 # Sync plugin to native projects

# Platform management
npx cap add ios
npx cap add android
npx cap update               # Update Capacitor
npx cap doctor              # Check configuration