import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

GroupBox {
    id: utilMiscGroupBox
    Layout.fillWidth: true

    label:
        MyText {
        leftPadding: 10
        text: "雜項："
        bottomPadding: -10
        }


    background: Rectangle {
        color: "transparent"
        border.color: "#d9dbe0"
        radius: 8
    }

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            color: "#d9dbe0"
            height: 1
            Layout.fillWidth: true
            Layout.bottomMargin: 5
        }

        RowLayout {
            spacing: 16

            MyToggleButton {
                id: trackerOvlToggle
                text: "顯示追蹤器電池電量"
                Layout.preferredWidth: 250
                onCheckedChanged: {
                    UtilitiesTabController.setTrackerOvlEnabled(this.checked, false)
                }
            }
        }

    }

    Component.onCompleted: {
            trackerOvlToggle.checked = UtilitiesTabController.trackerOvlEnabled
    }

    Connections {
        target: UtilitiesTabController
        onTrackerOvlEnabledChanged:{
            trackerOvlToggle.checked = UtilitiesTabController.trackerOvlEnabled
        }

    }
}

