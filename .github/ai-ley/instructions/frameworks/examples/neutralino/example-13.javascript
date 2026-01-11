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