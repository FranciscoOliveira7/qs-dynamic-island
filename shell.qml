import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

// qmllint disable uncreatable-type
PanelWindow {
  id: bar

  anchors { top: true; left: true; right: true }
  implicitHeight: 40
  color: "#77ff0000"

  Poller {
    id: clock
    command: "date +%H:%M"
    interval: 60000
  }

  Poller {
    id: vol
    command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf\"%d\", $2*100}'"
    interval: 1000
  }

  Poller {
    id: net
    command: "nmcli -t -f NAME connection show --active | head -n1"
    interval: 5000
  }

  readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.players.values[0] ?? null

  RowLayout {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: 14
    spacing: 8

    Pill { icon: "volume_up"; label: vol.value + "%"; iconColor: "#ffa478" }
    Pill { icon: "android_wifi_3_bar"; label: net.value; iconColor: "#ffa478" }
  }

  RowLayout {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: 14
    spacing: 8

    Pill {
      icon: "music_note";
      label: bar.player ? `${bar.player.trackArtist || "unknown"} - ${bar.player.trackTitle || ""}` : "no media";
      iconColor: "#ffa478"
    }
  }
}
