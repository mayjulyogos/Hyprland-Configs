import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root

    property string icon: ""
    property string label: ""
    property color iconColor: "#3cd"
    property int maxLabelWidth: 400

    implicitWidth: row.implicitWidth + 35
    implicitHeight: 30
    radius: height / 2
    color: '#6061B6'
    // color: "transparent"
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
            font.pixelSize: 16
	    font.weight: Font.ExtraBold
        }

        Text {
            text: root.label
            color: "#ffffff"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            elide: Text.ElideRight
	    font.weight: Font.ExtraBold
            Layout.maximumWidth: root.maxLabelWidth
            visible:root.label !== ""
        }
    }
}
