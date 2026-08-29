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

        PanelWindow {
            id: powerMenu
            property var padding: ({
                block: 6,
                inline: 8
            })
            visible: false
            anchors {
                top: true
                left: true
            }
            margins {
                top: BarConfig.height + 5
                left: BarConfig.inlineMargin
                + 6
                + (root.width - powerMenu.width) / 2
            }
            color: "transparent"
            implicitHeight: menuLayout.implicitHeight + powerMenu.padding.block * 2.5
            exclusionMode: ExclusionMode.Ignore

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
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
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

                    delegate: ModuleShell {
                        id: menuItem
                        required property var modelData
                        Layout.alignment: Qt.AlignCenter
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
