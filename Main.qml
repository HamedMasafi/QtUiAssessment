import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import "./components"
import QtUiAssessment

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint | Qt.Window
    property real resizeHandlerSize: 5

    ProfileModel {
        id: profileModel
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: {
            const p = Qt.point(mouseX, mouseY);
            const b = resizeHandlerSize + 10; // Increase the corner size slightly
            if (p.x < b && p.y < b) return Qt.SizeFDiagCursor;
            if (p.x >= width - b && p.y >= height - b) return Qt.SizeFDiagCursor;
            if (p.x >= width - b && p.y < b) return Qt.SizeBDiagCursor;
            if (p.x < b && p.y >= height - b) return Qt.SizeBDiagCursor;
            if (p.x < b || p.x >= width - b) return Qt.SizeHorCursor;
            if (p.y < b || p.y >= height - b) return Qt.SizeVerCursor;
        }
        acceptedButtons: Qt.NoButton // don't handle actual events
    }
    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.TakeOverForbidden
        target: null
        onActiveChanged: {
            if (active) {
                const p = resizeHandler.centroid.position;
                const b = resizeHandlerSize + 10; // Increase the corner size slightly
                let e = 0;
                if (p.x < b) { e |= Qt.LeftEdge }
                if (p.x >= width - b) { e |= Qt.RightEdge }
                if (p.y < b) { e |= Qt.TopEdge }
                if (p.y >= height - b) { e |= Qt.BottomEdge }
                window.startSystemResize(e);
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        border.color: '#3F0F3F'
    }

    Rectangle {
        id: titleBar
        color: '#301134'
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 30

        RowLayout {
            anchors{
                leftMargin: resizeHandlerSize * 2
                topMargin: resizeHandlerSize
                rightMargin: resizeHandlerSize * 2
                fill: parent
            }

            Rectangle {
                height: 12
                width: 12
                radius: 6
                color: '#ED6A5E'
            }

            Rectangle {
                height: 12
                width: 12
                radius: 6
                color: '#F4BD4F'
            }

            Rectangle {
                height: 12
                width: 12
                radius: 6
                color: '#61C354'
            }
            Item { Layout.fillWidth: true }

            Text {
                font.family: FontAwesome
                text: fa_arrow_left
                color: 'white'
            }
            Text {
                font.family: FontAwesome
                text: fa_arrow_right
                color: "#8f8f8f"
            }

            Text {
                color: 'white'
                font.family: FontAwesome
                text: fa_clock_o
            }

            TextField {
                Layout.preferredWidth: 500
                placeholderText: "Search DesignersKR"
                placeholderTextColor: '#bbbbbb'
                color: 'white'
                background: Rectangle {
                    color: '#3E2142'
                }
                leftPadding: 24
                Label {
                    id: searchIcon
                    color: 'white'
                    font.family: FontAwesome
                    text: fa_search
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Text {
                color: 'white'
                font.family: FontAwesome
                text: fa_question_circle
            }

            Item { Layout.fillWidth: true }

        }
    }

    RowLayout {
        anchors{
            fill: parent
            leftMargin: resizeHandlerSize
            rightMargin: resizeHandlerSize
            topMargin: titleBar.height
            bottomMargin: resizeHandlerSize
        }
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
