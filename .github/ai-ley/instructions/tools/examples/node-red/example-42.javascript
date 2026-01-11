// settings.js security configuration
module.exports = {
  adminAuth: {
    type: 'credentials',
    users: [
      {
        username: 'admin',
        password: '$2b$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.',
        permissions: '*',
      },
    ],
    sessionExpiryTime: 86400, // 24 hours
    tokens: {
      expiresIn: '7d',
    },
  },

  // HTTP endpoint authentication
  httpNodeAuth: {
    user: 'api-user',
    pass: '$2b$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.',
  },

  // HTTPS configuration
  https: {
    key: require('fs').readFileSync('private-key.pem'),
    cert: require('fs').readFileSync('certificate.pem'),
  },
};