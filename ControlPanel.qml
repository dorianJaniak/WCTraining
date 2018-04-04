import QtQuick 2.0

Rectangle {
    id: controlPanel
    color: startedAnimation ? "gray" : "lightgreen"

    property int btnsCount: 6
    readonly property int btnWidth: width / btnsCount
    property bool startedAnimation: false

    signal startTest(int number)
    signal animationEnd();

   // onAnimationEnd: startedAnimation = false;

    Row {
        anchors.fill: parent
        Repeater {
            model: btnsCount

            Rectangle {
                color: Qt.rgba(0.8, 0.7, 0.7, 0.5);
                radius: 10
                width: controlPanel.btnWidth
                height: controlPanel.height
                border.color: Qt.rgba(0.8, 0.4, 0.4, 0.5);
                border.width: 2

                Text {
                    text: "" + index
                    anchors.centerIn: parent
                }

                MouseArea {
                    enabled: !controlPanel.startedAnimation
                    anchors.fill: parent
                    onClicked: {
                        startTest(index)
                 //       controlPanel.startedAnimation = true;
                    }
                }
            }
        }
    }
}

