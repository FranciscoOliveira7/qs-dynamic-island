import QtQuick
import ".."

Item {
  implicitWidth: 120
  implicitHeight: 30

  Poller {
    id: clock
    command: "date +%H:%M"
    interval: 30000
  }

  Text {
    id: clockDisplay
    anchors.centerIn: parent

    color: "#f5e2c5"
    font.family: "JetbrainsMono Nerd Font"
    font.pixelSize: 18
    font.bold: true

    text: clock.value
  }
}
