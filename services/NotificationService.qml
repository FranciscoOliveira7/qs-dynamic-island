pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQml.Models

Singleton {
  id: root

  ListModel { id: history }

  property int unreadCount: 0

  signal unread(unread: int)
  signal notificationReceived(notification: Notification)
  readonly property var trackedNotifications: server.trackedNotifications

  NotificationServer {
    id: server
    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: n => {
      root.unreadCount++
      root.unread(root.unreadCount)
      // root.notificationReceived(n)
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

  function dismiss(notification) {
    notification.dismiss()
    unreadCount--
    root.unread(root.unreadCount)
  }

  function activate(notification) {
    console.log(notification.actions)
    if (notification.actions.length == 0) return
    notification.actions[0].invoke()
  }
}
