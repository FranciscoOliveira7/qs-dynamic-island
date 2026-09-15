import Quickshell
import QtQuick
import "island"
import QtQuick.Effects

// qmllint disable uncreatable-type
PanelWindow {

  exclusiveZone: 44
  implicitHeight: capsule.implicitHeight + 20
  anchors { top: true; left: true; right: true }
  // color: "#77ff0000"
  color: "transparent"

  RectangularShadow {
    anchors.fill: capsule

    radius: capsule.radius
    // offset.y: 1
    spread: 4
    blur: 0
    
    color: "#ffffff"
  }

  Island {
    id: capsule

    radius: 15
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
