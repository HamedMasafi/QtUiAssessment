#pragma once

#include <QAbstractListModel>
#include <QDateTime>
#include <QQmlEngine>

struct ChatModelItem{
    ChatModelItem(QString author, QString text);
    QString text;
    QString author;
    QDateTime dateTime;
    QString avatar;

    QStringList replies;
    QDateTime lastReplyTime;


};
class ChatModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    enum class Roles{
        AuthorRole,
        TextRole,
        RepliesRole,
        AuthTimeRole,
        AuthDateRole,
        AuthDateTimeRole,
        LastReplyDateTimeRole,
        ReactionsRole
    };
    ChatModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void fillSampleData();

private:
    QList<ChatModelItem*> _data;

};

