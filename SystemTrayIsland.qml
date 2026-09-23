import Quickshell
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
        width: 30
        height: 30
        color: Theme.surface
        radius: width / 2

        IconImage {
          anchors.centerIn: parent

          implicitSize: 20
          source: modelData.icon
        }

        HoverHandler {
          cursorShape: Qt.PointingHandCursor
        }

        TapHandler {
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          onTapped: (eventPoint, button) => {
            console.log("test")
            if (button & Qt.RightButton) {
              // modelData.secondaryActivate()
              if (modelData.hasMenu) {
                menuAnchor.open()
              }
            } else {
              modelData.activate()
            }
          }
        }
        QsMenuOpener {
          id: rootMenu
          menu: modelData.menu
        }
        // Rectangle {
        //   // anchors.top: parent
        //   width: 20
        //   height: 20


        //   Text {
        //     text: rootMenu.children[0].text
        //   }
        // }
        QsMenuAnchor {
          id: menuAnchor
          // anchor.window: parent.window
          menu: modelData ? modelData.menu : null

          // Define onde o menu vai abrir (alinha-se à tua janela/ícone)
          anchor.window: Quickshell.window
          anchor.rect: Qt.rect(trayItemArea.x, trayItemArea.y, trayItemArea.width, trayItemArea.height)
          anchor.edges: Edges.Bottom // Abre para baixo do ícone
        }
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
