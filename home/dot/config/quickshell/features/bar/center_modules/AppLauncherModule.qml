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
            command: ["sh", "-c", "pgrep wofi >/dev/null 2>&1 && killall wofi || wofi --show drun --location=top -y 3 &"]
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
