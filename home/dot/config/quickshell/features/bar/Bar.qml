import QtQuick
import Quickshell
import qs.features.bar.layouts
import qs.features.bar.config

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData

            implicitHeight: BarConfig.height
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: BarConfig.topMargin
                left: BarConfig.inlineMargin
                right: BarConfig.inlineMargin
            }

            Rectangle {
                anchors.fill: parent
                color: BarConfig.bgColor
                border.color: BarConfig.border.color
                border.width: BarConfig.border.width
                radius: BarConfig.border.radius

                LeftModules {}
                CenterModules {}
                RightModules {}
            }
        }
    }
}
