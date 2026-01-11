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