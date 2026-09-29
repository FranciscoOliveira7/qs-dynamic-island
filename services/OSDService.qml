pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root

    readonly property bool isShowing: hideTimer.running
    readonly property real volume: Pipewire.defaultAudioSink?.audio?.volume ?? 0.0
    readonly property bool muted: Pipewire.defaultAudioSink?.audio?.muted ?? false

    property int duration: 1500

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Timer {
        id: hideTimer
        interval: root.duration
    }

    Connections {
        target: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null
        ignoreUnknownSignals: true

        function onVolumeChanged() {
            if (Pipewire.defaultAudioSink?.audio) {
                hideTimer.restart()
            }
        }

        function onMutedChanged() {
            if (Pipewire.defaultAudioSink?.audio) {
                hideTimer.restart()
            }
        }
    }
}

