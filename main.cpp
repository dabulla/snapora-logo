#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QSurfaceFormat>
#include <QQmlContext>
#include <QDebug>
//#include <QtQuickShapes/QtQuickShapes>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Material");

    QSurfaceFormat format;
    format.setSamples(8);
    QSurfaceFormat::setDefaultFormat(format);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("currentPath", engine.baseUrl());

    if(argc > 1) {
        qDebug() << "Path:" << argv[1];
        engine.rootContext()->setContextProperty("loadedFile", argv[1]);
    }
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
