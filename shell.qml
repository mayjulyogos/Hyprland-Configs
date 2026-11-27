import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import Quickshell.Io

Scope {
    // Keep track of hover state globally between the sensor and the bar
    property bool barHovered: false

    // Timer to delay hiding when the mouse leaves
    Timer {
        id: hideTimer
        interval: 250
        onTriggered: {
            if (!bar.noWindows)
                barHovered = false
        }
    }

    // 1. Invisible thin hover sensor at the very top of the screen
    PanelWindow {
        id: revealSensor
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 0 // Slightly taller to ensure easy triggering
        color: "transparent"
        exclusiveZone: 0

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.NoButton // Let clicks pass through to windows below

            onEntered: {
                hideTimer.stop()
                barHovered = true
            }
            onExited: {
                hideTimer.restart()
            }
        }
    }

    // 2. The Main Quickshell Bar
    PanelWindow {
        id: bar
        anchors { 
            top: true 
            left: true
            right: true 
        }
        margins {
            top: 5
            left: 5
            right: 5
        }
        implicitHeight: 50
        color: "transparent"



        // Auto hide function
        exclusiveZone: 0

        readonly property bool noWindows:
            (Hyprland.focusedWorkspace?.toplevels.values.length ?? 0) === 0

        // Visible if there are no windows OR if either the sensor or bar is hovered
        visible: noWindows || barHovered || barMouseArea.containsMouse

        MouseArea {
            id: barMouseArea
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.NoButton

            onEntered: {
                hideTimer.stop()
                barHovered = true
            }
            onExited: {
                hideTimer.restart()
            }
        }



        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }

        // Volume
        Poller {
            id: vol
            command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf \"%d\", $2*100}'"
            interval: 500
        }

        // Brightness
        Poller {
            id: brightness
            command: "brightnessctl -m | cut -d, -f4 | tr -d '%'"
            interval: 1000
        }

        // Network
        Poller {
            id: net
            command: "nmcli -t -f NAME connection show --active | head -n1"
            interval: 2000
        }

        // Media Player
        readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.players.values[0] ?? null

        // RAM
        Poller {
            id: ram
            command: "free -b | awk '/Mem:/ {printf \"%.2f GB\", ($2-$7)/1073741824}'"
            interval: 500
        }

        // GPU
	/*
        Poller {
            id: gpu
            command: "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits"
            interval: 2000
        }
	*/



        // Background Color
        Rectangle {
            anchors.fill: parent
            width: parent.width
            radius: height / 2
            anchors.topMargin: 2.5
            anchors.bottomMargin: 2.5
            color: Qt.alpha("#D5E8E6", 1)



            // Left Panel
            RowLayout {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 10
                spacing: 10

                Workspace {}

		// Media
                Pill {
                    icon: ""
                    maxLabelWidth: 200
                    label: bar.player ? `${bar.player.trackArtist || "Unknown"} - ${bar.player.trackTitle || ""}` : "Nothing Playing"
                }

		// GPU
                /*
		Pill {
                    icon: ""
                    label: gpu.value + "%"
                    iconColor: "#ceb09a"
                }
		*/
            }



            // Center
            RowLayout {
                anchors.centerIn: parent
        
                // Time and Date
		Pill {
                    id: datePill
                    label: Qt.formatDateTime(clock.date, "hh:mm AP")
		    // label: Qt.formatDateTime(clock.date, "ddd MMM dd hh:mm AP")
                    iconColor: "#f5e2c5"
                }
            }



            // Right Panel
            RowLayout {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 10
                spacing: 10

		// Volume
                Pill {
                    icon: ""
                    label: vol.value + "%"
                    iconColor: "#ff6048"
                }
	
		// Brightness
                Pill {
                    icon: ""
                    label: brightness.value + "%"
                    iconColor: "#ff6059"
                }

		// Network
                Pill {
                    icon: ""
                    label: net.value
                    iconColor: "#5fc8d4"
                }

		// RAM
                Pill {
                    icon: ""
                    label: ram.value
                    iconColor: "#6befa2"
                }
            }
        }
    }
}
