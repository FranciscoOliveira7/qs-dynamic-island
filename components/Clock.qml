import QtQuick
import "../services" as Services
import ".."

Item {
  implicitWidth: 120
  implicitHeight: 30

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
}
