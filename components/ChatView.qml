import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtUiAssessment

Page {
    id: item2

    ChatModel {
        id: chatModel
    }

    Component.onCompleted: chatModel.fillSampleData()

    header: Rectangle {
        id: header
        height: 73

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
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom
            height: 1
            color: 'gray'
        }

    }

    Component {
        id: sectionComponent
        Item {
            required property string section
            height: 30
            width: parent.width

            Rectangle{
                color: 'gray'
                anchors{
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                height: 1
            }

            Rectangle{
                anchors{
                    topMargin: -4
                    leftMargin: -7
                    rightMargin: -7
                    bottomMargin: -4
                    fill: layoutLabel
                }
                radius: 9
                border.width: 1
                border.color: 'gray'
            }
            RowLayout {
                id: layoutLabel
                anchors.centerIn: parent
                Label {
                    id: labelSection
                    text: section
                }
                Label {
                    font.family: FontAwesome
                    text: fa_chevron_down
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent

        ListView {
            id: listView
            clip: true
            model: chatModel
            anchors.fill: parent

            section.criteria: ViewSection.FullString
            section.property: "authDate"
            section.delegate: sectionComponent

            delegate: ChatPost {
                message: model.message
                author: model.author
                authTime: model.authTime
                replies: model.replies
                lastReplyTime: model.lastReplyDateTime

                width: parent == null ? 0 :  parent.width
            }
        }
    }
    footer: Rectangle {
        id: writeBox
        height: 110

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
