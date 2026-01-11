# Development with Qt Creator (Recommended)
qtcreator MyQtApp.pro

# Command line development
mkdir build && cd build
qt-cmake .. -G Ninja
cmake --build .

# Alternative with qmake (legacy)
qmake MyQtApp.pro
make

# Testing
ctest --output-on-failure

# Debugging
gdb ./MyQtApp
# or on Windows
windebuger MyQtApp.exe

# Profiling with Qt Creator's profiler
# Use Qt Creator's built-in profiler for performance analysis

# Static analysis
clang-static-analyzer src/
# or with Qt Creator's Clang analyzer

# Documentation generation
qdoc myapp.qdocconf

# Deployment preparation
# Windows
windeployqt MyQtApp.exe

# macOS
macdeployqt MyQtApp.app

# Linux AppImage
linuxdeployqt MyQtApp -appimage