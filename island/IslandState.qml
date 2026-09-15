pragma Singleton

import QtQuick

QtObject {
  // States
  readonly property int defaultState: 0
  readonly property int expandedState: 1

  // State
  property int state: defaultState
}
