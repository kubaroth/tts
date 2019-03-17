import QtQuick 2.9
import QtQuick.Controls 2.2
import QtMultimedia 5.0

import custom.tts 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 200
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
            font.pixelSize: 10
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
            //onPressed: {console.log("text change!")}
            onPressed: tts.play(textEdit.text)
        }

        Button {
            id: pause
            width: 60
            height: 40
            text: qsTr("Pause")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 60
            onPressed: {
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
            anchors.left: parent.left
            anchors.leftMargin: 120
            onPressed: {
                tts.stop();
            }
        }

        Column {
            id: column
            width: 400
            height: 50
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }
    }
}


/*##^## Designer {
    D{i:21;anchors_height:40;anchors_width:60}D{i:22;anchors_height:40}
}
 ##^##*/
