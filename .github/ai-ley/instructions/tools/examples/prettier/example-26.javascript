// vite.config.js - format during build (optional)
import { defineConfig } from 'vite';
import prettier from 'prettier';

export default defineConfig({
  plugins: [
    // Custom plugin to format during build
    {
      name: 'prettier-format',
      buildStart() {
        // Format files during build if needed
      },
    },
  ],
});