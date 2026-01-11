# Development
cargo run

# Testing
cargo test

# Linting
cargo clippy

# Formatting
cargo fmt

# Building for release
cargo build --release

# Cross-compilation
rustup target add x86_64-pc-windows-gnu
cargo build --target x86_64-pc-windows-gnu

# Creating AppImage (Linux)
cargo install cargo-appimage
cargo appimage