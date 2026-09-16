import QtQuick
import "../components"

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
  onSourceComponentChanged : { updateState(sourceComponent) }

  function updateState(component) {
    // fadeIn.stop(); fadeOut.start()

    console.log(component.width)
  }

  implicitWidth: loader.item ? loader.item.implicitWidth : 0
  implicitHeight: loader.item ? loader.item.implicitHeight : 0
  // implicitWidth: viewLoader.width
  // implicitHeight: viewLoader.height
  anchors.centerIn: parent
  // clip: false

  Loader {
    id: loader
    anchors.centerIn: parent

    onLoaded: { fadeOut.stop(); fadeIn.start() }

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
    Clock {}
  }

  Component {
    id: test
    Idk {}
  }
}
