---
title: 'Apache Cordova Mobile Development Framework Instructions'
description: 'Comprehensive guide for Apache Cordova hybrid mobile app development using web technologies for iOS, Android, and other platforms'
category: 'Mobile Frameworks'

tags:
  [
    'cordova',
    'phonegap',
    'hybrid',
    'mobile',
    'cross-platform',
    'web-to-mobile',
    'ionic',
    'javascript',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/config.xml'
  - '**/cordova/**'
  - '**/platforms/**'
  - '**/plugins/**'
  - '**/www/**'
  - '**/hooks/**'
---

# Apache Cordova Mobile Development Framework Instructions

## Framework Overview

- **Framework Name**: Apache Cordova
- **Version**: 12.0+ (Latest stable with platform improvements and security updates)
- **Type**: Hybrid Mobile Framework
- **Language**: HTML, CSS, JavaScript, TypeScript
- **Use Cases**: Cross-platform mobile apps, web-to-mobile conversion, rapid prototyping, enterprise mobile solutions

## When to Use Cordova

### ✅ **Use Cordova When**

- Converting existing web applications to mobile apps quickly
- Team has strong web development skills but limited native mobile experience
- Need to support multiple platforms with single codebase
- Building content-focused apps that don't require intensive native performance
- Working with legacy web technologies that need mobile deployment
- Budget constraints require cost-effective cross-platform solution
- Enterprise apps requiring standard UI components and basic device integration
- Prototyping mobile concepts before committing to native development

### ❌ **Avoid Cordova When**

- Building performance-critical applications (games, AR/VR, heavy animations)
- Need advanced native UI components and platform-specific design patterns
- Requiring complex device integrations beyond basic plugin capabilities
- Target audience expects native app performance and responsiveness
- Working with real-time applications requiring low latency
- Team has strong native development expertise and resources
- App stores are rejecting hybrid apps in your category

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type        | Cordova Recommendation                      | Alternative Consideration   |
| ------------------- | ------------------------------------------- | --------------------------- |
| Content/News App    | ✅ **Recommended** - Web content works well | Consider PWA first          |
| Business/Enterprise | ✅ **Good Choice** - Forms and data entry   | React Native for better UX  |
| E-commerce          | 🔄 **Consider** - Performance important     | Native for complex checkout |
| Gaming              | ❌ **Avoid** - Performance critical         | Unity, native frameworks    |
| Social Media        | 🔄 **Consider** - UX expectations high      | React Native, Flutter       |
| Utility/Tools       | ✅ **Good Choice** - Simple functionality   | PWA might be sufficient     |

### Complexity Assessment

| Factor                       | Low Complexity        | Medium Complexity                | High Complexity                  |
| ---------------------------- | --------------------- | -------------------------------- | -------------------------------- |
| **Setup Time**               | 4 hours (basic app)   | 2 days (plugins + customization) | 1 week (complex integrations)    |
| **Platform Support**         | Android + iOS         | + Windows, Browser               | + Custom platforms               |
| **Plugin Dependencies**      | 0-3 basic plugins     | 4-8 plugins with customization   | 9+ plugins or custom development |
| **Performance Requirements** | Basic content display | Moderate interactivity           | High performance needs           |

## Installation & Setup

### Prerequisites

```bash
# Install Node.js (version 16+ recommended)
node --version  # Should be 16.0.0 or higher
npm --version   # Should be 8.0.0 or higher

# Install Java Development Kit (for Android)
java -version   # Should be JDK 8 or higher

# Install Android SDK (via Android Studio)
# Download and install Android Studio
# Configure ANDROID_HOME environment variable
export ANDROID_HOME=$HOME/Library/Android/sdk  # macOS
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Install Xcode (for iOS development on macOS)
xcode-select --install
```

### Global Cordova Installation

```bash
# Install Cordova CLI globally
npm install -g cordova

# Verify installation
cordova --version

# Check system requirements
cordova requirements

# Update Cordova to latest version
npm update -g cordova
```

### Project Initialization

```bash
# Create new Cordova project
cordova create myApp com.example.myapp "My App"
cd myApp

# Add platforms
cordova platform add android
cordova platform add ios
cordova platform add browser  # For browser testing

# List installed platforms
cordova platform list

# Check platform requirements
cordova requirements android
cordova requirements ios
```

## Project Structure

```
myApp/
├── config.xml              # Main configuration file
├── package.json            # Node.js dependencies
├── www/                    # Web application source
│   ├── index.html          # Main HTML entry point
│   ├── css/
│   │   └── index.css       # Application styles
│   ├── js/
│   │   └── index.js        # Application logic
│   └── img/                # Images and assets
├── platforms/              # Generated platform-specific code
│   ├── android/            # Android platform files
│   ├── ios/                # iOS platform files
│   └── browser/            # Browser platform files
├── plugins/                # Installed Cordova plugins
├── hooks/                  # Build hooks and scripts
│   ├── after_prepare/
│   └── before_build/
└── res/                    # Platform resources
    ├── icon/               # App icons
    └── screen/             # Splash screens
```

## Core Concepts

### Device Ready Event

- **Purpose**: Ensures Cordova APIs are loaded before use
- **Usage**: Critical initialization point for all Cordova applications
- **Example**:

```javascript
// Wait for device ready before using Cordova APIs
document.addEventListener('deviceready', onDeviceReady, false);

function onDeviceReady() {
  console.log('Cordova is ready!');

  // Safe to use Cordova APIs now
  console.log('Device: ' + device.platform);
  console.log('Version: ' + device.version);

  // Initialize your app here
  initializeApp();
}

function initializeApp() {
  // App initialization code
  setupEventHandlers();
  loadInitialData();
}
```

### Plugin System

- **Purpose**: Extends web apps with native device functionality
- **Usage**: Bridge between JavaScript and native mobile platform APIs
- **Example**:

```bash
# Install essential plugins
cordova plugin add cordova-plugin-device
cordova plugin add cordova-plugin-network-information
cordova plugin add cordova-plugin-camera
cordova plugin add cordova-plugin-file
cordova plugin add cordova-plugin-geolocation

# List installed plugins
cordova plugin list

# Remove plugin
cordova plugin remove cordova-plugin-camera
```

```javascript
// Using device plugin
document.addEventListener('deviceready', function () {
  console.log('Device Platform: ' + device.platform);
  console.log('Device Version: ' + device.version);
  console.log('Device Model: ' + device.model);
  console.log('Device UUID: ' + device.uuid);
});

// Using camera plugin
function takePicture() {
  const options = {
    quality: 75,
    destinationType: Camera.DestinationType.FILE_URI,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
    targetWidth: 300,
    targetHeight: 300,
  };

  navigator.camera.getPicture(onSuccess, onFail, options);
}

function onSuccess(imageURI) {
  const image = document.getElementById('myImage');
  image.src = imageURI;
}

function onFail(message) {
  alert('Failed to capture image: ' + message);
}
```

## Development Workflow

1. **Setup**: Initialize project and add target platforms
2. **Development**: Code in www/ directory using web technologies
3. **Testing**: Test in browser, then device emulators and real devices
4. **Building**: Compile platform-specific applications
5. **Deployment**: Distribute through app stores or enterprise channels

## Essential Commands

```bash
# Project management
cordova create <path> <id> <name>     # Create new project
cordova platform add <platform>       # Add platform
cordova platform remove <platform>    # Remove platform
cordova plugin add <plugin>           # Install plugin
cordova plugin remove <plugin>        # Remove plugin

# Development workflow
cordova prepare                       # Prepare project for building
cordova build                        # Build all platforms
cordova build android               # Build specific platform
cordova run android --device       # Run on device
cordova emulate ios                # Run in emulator

# Debugging and analysis
cordova requirements              # Check platform requirements
cordova info                     # Display project information
cordova plugin list              # List installed plugins
cordova platform list           # List installed platforms

# Advanced operations
cordova clean                    # Clean project
cordova build --release         # Release build
cordova run --list             # List available devices/emulators
```

## Best Practices

### ✅ **Performance Optimization**

- **Minimize DOM manipulation** - Cache DOM references and batch updates
- **Use CSS transforms** instead of changing layout properties for animations
- **Implement lazy loading** for images and content to improve initial load time
- **Optimize images** - Use appropriate formats and sizes for mobile screens
- **Use requestAnimationFrame** for smooth animations and transitions
- **Minimize plugin usage** - Only include plugins you actually need

### ✅ **Security Best Practices**

- **Content Security Policy** - Implement strict CSP headers
- **Validate all inputs** - Never trust data from device APIs or user input
- **Secure storage** - Use plugins for sensitive data storage
- **HTTPS only** - Always use secure connections for network requests
- **Plugin auditing** - Regularly audit and update plugins for security issues
- **Whitelist domains** - Restrict network access to known domains

### ❌ **Common Pitfalls to Avoid**

- **Don't access device APIs before deviceready** - Always wait for the event
- **Don't use synchronous operations** - Use callbacks and promises for async operations
- **Don't ignore platform differences** - Test thoroughly on each target platform
- **Don't create memory leaks** - Properly clean up event listeners and timers
- **Don't rely on browser-specific features** - Ensure cross-platform compatibility
- **Don't skip error handling** - Plugin operations can fail on different devices

## AI Agent Guidelines

When helping with Apache Cordova development:

1. **Always check deviceready first** - Ensure proper Cordova initialization
2. **Recommend modern alternatives** - Suggest Capacitor or native solutions when appropriate
3. **Focus on cross-platform compatibility** - Provide solutions that work on multiple platforms
4. **Include error handling** - Always wrap plugin calls in try-catch or promise chains
5. **Suggest performance optimizations** - Recommend best practices for hybrid app performance
6. **Security awareness** - Include CSP and secure storage recommendations
7. **Plugin ecosystem guidance** - Help select appropriate plugins and avoid deprecated ones
8. **Testing strategies** - Emphasize testing on real devices, not just emulators

### Code Generation Rules

- Generate code that waits for deviceready event before using Cordova APIs
- Include proper error handling for all plugin operations
- Provide cross-platform compatible solutions
- Follow modern JavaScript practices (ES6+, async/await, promises)
- Include fallbacks for when plugins are not available
- Generate responsive CSS that works on various screen sizes
- Include performance optimization techniques in generated code
- Follow Cordova's security best practices in all generated examples
