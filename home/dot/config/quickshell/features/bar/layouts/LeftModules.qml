import QtQuick
import QtQuick.Layouts
import "../left_modules"

RowLayout {
    // ColumnLayout {
    spacing: 6

    anchors {
        verticalCenter: parent.verticalCenter
        left: parent.left
        leftMargin: 6
    }

    PowerModule {}

    ScreenshotModule {}

    WorkspacesModule {}
}
