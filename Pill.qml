import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property color iconColor: "#3cd"
    property int maxLabelWidth: 400

    implicitWidth: row.implicitWidth + 40
    implicitHeight: 35
    radius: height / 2
    // color: "transparent"
    color: '#00105B'
    // color: Qt.alpha("#000000", 0.75)
    // color: Qt.alpha("#ffffff", 0.25)

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
            color: "#ffffff"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            elide: Text.ElideRight
            Layout.maximumWidth: root.maxLabelWidth
            visible:root.label !== ""
        }
    }
}
