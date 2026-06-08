import QtQuick
import Quickshell.Io
import "../../../components"

ModuleShell {

    background: ModuleShellBackground {
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("AppLauncherModule clicked");
                launcherProcess.exec(launcherProcess.command);
            }
        }

        Process {
            id: launcherProcess
            command: [
              "sh",
              "-c",
              `
              pgrep -x rofi >/dev/null && pkill -x rofi || 
              rofi -show drun -theme-str 'window { location: north; anchor: north; y-offset: 3; }'
              &
              `
            ]
            stdout: StdioCollector {
                onStreamFinished: {
                    console.log("AppLauncherModule process finished with output:", this.text);
                }
            }
        }
    }

    StyledText {
        text: "〇"
        font.bold: true
        font.pointSize: 10.5
    }
}
