import QtQuick 2.9
import QtQuick.Controls 2.2
import QtMultimedia 5.0

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
       text: "this is a test. And this is another. This is a third one. "
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

       /// does not work

//    SoundEffect {
//            id: playSound
//            muted: false
//            source: "file:///home/kuba/Downloads/wwwwww.wav"
//        }
//        MouseArea {
//            id: playArea
//            anchors.fill: parent
//            onPressed: { playSound.play() }
//        }

        /// works

//        Audio {
//            autoLoad: true
//            autoPlay: true

//            source: "file:///home/kuba/Downloads/wwwwww.wav"
//            muted: false
//            volume: 0.5
//        }

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
