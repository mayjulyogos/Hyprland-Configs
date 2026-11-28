import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: commandScope

    property string command: ""
    property int interval: 3000
    property string value: ""

    Process {
        id: proc
        command: ["sh", "-c", commandScope.command]
        running: commandScope.command !== ""
        stdout: StdioCollector {
            onStreamFinished: commandScope.value = this.text.trim()
        }
    }

    Timer {
        interval: commandScope.interval
        running: commandScope.command !== ""
        repeat: true
        onTriggered: proc.running = true
    }
}