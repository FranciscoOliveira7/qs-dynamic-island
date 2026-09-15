import QtQuick
import "../components"

Item {
  id: root

  // implicitWidth: viewLoader.item ? viewLoader.item.implicitWidth : 0
  
  implicitWidth: viewLoader.item ? viewLoader.item.implicitWidth : 0
  implicitHeight: viewLoader.item ? viewLoader.item.implicitHeight : 0
  // implicitWidth: viewLoader.width
  // implicitHeight: viewLoader.height
  anchors.centerIn: parent
  // clip: false

  Loader {
    id: viewLoader
    anchors.centerIn: parent

    width: item ? item.implicitWidth : 0
    height: item ? item.implicitHeight : 0

    sourceComponent: {
      switch (IslandState.state) {
        case IslandState.defaultState:
          return clock
        case IslandState.expandedState:
          return test
      }
    }
  }

  Component {
    id: clock
    Clock {}
  }

  Component {
    id: test
    Idk {}
  }
}
