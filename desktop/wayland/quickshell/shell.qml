import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.modules

ShellRoot {
	Variants {
		model: Quickshell.screens

		PanelWindow {
			id: bar
			required property var modelData
			screen: modelData

			WlrLayershell.namespace: "shell:bar"

			anchors {
				top: true
				left: true
				right: true
			}
			implicitHeight: 30

			color: "transparent"

			Rectangle {
				anchors.fill: parent
				color: Colors.barBackground
			}

			Workspaces {
				id: workspacesModule
				screen: bar.modelData
				anchors.verticalCenter: parent.verticalCenter
				anchors.left: parent.left
				anchors.leftMargin: 8
			}

			ActiveWindow {
				screen: bar.modelData
				anchors.verticalCenter: parent.verticalCenter
				anchors.left: workspacesModule.right
				anchors.leftMargin: 12
			}
		}
	}
}
