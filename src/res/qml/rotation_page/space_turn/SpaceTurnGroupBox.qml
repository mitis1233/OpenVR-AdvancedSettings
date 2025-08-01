import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import ovras.advsettings 1.0
import "../../common"

GroupBox {
    id: spaceTurnGroupBox
    Layout.fillWidth: true

    label: MyText {
        leftPadding: 10
        text: "空間轉向 (用於手動重定向行走)"
        bottomPadding: -12
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
            Layout.bottomMargin: 3
        }

        RowLayout {
            Layout.fillWidth: true

            MyToggleButton {
                id: turnBindLeft
                text: "左手"
                onCheckedChanged: {
                    MoveCenterTabController.turnBindLeft = this.checked
                }
            }

            MyToggleButton {
                id: turnBindRight
                text: "右手"
                onCheckedChanged: {
                    MoveCenterTabController.turnBindRight = this.checked
                }
            }

            Item {
                Layout.fillWidth: true
            }

            MyText {
                text: "舒適模式："
                horizontalAlignment: Text.AlignRight
                Layout.rightMargin: 10
            }

            MySlider {
                id: turnComfortSlider
                from: 0
                to: 10
                stepSize: 1
                value: 0
                Layout.preferredWidth: 180
                Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
                onValueChanged: {
                    turnComfortText.text = turnComfortSlider.value
                    MoveCenterTabController.turnComfortFactor = turnComfortSlider.value
                }
            }

            MyText {
                id: turnComfortText
                text: "0"
                horizontalAlignment: Text.AlignRight
                Layout.preferredWidth: 30
                Layout.rightMargin: 10
            }

            MyToggleButton {
                id: turnBounds
                text: "強制邊界"
                onCheckedChanged: {
                    MoveCenterTabController.turnBounds = this.checked
                }
            }
        }
    }

    Component.onCompleted: {
        turnBindLeft.checked = MoveCenterTabController.turnBindLeft
        turnBindRight.checked = MoveCenterTabController.turnBindRight
        turnComfortSlider.value = MoveCenterTabController.turnComfortFactor
        turnBounds.checked = MoveCenterTabController.turnBounds
    }

    Connections {
        target: MoveCenterTabController

        onTurnBindLeftChanged: {
            turnBindLeft.checked = MoveCenterTabController.turnBindLeft
        }
        onTurnBindRightChanged: {
            turnBindRight.checked = MoveCenterTabController.turnBindRight
        }
        onTurnComfortFactorChanged: {
            turnComfortSlider.value = MoveCenterTabController.turnComfortFactor
        }
        onTurnBoundsChanged: {
            turnBounds.checked = MoveCenterTabController.turnBounds
        }
    }
}
