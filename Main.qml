import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import "./components"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    RowLayout {
        anchors.fill: parent
        spacing: 1

        Rectangle {
            Layout.fillHeight: true
            Layout.preferredWidth: 40
            width: 40
            color: "#3F0F3F"

            ColumnLayout {
                anchors.fill: parent
                SidebarButton {
                    text: "A"
                    Layout.alignment: Qt.AlignHCenter
                }
                SidebarButton {
                    text: "B"
                    Layout.alignment: Qt.AlignHCenter
                }
                SidebarButton {
                    text: "C"
                    Layout.alignment: Qt.AlignHCenter
                }

                Item {
                    Layout.fillHeight: true
                }
            }
        }
        UserSideMenu {
            Layout.fillHeight: true
            Layout.preferredWidth: 200
        }

        ChatView {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

}
