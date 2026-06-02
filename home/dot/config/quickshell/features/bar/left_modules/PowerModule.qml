pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../config"
import "../../../components"
import "../../../services"

ModuleShell {
    id: root
    horizontalPadding: 7

    StyledText {
        text: "󰐥"
        font.pointSize: 10.5
    }

    background: ModuleShellBackground {
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: powerMenu.visible ? close() : open()

            function close() {
                powerMenu.visible = false;
            }

            function open() {
                powerMenu.visible = true;
            }
        }

        PopupWindow {
            id: powerMenu
            property var margin: ({
                    block: 6,
                    inline: 8
                })

            // visible: true
            color: "transparent"
            implicitHeight: menuLayout.implicitHeight + powerMenu.margin.block * 2

            anchor {
                item: mouseArea
                edges: Edges.Bottom
                gravity: Edges.Bottom
                adjustment: PopupAdjustment.Flip
                margins.bottom: -((BarConfig.height - root.implicitHeight) / 2 + 3)
            }

            Rectangle {
                anchors.fill: parent
                color: ColorsService.background
                border.color: ColorsService.border
                radius: 12
            }

            ColumnLayout {
                id: menuLayout
                spacing: 6
                anchors {
                    fill: parent
                    topMargin: powerMenu.margin.block
                    bottomMargin: powerMenu.margin.block
                    leftMargin: powerMenu.margin.inline
                    rightMargin: powerMenu.margin.inline
                }

                Repeater {
                    model: [
                        {
                            text: "Shutdown",
                            action: () => shutdownProcess.exec(shutdownProcess.command)
                        },
                        {
                            text: "Reboot",
                            action: () => rebootProcess.exec(rebootProcess.command)
                        },
                        {
                            text: "Logout",
                            action: () => logoutProcess.exec(logoutProcess.command)
                        }
                    ]

                    ModuleShell {
                        id: menuItem
                        required property var modelData
                        Layout.fillWidth: true
                        background: ModuleShellBackground {
                            MouseArea {
                                anchors.fill: parent
                                onClicked: menuItem.modelData.action()
                            }
                        }
                        StyledText {
                            text: menuItem.modelData.text
                            font.pointSize: 10.5
                        }
                    }
                }
            }
        }

        Process {
            id: shutdownProcess
            command: ["poweroff"]
        }

        Process {
            id: rebootProcess
            command: ["reboot"]
        }

        Process {
            id: logoutProcess
            command: ["niri", "msg", "action", "quit"]
        }
    }
}
