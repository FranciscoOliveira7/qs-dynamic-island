import QtQuick
import QtQuick.Layouts
import ".."

Item {
  anchors.centerIn: parent

  implicitWidth: 160
  implicitHeight: 70

  Poller {
    id: date
    command: "date +%H:%M"
    interval: 30000
  }

  Poller {
    id: clock
    command: "date +%a:%G"
    interval: 30000
  }

  RowLayout {
    
    anchors.fill: parent

    Text {
      id: clockDisplay
      // anchors.centerIn: parent

      color: "#f5e2c5"
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: date
    }

    Text {
      id: dateDisplay
      // anchors.centerIn: parent

      color: "#f5e2c5"
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: date
    }
  }
}
