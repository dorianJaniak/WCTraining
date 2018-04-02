import QtQuick 2.0

Item {

    property string name: ""
    property string direction: "left"; //left, right, down, up
    property int length: 100
    property int thickness: 3

    property int turnOnIt: 0

    property var actors: []



    function detectActor() {
        var centerX = x + 0.5 * width;
        var centerY = y + 0.5 * height;

        var measuredDistance = 600;

        actors.forEach(
            function measure(value, index) {
                switch (direction) {
                case "left":
                    var distance = Math.max(0, x - (value.x + value.width));
                    var inRange = (centerY < value.y + value.height && centerY > value.y && distance > 0);
                    break;
                case "right":
                    var distance = Math.max(0, value.x - x);
                    var inRange = (centerY < value.y + value.height && centerY > value.y && distance > 0);
                    break;
                case "up":
                    var distance = Math.max(0, y - (value.y + value.height));
                    var inRange = (centerX < value.x + value.width && centerX > value.x && distance > 0);
                    break;
                case "down":
                    var distance = Math.max(0, value.y - y);
                    var inRange = (centerX < value.x + value.width && centerX > value.x && distance > 0);
                    break;
                }

                measuredDistance = Math.min(measuredDistance, inRange ? distance : measuredDistance);
            }
        );

        length = measuredDistance;
        Backend.measurement(name, length);
    }

    Timer {
        interval: 100
        repeat: true
        onTriggered: detectActor()

        Component.onCompleted: start()
    }

    Rectangle {
        color: parent.turnOnIt ? "mediumturquoise" : "navajowhite"
        width: (direction === "left" || direction === "right") ? length : thickness
        height: (direction === "up" || direction === "down") ? length : thickness
        x: (direction === "left") ? -length : 0
        y: (direction === "up") ? -length : 0
    }
}

