import QtQuick
import QtQuick.Controls 6.3
import QtQuick.Layouts 6.3

Item {
    id: item1
    property string message: ''
    property string author: ''

    height: labelMessage.height + itemHeader.height + itemFooter.height + 16

    //    width: 300
    //    height: 300
    //    property list<string> replies

    Image {
        id: imageAvatar
        x: 0
        y: 0
        width: 32
        height: 32
        //        source: "qrc:/qtquickplugin/images/template_image.png"
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
            text: qsTr("6:49 PM --- ")
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
        y: 238
        height: 44
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 46
        anchors.bottomMargin: 9
        anchors.rightMargin: 9
        Layout.fillWidth: true

        //            Repeater{
        //                model: replies
        //            }
        //            Label{
        //                text: {
        //                    if (replies.length == 0)
        //                        return "No replies"
        //                    else if (replies.length == 1)
        //                        return "1 reply"
        //                    else
        //                        return replies.length + " replies"
        //                }
        //            }
    }
}

