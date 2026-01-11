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