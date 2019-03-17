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
            text: qsTr("This is a text edit field. This is a text edit field. This is a text edit field. ")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
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
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
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
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
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
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
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
            value: 100

        }

    }



}













