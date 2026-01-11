// settings.js - Main configuration file
module.exports = {
  // HTTP settings
  uiPort: process.env.PORT || 1880,
  uiHost: '0.0.0.0',

  // Runtime settings
  flowFile: 'flows.json',
  credentialSecret: process.env.NODE_RED_CREDENTIAL_SECRET || 'a-secret-key',

  // Security settings
  adminAuth: {
    type: 'credentials',
    users: [
      {
        username: 'admin',
        password: '$2b$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.',
        permissions: '*',
      },
    ],
  },

  // HTTP Node settings
  httpNodeAuth: {
    user: 'user',
    pass: '$2b$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.',
  },

  // Function node settings
  functionGlobalContext: {
    process: process,
    moment: require('moment'),
    axios: require('axios'),
  },

  // Logging
  logging: {
    console: {
      level: 'info',
      metrics: false,
      audit: false,
    },
  },

  // Editor settings
  editorTheme: {
    page: {
      title: 'My Node-RED',
      favicon: '/absolute/path/to/theme/icon',
    },
    palette: {
      theme: 'dark',
    },
  },
};