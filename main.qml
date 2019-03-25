import QtQuick 2.9
import QtQuick.Controls 2.2
//import QtMultimedia 5.0

//import custom.tts 1.0
//import QtQuick.Window 2.10

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 300
    height: 480
    title: qsTr("Tabs")

//    TTS {
//        id: tts
//    }


//     Button {
//            id: play
//            width: 60
//            height: 40
//            text: qsTr("Play")
//            flat: false
//            highlighted: false
//            anchors.left: textEdit.left
//            anchors.leftMargin: 0
//            //onPressed: {console.log("run play!")}
//            onPressed: tts.play(textEdit.text, rate.value)
//        }

        ScrollView {
            id: scrollview
            focusPolicy: Qt.ClickFocus
            width: applicationWindow.width
            height: applicationWindow.height
            //contentWidth: -1   // disables scroll
            function scrollToY(y) {
                scrollview.contentItem.contentY = y;
            }


        TextEdit {
            id: textEdit
            x: 0
            text: qsTr("The puquios are an old system of subterranean aqueducts near the city of Nazca, Peru. Out of 36 puquios, most are still functioning and even relied upon to bring fresh water into the arid desert. The puquios have never been fully mapped, nor have any been excavated.")
            selectionColor: "#800000"
            anchors.verticalCenterOffset: 60
            anchors.verticalCenter: parent.verticalCenter
            renderType: Text.NativeRendering
            width: applicationWindow.width
            cursorVisible: true
            wrapMode: TextEdit.Wrap
            font.pixelSize: 12
            onCursorPositionChanged: {
                scrollview.scrollToY(textEdit.y + textEdit.cursorRectangle.y);
            }

        }

        }



}

















































































