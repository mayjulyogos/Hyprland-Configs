import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Hyprland

PanelWindow {
    id: bar

    anchors { top: true; left: true; right: true }
    implicitHeight: 45
    color: "transparent"
    exclusiveZone: 0

    // Shows only when the active workspace has 0 open windows
    property bool showBar: (Hyprland.focusedWorkspace?.toplevels.values.length ?? 0) === 0

    margins.top: showBar ? 0 : -implicitHeight

    Behavior on margins.top {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    Poller {
        id: clock
        command: "date +%H:%M:%S"
        interval: 1000
    }

    Poller {
        id: vol
        command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}'"
        interval: 1000
    }

    Poller {
        id: bat
        command: "cat /sys/class/power_supply/BAT1/capacity"
        interval: 1000
    }

    Poller {
        id: bt
        command: "bluetoothctl show | grep -q 'Power: yes' && echo on || echo off"
        interval: 5000
    }

    Poller {
        id: net
        command: "nmcli -t -f NAME connection show --active | head -n1"
        interval: 5000
    }

    readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.Players.values[0] ?? null

    // Left Panel
    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 14

        // Media Player
        Pill {
            icon: ""
            maxLabelWidth: 200
            label: bar.player ? `${bar.player.trackArtist || "Unkown"} - ${bar.player.trackTItle || ""}` : "Nothing Playing"
        }
    }

     // Clock
    RowLayout {
        anchors.centerIn: parent

        Pill {
            label: clock.value
            iconColor: "#f5e2c5"
        }

        Workspace {
        }
    }

    // Right Panel
    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 14
        spacing: 8

        // volume
        Pill {
            icon: ""
            label: vol.value + "%"
            iconColor: "#ff6048"
        }

        // battery
        Pill {
            icon: ""
            label: bat.value + "%"
            iconColor: "#7ad9a8"
        }

        // bluetooth
        Pill {
            icon: "󰂯"
            label: bt.value
            iconColor: "#ffa478"
        }

        // Network
        Pill {
            icon:""
            label: net.value
            iconColor: "#5fc8d4"
        }
    }
}