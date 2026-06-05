import QtQuick
import QtQuick.Layouts
import "../../../components"
import "../../../services"

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
                color: hoverControl.hovered ? ColorsService.blue_300 : modelData.idx === NiriService.activeWorkspace ? ColorsService.blue_300 : ColorsService.foreground

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
