# Development
npx expo start

# Platform-specific development
npx expo start --ios
npx expo start --android

# Type checking
npx tsc --noEmit

# Testing
npm test
npm run test:watch

# Building
eas build --platform all
eas build --platform ios
eas build --platform android

# Deployment
eas submit --platform all