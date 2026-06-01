import QtQuick
import Quickshell
import "layouts"
import "../../services"

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData

            implicitHeight: 36
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: 2
                left: 175
                right: 175
            }

            Rectangle {
                anchors.fill: parent
                color: ColorsService.background
                border.color: ColorsService.border
                border.width: 1
                radius: 14

                LeftModules {}
                RightModules {}
            }
        }
    }
}
