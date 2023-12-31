#include "chatmodel.h"


ChatModel::ChatModel(QObject *parent) : QAbstractListModel{parent}
{

}

int ChatModel::rowCount(const QModelIndex &parent) const
{
    return _data.size();
}

QHash<int, QByteArray> ChatModel::roleNames() const
{
    return {
        {(int) Roles::AuthorRole, "author"},
        {(int) Roles::TextRole, "message"},
        {(int) Roles::RepliesRole, "replies"},
        {(int) Roles::AuthTimeRole, "authTime"},
        {(int) Roles::AuthDateRole, "authDate"},
        {(int) Roles::AuthDateTimeRole, "authDateTime"},
        {(int) Roles::LastReplyDateTimeRole, "lastReplyDateTime"},
        {(int) Roles::ReactionsRole, "reactions"}
    };
}

void ChatModel::fillSampleData()
{
    beginResetModel();
    auto d1 = new ChatModelItem{"Kamran",
                                R"(봄날의 햇살 따라 새벽길을 걷네, 작은 꽃들이 눈부신 향기를 품고 서로 맞닿아 웃네. 나비들은 춤추며 색다른 세계를 만들어가고, 그 속에서 나는 풍경에 녹아들어 자유롭게 흘러가네.

어린 그림자들이 덧없이 노래하며 흐르고, 푸른 하늘은 감탄을 자아내며 펼쳐진다. 저 멀리 산들은 우리에게 약속을 전하고, 물결처럼 흐르는 강물은 시간을 담고 흘러간다.
끝없이 이어지는 세상의 수레바퀴, 그 안에서 나는 작은 하나의 이야기가 되어 흘러간다.)"};
    d1->dateTime = QDateTime{QDate{2023, 10, 1}, QTime{18, 49}};
    d1->replies = QStringList{} << "1"
                                << "2"
                                << "3";

    auto d2 = new ChatModelItem{"Kamran",
                                R"(봄날의 햇살 따라 새벽길을 걷네, 작은 꽃들이 눈부신 향기를 품고 서로 맞닿아 웃네. 나비들은 춤추며 색다른 세계를 만들어가고, 그 속에서 나는 풍경에 녹아들어 자유롭게 흘러가네.

어린 그림자들이 덧없이 노래하며 흐르고, 푸른 하늘은 감탄을 자아내며 펼쳐진다. 저 멀리 산들은 우리에게 약속을 전하고, 물결처럼 흐르는 강물은 시간을 담고 흘러간다.
끝없이 이어지는 세상의 수레바퀴, 그 안에서 나는 작은 하나의 이야기가 되어 흘러간다.)"};
    d2->dateTime = QDateTime{QDate{2023, 10, 2}, QTime{18, 49}};
    d2->replies = QStringList{} << "1"
                                << "2"
                                << "3"
                                << "4"
                                << "5";

    auto d3 = new ChatModelItem{"Heal", "그 안에서 나는 작은 하나의 이야기가 되어 흘러간다."};
    d3->dateTime = QDateTime{QDate::currentDate(), QTime{15, 34}};
    _data << d1 << d2 << d3;

    endResetModel();
}

QVariant ChatModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= _data.size())
        return {};

    switch ((Roles)role) {
    case Roles::TextRole:
        return _data.at(index.row())->text;
        break;
    case Roles::AuthorRole:
        return _data.at(index.row())->author;
        break;
    case Roles::AuthDateTimeRole:
        return _data.at(index.row())->dateTime;
        break;
    case Roles::RepliesRole:
        return _data.at(index.row())->replies;
        break;
    case Roles::LastReplyDateTimeRole:
        return _data.at(index.row())->lastReplyTime;
    case Roles::ReactionsRole:
        break;
    case Roles::AuthTimeRole:
        return _data.at(index.row())->dateTime.toString("hh:mm AP");
    case Roles::AuthDateRole:
        return _data.at(index.row())->dateTime.toString("dddd, MMMM d");
    }

    return QVariant{};
}

ChatModelItem::ChatModelItem(QString author, QString text)
    : text(std::move(text))
    , author(std::move(author))
{}
