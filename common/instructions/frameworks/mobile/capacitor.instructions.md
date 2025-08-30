---
applyTo: 'capacitor, @capacitor'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Capacitor 5+ for native bridge functionality'
---

# Capacitor Framework Instructions for AI Agents

## When to Use Capacitor

Use Capacitor when you need:

- Native mobile app deployment from web applications
- Modern replacement for Apache Cordova/PhoneGap
- Progressive Web Apps (PWAs) with native capabilities
- Cross-platform development with web technologies
- Bridge between web app and native mobile features
- Existing web application that needs mobile deployment
- Live reload and debugging in native environment

## When to Avoid Capacitor

Consider alternatives when:

- Building native-first applications (use native frameworks)
- Need maximum native performance (consider React Native/Flutter)
- Working with complex native integrations requiring custom code
- Team has no web development experience
- App requires intensive graphics or gaming features
- Pure web application without mobile deployment needs

## Framework Overview

- **Framework**: Capacitor 5.x
- **Type**: Native bridge layer for web applications
- **Architecture**: Web-to-native runtime with plugin system
- **Language**: JavaScript/TypeScript with web frameworks
- **Use Cases**: Hybrid mobile apps, PWAs with native features, web-to-mobile conversion

## Installation & Setup

### ✅ Recommended: Add Capacitor to Existing Web App

```bash
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
```

### ✅ Alternative: Start with Capacitor Template

```bash
# Create new app with various frameworks
npm create @capacitor/app my-app
# or
ionic start my-app tabs --capacitor
# or
npx create-react-app my-app
cd my-app && npx cap init
```

### AI Agent Decision Tree

- **For existing web app**: Add Capacitor incrementally
- **For new project**: Start with web framework + Capacitor
- **For Ionic projects**: Capacitor is default (preferred over Cordova)
- **For React/Vue/Angular**: Add Capacitor after initial setup
- **For PWA enhancement**: Add native plugins as needed

## Project Structure

### ✅ Capacitor Project Structure

```
capacitor-app/
├── src/                      # Web application source
│   ├── components/
│   ├── pages/
│   ├── services/
│   └── index.html
├── public/                   # Static assets
├── dist/                     # Built web application
├── android/                  # Android platform
│   ├── app/
│   ├── gradle/
│   └── build.gradle
├── ios/                      # iOS platform
│   ├── App/
│   ├── App.xcodeproj/
│   └── Podfile
├── capacitor.config.ts       # Capacitor configuration
├── package.json
└── tsconfig.json
```

### ✅ Configuration File (capacitor.config.ts)

```typescript
import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.example.myapp',
  appName: 'My App',
  webDir: 'dist',
  server: {
    androidScheme: 'https',
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 2000,
      backgroundColor: '#ffffff',
      androidSplashResourceName: 'splash',
      showSpinner: false,
    },
    StatusBar: {
      style: 'dark',
    },
    PushNotifications: {
      presentationOptions: ['badge', 'sound', 'alert'],
    },
  },
  ios: {
    contentInset: 'automatic',
  },
  android: {
    buildOptions: {
      keystorePath: 'release.keystore',
      keystoreAlias: 'my-app',
    },
  },
};

export default config;
```

## Core Concepts

### Native Plugin System

✅ **Best Practice**: Using official Capacitor plugins

```typescript
// services/device.service.ts
import { Camera, CameraResultType, CameraSource } from '@capacitor/camera';
import { Geolocation, Position } from '@capacitor/geolocation';
import { Device, DeviceInfo } from '@capacitor/device';
import { Network, ConnectionStatus } from '@capacitor/network';
import { Toast } from '@capacitor/toast';

export class DeviceService {
  // Camera functionality
  async takePicture(): Promise<string | undefined> {
    try {
      const image = await Camera.getPhoto({
        quality: 90,
        allowEditing: false,
        resultType: CameraResultType.DataUrl,
        source: CameraSource.Camera,
      });

      return image.dataUrl;
    } catch (error) {
      console.error('Camera error:', error);
      await this.showToast('Failed to take picture');
      return undefined;
    }
  }

  async selectFromGallery(): Promise<string | undefined> {
    try {
      const image = await Camera.getPhoto({
        quality: 90,
        allowEditing: true,
        resultType: CameraResultType.DataUrl,
        source: CameraSource.Photos,
      });

      return image.dataUrl;
    } catch (error) {
      console.error('Gallery error:', error);
      await this.showToast('Failed to select image');
      return undefined;
    }
  }

  // Geolocation
  async getCurrentPosition(): Promise<Position | null> {
    try {
      const coordinates = await Geolocation.getCurrentPosition({
        enableHighAccuracy: true,
        timeout: 10000,
      });

      return coordinates;
    } catch (error) {
      console.error('Geolocation error:', error);
      await this.showToast('Failed to get location');
      return null;
    }
  }

  // Network status
  async getNetworkStatus(): Promise<ConnectionStatus> {
    return await Network.getStatus();
  }

  startNetworkListener(callback: (status: ConnectionStatus) => void) {
    Network.addListener('networkStatusChange', callback);
  }

  // Helper methods
  private async showToast(message: string) {
    await Toast.show({
      text: message,
      duration: 'short',
      position: 'bottom',
    });
  }
}
```

### Local Storage and Preferences

✅ **Best Practice**: Secure data storage with Capacitor

```typescript
// services/storage.service.ts
import { Preferences } from '@capacitor/preferences';
import { Filesystem, Directory, Encoding } from '@capacitor/filesystem';

export class StorageService {
  // Simple key-value storage
  async setItem(key: string, value: any): Promise<void> {
    try {
      await Preferences.set({
        key,
        value: JSON.stringify(value),
      });
    } catch (error) {
      console.error('Storage set error:', error);
      throw new Error('Failed to store data');
    }
  }

  async getItem<T>(key: string): Promise<T | null> {
    try {
      const { value } = await Preferences.get({ key });
      return value ? JSON.parse(value) : null;
    } catch (error) {
      console.error('Storage get error:', error);
      return null;
    }
  }

  async removeItem(key: string): Promise<void> {
    try {
      await Preferences.remove({ key });
    } catch (error) {
      console.error('Storage remove error:', error);
      throw new Error('Failed to remove data');
    }
  }

  // File system operations
  async writeFile(fileName: string, data: string): Promise<string> {
    try {
      const result = await Filesystem.writeFile({
        path: fileName,
        data,
        directory: Directory.Documents,
        encoding: Encoding.UTF8,
      });

      return result.uri;
    } catch (error) {
      console.error('File write error:', error);
      throw new Error('Failed to write file');
    }
  }

  async readFile(fileName: string): Promise<string> {
    try {
      const result = await Filesystem.readFile({
        path: fileName,
        directory: Directory.Documents,
        encoding: Encoding.UTF8,
      });

      return result.data as string;
    } catch (error) {
      console.error('File read error:', error);
      throw new Error('Failed to read file');
    }
  }
}
```

### Push Notifications

✅ **Best Practice**: Implementing push notifications

```typescript
// services/push-notification.service.ts
import {
  PushNotifications,
  PushNotificationSchema,
  Token,
  ActionPerformed,
} from '@capacitor/push-notifications';
import { Capacitor } from '@capacitor/core';

export class PushNotificationService {
  async initializePushNotifications(): Promise<void> {
    if (!Capacitor.isNativePlatform()) {
      console.warn('Push notifications not available on web platform');
      return;
    }

    // Request permission
    const permission = await PushNotifications.requestPermissions();

    if (permission.receive === 'granted') {
      await this.registerForPushNotifications();
      this.setupEventListeners();
    } else {
      console.warn('Push notification permission denied');
    }
  }

  private async registerForPushNotifications(): Promise<void> {
    try {
      await PushNotifications.register();
    } catch (error) {
      console.error('Failed to register for push notifications:', error);
    }
  }

  private setupEventListeners(): void {
    // Registration success
    PushNotifications.addListener('registration', (token: Token) => {
      console.log('Push registration success, token:', token.value);
      this.sendTokenToServer(token.value);
    });

    // Registration error
    PushNotifications.addListener('registrationError', (error: any) => {
      console.error('Push registration error:', error);
    });

    // Notification received (app in foreground)
    PushNotifications.addListener(
      'pushNotificationReceived',
      (notification: PushNotificationSchema) => {
        console.log('Push notification received:', notification);
        this.handleForegroundNotification(notification);
      },
    );

    // Notification action (app opened from notification)
    PushNotifications.addListener(
      'pushNotificationActionPerformed',
      (notification: ActionPerformed) => {
        console.log('Push notification action performed:', notification);
        this.handleNotificationAction(notification);
      },
    );
  }

  private async sendTokenToServer(token: string): Promise<void> {
    try {
      // Send token to your backend server
      const response = await fetch('/api/push-token', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ token }),
      });

      if (!response.ok) {
        throw new Error('Failed to send token to server');
      }
    } catch (error) {
      console.error('Error sending token to server:', error);
    }
  }

  private handleForegroundNotification(notification: PushNotificationSchema): void {
    console.log('Handling foreground notification:', notification.title);
  }

  private handleNotificationAction(notification: ActionPerformed): void {
    const data = notification.notification.data;

    if (data?.route) {
      this.navigateToRoute(data.route, data.params);
    }
  }

  private navigateToRoute(route: string, params?: any): void {
    console.log('Navigating to:', route, params);
  }
}
```

## Best Practices

### ✅ Do's

- Use official Capacitor plugins whenever possible
- Test thoroughly on actual devices, not just simulators
- Handle network connectivity changes gracefully
- Implement proper error handling for all native operations
- Use TypeScript for better development experience
- Follow platform-specific UI guidelines and patterns
- Optimize for both iOS and Android platform differences
- Implement proper app lifecycle management

### ❌ Don'ts

- Don't rely solely on web browser testing for native features
- Don't ignore platform-specific permissions and security models
- Don't forget to handle offline scenarios appropriately
- Don't mix Capacitor with Cordova plugins (use migration guide)
- Don't ignore memory management in long-running background tasks
- Don't hardcode platform-specific values in shared code
- Don't skip testing on different device sizes and OS versions
- Don't ignore app store guidelines and requirements

### Performance Optimization

```typescript
// Image optimization and caching
import { CapacitorHttp } from '@capacitor/core';

class ImageService {
  private imageCache = new Map<string, string>();

  async loadOptimizedImage(url: string, maxWidth = 800): Promise<string> {
    if (this.imageCache.has(url)) {
      return this.imageCache.get(url)!;
    }

    try {
      const response = await CapacitorHttp.get({
        url: url,
        responseType: 'blob',
      });

      // Create optimized image
      const optimizedBlob = await this.resizeImage(response.data, maxWidth);
      const dataUrl = await this.blobToDataUrl(optimizedBlob);

      this.imageCache.set(url, dataUrl);
      return dataUrl;
    } catch (error) {
      console.error('Failed to load image:', error);
      throw error;
    }
  }

  private async resizeImage(blob: Blob, maxWidth: number): Promise<Blob> {
    return new Promise((resolve) => {
      const canvas = document.createElement('canvas');
      const ctx = canvas.getContext('2d')!;
      const img = new Image();

      img.onload = () => {
        const ratio = Math.min(maxWidth / img.width, maxWidth / img.height);
        canvas.width = img.width * ratio;
        canvas.height = img.height * ratio;

        ctx.drawImage(img, 0, 0, canvas.width, canvas.height);
        canvas.toBlob(resolve as BlobCallback, 'image/jpeg', 0.8);
      };

      img.src = URL.createObjectURL(blob);
    });
  }

  private blobToDataUrl(blob: Blob): Promise<string> {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onload = () => resolve(reader.result as string);
      reader.onerror = reject;
      reader.readAsDataURL(blob);
    });
  }
}
```

## Development Workflow

### ✅ Recommended Development Process

```bash
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
```

### AI Agent Decision Matrix

| Scenario                    | Recommended Approach           | Avoid                        |
| --------------------------- | ------------------------------ | ---------------------------- |
| Existing web app            | Add Capacitor incrementally    | Complete rewrite             |
| New mobile project          | Web framework + Capacitor      | Native-only development      |
| Native performance critical | Consider native alternatives   | Heavy web frameworks         |
| Cross-platform requirement  | Capacitor with shared codebase | Separate native apps         |
| Web + mobile deployment     | PWA with Capacitor enhancement | Separate web and mobile apps |
| Plugin needed               | Official Capacitor plugins     | Custom native code initially |
| Team web-focused            | Leverage existing web skills   | Learning native development  |
| Rapid prototyping           | Capacitor with web frameworks  | Complex native setup         |

## Testing

### ✅ Unit Testing Native Features

```typescript
// tests/device.service.test.ts
import { DeviceService } from '../src/services/device.service';
import { Camera } from '@capacitor/camera';
import { Geolocation } from '@capacitor/geolocation';

// Mock Capacitor plugins
jest.mock('@capacitor/camera');
jest.mock('@capacitor/geolocation');

describe('DeviceService', () => {
  let service: DeviceService;
  let mockCamera: jest.Mocked<typeof Camera>;
  let mockGeolocation: jest.Mocked<typeof Geolocation>;

  beforeEach(() => {
    service = new DeviceService();
    mockCamera = Camera as jest.Mocked<typeof Camera>;
    mockGeolocation = Geolocation as jest.Mocked<typeof Geolocation>;
  });

  describe('takePicture', () => {
    it('should return image data URL on success', async () => {
      const mockImageData = 'data:image/jpeg;base64,/9j/4AAQ...';
      mockCamera.getPhoto.mockResolvedValue({
        dataUrl: mockImageData,
        format: 'jpeg',
        saved: false,
      });

      const result = await service.takePicture();

      expect(result).toBe(mockImageData);
      expect(mockCamera.getPhoto).toHaveBeenCalledWith({
        quality: 90,
        allowEditing: false,
        resultType: 'dataUrl',
        source: 'camera',
      });
    });

    it('should handle camera errors gracefully', async () => {
      mockCamera.getPhoto.mockRejectedValue(new Error('Camera not available'));

      const result = await service.takePicture();

      expect(result).toBeUndefined();
    });
  });
});
```

## Security Considerations

- Validate all data received from native plugins before processing
- Use secure storage (Preferences with encryption) for sensitive data
- Implement certificate pinning for critical API communications
- Follow platform security guidelines (iOS App Transport Security, Android Network Security Config)
- Use proper authentication and session management
- Implement biometric authentication where appropriate
- Validate file uploads and downloads from device storage
- Use HTTPS for all network communications
- Implement proper error handling that doesn't leak sensitive information

## Error Handling and Debugging

```typescript
// utils/error-handler.ts
import { Toast } from '@capacitor/toast';
import { Capacitor } from '@capacitor/core';

export class ErrorHandler {
  static async handleNativeError(error: any, context: string): Promise<void> {
    console.error(`Native error in ${context}:`, error);

    let userMessage = 'An unexpected error occurred';

    // Platform-specific error handling
    if (Capacitor.getPlatform() === 'ios') {
      if (error.code === 'NSURLErrorNotConnectedToInternet') {
        userMessage = 'No internet connection available';
      } else if (error.code === 'AVErrorApplicationIsNotAuthorized') {
        userMessage = 'Camera access denied. Please enable in Settings.';
      }
    } else if (Capacitor.getPlatform() === 'android') {
      if (error.message?.includes('PERMISSION_DENIED')) {
        userMessage = 'Permission denied. Please enable in app settings.';
      } else if (error.message?.includes('NetworkError')) {
        userMessage = 'Network error. Please check your connection.';
      }
    }

    // Show user-friendly error message
    if (Capacitor.isNativePlatform()) {
      await Toast.show({
        text: userMessage,
        duration: 'long',
        position: 'bottom',
      });
    } else {
      // Fallback for web
      alert(userMessage);
    }
  }

  static async handlePermissionError(plugin: string): Promise<void> {
    const message = `${plugin} access denied. Please enable permissions in your device settings.`;

    if (Capacitor.isNativePlatform()) {
      await Toast.show({
        text: message,
        duration: 'long',
        position: 'center',
      });
    } else {
      console.warn(message);
    }
  }
}
```

## AI Agent Quick Reference

- **Project Setup**: Add Capacitor to existing web app or start with template
- **Configuration**: Configure capacitor.config.ts for platform-specific settings
- **Plugin Integration**: Use official plugins with proper TypeScript types
- **Development**: Use live reload for rapid development and testing
- **Testing**: Mock native plugins for unit tests, use actual devices for integration testing
- **Performance**: Implement lazy loading, image optimization, and proper caching
- **Security**: Use secure storage, validate inputs, follow platform guidelines
- **Deployment**: Build and test on actual devices before app store submission
