#include "profilemodel.h"

#include <QModelIndex>

const QString &ProfileModel::separator() const
{
    return mSeparator;
}

void ProfileModel::setSeparator(const QString &newSeparator)
{
    mSeparator = newSeparator;
}

bool ProfileModel::lastPartAsData() const
{
    return mLastPartAsData;
}

void ProfileModel::setLastPartAsData(bool newLastPartAsData)
{
    mLastPartAsData = newLastPartAsData;
}

const QIcon &ProfileModel::defaultIcon() const
{
    return mDefaultIcon;
}

void ProfileModel::setDefaultIcon(const QIcon &newDefaultIcon)
{
    mDefaultIcon = newDefaultIcon;
}

void ProfileModel::clear()
{
    beginRemoveRows(QModelIndex(), 0, mRootNode->childs.count() - 1);
    qDeleteAll(mRootNode->childs);
    mRootNode->childs.clear();
    endRemoveRows();
}

ProfileModel::ProfileModel(QObject *parent)
    : QAbstractItemModel(parent)
    , mRootNode(new Node)
{
    beginResetModel();
    _mentionAndReactionsNode = mRootNode->createChild();
    _savedItemsNode = mRootNode->createChild();
    _moreNode = mRootNode->createChild();
    _channelsNode = mRootNode->createChild();
    _directMessagesNode = mRootNode->createChild();

    _mentionAndReactionsNode->title = "Mentions & reactions";
    _mentionAndReactionsNode->icon = "qrc:/icons/at.png";
    _savedItemsNode->title = "Saved items";
    _savedItemsNode->icon = "qrc:/icons/bookmark.png";
    _moreNode->title = "More";
    _moreNode->icon = "qrc:/icons/more.png";
    _channelsNode->title = "Channels";
    _directMessagesNode->title = "Direct messages";

    for (int i = 0; i < 6; ++i) {
        auto n = _channelsNode->createChild();
        n->title = QStringLiteral("channel-%1").arg(i);
        n->icon = "qrc:/icons/hash.png";
    }

    auto addDirectMessage = [this](const QString &userName) {
        auto n = _directMessagesNode->createChild();
        n->title = userName;
        n->icon = "image://avatar/" + userName;
    };
    addDirectMessage("HHH");
    addDirectMessage("Heal");
    addDirectMessage("Kamran");
    endResetModel();
}

QModelIndex ProfileModel::index(const Node *node, int col) const
{
    if (node->parent)
        return index(node->row, col, index(node->parent, col));

    return index(node->row, col, QModelIndex());
}

int ProfileModel::rowCount(const QModelIndex &parent) const
{
    Node *parentItem;
    if (parent.column() > 0)
        return 0;

    if (!parent.isValid())
        parentItem = mRootNode;
    else
        parentItem = static_cast<Node *>(parent.internalPointer());

    return parentItem->childs.count();
}

int ProfileModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return 1;
}

QVariant ProfileModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return {};

    switch ((Role)role) {

    case Role::TitleRole:
        return static_cast<Node *>(index.internalPointer())->title;

    case Role::IconRole:
        return static_cast<Node *>(index.internalPointer())->icon;
    }
    if (role == Qt::DisplayRole && index.column() == 0) {
        Node *item = static_cast<Node *>(index.internalPointer());

        return item->title;
    } else if (role == Qt::DecorationRole) {
        return mDefaultIcon;
    }

    return {};
}

QModelIndex ProfileModel::index(int row, int column, const QModelIndex &parent) const
{
    if (!hasIndex(row, column, parent))
        return {};

    Node *parentItem;

    if (!parent.isValid())
        parentItem = mRootNode;
    else
        parentItem = static_cast<Node *>(parent.internalPointer());

    Node *childItem = parentItem->childs.at(row);
    if (childItem)
        return createIndex(row, column, childItem);
    return {};
}

QModelIndex ProfileModel::parent(const QModelIndex &child) const
{
    if (!child.isValid())
        return {};

    Node *childItem = static_cast<Node *>(child.internalPointer());
    Node *parentItem = childItem->parent;

    if (parentItem == mRootNode)
        return {};

    return createIndex(parentItem->row, 0, parentItem);
}

QHash<int, QByteArray> ProfileModel::roleNames() const
{
    return {
        {(int)Role::TitleRole, "display"},
        {(int)Role::IconRole, "icon"}
    };
}

QStringList ProfileModel::rootData() const
{
    return mRootNode->data;
}

QStringList ProfileModel::data(const QModelIndex &index) const
{
    return static_cast<Node *>(index.internalPointer())->data;
}

QString ProfileModel::fullPath(const QModelIndex &index) const
{
    QString path;

    if (index.isValid())
        getFullPath(path, static_cast<Node *>(index.internalPointer()));
    else
        getFullPath(path, mRootNode);

    return path;
}

QString ProfileModel::key(const QModelIndex &index) const
{
    auto node = static_cast<Node *>(index.internalPointer());
    if (node)
        return node->key;
    return {};
}

QString ProfileModel::section(const QModelIndex &index) const
{
    auto node = static_cast<Node *>(index.internalPointer());
    if (node)
        return node->prefix;
    return {};
}

void ProfileModel::addData(const QStringList &data, const QString &prefix, bool split)
{
    for (const auto &p : data) {
        auto path = p;
        path = path.remove(QLatin1Char('\r')).remove(QLatin1Char('\n')).trimmed();
        if (path.isEmpty())
            continue;

        ProfileModel::Node *node;

        if (split) {
            auto nodePath = path;
            if (!prefix.isEmpty())
                nodePath.prepend(prefix + mSeparator);

            auto parts = nodePath.split(mSeparator);
            if (mLastPartAsData) {
                auto data = parts.takeLast();
                if (mShowRoot)
                    node = createPath(QStringList() << mSeparator << parts);
                else
                    node = createPath(parts);

                if (mShowRoot && node != mRootNode)
                    node->data.append(data);
                auto nodePathParts = nodePath.split(mSeparator);
                nodePathParts.takeLast();
                node->key = nodePathParts.join(mSeparator);
            } else {
                node = createPath(parts);
                node->key = path;
            }
        } else {
            if (!prefix.isEmpty())
                node = createPath({prefix, path});
            else
                node = createPath({path});
            node->key = path;
        }
        if (node) {
            node->prefix = prefix;
        }
    }
    beginInsertRows(QModelIndex(), 0, mRootNode->childs.count() - 1);
    endInsertRows();
}

ProfileModel::Node *ProfileModel::find(QStringList &path, Node *node)
{
    if (path.empty())
        return nullptr;

    auto ch = node->find(path.first());
    if (!ch)
        return nullptr;

    auto p = path;
    p.removeFirst();
    return find(p, ch);
}

ProfileModel::Node *ProfileModel::createPath(const QStringList &path)
{
    Node *parent = mRootNode;
    for (const auto &p : path) {
        auto child = parent->find(p);
        if (!child) {
            child = parent->createChild();
            child->title = p;
        }
        parent = child;
    }
    return parent;
}

void ProfileModel::getFullPath(QString &path, Node *node) const
{
    if (mShowRoot && node == mRootNode)
        return;
    if (node) {
        path.prepend(node->title);

        if ((mShowRoot && node->parent->parent != mRootNode) && node->parent != mRootNode) {
            path.prepend(mSeparator);
            getFullPath(path, node->parent);
        }
    }
}

