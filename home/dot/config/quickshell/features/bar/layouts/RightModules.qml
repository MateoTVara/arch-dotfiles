import QtQuick
import QtQuick.Layouts
import "../right_modules"

RowLayout {
    spacing: 6

    anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        rightMargin: 6
    }

    TrayModule {}

    ClockModule {}
}
