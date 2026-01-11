# Debug with Node.js inspector
npx mocha --inspect-brk test/specific.test.js

# Debug with VS Code
# Add to launch.json:
{
  "type": "node",
  "request": "launch",
  "name": "Mocha Tests",
  "program": "${workspaceFolder}/node_modules/mocha/bin/_mocha",
  "args": ["--timeout", "999999", "--colors", "${workspaceFolder}/test"],
  "console": "integratedTerminal",
  "internalConsoleOptions": "neverOpen"
}