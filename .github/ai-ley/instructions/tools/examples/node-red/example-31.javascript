// Environment switching function
const loadEnvironmentFlows = (environment) => {
  const fs = require('fs');
  const path = require('path');

  const flowsFile = path.join(__dirname, 'flows', `${environment}.json`);
  const settingsFile = path.join(__dirname, 'settings', `${environment}.js`);

  process.env.NODE_RED_FLOWS = flowsFile;
  process.env.NODE_RED_SETTINGS = settingsFile;
};

// Usage
const env = process.env.NODE_ENV || 'development';
loadEnvironmentFlows(env);