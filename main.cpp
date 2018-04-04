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
    backend.assignSensor("GP2Y0A710K0F", "pissoir");  //GP2D12, GP2Y0A02YK0F, GP2Y0A710K0F
    backend.assignSensor("GP2Y0A710K0F", "toilet");   //GP2D12, GP2Y0A02YK0F, GP2Y0A710K0F
    backend.assignSensor("GP2Y0A710K0F", "light");    //GP2D12, GP2Y0A02YK0F, GP2Y0A710K0F
    view.rootContext()->setContextProperty("Backend", &backend);

    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.show();

    return app.exec();
}
