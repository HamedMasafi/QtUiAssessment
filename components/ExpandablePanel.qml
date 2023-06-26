import QtQuick
import QtQuick.Layouts

Item {
    id: panel
    property bool isOpen: true
    property alias model: repeater.model
    property alias delegate: repeater.delegate
    property string title

    height: header.height + (isOpen ? itemsLayout.height : 0)
    Rectangle {
        id: header
        color: 'red'
        height: 30
        clip: true
        width: parent.width

        Text {
            text: panel.title + panel.isOpen
            color: "white"
        }

        MouseArea {
            onClicked: isOpen = !isOpen
            anchors.fill: parent
        }
    }
    ColumnLayout {
        id: itemsLayout
        visible: panel.isOpen

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
