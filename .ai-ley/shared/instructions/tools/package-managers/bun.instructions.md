
# Bun JavaScript Runtime & Package Manager Instructions

## Tool Overview
- **Tool Name**: Bun
- **Version**: 1.0+ (stable), 1.0.25+ (latest with enhanced features)
- **Category**: JavaScript Runtime & Package Manager
- **Purpose**: All-in-one JavaScript runtime, bundler, test runner, and package manager
- **Prerequisites**: No dependencies (self-contained), compatible with Node.js APIs

## Installation & Setup
### Installation Methods
```bash
# Install via curl (macOS and Linux)
curl -fsSL https://bun.sh/install | bash

# Install via npm (if Node.js is available)
npm install -g bun

# Install via Homebrew (macOS)
brew tap oven-sh/bun
brew install bun

# Install via Scoop (Windows)
scoop install bun

# Install via winget (Windows)
winget install Oven-sh.Bun

# Install via Docker
docker pull oven/bun:latest

# Verify installation
bun --version
bun --help

# Update Bun
bun upgrade
```

### Project Initialization
```bash
# Create new project
mkdir my-project && cd my-project
bun init

# Initialize with specific template
bun create react-app my-react-app
bun create next-app my-next-app
bun create vite my-vite-app
bun create discord-bot my-bot

# Initialize existing project with Bun
cd existing-project
bun install                    # Creates bun.lockb

# Convert from package-lock.json or yarn.lock
rm package-lock.json yarn.lock
bun install
```

## Configuration

### bunfig.toml (Global Configuration)
```toml
# ~/.bunfig.toml or bunfig.toml in project root

[install]
# Registry configuration
registry = "https://registry.npmjs.org/"
# Alternative registries
# registry = "https://npm.pkg.github.com/"

# Package manager behavior
cache = true
exact = false
dev = true
peer = true
production = false
optional = true
lockfile = true

# Performance settings
concurrent_scripts = 10
prefer = "bun"  # or "node"

[install.scopes]
# Scoped registry configuration
"@company" = "https://npm.company.com/"
"@internal" = { url = "https://internal-registry.com/", token = "secret" }

[run]
# Script execution preferences
bun = true
silent = false
shell = "bash"

# Environment variables for scripts
[run.env]
NODE_ENV = "development"
LOG_LEVEL = "info"

[test]
# Test configuration
preload = ["./test-setup.ts"]
timeout = 30000
coverage = true

[bundler]
# Bundling configuration
target = "browser"  # or "node"
format = "esm"      # or "cjs", "iife"
minify = false
sourcemap = "external"  # or "inline", "none"

[build]
# Build settings
outdir = "./dist"
splitting = true
```

### Package.json Configuration
```json
{
  "name": "my-bun-app",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "bun --hot src/index.ts",
    "start": "bun src/index.ts",
    "build": "bun build src/index.ts --outdir=dist",
    "test": "bun test",
    "test:watch": "bun test --watch",
    "test:coverage": "bun test --coverage",
    "lint": "bun run eslint src/",
    "type-check": "bun tsc --noEmit"
  },
  "dependencies": {
    "fastify": "^4.24.0",
    "zod": "^3.22.0"
  },
  "devDependencies": {
    "@types/bun": "latest",
    "typescript": "^5.2.0",
    "eslint": "^8.53.0"
  },
  "trustedDependencies": [
    "esbuild",
    "sqlite3"
  ],
  "bun": {
    "install": {
      "production": false,
      "optional": true,
      "dev": true
    }
  }
}
```

### TypeScript Configuration for Bun
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "skipLibCheck": true,
    "lib": ["ES2022"],
    "types": ["bun-types"],
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true
  },
  "include": [
    "src/**/*",
    "test/**/*"
  ],
  "exclude": [
    "node_modules",
    "dist"
  ]
}
```

## Core Features

### Package Management
- **Purpose**: Ultra-fast package installation and management
- **Usage**: Install, update, and manage JavaScript dependencies
- **Example**:
```bash
# Install dependencies
bun install                    # Install all dependencies
bun i                         # Short form

# Install specific packages
bun add react react-dom       # Add to dependencies
bun add -d typescript         # Add to devDependencies
bun add -D @types/node        # Same as -d
bun add --optional sharp      # Add to optionalDependencies
bun add --exact lodash@4.17.21  # Install exact version

# Install from various sources
bun add github:user/repo      # GitHub repository
bun add git+ssh://git@github.com:user/repo.git  # SSH Git URL
bun add file:../local-package # Local package
bun add @scope/package@tag    # Specific tag

# Remove packages
bun remove react-router-dom   # Remove dependency
bun rm lodash                # Short form

# Update packages
bun update                    # Update all packages
bun update react             # Update specific package
bun outdated                 # Check outdated packages
```

### JavaScript Runtime
- **Purpose**: Execute JavaScript and TypeScript directly without compilation
- **Usage**: Run scripts with built-in TypeScript support and Node.js compatibility
- **Example**:
```bash
# Run JavaScript/TypeScript files
bun index.js                 # Run JavaScript
bun index.ts                 # Run TypeScript directly
bun src/server.ts           # Run with path

# Run with hot reload
bun --hot src/index.ts      # Auto-restart on changes
bun --watch src/app.ts      # Watch mode

# Run with environment variables
NODE_ENV=production bun start
bun --env-file=.env.local src/index.ts

# Execute from URL
bun https://example.com/script.js

# Execute one-liner
bun -e "console.log('Hello, Bun!')"
bun -p "Math.random()"      # Print result

# Debug mode
bun --inspect src/index.ts  # Enable debugger
bun --inspect-brk src/index.ts  # Break on start
```

### Testing Framework
- **Purpose**: Built-in test runner with Jest-compatible API
- **Usage**: Run unit tests with excellent performance and built-in mocking
- **Example**:
```bash
# Run tests
bun test                     # Run all tests
bun test --watch            # Watch mode
bun test --coverage         # Generate coverage report

# Run specific tests
bun test math.test.ts       # Run specific file
bun test --grep="addition"  # Run tests matching pattern
bun test src/              # Run tests in directory

# Test configuration and options
bun test --timeout=10000    # Set timeout
bun test --reporter=json    # JSON output
bun test --verbose          # Verbose output
bun test --silent          # Minimal output

# Example test file
// math.test.ts
import { expect, test, describe, beforeAll, afterAll } from "bun:test";

describe("Math operations", () => {
  beforeAll(() => {
    console.log("Setup tests");
  });

  test("addition", () => {
    expect(2 + 2).toBe(4);
  });

  test("async operation", async () => {
    const result = await Promise.resolve(42);
    expect(result).toBe(42);
  });
});
```

### Bundling and Building
- **Purpose**: Bundle JavaScript/TypeScript for production deployment
- **Usage**: Create optimized bundles for web and Node.js targets
- **Example**:
```bash
# Basic bundling
bun build src/index.ts --outdir=dist
bun build src/index.ts --outfile=dist/bundle.js

# Advanced bundling options
bun build src/index.ts \
  --outdir=dist \
  --target=browser \
  --format=esm \
  --minify \
  --sourcemap=external \
  --splitting

# Multiple entry points
bun build src/client.ts src/worker.ts --outdir=dist

# Node.js target
bun build src/server.ts \
  --target=node \
  --outfile=dist/server.js \
  --minify

# Library bundling
bun build src/lib.ts \
  --outdir=dist \
  --format=esm \
  --format=cjs \
  --external=react
```

## Common Commands
```bash
# Package management
bun install                  # Install dependencies
bun add <package>           # Add package
bun remove <package>        # Remove package
bun update                  # Update packages
bun outdated               # Check outdated packages

# Script execution
bun run <script>           # Run npm script
bun start                  # Run start script
bun dev                    # Run dev script
bun build                  # Run build script

# Direct execution
bun <file>                 # Run JavaScript/TypeScript file
bun --hot <file>           # Run with hot reload
bun --watch <file>         # Run with file watching

# Testing
bun test                   # Run tests
bun test --watch          # Watch mode
bun test --coverage       # Generate coverage

# Bundling
bun build <input>         # Bundle for production
bun build --watch         # Bundle with watching

# Utilities
bun create <template>     # Create new project
bun init                  # Initialize package.json
bun upgrade              # Update Bun itself
bun pm cache clear       # Clear package cache
```

## Advanced Features

### Built-in APIs
```typescript
// File system operations
import { file, write } from "bun";

// Read file
const contents = await file("./package.json").text();
const data = await file("./data.json").json();
const buffer = await file("./image.png").arrayBuffer();

// Write file
await write("output.txt", "Hello, Bun!");
await write("data.json", { key: "value" });

// Streaming
const stream = file("large-file.txt").stream();

// HTTP Server (Bun.serve)
const server = Bun.serve({
  port: 3000,
  fetch(req) {
    const url = new URL(req.url);

    if (url.pathname === "/") {
      return new Response("Hello, Bun!");
    }

    if (url.pathname === "/api/data") {
      return Response.json({ message: "API response" });
    }

    return new Response("Not Found", { status: 404 });
  },
});

console.log(`Server running on http://localhost:${server.port}`);

// WebSocket support
const server = Bun.serve({
  port: 3000,
  websocket: {
    message(ws, message) {
      console.log("Received:", message);
      ws.send(`Echo: ${message}`);
    },
    open(ws) {
      console.log("WebSocket connected");
    },
    close(ws, code, message) {
      console.log("WebSocket disconnected");
    },
  },
  fetch(req, server) {
    if (server.upgrade(req)) {
      return; // WebSocket upgrade
    }
    return new Response("Upgrade failed", { status: 500 });
  },
});
```

### Environment and Configuration
```typescript
// Environment variables
const dbUrl = Bun.env.DATABASE_URL;
const port = Bun.env.PORT || 3000;

// Process information
console.log("Bun version:", Bun.version);
console.log("Platform:", process.platform);
console.log("Args:", Bun.argv);

// Hash and crypto
const hasher = new Bun.CryptoHasher("sha256");
hasher.update("Hello, world!");
const hash = hasher.digest("hex");

// Password hashing
const password = await Bun.password.hash("secret123");
const isValid = await Bun.password.verify("secret123", password);
```

### SQLite Integration
```typescript
// Built-in SQLite database
import { Database } from "bun:sqlite";

const db = new Database("mydb.sqlite");

// Create table
db.exec(`
  CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE
  )
`);

// Prepared statements
const insertUser = db.prepare("INSERT INTO users (name, email) VALUES (?, ?)");
const getUser = db.prepare("SELECT * FROM users WHERE id = ?");

// Insert data
insertUser.run("John Doe", "john@example.com");

// Query data
const user = getUser.get(1);
console.log(user);

// Transactions
db.transaction(() => {
  insertUser.run("Jane Smith", "jane@example.com");
  insertUser.run("Bob Johnson", "bob@example.com");
})();

// Close database
db.close();
```

## Performance Optimization

### Installation Speed
```bash
# Optimize package installation
bun install --frozen-lockfile    # Don't update lockfile
bun install --ignore-scripts     # Skip postinstall scripts
bun install --production         # Skip devDependencies

# Use global cache effectively
bun pm cache clear              # Clear cache if corrupted
bun install --verbose           # Debug installation issues
```

### Runtime Performance
```typescript
// Efficient file operations
const file = Bun.file("large-file.txt");
const contents = await file.text();  // Faster than fs.readFile

// Streaming for large files
const stream = file.stream();
const reader = stream.getReader();

// Optimized HTTP responses
const server = Bun.serve({
  fetch(req) {
    // Return static files efficiently
    return new Response(Bun.file("./public/index.html"));
  }
});

// Memory-efficient JSON handling
const data = await Bun.file("large.json").json();
```

### Build Optimization
```bash
# Production bundling with optimizations
bun build src/index.ts \
  --outdir=dist \
  --minify \
  --splitting \
  --target=browser \
  --format=esm

# Tree shaking and dead code elimination
bun build src/index.ts \
  --outfile=dist/bundle.js \
  --minify \
  --external=react

# Generate source maps for debugging
bun build src/index.ts \
  --outdir=dist \
  --sourcemap=external \
  --minify
```

## Testing Patterns

### Unit Testing
```typescript
// basic.test.ts
import { expect, test, describe, beforeEach, afterEach } from "bun:test";

describe("Calculator", () => {
  let calculator: Calculator;

  beforeEach(() => {
    calculator = new Calculator();
  });

  test("should add numbers correctly", () => {
    expect(calculator.add(2, 3)).toBe(5);
  });

  test("should handle edge cases", () => {
    expect(calculator.divide(10, 0)).toThrow("Division by zero");
  });
});
```

### Async Testing
```typescript
// async.test.ts
import { expect, test, describe } from "bun:test";

describe("Async operations", () => {
  test("should handle promises", async () => {
    const result = await fetchData();
    expect(result).toHaveProperty("id");
  });

  test("should handle timeouts", async () => {
    const promise = new Promise(resolve =>
      setTimeout(() => resolve("done"), 1000)
    );

    await expect(promise).resolves.toBe("done");
  }, 2000); // 2 second timeout
});
```

### Mocking and Spying
```typescript
// mock.test.ts
import { expect, test, mock, spyOn } from "bun:test";

test("should mock functions", () => {
  const mockFn = mock((x: number) => x * 2);

  expect(mockFn(5)).toBe(10);
  expect(mockFn).toHaveBeenCalledWith(5);
  expect(mockFn).toHaveBeenCalledTimes(1);
});

test("should spy on object methods", () => {
  const obj = { method: (x: number) => x + 1 };
  const spy = spyOn(obj, "method");

  obj.method(5);

  expect(spy).toHaveBeenCalledWith(5);
});
```

## Common Patterns

### Web Server with Routing
```typescript
// server.ts
const server = Bun.serve({
  port: 3000,
  fetch(req) {
    const url = new URL(req.url);
    const { pathname } = url;

    // Static files
    if (pathname.startsWith("/static/")) {
      const filePath = `./public${pathname}`;
      return new Response(Bun.file(filePath));
    }

    // API routes
    if (pathname.startsWith("/api/")) {
      return handleAPI(req);
    }

    // SPA fallback
    return new Response(Bun.file("./public/index.html"));
  },
});

async function handleAPI(req: Request) {
  const url = new URL(req.url);

  if (url.pathname === "/api/users" && req.method === "GET") {
    return Response.json(await getUsers());
  }

  if (url.pathname === "/api/users" && req.method === "POST") {
    const user = await req.json();
    return Response.json(await createUser(user));
  }

  return new Response("Not Found", { status: 404 });
}
```

### CLI Tool Development
```typescript
#!/usr/bin/env bun
// cli.ts

import { parseArgs } from "util";

const { values, positionals } = parseArgs({
  args: Bun.argv,
  options: {
    verbose: { type: 'boolean', short: 'v' },
    output: { type: 'string', short: 'o' }
  },
  allowPositionals: true
});

if (values.verbose) {
  console.log("Verbose mode enabled");
}

const command = positionals[2]; // First positional after script name

switch (command) {
  case "build":
    await buildProject(values.output);
    break;
  case "dev":
    await startDevelopment();
    break;
  default:
    console.log("Usage: bun cli.ts [build|dev] [options]");
}
```

### Database Operations
```typescript
// db.ts
import { Database } from "bun:sqlite";

class UserRepository {
  private db: Database;

  constructor(dbPath: string) {
    this.db = new Database(dbPath);
    this.init();
  }

  private init() {
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT UNIQUE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    `);
  }

  async createUser(name: string, email: string) {
    const stmt = this.db.prepare(
      "INSERT INTO users (name, email) VALUES (?, ?)"
    );
    return stmt.run(name, email);
  }

  async getUserById(id: number) {
    const stmt = this.db.prepare("SELECT * FROM users WHERE id = ?");
    return stmt.get(id);
  }

  async getAllUsers() {
    const stmt = this.db.prepare("SELECT * FROM users ORDER BY created_at DESC");
    return stmt.all();
  }
}
```

## Environment-Specific Configuration

### Development Environment
```toml
# bunfig.toml (development)
[install]
dev = true
optional = true
production = false

[run]
bun = true
silent = false

[test]
coverage = true
watch = true
```

### Production Environment
```toml
# bunfig.toml (production)
[install]
dev = false
optional = false
production = true
exact = true

[run]
silent = true

[bundler]
minify = true
sourcemap = "none"
```

### Docker Integration
```dockerfile
# Dockerfile
FROM oven/bun:1 as dependencies
WORKDIR /app
COPY package.json bun.lockb ./
RUN bun install --frozen-lockfile

FROM oven/bun:1 as build
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .
RUN bun run build

FROM oven/bun:1 as runtime
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/package.json ./
EXPOSE 3000
CMD ["bun", "dist/index.js"]
```

## Common Issues & Solutions

### Module Resolution Issues
**Problem**: Import errors or module not found
**Solution**: Configure TypeScript and check file extensions
```typescript
// Use explicit extensions for TypeScript files
import { helper } from "./utils.ts";  // Include .ts
import config from "./config.json";   // JSON imports work

// Configure paths in tsconfig.json
{
  "compilerOptions": {
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true
  }
}
```

### Performance Issues
**Problem**: Slow startup or execution
**Solution**: Optimize imports and use Bun APIs
```typescript
// Use Bun's built-in APIs instead of Node.js equivalents
import { file } from "bun";  // Instead of fs
import { serve } from "bun";  // Instead of http

// Lazy load modules
const heavyModule = await import("./heavy-module.ts");
```

### Testing Issues
**Problem**: Tests fail or behave differently than Jest
**Solution**: Use Bun-compatible patterns
```typescript
// Use Bun test APIs
import { expect, test } from "bun:test";

// Mock modules properly
import { mock } from "bun:test";
const mockFunction = mock(() => "mocked");
```

## Integration with Development Tools

### VS Code Configuration
```json
{
  "typescript.preferences.includePackageJsonAutoImports": "on",
  "bun.runtime": "bun",
  "terminal.integrated.defaultProfile.osx": "bun",
  "typescript.suggest.paths": true
}
```

### ESLint Configuration
```javascript
module.exports = {
  env: {
    es2022: true,
    node: true,
  },
  extends: ["eslint:recommended", "@typescript-eslint/recommended"],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    ecmaVersion: 2022,
    sourceType: "module",
  },
  rules: {
    // Bun-specific rules
    "prefer-const": "error",
    "no-var": "error",
  },
};
```

## Useful Resources
- **Official Documentation**: https://bun.sh/docs
- **API Reference**: https://bun.sh/docs/api
- **Examples Repository**: https://github.com/oven-sh/bun/tree/main/examples
- **Discord Community**: https://bun.sh/discord
- **GitHub**: https://github.com/oven-sh/bun

## Tool-Specific Guidelines

### Best Practices
- Use Bun's built-in APIs when available for better performance
- Leverage TypeScript support without additional compilation
- Use the built-in test runner for fastest test execution
- Take advantage of fast bundling for production builds
- Use SQLite integration for local development databases

### Performance Tips
- Prefer Bun.file() over Node.js fs operations
- Use Bun.serve() for HTTP servers instead of Express
- Leverage built-in bundling instead of separate tools
- Use hot reload during development for faster iteration
- Take advantage of fast package installation

### Migration from Node.js
- Most Node.js APIs work out of the box
- Replace fs operations with Bun.file() for better performance
- Use Bun.serve() instead of Express for new projects
- Convert package-lock.json to bun.lockb automatically
- Update build scripts to use `bun build`

## Version Compatibility
- **Bun**: 1.0+ (stable release)
- **Node.js APIs**: Compatible with Node.js 18+ APIs
- **TypeScript**: Native support, no compilation needed
- **npm packages**: Full compatibility with npm ecosystem

## Troubleshooting

### Debug Mode
```bash
# Enable debug logging
bun --verbose install
bun --inspect src/index.ts

# Check installation issues
bun install --verbose
bun pm ls

# Test debugging
bun test --verbose
bun test --reporter=verbose

# Build debugging
bun build --verbose src/index.ts
```

### Common Error Messages
- **Error**: `Module not found`
  **Cause**: Incorrect import path or missing extension
  **Solution**: Use explicit .ts extensions, check file paths

- **Error**: `Cannot resolve module`
  **Cause**: Package not installed or wrong registry
  **Solution**: Run `bun install`, check bunfig.toml registry

- **Error**: `Permission denied`
  **Cause**: File permissions or execution rights
  **Solution**: Check file permissions, use `chmod +x`
1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions

```

```
