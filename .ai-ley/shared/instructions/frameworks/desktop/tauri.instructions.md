---
applyTo: 'tauri, @tauri-apps'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Tauri 2.0+ for lightweight native desktop applications'
---

# Tauri Framework Instructions for AI Agents

## When to Use Tauri

Use Tauri when you need:

- Lightweight desktop applications with minimal resource usage
- Native performance with web frontend technologies
- Strong security with Rust backend and isolated frontend
- Small application bundle sizes (under 10MB vs 100MB+ for Electron)
- Cross-platform desktop apps with platform-specific optimizations
- Applications requiring deep system integration with security
- Modern web frontend (React, Vue, Svelte) with native backend capabilities

## When to Avoid Tauri

Consider alternatives when:

- Team has no Rust experience and complex backend requirements
- Need extensive Node.js ecosystem integration
- Building simple web-only applications
- Require mature ecosystem with extensive plugins (use Electron)
- Working with legacy web technologies or IE compatibility
- Need rapid prototyping without backend development
- Complex multimedia processing requiring specialized libraries

## Framework Overview

- **Framework**: Tauri 2.0+
- **Type**: Native desktop application framework with web frontend
- **Architecture**: Rust backend + Web frontend with secure IPC bridge
- **Language**: Rust (backend) + JavaScript/TypeScript (frontend)
- **Use Cases**: Native desktop apps, system tools, secure applications, performance-critical desktop software

## Installation & Setup

### ✅ Recommended: Tauri CLI with Frontend Framework

```bash
# Install Rust (prerequisite)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install Tauri CLI
cargo install tauri-cli

# Create new Tauri app with React
npm create tauri-app@latest my-app
cd my-app

# Or with specific frontend
npm create tauri-app@latest my-app -- --template react-ts
npm create tauri-app@latest my-app -- --template vue-ts
npm create tauri-app@latest my-app -- --template svelte-ts
npm create tauri-app@latest my-app -- --template vanilla-ts

# Install dependencies and start development
npm install
npm run tauri dev
```

### ✅ Alternative: Add Tauri to Existing Frontend

```bash
# Navigate to existing frontend project
cd my-existing-app

# Install Tauri CLI and initialize
npm install --save-dev @tauri-apps/cli
npx tauri init

# Install Tauri API
npm install @tauri-apps/api

# Configure tauri.conf.json
# Start development
npm run tauri dev
```

### AI Agent Decision Tree

- **For new projects**: Use create-tauri-app with TypeScript template
- **For existing web apps**: Add Tauri incrementally with minimal changes
- **For performance-critical apps**: Choose Tauri over Electron
- **For security-focused apps**: Leverage Rust's memory safety and Tauri's security model
- **For lightweight distribution**: Tauri provides significantly smaller bundle sizes

## Project Structure

### ✅ Tauri Project Structure

```
tauri-app/
├── src-tauri/                # Rust backend
│   ├── src/
│   │   ├── main.rs          # Main Rust application
│   │   ├── lib.rs           # Library exports
│   │   ├── commands.rs      # Tauri commands (IPC handlers)
│   │   ├── menu.rs          # Application menu
│   │   ├── setup.rs         # Application setup
│   │   └── utils.rs         # Utility functions
│   ├── Cargo.toml           # Rust dependencies
│   ├── tauri.conf.json      # Tauri configuration
│   ├── build.rs             # Build script
│   └── icons/               # Application icons
├── src/                     # Frontend source (React/Vue/Svelte)
│   ├── components/
│   ├── services/
│   ├── utils/
│   ├── App.tsx
│   ├── main.tsx
│   └── styles/
├── public/                  # Static assets
├── dist/                    # Built frontend
├── package.json             # Frontend dependencies
├── tsconfig.json            # TypeScript configuration
└── vite.config.ts          # Vite configuration
```

### ✅ Advanced Project Structure

```
enterprise-tauri-app/
├── src-tauri/
│   ├── src/
│   │   ├── main.rs
│   │   ├── commands/        # Organized command modules
│   │   │   ├── mod.rs
│   │   │   ├── file_ops.rs
│   │   │   ├── system_info.rs
│   │   │   └── database.rs
│   │   ├── services/        # Business logic services
│   │   │   ├── mod.rs
│   │   │   ├── auth.rs
│   │   │   ├── storage.rs
│   │   │   └── network.rs
│   │   ├── models/          # Data models
│   │   │   ├── mod.rs
│   │   │   ├── user.rs
│   │   │   └── settings.rs
│   │   ├── utils/           # Utility modules
│   │   │   ├── mod.rs
│   │   │   ├── crypto.rs
│   │   │   └── logger.rs
│   │   └── errors.rs        # Custom error types
│   ├── migrations/          # Database migrations
│   ├── templates/           # Code generation templates
│   └── tests/               # Rust tests
├── src/                     # Frontend (TypeScript/React)
│   ├── components/
│   │   ├── ui/              # Reusable UI components
│   │   ├── forms/           # Form components
│   │   └── layout/          # Layout components
│   ├── hooks/               # Custom React hooks
│   ├── services/            # Frontend services
│   ├── stores/              # State management
│   ├── types/               # TypeScript types
│   ├── utils/               # Frontend utilities
│   └── __tests__/           # Frontend tests
├── docs/                    # Documentation
├── scripts/                 # Build and utility scripts
└── .github/                 # GitHub workflows
```

## Core Concepts

### Tauri Commands (IPC Bridge)

✅ **Best Practice**: Type-safe communication between Rust backend and frontend

```rust
// src-tauri/src/commands/file_ops.rs
use tauri::{command, State, Window};
use serde::{Deserialize, Serialize};
use std::fs;
use std::path::PathBuf;

#[derive(Debug, Serialize, Deserialize)]
pub struct FileInfo {
    pub name: String,
    pub path: String,
    pub size: u64,
    pub modified: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct SaveRequest {
    pub path: String,
    pub content: String,
}

#[derive(Debug, Serialize)]
pub struct CommandResult<T> {
    pub success: bool,
    pub data: Option<T>,
    pub error: Option<String>,
}

impl<T> CommandResult<T> {
    pub fn success(data: T) -> Self {
        Self {
            success: true,
            data: Some(data),
            error: None,
        }
    }

    pub fn error(message: String) -> Self {
        Self {
            success: false,
            data: None,
            error: Some(message),
        }
    }
}

#[command]
pub async fn read_file(path: String) -> Result<CommandResult<String>, String> {
    match fs::read_to_string(&path) {
        Ok(content) => Ok(CommandResult::success(content)),
        Err(e) => Ok(CommandResult::error(format!("Failed to read file: {}", e))),
    }
}

#[command]
pub async fn write_file(request: SaveRequest) -> Result<CommandResult<()>, String> {
    match fs::write(&request.path, &request.content) {
        Ok(_) => Ok(CommandResult::success(())),
        Err(e) => Ok(CommandResult::error(format!("Failed to write file: {}", e))),
    }
}

#[command]
pub async fn get_file_info(path: String) -> Result<CommandResult<FileInfo>, String> {
    let path_buf = PathBuf::from(&path);

    match fs::metadata(&path_buf) {
        Ok(metadata) => {
            let file_info = FileInfo {
                name: path_buf
                    .file_name()
                    .unwrap_or_default()
                    .to_string_lossy()
                    .to_string(),
                path: path.clone(),
                size: metadata.len(),
                modified: format!("{:?}", metadata.modified().unwrap_or(std::time::UNIX_EPOCH)),
            };
            Ok(CommandResult::success(file_info))
        }
        Err(e) => Ok(CommandResult::error(format!("Failed to get file info: {}", e))),
    }
}

#[command]
pub async fn list_directory(path: String) -> Result<CommandResult<Vec<FileInfo>>, String> {
    match fs::read_dir(&path) {
        Ok(entries) => {
            let mut files = Vec::new();

            for entry in entries {
                if let Ok(entry) = entry {
                    let path = entry.path();
                    if let Ok(metadata) = entry.metadata() {
                        let file_info = FileInfo {
                            name: entry.file_name().to_string_lossy().to_string(),
                            path: path.to_string_lossy().to_string(),
                            size: metadata.len(),
                            modified: format!("{:?}",
                                metadata.modified().unwrap_or(std::time::UNIX_EPOCH)
                            ),
                        };
                        files.push(file_info);
                    }
                }
            }

            files.sort_by(|a, b| a.name.cmp(&b.name));
            Ok(CommandResult::success(files))
        }
        Err(e) => Ok(CommandResult::error(format!("Failed to list directory: {}", e))),
    }
}

#[command]
pub async fn open_file_dialog(window: Window) -> Result<CommandResult<String>, String> {
    use tauri::api::dialog::FileDialogBuilder;

    let file_path = FileDialogBuilder::new()
        .add_filter("Text files", &["txt", "md", "json"])
        .add_filter("All files", &["*"])
        .pick_file();

    match file_path {
        Some(path) => Ok(CommandResult::success(path.to_string_lossy().to_string())),
        None => Ok(CommandResult::error("No file selected".to_string())),
    }
}

#[command]
pub async fn save_file_dialog(window: Window) -> Result<CommandResult<String>, String> {
    use tauri::api::dialog::FileDialogBuilder;

    let file_path = FileDialogBuilder::new()
        .add_filter("Text files", &["txt", "md"])
        .save_file();

    match file_path {
        Some(path) => Ok(CommandResult::success(path.to_string_lossy().to_string())),
        None => Ok(CommandResult::error("No file selected".to_string())),
    }
}
```

### Application State Management

✅ **Best Practice**: Rust-based state management with thread-safe access

```rust
// src-tauri/src/services/app_state.rs
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::sync::{Arc, Mutex};
use tauri::{command, State};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AppSettings {
    pub theme: String,
    pub language: String,
    pub auto_save: bool,
    pub recent_files: Vec<String>,
}

impl Default for AppSettings {
    fn default() -> Self {
        Self {
            theme: "dark".to_string(),
            language: "en".to_string(),
            auto_save: true,
            recent_files: Vec::new(),
        }
    }
}

#[derive(Debug)]
pub struct AppState {
    pub settings: Arc<Mutex<AppSettings>>,
    pub cache: Arc<Mutex<HashMap<String, String>>>,
}

impl AppState {
    pub fn new() -> Self {
        Self {
            settings: Arc::new(Mutex::new(AppSettings::default())),
            cache: Arc::new(Mutex::new(HashMap::new())),
        }
    }

    pub fn load_settings(&self) -> Result<AppSettings, String> {
        // Load settings from file or database
        let settings_path = tauri::api::path::app_data_dir(&tauri::Config::default())
            .ok_or("Failed to get app data directory")?
            .join("settings.json");

        if settings_path.exists() {
            let content = std::fs::read_to_string(&settings_path)
                .map_err(|e| format!("Failed to read settings: {}", e))?;

            let settings: AppSettings = serde_json::from_str(&content)
                .map_err(|e| format!("Failed to parse settings: {}", e))?;

            *self.settings.lock().unwrap() = settings.clone();
            Ok(settings)
        } else {
            Ok(AppSettings::default())
        }
    }

    pub fn save_settings(&self, settings: &AppSettings) -> Result<(), String> {
        let settings_path = tauri::api::path::app_data_dir(&tauri::Config::default())
            .ok_or("Failed to get app data directory")?
            .join("settings.json");

        // Create directory if it doesn't exist
        if let Some(parent) = settings_path.parent() {
            std::fs::create_dir_all(parent)
                .map_err(|e| format!("Failed to create settings directory: {}", e))?;
        }

        let content = serde_json::to_string_pretty(settings)
            .map_err(|e| format!("Failed to serialize settings: {}", e))?;

        std::fs::write(&settings_path, content)
            .map_err(|e| format!("Failed to write settings: {}", e))?;

        *self.settings.lock().unwrap() = settings.clone();
        Ok(())
    }
}

#[command]
pub async fn get_settings(state: State<'_, AppState>) -> Result<AppSettings, String> {
    state.load_settings()
}

#[command]
pub async fn update_settings(
    settings: AppSettings,
    state: State<'_, AppState>,
) -> Result<(), String> {
    state.save_settings(&settings)
}

#[command]
pub async fn add_recent_file(
    file_path: String,
    state: State<'_, AppState>,
) -> Result<(), String> {
    let mut current_settings = state.load_settings()?;

    // Remove if already exists
    current_settings.recent_files.retain(|f| f != &file_path);

    // Add to front
    current_settings.recent_files.insert(0, file_path);

    // Keep only last 10 files
    current_settings.recent_files.truncate(10);

    state.save_settings(&current_settings)
}

#[command]
pub async fn clear_recent_files(state: State<'_, AppState>) -> Result<(), String> {
    let mut current_settings = state.load_settings()?;
    current_settings.recent_files.clear();
    state.save_settings(&current_settings)
}
```

### Main Application Setup

✅ **Best Practice**: Comprehensive application initialization with error handling

```rust
// src-tauri/src/main.rs
#![cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

mod commands;
mod services;
mod utils;

use commands::file_ops::*;
use commands::system_info::*;
use services::app_state::{AppState, get_settings, update_settings, add_recent_file, clear_recent_files};
use tauri::{CustomMenuItem, Manager, Menu, MenuItem, Submenu, Window, WindowEvent};

fn create_menu() -> Menu {
    let file_menu = Submenu::new(
        "File",
        Menu::new()
            .add_item(CustomMenuItem::new("new", "New").accelerator("CmdOrCtrl+N"))
            .add_item(CustomMenuItem::new("open", "Open").accelerator("CmdOrCtrl+O"))
            .add_item(CustomMenuItem::new("save", "Save").accelerator("CmdOrCtrl+S"))
            .add_item(CustomMenuItem::new("save_as", "Save As").accelerator("CmdOrCtrl+Shift+S"))
            .add_native_item(MenuItem::Separator)
            .add_item(CustomMenuItem::new("quit", "Quit").accelerator("CmdOrCtrl+Q")),
    );

    let edit_menu = Submenu::new(
        "Edit",
        Menu::new()
            .add_native_item(MenuItem::Undo)
            .add_native_item(MenuItem::Redo)
            .add_native_item(MenuItem::Separator)
            .add_native_item(MenuItem::Cut)
            .add_native_item(MenuItem::Copy)
            .add_native_item(MenuItem::Paste)
            .add_native_item(MenuItem::SelectAll),
    );

    let view_menu = Submenu::new(
        "View",
        Menu::new()
            .add_item(CustomMenuItem::new("toggle_devtools", "Toggle DevTools"))
            .add_item(CustomMenuItem::new("reload", "Reload").accelerator("CmdOrCtrl+R"))
            .add_native_item(MenuItem::Separator)
            .add_item(CustomMenuItem::new("zoom_in", "Zoom In").accelerator("CmdOrCtrl+Plus"))
            .add_item(CustomMenuItem::new("zoom_out", "Zoom Out").accelerator("CmdOrCtrl+-"))
            .add_item(CustomMenuItem::new("reset_zoom", "Reset Zoom").accelerator("CmdOrCtrl+0")),
    );

    Menu::new()
        .add_submenu(file_menu)
        .add_submenu(edit_menu)
        .add_submenu(view_menu)
}

fn handle_menu_event(event_id: &str, window: &Window) {
    match event_id {
        "new" => {
            window.emit("menu:new", {}).unwrap();
        }
        "open" => {
            window.emit("menu:open", {}).unwrap();
        }
        "save" => {
            window.emit("menu:save", {}).unwrap();
        }
        "save_as" => {
            window.emit("menu:save_as", {}).unwrap();
        }
        "quit" => {
            std::process::exit(0);
        }
        "toggle_devtools" => {
            if window.is_devtools_open() {
                window.close_devtools();
            } else {
                window.open_devtools();
            }
        }
        "reload" => {
            window.eval("location.reload()").unwrap();
        }
        "zoom_in" => {
            window.eval("document.body.style.zoom = (parseFloat(document.body.style.zoom || '1') + 0.1).toString()").unwrap();
        }
        "zoom_out" => {
            window.eval("document.body.style.zoom = (parseFloat(document.body.style.zoom || '1') - 0.1).toString()").unwrap();
        }
        "reset_zoom" => {
            window.eval("document.body.style.zoom = '1'").unwrap();
        }
        _ => {}
    }
}

fn main() {
    let app_state = AppState::new();

    tauri::Builder::default()
        .menu(create_menu())
        .manage(app_state)
        .invoke_handler(tauri::generate_handler![
            // File operations
            read_file,
            write_file,
            get_file_info,
            list_directory,
            open_file_dialog,
            save_file_dialog,
            // Settings
            get_settings,
            update_settings,
            add_recent_file,
            clear_recent_files,
            // System info
            get_system_info,
            get_memory_usage,
            get_cpu_usage,
        ])
        .setup(|app| {
            let window = app.get_window("main").unwrap();

            // Load and apply saved window state
            if let Ok(app_state) = app.state::<AppState>().load_settings() {
                println!("Loaded app settings: {:?}", app_state);
            }

            // Set minimum window size
            window.set_min_size(Some(tauri::Size::Physical(tauri::PhysicalSize {
                width: 800,
                height: 600,
            }))).unwrap();

            Ok(())
        })
        .on_menu_event(|event| {
            handle_menu_event(&event.menu_item_id(), &event.window());
        })
        .on_window_event(|event| {
            match event.event() {
                WindowEvent::CloseRequested { api, .. } => {
                    // Handle unsaved changes
                    event.window().emit("window:close-requested", {}).unwrap();
                    api.prevent_close();
                }
                WindowEvent::Resized(_) => {
                    // Save window state
                }
                _ => {}
            }
        })
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
```

### Frontend Integration with TypeScript

✅ **Best Practice**: Type-safe frontend communication with Rust backend

```typescript
// src/services/tauri-api.ts
import { invoke } from '@tauri-apps/api/tauri';
import { listen } from '@tauri-apps/api/event';

export interface FileInfo {
  name: string;
  path: string;
  size: number;
  modified: string;
}

export interface SaveRequest {
  path: string;
  content: string;
}

export interface CommandResult<T> {
  success: boolean;
  data?: T;
  error?: string;
}

export interface AppSettings {
  theme: string;
  language: string;
  auto_save: boolean;
  recent_files: string[];
}

export class TauriAPI {
  // File operations
  static async readFile(path: string): Promise<CommandResult<string>> {
    return await invoke('read_file', { path });
  }

  static async writeFile(request: SaveRequest): Promise<CommandResult<void>> {
    return await invoke('write_file', { request });
  }

  static async getFileInfo(path: string): Promise<CommandResult<FileInfo>> {
    return await invoke('get_file_info', { path });
  }

  static async listDirectory(path: string): Promise<CommandResult<FileInfo[]>> {
    return await invoke('list_directory', { path });
  }

  static async openFileDialog(): Promise<CommandResult<string>> {
    return await invoke('open_file_dialog');
  }

  static async saveFileDialog(): Promise<CommandResult<string>> {
    return await invoke('save_file_dialog');
  }

  // Settings management
  static async getSettings(): Promise<AppSettings> {
    return await invoke('get_settings');
  }

  static async updateSettings(settings: AppSettings): Promise<void> {
    return await invoke('update_settings', { settings });
  }

  static async addRecentFile(filePath: string): Promise<void> {
    return await invoke('add_recent_file', { filePath });
  }

  static async clearRecentFiles(): Promise<void> {
    return await invoke('clear_recent_files');
  }

  // Event listeners
  static async onMenuAction(callback: (action: string) => void) {
    const unlisten = await listen('menu:new', () => callback('new'));
    const unlisten2 = await listen('menu:open', () => callback('open'));
    const unlisten3 = await listen('menu:save', () => callback('save'));
    const unlisten4 = await listen('menu:save_as', () => callback('save_as'));

    return () => {
      unlisten();
      unlisten2();
      unlisten3();
      unlisten4();
    };
  }

  static async onWindowCloseRequested(callback: () => void) {
    return await listen('window:close-requested', callback);
  }
}
```

### React Component Integration

✅ **Best Practice**: React hooks for Tauri integration with error handling

```typescript
// src/hooks/useTauriFile.ts
import { useState, useCallback } from 'react';
import { TauriAPI, FileInfo } from '../services/tauri-api';

interface FileState {
  currentFile: string | null;
  content: string;
  hasUnsavedChanges: boolean;
  isLoading: boolean;
  error: string | null;
}

export const useTauriFile = () => {
  const [state, setState] = useState<FileState>({
    currentFile: null,
    content: '',
    hasUnsavedChanges: false,
    isLoading: false,
    error: null,
  });

  const setError = useCallback((error: string | null) => {
    setState((prev) => ({ ...prev, error }));
  }, []);

  const setLoading = useCallback((isLoading: boolean) => {
    setState((prev) => ({ ...prev, isLoading }));
  }, []);

  const openFile = useCallback(async (): Promise<boolean> => {
    setLoading(true);
    setError(null);

    try {
      const dialogResult = await TauriAPI.openFileDialog();

      if (!dialogResult.success || !dialogResult.data) {
        setLoading(false);
        return false;
      }

      const filePath = dialogResult.data;
      const readResult = await TauriAPI.readFile(filePath);

      if (!readResult.success || readResult.data === undefined) {
        setError(readResult.error || 'Failed to read file');
        setLoading(false);
        return false;
      }

      setState((prev) => ({
        ...prev,
        currentFile: filePath,
        content: readResult.data!,
        hasUnsavedChanges: false,
        isLoading: false,
        error: null,
      }));

      await TauriAPI.addRecentFile(filePath);
      return true;
    } catch (error) {
      setError(`Failed to open file: ${error}`);
      setLoading(false);
      return false;
    }
  }, []);

  const saveFile = useCallback(
    async (saveAs = false): Promise<boolean> => {
      setLoading(true);
      setError(null);

      try {
        let filePath = state.currentFile;

        if (!filePath || saveAs) {
          const dialogResult = await TauriAPI.saveFileDialog();

          if (!dialogResult.success || !dialogResult.data) {
            setLoading(false);
            return false;
          }

          filePath = dialogResult.data;
        }

        const saveResult = await TauriAPI.writeFile({
          path: filePath,
          content: state.content,
        });

        if (!saveResult.success) {
          setError(saveResult.error || 'Failed to save file');
          setLoading(false);
          return false;
        }

        setState((prev) => ({
          ...prev,
          currentFile: filePath,
          hasUnsavedChanges: false,
          isLoading: false,
          error: null,
        }));

        if (filePath) {
          await TauriAPI.addRecentFile(filePath);
        }

        return true;
      } catch (error) {
        setError(`Failed to save file: ${error}`);
        setLoading(false);
        return false;
      }
    },
    [state.currentFile, state.content],
  );

  const newFile = useCallback(() => {
    setState({
      currentFile: null,
      content: '',
      hasUnsavedChanges: false,
      isLoading: false,
      error: null,
    });
  }, []);

  const updateContent = useCallback((content: string) => {
    setState((prev) => ({
      ...prev,
      content,
      hasUnsavedChanges: prev.content !== content,
    }));
  }, []);

  return {
    ...state,
    openFile,
    saveFile,
    newFile,
    updateContent,
    setError,
  };
};
```

## Best Practices

### ✅ Do's

- Use Rust's ownership system for memory safety and performance
- Implement proper error handling with Result types in Rust
- Use Tauri's secure IPC system with type-safe commands
- Leverage Rust's ecosystem for backend functionality
- Implement proper logging and debugging capabilities
- Use TypeScript for frontend type safety
- Follow Rust naming conventions and idiomatic patterns
- Implement comprehensive testing for both Rust and frontend code

### ❌ Don'ts

- Don't expose unsafe Rust operations to the frontend
- Don't ignore Rust's borrowing rules and lifetime management
- Don't use unwrap() extensively in production code
- Don't skip error handling in IPC communication
- Don't ignore Tauri's security model and CSP requirements
- Don't forget to handle cross-platform differences
- Don't skip code signing for production releases
- Don't ignore bundle size optimization opportunities

### Security and Performance

```rust
// src-tauri/src/utils/security.rs
use tauri::{command, Window};
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct SecurityConfig {
    pub allowed_domains: Vec<String>,
    pub max_file_size: usize,
    pub allowed_extensions: Vec<String>,
}

impl Default for SecurityConfig {
    fn default() -> Self {
        Self {
            allowed_domains: vec!["https://api.yourdomain.com".to_string()],
            max_file_size: 10 * 1024 * 1024, // 10MB
            allowed_extensions: vec![
                "txt".to_string(),
                "md".to_string(),
                "json".to_string(),
            ],
        }
    }
}

#[command]
pub async fn validate_file_access(
    file_path: String,
    config: tauri::State<'_, SecurityConfig>,
) -> Result<bool, String> {
    use std::path::Path;

    let path = Path::new(&file_path);

    // Check file extension
    if let Some(extension) = path.extension() {
        let ext = extension.to_string_lossy().to_lowercase();
        if !config.allowed_extensions.contains(&ext) {
            return Ok(false);
        }
    }

    // Check file size
    if let Ok(metadata) = std::fs::metadata(&path) {
        if metadata.len() > config.max_file_size as u64 {
            return Ok(false);
        }
    }

    // Additional security checks...
    Ok(true)
}

#[command]
pub async fn secure_http_request(
    url: String,
    config: tauri::State<'_, SecurityConfig>,
) -> Result<String, String> {
    // Validate URL against allowed domains
    let parsed_url = url::Url::parse(&url)
        .map_err(|e| format!("Invalid URL: {}", e))?;

    let origin = format!("{}://{}", parsed_url.scheme(),
                        parsed_url.host_str().unwrap_or(""));

    if !config.allowed_domains.contains(&origin) {
        return Err("Domain not allowed".to_string());
    }

    // Make secure HTTP request
    let response = reqwest::get(&url)
        .await
        .map_err(|e| format!("Request failed: {}", e))?;

    let body = response.text()
        .await
        .map_err(|e| format!("Failed to read response: {}", e))?;

    Ok(body)
}
```

## Development Workflow

### ✅ Recommended Development Process

```bash
# Development workflow
cargo tauri dev              # Start development server
cargo tauri dev --no-watch   # Start without file watching
cargo check                  # Check Rust code
cargo test                   # Run Rust tests
npm test                     # Run frontend tests

# Building for distribution
cargo tauri build            # Build for current platform
cargo tauri build --debug    # Build debug version
cargo tauri build --target aarch64-apple-darwin  # Cross-compile

# Platform-specific builds
cargo tauri build --bundles dmg     # macOS DMG
cargo tauri build --bundles msi     # Windows MSI
cargo tauri build --bundles deb     # Linux DEB
cargo tauri build --bundles appimage # Linux AppImage

# Code quality
cargo clippy                 # Rust linting
cargo fmt                    # Rust formatting
npm run lint                 # Frontend linting
npm run type-check          # TypeScript checking
```

### Configuration and Optimization

```json
// tauri.conf.json - Production configuration
{
  "build": {
    "beforeDevCommand": "npm run dev",
    "beforeBuildCommand": "npm run build",
    "devPath": "http://localhost:3000",
    "distDir": "../dist"
  },
  "package": {
    "productName": "My Tauri App",
    "version": "1.0.0"
  },
  "tauri": {
    "allowlist": {
      "all": false,
      "shell": {
        "all": false,
        "open": true
      },
      "dialog": {
        "all": false,
        "open": true,
        "save": true
      },
      "fs": {
        "all": false,
        "readFile": true,
        "writeFile": true,
        "readDir": true,
        "createDir": true,
        "removeDir": false,
        "removeFile": true,
        "renameFile": true
      },
      "path": {
        "all": true
      },
      "os": {
        "all": true
      }
    },
    "bundle": {
      "active": true,
      "targets": "all",
      "identifier": "com.yourcompany.myapp",
      "icon": [
        "icons/32x32.png",
        "icons/128x128.png",
        "icons/128x128@2x.png",
        "icons/icon.icns",
        "icons/icon.ico"
      ],
      "resources": [],
      "externalBin": [],
      "copyright": "© 2025 Your Company",
      "category": "DeveloperTool",
      "shortDescription": "A modern desktop application",
      "longDescription": "A comprehensive desktop application built with Tauri and modern web technologies."
    },
    "security": {
      "csp": "default-src 'self'; img-src 'self' asset: https://asset.localhost"
    },
    "windows": [
      {
        "fullscreen": false,
        "resizable": true,
        "title": "My Tauri App",
        "width": 1200,
        "height": 800,
        "minWidth": 800,
        "minHeight": 600
      }
    ]
  }
}
```

### AI Agent Decision Matrix

| Scenario                      | Recommended Approach            | Avoid                          |
| ----------------------------- | ------------------------------- | ------------------------------ |
| Lightweight desktop app       | Tauri with minimal dependencies | Electron (larger bundle)       |
| Security-critical application | Leverage Rust's memory safety   | Languages with runtime errors  |
| Performance-sensitive app     | Native Rust backend             | Heavy JavaScript processing    |
| Cross-platform requirement    | Tauri with platform detection   | Platform-specific code         |
| Team with Rust experience     | Full Tauri capabilities         | Avoiding backend complexity    |
| Simple web app conversion     | Gradual Tauri integration       | Complete rewrite               |
| System integration needs      | Rust native capabilities        | Web-only solutions             |
| Small distribution size       | Tauri optimization              | Frameworks with large runtimes |

## Testing

### ✅ Rust Testing

```rust
// src-tauri/src/commands/file_ops.rs - Tests
#[cfg(test)]
mod tests {
    use super::*;
    use std::fs;
    use tempfile::tempdir;

    #[tokio::test]
    async fn test_read_file_success() {
        let dir = tempdir().unwrap();
        let file_path = dir.path().join("test.txt");
        let content = "Hello, Tauri!";

        fs::write(&file_path, content).unwrap();

        let result = read_file(file_path.to_string_lossy().to_string()).await.unwrap();

        assert!(result.success);
        assert_eq!(result.data.unwrap(), content);
    }

    #[tokio::test]
    async fn test_read_file_not_found() {
        let result = read_file("/nonexistent/file.txt".to_string()).await.unwrap();

        assert!(!result.success);
        assert!(result.error.is_some());
    }

    #[tokio::test]
    async fn test_write_file_success() {
        let dir = tempdir().unwrap();
        let file_path = dir.path().join("output.txt");
        let content = "Test content";

        let request = SaveRequest {
            path: file_path.to_string_lossy().to_string(),
            content: content.to_string(),
        };

        let result = write_file(request).await.unwrap();

        assert!(result.success);

        let written_content = fs::read_to_string(&file_path).unwrap();
        assert_eq!(written_content, content);
    }
}
```

### ✅ Frontend Testing with Vitest

```typescript
// src/__tests__/tauri-api.test.ts
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { TauriAPI } from '../services/tauri-api';

// Mock Tauri's invoke function
const mockInvoke = vi.fn();
vi.mock('@tauri-apps/api/tauri', () => ({
  invoke: mockInvoke,
}));

describe('TauriAPI', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('readFile', () => {
    it('should return success result', async () => {
      const mockResult = {
        success: true,
        data: 'file content',
      };

      mockInvoke.mockResolvedValue(mockResult);

      const result = await TauriAPI.readFile('/path/to/file.txt');

      expect(mockInvoke).toHaveBeenCalledWith('read_file', {
        path: '/path/to/file.txt',
      });
      expect(result).toEqual(mockResult);
    });

    it('should handle error result', async () => {
      const mockResult = {
        success: false,
        error: 'File not found',
      };

      mockInvoke.mockResolvedValue(mockResult);

      const result = await TauriAPI.readFile('/nonexistent.txt');

      expect(result.success).toBe(false);
      expect(result.error).toBe('File not found');
    });
  });

  describe('writeFile', () => {
    it('should save file successfully', async () => {
      const mockResult = { success: true };
      mockInvoke.mockResolvedValue(mockResult);

      const request = {
        path: '/path/to/file.txt',
        content: 'new content',
      };

      const result = await TauriAPI.writeFile(request);

      expect(mockInvoke).toHaveBeenCalledWith('write_file', { request });
      expect(result.success).toBe(true);
    });
  });
});
```

## Security Considerations

- Implement least privilege principle with Tauri allowlist configuration
- Use Rust's memory safety features to prevent buffer overflows and memory leaks
- Validate all input data in Rust commands before processing
- Implement proper authentication and session management
- Use Content Security Policy (CSP) to prevent XSS attacks
- Keep Tauri and Rust dependencies updated to latest secure versions
- Implement secure communication channels for sensitive operations
- Use proper error handling that doesn't leak sensitive information
- Follow secure coding practices in both Rust and frontend code

## AI Agent Quick Reference

- **Project Setup**: Use create-tauri-app with TypeScript template for modern development
- **Architecture**: Rust backend with secure IPC communication to web frontend
- **Performance**: Leverage Rust's zero-cost abstractions and memory safety
- **Security**: Use Tauri's allowlist and Rust's safety features
- **Development**: Combine Rust tooling (cargo) with frontend tools (npm/yarn)
- **Testing**: Implement both Rust unit tests and frontend integration tests
- **Distribution**: Build lightweight native applications with small bundle sizes
- **Cross-platform**: Handle platform differences in Rust code with conditional compilation

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

## Configuration

### [Config File 1]

```[format]
# Configuration options
[example configuration]
```

### [Config File 2]

```[format]
# Configuration options
[example configuration]
```

## Essential Commands

```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions

### [Issue 1]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization

- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations

- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources

- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines

### Code Style

- [Coding conventions specific to this framework]
- [Naming conventions]
- [File organization patterns]

### Architecture Patterns

- [Recommended architectural patterns]
- [State management approaches]
- [Component/module organization]

## Integration Points

### [External Service/Tool 1]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

### [External Service/Tool 2]

- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

## Version Compatibility

- **Node.js**: [Supported versions]
- **Dependencies**: [Key dependency versions]
- **Browser Support**: [If applicable]
- **OS Support**: [If applicable]

## Troubleshooting

### Debug Mode

```bash
[debug commands]
```

### Log Analysis

- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages

- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]
