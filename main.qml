import QtQuick 2.9
import QtQuick.Controls 2.2

import custom.tts 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")
    
    TTS {
        id: tts
    }
    
    TextField {
       text: tts.userName
       placeholderText: qsTr("User name")
       anchors.centerIn: parent
       
//       onTextChanged: tts.userName = text
//       onTextChanged: {console.log("text change!")}
//       onTextChanged: tts.echo()       
       Keys.onPressed: {
              if (event.key == Qt.Key_Return) {
                  tts.userName = text
//                  tts.echo(text)
                  tts.play(text)
              }
          }       
    }
    Button{
        x: 426
        y: 220
        text: "stop"
       onPressed: {
           tts.stop();
       }
    }
}
