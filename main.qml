import QtQuick 2.9
import QtQuick.Controls 2.2
import QtMultimedia 5.0

import custom.tts 1.0

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")

    TTS {
        id: tts
    }

    TextEdit {
        id: textEdit
        width: 640
        height: 429
        text: qsTr("This is a text edit field")
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        wrapMode: TextEdit.Wrap
        cursorVisible: true
        font.pixelSize: 10

//        Keys.onPressed: {
//           if (event.key == Qt.Key_Return) {
//               tts.userName = text
//               tts.echo(text)
//               tts.play(text)
//           }
//        }
    }

    Button {
        id: play
        x: 8
        width: 60
        height: 40
        text: qsTr("Play")
        anchors.top: textEdit.bottom
        anchors.topMargin: 8
        //onPressed: {console.log("text change!")}
        onPressed: tts.play(textEdit.text)
    }

    Button {
        id: pause
        x: 74
        y: -8
        width: 60
        height: 40
        text: qsTr("Pause")
        anchors.top: textEdit.bottom
        anchors.topMargin: 8
        onPressed: {
            tts.pause();
        }
    }

    Button {
        id: stop
        x: 140
        y: 0
        width: 60
        height: 40
        text: qsTr("Stop")
        anchors.top: textEdit.bottom
        anchors.topMargin: 8
        onPressed: {
            tts.stop();
        }
    }
}



/*##^## Designer {
    D{i:6;anchors_y:432}D{i:7;anchors_y:432}D{i:8;anchors_y:432}
}
 ##^##*/
