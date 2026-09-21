import QtQuick
import QtQuick.Layouts
import "../services" as Services
import ".."

Item {
  anchors.centerIn: parent

  implicitWidth: 220
  implicitHeight: 70

  ColumnLayout {
    
    anchors.centerIn: parent

    Text {
      id: clockDisplay
      Layout.alignment: Qt.AlignHCenter

      color: Theme.textPrimary
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: Services.Time.time
    }

    Text {
      id: dateDisplay
      Layout.alignment: Qt.AlignHCenter

      color: Theme.textMuted
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: Services.Time.date
    }
  }
}
