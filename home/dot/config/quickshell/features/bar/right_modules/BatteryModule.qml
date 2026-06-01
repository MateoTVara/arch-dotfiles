pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.UPower
import "../../../components"
import "../../../services"

ModuleShell {
    id: root
    readonly property int percentage: BatteryService.percentage
    readonly property bool lowBattery: percentage <= 30

    background: Rectangle {
        radius: 8
        color: root.lowBattery ? ColorsService.red_500 : ColorsService.blue_700
    }

    StyledText {
        text: {
            const currentBatteryLevel = root.percentage;
            const state = BatteryService.state;
            let prefix = "";
            if (state === UPowerDeviceState.FullyCharged) {
                prefix = "󱈑";
            } else if (state === UPowerDeviceState.Charging) {
                prefix = "󰂄";
            } else if (state === UPowerDeviceState.Discharging) {
                if (currentBatteryLevel >= 70) {
                    prefix = "󱊣";
                } else if (currentBatteryLevel > 30) {
                    prefix = "󱊢";
                } else {
                    prefix = "󱊡";
                }
            }
            return `${prefix} ${currentBatteryLevel}%`;
        }
        color: root.lowBattery ? ColorsService.blue_900 : ColorsService.foreground
    }
}
