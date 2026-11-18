import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property color iconColor: "#3cd"
    property int maxLabelWidth: 400

    implicitWidth: row.implicitWidth + 30
    implicitHeight: 35
    radius: height / 2
    color: "#040e0d"

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 7

        Text {
            text: root.icon
            color: root.iconColor
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
        }

        Text {
            text: root.label
            color: "#f5e5c5"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            elide: Text.ElideRight
            Layout.maximumWidth: root.maxLabelWidth
            visible:root.label !== ""
        }
    }
}