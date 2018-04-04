import QtQuick 2.0

Item {
    id: scenarios
    property var target: undefined

    function runAnimation(num) {
        switch(num) {
        case 0: test01.start(); break;
        case 1: test02.start(); break;
        case 2: test03.start(); break;
        case 3: test04.start(); break;
        }
    }

    signal animationEnd();

    Item {
        id: points
        readonly property point pissuar: Qt.point(11 * scene.width / 12 - actor.width / 2,
                                                  5 * scene.height / 6 - actor.height / 2);
        readonly property point atToilet: Qt.point(scene.width / 6 - actor.width / 2,
                                                   scene.height / 6  - actor.height / 2);
        readonly property point closeToToilet: Qt.point(scene.width / 6 - actor.width / 2,
                                                        scene.height / 6  - actor.height / 2);
        readonly property point inFrontOfDoors: Qt.point(scene.width / 2 - actor.width / 2,
                                                         scene.height / 6  - actor.height / 2);
        readonly property point inFrontOfDoorsFar: Qt.point(3 * scene.width / 4 - actor.width / 2,
                                                            inFrontOfDoors.y);
        readonly property point outside: Qt.point(2 * scene.width / 3 - actor.width / 2,
                                                  3 * scene.height / 2  - actor.height / 2);
        readonly property point inside: Qt.point(2 * scene.width / 3 - actor.width / 2,
                                                 5 * scene.height / 6  - actor.height / 2);
        readonly property point inPlaceOfDoor: Qt.point(scene.width / 3 - actor.width / 2,
                                                        scene.height / 6 - actor.height / 2);
        readonly property point atWashbasin: Qt.point(atToilet.x, pissuar.y);
    }

    SequentialAnimation {
        id: test01

        ScriptAction {
            script: {
                target.x = points.outside.x;
                target.y = points.outside.y;
                doors.state = "closed"
            }
        }

        PathAnimation {
            target: scenarios.target
            duration: 2000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.outside.x; y: points.outside.y }
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.inFrontOfDoors.x; y: points.inFrontOfDoors.y }
            }
        }
        PauseAnimation {
            duration: 2000
        }
        PathAnimation {
            target: scenarios.target
            duration: 3000
            easing.type: Easing.Linear
            path: Path {
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.outside.x; y: points.outside.y }
            }
        }
    }

    SequentialAnimation {
        id: test02

        ScriptAction {
            script: {
                target.x = points.outside.x;
                target.y = points.outside.y;
                doors.state = "closed"
            }
        }
        PauseAnimation { duration: 1000 }
        PathAnimation {
            target: scenarios.target
            duration: 2000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.outside.x; y: points.outside.y }
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.inFrontOfDoorsFar.x; y: points.inFrontOfDoorsFar.y }
            }
        }
        ScriptAction { script: { doors.state = "opened"; } }
        PauseAnimation {  duration: 1000  }

        PathAnimation {     //go to Toilet
            target: scenarios.target
            duration: 1000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.atToilet.x; y: points.atToilet.y }
            }
        }
        ScriptAction { script: { doors.state = "closed"; } }
        PauseAnimation { duration: 6000 }

        ScriptAction { script: { doors.state = "opened"; } }
        PathAnimation {
            target: scenarios.target
            duration: 1500
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.inFrontOfDoorsFar.x; y: points.inFrontOfDoorsFar.y }
            }
        }

        ScriptAction { script: { doors.state = "closed"; } }
        PathAnimation {
            target: scenarios.target
            duration: 3000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.atWashbasin.x; y: points.atWashbasin.y }
            }
        }
        PauseAnimation { duration: 2000 }
        PathAnimation {
            target: scenarios.target
            duration: 2000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.outside.x; y: points.outside.y }
            }
        }
    }

    SequentialAnimation {
        id: test03
        ScriptAction {
            script: {
                target.x = points.outside.x;
                target.y = points.outside.y;
                doors.state = "closed"
            }
        }
        PauseAnimation { duration: 1000 }
        PathAnimation {
            target: scenarios.target
            duration: 2000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.outside.x; y: points.outside.y }
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.pissuar.x; y: points.pissuar.y }
            }
        }
        PauseAnimation { duration: 3000 }
        PathAnimation {
            target: scenarios.target
            duration: 2000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.atWashbasin.x; y: points.atWashbasin.y }
            }
        }
        PauseAnimation { duration: 2000 }
        PathAnimation {
            target: scenarios.target
            duration: 2000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.outside.x; y: points.outside.y }
            }
        }
    }

    SequentialAnimation {
        id: test04
        ScriptAction {
            script: {
                target.x = points.outside.x;
                target.y = points.outside.y;
                doors.state = "closed"
            }
        }
        PauseAnimation { duration: 1000 }
        PathAnimation {
            target: scenarios.target
            duration: 3000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.outside.x; y: points.outside.y }
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.atWashbasin.x; y: points.atWashbasin.y }
            }
        }
        PauseAnimation { duration: 2000 }
        PathAnimation {
            target: scenarios.target
            duration: 2000
            easing.type: Easing.Linear
            orientationEntryDuration: 0
            path: Path {
                PathLine { x: points.inside.x; y: points.inside.y }
                PathLine { x: points.outside.x; y: points.outside.y }
            }
        }
    }
}

