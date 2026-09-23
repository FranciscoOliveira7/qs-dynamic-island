pragma ComponentBehavior: Bound

import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "../services"
import ".."

Item {
  id: root
  
  anchors.centerIn: parent
  
  implicitWidth: 280
  implicitHeight: column.implicitHeight

  property var service: NotificationService

  ColumnLayout {
    id: column
    width: root.width

    Repeater {
      model: root.service.trackedNotifications

      delegate: Rectangle {
        id: card

        required property var modelData
        readonly property var service: NotificationService

        Timer {
          running: card.modelData.urgency !== NotificationUrgency.Critical
          interval: 5000
          onTriggered: root.service.dismiss(card.modelData)
        }

        Layout.fillWidth: true
        // Layout.preferredHeight: 60
        Layout.preferredHeight: layout.implicitHeight + 20
        radius: 15
        color: Theme.surface
        border.width: 0
        border.color: modelData.urgency === NotificationUrgency.Critical
          ? Theme.accent : Theme.border

        RowLayout {
          id: layout
          anchors.fill: parent
          // anchors.margins: 10
          anchors.leftMargin: 10
          spacing: 10

          Image {
            Layout.preferredHeight: 36
            Layout.preferredWidth: 36
            // Layout.alignment: Qt.AlignTop
            fillMode: Image.PreserveAspectFit
            visible: source.toString() !== ""
            source: card.modelData.image || card.modelData.appIcon || ""

            // Rectangle {
            //   anchors.fill: parent
            //   color: "green"
            // }
          }

          ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            Text {
              Layout.fillWidth: true
              text: card.modelData.summary
              color: Theme.textPrimary
              font.family: "JetbrainsMono Nerd Font"
              font.pixelSize: 18
              font.bold: true
              elide: Text.ElideRight
            }
            Text {
              Layout.fillWidth: true
              visible: text !== ""
              text: card.modelData.body
              color: Theme.textSecondary
              font.family: "JetbrainsMono Nerd Font"
              font.pixelSize: 16
              wrapMode: Text.Wrap
            }
          }
        }

        MouseArea {
          anchors.fill: parent
          onClicked: {
            root.service.activate(card.modelData)
            root.service.dismiss(card.modelData)
          }
        }
      }
    }
  }
}
