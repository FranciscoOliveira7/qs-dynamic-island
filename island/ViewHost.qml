import QtQuick
import "../components" as Components

Item {
  id: root

  required property int islandState

  // implicitWidth: viewLoader.item ? viewLoader.item.implicitWidth : 0

  implicitWidth: loader.item ? loader.item.implicitWidth : 0
  implicitHeight: loader.item ? loader.item.implicitHeight : 0
  // implicitWidth: viewLoader.width
  // implicitHeight: viewLoader.height
  anchors.centerIn: parent

  Loader {
    id: loader
    anchors.centerIn: parent

    onLoaded: { fadeOut.stop(); fadeIn.start() }

    width: item ? item.implicitWidth : 0
    height: item ? item.implicitHeight : 0

    sourceComponent: {
      switch (root.islandState) {
        case IslandController.Default:
          return clock
        case IslandController.Expanded:
          return expanded
        case IslandController.Notification:
          return notifications
        case IslandController.Launcher:
          return launcher
      }
    }
  }

  NumberAnimation on opacity {
    id: fadeOut
    to: 0
    // onStopped: { loader.sourceComponent = sourceComponent }
  }

  NumberAnimation on opacity {
    id: fadeIn
    to: 1
  }

  Component {
    id: clock
    Components.Clock {}
  }

  Component {
    id: expanded
    Components.Idk {}
  }

  Component {
    id: notifications
    Components.NotificationPopUp {}
  }

  Component {
    id: launcher
    Components.AppLauncher {}
  }
}
