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
    }

    StaticScene {
        id: staticScene
        anchors.fill: parent
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
        name: "throne"
        x: constants.wallThickness
        y: scene.height / 6
        actors: [actor].concat(staticScene.verticalWalls)
        direction: "right"
        turnOnIt: Backend.throneDrain
        onTurnOnItChanged: console.log("throneDrain:", Backend.throneDrain)
    }

    Sensor {
        name: "light"
        x: 2 * scene.width / 3
        y: constants.wallThickness
        actors: [actor].concat(staticScene.horizontalWalls)
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
