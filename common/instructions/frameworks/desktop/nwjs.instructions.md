---
applyTo: 'nwjs, nw.js, node-webkit'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on NW.js for web-based desktop applications with Node.js integration'
---

# NW.js Framework Instructions for AI Agents

## When to Use NW.js

Use NW.js when you need:

- Desktop applications built with web technologies (HTML, CSS, JavaScript)
- Direct access to Node.js APIs from the browser context
- Applications requiring both DOM manipulation and file system access
- Migration from older Node-Webkit projects
- Applications needing backward compatibility with older Chromium versions
- Desktop apps with specific Node.js module dependencies
- Applications requiring fine-grained control over the Chromium runtime
- Legacy web applications that need desktop deployment

## When to Avoid NW.js

Consider alternatives when:

- Building new projects (prefer Electron for better ecosystem support)
- Need the smallest possible bundle size (use Neutralino or Tauri)
- Require modern security models with process isolation
- Working with teams unfamiliar with Node.js and Chromium internals
- Building applications with strict security requirements
- Need extensive mobile platform support alongside desktop
- Prefer frameworks with more active development and community

## Framework Overview

- **Framework**: NW.js (formerly Node-Webkit)
- **Type**: Web-based desktop application framework with Node.js integration
- **Runtime**: Chromium + Node.js in single process context
- **Languages**: JavaScript/TypeScript, HTML, CSS
- **Use Cases**: Legacy web app conversion, Node.js-heavy desktop apps, cross-platform utilities

## Installation & Setup

### ✅ Recommended: NW.js with npm Package Manager

```bash
# Install NW.js globally
npm install -g nw

# Verify installation
nw --version

# Create new project
mkdir my-nwjs-app && cd my-nwjs-app

# Initialize package.json
npm init -y

# Install NW.js as dev dependency for specific version control
npm install --save-dev nw

# Create basic application structure
mkdir src
touch src/index.html src/main.js src/style.css

# Create package.json for NW.js app
cat > package.json << 'EOF'
{
  "name": "my-nwjs-app",
  "version": "1.0.0",
  "description": "My NW.js Application",
  "main": "src/index.html",
  "node-remote": "http://localhost:*",
  "webkit": {
    "plugin": true
  },
  "window": {
    "title": "My NW.js App",
    "width": 1200,
    "height": 800,
    "min_width": 800,
    "min_height": 600,
    "position": "center",
    "resizable": true,
    "show_in_taskbar": true,
    "frame": true,
    "kiosk": false,
    "show": true
  },
  "scripts": {
    "start": "nw .",
    "dev": "nw . --debug",
    "build": "nwbuild -p win32,win64,osx64,linux32,linux64 -v 0.75.0 .",
    "dist": "npm run build"
  },
  "devDependencies": {
    "nw": "^0.75.0",
    "nw-builder": "^3.7.0"
  }
}
EOF

# Start development
npm start
```

### ✅ Alternative: Using NW.js Builder for Distribution

```bash
# Install nw-builder for packaging
npm install --save-dev nw-builder

# Create build script
cat > build.js << 'EOF'
const nwbuild = require('nw-builder');

const nw = new nwbuild({
    files: './src/**/**',
    platforms: ['win32', 'win64', 'osx64', 'linux32', 'linux64'],
    version: '0.75.0',
    flavor: 'normal',
    macIcns: './assets/icon.icns',
    winIco: './assets/icon.ico'
});

nw.on('log', console.log);

nw.build().then(function () {
   console.log('all done!');
}).catch(function (error) {
    console.error(error);
});
EOF

# Run build
node build.js
```

### ✅ Integration with Modern Frontend Tools

```bash
# Setup with webpack
npm install --save-dev webpack webpack-cli html-webpack-plugin

# Setup with Vite (for development)
npm install --save-dev vite

# Create vite.config.js for NW.js
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'

export default defineConfig({
  base: './',
  build: {
    outDir: 'dist',
    assetsDir: 'assets',
    rollupOptions: {
      output: {
        format: 'iife'
      }
    }
  },
  server: {
    port: 3000
  }
})
EOF

# Update package.json scripts
npm pkg set scripts.dev:web="vite"
npm pkg set scripts.build:web="vite build"
npm pkg set scripts.dev="concurrently "npm run dev:web" "npm start""
```

### AI Agent Decision Tree

- **For new projects**: Consider Electron unless specific NW.js features are required
- **For legacy migration**: NW.js provides smoother transition from Node-Webkit
- **For Node.js heavy apps**: NW.js offers direct Node.js access in renderer
- **For smaller teams**: NW.js has simpler architecture than Electron's multi-process model
- **For specific Chromium needs**: NW.js allows more control over Chromium version

## Project Structure

### ✅ Basic NW.js Project Structure

```
nwjs-app/
├── package.json             # NW.js app configuration
├── src/
│   ├── index.html           # Main HTML file
│   ├── main.js              # Main application logic
│   ├── style.css            # Application styles
│   ├── components/          # UI components
│   │   ├── header.js
│   │   ├── sidebar.js
│   │   └── main-content.js
│   ├── modules/             # Node.js modules
│   │   ├── file-manager.js
│   │   ├── system-info.js
│   │   └── database.js
│   ├── utils/               # Utility functions
│   │   ├── helpers.js
│   │   └── constants.js
│   └── assets/              # Static assets
│       ├── images/
│       ├── fonts/
│       └── icons/
├── node_modules/            # Node.js dependencies
├── build/                   # Build scripts
├── dist/                    # Built application
├── assets/                  # Application icons
│   ├── icon.icns           # macOS icon
│   ├── icon.ico            # Windows icon
│   └── icon.png            # Linux icon
└── docs/                    # Documentation
```

### ✅ Advanced NW.js Project with Modern Tooling

```
advanced-nwjs-app/
├── package.json
├── webpack.config.js        # Webpack configuration
├── babel.config.js          # Babel configuration
├── src/
│   ├── index.html
│   ├── main.js
│   ├── renderer/            # Renderer process code
│   │   ├── app.js
│   │   ├── components/
│   │   │   ├── App.vue      # If using Vue
│   │   │   ├── FileManager.vue
│   │   │   └── Settings.vue
│   │   ├── stores/          # State management
│   │   │   ├── app-store.js
│   │   │   └── file-store.js
│   │   ├── services/        # API services
│   │   │   ├── file-service.js
│   │   │   └── system-service.js
│   │   └── styles/          # SCSS/CSS files
│   │       ├── main.scss
│   │       └── components.scss
│   ├── main/                # Main process code
│   │   ├── app-controller.js
│   │   ├── file-controller.js
│   │   ├── window-manager.js
│   │   └── menu-manager.js
│   └── shared/              # Shared utilities
│       ├── constants.js
│       ├── ipc-channels.js
│       └── validation.js
├── static/                  # Static assets
├── build/                   # Build and packaging scripts
├── tests/                   # Tests
│   ├── unit/
│   ├── integration/
│   └── e2e/
└── docs/                    # Documentation
```

### ✅ TypeScript NW.js Project Structure

```
typescript-nwjs-app/
├── package.json
├── tsconfig.json            # TypeScript configuration
├── webpack.config.ts        # Webpack with TypeScript
├── src/
│   ├── index.html
│   ├── main.ts              # Main entry point
│   ├── types/               # TypeScript definitions
│   │   ├── global.d.ts
│   │   ├── nwjs.d.ts
│   │   └── app.d.ts
│   ├── app/                 # Application code
│   │   ├── controllers/
│   │   │   ├── AppController.ts
│   │   │   ├── FileController.ts
│   │   │   └── WindowController.ts
│   │   ├── models/          # Data models
│   │   │   ├── FileModel.ts
│   │   │   ├── SettingsModel.ts
│   │   │   └── UserModel.ts
│   │   ├── views/           # UI components
│   │   │   ├── MainView.ts
│   │   │   ├── FileExplorer.ts
│   │   │   └── SettingsView.ts
│   │   └── services/        # Services
│   │       ├── FileService.ts
│   │       ├── SystemService.ts
│   │       └── ConfigService.ts
│   ├── styles/              # Stylesheets
│   └── assets/              # Static assets
├── dist/                    # Compiled output
├── build/                   # Build scripts
└── types/                   # External type definitions
```

## Core Concepts

### Application Entry Point and Window Management

✅ **Best Practice**: Proper NW.js application structure with window management

```html
<!-- src/index.html - Main Application Entry -->
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NW.js Application</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <div id="app">
      <header id="header">
        <div class="title-bar">
          <h1>My NW.js App</h1>
          <div class="window-controls">
            <button id="minimize-btn">−</button>
            <button id="maximize-btn">□</button>
            <button id="close-btn">×</button>
          </div>
        </div>
        <nav id="navigation">
          <ul>
            <li><a href="#home" class="nav-link active">Home</a></li>
            <li><a href="#files" class="nav-link">Files</a></li>
            <li><a href="#settings" class="nav-link">Settings</a></li>
          </ul>
        </nav>
      </header>

      <main id="main-content">
        <div id="home-view" class="view active">
          <h2>Welcome to NW.js App</h2>
          <div class="system-info">
            <h3>System Information</h3>
            <div id="system-details"></div>
          </div>
        </div>

        <div id="files-view" class="view">
          <h2>File Manager</h2>
          <div class="file-manager">
            <div class="toolbar">
              <button id="open-folder-btn">Open Folder</button>
              <button id="create-file-btn">New File</button>
              <button id="delete-file-btn" disabled>Delete</button>
            </div>
            <div id="file-list"></div>
            <div id="file-content">
              <textarea id="file-editor" placeholder="Select a file to edit..."></textarea>
              <button id="save-file-btn" disabled>Save</button>
            </div>
          </div>
        </div>

        <div id="settings-view" class="view">
          <h2>Settings</h2>
          <div class="settings-form">
            <div class="setting-group">
              <label for="theme-select">Theme:</label>
              <select id="theme-select">
                <option value="light">Light</option>
                <option value="dark">Dark</option>
              </select>
            </div>
            <div class="setting-group">
              <label for="auto-save">Auto Save:</label>
              <input type="checkbox" id="auto-save" />
            </div>
            <button id="save-settings-btn">Save Settings</button>
          </div>
        </div>
      </main>

      <footer id="footer">
        <div class="status-bar">
          <span id="status-text">Ready</span>
          <span id="app-version"></span>
        </div>
      </footer>
    </div>

    <script src="main.js"></script>
  </body>
</html>
```

### NW.js API Integration and File Management

✅ **Best Practice**: Comprehensive NW.js API usage with error handling

```javascript
// src/main.js - Main Application Logic
class NWJSApp {
    constructor() {
        this.currentFile = null;
        this.isDirty = false;
        this.settings = this.loadSettings();

        this.init();
    }

    async init() {
        // Wait for NW.js to be ready
        if (typeof nw !== 'undefined') {
            this.setupNWJS();
        } else {
            // Fallback for web browser testing
            console.log('Running in browser mode - NW.js APIs not available');
        }

        this.setupUI();
        this.setupEventListeners();
        this.loadSystemInfo();
        this.applySettings();

        console.log('NW.js Application initialized');
    }

    setupNWJS() {
        // Get the current window
        this.win = nw.Window.get();

        // Setup window events
        this.win.on('close', () => {
            this.handleAppClose();
        });

        this.win.on('new-win-policy', (frame, url, policy) => {
            // Control how new windows are opened
            policy.ignore();
        });

        // Setup menu
        this.setupMenu();

        // Setup window controls if using frameless window
        this.setupWindowControls();

        // Enable developer tools in development
        if (this.isDevelopment()) {
            this.win.showDevTools();
        }
    }

    setupMenu() {
        // Create application menu
        const menubar = new nw.Menu({ type: 'menubar' });

        // File menu
        const fileMenu = new nw.Menu();
        fileMenu.append(new nw.MenuItem({
            label: 'New File',
            key: 'n',
            modifiers: 'ctrl',
            click: () => this.newFile()
        }));

        fileMenu.append(new nw.MenuItem({
            label: 'Open File',
            key: 'o',
            modifiers: 'ctrl',
            click: () => this.openFile()
        }));

        fileMenu.append(new nw.MenuItem({
            label: 'Save',
            key: 's',
            modifiers: 'ctrl',
            click: () => this.saveFile()
        }));

        fileMenu.append(new nw.MenuItem({ type: 'separator' }));

        fileMenu.append(new nw.MenuItem({
            label: 'Exit',
            key: 'q',
            modifiers: 'ctrl',
            click: () => this.win.close()
        }));

        // Add file menu to menubar
        menubar.append(new nw.MenuItem({
            label: 'File',
            submenu: fileMenu
        }));

        // Edit menu
        const editMenu = new nw.Menu();
        editMenu.append(new nw.MenuItem({
            label: 'Cut',
            key: 'x',
            modifiers: 'ctrl',
            click: () => document.execCommand('cut')
        }));

        editMenu.append(new nw.MenuItem({
            label: 'Copy',
            key: 'c',
            modifiers: 'ctrl',
            click: () => document.execCommand('copy')
        }));

        editMenu.append(new nw.MenuItem({
            label: 'Paste',
            key: 'v',
            modifiers: 'ctrl',
            click: () => document.execCommand('paste')
        }));

        menubar.append(new nw.MenuItem({
            label: 'Edit',
            submenu: editMenu
        }));

        // Help menu
        const helpMenu = new nw.Menu();
        helpMenu.append(new nw.MenuItem({
            label: 'About',
            click: () => this.showAbout()
        }));

        menubar.append(new nw.MenuItem({
            label: 'Help',
            submenu: helpMenu
        }));

        // Set the menubar
        this.win.menu = menubar;
    }

    setupWindowControls() {
        // Custom window controls for frameless windows
        const minimizeBtn = document.getElementById('minimize-btn');
        const maximizeBtn = document.getElementById('maximize-btn');
        const closeBtn = document.getElementById('close-btn');

        if (minimizeBtn) {
            minimizeBtn.addEventListener('click', () => {
                this.win.minimize();
            });
        }

        if (maximizeBtn) {
            maximizeBtn.addEventListener('click', () => {
                if (this.win.isMaximized) {
                    this.win.unmaximize();
                } else {
                    this.win.maximize();
                }
            });
        }

        if (closeBtn) {
            closeBtn.addEventListener('click', () => {
                this.win.close();
            });
        }
    }

    setupUI() {
        // Setup navigation
        this.setupNavigation();

        // Setup file manager
        this.setupFileManager();

        // Setup settings
        this.setupSettings();

        // Update version display
        const versionEl = document.getElementById('app-version');
        if (versionEl && typeof nw !== 'undefined') {
            versionEl.textContent = `v${nw.App.manifest.version}`;
        }
    }

    setupNavigation() {
        const navLinks = document.querySelectorAll('.nav-link');
        const views = document.querySelectorAll('.view');

        navLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();

                const targetId = link.getAttribute('href').substring(1) + '-view';

                // Hide all views
                views.forEach(view => view.classList.remove('active'));

                // Remove active class from all nav links
                navLinks.forEach(nav => nav.classList.remove('active'));

                // Show target view and activate nav link
                const targetView = document.getElementById(targetId);
                if (targetView) {
                    targetView.classList.add('active');
                    link.classList.add('active');
                }
            });
        });
    }

    setupFileManager() {
        const openFolderBtn = document.getElementById('open-folder-btn');
        const createFileBtn = document.getElementById('create-file-btn');
        const deleteFileBtn = document.getElementById('delete-file-btn');
        const saveFileBtn = document.getElementById('save-file-btn');
        const fileEditor = document.getElementById('file-editor');

        if (openFolderBtn) {
            openFolderBtn.addEventListener('click', () => this.openFolder());
        }

        if (createFileBtn) {
            createFileBtn.addEventListener('click', () => this.createNewFile());
        }

        if (deleteFileBtn) {
            deleteFileBtn.addEventListener('click', () => this.deleteSelectedFile());
        }

        if (saveFileBtn) {
            saveFileBtn.addEventListener('click', () => this.saveFile());
        }

        if (fileEditor) {
            fileEditor.addEventListener('input', () => {
                this.isDirty = true;
                if (saveFileBtn) {
                    saveFileBtn.disabled = false;
                }
                this.updateStatus('Modified');
            });
        }
    }

    setupSettings() {
        const themeSelect = document.getElementById('theme-select');
        const autoSaveCheck = document.getElementById('auto-save');
        const saveSettingsBtn = document.getElementById('save-settings-btn');

        if (themeSelect) {
            themeSelect.value = this.settings.theme || 'light';
            themeSelect.addEventListener('change', () => {
                this.settings.theme = themeSelect.value;
                this.applyTheme(this.settings.theme);
            });
        }

        if (autoSaveCheck) {
            autoSaveCheck.checked = this.settings.autoSave || false;
            autoSaveCheck.addEventListener('change', () => {
                this.settings.autoSave = autoSaveCheck.checked;
            });
        }

        if (saveSettingsBtn) {
            saveSettingsBtn.addEventListener('click', () => {
                this.saveSettings();
                this.updateStatus('Settings saved');
            });
        }
    }

    setupEventListeners() {
        // Global keyboard shortcuts
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

        // Prevent accidental navigation
        window.addEventListener('beforeunload', (e) => {
            if (this.isDirty) {
                const message = 'You have unsaved changes. Are you sure you want to leave?';
                e.returnValue = message;
                return message;
            }
        });
    }

    // File operations using Node.js APIs
    async openFile() {
        if (typeof nw === 'undefined') {
            console.log('File operations not available in browser mode');
            return;
        }

        try {
            const input = document.createElement('input');
            input.type = 'file';
            input.accept = '.txt,.js,.json,.md';

            input.onchange = async (e) => {
                const file = e.target.files[0];
                if (file) {
                    await this.loadFile(file.path);
                }
            };

            input.click();
        } catch (error) {
            this.showError('Failed to open file selector', error);
        }
    }

    async loadFile(filePath) {
        if (typeof require === 'undefined') return;

        try {
            const fs = require('fs').promises;
            const path = require('path');

            const content = await fs.readFile(filePath, 'utf8');
            const fileEditor = document.getElementById('file-editor');

            if (fileEditor) {
                fileEditor.value = content;
                this.currentFile = filePath;
                this.isDirty = false;

                const saveFileBtn = document.getElementById('save-file-btn');
                if (saveFileBtn) {
                    saveFileBtn.disabled = true;
                }

                this.updateStatus(`Loaded: ${path.basename(filePath)}`);
            }
        } catch (error) {
            this.showError(`Failed to load file: ${filePath}`, error);
        }
    }

    async saveFile() {
        if (!this.currentFile || typeof require === 'undefined') return;

        try {
            const fs = require('fs').promises;
            const path = require('path');
            const fileEditor = document.getElementById('file-editor');

            if (fileEditor) {
                await fs.writeFile(this.currentFile, fileEditor.value, 'utf8');
                this.isDirty = false;

                const saveFileBtn = document.getElementById('save-file-btn');
                if (saveFileBtn) {
                    saveFileBtn.disabled = true;
                }

                this.updateStatus(`Saved: ${path.basename(this.currentFile)}`);
            }
        } catch (error) {
            this.showError(`Failed to save file: ${this.currentFile}`, error);
        }
    }

    async newFile() {
        if (this.isDirty) {
            const confirmed = confirm('You have unsaved changes. Create new file anyway?');
            if (!confirmed) return;
        }

        const fileEditor = document.getElementById('file-editor');
        if (fileEditor) {
            fileEditor.value = '';
            this.currentFile = null;
            this.isDirty = false;

            const saveFileBtn = document.getElementById('save-file-btn');
            if (saveFileBtn) {
                saveFileBtn.disabled = true;
            }

            this.updateStatus('New file created');
        }
    }

    async loadSystemInfo() {
        const systemDetails = document.getElementById('system-details');
        if (!systemDetails) return;

        try {
            let systemInfo = '<p>System information:</p><ul>';

            if (typeof nw !== 'undefined') {
                // NW.js specific information
                systemInfo += `<li>NW.js Version: ${process.versions.nw}</li>`;
                systemInfo += `<li>Node.js Version: ${process.versions.node}</li>`;
                systemInfo += `<li>Chromium Version: ${process.versions.chromium}</li>`;
                systemInfo += `<li>Platform: ${process.platform}</li>`;
                systemInfo += `<li>Architecture: ${process.arch}</li>`;

                if (typeof require !== 'undefined') {
                    const os = require('os');
                    systemInfo += `<li>OS Type: ${os.type()}</li>`;
                    systemInfo += `<li>OS Release: ${os.release()}</li>`;
                    systemInfo += `<li>Total Memory: ${Math.round(os.totalmem() / 1024 / 1024 / 1024)} GB</li>`;
                    systemInfo += `<li>Free Memory: ${Math.round(os.freemem() / 1024 / 1024 / 1024)} GB</li>`;
                    systemInfo += `<li>CPU Cores: ${os.cpus().length}</li>`;
                }
            } else {
                systemInfo += '<li>Running in browser mode</li>';
                systemInfo += `<li>User Agent: ${navigator.userAgent}</li>`;
            }

            systemInfo += '</ul>';
            systemDetails.innerHTML = systemInfo;
        } catch (error) {
            systemDetails.innerHTML = '<p>Unable to load system information</p>';
            console.error('Failed to load system info:', error);
        }
    }

    loadSettings() {
        if (typeof localStorage !== 'undefined') {
            const saved = localStorage.getItem('nwjs-app-settings');
            return saved ? JSON.parse(saved) : {};
        }
        return {};
    }

    saveSettings() {
        if (typeof localStorage !== 'undefined') {
            localStorage.setItem('nwjs-app-settings', JSON.stringify(this.settings));
        }
    }

    applySettings() {
        if (this.settings.theme) {
            this.applyTheme(this.settings.theme);
        }
    }

    applyTheme(theme) {
        document.body.className = theme === 'dark' ? 'dark-theme' : 'light-theme';
    }

    updateStatus(message) {
        const statusText = document.getElementById('status-text');
        if (statusText) {
            statusText.textContent = message;

            // Clear status after 3 seconds
            setTimeout(() => {
                statusText.textContent = 'Ready';
            }, 3000);
        }
    }

    showError(message, error) {
        console.error(message, error);
        this.updateStatus(`Error: ${message}`);

        if (typeof nw !== 'undefined') {
            // Show native dialog
            const gui = require('nw.gui');
            gui.Shell.openExternal('javascript:alert("' + message + '")');
        } else {
            alert(message);
        }
    }

    showAbout() {
        const aboutMessage = `
            NW.js Application
            Version: ${typeof nw !== 'undefined' ? nw.App.manifest.version : '1.0.0'}

            Built with NW.js framework

            © 2025 Your Company
        `;

        if (typeof nw !== 'undefined') {
            const gui = require('nw.gui');
            gui.Shell.openExternal('javascript:alert("' + aboutMessage.replace(/
/g, '
') + '")');
        } else {
            alert(aboutMessage);
        }
    }

    isDevelopment() {
        return typeof nw !== 'undefined' && nw.App.manifest.debug === true;
    }

    handleAppClose() {
        if (this.isDirty) {
            const confirmed = confirm('You have unsaved changes. Close anyway?');
            if (!confirmed) {
                return false;
            }
        }

        // Save settings before closing
        this.saveSettings();

        // Close the application
        if (typeof nw !== 'undefined') {
            nw.App.quit();
        }
    }
}

// Initialize the application when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    new NWJSApp();
});

// Export for testing
if (typeof module !== 'undefined' && module.exports) {
    module.exports = NWJSApp;
}
```

## Best Practices

### ✅ Do's

- Use the latest stable version of NW.js for security and performance improvements
- Implement proper error handling for all Node.js and NW.js API calls
- Use modern JavaScript features and development tools for better code quality
- Implement proper window management and state persistence
- Use native menus and dialogs for better platform integration
- Handle both NW.js environment and browser fallbacks for testing
- Implement proper security measures when accessing file system and system APIs
- Use build tools like webpack or Vite for modern development workflow

### ❌ Don'ts

- Don't use NW.js for new projects unless specific features are required
- Don't ignore security implications of Node.js access in the renderer process
- Don't use outdated NW.js versions - regularly update for security patches
- Don't forget to handle platform-specific differences in file paths and APIs
- Don't expose sensitive Node.js APIs to untrusted web content
- Don't skip proper packaging and code signing for distribution
- Don't ignore memory management - NW.js apps can consume significant resources
- Don't forget to test on all target platforms thoroughly

### Security and Performance Considerations

```javascript
// Example of secure NW.js application patterns
class SecureNWJSApp {
  constructor() {
    this.initSecurity();
  }

  initSecurity() {
    // Disable Node.js in child windows
    nw.Window.open('about.html', {
      'node-integration': false,
    });

    // Validate file paths
    this.validatePath = (filePath) => {
      const path = require('path');
      const resolved = path.resolve(filePath);

      // Prevent directory traversal attacks
      if (resolved.includes('..')) {
        throw new Error('Invalid file path');
      }

      return resolved;
    };

    // Sanitize file operations
    this.safeFileOperation = async (operation, filePath, ...args) => {
      try {
        const safePath = this.validatePath(filePath);
        return await operation(safePath, ...args);
      } catch (error) {
        console.error('File operation failed:', error);
        throw error;
      }
    };
  }

  // Memory management
  cleanup() {
    // Clear large objects
    this.fileCache = null;
    this.imageCache = null;

    // Force garbage collection if available
    if (global.gc) {
      global.gc();
    }
  }

  // Performance monitoring
  monitorPerformance() {
    const used = process.memoryUsage();
    console.log('Memory usage:', {
      rss: Math.round(used.rss / 1024 / 1024) + ' MB',
      heapTotal: Math.round(used.heapTotal / 1024 / 1024) + ' MB',
      heapUsed: Math.round(used.heapUsed / 1024 / 1024) + ' MB',
    });
  }
}
```

## Development Workflow

### ✅ NW.js Development Process

```bash
# Development workflow
npm start                    # Start application in development mode
npm run dev                  # Start with debugging enabled

# Building for different platforms
npm run build               # Build for all platforms
nwbuild -p win32,win64 .    # Build for Windows
nwbuild -p osx64 .         # Build for macOS
nwbuild -p linux32,linux64 . # Build for Linux

# Using nw-builder programmatically
node build.js              # Custom build script

# Development with hot reload (using webpack-dev-server)
npm run dev:webpack         # Start webpack dev server
npm run build:webpack       # Build with webpack

# Testing
npm test                    # Run unit tests
npm run test:e2e           # Run end-to-end tests

# Debugging
npm run debug              # Start with DevTools open
nw . --remote-debugging-port=9222 # Remote debugging
```

### Package.json Configuration Examples

```json
{
  "name": "my-nwjs-app",
  "version": "1.0.0",
  "main": "src/index.html",
  "node-remote": ["http://localhost:*"],
  "webkit": {
    "plugin": true,
    "java": false,
    "page-cache": false
  },
  "window": {
    "title": "My NW.js Application",
    "icon": "assets/icon.png",
    "width": 1200,
    "height": 800,
    "min_width": 800,
    "min_height": 600,
    "position": "center",
    "resizable": true,
    "always_on_top": false,
    "fullscreen": false,
    "kiosk": false,
    "frame": true,
    "show": true,
    "show_in_taskbar": true,
    "transparent": false
  },
  "chromium-args": [
    "--disable-features=TranslateUI",
    "--disable-pinch",
    "--overscroll-history-navigation=0"
  ],
  "crash_report_url": "https://your-crash-report-server.com",
  "user-agent": "MyApp/%ver",
  "node-main": "src/background.js",
  "bg-script": "src/background.js",
  "debug": false,
  "scripts": {
    "start": "nw .",
    "dev": "nw . --debug",
    "build": "nwbuild -p win32,win64,osx64,linux32,linux64 -v 0.75.0 .",
    "test": "jest",
    "test:e2e": "playwright test"
  }
}
```

## AI Agent Decision Matrix

| Scenario                        | Recommended Approach              | Avoid                                   |
| ------------------------------- | --------------------------------- | --------------------------------------- |
| Legacy Node-Webkit migration    | NW.js for easier transition       | Complete rewrite to different framework |
| Node.js heavy desktop app       | NW.js for direct Node.js access   | Electron with complex IPC setup         |
| Small team, simple architecture | NW.js single-process model        | Electron multi-process complexity       |
| New project development         | Electron for better ecosystem     | NW.js (less active development)         |
| Security-critical application   | Native frameworks or Electron     | NW.js (shared process model)            |
| Minimal bundle size             | Neutralino or Tauri               | NW.js (includes full Chromium)          |
| Specific Chromium version needs | NW.js for version control         | Electron (limited version control)      |
| Enterprise application          | Electron with proper architecture | NW.js (limited enterprise support)      |

## Testing

### ✅ Unit Testing with Jest

```javascript
// tests/app.test.js
const NWJSApp = require('../src/main.js');

// Mock NW.js global
global.nw = {
  Window: {
    get: jest.fn(() => ({
      on: jest.fn(),
      close: jest.fn(),
      minimize: jest.fn(),
      maximize: jest.fn(),
      showDevTools: jest.fn(),
    })),
  },
  App: {
    manifest: { version: '1.0.0', debug: false },
    quit: jest.fn(),
  },
  Menu: jest.fn(() => ({
    append: jest.fn(),
  })),
  MenuItem: jest.fn(),
};

// Mock DOM
document.body.innerHTML = `
    <div id="app">
        <div id="status-text">Ready</div>
        <div id="app-version"></div>
        <textarea id="file-editor"></textarea>
        <button id="save-file-btn" disabled>Save</button>
    </div>
`;

describe('NWJSApp', () => {
  let app;

  beforeEach(() => {
    app = new NWJSApp();
    jest.clearAllMocks();
  });

  describe('Initialization', () => {
    it('should initialize the application', () => {
      expect(app).toBeDefined();
      expect(app.currentFile).toBeNull();
      expect(app.isDirty).toBe(false);
    });

    it('should setup NW.js when available', () => {
      expect(nw.Window.get).toHaveBeenCalled();
    });
  });

  describe('File Operations', () => {
    it('should create new file', async () => {
      const fileEditor = document.getElementById('file-editor');
      fileEditor.value = 'some content';
      app.isDirty = true;

      // Mock confirm dialog
      global.confirm = jest.fn(() => true);

      await app.newFile();

      expect(fileEditor.value).toBe('');
      expect(app.currentFile).toBeNull();
      expect(app.isDirty).toBe(false);
    });

    it('should update dirty state when editor content changes', () => {
      const fileEditor = document.getElementById('file-editor');

      // Simulate input event
      fileEditor.value = 'new content';
      fileEditor.dispatchEvent(new Event('input'));

      expect(app.isDirty).toBe(true);
    });
  });

  describe('Settings Management', () => {
    it('should load default settings', () => {
      expect(app.settings).toBeDefined();
      expect(typeof app.settings).toBe('object');
    });

    it('should apply theme settings', () => {
      app.applyTheme('dark');
      expect(document.body.className).toBe('dark-theme');

      app.applyTheme('light');
      expect(document.body.className).toBe('light-theme');
    });
  });

  describe('Status Management', () => {
    it('should update status text', () => {
      const statusText = document.getElementById('status-text');

      app.updateStatus('Test message');

      expect(statusText.textContent).toBe('Test message');
    });
  });
});
```

### ✅ End-to-End Testing with Playwright

```javascript
// tests/e2e/app.spec.js
const { test, expect } = require('@playwright/test');
const { spawn } = require('child_process');
const path = require('path');

test.describe('NW.js App E2E Tests', () => {
  let nwProcess;

  test.beforeAll(async () => {
    // Start NW.js application
    nwProcess = spawn('nw', ['.'], {
      cwd: path.join(__dirname, '../..'),
      stdio: 'pipe',
    });

    // Wait for app to start
    await new Promise((resolve) => setTimeout(resolve, 3000));
  });

  test.afterAll(async () => {
    if (nwProcess) {
      nwProcess.kill();
    }
  });

  test('should start the application', async ({ page }) => {
    // Connect to NW.js app (requires remote debugging)
    await page.goto('http://localhost:9222');

    await expect(page.locator('#app')).toBeVisible();
    await expect(page.locator('#status-text')).toHaveText('Ready');
  });

  test('should navigate between views', async ({ page }) => {
    await page.goto('http://localhost:9222');

    // Click on Files tab
    await page.click('a[href="#files"]');

    // Check if files view is active
    await expect(page.locator('#files-view')).toHaveClass(/active/);

    // Click on Settings tab
    await page.click('a[href="#settings"]');

    // Check if settings view is active
    await expect(page.locator('#settings-view')).toHaveClass(/active/);
  });

  test('should change theme', async ({ page }) => {
    await page.goto('http://localhost:9222');

    // Navigate to settings
    await page.click('a[href="#settings"]');

    // Change theme to dark
    await page.selectOption('#theme-select', 'dark');

    // Check if dark theme is applied
    await expect(page.locator('body')).toHaveClass('dark-theme');
  });

  test('should handle file operations', async ({ page }) => {
    await page.goto('http://localhost:9222');

    // Navigate to files view
    await page.click('a[href="#files"]');

    // Create new file
    await page.click('#create-file-btn');

    // Type in editor
    await page.fill('#file-editor', 'Test content');

    // Check if save button is enabled
    await expect(page.locator('#save-file-btn')).not.toBeDisabled();
  });
});
```

## Security Considerations

- Be aware that NW.js runs Node.js and web content in the same process context
- Validate all file paths and user inputs to prevent directory traversal attacks
- Use the `node-remote` configuration carefully to limit Node.js access
- Disable Node.js integration in child windows that load external content
- Implement proper CSP (Content Security Policy) for web content
- Avoid exposing sensitive Node.js APIs to untrusted web content
- Use HTTPS for any external web content loaded in the application
- Regular updates to NW.js framework for security patches
- Consider using iframe sandboxing for untrusted content
- Implement proper session management and data validation

## AI Agent Quick Reference

- **Project Setup**: Use NW.js CLI or npm for project initialization and dependency management
- **API Integration**: Direct Node.js access allows full system integration but requires security consideration
- **Architecture**: Single-process model simpler than Electron but less secure for complex applications
- **Development**: Use modern build tools (webpack/Vite) for better development experience
- **Testing**: Unit test with Jest, E2E test with Playwright, mock NW.js APIs for testing
- **Distribution**: Use nw-builder for cross-platform packaging and distribution
- **Security**: Careful API exposure management, input validation, and regular framework updates
- **Migration**: Good choice for Node-Webkit migration, consider Electron for new projects
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
