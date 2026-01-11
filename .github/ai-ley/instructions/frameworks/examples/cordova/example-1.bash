# Install Node.js (version 16+ recommended)
node --version  # Should be 16.0.0 or higher
npm --version   # Should be 8.0.0 or higher

# Install Java Development Kit (for Android)
java -version   # Should be JDK 8 or higher

# Install Android SDK (via Android Studio)
# Download and install Android Studio
# Configure ANDROID_HOME environment variable
export ANDROID_HOME=$HOME/Library/Android/sdk  # macOS
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# Install Xcode (for iOS development on macOS)
xcode-select --install