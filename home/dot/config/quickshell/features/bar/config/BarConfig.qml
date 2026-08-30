pragma Singleton

import Quickshell
import qs.config

Singleton {
    readonly property int height: 36
    readonly property int topMargin: 2
    readonly property int inlineMargin: 175
    readonly property string bgColor: ColorsConfig.background
    readonly property var border: ({
            color: ColorsConfig.border,
            width: 1,
            radius: 14
        })
}
