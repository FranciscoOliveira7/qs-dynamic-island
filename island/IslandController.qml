pragma Singleton

import QtQuick
// import "island"

QtObject {
  id: root

  function setDefault() {
    IslandState.state = IslandState.defaultState
  }
  function setExpanded() {
    IslandState.state = IslandState.expandedState
  }
}
