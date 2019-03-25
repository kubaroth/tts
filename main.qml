import QtQuick 2.9
import QtQuick.Controls 2.2
import QtMultimedia 5.0

import custom.tts 1.0
import QtQuick.Window 2.10

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 300
    height: 480
    title: qsTr("Tabs")

    TTS {
        id: tts
    }
    Row {
        id: row
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        TextEdit {
            id: textEdit
            text: qsTr("The puquios are an old system of subterranean aqueducts near the city of Nazca, Peru. Out of 36 puquios, most are still functioning and even relied upon to bring fresh water into the arid desert. The puquios have never been fully mapped, nor have any been excavated.")
            anchors.verticalCenter: parent.verticalCenter
            rightPadding: 10
            bottomPadding: 10
            leftPadding: 10
            topPadding: 10
            renderType: Text.NativeRendering
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 40
            width: parent.width
            cursorVisible: true
            wrapMode: TextEdit.Wrap
            font.pixelSize: 12

        }

        Button {
            id: play
            width: 60
            height: 40
            text: qsTr("Play")
            anchors.left: textEdit.left
            anchors.leftMargin: 0
            //onPressed: {console.log("run play!")}
            onPressed: tts.play(textEdit.text, rate.value)
        }

        Button {
            id: pause
            width: 60
            height: 40
            text: qsTr("Pause")
            anchors.left: play.right
            anchors.leftMargin: 0
            onPressed: {
                //console.log(rate.value)
                tts.pause();
            }
        }

        Button {
            id: stop
            width: 60
            height: 40
            text: qsTr("Stop")
            anchors.left: pause.right
            anchors.leftMargin: 0
            onPressed: {
                tts.stop();
            }
        }

        SpinBox {
            id: rate
            width: 120
            anchors.verticalCenter: stop.verticalCenter
            anchors.left: stop.right
            anchors.leftMargin: 0
            editable: true
            from: 70
            to: 120
            value: 90

        }

    }



}






























/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
