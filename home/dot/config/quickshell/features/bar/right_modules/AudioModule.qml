pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io
import "../../../components"
import "../../../services"

ModuleShell {
    id: root
    property int volume: PipewireService.volume
    property bool muted: PipewireService.muted

    background: ModuleShellBackground {
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Audio module clicked");
                togglePavucontrol.exec(togglePavucontrol.command);
            }
        }

        Process {
            id: togglePavucontrol

            command: ["sh", "-c", `
                id=$(niri msg windows | awk '
                    /Window ID/ { gsub(":", "", $3); id=$3 }
                    /App ID: "org.pulseaudio.pavucontrol"/ { print id; exit }
                ')

                if [ -n "$id" ]; then
                    niri msg action focus-window --id "$id"
                else
                    nohup pavucontrol >/dev/null 2>&1 &
                fi
            `]

            stdout: StdioCollector {
                onStreamFinished: console.log(text)
            }

            onRunningChanged: console.log("running:", running)
        }
    }

    StyledText {
        text: {
            if (root.muted)
                return "";

            const vol = root.volume;
            let prefix = "";
            if (vol >= 70)
                prefix = " ";
            else if (vol >= 35)
                prefix = "";
            else
                prefix = "";
            return `${prefix} ${vol}%`;
        }
    }
}
