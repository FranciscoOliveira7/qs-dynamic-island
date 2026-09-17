import Quickshell
import QtQuick
import QtQuick.Effects

import "island"

// qmllint disable uncreatable-type
PanelWindow {

  exclusiveZone: 44
  // implicitHeight: capsule.implicitHeight + 20
  anchors { top: true; left: true; right: true }
  // color: "#77ff0000"
  color: "transparent"

  RectangularShadow {
    anchors.fill: capsule

    radius: capsule.radius - spread / 4
    // offset.y: 1
    spread: 4
    blur: 0
    
    color: Theme.border
  }

  Island {
    id: capsule

    radius: 15
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 10

  }

  RectangularShadow {
    anchors.fill: systray

    radius: capsule.radius - spread / 4
    // offset.y: 1
    spread: 4
    blur: 0
    
    color: Theme.border
  }

  SystemTrayIsland {
    id: systray

    radius: 15
    anchors.left: capsule.right
    anchors.leftMargin: 16
    anchors.top: capsule.top
  }

  // Region {
  //   id: capsuleMask

  //   item: rect
  // }

  // Rectangle {
  //   id: rect

  //   anchors.centerIn: parent
  //   width: 100
  //   height: 100
  // }

  // mask: capsuleMask
}
