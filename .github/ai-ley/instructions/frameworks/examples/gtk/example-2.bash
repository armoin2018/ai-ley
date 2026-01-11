# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install GTK 4 development packages
sudo apt install libgtk-4-dev  # Ubuntu/Debian
sudo dnf install gtk4-devel    # Fedora
sudo pacman -S gtk4            # Arch

# Create new Rust project
cargo new gtk_app
cd gtk_app

# Add GTK dependency to Cargo.toml
echo 'gtk = { version = "0.7", package = "gtk4" }' >> Cargo.toml
echo 'glib = "0.18"' >> Cargo.toml
echo 'gio = "0.18"' >> Cargo.toml