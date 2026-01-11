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