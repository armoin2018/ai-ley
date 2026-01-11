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