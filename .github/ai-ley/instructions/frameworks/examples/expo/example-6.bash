# Configure EAS Build
eas build:configure

# Build for different platforms
eas build --platform ios
eas build --platform android
eas build --platform all

# Submit to app stores
eas submit --platform ios
eas submit --platform android

# Preview builds
eas build --platform ios --profile preview