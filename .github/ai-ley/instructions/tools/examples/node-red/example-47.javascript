// settings.js performance configuration
module.exports = {
  // Increase Node.js memory limit
  nodeOptions: '--max-old-space-size=4096',

  // Optimize garbage collection
  runtimeState: {
    enabled: false,
    ui: false,
  },

  // Reduce logging in production
  logging: {
    console: {
      level: process.env.NODE_ENV === 'production' ? 'warn' : 'info',
      metrics: false,
      audit: false,
    },
  },

  // Connection pooling
  httpRequestTimeout: 120000,
  httpMaxRedirects: 20,

  // Context storage optimization
  contextStorage: {
    default: 'memoryOnly',
    file: {
      module: 'localfilesystem',
      config: {
        flushInterval: 30,
      },
    },
  },
};