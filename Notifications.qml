import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQml.Models

Scope {
  id: root

  ListModel { id: history }
  property bool centerOpen: false

  NotificationServer {
    id: server
    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: n => {
      history.insert(0, {
        summary: n.summary,
        body: n.body,
        appName: n.appName,
        urgency: n.urgency,
        time: Qt.formatDateTime(new Date(), "HH:mm")
      })
      n.tracked = true
    }
  }

  IpcHandler {
    target: "notifications"
    function toggle(): void { root.centerOpen = !root.centerOpen }
    function show(): void { root.centerOpen = true }
    function hide(): void { root.centerOpen = false }
  }

  // Notifications Popup
  PanelWindow {
    anchors { top: true; right: true }
    margins { top: 12; right: 12 }

    implicitWidth: 380
    implicitHeight: Math.max(1, column.implicitHeight)
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    ColumnLayout {
      id: column
      width: parent.width
      spacing: 10

      Repeater {
        model: server.trackedNotifications

        delegate: Rectangle {
          id: card
          required property var modelData

          Timer {
            running: card.modelData.urgency !== NotificationUrgency.Critical
            interval: 5000
            onTriggered: card.modelData.dismiss()
          }

          Layout.fillWidth: true
          Layout.preferredHeight: 60
          // Layout.preferredHeight: layout.implicitHeight + 20
          radius: 8
          color: Theme.background
          border.width: 2
          border.color: modelData.urgency === NotificationUrgency.Critical
            ? Theme.accent : Theme.border

          RowLayout {
            id: layout
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10
            
            Image {
              Layout.preferredHeight: 36
              Layout.preferredWidth: 36
              Layout.alignment: Qt.AlignTop
              fillMode: Image.PreserveAspectFit
              visible: source.toString() !== ""
              source: card.modelData.image || card.modelData.appIcon || ""
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
                wrapMode: Text.WordWrap
              }
            }
          }

          MouseArea {
            anchors.fill: parent
            onClicked: card.modelData.dismiss()
          }
        }
      }
    }
  }

  // Notification Panel
  PanelWindow {
    visible: root.centerOpen
    anchors { top: true; right: true }
    margins { top: 12; right: 12 }

    implicitWidth: 380
    implicitHeight: centerCol.implicitHeight + 24
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    Rectangle {
      anchors.fill: parent
      radius: 10
      color: Theme.background
      border.width: 2
      border.color: Theme.border
      
      ColumnLayout {
        id: centerCol
        anchors.fill: parent
        width: parent.width
        anchors.margins: 12
        spacing: 10

        RowLayout {
          Layout.fillWidth: true

          Text {
            Layout.fillWidth: true
            text: "Notifications"
            color: Theme.textPrimary
            font.family: "JetbrainsMono Nerd Font"
            font.pixelSize: 20
            font.bold: true
          }
          Text {
            text: "Clear all"
            visible: history.count > 0
            color: Theme.textPrimaryChanged
            font.family: "JetbrainsMono Nerd Font"
            font.pixelSize: 20
            font.bold: true

            MouseArea {
              anchors.fill: parent
              onClicked: history.clear()
            }
          }
        }
        Repeater {
          model: history

          delegate: Rectangle {
            id: card2
            required property var modelData

            Layout.fillWidth: true
            Layout.preferredHeight: 60
            // Layout.preferredHeight: layout.implicitHeight + 20
            radius: 8
            color: Theme.background
            border.width: 2
            border.color: modelData.urgency === NotificationUrgency.Critical
              ? Theme.accent : Theme.border

            RowLayout {
              id: layout2
              anchors.fill: parent
              anchors.margins: 10
              spacing: 10
            
              ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                Text {
                  Layout.fillWidth: true
                  text: card2.modelData.summary
                  color: Theme.textPrimary
                  font.family: "JetbrainsMono Nerd Font"
                  font.pixelSize: 18
                  font.bold: true
                  elide: Text.ElideRight
                }
                Text {
                  Layout.fillWidth: true
                  visible: text !== ""
                  text: card2.modelData.body
                  color: Theme.textSecondary
                  font.family: "JetbrainsMono Nerd Font"
                  font.pixelSize: 16
                  wrapMode: Text.WordWrap
                }
              }
            }
          }
        }
      }
    }
  }
}
