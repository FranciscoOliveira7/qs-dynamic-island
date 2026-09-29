import Quickshell
import Quickshell.Wayland
import QtQuick

// qmllint disable uncreatable-type
PanelWindow {
  anchors { top: true; left: true; right: true; bottom: true }

  WlrLayershell.layer: WlrLayer.Background
  WlrLayershell.exclusionMode: ExclusionMode.Ignore 

  color: "#22ff00ff"
  Image {
    fillMode: Image.PreserveAspectCrop
    anchors.fill: parent
    // source: appRow.modelData.icon !== "" ? "image://icon/" + appRow.modelData.icon : ""
    source: "/home/francisco/Pictures/wallpapers/wallhaven-xedzpo.png"
  }
}
