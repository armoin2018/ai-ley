// yarn.config.cjs - Workspace constraints
module.exports = {
  constraints: async ({Yarn}) => {
    // Ensure all workspaces use same TypeScript version
    for (const workspace of Yarn.workspaces()) {
      const dep = workspace.manifest.devDependencies.get('typescript');
      if (dep && dep.range !== '^5.1.6') {
        workspace.error(`TypeScript version should be ^5.1.6, got ${dep.range}`);
      }
    }

    // Ensure all workspaces have test script
    for (const workspace of Yarn.workspaces()) {
      if (!workspace.manifest.scripts.has('test')) {
        workspace.error('All workspaces must have a test script');
      }
    }
  }
};