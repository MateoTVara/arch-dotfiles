pragma Singleton

import Quickshell
import "../../../services"

Singleton {
    readonly property int height: 36
    readonly property int topMargin: 2
    readonly property int inlineMargin: 175
    readonly property string bgColor: ColorsService.background
    readonly property var border: ({
            color: ColorsService.border,
            width: 1,
            radius: 14
        })
}
