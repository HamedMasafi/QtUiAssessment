#include "avatarprovider.h"

AvatarProvider::AvatarProvider() : QQuickImageProvider{QQuickImageProvider::Pixmap}
{

}

QPixmap AvatarProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    return QPixmap{"/doc/dev/tmp/QtUiAssessment/avatars/" + id + ".png"};
}
