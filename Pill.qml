import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root

  property string icon: ""
  property string label: ""
  property color iconColor: "green"
  property int maxLabelWidth: 400

  implicitWidth: row.implicitWidth + 22
  implicitHeight: 35
  radius: height / 2
  color: "#040e0d"

  RowLayout {
    id: row
    anchors.centerIn: parent
    spacing: 7

    Text {
      text: root.icon
      color: root.iconColor
      font.family: "Material Symbols Rounded"
      font.pixelSize: 16
      font.bold: true
    }
    Text {
      text: root.label
      color: "#f5e2c5"
      font.family: "CaskaydiaCove Nerd Font"
      font.pixelSize: 16
      elide: Text.ElideRight
      Layout.maximumWidth: root.maxLabelWidth
      visible: root.label !== ""
    }
  }
}
