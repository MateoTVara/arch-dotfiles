import QtQuick
import QtQuick.Layouts
import qs.features.bar.right_modules

RowLayout {
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
