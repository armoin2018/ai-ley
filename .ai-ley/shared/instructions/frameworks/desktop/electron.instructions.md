---
applyTo: 'electron, electronjs'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Electron 28+ for cross-platform desktop applications'
---

# Electron Framework Instructions for AI Agents

## When to Use Electron

Use Electron when you need:

- Cross-platform desktop applications using web technologies
- Leveraging existing web development skills for desktop apps
- Rapid desktop app development with familiar tools (HTML, CSS, JavaScript)
- Access to native desktop APIs while maintaining web-based UI
- Consistent user experience across Windows, macOS, and Linux
- Desktop apps with rich multimedia, complex layouts, or web integrations
- Converting existing web applications to desktop applications

## When to Avoid Electron

Consider alternatives when:

- Building performance-critical applications (games, CAD, video editing)
- Memory usage is a primary concern (Electron apps use more RAM)
- Creating simple utility apps (consider native solutions or Tauri)
- Building mobile applications (use React Native, Flutter, or native)
- Maximum startup time performance is critical
- Working with security-sensitive applications requiring maximum isolation

## Framework Overview

- **Framework**: Electron 28.x+
- **Type**: Cross-platform desktop application framework
- **Architecture**: Chromium + Node.js runtime with main/renderer process architecture
- **Language**: JavaScript/TypeScript, HTML, CSS
- **Use Cases**: Desktop apps, IDEs, productivity tools, media applications

## Installation & Setup

### ✅ Recommended: Electron Forge (Modern Toolchain)

```bash
# Create new Electron app with Forge
npm create electron-app@latest my-app
cd my-app

# Or with specific template
npm create electron-app@latest my-app -- --template=typescript
npm create electron-app@latest my-app -- --template=typescript-webpack
npm create electron-app@latest my-app -- --template=vite-typescript

# Development
npm start

# Build for distribution
npm run make
```

### ✅ Alternative: Manual Setup

```bash
# Initialize new project
mkdir my-electron-app
cd my-electron-app
npm init -y

# Install Electron
npm install --save-dev electron

# Install development dependencies
npm install --save-dev @electron/rebuild
npm install --save-dev electron-builder # for packaging

# Add start script to package.json
npm pkg set scripts.start="electron ."
npm pkg set main="src/main.js"
```

### AI Agent Decision Tree

- **For new projects**: Use Electron Forge with TypeScript template
- **For existing web apps**: Add Electron manually with minimal configuration
- **For complex builds**: Use Electron Builder for advanced packaging
- **For simple apps**: Start with basic setup and add complexity incrementally
- **For team development**: Use TypeScript and ESLint configuration

## Project Structure

### ✅ Electron Forge Project Structure

```
electron-app/
├── src/
│   ├── main.ts                # Main process (Node.js)
│   ├── preload.ts             # Preload scripts (security bridge)
│   ├── renderer.ts            # Renderer process logic
│   ├── index.html             # Application UI
│   └── styles.css             # Application styles
├── out/                       # Built application
├── .vscode/                   # VS Code configuration
├── .eslintrc.json            # ESLint configuration
├── .gitignore
├── forge.config.ts           # Electron Forge configuration
├── package.json
├── tsconfig.json
└── webpack.main.config.ts    # Webpack config for main process
```

### ✅ Advanced Project Structure

```
enterprise-electron-app/
├── src/
│   ├── main/                  # Main process modules
│   │   ├── main.ts
│   │   ├── menu.ts
│   │   ├── windows.ts
│   │   └── ipc-handlers.ts
│   ├── preload/               # Preload scripts
│   │   ├── preload.ts
│   │   └── types.ts
│   ├── renderer/              # Renderer process
│   │   ├── components/
│   │   ├── services/
│   │   ├── utils/
│   │   ├── index.html
│   │   ├── app.ts
│   │   └── styles/
│   └── shared/                # Shared types and utilities
│       ├── types.ts
│       ├── constants.ts
│       └── ipc-channels.ts
├── assets/                    # Static assets
│   ├── icons/
│   └── images/
├── build/                     # Build configuration
│   ├── icon.ico
│   ├── icon.png
│   └── installer.nsh
├── dist/                      # Distribution builds
├── tests/                     # Test files
├── docs/                      # Documentation
└── scripts/                   # Build and utility scripts
```

## Core Concepts

### Main Process and Renderer Processes

✅ **Best Practice**: Proper process architecture with IPC communication

```typescript
// src/main/main.ts - Main process
import { app, BrowserWindow, ipcMain, Menu, shell } from 'electron';
import * as path from 'path';
import { isDev } from './utils';

interface WindowState {
  width: number;
  height: number;
  x?: number;
  y?: number;
  isMaximized: boolean;
}

class ElectronApp {
  private mainWindow: BrowserWindow | null = null;
  private windowState: WindowState = {
    width: 1200,
    height: 800,
    isMaximized: false,
  };

  async initialize(): Promise<void> {
    await app.whenReady();
    this.createMainWindow();
    this.setupEventHandlers();
    this.setupIpcHandlers();
    this.createMenu();
  }

  private createMainWindow(): void {
    // Load previous window state
    this.loadWindowState();

    this.mainWindow = new BrowserWindow({
      width: this.windowState.width,
      height: this.windowState.height,
      x: this.windowState.x,
      y: this.windowState.y,
      minWidth: 800,
      minHeight: 600,
      webPreferences: {
        nodeIntegration: false, // Security: disable node integration
        contextIsolation: true, // Security: enable context isolation
        sandbox: true, // Security: enable sandbox
        preload: path.join(__dirname, '../preload/preload.js'),
        webSecurity: !isDev, // Disable web security only in dev
      },
      titleBarStyle: process.platform === 'darwin' ? 'hiddenInset' : 'default',
      show: false, // Don't show until ready
    });

    // Load the application
    if (isDev) {
      this.mainWindow.loadURL('http://localhost:3000');
      this.mainWindow.webContents.openDevTools();
    } else {
      this.mainWindow.loadFile(path.join(__dirname, '../renderer/index.html'));
    }

    // Show window when ready
    this.mainWindow.once('ready-to-show', () => {
      if (this.windowState.isMaximized) {
        this.mainWindow?.maximize();
      }
      this.mainWindow?.show();
    });

    // Save window state on close
    this.mainWindow.on('close', () => {
      this.saveWindowState();
    });

    // Handle external links
    this.mainWindow.webContents.setWindowOpenHandler(({ url }) => {
      shell.openExternal(url);
      return { action: 'deny' };
    });
  }

  private setupEventHandlers(): void {
    // Quit when all windows are closed (except on macOS)
    app.on('window-all-closed', () => {
      if (process.platform !== 'darwin') {
        app.quit();
      }
    });

    // Re-create window on macOS when dock icon is clicked
    app.on('activate', () => {
      if (BrowserWindow.getAllWindows().length === 0) {
        this.createMainWindow();
      }
    });

    // Security: prevent new window creation
    app.on('web-contents-created', (_, contents) => {
      contents.on('new-window', (event, navigationUrl) => {
        event.preventDefault();
        shell.openExternal(navigationUrl);
      });
    });
  }

  private setupIpcHandlers(): void {
    // File operations
    ipcMain.handle('file:open', async () => {
      const { dialog } = await import('electron');
      const result = await dialog.showOpenDialog(this.mainWindow!, {
        properties: ['openFile'],
        filters: [
          { name: 'Text Files', extensions: ['txt', 'md'] },
          { name: 'All Files', extensions: ['*'] },
        ],
      });

      if (!result.canceled && result.filePaths.length > 0) {
        const fs = await import('fs/promises');
        const content = await fs.readFile(result.filePaths[0], 'utf-8');
        return {
          success: true,
          filePath: result.filePaths[0],
          content,
        };
      }

      return { success: false };
    });

    ipcMain.handle('file:save', async (_, filePath: string, content: string) => {
      try {
        const fs = await import('fs/promises');
        await fs.writeFile(filePath, content, 'utf-8');
        return { success: true };
      } catch (error) {
        console.error('Save error:', error);
        return { success: false, error: error.message };
      }
    });

    // Application info
    ipcMain.handle('app:getVersion', () => app.getVersion());
    ipcMain.handle('app:getPlatform', () => process.platform);

    // Window controls
    ipcMain.handle('window:minimize', () => {
      this.mainWindow?.minimize();
    });

    ipcMain.handle('window:maximize', () => {
      if (this.mainWindow?.isMaximized()) {
        this.mainWindow.unmaximize();
      } else {
        this.mainWindow?.maximize();
      }
    });

    ipcMain.handle('window:close', () => {
      this.mainWindow?.close();
    });
  }

  private createMenu(): void {
    const template: Electron.MenuItemConstructorOptions[] = [
      {
        label: 'File',
        submenu: [
          {
            label: 'New',
            accelerator: 'CmdOrCtrl+N',
            click: () => {
              this.mainWindow?.webContents.send('menu:new');
            },
          },
          {
            label: 'Open',
            accelerator: 'CmdOrCtrl+O',
            click: () => {
              this.mainWindow?.webContents.send('menu:open');
            },
          },
          {
            label: 'Save',
            accelerator: 'CmdOrCtrl+S',
            click: () => {
              this.mainWindow?.webContents.send('menu:save');
            },
          },
          { type: 'separator' },
          {
            label: 'Quit',
            accelerator: process.platform === 'darwin' ? 'Cmd+Q' : 'Ctrl+Q',
            click: () => {
              app.quit();
            },
          },
        ],
      },
      {
        label: 'Edit',
        submenu: [
          { role: 'undo' },
          { role: 'redo' },
          { type: 'separator' },
          { role: 'cut' },
          { role: 'copy' },
          { role: 'paste' },
        ],
      },
      {
        label: 'View',
        submenu: [
          { role: 'reload' },
          { role: 'forceReload' },
          { role: 'toggleDevTools' },
          { type: 'separator' },
          { role: 'resetZoom' },
          { role: 'zoomIn' },
          { role: 'zoomOut' },
          { type: 'separator' },
          { role: 'togglefullscreen' },
        ],
      },
    ];

    const menu = Menu.buildFromTemplate(template);
    Menu.setApplicationMenu(menu);
  }

  private loadWindowState(): void {
    try {
      const { screen } = require('electron');
      const fs = require('fs');
      const path = require('path');

      const stateFile = path.join(app.getPath('userData'), 'window-state.json');

      if (fs.existsSync(stateFile)) {
        const state = JSON.parse(fs.readFileSync(stateFile, 'utf-8'));

        // Ensure window is visible on current displays
        const bounds = screen.getPrimaryDisplay().bounds;
        if (state.x >= 0 && state.x < bounds.width && state.y >= 0 && state.y < bounds.height) {
          this.windowState = state;
        }
      }
    } catch (error) {
      console.error('Failed to load window state:', error);
    }
  }

  private saveWindowState(): void {
    try {
      if (!this.mainWindow) return;

      const bounds = this.mainWindow.getBounds();
      const state: WindowState = {
        width: bounds.width,
        height: bounds.height,
        x: bounds.x,
        y: bounds.y,
        isMaximized: this.mainWindow.isMaximized(),
      };

      const fs = require('fs');
      const path = require('path');
      const stateFile = path.join(app.getPath('userData'), 'window-state.json');

      fs.writeFileSync(stateFile, JSON.stringify(state, null, 2));
    } catch (error) {
      console.error('Failed to save window state:', error);
    }
  }
}

// Application entry point
const electronApp = new ElectronApp();
electronApp.initialize().catch(console.error);
```

### Preload Scripts for Security

✅ **Best Practice**: Secure communication between main and renderer processes

```typescript
// src/preload/preload.ts
import { contextBridge, ipcRenderer } from 'electron';

// Define the API interface
interface ElectronAPI {
  // File operations
  fileOpen: () => Promise<{ success: boolean; filePath?: string; content?: string }>;
  fileSave: (filePath: string, content: string) => Promise<{ success: boolean; error?: string }>;

  // Application info
  getVersion: () => Promise<string>;
  getPlatform: () => Promise<string>;

  // Window controls
  windowMinimize: () => Promise<void>;
  windowMaximize: () => Promise<void>;
  windowClose: () => Promise<void>;

  // Menu events
  onMenuAction: (callback: (action: string) => void) => void;
  removeMenuListeners: () => void;
}

// Expose protected methods that allow the renderer process to use
// the ipcRenderer without exposing the entire object
const electronAPI: ElectronAPI = {
  // File operations
  fileOpen: () => ipcRenderer.invoke('file:open'),
  fileSave: (filePath: string, content: string) =>
    ipcRenderer.invoke('file:save', filePath, content),

  // Application info
  getVersion: () => ipcRenderer.invoke('app:getVersion'),
  getPlatform: () => ipcRenderer.invoke('app:getPlatform'),

  // Window controls
  windowMinimize: () => ipcRenderer.invoke('window:minimize'),
  windowMaximize: () => ipcRenderer.invoke('window:maximize'),
  windowClose: () => ipcRenderer.invoke('window:close'),

  // Menu events
  onMenuAction: (callback: (action: string) => void) => {
    const handler = (_: any, action: string) => callback(action);
    ipcRenderer.on('menu:new', handler);
    ipcRenderer.on('menu:open', handler);
    ipcRenderer.on('menu:save', handler);
  },

  removeMenuListeners: () => {
    ipcRenderer.removeAllListeners('menu:new');
    ipcRenderer.removeAllListeners('menu:open');
    ipcRenderer.removeAllListeners('menu:save');
  },
};

// Expose the API to the renderer process
contextBridge.exposeInMainWorld('electronAPI', electronAPI);

// Type declaration for renderer process
declare global {
  interface Window {
    electronAPI: ElectronAPI;
  }
}
```

### Renderer Process with TypeScript

✅ **Best Practice**: Type-safe renderer process with proper error handling

```typescript
// src/renderer/app.ts
interface AppState {
  currentFile: string | null;
  content: string;
  hasUnsavedChanges: boolean;
  platform: string;
}

class RendererApp {
  private state: AppState = {
    currentFile: null,
    content: '',
    hasUnsavedChanges: false,
    platform: 'unknown',
  };

  private elements: {
    editor?: HTMLTextAreaElement;
    statusBar?: HTMLElement;
    titleBar?: HTMLElement;
  } = {};

  async initialize(): Promise<void> {
    await this.loadPlatformInfo();
    this.setupDOM();
    this.setupEventListeners();
    this.setupMenuHandlers();
    this.updateUI();
  }

  private async loadPlatformInfo(): Promise<void> {
    try {
      this.state.platform = await window.electronAPI.getPlatform();
    } catch (error) {
      console.error('Failed to load platform info:', error);
    }
  }

  private setupDOM(): void {
    // Create main application structure
    document.body.innerHTML = `
      <div class="app">
        <div class="title-bar" id="titleBar">
          <div class="title">Text Editor</div>
          <div class="window-controls" id="windowControls">
            <button id="minimizeBtn" class="window-btn">-</button>
            <button id="maximizeBtn" class="window-btn">□</button>
            <button id="closeBtn" class="window-btn">×</button>
          </div>
        </div>
        <div class="editor-container">
          <textarea 
            id="editor" 
            class="editor" 
            placeholder="Start typing..."
            spellcheck="false"
          ></textarea>
        </div>
        <div class="status-bar" id="statusBar">
          <span class="status-info">Ready</span>
          <span class="file-info"></span>
        </div>
      </div>
    `;

    // Cache DOM elements
    this.elements.editor = document.getElementById('editor') as HTMLTextAreaElement;
    this.elements.statusBar = document.getElementById('statusBar');
    this.elements.titleBar = document.getElementById('titleBar');

    // Platform-specific styling
    if (this.state.platform === 'darwin') {
      this.elements.titleBar?.classList.add('mac-titlebar');
    }
  }

  private setupEventListeners(): void {
    // Editor content changes
    this.elements.editor?.addEventListener('input', (e) => {
      const target = e.target as HTMLTextAreaElement;
      this.state.content = target.value;
      this.state.hasUnsavedChanges = true;
      this.updateUI();
    });

    // Window controls (for custom title bar)
    document.getElementById('minimizeBtn')?.addEventListener('click', () => {
      window.electronAPI.windowMinimize();
    });

    document.getElementById('maximizeBtn')?.addEventListener('click', () => {
      window.electronAPI.windowMaximize();
    });

    document.getElementById('closeBtn')?.addEventListener('click', () => {
      this.handleClose();
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', (e) => {
      if (e.ctrlKey || e.metaKey) {
        switch (e.key) {
          case 'n':
            e.preventDefault();
            this.newFile();
            break;
          case 'o':
            e.preventDefault();
            this.openFile();
            break;
          case 's':
            e.preventDefault();
            this.saveFile();
            break;
        }
      }
    });

    // Prevent data loss
    window.addEventListener('beforeunload', (e) => {
      if (this.state.hasUnsavedChanges) {
        e.preventDefault();
        e.returnValue = '';
      }
    });
  }

  private setupMenuHandlers(): void {
    window.electronAPI.onMenuAction((action: string) => {
      switch (action) {
        case 'menu:new':
          this.newFile();
          break;
        case 'menu:open':
          this.openFile();
          break;
        case 'menu:save':
          this.saveFile();
          break;
      }
    });
  }

  private async newFile(): Promise<void> {
    if (this.state.hasUnsavedChanges) {
      const shouldDiscard = confirm('You have unsaved changes. Continue without saving?');
      if (!shouldDiscard) return;
    }

    this.state.currentFile = null;
    this.state.content = '';
    this.state.hasUnsavedChanges = false;

    if (this.elements.editor) {
      this.elements.editor.value = '';
    }

    this.updateUI();
  }

  private async openFile(): Promise<void> {
    try {
      const result = await window.electronAPI.fileOpen();

      if (result.success && result.content !== undefined) {
        this.state.currentFile = result.filePath || null;
        this.state.content = result.content;
        this.state.hasUnsavedChanges = false;

        if (this.elements.editor) {
          this.elements.editor.value = result.content;
        }

        this.updateUI();
        this.updateStatus('File opened successfully');
      }
    } catch (error) {
      console.error('Open file error:', error);
      this.updateStatus('Failed to open file', true);
    }
  }

  private async saveFile(): Promise<void> {
    if (!this.state.currentFile) {
      // TODO: Implement save-as dialog
      this.updateStatus('Save-as not implemented yet', true);
      return;
    }

    try {
      const result = await window.electronAPI.fileSave(this.state.currentFile, this.state.content);

      if (result.success) {
        this.state.hasUnsavedChanges = false;
        this.updateUI();
        this.updateStatus('File saved successfully');
      } else {
        this.updateStatus(`Save failed: ${result.error}`, true);
      }
    } catch (error) {
      console.error('Save file error:', error);
      this.updateStatus('Failed to save file', true);
    }
  }

  private async handleClose(): Promise<void> {
    if (this.state.hasUnsavedChanges) {
      const shouldSave = confirm('You have unsaved changes. Save before closing?');
      if (shouldSave) {
        await this.saveFile();
      }
    }

    window.electronAPI.windowClose();
  }

  private updateUI(): void {
    // Update title
    const fileName = this.state.currentFile
      ? this.state.currentFile.split('/').pop() || 'Untitled'
      : 'Untitled';

    const title = `${fileName}${this.state.hasUnsavedChanges ? ' •' : ''} - Text Editor`;
    document.title = title;

    // Update status bar
    const fileInfo = this.state.currentFile ? `File: ${this.state.currentFile}` : 'No file open';

    const statusElement = this.elements.statusBar?.querySelector('.file-info');
    if (statusElement) {
      statusElement.textContent = fileInfo;
    }
  }

  private updateStatus(message: string, isError = false): void {
    const statusElement = this.elements.statusBar?.querySelector('.status-info');
    if (statusElement) {
      statusElement.textContent = message;
      statusElement.className = `status-info ${isError ? 'error' : ''}`;

      // Clear status after 3 seconds
      setTimeout(() => {
        statusElement.textContent = 'Ready';
        statusElement.className = 'status-info';
      }, 3000);
    }
  }
}

// Initialize the application
document.addEventListener('DOMContentLoaded', () => {
  const app = new RendererApp();
  app.initialize().catch(console.error);
});
```

## Best Practices

### ✅ Do's

- Use context isolation and disable node integration for security
- Implement proper IPC communication with preload scripts
- Handle window state persistence for better user experience
- Use TypeScript for better development experience and type safety
- Implement proper error handling and user feedback
- Follow platform-specific UI guidelines (macOS, Windows, Linux)
- Use Electron Forge or similar tools for build management
- Implement auto-updater for production applications

### ❌ Don'ts

- Don't disable security features without understanding implications
- Don't expose the entire Node.js API to renderer processes
- Don't ignore memory management and potential memory leaks
- Don't forget to handle platform-specific behaviors
- Don't skip code signing for production applications
- Don't ignore app size optimization and bundle analysis
- Don't forget to handle network connectivity issues
- Don't mix synchronous IPC calls in performance-critical code

### Security Best Practices

```typescript
// forge.config.ts - Security-focused configuration
import type { ForgeConfig } from '@electron-forge/shared-types';

const config: ForgeConfig = {
  packagerConfig: {
    // Code signing configuration
    osxSign: {
      identity: process.env.APPLE_IDENTITY,
      'hardened-runtime': true,
      'gatekeeper-assess': false,
      entitlements: 'build/entitlements.plist',
      'entitlements-inherit': 'build/entitlements.plist',
    },
    osxNotarize: {
      appleId: process.env.APPLE_ID!,
      appleIdPassword: process.env.APPLE_APP_PASSWORD!,
      teamId: process.env.APPLE_TEAM_ID!,
    },
    // Windows code signing
    win32metadata: {
      CompanyName: 'Your Company',
      ProductName: 'Your App',
      FileDescription: 'Your app description',
    },
  },
  makers: [
    {
      name: '@electron-forge/maker-squirrel',
      config: {
        // Windows installer configuration
        certificateFile: process.env.WINDOWS_CERTIFICATE_FILE,
        certificatePassword: process.env.WINDOWS_CERTIFICATE_PASSWORD,
      },
    },
    {
      name: '@electron-forge/maker-dmg',
      config: {
        // macOS DMG configuration
        background: './assets/dmg-background.png',
        icon: './assets/icon.icns',
      },
    },
    {
      name: '@electron-forge/maker-deb',
      config: {
        // Linux DEB configuration
        options: {
          maintainer: 'Your Name',
          homepage: 'https://yourwebsite.com',
        },
      },
    },
  ],
  plugins: [
    {
      name: '@electron-forge/plugin-auto-unpack-natives',
      config: {},
    },
    {
      name: '@electron-forge/plugin-webpack',
      config: {
        mainConfig: './webpack.main.config.js',
        renderer: {
          config: './webpack.renderer.config.js',
          entryPoints: [
            {
              html: './src/index.html',
              js: './src/renderer.ts',
              name: 'main_window',
              preload: {
                js: './src/preload.ts',
              },
            },
          ],
        },
      },
    },
  ],
};

export default config;
```

## Development Workflow

### ✅ Recommended Development Process

```bash
# Development workflow
npm start                     # Start development server
npm run lint                  # Run ESLint
npm run type-check           # TypeScript type checking
npm test                     # Run tests

# Building for distribution
npm run make                 # Build for current platform
npm run make -- --platform=darwin  # Build for macOS
npm run make -- --platform=win32   # Build for Windows
npm run make -- --platform=linux   # Build for Linux

# Publishing
npm run publish              # Build and publish to GitHub releases

# Debugging
npm run start:debug          # Start with DevTools enabled
npm run start:inspect        # Start with Node.js inspector
```

### Testing and Quality Assurance

```typescript
// tests/main.test.ts - Testing main process
import { Application } from 'spectron';
import * as path from 'path';

describe('Application launch', () => {
  let app: Application;

  beforeEach(async () => {
    app = new Application({
      path: path.join(__dirname, '..', 'out', 'my-app', 'my-app.exe'),
      args: [],
    });
    await app.start();
  });

  afterEach(async () => {
    if (app && app.isRunning()) {
      await app.stop();
    }
  });

  it('shows an initial window', async () => {
    const count = await app.client.getWindowCount();
    expect(count).toBe(1);
  });

  it('has the correct title', async () => {
    const title = await app.client.getTitle();
    expect(title).toBe('Text Editor');
  });

  it('handles file operations', async () => {
    // Test file open dialog
    await app.client.keys(['CommandOrControl', 'o']);
    // Add assertions for file dialog behavior
  });
});
```

### AI Agent Decision Matrix

| Scenario                   | Recommended Approach          | Avoid                         |
| -------------------------- | ----------------------------- | ----------------------------- |
| Cross-platform desktop app | Electron with TypeScript      | Native apps for each platform |
| Simple utility app         | Consider Tauri or native      | Electron (overhead)           |
| Web app conversion         | Electron with minimal changes | Complete rewrite              |
| Performance-critical app   | Native or Tauri               | Electron                      |
| Enterprise application     | Electron with security focus  | Web-only solutions            |
| Media/Graphics intensive   | Native frameworks             | Web-based solutions           |
| Rapid prototyping          | Electron with hot reload      | Complex native setup          |
| Team with web skills       | Leverage existing knowledge   | Learning native development   |

## Integration Guidelines

- **With React**: Use Electron + React for familiar component patterns
- **With Vue**: Integrate Vue.js for reactive UI development
- **With databases**: Use SQLite, IndexedDB, or remote databases
- **With APIs**: Implement secure API communication with proper authentication
- **With file systems**: Use Node.js fs APIs through IPC channels
- **With native modules**: Use @electron/rebuild for native dependencies
- **With CI/CD**: Automate builds and code signing in pipelines

## Testing

### ✅ Unit Testing with Jest

```typescript
// tests/ipc.test.ts
import { ipcRenderer } from 'electron';

// Mock electron
jest.mock('electron', () => ({
  ipcRenderer: {
    invoke: jest.fn(),
    on: jest.fn(),
    removeAllListeners: jest.fn(),
  },
}));

describe('IPC Communication', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should handle file open', async () => {
    const mockResult = {
      success: true,
      filePath: '/path/to/file.txt',
      content: 'file content',
    };

    (ipcRenderer.invoke as jest.Mock).mockResolvedValue(mockResult);

    const result = await window.electronAPI.fileOpen();

    expect(ipcRenderer.invoke).toHaveBeenCalledWith('file:open');
    expect(result).toEqual(mockResult);
  });

  it('should handle file save', async () => {
    const mockResult = { success: true };
    (ipcRenderer.invoke as jest.Mock).mockResolvedValue(mockResult);

    const result = await window.electronAPI.fileSave('/path/to/file.txt', 'content');

    expect(ipcRenderer.invoke).toHaveBeenCalledWith('file:save', '/path/to/file.txt', 'content');
    expect(result).toEqual(mockResult);
  });
});
```

### ✅ E2E Testing with Playwright

```typescript
// tests/e2e/app.spec.ts
import { test, expect, _electron as electron } from '@playwright/test';
import * as path from 'path';

test.describe('Electron App E2E', () => {
  test('should launch app and interact with UI', async () => {
    // Launch Electron app
    const electronApp = await electron.launch({
      args: [path.join(__dirname, '../../out/main/main.js')],
    });

    // Get first window
    const page = await electronApp.firstWindow();

    // Test initial state
    await expect(page.locator('.title')).toHaveText('Text Editor');

    // Test editor interaction
    await page.locator('#editor').fill('Hello, Electron!');
    await expect(page.locator('#editor')).toHaveValue('Hello, Electron!');

    // Test menu interaction
    await page.keyboard.press('CommandOrControl+N');
    await expect(page.locator('#editor')).toHaveValue('');

    // Close app
    await electronApp.close();
  });
});
```

## Performance Optimization

- Implement code splitting and lazy loading for large applications
- Use virtual scrolling for large lists and data sets
- Optimize bundle size with tree shaking and dead code elimination
- Implement proper memory management and cleanup
- Use web workers for CPU-intensive tasks
- Optimize startup time with preload optimization
- Implement efficient state management patterns
- Use native modules only when necessary

## Security Considerations

- Enable context isolation and disable node integration by default
- Use content security policy (CSP) in renderer processes
- Validate all data received from IPC channels
- Implement proper authentication and session management
- Use HTTPS for all network communications
- Keep Electron and dependencies updated to latest secure versions
- Implement proper error handling that doesn't leak sensitive information
- Use code signing for production builds
- Follow principle of least privilege for IPC exposed APIs

## AI Agent Quick Reference

- **Project Setup**: Use Electron Forge with TypeScript template for modern development
- **Architecture**: Separate main process, preload scripts, and renderer process logic
- **Security**: Always use context isolation and preload scripts for IPC communication
- **Development**: Leverage TypeScript, ESLint, and modern tooling for quality
- **Testing**: Implement unit tests for logic and E2E tests for user workflows
- **Distribution**: Use Electron Builder or Forge for cross-platform packaging
- **Performance**: Optimize bundle size, implement lazy loading, and use native modules judiciously
- **Updates**: Implement auto-updater for seamless user experience

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
