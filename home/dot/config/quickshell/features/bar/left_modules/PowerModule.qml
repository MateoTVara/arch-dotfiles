import qs.components
import qs.config
import qs.features.bar.config
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

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

            function open() {
                powerMenu.visible = true;
                powerMenu.opened = true;
                powerMenu.topOffset = 5;
            }

            function close() {
                powerMenu.opened = false;
                powerMenu.topOffset = powerMenu.closedOffset;
            }

            anchors.fill: parent
            onClicked: powerMenu.opened ? close() : open()
        }

        PanelWindow {
            id: powerMenu

            property var padding: ({
                "block": 6
            })
            property bool opened: false
            property int closedOffset: -12
            property int topOffset: powerMenu.closedOffset

            color: "transparent"
            implicitHeight: menuLayout.implicitHeight + padding.block * 2
            exclusionMode: ExclusionMode.Ignore

            anchors {
                top: true
                left: true
            }

            margins {
                top: BarConfig.height + topOffset
                left: BarConfig.inlineMargin + 6 + (root.width - powerMenu.width) / 2
            }

            Item {
                id: content

                anchors.fill: parent
                opacity: powerMenu.opened ? 1 : 0

                Rectangle {
                    anchors.fill: parent
                    color: ColorsConfig.background
                    border.color: ColorsConfig.border
                    radius: 12
                }

                ColumnLayout {
                    id: menuLayout

                    spacing: 6
                    anchors.centerIn: parent

                    Repeater {
                        model: [{
                            "text": "Shutdown",
                            "action": () => {
                                return shutdownProcess.exec(shutdownProcess.command);
                            }
                        }, {
                            "text": "Reboot",
                            "action": () => {
                                return rebootProcess.exec(rebootProcess.command);
                            }
                        }, {
                            "text": "Logout",
                            "action": () => {
                                return logoutProcess.exec(logoutProcess.command);
                            }
                        }]

                        delegate: ModuleShell {
                            id: menuItem

                            required property var modelData
                            property bool isHovered: hoverControl.hovered

                            Layout.alignment: Qt.AlignCenter
                            Layout.fillWidth: true

                            StyledText {
                                text: menuItem.modelData.text
                                font.pointSize: 10.5
                                color: menuItem.isHovered ? ColorsConfig.blue_800 : ColorsConfig.foreground

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 100
                                    }

                                }

                            }

                            background: ModuleShellBackground {
                                color: menuItem.isHovered ? ColorsConfig.blue_300 : ColorsConfig.blue_700

                                HoverHandler {
                                    id: hoverControl
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: menuItem.modelData.action()
                                }

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 100
                                    }

                                }

                            }

                        }

                    }

                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutCubic
                    }

                }

            }

            Behavior on topOffset {
                NumberAnimation {
                    duration: 225
                    easing.type: Easing.OutCubic
                    onFinished: {
                        if (!powerMenu.opened)
                            powerMenu.visible = false;

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
