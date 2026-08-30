pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    // Grays
    readonly property color gray_100: "#c1c7db"
    readonly property color gray_200: "#b5bbcf"
    readonly property color gray_500: "#848484"
    readonly property color gray_600: "#847c84"

    // Blues
    readonly property color blue_300: "#7589aa"
    readonly property color blue_400: "#617291"
    readonly property color blue_500: "#4d5667"
    readonly property color blue_600: "#39465a"
    readonly property color blue_700: "#2f3749"
    readonly property color blue_800: "#282b34"
    readonly property color blue_900: "#060708"

    // Reds
    readonly property color red_500: "#fc4649"

    // Semantic Aliases
    readonly property color foreground: gray_200
    readonly property color background: blue_800
    readonly property color border: blue_300
}
