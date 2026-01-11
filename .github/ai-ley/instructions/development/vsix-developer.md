---
name: 'vsix-developer'
description: 'VS Code Extension Development - Latest Capabilities & Best Practices'
keywords: [api, basic, async, accessibility, (sidebar), bundling, (lsp), architecture, activation, benefits]
---


# VS Code Extension Development Guide

## Core Architecture

### Extension Entry Points
- **Activation**: Extensions activate via `activationEvents` in package.json
  - `onStartupFinished`: Activate after VS Code starts (recommended for most extensions)
  - `onLanguage:${languageId}`: Activate when specific language files open
  - `onCommand:${commandId}`: Activate when command invoked (auto-generated from contributes.commands)
  - `onView:${viewId}`: Activate when custom view becomes visible
  - `onFileSystem:${scheme}`: Activate when files from specific scheme accessed

### Extension Lifecycle
- **activate(context)**: Called when extension activates
  - Register all commands, providers, event listeners
  - Store subscriptions in `context.subscriptions` for cleanup
  - Return public API for other extensions (optional)
- **deactivate()**: Called on shutdown (optional)
  - Clean up resources, stop processes
  - Dispose all registered services

## API Namespaces

### window namespace
**Purpose**: UI interactions, editors, terminals, notifications
- `window.createStatusBarItem()`: Add status bar indicators
- `window.showInformationMessage()`: Display notifications
- `window.createTreeView()`: Create custom tree views
- `window.createWebviewPanel()`: Create webview-based UIs
- `window.createTerminal()`: Create integrated terminals
- `window.registerTreeDataProvider()`: Provide tree data
- `window.registerCustomEditorProvider()`: Custom file editors

### workspace namespace
**Purpose**: Workspace folders, configuration, file system
- `workspace.workspaceFolders`: Array of open workspace folders
- `workspace.getConfiguration()`: Read extension/workspace settings
  - **Multi-root**: Pass workspace folder URI for scoped config
- `workspace.onDidChangeWorkspaceFolders`: Workspace add/remove events
- `workspace.fs`: File system API (read/write/delete files)
- `workspace.getWorkspaceFolder(uri)`: Get folder containing URI
- `workspace.onDidChangeConfiguration`: Config change events

### commands namespace
**Purpose**: Command registration and execution
- `commands.registerCommand(id, callback)`: Register command handler
- `commands.executeCommand(id, ...args)`: Invoke any command
- `commands.registerTextEditorCommand()`: Editor-specific commands

### languages namespace
**Purpose**: Language features and providers
- `languages.registerHoverProvider()`: Show hover tooltips
- `languages.registerCompletionItemProvider()`: IntelliSense suggestions
- `languages.registerCodeActionsProvider()`: Quick fixes/refactorings
- `languages.registerDefinitionProvider()`: Go to definition
- `languages.createDiagnosticCollection()`: Report errors/warnings
- `languages.registerDocumentFormattingEditProvider()`: Format documents

### tasks namespace
**Purpose**: Task execution and management
- `tasks.registerTaskProvider()`: Provide custom tasks
- `tasks.executeTask()`: Run tasks programmatically
- `tasks.onDidStartTask`: Task lifecycle events

### debug namespace
**Purpose**: Debugging functionality
- `debug.registerDebugAdapterDescriptorFactory()`: Register debugger
- `debug.startDebugging()`: Start debug sessions
- `debug.onDidStartDebugSession`: Debug lifecycle events

### scm namespace
**Purpose**: Source control management
- `scm.createSourceControl()`: Register SCM provider
- Enables custom source control integrations

### tests namespace
**Purpose**: Test explorer integration
- `tests.createTestController()`: Register test provider
- Enable test discovery, execution, debugging

## Contribution Points

### contributes.commands
Define commands shown in Command Palette:
See [example-1](./examples/vsix-developer/example-1.json)
- **category**: Groups commands in palette
- **icon**: Shows in menus/toolbars (use product icons or custom)

### contributes.menus
Add commands to specific menus:
See [example-2](./examples/vsix-developer/example-2.json)
**Menu locations**: `editor/context`, `editor/title`, `view/title`, `view/item/context`, `explorer/context`, `scm/title`, `terminal/context`, `commandPalette`

### contributes.views
Custom views in Activity Bar or panels:
See [example-3](./examples/vsix-developer/example-3.json)
Populate with `TreeView` (hierarchical data) or `WebviewView` (HTML UI)

### contributes.viewsContainers
Custom Activity Bar sections:
See [example-4](./examples/vsix-developer/example-4.json)

### contributes.configuration
Extension settings:
See [example-5](./examples/vsix-developer/example-5.json)
**Scopes**: `application`, `machine`, `window`, `resource`

### contributes.keybindings
Default keyboard shortcuts:
See [example-6](./examples/vsix-developer/example-6.json)

### contributes.languages
Language support:
See [example-7](./examples/vsix-developer/example-7.json)

## Multi-Workspace Support

### Best Practices
1. **Per-Workspace Services**: Store services/managers in `Map<string, Services>` keyed by workspace root path
See [example-8](./examples/vsix-developer/example-8.typescript)

2. **Scoped Configuration**: Always pass workspace folder URI
See [example-9](./examples/vsix-developer/example-9.typescript)

3. **Independent Logging**: Create separate log files per workspace
See [example-10](./examples/vsix-developer/example-10.typescript)

4. **Workspace Lifecycle**: Handle folder add/remove
See [example-11](./examples/vsix-developer/example-11.typescript)

## When Clauses
Control visibility/enablement based on context:
- `editorTextFocus`: Editor has focus
- `editorHasSelection`: Text selected
- `resourceLangId == javascript`: File language
- `view == myView`: Custom view visible
- `config.myExt.enabled`: Setting value

## Webviews

### Basic Webview Panel
See [example-12](./examples/vsix-developer/example-12.typescript)

### Webview Views (Sidebar)
See [example-13](./examples/vsix-developer/example-13.typescript)

### Security
- Use `Content-Security-Policy` in HTML
- Use `webview.asWebviewUri()` for local resources
- Validate all messages from webview

## Tree Views

### TreeDataProvider Implementation
See [example-14](./examples/vsix-developer/example-14.typescript)

## Language Server Protocol (LSP)

### Benefits
- Runs in separate process (better performance)
- Reusable across editors
- Handles cancellation, diagnostics automatically

### Basic Setup
1. Extension activates language client
2. Client spawns language server process
3. Server provides language features via LSP

## Testing

### Extension Tests
See [example-15](./examples/vsix-developer/example-15.typescript)

### Test Configuration
- Place tests in `src/test/` directory
- Use Mocha test framework
- Run with `vscode-test` package

## Performance Guidelines

### Activation Time
- Minimize work in `activate()`
- Use lazy initialization
- Defer heavy operations until needed

### Extension Host
- Extensions run in separate process from UI
- No DOM access (use webviews for custom UI)
- Async operations preferred

### Bundling
- Use webpack/esbuild to bundle extension
- Reduces file count and load time
- Configure in `.vscode/launch.json`

## Publishing

### Package Extension
See [example-16](./examples/vsix-developer/example-16.bash)

### Publish to Marketplace
See [example-17](./examples/vsix-developer/example-17.bash)

### Version Management
- Use semantic versioning (major.minor.patch)
- Update CHANGELOG.md
- Tag releases in git

## Common Patterns

### Status Bar Progress
See [example-18](./examples/vsix-developer/example-18.typescript)

### File System Operations
See [example-19](./examples/vsix-developer/example-19.typescript)

### Configuration Updates
See [example-20](./examples/vsix-developer/example-20.typescript)

### Diagnostic Collection
See [example-21](./examples/vsix-developer/example-21.typescript)

## Security Best Practices

1. **Input Validation**: Always validate user input and external data
2. **Command Arguments**: Validate all command arguments
3. **Webview Content**: Use CSP, sanitize HTML
4. **File Access**: Validate paths, prevent path traversal
5. **Network Requests**: Validate URLs, use HTTPS
6. **Secrets**: Use `SecretStorage` API for sensitive data

## Accessibility

- Use semantic HTML in webviews
- Provide aria labels for custom UI
- Support keyboard navigation
- Test with screen readers
- Follow VS Code color theme (use ThemeColor API)

## Resources

- **API Reference**: https://code.visualstudio.com/api/references/vscode-api
- **Extension Guides**: https://code.visualstudio.com/api/extension-guides/overview
- **Sample Extensions**: https://github.com/microsoft/vscode-extension-samples
- **Publishing**: https://code.visualstudio.com/api/working-with-extensions/publishing-extension

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
