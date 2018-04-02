import QtQuick 2.0

Item {
    id: scenarios
    property var target: undefined

    function runAnimation(num) {
        test01.start()
    }

    signal animationEnd();

    Item {
        id: points
        readonly property point pissuar: Qt.point(11 * scene.width / 12 - actor.width / 2,
                                                  5 * scene.height / 6 - actor.height / 2);
        readonly property point atThrone: Qt.point(scene.width / 12 - actor.width / 2,
                                                   scene.height / 6  - actor.height / 2);
        readonly property point closeToThrone: Qt.point(scene.width / 6 - actor.width / 2,
                                                        scene.height / 6  - actor.height / 2);
        readonly property point inFrontOfDoors: Qt.point(scene.width / 2 - actor.width / 2,
                                                         scene.height / 6  - actor.height / 2);
        readonly property point outside: Qt.point(2 * scene.width / 3 - actor.width / 2,
                                                  3 * scene.height / 2  - actor.height / 2);
        readonly property point inside: Qt.point(2 * scene.width / 3 - actor.width / 2,
                                                 5 * scene.height / 6  - actor.height / 2);
        readonly property point inPlaceOfDoor: Qt.point(scene.width / 3 - actor.width / 2,
                                                        scene.height / 6 - actor.height / 2);
    }

    SequentialAnimation {
        id: test01

        ScriptAction {
            script: {
                target.x = points.outside.x;
                target.y = points.outside.y;
            }
        }

        PathAnimation {
            target: scenarios.target
            duration: 2000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                id: patyczka
                PathLine { x: points.outside.x; y: points.outside.y }
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.pissuar.x; y: points.pissuar.y }
            }
        }
        PauseAnimation {
            duration: 1000
        }
        PathAnimation {
            target: scenarios.target
            duration: 4000
            easing.type: Easing.Linear
            path: Path {
                PathLine { x: points.inFrontOfDoors.x; y: points.inFrontOfDoors.y }
                PathLine { x: points.atThrone.x; y: points.atThrone.y }
                PathLine { x: points.closeToThrone.x; y: points.closeToThrone.y }
                PathLine { x: points.inPlaceOfDoor.x; y: points.inPlaceOfDoor.y }
            }
        }
    }
}

