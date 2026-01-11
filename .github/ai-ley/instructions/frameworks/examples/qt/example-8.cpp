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