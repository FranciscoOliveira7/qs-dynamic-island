import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import "../services" as Services

Scope {
  id: root

  property bool hovered: false
  onHoveredChanged: handleHoverChanged(hovered)

  Connections {
    target: Services.NotificationService

    function onUnread(count) {
      if (count == 0) {
        if (root.hovered) {
          root.setExpanded()
        }
        else {
          root.setDefault()
        }
        return
      }
      root.showNotification()
    }
  }

  function setDefault() {
    IslandState.state = IslandState.Default
  }

  function setExpanded() {
    IslandState.state = IslandState.Expanded
  }

  function showNotification() {
    IslandState.state = IslandState.Notification
  }

  function handleHoverChanged(isHovered) {
    root.hovered = isHovered

    if (IslandState.state == IslandState.Notification) return

    if (!isHovered) {
      setDefault()
    }
    if (isHovered) {
      setExpanded()
    }
  }
}
