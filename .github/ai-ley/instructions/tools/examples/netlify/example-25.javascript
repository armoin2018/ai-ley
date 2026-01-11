// nuxt.config.ts for Nuxt.js on Netlify
export default defineNuxtConfig({
  nitro: {
    preset: 'netlify',
  },

  // Generate static site
  ssr: false,
  target: 'static',

  // Netlify specific configuration
  generate: {
    fallback: true,
  },

  // Environment variables
  runtimeConfig: {
    public: {
      apiBase: process.env.API_BASE_URL || 'http://localhost:3000',
    },
  },
});