import QtQuick

Item {
  anchors.centerIn: parent

  implicitWidth: 160
  implicitHeight: 70

  Text {
    id: clockDisplay
    anchors.centerIn: parent

    color: "#f5e2c5"
    font.family: "JetbrainsMono Nerd Font"
    font.pixelSize: 18
    font.bold: true

    text: "Sample Text"
  }
}
