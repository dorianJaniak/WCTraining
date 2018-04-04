import QtQuick 2.1

Rectangle {
    id: scene
    visible: true
    width: 300
    height: 300

    function startTest(num) {
        actorMovementScenarios.runAnimation(num);
    }

    signal animationEnd();

    Item {
        id: constants
        readonly property int wallThickness: 5
        readonly property string wallColor: "black"
        readonly property int floorTileSize: 20
        readonly property real floorTileAngle: 45
        readonly property int actorSize: 40
        readonly property int doorsLength: 80
        readonly property int cabineSize: 80
    }

    StaticScene {
        id: staticScene
        anchors.fill: parent
    }

    Rectangle {
        id: doors

        property real angle: 0

        Behavior on angle {
            animation: NumberAnimation {
                duration: 1000
            }
        }

        state: "opened"
        x: constants.cabineSize + constants.wallThickness
        y: constants.cabineSize + constants.wallThickness
        width: constants.doorsLength
        height: constants.wallThickness
        color: "blue"

        transform: Rotation {
            id: doorsRotation
            angle: doors.angle
        }

        states: [
            State { name: "opened"; PropertyChanges { target: doors; angle: 0 } },
            State { name: "closed"; PropertyChanges { target: doors; angle: -90 } }
        ]
    }

    ActorMovementScenarios {
        id: actorMovementScenarios
        target: actor
        onAnimationEnd: parent.animationEnd();
    }

    Sensor {
        name: "pissoir"
        x: parent.width - constants.wallThickness
        y: 5 * scene.height / 6
        actors: [actor].concat(staticScene.verticalWalls)
        turnOnIt: Backend.pissoirDrain
        onTurnOnItChanged: console.log("pissoirDrain:", Backend.pissoirDrain)
    }

    Sensor {
        name: "toilet"
        x: constants.wallThickness
        y: scene.height / 6
        actors: [actor].concat(staticScene.verticalWalls).concat(doors)
        direction: "right"
        turnOnIt: Backend.toiletDrain
        onTurnOnItChanged: console.log("toiletDrain:", Backend.toiletDrain)
    }

    Sensor {
        name: "light"
        x: 2 * scene.width / 3
        y: constants.wallThickness
        actors: [actor].concat(staticScene.horizontalWalls).concat(doors)
        direction: "down"
        turnOnIt: Backend.lightOn
        onTurnOnItChanged: console.log("lightOn:", Backend.lightOn)
    }

    Actor {
        id: actor
        width: constants.actorSize
        height: constants.actorSize
    }
}
