import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    Layout.fillHeight: true
    Layout.preferredWidth: 200
    color: "#3F0F3F"

    TreeView {
        anchors{
            leftMargin: 9
            rightMargin: 9
            topMargin: 9
            bottomMargin: 9
            fill: parent
        }
        model: profileModel

        delegate: Item {
            id: treeDelegate

            implicitWidth: padding + label.x + label.implicitWidth + padding
            implicitHeight: label.implicitHeight * 1.5

            readonly property real indent: 20
            readonly property real padding: 5

            // Assigned to by TreeView:
            required property TreeView treeView
            required property bool isTreeNode
            required property bool expanded
            required property int hasChildren
            required property int depth

            TapHandler {
                onTapped: treeView.toggleExpanded(row)
            }

            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: 24 * depth
                }

                Text {
                    id: indicator
                    visible: treeDelegate.isTreeNode && treeDelegate.hasChildren
//                            x: padding + (treeDelegate.depth * treeDelegate.indent)
                    Layout.alignment: Qt.AlignVCenter
                    text: "▸"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    rotation: treeDelegate.expanded ? 90 : 0
                    color: 'white'

                    Layout.preferredWidth: 24
                    Behavior on rotation { NumberAnimation{} }
                }
                Image {
                    source: model.icon
                    fillMode: Image.PreserveAspectFit
                    Layout.preferredHeight: label.height
                    Layout.preferredWidth: 24
                    sourceSize: Qt.size(24, 24)
                    Layout.alignment: Qt.AlignVCenter

                    visible: !(treeDelegate.isTreeNode && treeDelegate.hasChildren)
                }
                Text {
                    id: label
//                    x: padding + (treeDelegate.isTreeNode ? (treeDelegate.depth + 1) * treeDelegate.indent : 0)
//                    width: treeDelegate.width - treeDelegate.padding - x
                    clip: true
                    text: model.display
                    color: 'white'
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                }
            }
        }
    }
}

