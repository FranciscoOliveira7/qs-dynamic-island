import QtQuick
import "../services" as Services
import ".."

Item {
  id: root
  
  implicitWidth: battery.visible ? 180 : 100
  implicitHeight: 30

  anchors.centerIn: parent

  // Poller {
  //   id: clock
  //   command: "date +%H:%M"
  //   interval: 30000
  // }

  Text {
    id: clockDisplay
    anchors.centerIn: parent

    color: Theme.textPrimary
    font.family: "JetbrainsMono Nerd Font"
    font.pixelSize: 18
    font.bold: true

    text: Services.Time.time
  }

  Battery {
    id: battery
    anchors.right: root.right
    anchors.verticalCenter: clockDisplay.verticalCenter
    anchors.rightMargin: 10
  }
}
