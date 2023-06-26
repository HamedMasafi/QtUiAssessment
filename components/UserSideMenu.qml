import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {

    ScrollBar.vertical.policy: ScrollBar.AlwaysOn

    background: Rectangle{
        color: "#3F0F3F"
    }
    component MenuItem : ItemDelegate {
        id: control
        Layout.fillWidth: true

        contentItem: Text {
            rightPadding: control.spacing
            text: control.text
            font: control.font
            color: control.enabled ? (control.down ? "#17a81a" : "white") : "#bdbebf"
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            color: "#3F0F3F"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        MenuItem {
            text: "Mentions & reactions"
        }
        MenuItem {
            text: "Saved items"
        }
        MenuItem {
            text: "More"
        }

        ExpandablePanel{
            model: 7
            title: "Channels"
            Layout.fillWidth: true
            Layout.preferredHeight: height
            delegate: ItemDelegate{
                text: "channel-" + (index + 1)
            }
        }
        ExpandablePanel{
            Layout.fillWidth: true
            Layout.preferredHeight: height
        }
    }
}
