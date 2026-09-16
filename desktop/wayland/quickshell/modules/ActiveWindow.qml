import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.modules

Item {
	id: root
	required property var screen

    	implicitWidth: label.implicitWidth
	implicitHeight: label.implicitHeight

	readonly property var monitor: Hyprland.monitorFor(root.screen)

	readonly property var focusedOnThisMonitor: {
		for (const tl of Hyprland.toplevels.values) {
			if (tl.monitor === root.monitor && tl.activated) {
				return tl;
			}
		}
		return null;
	}

    	Text {
        	id: label
        	anchors.verticalCenter: parent.verticalCenter
        	color: Colors.textPrimary
        	font.pixelSize: 13
        	elide: Text.ElideRight

        	// activeToplevel may be null (e.g. on an empty workspace)
        	text: Hyprland.activeToplevel?.title ?? ""
	}
}
