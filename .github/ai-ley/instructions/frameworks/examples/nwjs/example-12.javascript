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