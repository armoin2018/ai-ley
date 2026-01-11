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