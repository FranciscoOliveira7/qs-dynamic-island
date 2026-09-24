import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

import "island"

// qmllint disable uncreatable-type
PanelWindow {

  exclusiveZone: 44
  implicitHeight: capsule.implicitHeight + 20
  anchors { top: true; left: true; right: true }
  // color: "#77ff0000"
  color: "transparent"

  // WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.keyboardFocus: capsule.isKeyboardFocused ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
  WlrLayershell.namespace: "quickshell-launcher"

  // Notifications {}
  
  // Rectangle {
  //   anchors.fill: parent
  //   color: "#77ff0000"
  // }

  Rectangle {
    anchors { left: parent.left; top: parent.top }
    anchors.leftMargin: 200
    width: 70
    height: 40

    color: "#77ff0000"
    
    // TextInput {
    //   id: searchInput
    //   height: 20
    //   width: 50
    //   anchors.fill: parent
    //   color: "white"
    //   selectionColor: "green"
    //   focus: true
    //   activeFocusOnPress: false
    //   font {
    //     pixelSize: 13
    //     family: "JetBrainsMono Nerd Font"
    //   }
    //   verticalAlignment: TextInput.AlignVCenter
    //   clip: true
    //   text: "balls"

    //   onTextEdited: root.searchQuery = text
    // }
  }

  RectangularShadow {
    anchors.fill: capsule

    radius: capsule.radius - spread / 4
    // offset.y: 1
    // spread: 4
    // blur: 0
    
    // color: Theme.border
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

  // SystemTrayIsland {
  //   id: systray

  //   radius: 15
  //   anchors.left: capsule.right
  //   anchors.leftMargin: 16
  //   anchors.top: capsule.top
  // }

  // Prevents the panel window from stealing the cursor input
  Region {
    id: capsuleMask

    item: capsule
    // Region {
    //   item: systray
    // }
  }

  mask: capsuleMask
}
