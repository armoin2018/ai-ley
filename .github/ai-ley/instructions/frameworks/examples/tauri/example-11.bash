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