import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import "../config"
import "../../../components"

ModuleShell {
    id: root
    RowLayout {
        // ColumnLayout {
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

                contentItem: Image {
                    source: trayButton.modelData.icon
                    sourceSize {
                        width: 22
                        height: 22
                    }
                    mipmap: true
                    antialiasing: true
                    visible: status === Image.Ready
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    property var menuIdExceptions: ["nm-applet"]
                    onClicked: mouse => {
                        console.log(trayButton.modelData.id, trayButton.modelData.title, "onlyMenu =", trayButton.modelData.onlyMenu, "hasMenu =", trayButton.modelData.hasMenu);
                        if (mouse.button === Qt.LeftButton) {
                            if (trayButton.modelData.id && menuIdExceptions.includes(trayButton.modelData.id)) {
                                console.log("Opening system tray menu for", trayButton.modelData.title, "(exception)");
                                menuAnchor.open();
                                return;
                            }
                            if (trayButton.modelData.onlyMenu && trayButton.modelData.hasMenu) {
                                menuAnchor.open();
                            } else {
                                console.log("activate()");
                                trayButton.modelData.activate();
                            }
                        } else if (mouse.button === Qt.RightButton && trayButton.modelData.hasMenu) {
                            console.log("Opening system tray menu for", trayButton.modelData.title);
                            menuAnchor.open();
                        }
                    }

                    QsMenuAnchor {
                        id: menuAnchor
                        menu: trayButton.modelData.menu

                        anchor {
                            item: mouseArea
                            edges: Edges.Bottom
                            gravity: Edges.Bottom
                            adjustment: PopupAdjustment.Flip
                            margins.bottom: -((BarConfig.height - root.implicitHeight) / 2 + 3)
                        }
                    }
                }

                // I'll use a custom popup in the future
                // QsMenuOpener {
                //     id: menuOpener
                //     menu: trayButton.modelData.menu
                // }
            }
        }
    }
}
