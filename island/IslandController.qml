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

  property bool hasNotifications: {
    return Services.NotificationService.unreadCount > 0
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

  IpcHandler {
    target: "launcher"
    function toggle(): void {
      AppLauncherState.launcherVisible = !AppLauncherState.launcherVisible
    }
  }

  Connections {
    target: AppLauncherState

    function onHide() {
      console.log("hiding...")
    }
  }
}
