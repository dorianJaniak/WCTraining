import QtQuick 2.1

Rectangle {
    id: window
    visible: true
    width: 300
    height: 350

    Scene {
        id: scene
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 300
        onAnimationEnd: controlPanel.animationEnd()
    }

    ControlPanel {
        id: controlPanel
        anchors {
            top: scene.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }

        onStartTest: scene.startTest(number)
    }

}
