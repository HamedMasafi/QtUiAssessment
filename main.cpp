#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "fontawesome/fontawesome.h"
#include "avatarprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    FontAwesome::init(&engine);
    engine.addImageProvider("avatar", new AvatarProvider);

    const QUrl url(u"qrc:/QtUiAssessment/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
