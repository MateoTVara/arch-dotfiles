pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property UPowerDevice uPowerDevice: UPower.displayDevice
    readonly property int percentage: uPowerDevice.percentage * 100  // Coerce to int
    readonly property var state: uPowerDevice.state
}
