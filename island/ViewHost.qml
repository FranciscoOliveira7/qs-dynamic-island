import QtQuick
import "../components" as Components

Item {
  id: root

  // implicitWidth: viewLoader.item ? viewLoader.item.implicitWidth : 0
  property var sourceComponent: {
    switch (IslandState.state) {
      case IslandState.defaultState:
        return clock
      case IslandState.expandedState:
        return test
    }
  }

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
      switch (IslandState.state) {
        case IslandState.Default:
          return clock
        case IslandState.Expanded:
          return test
        case IslandState.State.Notification:
          return notifications
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
    id: test
    Components.Idk {}
  }

  Component {
    id: notifications
    Components.NotificationPopUp {}
  }
}
