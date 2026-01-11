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