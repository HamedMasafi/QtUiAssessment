import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtUiAssessment

Control {
    id: item2

    ChatModel {
        id: chatModel
    }

    Component.onCompleted: chatModel.fillSampleData()

    Item {
        id: header
        height: 73
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        RowLayout {
            id: rowLayout
            anchors.fill: parent
            anchors.leftMargin: 9
            anchors.bottomMargin: 9
            anchors.topMargin: 9
            ColumnLayout {
                id: columnLayout

                Label {
                    text: "channel-6"
                }

                RowLayout {
                    Label{
                        text: "13"
                    }
                    ToolSeparator {}
                    Label{
                        text: "Channel for member 6"
                    }
                }
            }
        }

    }

    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: writeBox.top
        clip: true
        model: chatModel
        section.property: "authDateTime"
        section.delegate: Rectangle{
            color: 'red'
            height: 10
        }

        delegate: ChatPost {
            message: "MSG:"+model.message
            author: model.author
            width: parent.width
        }
    }

    /*ScrollView {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: writeBox.top
        ColumnLayout {
            width: parent.width
            Repeater {
                model: chatModel
                delegate: ChatPost {
                    message: "MSG:"+model.message
                    author: model.author
                    height: 100
                    width: parent.width
                }
            }
        }
    }*/

    Item {
        id: writeBox
        y: 393
        height: 110
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Rectangle {
            id: rectangle
            color: "#ffffff"
            radius: 14
            border.color: "#747474"
            anchors.fill: parent
            anchors.rightMargin: 15
            anchors.leftMargin: 15
            anchors.bottomMargin: 15
            anchors.topMargin: 15

            TextArea {
                id: textEdit
                placeholderText: "Message #uxui_design"

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: item1.top
                font.pixelSize: 12
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.bottomMargin: 10
                anchors.topMargin: 10
            }

            RowLayout {
                id: item1
                y: 142
                height: 33
                anchors{
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    leftMargin: 10
                    rightMargin: 10
                }

                AwesomeIconButton{
                    text: fa_bold
                }

                ToolSeparator{}

                AwesomeIconButton{
                    text: fa_bold
                }

                AwesomeIconButton{
                    text: fa_italic
                }

                AwesomeIconButton{
                    text: fa_code
                }
                AwesomeIconButton{
                    text: fa_link
                }
                AwesomeIconButton{
                    text: fa_list_alt
                }
                AwesomeIconButton{
                    text: fa_list_ol
                }
                AwesomeIconButton{
                    text: fa_list_ul
                }
                Item{
                    Layout.fillWidth: true
                }
                AwesomeIconButton{
                    text: fa_smile_o
                }
                AwesomeIconButton{
                    text: fa_send
                }
            }
        }
    }

}
