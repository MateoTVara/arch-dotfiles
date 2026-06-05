import QtQuick
import QtQuick.Layouts
import "../right_modules"

RowLayout {
    // ColumnLayout {
    spacing: 6

    anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        rightMargin: 6
    }

    BatteryModule {}

    AudioModule {}

    TrayModule {}

    ClockModule {}
}
