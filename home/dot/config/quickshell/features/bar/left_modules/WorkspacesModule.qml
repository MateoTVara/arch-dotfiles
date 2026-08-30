import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services
import qs.config

ModuleShell {
    horizontalPadding: 13

    RowLayout {
        // ColumnLayout {
        spacing: 10
        Repeater {
            model: NiriService.workspaces

            StyledText {
                id: textRoot
                required property var modelData
                text: `${modelData.idx}`
                font {
                    bold: true
                    pointSize: 10.5
                }
                color: hoverControl.hovered ? ColorsConfig.blue_300 : modelData.idx === NiriService.activeWorkspace ? ColorsConfig.blue_300 : ColorsConfig.foreground

                MouseArea {
                    anchors.fill: parent
                    onClicked: NiriService.switchToWorkspace(textRoot.modelData.idx)
                }

                HoverHandler {
                    id: hoverControl
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 120
                    }
                }
            }
        }
    }
}
