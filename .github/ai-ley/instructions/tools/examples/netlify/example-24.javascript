// next.config.js for Next.js on Netlify
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  trailingSlash: true,
  output: 'export',

  // Netlify specific configuration
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: '/.netlify/functions/:path*',
      },
    ];
  },

  // Environment variables
  env: {
    NETLIFY_SITE_ID: process.env.NETLIFY_SITE_ID,
    NETLIFY_ENV: process.env.CONTEXT || 'development',
  },
};

module.exports = nextConfig;