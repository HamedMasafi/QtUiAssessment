#pragma once

#include <QAbstractItemModel>
#include <QQmlEngine>

#include <QIcon>

class ProfileModel : public QAbstractItemModel
{
    Q_OBJECT
    QML_ELEMENT

public:
    struct Node {
        QString title;
        QString icon;
        QList<Node *> childs;
        Node *parent;
        struct Feature *feature;
        int row{};
        QStringList data;
        QString key;
        QString prefix;
#ifdef ProfileModel_NODE_DATA_TYPE
        ProfileModel_NODE_DATA_TYPE metaData;
#endif
        Node()
            : parent(nullptr)
            , feature(nullptr)
        {
        }
        explicit Node(Node *parent)
            : parent(parent)
            , feature(nullptr)
        {
            row = parent->childs.count();
        }

        ~Node()
        {
            qDeleteAll(childs);
        }

        Node *createChild()
        {
            auto ch = new Node;
            ch->parent = this;
            ch->row = childs.count();
            childs.append(ch);
            return ch;
        }
        Node *find(const QString &title)
        {
            auto i = childs.begin();
            while (i != childs.end()) {
                if ((*i)->title == title)
                    return *i;
                ++i;
            }
            return nullptr;
        }

        void clear()
        {
            qDeleteAll(childs);
            childs.clear();
        }
    };

    explicit ProfileModel(QObject *parent = nullptr);

    QModelIndex index(const Node *node, int col) const;
    int rowCount(const QModelIndex &parent) const override;
    int columnCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QModelIndex index(int row, int column, const QModelIndex &parent) const override;
    QModelIndex parent(const QModelIndex &child) const override;
    QHash<int, QByteArray> roleNames() const override;

    QStringList rootData() const;
    QStringList data(const QModelIndex &index) const;
    QString fullPath(const QModelIndex &index) const;
    QString key(const QModelIndex &index) const;
    QString section(const QModelIndex &index) const;

    void addData(const QStringList &data, const QString &prefix = QString(), bool split = true);

    const QString &separator() const;
    void setSeparator(const QString &newSeparator);

    bool lastPartAsData() const;
    void setLastPartAsData(bool newLastPartAsData);

    const QIcon &defaultIcon() const;
    void setDefaultIcon(const QIcon &newDefaultIcon);

    void clear();

protected:
    Node *mRootNode = nullptr;

    Node *createPath(const QStringList &path);
    Node *find(QStringList &path, Node *node = nullptr);
    void getFullPath(QString &path, Node *node) const;

private:
    enum class Role {
        TitleRole = Qt::UserRole,
        IconRole
    };
    QString mSeparator{QStringLiteral("/")};
    bool mLastPartAsData{false};
    QIcon mDefaultIcon;
    bool mShowRoot{false};

    Node *_mentionAndReactionsNode;
    Node *_savedItemsNode;
    Node *_moreNode;
    Node *_channelsNode;
    Node *_directMessagesNode;

};
