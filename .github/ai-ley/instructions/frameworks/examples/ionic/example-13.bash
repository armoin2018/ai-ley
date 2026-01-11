# Development
ionic serve                    # Web development
ionic serve --lab            # Device preview mode

# Build
ionic build                   # Web build
ionic build --prod           # Production build

# Native development
ionic capacitor build ios     # iOS build
ionic capacitor build android # Android build
ionic capacitor run ios --livereload    # Live reload on iOS
ionic capacitor run android --livereload # Live reload on Android

# Testing
npm test                      # Unit tests
npm run e2e                   # End-to-end tests

# Deployment
ionic build --prod
ionic capacitor sync
ionic capacitor build ios --prod
ionic capacitor build android --prod