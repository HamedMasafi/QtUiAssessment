import QtQuick
import QtQuick.Controls

Item {
    property string text
    width: 38
    height: 38


    Rectangle {
        border.color: "white"
        visible: mouse.containsPress
        border.width: 2
        anchors.fill: parent
        radius: 5
    }

    Rectangle {
        color: "#616061"
        anchors{
            fill: parent
            bottomMargin: 3
            rightMargin: 3
            leftMargin: 3
            topMargin: 3
        }

        radius: 5
    }

    Text {
        anchors.centerIn: parent
        text: parent.text
        font.bold: true
        color: "white"
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
    }
}
