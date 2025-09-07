/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,

  // Enable static file serving from shared directory
  async rewrites() {
    return [
      {
        source: '/uml-flows/:path*',
        destination: '/../shared/uml-flows/:path*',
      },
    ];
  },

  // Optimize for Vercel deployment
  output: 'standalone',

  // Environment variables
  env: {
    PLANTUML_SERVER_URL: process.env.PLANTUML_SERVER_URL || 'http://localhost:8080/plantuml',
    WORKFLOWS_DIR: process.env.WORKFLOWS_DIR || '../shared/uml-flows',
  },

  // Image optimization for workflow screenshots
  images: {
    domains: ['localhost', 'ai-ley-workflows.vercel.app'],
    formats: ['image/webp', 'image/avif'],
  },

  // Headers for security
  async headers() {
    return [
      {
        source: '/api/:path*',
        headers: [
          { key: 'Access-Control-Allow-Origin', value: '*' },
          { key: 'Access-Control-Allow-Methods', value: 'GET, POST, PUT, DELETE, OPTIONS' },
          { key: 'Access-Control-Allow-Headers', value: 'Content-Type, Authorization' },
        ],
      },
    ];
  },
};

module.exports = nextConfig;
