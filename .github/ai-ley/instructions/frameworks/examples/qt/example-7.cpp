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