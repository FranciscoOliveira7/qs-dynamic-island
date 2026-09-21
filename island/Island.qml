import QtQuick
import ".."

Rectangle {
  id: root

  clip: true

  // width: implicitWidth
  // height: implicitHeight

  implicitWidth: viewHost.implicitWidth
  implicitHeight: Math.max(30, viewHost.implicitHeight) 

  color: Theme.background

  Behavior on implicitWidth {
    NumberAnimation {
      duration: 300
      easing.type: Easing.OutBack
    }
  }

  Behavior on implicitHeight {
    NumberAnimation {
      duration: 300
      easing.type: Easing.OutCubic
    }
  }

  // IslandInputHandler {
  //   id: inputHandler

  //   anchors.fill: parent
  // }

  HoverHandler {
    id: hoverHandler

    onHoveredChanged: controller.hovered = hovered
  }

  IslandController {
    id: controller
  }

  ViewHost {
    id: viewHost

    anchors.centerIn: parent
  }
}
