pragma ComponentBehavior: Bound

import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import "../services"

Item {
  
  id: root
  
  implicitWidth: 220
  implicitHeight: column.height

  property var service: NotificationService
  property var notifications: service.trackedNotifications

  function dismiss(index) {
    // console.log("Notif index: " + index)
    service.dismiss(index)
  }

  ColumnLayout {
    id: column
    width: root.implicitWidth

    Repeater {
      model: root.notifications

      delegate: NotificationCard {
        onRequestdimiss: index => {
          root.dismiss(index)
        }
      }
    }
  }
}
