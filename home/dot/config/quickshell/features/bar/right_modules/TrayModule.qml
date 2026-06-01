import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import "../../../components"

ModuleShell {
    id: trayModule
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
                            window: mouseArea.QsWindow.window
                            adjustment: PopupAdjustment.Flip
                            onAnchoring: {
                                const window = mouseArea.QsWindow.window;
                                const widgetRect = window.contentItem.mapFromItem(mouseArea, 0, mouseArea.height, mouseArea.width, mouseArea.height);

                                menuAnchor.anchor.rect = widgetRect;
                            }
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
