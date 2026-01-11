# macOS installation with Homebrew
brew install --cask flutter

# Manual installation
# Download Flutter SDK from https://flutter.dev/docs/get-started/install
# Extract and add to PATH

# Verify installation
flutter doctor

# Create new project
flutter create my_app
cd my_app

# Run on device/simulator
flutter run

# Run on specific platform
flutter run -d chrome      # Web
flutter run -d macos       # macOS
flutter run -d windows     # Windows