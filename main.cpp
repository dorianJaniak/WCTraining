#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>

#include "backend.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;

    Backend backend;
    backend.assignSensor("GP2D12", "pissoir");
    backend.assignSensor("GP2Y0A02YK0F", "throne");
    backend.assignSensor("GP2Y0A710K0F", "light");
    view.rootContext()->setContextProperty("Backend", &backend);

    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.show();

    return app.exec();
}
