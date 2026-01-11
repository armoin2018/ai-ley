// lint-staged.config.js - Custom tools and scripts
module.exports = {
  // Custom script for API documentation
  'src/api/**/*.js': [
    'eslint --fix',
    'prettier --write',
    'node scripts/generate-api-docs.js',
    'git add docs/api/',
  ],

  // Custom validation for configuration files
  '*.{json,yaml,yml}': (filenames) => {
    const commands = ['prettier --write'];

    filenames.forEach((filename) => {
      if (filename.endsWith('.json')) {
        commands.push(`node scripts/validate-json.js ${filename}`);
      }
      if (filename.includes('docker-compose')) {
        commands.push(`docker-compose -f ${filename} config`);
      }
    });

    return commands;
  },

  // Database migration validation
  'migrations/**/*.sql': ['node scripts/validate-migration.js', 'sql-formatter --fix'],

  // License header enforcement
  'src/**/*.{js,ts}': ['node scripts/add-license-header.js', 'eslint --fix', 'prettier --write'],
};