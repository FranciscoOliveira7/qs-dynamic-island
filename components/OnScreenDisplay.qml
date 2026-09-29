import QtQuick

import "../services" as Services
import ".."

Item {
  implicitWidth: row.implicitWidth + 24
  implicitHeight: 30

  anchors.verticalCenter: parent.verticalCenter

  property string icon: {
    const volume = Services.OSDService.volume
    if (Services.OSDService.muted) {
      return ""
    }
    if (volume <= 0) {
      return ""
    }
    if (volume < 0.3) {
      return ""
    }
    if (volume < 0.6) {
      return ""
    }
    return ""
  }

  Row {
    id: row
    anchors.centerIn: parent
    spacing: 8
    MainText {
      width: 20
      text: icon
    }
    Rectangle {
      id: slider
      property real percentage: Services.OSDService.volume

      anchors.verticalCenter: parent.verticalCenter
      implicitWidth: 150
      implicitHeight: 10
      radius: height * 0.5

      color: Theme.surface

      Rectangle {
        anchors {
          top: parent.top
          left: parent.left
          bottom: parent.bottom
        }
        radius: height * 0.5
        implicitWidth: parent.implicitWidth * slider.percentage
      }
    }
  }
}
