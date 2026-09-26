pragma ComponentBehavior: Bound

import QtQuick
import Qt.labs.folderlistmodel
import ".."

Rectangle {
  id: root
  
  implicitWidth: 500
  implicitHeight: 200

  property var directory: "file:///home/francisco/Pictures/Wallpapers"

  Component {
    id: wallpaperEntry

    Item {
      implicitWidth: 160
      implicitHeight: 90

      id: wallpaper
      required property string fileName

      Rectangle {
        // implicitWidth: parent.width - 0
        // implicitHeight: parent.height - 0
      }

      Image {
        anchors.centerIn: parent
        width: parent.width - 10
        height: parent.height - 10
        source: root.directory + "/" + wallpaper.fileName
        sourceSize.width: 160
        sourceSize.height: 90
      }
    }
  }

  ListView {
    anchors.fill: parent

    FolderListModel {
      id: folderModel
      folder: root.directory
      nameFilters: ["*.png", "*.jpg"]
    }

    spacing: 10
    orientation: ListView.Horizontal
    model: folderModel

    // populate: Transition {
    //   NumberAnimation {
    //     property: "opacity"
    //     from: 0
    //     to: 1
    //     duration: 1000
    //   }
    // }

    delegate: wallpaperEntry
    highlight: Rectangle {
      color: "green"
      // width: 200
      // height: 200
    }
    highlightFollowsCurrentItem: true
    focus: true
  }

  color: "transparent"
}
