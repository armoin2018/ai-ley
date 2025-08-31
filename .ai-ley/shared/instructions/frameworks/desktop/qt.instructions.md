---
applyTo: 'qt, qt5, qt6, pyqt, pyside, qtquick, qml'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Qt 6+ for modern cross-platform native desktop applications'
---

# Qt Framework Instructions for AI Agents

## When to Use Qt

Use Qt when you need:

- Cross-platform native desktop applications (Windows, macOS, Linux)
- High-performance applications with native look and feel
- Applications requiring complex custom widgets and advanced graphics
- Enterprise-grade desktop software with professional UI
- Applications needing extensive hardware integration and system APIs
- Multi-language applications with robust internationalization
- Applications requiring offline functionality and local data processing
- Desktop applications with mobile companion apps using shared codebase

## When to Avoid Qt

Consider alternatives when:

- Building simple utilities or one-time tools
- Team lacks C++ experience and timeline is tight
- Need rapid web-based prototyping and deployment
- Primary target is web browsers or cloud-based solutions
- Licensing costs are prohibitive for commercial applications
- Building primarily data visualization or chart-heavy web applications
- Working with teams preferring web technologies exclusively

## Framework Overview

- **Framework**: Qt 6+ (Cross-platform Application Framework)
- **Type**: Native cross-platform desktop and mobile application framework
- **Languages**: C++ (primary), Python (PySide/PyQt), QML/JavaScript (UI), Go (Go-Qt), Rust (Qt bindings)
- **Platform**: Windows, macOS, Linux, iOS, Android, embedded systems
- **Use Cases**: Desktop applications, embedded software, mobile apps, automotive software, industrial applications

## Installation & Setup

### ✅ Recommended: Qt 6 with C++ and Qt Creator

```bash
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
```

### ✅ Alternative: Qt with Python (PySide6)

```bash
# Install Python and PySide6
python -m pip install --upgrade pip
pip install PySide6 PySide6-tools

# Verify installation
python -c "import PySide6; print(f'PySide6 {PySide6.__version__} ready!')"

# Create project structure
mkdir qt_python_app && cd qt_python_app
mkdir src ui resources

# Test with simple application
cat > src/main.py << 'EOF'
import sys
from PySide6.QtWidgets import QApplication, QMainWindow, QLabel

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Qt Python App")
        self.setCentralWidget(QLabel("Hello, Qt!"))

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()
    sys.exit(app.exec())
EOF

python src/main.py
```

### ✅ Alternative: Qt Quick with QML

```bash
# Qt Quick focuses on declarative UI with QML
# Install Qt 6 with Quick module

# Create QML project structure
mkdir qt_quick_app && cd qt_quick_app
mkdir qml src

# Create main.cpp
cat > src/main.cpp << 'EOF'
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
EOF

# Create main.qml
cat > qml/main.qml << 'EOF'
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    width: 800
    height: 600
    visible: true
    title: "Qt Quick App"

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"

        Text {
            anchors.centerIn: parent
            text: "Hello, Qt Quick!"
            font.pixelSize: 24
        }
    }
}
EOF
```

### AI Agent Decision Tree

- **For cross-platform consistency**: Use Qt Widgets with C++ for traditional desktop apps
- **For modern, fluid UI**: Use Qt Quick with QML for touch-friendly and animated interfaces
- **For rapid prototyping**: Use PySide6 (Python) for faster development cycles
- **For enterprise applications**: Use C++ with Qt Creator for maximum performance and control
- **For mobile integration**: Use Qt Quick for applications targeting both desktop and mobile

## Project Structure

### ✅ C++ Qt Widgets Project Structure

```
qt_widgets_app/
├── CMakeLists.txt           # Build configuration
├── main.cpp                 # Application entry point
├── src/
│   ├── mainwindow.cpp       # Main window implementation
│   ├── mainwindow.h         # Main window header
│   ├── mainwindow.ui        # UI designer file
│   ├── models/              # Data models
│   │   ├── documentmodel.cpp
│   │   └── documentmodel.h
│   ├── widgets/             # Custom widgets
│   │   ├── custombutton.cpp
│   │   ├── custombutton.h
│   │   └── fileexplorer.cpp
│   ├── controllers/         # Business logic
│   │   ├── filecontroller.cpp
│   │   └── filecontroller.h
│   └── utils/               # Utility classes
│       ├── settings.cpp
│       └── settings.h
├── resources/               # Application resources
│   ├── icons/
│   ├── translations/
│   └── resources.qrc        # Resource file
├── tests/                   # Unit tests
│   ├── test_models.cpp
│   └── test_widgets.cpp
├── docs/                    # Documentation
└── dist/                    # Distribution files
```

### ✅ Qt Quick/QML Project Structure

```
qt_quick_app/
├── CMakeLists.txt           # Build configuration
├── main.cpp                 # C++ entry point
├── qml/
│   ├── main.qml            # Main QML file
│   ├── components/         # Reusable QML components
│   │   ├── CustomButton.qml
│   │   ├── FileDialog.qml
│   │   └── NavigationBar.qml
│   ├── pages/              # Application pages
│   │   ├── HomePage.qml
│   │   ├── SettingsPage.qml
│   │   └── AboutPage.qml
│   ├── models/             # QML data models
│   │   └── FileListModel.qml
│   └── styles/             # Styling and themes
│       ├── AppStyle.qml
│       └── Colors.qml
├── src/                    # C++ backend
│   ├── applicationcontroller.cpp
│   ├── applicationcontroller.h
│   ├── models/
│   │   ├── filemodel.cpp
│   │   └── filemodel.h
│   └── utils/
│       ├── filemanager.cpp
│       └── filemanager.h
├── resources/
│   ├── qml.qrc             # QML resources
│   ├── images/
│   └── fonts/
├── tests/
└── platform/               # Platform-specific code
    ├── windows/
    ├── macos/
    └── linux/
```

### ✅ PySide6 Python Project Structure

```
qt_python_app/
├── main.py                  # Application entry point
├── src/
│   ├── __init__.py
│   ├── application.py       # Main application class
│   ├── mainwindow.py        # Main window
│   ├── ui/                  # UI files
│   │   ├── __init__.py
│   │   ├── mainwindow.ui    # Designer files
│   │   └── generated/       # Auto-generated UI code
│   │       └── ui_mainwindow.py
│   ├── widgets/             # Custom widgets
│   │   ├── __init__.py
│   │   ├── custom_button.py
│   │   └── file_explorer.py
│   ├── models/              # Data models
│   │   ├── __init__.py
│   │   ├── file_model.py
│   │   └── settings_model.py
│   ├── controllers/         # Business logic
│   │   ├── __init__.py
│   │   └── file_controller.py
│   └── utils/               # Utilities
│       ├── __init__.py
│       ├── settings.py
│       └── resources.py
├── resources/               # Application resources
│   ├── icons/
│   ├── ui/
│   ├── translations/
│   └── resources.qrc
├── tests/                   # Unit tests
│   ├── test_models.py
│   └── test_widgets.py
├── requirements.txt         # Python dependencies
├── setup.py                # Installation script
└── pyproject.toml          # Modern Python project config
```

## Core Concepts

### Main Application and Window Management

✅ **Best Practice**: Proper Qt application architecture with modern C++

```cpp
// src/main.cpp - Application Entry Point
#include <QApplication>
#include <QStyleFactory>
#include <QDir>
#include <QStandardPaths>
#include <QLoggingCategory>

#include "mainwindow.h"
#include "utils/settings.h"

Q_LOGGING_CATEGORY(main, "app.main")

void setupApplicationProperties()
{
    QCoreApplication::setOrganizationName("MyCompany");
    QCoreApplication::setOrganizationDomain("mycompany.com");
    QCoreApplication::setApplicationName("MyQtApp");
    QCoreApplication::setApplicationVersion("1.0.0");
}

void setupApplicationStyle()
{
    // Set application style for consistent appearance
    QApplication::setStyle(QStyleFactory::create("Fusion"));

    // Apply dark theme palette
    QPalette darkPalette;
    darkPalette.setColor(QPalette::Window, QColor(53, 53, 53));
    darkPalette.setColor(QPalette::WindowText, Qt::white);
    darkPalette.setColor(QPalette::Base, QColor(25, 25, 25));
    darkPalette.setColor(QPalette::AlternateBase, QColor(53, 53, 53));
    darkPalette.setColor(QPalette::ToolTipBase, Qt::white);
    darkPalette.setColor(QPalette::ToolTipText, Qt::white);
    darkPalette.setColor(QPalette::Text, Qt::white);
    darkPalette.setColor(QPalette::Button, QColor(53, 53, 53));
    darkPalette.setColor(QPalette::ButtonText, Qt::white);
    darkPalette.setColor(QPalette::BrightText, Qt::red);
    darkPalette.setColor(QPalette::Link, QColor(42, 130, 218));
    darkPalette.setColor(QPalette::Highlight, QColor(42, 130, 218));
    darkPalette.setColor(QPalette::HighlightedText, Qt::black);

    QApplication::setPalette(darkPalette);
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // High DPI support
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);

    setupApplicationProperties();
    setupApplicationStyle();

    // Load application settings
    Settings settings;

    // Create main window
    MainWindow window;
    window.show();

    qCInfo(main) << "Application started successfully";

    return app.exec();
}
```

### Modern Qt Widgets with MVC Pattern

✅ **Best Practice**: Comprehensive main window with proper architecture

```cpp
// src/mainwindow.h - Main Window Header
#pragma once

#include <QMainWindow>
#include <QMenuBar>
#include <QToolBar>
#include <QStatusBar>
#include <QSplitter>
#include <QTextEdit>
#include <QTreeView>
#include <QLabel>
#include <QProgressBar>
#include <QFileSystemModel>
#include <QUndoStack>

QT_BEGIN_NAMESPACE
class QAction;
class QMenu;
class QUndoView;
QT_END_NAMESPACE

class FileController;
class DocumentModel;
class CustomFileExplorer;

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

protected:
    void closeEvent(QCloseEvent *event) override;
    void dragEnterEvent(QDragEnterEvent *event) override;
    void dropEvent(QDropEvent *event) override;

private slots:
    void newFile();
    void openFile();
    void openRecentFile();
    void saveFile();
    void saveFileAs();
    void exportToPdf();
    void print();
    void undo();
    void redo();
    void cut();
    void copy();
    void paste();
    void selectAll();
    void find();
    void replace();
    void goToLine();
    void preferences();
    void about();
    void updateStatusBar();
    void updateRecentFiles();
    void documentModified();
    void currentFileChanged(const QString &filePath);

private:
    void createActions();
    void createMenus();
    void createToolBars();
    void createStatusBar();
    void createCentralWidget();
    void setupFileExplorer();
    void connectSignals();
    void loadSettings();
    void saveSettings();
    void updateWindowTitle();
    void setCurrentFile(const QString &fileName);
    bool saveDocument();
    bool saveDocumentAs();
    bool discardChanges();
    void addRecentFile(const QString &fileName);

    // UI Components
    QSplitter *m_centralSplitter;
    QTextEdit *m_textEdit;
    CustomFileExplorer *m_fileExplorer;

    // Status bar widgets
    QLabel *m_statusLabel;
    QLabel *m_positionLabel;
    QLabel *m_modeLabel;
    QProgressBar *m_progressBar;

    // Menus
    QMenu *m_fileMenu;
    QMenu *m_editMenu;
    QMenu *m_viewMenu;
    QMenu *m_toolsMenu;
    QMenu *m_helpMenu;
    QMenu *m_recentFilesMenu;

    // Toolbars
    QToolBar *m_fileToolBar;
    QToolBar *m_editToolBar;

    // Actions
    QAction *m_newAction;
    QAction *m_openAction;
    QAction *m_saveAction;
    QAction *m_saveAsAction;
    QAction *m_exportPdfAction;
    QAction *m_printAction;
    QAction *m_exitAction;
    QAction *m_undoAction;
    QAction *m_redoAction;
    QAction *m_cutAction;
    QAction *m_copyAction;
    QAction *m_pasteAction;
    QAction *m_selectAllAction;
    QAction *m_findAction;
    QAction *m_replaceAction;
    QAction *m_goToLineAction;
    QAction *m_preferencesAction;
    QAction *m_aboutAction;

    // Data and controllers
    FileController *m_fileController;
    DocumentModel *m_documentModel;
    QUndoStack *m_undoStack;
    QFileSystemModel *m_fileSystemModel;

    // State
    QString m_currentFilePath;
    QStringList m_recentFiles;
    bool m_isModified;

    // Constants
    static const int MaxRecentFiles = 10;
};
```

### File Management and Model Implementation

✅ **Best Practice**: Robust file handling with Qt's model-view architecture

```cpp
// src/controllers/filecontroller.cpp - File Operations Controller
#include "filecontroller.h"
#include <QFile>
#include <QTextStream>
#include <QFileInfo>
#include <QDir>
#include <QMimeDatabase>
#include <QLoggingCategory>
#include <QMessageBox>
#include <QApplication>

Q_LOGGING_CATEGORY(fileController, "app.filecontroller")

FileController::FileController(QObject *parent)
    : QObject(parent)
    , m_textCodec(QTextCodec::codecForName("UTF-8"))
{
}

FileController::~FileController() = default;

bool FileController::openFile(const QString &filePath, QString &content, QString &errorMessage)
{
    QFile file(filePath);

    if (!file.exists()) {
        errorMessage = tr("File does not exist: %1").arg(filePath);
        qCWarning(fileController) << errorMessage;
        return false;
    }

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        errorMessage = tr("Cannot open file for reading: %1
Error: %2")
                      .arg(filePath, file.errorString());
        qCWarning(fileController) << errorMessage;
        return false;
    }

    QTextStream stream(&file);
    stream.setCodec(m_textCodec);

    // Read file with progress for large files
    content.clear();
    qint64 fileSize = file.size();
    qint64 bytesRead = 0;

    while (!stream.atEnd()) {
        QString line = stream.readLine();
        content += line + "
";

        bytesRead += line.toUtf8().size() + 1;

        // Emit progress for large files (>1MB)
        if (fileSize > 1024 * 1024) {
            int progress = static_cast<int>((bytesRead * 100) / fileSize);
            emit progressChanged(progress);

            // Allow event processing for responsive UI
            QApplication::processEvents();
        }
    }

    // Remove trailing newline
    if (content.endsWith('
')) {
        content.chop(1);
    }

    emit progressChanged(100);
    qCInfo(fileController) << "Successfully opened file:" << filePath;

    return true;
}

bool FileController::saveFile(const QString &filePath, const QString &content, QString &errorMessage)
{
    // Create backup if file exists
    if (QFile::exists(filePath)) {
        createBackup(filePath);
    }

    QFile file(filePath);

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        errorMessage = tr("Cannot open file for writing: %1
Error: %2")
                      .arg(filePath, file.errorString());
        qCWarning(fileController) << errorMessage;
        return false;
    }

    QTextStream stream(&file);
    stream.setCodec(m_textCodec);

    // Write content with progress for large files
    QStringList lines = content.split('
');
    int totalLines = lines.size();

    for (int i = 0; i < totalLines; ++i) {
        stream << lines[i];
        if (i < totalLines - 1) {
            stream << '
';
        }

        // Emit progress for large files
        if (totalLines > 1000) {
            int progress = static_cast<int>((i * 100) / totalLines);
            emit progressChanged(progress);

            // Allow event processing
            if (i % 100 == 0) {
                QApplication::processEvents();
            }
        }
    }

    stream.flush();
    file.close();

    if (file.error() != QFile::NoError) {
        errorMessage = tr("Error writing to file: %1
Error: %2")
                      .arg(filePath, file.errorString());
        qCWarning(fileController) << errorMessage;
        return false;
    }

    emit progressChanged(100);
    qCInfo(fileController) << "Successfully saved file:" << filePath;

    return true;
}

FileInfo FileController::getFileInfo(const QString &filePath) const
{
    QFileInfo fileInfo(filePath);
    FileInfo info;

    info.fileName = fileInfo.fileName();
    info.baseName = fileInfo.baseName();
    info.suffix = fileInfo.suffix();
    info.absolutePath = fileInfo.absolutePath();
    info.absoluteFilePath = fileInfo.absoluteFilePath();
    info.size = fileInfo.size();
    info.lastModified = fileInfo.lastModified();
    info.isReadable = fileInfo.isReadable();
    info.isWritable = fileInfo.isWritable();
    info.isExecutable = fileInfo.isExecutable();

    // Determine file type using MIME database
    QMimeDatabase mimeDb;
    QMimeType mimeType = mimeDb.mimeTypeForFile(filePath);
    info.mimeType = mimeType.name();
    info.description = mimeType.comment();

    // Categorize file type
    if (mimeType.name().startsWith("text/")) {
        info.category = FileInfo::TextFile;
    } else if (mimeType.name().startsWith("image/")) {
        info.category = FileInfo::ImageFile;
    } else if (mimeType.name().startsWith("audio/")) {
        info.category = FileInfo::AudioFile;
    } else if (mimeType.name().startsWith("video/")) {
        info.category = FileInfo::VideoFile;
    } else if (mimeType.name() == "application/pdf") {
        info.category = FileInfo::DocumentFile;
    } else {
        info.category = FileInfo::OtherFile;
    }

    return info;
}

bool FileController::createBackup(const QString &filePath)
{
    QFileInfo fileInfo(filePath);
    QString backupPath = fileInfo.absolutePath() + "/.backup_" + fileInfo.fileName();

    // Remove old backup if exists
    if (QFile::exists(backupPath)) {
        QFile::remove(backupPath);
    }

    bool success = QFile::copy(filePath, backupPath);

    if (success) {
        qCInfo(fileController) << "Created backup:" << backupPath;
    } else {
        qCWarning(fileController) << "Failed to create backup for:" << filePath;
    }

    return success;
}

QStringList FileController::getRecentFiles() const
{
    QSettings settings;
    return settings.value("recentFiles").toStringList();
}

void FileController::addRecentFile(const QString &filePath)
{
    QSettings settings;
    QStringList recentFiles = settings.value("recentFiles").toStringList();

    // Remove if already exists
    recentFiles.removeAll(filePath);

    // Add to front
    recentFiles.prepend(filePath);

    // Keep only last 10 files
    while (recentFiles.size() > 10) {
        recentFiles.removeLast();
    }

    settings.setValue("recentFiles", recentFiles);
    emit recentFilesChanged(recentFiles);
}
```

### Qt Quick/QML Modern UI Components

✅ **Best Practice**: Declarative UI with modern QML patterns

```qml
// qml/main.qml - Main Application Window
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3

ApplicationWindow {
    id: window
    width: 1200
    height: 800
    visible: true
    title: qsTr("Qt Quick Text Editor")

    Material.theme: Material.Dark
    Material.primary: Material.Blue
    Material.accent: Material.LightBlue

    property alias currentDocument: documentModel.currentDocument
    property bool hasUnsavedChanges: documentModel.modified

    // Custom application controller (C++ backend)
    ApplicationController {
        id: appController
    }

    DocumentModel {
        id: documentModel
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")

            MenuItem {
                text: qsTr("&New")
                shortcut: "Ctrl+N"
                onTriggered: appController.newDocument()
            }

            MenuItem {
                text: qsTr("&Open...")
                shortcut: "Ctrl+O"
                onTriggered: fileDialog.open()
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("&Save")
                shortcut: "Ctrl+S"
                enabled: hasUnsavedChanges
                onTriggered: appController.saveDocument()
            }

            MenuItem {
                text: qsTr("Save &As...")
                shortcut: "Ctrl+Shift+S"
                onTriggered: saveAsDialog.open()
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("&Quit")
                shortcut: "Ctrl+Q"
                onTriggered: window.close()
            }
        }

        Menu {
            title: qsTr("&Edit")

            MenuItem {
                text: qsTr("&Undo")
                shortcut: "Ctrl+Z"
                enabled: textEditor.canUndo
                onTriggered: textEditor.undo()
            }

            MenuItem {
                text: qsTr("&Redo")
                shortcut: "Ctrl+Y"
                enabled: textEditor.canRedo
                onTriggered: textEditor.redo()
            }

            MenuSeparator {}

            MenuItem {
                text: qsTr("Cu&t")
                shortcut: "Ctrl+X"
                enabled: textEditor.selectedText.length > 0
                onTriggered: textEditor.cut()
            }

            MenuItem {
                text: qsTr("&Copy")
                shortcut: "Ctrl+C"
                enabled: textEditor.selectedText.length > 0
                onTriggered: textEditor.copy()
            }

            MenuItem {
                text: qsTr("&Paste")
                shortcut: "Ctrl+V"
                enabled: textEditor.canPaste
                onTriggered: textEditor.paste()
            }
        }
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ToolButton {
                icon.source: "qrc:/icons/document-new.svg"
                text: qsTr("New")
                ToolTip.text: text
                onClicked: appController.newDocument()
            }

            ToolButton {
                icon.source: "qrc:/icons/document-open.svg"
                text: qsTr("Open")
                ToolTip.text: text
                onClicked: fileDialog.open()
            }

            ToolButton {
                icon.source: "qrc:/icons/document-save.svg"
                text: qsTr("Save")
                ToolTip.text: text
                enabled: hasUnsavedChanges
                onClicked: appController.saveDocument()
            }

            ToolSeparator {}

            ToolButton {
                icon.source: "qrc:/icons/edit-undo.svg"
                text: qsTr("Undo")
                ToolTip.text: text
                enabled: textEditor.canUndo
                onClicked: textEditor.undo()
            }

            ToolButton {
                icon.source: "qrc:/icons/edit-redo.svg"
                text: qsTr("Redo")
                ToolTip.text: text
                enabled: textEditor.canRedo
                onClicked: textEditor.redo()
            }

            Item {
                Layout.fillWidth: true
            }

            Label {
                text: currentDocument.fileName || qsTr("Untitled")
                font.bold: true
            }

            BusyIndicator {
                visible: appController.busy
                implicitWidth: 24
                implicitHeight: 24
            }
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        // File Explorer Panel
        Rectangle {
            SplitView.minimumWidth: 200
            SplitView.preferredWidth: 300
            color: Material.backgroundColor

            FileExplorer {
                id: fileExplorer
                anchors.fill: parent
                onFileSelected: function(filePath) {
                    appController.openDocument(filePath)
                }
            }
        }

        // Main Editor Area
        Rectangle {
            SplitView.fillWidth: true
            color: Material.backgroundColor

            ScrollView {
                anchors.fill: parent
                anchors.margins: 8

                TextArea {
                    id: textEditor
                    text: documentModel.content
                    selectByMouse: true
                    wrapMode: TextArea.Wrap

                    font.family: "Consolas, Monaco, monospace"
                    font.pixelSize: 14

                    color: Material.foreground
                    selectionColor: Material.accent
                    selectedTextColor: Material.background

                    onTextChanged: {
                        if (text !== documentModel.content) {
                            documentModel.content = text
                            documentModel.modified = true
                        }
                    }

                    // Line numbers background
                    Rectangle {
                        id: lineNumbers
                        width: 50
                        height: parent.height
                        color: Qt.darker(Material.backgroundColor, 1.2)

                        Column {
                            anchors.top: parent.top
                            anchors.margins: 4

                            Repeater {
                                model: textEditor.lineCount

                                Text {
                                    text: index + 1
                                    color: Material.hintTextColor
                                    font: textEditor.font
                                    width: lineNumbers.width - 8
                                    horizontalAlignment: Text.AlignRight
                                }
                            }
                        }
                    }

                    leftPadding: lineNumbers.width + 8
                }
            }
        }
    }

    footer: ToolBar {
        RowLayout {
            anchors.fill: parent

            Label {
                text: qsTr("Ready")
                Layout.fillWidth: true
            }

            Label {
                text: qsTr("Line %1, Column %2")
                      .arg(textEditor.cursorLine + 1)
                      .arg(textEditor.cursorColumn + 1)
            }

            Label {
                text: hasUnsavedChanges ? qsTr("Modified") : qsTr("Saved")
                color: hasUnsavedChanges ? Material.accent : Material.foreground
            }
        }
    }

    // File Dialogs
    FileDialog {
        id: fileDialog
        title: qsTr("Open File")
        nameFilters: [
            qsTr("Text files (*.txt)"),
            qsTr("Markdown files (*.md)"),
            qsTr("All files (*)")
        ]
        onAccepted: {
            appController.openDocument(fileUrl)
        }
    }

    FileDialog {
        id: saveAsDialog
        title: qsTr("Save File As")
        selectExisting: false
        nameFilters: fileDialog.nameFilters
        onAccepted: {
            appController.saveDocumentAs(fileUrl)
        }
    }

    // Confirmation dialog for unsaved changes
    MessageDialog {
        id: unsavedChangesDialog
        title: qsTr("Unsaved Changes")
        text: qsTr("You have unsaved changes. Do you want to save before closing?")
        standardButtons: StandardButton.Save | StandardButton.Discard | StandardButton.Cancel

        onAccepted: {
            appController.saveDocument()
            Qt.quit()
        }

        onDiscard: {
            Qt.quit()
        }
    }

    onClosing: function(close) {
        if (hasUnsavedChanges) {
            close.accepted = false
            unsavedChangesDialog.open()
        }
    }
}
```

## Best Practices

### ✅ Do's

- Use modern C++17/20 features with Qt 6 for better performance and safety
- Implement proper Model-View-Controller (MVC) architecture
- Use Qt's signal-slot mechanism for loose coupling between components
- Leverage Qt's resource system for embedding assets and translations
- Implement proper error handling with user-friendly messages
- Use Qt Creator's profiling tools for performance optimization
- Follow Qt's naming conventions and coding standards
- Implement comprehensive unit tests using Qt Test framework

### ❌ Don'ts

- Don't mix Qt widgets and Qt Quick in the same window without proper integration
- Don't ignore memory management even though Qt has parent-child cleanup
- Don't use raw pointers when smart pointers or Qt's object ownership is available
- Don't block the UI thread with long-running operations
- Don't hardcode UI strings - use Qt's internationalization system
- Don't skip proper signal disconnection when objects are destroyed
- Don't ignore high DPI scaling considerations for modern displays
- Don't forget to handle platform-specific behavior differences

### Performance and Threading

```cpp
// Example of proper threading with QThread
#include <QThread>
#include <QMutex>
#include <QWaitCondition>

class FileProcessorWorker : public QObject
{
    Q_OBJECT

public slots:
    void processFile(const QString &filePath);

signals:
    void fileProcessed(const QString &result);
    void progressChanged(int percentage);
    void errorOccurred(const QString &error);

private:
    void heavyProcessing(const QString &content);
};

class FileProcessor : public QObject
{
    Q_OBJECT

public:
    FileProcessor(QObject *parent = nullptr);
    ~FileProcessor();

    void processFileAsync(const QString &filePath);

signals:
    void fileProcessed(const QString &result);
    void progressChanged(int percentage);
    void errorOccurred(const QString &error);

private:
    QThread *m_workerThread;
    FileProcessorWorker *m_worker;
};

// Implementation
FileProcessor::FileProcessor(QObject *parent)
    : QObject(parent)
    , m_workerThread(new QThread(this))
    , m_worker(new FileProcessorWorker)
{
    m_worker->moveToThread(m_workerThread);

    // Connect signals
    connect(m_workerThread, &QThread::started, m_worker, &FileProcessorWorker::processFile);
    connect(m_worker, &FileProcessorWorker::fileProcessed, this, &FileProcessor::fileProcessed);
    connect(m_worker, &FileProcessorWorker::progressChanged, this, &FileProcessor::progressChanged);
    connect(m_worker, &FileProcessorWorker::errorOccurred, this, &FileProcessor::errorOccurred);

    m_workerThread->start();
}

FileProcessor::~FileProcessor()
{
    m_workerThread->quit();
    m_workerThread->wait();
    delete m_worker;
}

void FileProcessor::processFileAsync(const QString &filePath)
{
    QMetaObject::invokeMethod(m_worker, "processFile", Qt::QueuedConnection,
                             Q_ARG(QString, filePath));
}
```

## Development Workflow

### ✅ C++ Qt Development Workflow

```bash
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
```

### ✅ PySide6 Development Workflow

```bash
# Development
python main.py

# UI file compilation
pyside6-uic mainwindow.ui -o ui_mainwindow.py

# Resource file compilation
pyside6-rcc resources.qrc -o resources_rc.py

# Translation workflow
pyside6-lupdate src/ -ts translations/app_en.ts
pyside6-lrelease translations/app_en.ts

# Testing with pytest
pytest tests/

# Type checking
mypy src/

# Code formatting
black src/
isort src/

# Packaging with cx_Freeze
pip install cx_Freeze
python setup.py build

# Creating wheel distribution
python setup.py bdist_wheel
```

### Cross-Platform Deployment

```bash
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
```

## AI Agent Decision Matrix

| Scenario                   | Recommended Approach               | Avoid                           |
| -------------------------- | ---------------------------------- | ------------------------------- |
| Cross-platform desktop app | Qt Widgets with C++                | Platform-specific frameworks    |
| Modern touch-friendly UI   | Qt Quick with QML                  | Traditional widgets for touch   |
| Rapid prototyping          | PySide6 with Python                | C++ for quick iterations        |
| Performance-critical app   | C++ with optimized Qt              | Python for heavy computation    |
| Enterprise application     | Qt Creator + CMake + C++           | Quick solutions without testing |
| Mobile + desktop app       | Qt Quick for both platforms        | Separate codebases              |
| System integration heavy   | Qt + native platform APIs          | Pure cross-platform approach    |
| Team with web background   | Qt Quick/QML (similar to HTML/CSS) | Traditional desktop paradigms   |

## Testing

### ✅ Qt Test Framework

```cpp
// tests/test_filecontroller.cpp
#include <QtTest>
#include <QObject>
#include <QTemporaryFile>
#include <QTextStream>

#include "../src/controllers/filecontroller.h"

class TestFileController : public QObject
{
    Q_OBJECT

private slots:
    void initTestCase();
    void cleanupTestCase();
    void init();
    void cleanup();

    void testOpenExistingFile();
    void testOpenNonexistentFile();
    void testSaveFile();
    void testSaveToReadOnlyLocation();
    void testFileInfo();
    void testRecentFiles();

private:
    FileController *m_controller;
    QTemporaryFile *m_testFile;
};

void TestFileController::initTestCase()
{
    m_controller = new FileController(this);
}

void TestFileController::cleanupTestCase()
{
    delete m_controller;
}

void TestFileController::init()
{
    m_testFile = new QTemporaryFile(this);
    m_testFile->open();

    QTextStream stream(m_testFile);
    stream << "Hello, Qt Test!" << Qt::endl;
    stream << "Line 2" << Qt::endl;
    m_testFile->close();
}

void TestFileController::cleanup()
{
    delete m_testFile;
}

void TestFileController::testOpenExistingFile()
{
    QString content;
    QString errorMessage;

    bool success = m_controller->openFile(m_testFile->fileName(), content, errorMessage);

    QVERIFY(success);
    QVERIFY(errorMessage.isEmpty());
    QVERIFY(content.contains("Hello, Qt Test!"));
    QVERIFY(content.contains("Line 2"));
}

void TestFileController::testOpenNonexistentFile()
{
    QString content;
    QString errorMessage;

    bool success = m_controller->openFile("/nonexistent/file.txt", content, errorMessage);

    QVERIFY(!success);
    QVERIFY(!errorMessage.isEmpty());
    QVERIFY(content.isEmpty());
}

void TestFileController::testSaveFile()
{
    QTemporaryFile tempFile;
    tempFile.open();
    QString filePath = tempFile.fileName();
    tempFile.close();
    tempFile.remove(); // Remove so we can write to it

    QString content = "Test content
Second line";
    QString errorMessage;

    bool success = m_controller->saveFile(filePath, content, errorMessage);

    QVERIFY(success);
    QVERIFY(errorMessage.isEmpty());

    // Verify content was written correctly
    QFile savedFile(filePath);
    QVERIFY(savedFile.open(QIODevice::ReadOnly));
    QString savedContent = QString::fromUtf8(savedFile.readAll());
    QCOMPARE(savedContent, content);
}

void TestFileController::testFileInfo()
{
    FileInfo info = m_controller->getFileInfo(m_testFile->fileName());

    QVERIFY(!info.fileName.isEmpty());
    QVERIFY(info.size > 0);
    QVERIFY(info.isReadable);
    QCOMPARE(info.category, FileInfo::TextFile);
}

QTEST_MAIN(TestFileController)
#include "test_filecontroller.moc"
```

### ✅ PySide6 Testing with pytest

```python
# tests/test_file_controller.py
import pytest
import tempfile
import os
from pathlib import Path

from PySide6.QtCore import QObject
from PySide6.QtTest import QTest
from PySide6.QtWidgets import QApplication

from src.controllers.file_controller import FileController

class TestFileController:
    @pytest.fixture(autouse=True)
    def setup(self, qtbot):
        self.app = QApplication.instance()
        if self.app is None:
            self.app = QApplication([])

        self.controller = FileController()
        qtbot.addWidget(self.controller)

        # Create temporary test file
        self.temp_file = tempfile.NamedTemporaryFile(mode='w', delete=False)
        self.temp_file.write("Hello, Qt Test!
Line 2
")
        self.temp_file.close()

        yield

        # Cleanup
        os.unlink(self.temp_file.name)

    def test_open_existing_file(self, qtbot):
        content, error = self.controller.open_file(self.temp_file.name)

        assert error is None
        assert "Hello, Qt Test!" in content
        assert "Line 2" in content

    def test_open_nonexistent_file(self, qtbot):
        content, error = self.controller.open_file("/nonexistent/file.txt")

        assert error is not None
        assert content is None

    def test_save_file(self, qtbot):
        with tempfile.NamedTemporaryFile(delete=False) as temp:
            temp_path = temp.name

        content = "Test content
Second line"
        error = self.controller.save_file(temp_path, content)

        assert error is None

        # Verify content
        with open(temp_path, 'r') as f:
            saved_content = f.read()

        assert saved_content == content

        # Cleanup
        os.unlink(temp_path)

    def test_file_info(self, qtbot):
        info = self.controller.get_file_info(self.temp_file.name)

        assert info.file_name
        assert info.size > 0
        assert info.is_readable
        assert info.category == "text"

# Run with: pytest tests/test_file_controller.py -v
```

## Security Considerations

- Use Qt's secure coding practices and avoid buffer overflows in C++
- Validate all user input and file paths to prevent injection attacks
- Use Qt's cryptographic classes for secure data handling
- Implement proper access controls for file operations
- Use Qt's secure network classes (QSslSocket) for encrypted communications
- Follow platform security guidelines for code signing and sandboxing
- Regularly update Qt framework to latest stable version for security patches
- Use static analysis tools to detect potential security vulnerabilities
- Implement proper session management for multi-user applications
- Consider using Qt's built-in privilege escalation mechanisms responsibly

## AI Agent Quick Reference

- **Project Setup**: Use Qt Creator with CMake for modern C++ projects, or PySide6 for Python
- **UI Choice**: Qt Widgets for traditional desktop apps, Qt Quick for modern/mobile-friendly UIs
- **Architecture**: Implement MVC with Qt's signal-slot system for clean separation
- **Performance**: Use QThread for background operations, profile with Qt Creator tools
- **Testing**: Qt Test framework for C++, pytest with qtbot for Python
- **Deployment**: Use Qt's deployment tools for platform-specific packaging
- **Cross-platform**: Leverage Qt's abstraction layer while respecting platform conventions
- **Modern Development**: Use Qt 6+ features, modern C++, and declarative QML for best results
- **Example**: [Code example]

### [Concept 2]

- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

## Development Workflow

1. **Setup**: [Initial project setup steps]
2. **Development**: [Development server, hot reload, etc.]
3. **Testing**: [Testing framework and commands]
4. **Building**: [Build process and commands]
5. **Deployment**: [Deployment strategies]

## Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

## Common Patterns

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
