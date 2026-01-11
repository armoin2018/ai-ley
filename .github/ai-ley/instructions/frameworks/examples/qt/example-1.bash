# Option 1: Qt Online Installer (Recommended)
# Download from https://www.qt.io/download-qt-installer
# Install Qt 6.6+ with Qt Creator IDE

# Option 2: Package Manager Installation
# Ubuntu/Debian
sudo apt update
sudo apt install qt6-base-dev qt6-tools-dev cmake ninja-build
sudo apt install qt6-declarative-dev qt6-multimedia-dev

# macOS with Homebrew
brew install qt@6
brew install cmake ninja

# Add Qt to PATH
export PATH="/opt/homebrew/opt/qt@6/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/qt@6/lib/pkgconfig:$PKG_CONFIG_PATH"

# Create new Qt project
mkdir MyQtApp && cd MyQtApp
qt-cmake --help  # Verify Qt installation

# Generate CMake project
cat > CMakeLists.txt << 'EOF'
cmake_minimum_required(VERSION 3.24)
project(MyQtApp VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Widgets Quick)

qt_standard_project_setup()

qt_add_executable(MyQtApp main.cpp)
qt_add_qml_module(MyQtApp
    URI MyQtApp
    VERSION 1.0
    QML_FILES main.qml
)

target_link_libraries(MyQtApp Qt6::Core Qt6::Widgets Qt6::Quick)
EOF