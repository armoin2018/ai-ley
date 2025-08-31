---
applyTo: 'neutralino, neutralinojs, neu'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Neutralino 4.0+ for lightweight web-based desktop applications'
---

# Neutralino Framework Instructions for AI Agents

## When to Use Neutralino

Use Neutralino when you need:

- Lightweight desktop applications with minimal resource usage (alternative to Electron)
- Web-based desktop apps with native system access
- Small application bundle sizes (3-15MB vs 100MB+ for Electron)
- Cross-platform desktop apps using web technologies
- Applications requiring basic file system and OS integration
- Quick conversion of web applications to desktop format
- Desktop apps with minimal security requirements and trusted environments
- Applications targeting resource-constrained environments

## When to Avoid Neutralino

Consider alternatives when:

- Need extensive native system integration and hardware access
- Require complex security models with sandboxing
- Building applications with heavy native dependencies
- Need mature ecosystem with extensive plugin support (use Electron)
- Require offline functionality with complex local data processing
- Working with applications requiring real-time performance
- Building enterprise applications with strict security requirements

## Framework Overview

- **Framework**: Neutralino 4.0+
- **Type**: Lightweight web-based desktop application framework
- **Languages**: JavaScript/TypeScript (frontend), Any language (backend via extensions)
- **Runtime**: Custom lightweight runtime (not Chromium)
- **Use Cases**: Lightweight desktop apps, system utilities, web app conversion, prototyping

## Installation & Setup

### ✅ Recommended: Neutralino CLI with Modern Frontend

```bash
# Install Neutralino CLI
npm install -g @neutralinojs/neu

# Verify installation
neu --version

# Create new application with template
neu create myapp --template vanilla
# or with specific frontend framework
neu create myapp --template react
neu create myapp --template vue
neu create myapp --template svelte

cd myapp

# Install dependencies
npm install

# Start development server
neu run

# Alternative: Create from scratch
mkdir neutralino-app && cd neutralino-app
neu init

# Install frontend dependencies (if using a framework)
npm install react react-dom  # for React
npm install vue@next         # for Vue 3
npm install svelte           # for Svelte
```

### ✅ Alternative: Add Neutralino to Existing Web App

```bash
# Navigate to existing web application
cd my-existing-webapp

# Initialize Neutralino
neu init

# Configure neutralino.config.json for your app
# Update build scripts in package.json

# Build frontend first, then Neutralino
npm run build
neu build
```

### ✅ Manual Setup for Custom Configuration

```bash
# Create project structure
mkdir custom-neutralino-app && cd custom-neutralino-app

# Download Neutralino binaries
neu init --template minimal

# Set up custom frontend build process
mkdir src public
touch src/index.html src/main.js src/style.css

# Configure build tools (webpack, vite, parcel, etc.)
npm init -y
npm install --save-dev vite
```

### AI Agent Decision Tree

- **For simple apps**: Use vanilla template for minimal overhead
- **For modern UI**: Use React/Vue/Svelte templates for component-based development
- **For existing web apps**: Initialize Neutralino in existing project
- **For system utilities**: Use minimal template with direct OS API access
- **For prototyping**: Use Neutralino for rapid desktop app conversion

## Project Structure

### ✅ Standard Neutralino Project Structure

```
neutralino-app/
├── neutralino.config.json   # Neutralino configuration
├── package.json            # Frontend dependencies
├── .neutralino.lock        # Lock file for Neutralino
├── resources/              # Application resources
│   ├── index.html          # Main HTML file
│   ├── js/
│   │   ├── main.js         # Main JavaScript
│   │   └── neutralino.js   # Neutralino client API
│   ├── css/
│   │   └── styles.css      # Application styles
│   └── icons/              # Application icons
├── extensions/             # Native extensions (optional)
│   ├── example/
│   │   ├── extension.js
│   │   └── package.json
│   └── system/
├── bin/                    # Compiled binaries
├── dist/                   # Built application
├── src/                    # Source code (if using build tools)
│   ├── components/
│   ├── services/
│   ├── utils/
│   └── assets/
├── scripts/                # Build and deployment scripts
└── docs/                   # Documentation
```

### ✅ React-based Neutralino Project

```
neutralino-react-app/
├── neutralino.config.json
├── package.json
├── webpack.config.js       # or vite.config.js
├── public/
│   ├── index.html
│   └── icons/
├── src/                    # React application
│   ├── components/
│   │   ├── App.jsx
│   │   ├── FileManager.jsx
│   │   ├── SystemInfo.jsx
│   │   └── Settings.jsx
│   ├── services/
│   │   ├── neutralino-api.js
│   │   ├── file-service.js
│   │   └── system-service.js
│   ├── hooks/
│   │   ├── useSystemInfo.js
│   │   └── useFileSystem.js
│   ├── utils/
│   │   ├── helpers.js
│   │   └── constants.js
│   ├── styles/
│   │   ├── global.css
│   │   └── components.css
│   ├── index.js
│   └── main.jsx
├── resources/              # Built application files
├── extensions/             # Native extensions
└── dist/                   # Final distribution
```

### ✅ Extension-based Architecture

```
neutralino-extended-app/
├── neutralino.config.json
├── app/                    # Main application
│   ├── index.html
│   ├── js/
│   └── css/
├── extensions/             # Backend extensions
│   ├── file-processor/     # File processing extension
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── extension.json
│   ├── database/           # Database extension
│   │   ├── db.js
│   │   ├── package.json
│   │   └── extension.json
│   └── system-monitor/     # System monitoring
│       ├── monitor.cpp
│       ├── CMakeLists.txt
│       └── extension.json
├── shared/                 # Shared utilities
├── tests/                  # Testing
└── scripts/                # Build scripts
```

## Core Concepts

### Neutralino Configuration

✅ **Best Practice**: Comprehensive configuration for production applications

```json
// neutralino.config.json - Main Configuration File
{
  "applicationId": "com.example.myapp",
  "version": "1.0.0",
  "defaultMode": "window",
  "port": 0,
  "documentRoot": "/resources/",
  "url": "/",
  "enableServer": true,
  "enableNativeAPI": true,
  "tokenSecurity": "one-time",
  "logging": {
    "enabled": true,
    "writeToLogFile": true,
    "logLevel": "INFO"
  },
  "nativeAllowList": [
    "app.*",
    "os.*",
    "filesystem.*",
    "computer.*",
    "storage.*",
    "debug.*",
    "window.*",
    "events.*",
    "clipboard.*",
    "updater.*",
    "custom.*"
  ],
  "globalVariables": {
    "TEST_MODE": "false",
    "APP_VERSION": "1.0.0"
  },
  "modes": {
    "window": {
      "title": "My Neutralino App",
      "width": 1200,
      "height": 800,
      "minWidth": 800,
      "minHeight": 600,
      "maxWidth": 1920,
      "maxHeight": 1080,
      "resizable": true,
      "maximizable": true,
      "hidden": false,
      "exitProcessOnClose": true,
      "icon": "/resources/icons/appIcon.png",
      "enableInspector": false,
      "borderless": false,
      "alwaysOnTop": false,
      "acceptFirstMouse": false,
      "transparent": false,
      "useSavedState": true
    },
    "browser": {
      "globalVariables": {
        "TEST_MODE": "true"
      },
      "nativeBlockList": ["filesystem.*", "os.*"]
    },
    "cloud": {
      "url": "https://cdn.neutralino.js.org/",
      "nativeAllowList": []
    }
  },
  "cli": {
    "binaryName": "myapp",
    "resourcesPath": "/resources/",
    "extensionsPath": "/extensions/",
    "clientLibrary": "/resources/js/neutralino.js",
    "binaryVersion": "4.14.1",
    "clientVersion": "3.12.0"
  },
  "buildScript": {
    "mac": {
      "binaryName": "myapp",
      "bundleId": "com.example.myapp"
    },
    "windows": {
      "binaryName": "myapp.exe",
      "icon": "/resources/icons/appIcon.ico"
    },
    "linux": {
      "binaryName": "myapp"
    }
  }
}
```

### Neutralino Client API Integration

✅ **Best Practice**: Type-safe Neutralino API wrapper with error handling

```javascript
// src/services/neutralino-api.js - API Wrapper Service
class NeutralinoAPI {
  constructor() {
    this.isReady = false;
    this.initPromise = this.initialize();
  }

  async initialize() {
    try {
      await Neutralino.init();
      await this.setupEventListeners();
      this.isReady = true;
      console.log('Neutralino API initialized successfully');
    } catch (error) {
      console.error('Failed to initialize Neutralino API:', error);
      throw error;
    }
  }

  async setupEventListeners() {
    // Window events
    Neutralino.events.on('windowClose', () => {
      this.handleWindowClose();
    });

    // App events
    Neutralino.events.on('ready', () => {
      console.log('Neutralino app is ready');
    });

    // File system events
    Neutralino.events.on('watchFile', (evt) => {
      this.handleFileSystemChange(evt);
    });
  }

  async ensureReady() {
    if (!this.isReady) {
      await this.initPromise;
    }
  }

  // File System Operations
  async readFile(path) {
    await this.ensureReady();
    try {
      const content = await Neutralino.filesystem.readFile(path);
      return { success: true, data: content };
    } catch (error) {
      console.error('Failed to read file:', error);
      return { success: false, error: error.message };
    }
  }

  async writeFile(path, content) {
    await this.ensureReady();
    try {
      await Neutralino.filesystem.writeFile(path, content);
      return { success: true };
    } catch (error) {
      console.error('Failed to write file:', error);
      return { success: false, error: error.message };
    }
  }

  async createDirectory(path) {
    await this.ensureReady();
    try {
      await Neutralino.filesystem.createDirectory(path);
      return { success: true };
    } catch (error) {
      console.error('Failed to create directory:', error);
      return { success: false, error: error.message };
    }
  }

  async readDirectory(path) {
    await this.ensureReady();
    try {
      const entries = await Neutralino.filesystem.readDirectory(path);
      return { success: true, data: entries };
    } catch (error) {
      console.error('Failed to read directory:', error);
      return { success: false, error: error.message };
    }
  }

  async removeFile(path) {
    await this.ensureReady();
    try {
      await Neutralino.filesystem.removeFile(path);
      return { success: true };
    } catch (error) {
      console.error('Failed to remove file:', error);
      return { success: false, error: error.message };
    }
  }

  async watchFile(path, callback) {
    await this.ensureReady();
    try {
      await Neutralino.filesystem.watchFile(path);
      this.fileWatchCallbacks = this.fileWatchCallbacks || {};
      this.fileWatchCallbacks[path] = callback;
      return { success: true };
    } catch (error) {
      console.error('Failed to watch file:', error);
      return { success: false, error: error.message };
    }
  }

  // System Information
  async getSystemInfo() {
    await this.ensureReady();
    try {
      const [osInfo, envInfo, computerInfo] = await Promise.all([
        Neutralino.os.getEnv(),
        Neutralino.computer.getMemoryInfo(),
        Neutralino.computer.getArch(),
      ]);

      return {
        success: true,
        data: {
          os: osInfo,
          memory: envInfo,
          architecture: computerInfo,
        },
      };
    } catch (error) {
      console.error('Failed to get system info:', error);
      return { success: false, error: error.message };
    }
  }

  async executeCommand(command, options = {}) {
    await this.ensureReady();
    try {
      const result = await Neutralino.os.execCommand(command, options);
      return { success: true, data: result };
    } catch (error) {
      console.error('Failed to execute command:', error);
      return { success: false, error: error.message };
    }
  }

  // Window Management
  async setWindowTitle(title) {
    await this.ensureReady();
    try {
      await Neutralino.window.setTitle(title);
      return { success: true };
    } catch (error) {
      console.error('Failed to set window title:', error);
      return { success: false, error: error.message };
    }
  }

  async getWindowSize() {
    await this.ensureReady();
    try {
      const size = await Neutralino.window.getSize();
      return { success: true, data: size };
    } catch (error) {
      console.error('Failed to get window size:', error);
      return { success: false, error: error.message };
    }
  }

  async setWindowSize(width, height) {
    await this.ensureReady();
    try {
      await Neutralino.window.setSize({ width, height });
      return { success: true };
    } catch (error) {
      console.error('Failed to set window size:', error);
      return { success: false, error: error.message };
    }
  }

  async minimizeWindow() {
    await this.ensureReady();
    try {
      await Neutralino.window.minimize();
      return { success: true };
    } catch (error) {
      console.error('Failed to minimize window:', error);
      return { success: false, error: error.message };
    }
  }

  async maximizeWindow() {
    await this.ensureReady();
    try {
      await Neutralino.window.maximize();
      return { success: true };
    } catch (error) {
      console.error('Failed to maximize window:', error);
      return { success: false, error: error.message };
    }
  }

  // Storage Operations
  async setStorageData(key, value) {
    await this.ensureReady();
    try {
      await Neutralino.storage.setData(key, JSON.stringify(value));
      return { success: true };
    } catch (error) {
      console.error('Failed to set storage data:', error);
      return { success: false, error: error.message };
    }
  }

  async getStorageData(key) {
    await this.ensureReady();
    try {
      const data = await Neutralino.storage.getData(key);
      return { success: true, data: JSON.parse(data) };
    } catch (error) {
      console.error('Failed to get storage data:', error);
      return { success: false, error: error.message };
    }
  }

  // Clipboard Operations
  async writeToClipboard(text) {
    await this.ensureReady();
    try {
      await Neutralino.clipboard.writeText(text);
      return { success: true };
    } catch (error) {
      console.error('Failed to write to clipboard:', error);
      return { success: false, error: error.message };
    }
  }

  async readFromClipboard() {
    await this.ensureReady();
    try {
      const text = await Neutralino.clipboard.readText();
      return { success: true, data: text };
    } catch (error) {
      console.error('Failed to read from clipboard:', error);
      return { success: false, error: error.message };
    }
  }

  // Event Handlers
  handleWindowClose() {
    console.log('Window close requested');
    // Perform cleanup or show confirmation dialog
    Neutralino.app.exit(0);
  }

  handleFileSystemChange(event) {
    console.log('File system change detected:', event);
    if (this.fileWatchCallbacks && this.fileWatchCallbacks[event.path]) {
      this.fileWatchCallbacks[event.path](event);
    }
  }

  // Utility Methods
  async showMessageBox(title, content, choice = 'OK') {
    await this.ensureReady();
    try {
      const result = await Neutralino.os.showMessageBox(title, content, choice);
      return { success: true, data: result };
    } catch (error) {
      console.error('Failed to show message box:', error);
      return { success: false, error: error.message };
    }
  }

  async openUrl(url) {
    await this.ensureReady();
    try {
      await Neutralino.os.open(url);
      return { success: true };
    } catch (error) {
      console.error('Failed to open URL:', error);
      return { success: false, error: error.message };
    }
  }

  async getPath(name) {
    await this.ensureReady();
    try {
      const path = await Neutralino.os.getPath(name);
      return { success: true, data: path };
    } catch (error) {
      console.error('Failed to get path:', error);
      return { success: false, error: error.message };
    }
  }
}

// Export singleton instance
export const neutralinoAPI = new NeutralinoAPI();
export default neutralinoAPI;
```

### React Component with Neutralino Integration

✅ **Best Practice**: React components using Neutralino APIs with hooks

```jsx
// src/components/FileManager.jsx - File Management Component
import React, { useState, useEffect, useCallback } from 'react';
import { neutralinoAPI } from '../services/neutralino-api';

const FileManager = () => {
  const [currentPath, setCurrentPath] = useState('');
  const [files, setFiles] = useState([]);
  const [selectedFile, setSelectedFile] = useState(null);
  const [fileContent, setFileContent] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  // Initialize with user's documents folder
  useEffect(() => {
    const initializeFileManager = async () => {
      setLoading(true);
      try {
        const pathResult = await neutralinoAPI.getPath('documents');
        if (pathResult.success) {
          setCurrentPath(pathResult.data);
          await loadDirectory(pathResult.data);
        } else {
          setError('Failed to get documents path');
        }
      } catch (err) {
        setError('Failed to initialize file manager');
      } finally {
        setLoading(false);
      }
    };

    initializeFileManager();
  }, []);

  const loadDirectory = useCallback(async (path) => {
    setLoading(true);
    setError(null);

    try {
      const result = await neutralinoAPI.readDirectory(path);
      if (result.success) {
        setFiles(result.data);
        setCurrentPath(path);
      } else {
        setError(`Failed to load directory: ${result.error}`);
      }
    } catch (err) {
      setError('Error loading directory');
    } finally {
      setLoading(false);
    }
  }, []);

  const handleFileSelect = async (file) => {
    if (file.type === 'FILE') {
      setSelectedFile(file);

      // Try to read file content if it's a text file
      const filePath = `${currentPath}/${file.entry}`;
      const result = await neutralinoAPI.readFile(filePath);

      if (result.success) {
        setFileContent(result.data);
      } else {
        setFileContent('Cannot read file content');
      }
    } else if (file.type === 'DIRECTORY') {
      const newPath = `${currentPath}/${file.entry}`;
      await loadDirectory(newPath);
    }
  };

  const handleGoUp = () => {
    const parentPath = currentPath.split('/').slice(0, -1).join('/');
    if (parentPath) {
      loadDirectory(parentPath);
    }
  };

  const handleCreateFile = async () => {
    const fileName = prompt('Enter file name:');
    if (fileName) {
      const filePath = `${currentPath}/${fileName}`;
      const result = await neutralinoAPI.writeFile(filePath, '');

      if (result.success) {
        await loadDirectory(currentPath); // Refresh directory
      } else {
        setError(`Failed to create file: ${result.error}`);
      }
    }
  };

  const handleCreateFolder = async () => {
    const folderName = prompt('Enter folder name:');
    if (folderName) {
      const folderPath = `${currentPath}/${folderName}`;
      const result = await neutralinoAPI.createDirectory(folderPath);

      if (result.success) {
        await loadDirectory(currentPath); // Refresh directory
      } else {
        setError(`Failed to create folder: ${result.error}`);
      }
    }
  };

  const handleDeleteFile = async (file) => {
    if (confirm(`Delete ${file.entry}?`)) {
      const filePath = `${currentPath}/${file.entry}`;
      const result = await neutralinoAPI.removeFile(filePath);

      if (result.success) {
        await loadDirectory(currentPath); // Refresh directory
        if (selectedFile && selectedFile.entry === file.entry) {
          setSelectedFile(null);
          setFileContent('');
        }
      } else {
        setError(`Failed to delete file: ${result.error}`);
      }
    }
  };

  const handleSaveFile = async () => {
    if (selectedFile) {
      const filePath = `${currentPath}/${selectedFile.entry}`;
      const result = await neutralinoAPI.writeFile(filePath, fileContent);

      if (result.success) {
        alert('File saved successfully!');
      } else {
        setError(`Failed to save file: ${result.error}`);
      }
    }
  };

  if (loading && files.length === 0) {
    return <div className="loading">Loading file manager...</div>;
  }

  return (
    <div className="file-manager">
      <div className="toolbar">
        <button onClick={handleGoUp} disabled={!currentPath}>
          ↑ Up
        </button>
        <span className="current-path">{currentPath}</span>
        <div className="actions">
          <button onClick={handleCreateFile}>New File</button>
          <button onClick={handleCreateFolder}>New Folder</button>
        </div>
      </div>

      {error && <div className="error">{error}</div>}

      <div className="file-manager-content">
        <div className="file-list">
          <h3>Files and Folders</h3>
          {loading && <div className="loading">Loading...</div>}
          <ul>
            {files.map((file, index) => (
              <li
                key={index}
                className={`file-item ${file.type.toLowerCase()} ${
                  selectedFile && selectedFile.entry === file.entry ? 'selected' : ''
                }`}
                onClick={() => handleFileSelect(file)}
              >
                <span className="file-icon">{file.type === 'DIRECTORY' ? '📁' : '📄'}</span>
                <span className="file-name">{file.entry}</span>
                <span className="file-type">{file.type}</span>
                {file.type === 'FILE' && (
                  <button
                    className="delete-btn"
                    onClick={(e) => {
                      e.stopPropagation();
                      handleDeleteFile(file);
                    }}
                  >
                    🗑️
                  </button>
                )}
              </li>
            ))}
          </ul>
        </div>

        {selectedFile && selectedFile.type === 'FILE' && (
          <div className="file-editor">
            <h3>
              Editing: {selectedFile.entry}
              <button onClick={handleSaveFile} className="save-btn">
                Save
              </button>
            </h3>
            <textarea
              value={fileContent}
              onChange={(e) => setFileContent(e.target.value)}
              className="file-content-editor"
              rows={20}
              cols={80}
            />
          </div>
        )}
      </div>
    </div>
  );
};

export default FileManager;
```

## Best Practices

### ✅ Do's

- Use the official Neutralino CLI for project management and building
- Implement proper error handling for all Neutralino API calls
- Use modern JavaScript/TypeScript with async/await patterns
- Leverage web technologies and frameworks for UI development
- Implement proper security measures despite Neutralino's lightweight nature
- Use extensions for complex native functionality that requires system access
- Follow web development best practices for performance and maintainability
- Test applications across different operating systems

### ❌ Don'ts

- Don't rely on Neutralino for applications requiring extensive native functionality
- Don't ignore security implications of the native API access
- Don't use Neutralino for performance-critical applications requiring heavy computation
- Don't expect the same level of ecosystem support as Electron
- Don't forget to configure proper native API allowlists
- Don't use outdated Neutralino versions - always use latest stable
- Don't hardcode file paths - use Neutralino's path API
- Don't forget to handle platform-specific differences

### Performance and Resource Management

```javascript
// Example of efficient resource management in Neutralino
class ResourceManager {
  constructor() {
    this.watchedFiles = new Map();
    this.cachedData = new Map();
    this.cleanup = this.cleanup.bind(this);

    // Register cleanup on window close
    window.addEventListener('beforeunload', this.cleanup);
  }

  async watchFile(path, callback) {
    if (!this.watchedFiles.has(path)) {
      try {
        await Neutralino.filesystem.watchFile(path);
        this.watchedFiles.set(path, new Set());
      } catch (error) {
        console.error('Failed to watch file:', error);
        return false;
      }
    }

    this.watchedFiles.get(path).add(callback);
    return true;
  }

  unwatchFile(path, callback) {
    if (this.watchedFiles.has(path)) {
      const callbacks = this.watchedFiles.get(path);
      callbacks.delete(callback);

      if (callbacks.size === 0) {
        this.watchedFiles.delete(path);
        // Neutralino doesn't have unwatchFile, so we keep watching
        // but clear our callbacks
      }
    }
  }

  async cacheData(key, fetchFunction, ttl = 60000) {
    const cached = this.cachedData.get(key);
    const now = Date.now();

    if (cached && now - cached.timestamp < ttl) {
      return cached.data;
    }

    try {
      const data = await fetchFunction();
      this.cachedData.set(key, {
        data,
        timestamp: now,
      });
      return data;
    } catch (error) {
      console.error('Failed to fetch data:', error);
      return cached ? cached.data : null;
    }
  }

  clearCache() {
    this.cachedData.clear();
  }

  cleanup() {
    console.log('Cleaning up resources...');
    this.watchedFiles.clear();
    this.cachedData.clear();
  }
}

// Usage
const resourceManager = new ResourceManager();

// Watch file with automatic cleanup
resourceManager.watchFile('/path/to/file.txt', (event) => {
  console.log('File changed:', event);
});

// Cache expensive operations
const systemInfo = await resourceManager.cacheData(
  'systemInfo',
  () => Neutralino.computer.getMemoryInfo(),
  30000, // Cache for 30 seconds
);
```

## Development Workflow

### ✅ Recommended Development Process

```bash
# Development workflow
neu run                      # Start development server
neu run --frontend-lib-dev   # Start with frontend dev server

# Building
neu build                    # Build for current platform
neu build --release          # Build optimized release

# Cross-platform building
neu build --target linux     # Build for Linux
neu build --target windows   # Build for Windows
neu build --target mac       # Build for macOS

# Testing
npm test                     # Run frontend tests
neu run --mode=browser       # Test in browser mode

# Frontend build integration
npm run build               # Build frontend first
neu build                   # Then build Neutralino app

# Extension development
neu ext install extension-name
neu ext uninstall extension-name

# Distribution
neu dist                    # Create distribution packages

# Debugging
neu run --enable-inspector  # Enable Chrome DevTools
neu run --verbose          # Verbose logging
```

### Build Integration with Modern Frontend Tools

```json
// package.json - Integrated build process
{
  "name": "neutralino-app",
  "version": "1.0.0",
  "scripts": {
    "dev": "concurrently "npm run dev:frontend" "npm run dev:neutralino"",
    "dev:frontend": "vite",
    "dev:neutralino": "neu run",
    "build": "npm run build:frontend && npm run build:neutralino",
    "build:frontend": "vite build",
    "build:neutralino": "neu build",
    "build:release": "npm run build:frontend && neu build --release",
    "test": "vitest",
    "test:e2e": "playwright test",
    "clean": "rimraf dist bin resources",
    "dist": "npm run build:release && neu dist"
  },
  "devDependencies": {
    "vite": "^4.0.0",
    "concurrently": "^7.0.0",
    "rimraf": "^4.0.0",
    "@neutralinojs/neu": "^10.0.0"
  }
}
```

## AI Agent Decision Matrix

| Scenario                         | Recommended Approach               | Avoid                                    |
| -------------------------------- | ---------------------------------- | ---------------------------------------- |
| Simple desktop utility           | Neutralino with vanilla JS         | Heavy frameworks for simple apps         |
| Web app conversion               | Neutralino with existing codebase  | Rewriting for different framework        |
| Resource-constrained environment | Neutralino minimal setup           | Electron or heavy alternatives           |
| Quick prototyping                | Neutralino with modern frontend    | Complex native development               |
| System integration required      | Neutralino with extensions         | Pure web-based solutions                 |
| Enterprise application           | Electron or native frameworks      | Neutralino (limited enterprise features) |
| Performance-critical app         | Native frameworks                  | Any web-based solution                   |
| Complex security requirements    | Native apps with proper sandboxing | Neutralino (limited security model)      |

## Testing

### ✅ Frontend Testing with Vitest

```javascript
// tests/neutralino-api.test.js
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { neutralinoAPI } from '../src/services/neutralino-api';

// Mock Neutralino global
global.Neutralino = {
  init: vi.fn(),
  events: {
    on: vi.fn(),
  },
  filesystem: {
    readFile: vi.fn(),
    writeFile: vi.fn(),
    readDirectory: vi.fn(),
    createDirectory: vi.fn(),
    removeFile: vi.fn(),
  },
  window: {
    setTitle: vi.fn(),
    getSize: vi.fn(),
    setSize: vi.fn(),
  },
  storage: {
    setData: vi.fn(),
    getData: vi.fn(),
  },
};

describe('NeutralinoAPI', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('File Operations', () => {
    it('should read file successfully', async () => {
      const mockContent = 'file content';
      Neutralino.filesystem.readFile.mockResolvedValue(mockContent);

      const result = await neutralinoAPI.readFile('/test/file.txt');

      expect(result.success).toBe(true);
      expect(result.data).toBe(mockContent);
      expect(Neutralino.filesystem.readFile).toHaveBeenCalledWith('/test/file.txt');
    });

    it('should handle file read errors', async () => {
      const mockError = new Error('File not found');
      Neutralino.filesystem.readFile.mockRejectedValue(mockError);

      const result = await neutralinoAPI.readFile('/nonexistent/file.txt');

      expect(result.success).toBe(false);
      expect(result.error).toBe('File not found');
    });

    it('should write file successfully', async () => {
      Neutralino.filesystem.writeFile.mockResolvedValue();

      const result = await neutralinoAPI.writeFile('/test/file.txt', 'content');

      expect(result.success).toBe(true);
      expect(Neutralino.filesystem.writeFile).toHaveBeenCalledWith('/test/file.txt', 'content');
    });

    it('should create directory successfully', async () => {
      Neutralino.filesystem.createDirectory.mockResolvedValue();

      const result = await neutralinoAPI.createDirectory('/test/newdir');

      expect(result.success).toBe(true);
      expect(Neutralino.filesystem.createDirectory).toHaveBeenCalledWith('/test/newdir');
    });
  });

  describe('Window Operations', () => {
    it('should set window title', async () => {
      Neutralino.window.setTitle.mockResolvedValue();

      const result = await neutralinoAPI.setWindowTitle('New Title');

      expect(result.success).toBe(true);
      expect(Neutralino.window.setTitle).toHaveBeenCalledWith('New Title');
    });

    it('should get window size', async () => {
      const mockSize = { width: 800, height: 600 };
      Neutralino.window.getSize.mockResolvedValue(mockSize);

      const result = await neutralinoAPI.getWindowSize();

      expect(result.success).toBe(true);
      expect(result.data).toEqual(mockSize);
    });
  });

  describe('Storage Operations', () => {
    it('should store and retrieve data', async () => {
      const testData = { key: 'value', number: 42 };
      Neutralino.storage.setData.mockResolvedValue();
      Neutralino.storage.getData.mockResolvedValue(JSON.stringify(testData));

      const setResult = await neutralinoAPI.setStorageData('test', testData);
      expect(setResult.success).toBe(true);

      const getResult = await neutralinoAPI.getStorageData('test');
      expect(getResult.success).toBe(true);
      expect(getResult.data).toEqual(testData);
    });
  });
});
```

### ✅ End-to-End Testing with Playwright

```javascript
// tests/e2e/app.spec.js
import { test, expect } from '@playwright/test';

test.describe('Neutralino App E2E Tests', () => {
  test.beforeEach(async ({ page }) => {
    // Navigate to the Neutralino app
    await page.goto('http://localhost:5173'); // Adjust port as needed
  });

  test('should load the application', async ({ page }) => {
    await expect(page).toHaveTitle(/My Neutralino App/);
    await expect(page.locator('body')).toBeVisible();
  });

  test('should display file manager', async ({ page }) => {
    const fileManager = page.locator('.file-manager');
    await expect(fileManager).toBeVisible();

    const toolbar = page.locator('.toolbar');
    await expect(toolbar).toBeVisible();

    const fileList = page.locator('.file-list');
    await expect(fileList).toBeVisible();
  });

  test('should create new file', async ({ page }) => {
    // Mock the prompt dialog
    page.on('dialog', async (dialog) => {
      expect(dialog.type()).toBe('prompt');
      await dialog.accept('test-file.txt');
    });

    await page.click('button:text("New File")');

    // Check if file appears in the list
    await expect(page.locator('.file-item:text("test-file.txt")')).toBeVisible();
  });

  test('should navigate directories', async ({ page }) => {
    // Click on a directory (assuming there's one)
    const directory = page.locator('.file-item.directory').first();
    if ((await directory.count()) > 0) {
      await directory.click();

      // Check if the current path changed
      const currentPath = page.locator('.current-path');
      await expect(currentPath).not.toHaveText('');
    }
  });

  test('should edit file content', async ({ page }) => {
    // Select a text file
    const textFile = page.locator('.file-item.file').first();
    if ((await textFile.count()) > 0) {
      await textFile.click();

      // Check if editor appears
      const editor = page.locator('.file-editor');
      await expect(editor).toBeVisible();

      // Edit content
      const textarea = page.locator('.file-content-editor');
      await textarea.fill('Updated content');

      // Save file
      await page.click('button:text("Save")');

      // Check for success message
      page.on('dialog', async (dialog) => {
        expect(dialog.message()).toContain('saved successfully');
        await dialog.accept();
      });
    }
  });
});
```

## Security Considerations

- Configure minimal native API allowlist for production applications
- Validate all user inputs before passing to Neutralino APIs
- Use HTTPS for any network communications from the web frontend
- Implement proper access controls for file system operations
- Avoid exposing sensitive system information through the web interface
- Use one-time token security mode for production deployments
- Regular updates to Neutralino framework for security patches
- Consider sandboxing limitations compared to Electron or native apps
- Implement proper session management for multi-user scenarios
- Use content security policies (CSP) for the web frontend

## AI Agent Quick Reference

- **Project Setup**: Use Neutralino CLI with modern frontend framework integration
- **API Usage**: Implement comprehensive error handling for all Neutralino API calls
- **Architecture**: Separate frontend logic from Neutralino-specific system integration
- **Performance**: Cache system calls and implement efficient resource management
- **Testing**: Unit test frontend logic, mock Neutralino APIs, use E2E for integration
- **Distribution**: Build frontend first, then use Neutralino build tools
- **Cross-platform**: Test on all target platforms, handle OS-specific differences
- **Security**: Configure minimal native API permissions, validate all system interactions
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
