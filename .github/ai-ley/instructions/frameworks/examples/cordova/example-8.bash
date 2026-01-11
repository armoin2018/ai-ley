# Project management
cordova create <path> <id> <name>     # Create new project
cordova platform add <platform>       # Add platform
cordova platform remove <platform>    # Remove platform
cordova plugin add <plugin>           # Install plugin
cordova plugin remove <plugin>        # Remove plugin

# Development workflow
cordova prepare                       # Prepare project for building
cordova build                        # Build all platforms
cordova build android               # Build specific platform
cordova run android --device       # Run on device
cordova emulate ios                # Run in emulator

# Debugging and analysis
cordova requirements              # Check platform requirements
cordova info                     # Display project information
cordova plugin list              # List installed plugins
cordova platform list           # List installed platforms

# Advanced operations
cordova clean                    # Clean project
cordova build --release         # Release build
cordova run --list             # List available devices/emulators