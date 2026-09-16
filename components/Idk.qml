import QtQuick
import QtQuick.Layouts
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

      color: "#f5e2c5"
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: Time.time
    }

    Text {
      id: dateDisplay
      Layout.alignment: Qt.AlignHCenter

      color: "#f5e2c5"
      font.family: "JetbrainsMono Nerd Font"
      font.pixelSize: 18
      font.bold: true

      text: Time.date
    }
  }
}
