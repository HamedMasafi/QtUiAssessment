#pragma once

#include <QString>

class QQmlApplicationEngine;
class FontAwesome
{
public:
#if QT_QML_LIB
    static bool init(const QQmlApplicationEngine *engine);
#endif

};

