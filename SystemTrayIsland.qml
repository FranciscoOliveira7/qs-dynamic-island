import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "./Theme.qml"

Rectangle {
  id: root

  clip: true

  implicitWidth: row.implicitWidth
  implicitHeight: 30

  color: Theme.background

  RowLayout {
    id: row
    anchors.centerIn: parent
    spacing: 8

    Repeater {
      model: SystemTray.items

      delegate: Rectangle {
        // Layout.fillWidth: true
        width: 30
        height: 30
        color: Theme.surface
        radius: width / 2

        IconImage {
          anchors.centerIn: parent

          implicitSize: 20
          source: modelData.icon
        }

        // QsMenuAnchor {
        //   menu: modelData.menu
        // }
      }
    }
  }

  Text {
    anchors.centerIn: parent

    color: Theme.textPrimary
    font.family: "JetbrainsMono Nerd Font"
    font.pixelSize: 18
    font.bold: true

    // text: root.foo.title
  }

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
}
