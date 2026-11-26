import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {
    implicitWidth: row.implicitWidth + 30
    implicitHeight: 35
    radius: height / 2
    color: '#00105B'
    // color: "transparent"

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            model: 9

            Rectangle {
                readonly property int wsId: index + 1
                readonly property var ws: Hyprland.workspaces.values.find(w => w.id === wsId)
                readonly property bool isActive: Hyprland.focusedWorkspace?.id === wsId
                readonly property bool isOccupied: ws !== null && ws.toplevels.values.length > 0

                implicitWidth: isActive ? 11 : 6
                implicitHeight: implicitWidth
                radius: width/2
                // Color states: Active (transparent with border), Occupied, or Empty
                color: isActive ? "transparent" : (isOccupied ? '#6f6f6f' : '#4d4d4d')
                border.width: isActive ? 2 : 0
                border.color: '#ffffff'

                Behavior on implicitWidth {
                    NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch(`workspace ${wsId}`)
                }
            }
        }
    }
}
