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
    Launcher = 3,
    Wallpapers = 4,
    OSD = 5
  }

  // For states that need keyboard
  property bool isKeyboardFocused: isOnLauncher || isOnWallpaperPicker

  property bool isOnOSD: {
    return Services.OSDService.isShowing
  }
  property bool hasNotifications: {
    return Services.NotificationService.unreadCount > 0
  }
  property bool isOnLauncher: {
    return AppLauncherState.launcherVisible
  }
  property bool isOnWallpaperPicker: {
    return Services.WallpaperService.isMenuOpen
  }

  property int islandState: {
    // return IslandController.Wallpapers

    // Simple Priority bases state
    if (isOnOSD) {
      return IslandController.OSD
    }
    if (isOnLauncher) {
      return IslandController.Launcher
    }
    if (isOnWallpaperPicker) {
      return IslandController.Wallpapers
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
}
