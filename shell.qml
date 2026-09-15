import Quickshell
import QtQuick
import "island"

// qmllint disable uncreatable-type
PanelWindow {

  exclusiveZone: 44
  implicitHeight: capsule.implicitHeight + 20
  anchors { top: true; left: true; right: true }
  // color: "#77ff0000"
  color: "transparent"

  Island {
    id: capsule

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 10
  }

  Region {
    id: capsuleMask

    item: capsule
  }

  mask: capsuleMask
}
