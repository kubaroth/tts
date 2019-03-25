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

    Flickable
    {
        id: flickable
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 40

        // place a TextArea inside the flickable, you can edit text
        // but you cannot select because click & move mouse flicks the view.
        TextArea.flickable: TextArea
        {
            id: textarea
            wrapMode: TextArea.Wrap
            font.pointSize: 12
            textMargin: 12

            // textFormat: TextEdit.RichText
            // can select but kills scrolling
            //selectByMouse: true
            text: qsTr("The puquios are an old system of subterranean aqueducts near the city of Nazca, Peru. Out of 36 puquios, most are still functioning and even relied upon to bring fresh water into the arid desert. The puquios have never been fully mapped, nor have any been excavated.")

            // try out links
            //onLinkActivated: Qt.openUrlExternally(link)
        }
        ScrollBar.vertical: ScrollBar { }
    }

        Button {
            id: play
            width: 60
            height: 40
            text: qsTr("Play")
            anchors.left: textarea.left
            anchors.leftMargin: 0
            //onPressed: {console.log("run play!")}
            onPressed: tts.play(textarea.text, rate.value)
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

