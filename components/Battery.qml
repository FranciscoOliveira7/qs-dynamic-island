import Quickshell.Services.UPower
import QtQuick
import ".."

Rectangle {
  id: root

  visible: UPower.displayDevice && UPower.displayDevice.isLaptopBattery
  implicitWidth: 40
  implicitHeight: 16

  function getColor(percentage) {
    if (percentage < 0.15) { return "#f38ba8" }
    if (percentage < 0.40) { return "#f9e2af" }
    else { return Theme.green }
  }

  radius: 5

  readonly property real percentage: {
    UPower.displayDevice.ready ? UPower.displayDevice.percentage : 0
  }

  color: "#585b70"

  Rectangle {
    width: root.implicitWidth * root.percentage
    height: root.implicitHeight

    color: root.getColor(root.percentage)

    topLeftRadius: root.topLeftRadius
    bottomLeftRadius: root.bottomLeftRadius
  }

  Text {
    id: percentage
    anchors.centerIn: parent

    color: "#1e1e2e"
    font.family: "JetbrainsMono Nerd Font"
    font.pixelSize: 15
    font.bold: true

    // text: { (UPowerDevice.ready) ? UPowerDevice.percentage : 0 + "%"}
    text: parseInt(root.percentage * 100)
  }
}
