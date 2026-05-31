import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import "../../../components"

ModuleShell {
    RowLayout {
        spacing: 10
        Repeater {
            model: SystemTray.items

            RoundButton {
                id: trayButton
                required property var modelData

                flat: true
                padding: 0
                implicitWidth: 16
                implicitHeight: 16

                // Override to remove the default pressed visual feedback
                background: Rectangle {
                    color: "transparent"
                    radius: 0
                }

                contentItem: Image {
                    source: trayButton.modelData.icon
                    sourceSize {
                        width: 22
                        height: 22
                    }
                    mipmap: true
                    antialiasing: true
                }
            }
        }
    }
}
