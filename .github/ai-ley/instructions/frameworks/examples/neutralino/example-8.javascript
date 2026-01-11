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