import QtQuick 2.0

Item {

    readonly property var verticalWalls: [wallRight, wallLeft]
    readonly property var horizontalWalls: [wallDownLeft, wallDownRight, wallUp, wallInternal]

    Rectangle {
        id: wallUp
        x: 0
        y: 0
        width: parent.width
        height: constants.wallThickness
        color: constants.wallColor
    }
    Rectangle {
        id: wallRight
        x: parent.width - constants.wallThickness
        y: constants.wallThickness
        width: constants.wallThickness
        height: parent.height - 2 * constants.wallThickness
        color: constants.wallColor
    }
    Rectangle {
        id: wallDownRight
        x: 0.825 * parent.width
        y: parent.height - constants.wallThickness
        width: parent.width - x
        height: constants.wallThickness
        color: constants.wallColor
    }
    Rectangle {
        id: wallDownLeft
        x: 0
        y: parent.height - constants.wallThickness
        width: 0.575 * parent.width
        height: constants.wallThickness
        color: constants.wallColor
    }
    Rectangle {
        id: wallLeft
        x: 0
        y: constants.wallThickness
        width: constants.wallThickness
        height: parent.height - 2 * constants.wallThickness
        color: constants.wallColor
    }
    Rectangle {
        id: wallInternal
        x: constants.wallThickness
        y: constants.cabineSize + constants.wallThickness
        width: constants.cabineSize
        height: constants.wallThickness
        color: constants.wallColor
    }
}

