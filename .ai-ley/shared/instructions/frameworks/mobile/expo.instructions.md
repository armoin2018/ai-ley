---
title: 'Expo React Native Development Platform Instructions'
description: 'Comprehensive guide for building React Native applications with Expo platform, tools, and services for faster mobile development'
category: 'Mobile Frameworks'

tags:
  ['expo', 'react-native', 'mobile', 'cross-platform', 'javascript', 'typescript', 'eas', 'snack']
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/app.json'
  - '**/app.config.*'
  - '**/eas.json'
  - '**/expo/**'
  - '**/.expo/**'
  - '**/App.js'
  - '**/App.tsx'
---

# Expo React Native Development Platform Instructions

## Framework Overview

- **Framework Name**: Expo
- **Version**: SDK 50+ (Latest stable with React Native 0.73+ support)
- **Type**: React Native Development Platform and Toolchain
- **Language**: JavaScript, TypeScript, React Native
- **Use Cases**: Rapid React Native prototyping, managed mobile development, universal apps, cross-platform deployment

## When to Use Expo

### ✅ **Use Expo When**

- Starting new React Native projects with rapid development needs
- Team wants managed development workflow without native build configuration
- Need to deploy quickly to app stores with minimal setup
- Building apps that don't require custom native modules or extensive platform-specific code
- Want to share and test apps easily with stakeholders via Expo Go
- Need universal apps that run on web, mobile, and potentially desktop
- Prototyping mobile concepts with quick iteration cycles
- Working with designers who need to see real device previews instantly

### ❌ **Avoid Expo When**

- App requires extensive custom native modules not available in Expo SDK
- Need fine-grained control over native build process and configurations
- Building apps with complex native integrations (custom cameras, specialized sensors)
- Working with existing React Native projects with significant native customizations
- Performance requirements demand highly optimized native implementations
- Need to integrate with specific enterprise SDKs not supported by Expo
- App requires background processing or native functionality beyond Expo's scope

## Installation & Setup

### Prerequisites

```bash
# Install Node.js (version 18+ recommended)
node --version  # Should be 18.0.0 or higher
npm --version   # Should be 9.0.0 or higher

# Install Expo CLI
npm install -g @expo/cli

# Verify installation
expo --version

# Install EAS CLI for building and deployment
npm install -g @expo/eas-cli

# Login to Expo account
expo login
eas login
```

### Project Initialization

```bash
# Create new Expo project
npx create-expo-app MyApp --template

# Available templates:
# - blank (minimal setup)
# - blank-typescript (TypeScript)
# - tabs (bottom tab navigation)
# - bare-minimum (bare workflow)

# Navigate to project
cd MyApp

# Start development server
expo start

# Start with specific platform
expo start --ios     # iOS simulator
expo start --android  # Android emulator
expo start --web     # Web browser
```

## Project Structure

```
MyApp/
├── app.json              # Expo configuration
├── App.js/App.tsx        # Main application entry
├── package.json          # Dependencies and scripts
├── babel.config.js       # Babel configuration
├── metro.config.js       # Metro bundler configuration
├── assets/               # Images, fonts, and static assets
│   ├── images/
│   └── fonts/
├── components/           # Reusable UI components
├── screens/              # Screen components
├── navigation/           # Navigation configuration
├── hooks/                # Custom React hooks
├── utils/                # Utility functions
├── constants/            # App constants and configuration
└── .expo/                # Expo-generated files (gitignored)
```

## Core Concepts

### Expo SDK and APIs

- **Purpose**: Pre-built native modules and APIs for common mobile functionality
- **Usage**: Access device features without writing native code
- **Example**:

```javascript
import * as Camera from 'expo-camera';
import * as Location from 'expo-location';
import * as Notifications from 'expo-notifications';

// Request camera permissions
const { status } = await Camera.requestCameraPermissionsAsync();

// Get current location
const location = await Location.getCurrentPositionAsync({});

// Schedule notification
await Notifications.scheduleNotificationAsync({
  content: {
    title: 'Hello!',
    body: 'This is a test notification',
  },
  trigger: { seconds: 5 },
});
```

### Development Workflow

- **Purpose**: Streamlined development with instant updates and easy testing
- **Usage**: Develop, test, and iterate quickly across multiple devices
- **Example**:

```bash
# Start development server with QR code
expo start

# Open on physical device with Expo Go app
# Scan QR code with camera (iOS) or Expo Go (Android)

# Development commands
expo start --clear     # Clear cache
expo start --offline   # Work offline
expo start --tunnel    # Use tunnel for remote access

# Preview on web
expo start --web
```

### EAS Build and Deployment

- **Purpose**: Cloud-based build service for creating app store-ready builds
- **Usage**: Build and deploy apps without local native development environment
- **Example**:

```bash
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
```

## Essential Commands

```bash
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
```

## Best Practices

### ✅ **Development Optimization**

- **Use TypeScript** - Leverage Expo's excellent TypeScript support for better development experience
- **Optimize bundle size** - Use dynamic imports and lazy loading for better performance
- **Handle permissions properly** - Always request permissions before using device APIs
- **Use Expo SDK modules** - Prefer Expo modules over third-party alternatives when available
- **Test on real devices** - Use Expo Go for quick testing on actual hardware
- **Implement error boundaries** - Handle errors gracefully in React Native components

### ✅ **Performance Best Practices**

- **Optimize images** - Use appropriate image formats and sizes for mobile
- **Implement lazy loading** - Load screens and components on demand
- **Use FlatList for large lists** - Better performance than ScrollView for long lists
- **Minimize re-renders** - Use React.memo and useMemo appropriately
- **Profile with Flipper** - Use debugging tools to identify performance bottlenecks
- **Enable Hermes** - Use Hermes JavaScript engine for better performance

### ❌ **Common Pitfalls to Avoid**

- **Don't ignore platform differences** - Test thoroughly on both iOS and Android
- **Don't overuse Expo Go** - Build standalone apps for production testing
- **Don't skip permission handling** - Always handle permission rejections gracefully
- **Don't use large bundle sizes** - Monitor and optimize app size regularly
- **Don't ignore update strategies** - Plan for over-the-air updates and rollbacks
- **Don't neglect offline functionality** - Consider offline scenarios in app design

## AI Agent Guidelines

When helping with Expo development:

1. **Always recommend latest Expo SDK** - Use most recent stable version for new projects
2. **Suggest appropriate workflow** - Help choose between managed and bare workflow
3. **Provide TypeScript examples** - Default to TypeScript for better development experience
4. **Include permission handling** - Always show proper permission request patterns
5. **Consider cross-platform differences** - Provide platform-specific guidance when needed
6. **Recommend EAS services** - Suggest EAS Build and EAS Update for deployment
7. **Focus on developer experience** - Emphasize Expo's development speed advantages
8. **Security considerations** - Include secure storage and API communication patterns

### Code Generation Rules

- Generate TypeScript code by default for new projects
- Include proper error handling for all async operations
- Use Expo SDK modules instead of third-party alternatives when possible
- Include platform-specific code when iOS/Android differences exist
- Follow React Native best practices for component structure
- Include navigation patterns using React Navigation
- Generate responsive layouts that work on different screen sizes
- Include proper permission handling for device API usage

## Installation & Setup

```bash
# Installation commands
[package manager install command]

# Project initialization
[framework CLI or setup commands]
```

## Project Structure

```
project-root/
├── [typical folder structure]
├── [configuration files]
├── [source directories]
└── [other important directories]
```

## Core Concepts

### [Concept 1]

- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

### [Concept 2]

- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

## Development Workflow

1. **Setup**: [Initial project setup steps]
2. **Development**: [Development server, hot reload, etc.]
3. **Testing**: [Testing framework and commands]
4. **Building**: [Build process and commands]
5. **Deployment**: [Deployment strategies]

## Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

## Common Patterns

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

## Configuration

### [Config File 1]

```[format]
# Configuration options
[example configuration]
```

### [Config File 2]

```[format]
# Configuration options
[example configuration]
```

## Essential Commands

```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions

### [Issue 1]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization

- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations

- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources

- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines

### Code Style

- [Coding conventions specific to this framework]
- [Naming conventions]
- [File organization patterns]

### Architecture Patterns

- [Recommended architectural patterns]
- [State management approaches]
- [Component/module organization]

## Integration Points

### [External Service/Tool 1]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

### [External Service/Tool 2]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

## Version Compatibility

- **Node.js**: [Supported versions]
- **Dependencies**: [Key dependency versions]
- **Browser Support**: [If applicable]
- **OS Support**: [If applicable]

## Troubleshooting

### Debug Mode

```bash
[debug commands]
```

### Log Analysis

- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages

- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]
