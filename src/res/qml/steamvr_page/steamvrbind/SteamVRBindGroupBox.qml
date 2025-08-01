import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

GroupBox {
    id: steamVRBindGroupBox
    Layout.fillWidth: true

    label:
        MyText {
        leftPadding: 10
        text: "按鍵綁定："
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
                id: steamvrBindingToggle
                text: "啟用個別應用程式設定"
                Layout.preferredWidth: 250
                onCheckedChanged: {
                    SteamVRTabController.setPerAppBindEnabled(this.checked, false)
                    if(!steamvrBindingToggle.checked){
                        appSelect.enabled = false;
                        setDefaultBtn.enabled = false;
                        setBinding.enabled = false;
                    }else{
                        appSelect.enabled = true;
                        setDefaultBtn.enabled = true;
                        setBinding.enabled = true;
                    }
                }
            }
            MyText {
                Layout.preferredWidth: 0
                text: " "
            }

            MyText {
                text: "應用程式："
                Layout.preferredWidth: 150
                horizontalAlignment: Text.AlignRight
                Layout.rightMargin: 2
            }
            MyTextField {
                id: appSelect
                Layout.fillWidth: true
                text: "steam.overlay.1009850"
                keyBoardUID: 201
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                horizontalAlignment: Text.AlignHCenter
                function onInputEvent(input) {
                    this.text = input
                }
            }
            MyPushButton {
                id: bindingsButton
                activationSoundEnabled: false
                text: "開啟按鍵綁定"
                Layout.preferredWidth: 180
                onClicked: {
                     SteamVRTabController.launchBindingUI()
                }
            }
        }
        RowLayout {
            spacing: 16
            MyText {
                text: "儲存所選應用程式的目前綁定："
                Layout.preferredWidth: 500
                horizontalAlignment: Text.AlignLeft
                Layout.rightMargin: 2
            }
            MyPushButton {
                    id: setBinding
                    text:"用於目前遊戲"
                    onClicked: {
                        SteamVRTabController.setBindingQMLWrapper(appSelect.text)
                    }
            }
            MyText {
                Layout.preferredWidth: 50
                text: " "
            }
            MyPushButton {
                    id: setDefaultBtn
                    text:"設為預設"
                    onClicked: {
                        SteamVRTabController.setBindingQMLWrapper(appSelect.text,true)
                    }
            }
        }

    }

    Component.onCompleted: {
            steamvrBindingToggle.checked = SteamVRTabController.perAppBindEnabled
        if(!steamvrBindingToggle.checked){
            appSelect.enabled = false;
            setDefaultBtn.enabled = false;
            setBinding.enabled = false;
        }else{
            appSelect.enabled = true;
            setDefaultBtn.enabled = true;
            setBinding.enabled = true;
        }
    }

    Connections {
        target: SteamVRTabController
        onPerformanceGraphChanged:{
            steamvrBindingToggle.checked = SteamVRTabController.perAppBindEnabled
        }

    }
}
