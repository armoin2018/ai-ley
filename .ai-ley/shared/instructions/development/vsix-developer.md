---
description: VS Code Extension Development - Latest Capabilities & Best Practices
applyTo: '**/*.{ts,js,json}'
priority: 90
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
```json
{
  "contributes": {
    "commands": [{
      "command": "extension.myCommand",
      "title": "My Command",
      "category": "Extension Name",
      "icon": "$(icon-id)"
    }]
  }
}
```
- **category**: Groups commands in palette
- **icon**: Shows in menus/toolbars (use product icons or custom)

### contributes.menus
Add commands to specific menus:
```json
{
  "contributes": {
    "menus": {
      "editor/context": [{
        "command": "extension.myCommand",
        "when": "editorTextFocus",
        "group": "navigation"
      }],
      "view/title": [{
        "command": "extension.refresh",
        "when": "view == myView",
        "group": "navigation"
      }],
      "commandPalette": [{
        "command": "extension.myCommand",
        "when": "editorHasSelection"
      }]
    }
  }
}
```
**Menu locations**: `editor/context`, `editor/title`, `view/title`, `view/item/context`, `explorer/context`, `scm/title`, `terminal/context`, `commandPalette`

### contributes.views
Custom views in Activity Bar or panels:
```json
{
  "contributes": {
    "views": {
      "explorer": [{
        "id": "myView",
        "name": "My View",
        "when": "workspaceHasConfig",
        "icon": "resources/icon.svg"
      }]
    }
  }
}
```
Populate with `TreeView` (hierarchical data) or `WebviewView` (HTML UI)

### contributes.viewsContainers
Custom Activity Bar sections:
```json
{
  "contributes": {
    "viewsContainers": {
      "activitybar": [{
        "id": "myContainer",
        "title": "My Container",
        "icon": "resources/icon.svg"
      }]
    }
  }
}
```

### contributes.configuration
Extension settings:
```json
{
  "contributes": {
    "configuration": {
      "title": "My Extension",
      "properties": {
        "myExt.setting": {
          "type": "string",
          "default": "value",
          "description": "Setting description",
          "scope": "resource"
        }
      }
    }
  }
}
```
**Scopes**: `application`, `machine`, `window`, `resource`

### contributes.keybindings
Default keyboard shortcuts:
```json
{
  "contributes": {
    "keybindings": [{
      "command": "extension.myCommand",
      "key": "ctrl+f1",
      "mac": "cmd+f1",
      "when": "editorTextFocus"
    }]
  }
}
```

### contributes.languages
Language support:
```json
{
  "contributes": {
    "languages": [{
      "id": "mylang",
      "extensions": [".ml"],
      "aliases": ["MyLang"],
      "configuration": "./language-configuration.json"
    }]
  }
}
```

## Multi-Workspace Support

### Best Practices
1. **Per-Workspace Services**: Store services/managers in `Map<string, Services>` keyed by workspace root path
```typescript
const workspaceServices = new Map<string, WorkspaceServices>();

function getServices(workspaceFolder: vscode.WorkspaceFolder) {
  const key = workspaceFolder.uri.fsPath;
  if (!workspaceServices.has(key)) {
    workspaceServices.set(key, createServices(workspaceFolder));
  }
  return workspaceServices.get(key)!;
}
```

2. **Scoped Configuration**: Always pass workspace folder URI
```typescript
const config = vscode.workspace.getConfiguration('myExt', workspaceFolder.uri);
```

3. **Independent Logging**: Create separate log files per workspace
```typescript
const logPath = path.join(workspaceFolder.uri.fsPath, 'extension.log');
```

4. **Workspace Lifecycle**: Handle folder add/remove
```typescript
vscode.workspace.onDidChangeWorkspaceFolders(event => {
  event.added.forEach(folder => initializeServices(folder));
  event.removed.forEach(folder => cleanupServices(folder));
});
```

## When Clauses
Control visibility/enablement based on context:
- `editorTextFocus`: Editor has focus
- `editorHasSelection`: Text selected
- `resourceLangId == javascript`: File language
- `view == myView`: Custom view visible
- `config.myExt.enabled`: Setting value

## Webviews

### Basic Webview Panel
```typescript
const panel = vscode.window.createWebviewPanel(
  'myView',
  'My Panel',
  vscode.ViewColumn.One,
  {
    enableScripts: true,
    localResourceRoots: [vscode.Uri.file(extensionPath)]
  }
);
panel.webview.html = getHtmlContent(panel.webview);
```

### Webview Views (Sidebar)
```typescript
vscode.window.registerWebviewViewProvider('myView', {
  resolveWebviewView(webviewView) {
    webviewView.webview.options = { enableScripts: true };
    webviewView.webview.html = getHtmlContent(webviewView.webview);
  }
});
```

### Security
- Use `Content-Security-Policy` in HTML
- Use `webview.asWebviewUri()` for local resources
- Validate all messages from webview

## Tree Views

### TreeDataProvider Implementation
```typescript
class MyTreeProvider implements vscode.TreeDataProvider<MyItem> {
  private _onDidChangeTreeData = new vscode.EventEmitter<MyItem | undefined>();
  readonly onDidChangeTreeData = this._onDidChangeTreeData.event;

  refresh(): void {
    this._onDidChangeTreeData.fire(undefined);
  }

  getTreeItem(element: MyItem): vscode.TreeItem {
    return element;
  }

  getChildren(element?: MyItem): Thenable<MyItem[]> {
    // Return root items or children
    return Promise.resolve(this.getData(element));
  }
}
```

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
```typescript
suite('Extension Test Suite', () => {
  test('Sample test', async () => {
    const ext = vscode.extensions.getExtension('publisher.extension');
    await ext?.activate();
    assert.ok(ext);
  });
});
```

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
```bash
vsce package
```

### Publish to Marketplace
```bash
vsce publish
```

### Version Management
- Use semantic versioning (major.minor.patch)
- Update CHANGELOG.md
- Tag releases in git

## Common Patterns

### Status Bar Progress
```typescript
vscode.window.withProgress({
  location: vscode.ProgressLocation.Notification,
  title: "Processing...",
  cancellable: true
}, async (progress, token) => {
  progress.report({ increment: 0 });
  // Do work
  progress.report({ increment: 50, message: "Halfway" });
  // More work
  progress.report({ increment: 100 });
});
```

### File System Operations
```typescript
const uri = vscode.Uri.file('/path/to/file');
const content = await vscode.workspace.fs.readFile(uri);
await vscode.workspace.fs.writeFile(uri, Buffer.from('data'));
await vscode.workspace.fs.delete(uri);
```

### Configuration Updates
```typescript
const config = vscode.workspace.getConfiguration('myExt');
await config.update('setting', value, vscode.ConfigurationTarget.Workspace);
```

### Diagnostic Collection
```typescript
const diagnostics = vscode.languages.createDiagnosticCollection('myExt');
const diag = new vscode.Diagnostic(
  range,
  'Error message',
  vscode.DiagnosticSeverity.Error
);
diagnostics.set(document.uri, [diag]);
```

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
