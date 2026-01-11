// tailwind.config.js - Production optimization
module.exports = {
  content: [
    // Be specific about content paths for better purging
    './src/**/*.{html,js,ts,jsx,tsx,vue,svelte}',
    './public/index.html',
  ],

  // Use safelist sparingly - only for dynamic classes
  safelist: [
    {
      pattern: /bg-(red|green|blue)-(100|500|900)/,
      variants: ['hover', 'focus'],
    },
  ],

  theme: {
    extend: {
      // Only add what you need
      colors: {
        brand: {
          50: '#eff6ff',
          500: '#3b82f6',
          900: '#1e3a8a',
        },
      },
    },
  },

  plugins: [
    // Only include plugins you actually use
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
};