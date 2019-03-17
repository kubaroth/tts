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

    TextField {
        width: 200
        height: 40
        text: "this is a test. And this is another. This is a third one. "
        horizontalAlignment: Text.AlignLeft
        anchors.centerIn: parent

//       onTextChanged: tts.userName = text
//       onTextChanged: {console.log("text change!")}
//       onTextChanged: tts.echo()
       Keys.onPressed: {
              if (event.key == Qt.Key_Return) {
                  tts.userName = text
                  tts.echo(text)
                  tts.play(text)
              }
       }


    }

TextEdit {
    id: textEdit
    width: 200
    height: 127
    text: qsTr("this is a TextEdit field")
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.top: parent.top
    anchors.topMargin: 0
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    cursorVisible: false
    font.pixelSize: 10

    Keys.onPressed: {
           if (event.key == Qt.Key_Return) {
               tts.userName = text
               tts.echo(text)
               tts.play(text)
           }
}
}


//    Button{
//        x: 426
//        y: 220
//        text: "stop"
//        onPressed: {
//            tts.stop();
//        }
//    }
}















/*##^## Designer {
    D{i:3;anchors_x:220;anchors_y:57}
}
 ##^##*/
