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