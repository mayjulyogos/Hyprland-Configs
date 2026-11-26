import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import Quickshell.Io

PanelWindow {
    id: bar

    anchors { top: true; left: true; right: true }
    implicitHeight: 50
    color: "transparent"
    // color: Qt.alpha("#000000", 0.75)



    // These following lines are build for auto hiding
    // exclusiveZone: 0
    
    // Shows only when the active workspace has 0 open windows
    /*
    property bool showBar: (Hyprland.focusedWorkspace?.toplevels.values.length ?? 0) === 0

    margins.top: showBar ? 0 : -implicitHeight

    Behavior on margins.top {
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutCubic
        }
    }
    */



    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }


    // Volume
    Poller {
        id: vol
        command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}'"
        interval: 100
    }

    // Brightness
    Poller {
        id: brightness
	command: "brightnessctl -m | cut -d, -f4 | tr -d '%'"
	interval: 100
    }

    // Network
    Poller {
        id: net
        command: "nmcli -t -f NAME connection show --active | head -n1"
        interval: 100
    }

    // Media Player
    readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.Players.values[0] ?? null

    // Memory
    Poller {
	    id: memory
        command: "free -b | awk '/Mem:/ {printf \"%.2f GB\", ($2-$7)/1073741824}'"
	    interval: 100
    }

    // GPU
    Poller {
        id: gpu
        command: "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits"
        interval: 100
    }



    // Left Panel
    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        spacing: 10

        /*
        Repeater {
            model: 9

            Text {
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                text: index + 1
                color: isActive ? "#3dd1b0" : "#ffffff"

                font {
                    family: "PingFang SC Bold"
                    weight: isActive ? "600" : "400"

                }
            }
        }
        */

        // Workspace
        Workspace {}

        // Media Player
        Pill {
            icon: ""
            maxLabelWidth: 200
            label: bar.player ? `${bar.player.trackArtist || "Unkown"} - ${bar.player.trackTItle || ""}` : "Nothing Playing"
        }

        // GPU
        Pill {
            icon: ""
            label: gpu.value + "%"
            iconColor: "#ceb09a"
        }
    }



    // Center
    RowLayout {
        anchors.centerIn: parent
        
        // Date and Time
        Pill {
            id: datePill
            label: Qt.formatDateTime(clock.date, "ddd MMM dd HH:mm:ss")
            iconColor: "#f5e2c5"
        }
    }



    // Right Panel
    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 10
        spacing: 10
        implicitWidth: row.implicitWidth + 30


        // volume
        Pill {
            icon: ""
            label: vol.value + "%"
            iconColor: "#ff6048"
        }
	
	    //Brightness
	    Pill {
	        icon: ""
	        label: brightness.value + "%"
	        iconColor: "#ff6059"
	    }

        // Network
        Pill {
            icon:""
            label: net.value
            iconColor: "#5fc8d4"
        }

	    // Memory
	    Pill {
	        icon: ""
	        label: memory.value
            iconColor: "#6befa2"
	    }
    }
}
