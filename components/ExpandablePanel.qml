import QtQuick
import QtQuick.Layouts

Item {
    id: panel
    property bool isOpen: true
    property alias model: repeater.model
    property alias delegate: repeater.delegate
    property string title

    clip: true

    height: header.height + (itemsLayout.height * itemsLayout.opacity)
    Item {
        id: header

        height: 30
        clip: true
        width: parent.width

        RowLayout {
            Text {
                font.family: FontAwesome
                text: fa_caret_down
                rotation: isOpen ? 0 : -90
                color: "white"

                Behavior on rotation { NumberAnimation {} }
            }

            Text {
                text: panel.title
                color: "white"
            }
        }

        MouseArea {
            onClicked: isOpen = !isOpen
            anchors.fill: parent
        }
    }
    ColumnLayout {
        id: itemsLayout
        visible: opacity > 0
        opacity: isOpen ? 1 : 0
        Behavior on opacity { NumberAnimation{} }

        anchors{
            top: header.bottom
            left: parent.left
            right: parent.right
        }
        Repeater {
            id: repeater
        }
    }
}
