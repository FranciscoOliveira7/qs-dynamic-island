pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property bool isMenuOpen: false

  Process {
    id: wallpaperProcess
    running: false
    // stdout: StdioCollector {
    //   onStreamFinished: console.log(`line read: ${this.text}`)
    // }
  }

  function setWallpaper(wallpaperDir) {
    wallpaperProcess.running = false
    wallpaperProcess.command = [
      "swaybg",
      "-i",
      wallpaperDir
    ]
    wallpaperProcess.running = true
  }
}
