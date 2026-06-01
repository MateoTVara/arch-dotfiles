import QtQuick
import QtQuick.Controls

Container {
    id: root

    default required property Component module

    implicitHeight: 26
    horizontalPadding: 8.5

    background: ModuleShellBackground {}

    contentItem: Item {
        implicitWidth: loader.implicitWidth
        implicitHeight: loader.implicitHeight

        Loader {
            id: loader
            anchors.centerIn: parent
            sourceComponent: root.module
        }
    }
}
