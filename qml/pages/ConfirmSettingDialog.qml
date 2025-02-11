import QtQuick 2.0
import Sailfish.Silica 1.0

import cz.chrastecky.chatgpt 1.0

Dialog {
    property var messages: []

    property alias intFieldVisible: intField.visible
    property alias intFieldDescription: intField.label
    property alias intValue: intField.text

    property alias sliderVisible: sliderField.visible
    property alias sliderMax: sliderField.maximumValue
    property alias sliderMin: sliderField.minimumValue
    property alias sliderStep: sliderField.stepSize
    property string sliderDescription: ''
    property alias sliderValue: sliderField.value

    property alias stringFieldVisible: stringField.visible
    property alias stringFieldDescription: stringField.label
    property alias stringFieldValue: stringField.text

    canAccept: (intFieldVisible ? intValue.length > 0 : true)

    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            DialogHeader {
                //: Dialog accept text
                acceptText: qsTr("Confirm")
            }

            Repeater {
                model: messages
                delegate: Label {
                    property var item: messages[index]

                    x: Theme.horizontalPageMargin
                    textFormat: Text.RichText;
                    width: parent.width - Theme.horizontalPageMargin * 2
                    text: item
                    color: Theme.primaryColor
                    wrapMode: Text.WordWrap
                }
            }

            TextField {
                id: intField
                inputMethodHints: Qt.ImhDigitsOnly
                visible: false
            }

            TextField {
                id: stringField
                visible: false
            }

            Slider {
                id: sliderField
                visible: false
                width: parent.width
                label: sliderDescription ? sliderDescription + ' (' + String(value) + ')' : String(value)
            }
        }
    }

    Component.onCompleted: {
        logger.debug("Navigated to ConfirmSettingDialog.qml");
    }
}
