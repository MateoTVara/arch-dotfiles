pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property int volume: Pipewire.defaultAudioSink.audio.volume * 100
    readonly property bool muted: Pipewire.defaultAudioSink.audio.muted

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
}
