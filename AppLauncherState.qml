pragma Singleton

import QtQuick
import QtCore

QtObject {
  property bool launcherVisible: false
  
  property bool showing: false
  property var recentIds: []

  property var _settings: Settings {
    category: "AppLauncher"
    property string recentIdsSerialized: "[]"
  }

  Component.onCompleted: {
    recentIds = JSON.parse(_settings.recentIdsSerialized)
  }

  function recordLaunch(id) {
    var list = recentIds.slice()
    var index = list.indexOf(id)

    if (index !== -1) list.splice(index, 1)
    list.unshift(id)
    
    if (list.length > 12) list = list.slice(0, 12)

    recentIds = list
    _settings.recentIdsSerialized = JSON.stringify(list)
  }

  function clearRecents() {
    recentIds = []
    _settings.recentIdsSerialized = "[]"
  }

  function hide() {
    launcherVisible = false
  }
}
