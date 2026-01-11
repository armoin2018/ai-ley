// vite.config.js
export default defineConfig({
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `@import "@/styles/variables.scss";`,
        includePaths: ['node_modules'],
      },
    },
    modules: {
      generateScopedName: '[name]__[local]___[hash:base64:5]',
    },
  },
})

// Usage in components
import styles from './Component.module.css'  // CSS Modules
import './Component.scss'                    // Global styles