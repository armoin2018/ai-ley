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