#ifndef FONTAWESOME_H
#define FONTAWESOME_H

#include <QString>
//#include "fonticons.h"

class QQmlApplicationEngine;
class FontAwesome
{
public:
    const QString fa;
#include "tool/_fontawesome_defines.h"
//#define X(name, data) static const QString fa_##name;
//    __fa_foreach(X)
//#include "tool/_fontawesome_undefs.h"

public slots:
#if QT_QML_LIB
    static bool init(const QQmlApplicationEngine *engine);
#endif

};

#endif // FONTAWESOME_H
