pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick
import "../../../components"
import "../../../services"

// Bugs:
// - first click doesn't trigger grim
// - if the module was used before reloading config, grim
//   will execute once inmediately after reloading config
//   otherwise it won't execute until second click after reloading config

ModuleShell {
    id: root
    property var isHovered: hoverControl.hovered
    horizontalPadding: 7

    background: ModuleShellBackground {
        id: backgroundRect
        color: root.isHovered ? ColorsService.blue_300 : ColorsService.blue_700

        HoverHandler {
            id: hoverControl
        }

        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onPressed: mouse => {
                if (mouse.button === Qt.LeftButton) {
                    backgroundRect.takeSelectionScreenshot();
                } else if (mouse.button === Qt.RightButton) {
                    backgroundRect.takeFullscreenScreenshot();
                }
            }
        }

        Process {
            id: selectionProcess
            running: false
        }

        Process {
            id: fullscreenProcess
            running: false
        }

        function takeSelectionScreenshot() {
            console.log("SELECTION");
            selectionProcess.exec(["sh", "-c", "grim -g \"$(slurp)\" - | wl-copy"]);
        }

        function takeFullscreenScreenshot() {
            console.log("FULLSCREEN");
            fullscreenProcess.exec(["sh", "-c", "grim - | wl-copy"]);
        }
    }

    StyledText {
        id: textRoot
        text: "󰄀"
        font {
            pointSize: 10.5
        }
        color: root.isHovered ? ColorsService.blue_800 : ColorsService.foreground

        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
    }
}
