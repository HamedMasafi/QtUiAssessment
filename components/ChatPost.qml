import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: item1
    property string message: ''
    property string author: ''
    property string authTime: ''
    property string lastReplyTime: ''
    property list<string> replies

    height: labelMessage.height + itemHeader.height + itemFooter.height + 16

    //    width: 300
    //    height: 300

    Image {
        id: imageAvatar
        x: 0
        y: 0
        width: 32
        height: 32
        source: "image://avatar/" + author.toLowerCase()
        fillMode: Image.PreserveAspectFit
    }


    RowLayout {
        id: itemHeader
        y: 0
        height: 32
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 46
        anchors.rightMargin: 9
        Layout.fillWidth: true

        Label {
            id: labelAuthor
            text: author
            font.bold: true

            Layout.alignment: Qt.AlignVCenter
        }

        Label {
            id: label2
            color: "#666666"
            text: authTime
            font.pointSize: 8
            Layout.alignment: Qt.AlignVCenter
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Label {
        id: labelMessage
        text: message
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        wrapMode: Text.WordWrap
        anchors.topMargin: 38
        anchors.leftMargin: 46
        anchors.rightMargin: 9
        Layout.fillWidth: true
    }

    RowLayout {
        id: itemFooter

        height: 24
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 46
        anchors.bottomMargin: 9
        anchors.rightMargin: 9
        Layout.fillWidth: true

        Repeater{
            model: replies
            Image {
                Layout.preferredHeight: 24
                Layout.preferredWidth: 24
                sourceSize: Qt.size(24, 24)
                source: "image://avatar/" + modelData
                fillMode: Image.PreserveAspectFit
            }
        }
        Label{
            color: "#3C71A6"
            text: {
                if (replies.length == 0)
                    return "No replies"
                else if (replies.length == 1)
                    return "1 reply"
                else
                    return replies.length + " replies"
            }
        }
        Label {
            color: 'gray'
            visible: replies.length > 0 && lastReplyTime != ''
            text: "Last reply at " + lastReplyTime
        }

        Item{
            Layout.fillWidth: true
        }
    }
}

