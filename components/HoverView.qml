import QtQuick
import QtQuick.Controls
import "../services" as Services
import ".."

Item {
  anchors.centerIn: parent

  implicitWidth: 280
  implicitHeight: 90

  AbstractButton {
    id: wallPickerBtn
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: 16
    width: 30
    height: 30
    text: "󰸉"
    onClicked: {
      Services.WallpaperService.isMenuOpen = true
    }
    Rectangle {
      color: wallPickerBtn.down ? Theme.surfaceVariant : Theme.surface
      anchors.fill: parent
      radius: 6
    }
    Text {
      anchors.centerIn: parent

      color: Theme.textPrimary
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: "󰸉"
    }
  }
  
  Column {
  
    anchors.centerIn: parent

    Text {
      id: clockDisplay
      anchors.horizontalCenter: parent.horizontalCenter

      color: Theme.textPrimary
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: Services.Time.time
    }

    Text {
      id: dateDisplay
      anchors.horizontalCenter: parent.horizontalCenter

      color: Theme.textMuted
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: Services.Time.date
    }
  }
}
