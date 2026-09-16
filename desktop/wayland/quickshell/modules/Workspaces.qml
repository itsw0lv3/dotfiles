// Workspaces.qml
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.modules

Item {
    id: root
    required property var screen

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    readonly property var monitor: Hyprland.monitorFor(root.screen)

    RowLayout {
        id: layout
        anchors.fill: parent
        spacing: 6

        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                id: wsDelegate
                required property var modelData

                // Only show this workspace if it belongs to this bar's monitor
                visible: wsDelegate.modelData.monitor === root.monitor
                width: visible ? 24 : 0
                height: 24
                radius: 6
                color: wsDelegate.modelData.focused
                    ? Colors.workspaceFocused
                    : (wsDelegate.modelData.active ? Colors.workspaceActive : "transparent")
                border.width: wsDelegate.modelData.urgent ? 2 : 0
                border.color: Colors.workspaceUrgentBorder

                Text {
                    anchors.centerIn: parent
                    text: wsDelegate.modelData.name
                    color: wsDelegate.modelData.focused ? Colors.textOnAccent : Colors.textPrimary
                    font.pixelSize: 13
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: wsDelegate.modelData.activate()
                }
            }
        }
    }
}
