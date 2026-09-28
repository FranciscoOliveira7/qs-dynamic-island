pragma ComponentBehavior: Bound

import QtQuick
import Qt.labs.folderlistmodel
import ".."
import "../services" as Services

Item {
  id: root
  
  implicitWidth: 500
  implicitHeight: 200

  FolderListModel {
    id: folderModel
    folder: root.directory
    nameFilters: ["*.png", "*.jpg"]
  }

  property var directory: "file:///home/francisco/Pictures/Wallpapers"

  // Call this from the viewHost Loader
  // function forceInputFocus() {
  //   listView.forceActiveFocus();
  // }

  function setWallpaper(wallpaperDir) {
    const fileDir = ((listView.currentItem) as WallpaperEntry).filePath
    Services.WallpaperService.setWallpaper(fileDir)
    Services.WallpaperService.isMenuOpen = false
  }

  component WallpaperEntry : Item {
    implicitWidth: 160
    implicitHeight: 90

    id: wallpaper
    required property string fileName
    required property string filePath

    Image {
      anchors.centerIn: parent
      width: parent.width - 10
      height: parent.height - 10
      source: root.directory + "/" + wallpaper.fileName
      sourceSize.width: 160
      sourceSize.height: 90
    }
  }

  Column {

    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      color: Theme.textPrimary
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: ((listView.currentItem) as WallpaperEntry).fileName
    }

    ListView {
      id: listView

      width: root.implicitWidth
      height: root.implicitHeight

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

      delegate: WallpaperEntry {}
      highlight: Rectangle {
        // color: "green"
        color: Theme.textPrimary
      }
      highlightFollowsCurrentItem: true
      highlightMoveDuration: 50

      focus: true
      keyNavigationEnabled: true
      keyNavigationWraps: true

      Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
           // root.launchEntry(root.filteredApps[root.selectedIndex]);
           root.setWallpaper(listView.currentIndex)
           event.accepted = true;
        }
        else if (event.key === Qt.Key_Escape) {
          Services.WallpaperService.isMenuOpen = false
          event.accepted = true;
        }
      }
    }
  }
}
