#include "avatarprovider.h"

#include <QGuiApplication>

AvatarProvider::AvatarProvider() : QQuickImageProvider{QQuickImageProvider::Pixmap}
{

}

QPixmap AvatarProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
#ifdef QT_DEBUG
    return QPixmap{AVATAR_DIRS "/" + id.toLower() + ".png"};
#else
    return QPixmap{qApp->applicationDirPath() + "/avatars/" + id.toLower() + ".png"};
#endif
}
