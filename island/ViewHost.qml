import QtQuick
import "../components" as Components

Item {
  id: root

  required property int islandState

  implicitWidth: loader.implicitWidth
  implicitHeight: loader.implicitHeight

  anchors.fill: parent

  // Components.AppLauncher {
  //   visible: IslandController.inslandState == IslandController.Launcher
  // }

  Loader {
    id: loader
    anchors.fill: parent

    // asynchronous: true

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
    onLoaded: {
      if (root.islandState === IslandController.Launcher && item) {
        // Option A: If your AppLauncher exposes a method or alias to the input
        if (typeof item.forceInputFocus === "function") {
          item.forceInputFocus(); } else {
          // Option B: Fallback if you want to force focus on the root of the launcher
          // item.forceActiveFocus();
        }
      }
    }
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
