import Quickshell
import Quickshell.Io
import QtQuick
import "../services" as Services
import ".."

Scope {
  id: root

  enum State {
    Default = 0,
    Expanded = 1,
    Notification = 2,
    Launcher = 3
  }

  property bool isKeyboardFocused: isOnLauncher

  // WlrLayershell.layer: WlrLayer.Overlay
  // WlrLayershell.keyboardFocus: isOnLauncher ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
  // WlrLayershell.namespace: "quickshell-launcher"

  property bool hasNotifications: {
    return Services.NotificationService.unreadCount
  }
  property bool isOnLauncher: {
    return AppLauncherState.launcherVisible
  }

  property int islandState: {
    if (isOnLauncher) {
      return IslandController.Launcher
    }
    if (hasNotifications) {
      return IslandController.Notification
    }
    if (hovered) {
      return IslandController.Expanded
    }
    return IslandController.Default
  }

  property bool hovered: false
  // onHoveredChanged: handleHoverChanged(hovered)

  IpcHandler {
    target: "launcher"
    function toggle(): void {
      AppLauncherState.launcherVisible = !AppLauncherState.launcherVisible
    }
  }

  function showAppLauncher() {
    IslandState.state = IslandState.Launcher
  }
  function hideAppLauncher() {
    IslandState.state = IslandState.Default
  }

  Connections {
    target: AppLauncherState

    function onHide() {
      console.log("hiding...")
    }
  }

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
    if (IslandState.state == IslandState.Launcher) return

    if (!isHovered) {
      setDefault()
    }
    if (isHovered) {
      setExpanded()
    }
  }
}
