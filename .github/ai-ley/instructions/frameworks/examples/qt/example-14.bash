# CMake cross-compilation
# For Windows from Linux
cmake .. -DCMAKE_TOOLCHAIN_FILE=windows-toolchain.cmake

# For macOS universal binary
cmake .. -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64"

# Static linking for portable executable
cmake .. -DQT_STATIC_BUILD=ON

# Creating installers
# Windows with NSIS
makensis installer.nsi

# macOS with DMG
hdiutil create -volname "MyApp" -srcfolder MyApp.app MyApp.dmg

# Linux with AppImage
./linuxdeployqt-continuous-x86_64.AppImage MyApp -appimage

# Cross-platform with Qt Installer Framework
binarycreator -c config.xml -p packages MyAppInstaller