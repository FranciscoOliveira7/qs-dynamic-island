import QtQuick

Rectangle {
  id: root

  clip: true

  width: implicitWidth
  height: implicitHeight

  implicitWidth: viewHost.implicitWidth
  implicitHeight: viewHost.implicitHeight

  color: "black"

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

  IslandInputHandler {
    id: inputHandler

    anchors.fill: parent
  }

  ViewHost {
    id: viewHost

    anchors.centerIn: parent
  }
}
