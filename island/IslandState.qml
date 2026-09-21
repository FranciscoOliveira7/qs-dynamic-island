pragma Singleton

import QtQuick

QtObject {
  // States
  enum State {
    Default = 0,
    Expanded = 1,
    Notification = 2
  }
  // readonly property int defaultState: 0
  // readonly property int expandedState: 1
  // readonly property int notification: 1

  // State
  property int state: 0
}
